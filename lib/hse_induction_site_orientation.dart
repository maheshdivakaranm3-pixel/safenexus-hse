import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HseInductionSiteOrientationPage extends StatefulWidget {
  const HseInductionSiteOrientationPage({super.key});

  @override
  State<HseInductionSiteOrientationPage> createState() =>
      _HseInductionSiteOrientationPageState();
}

class _HseInductionSiteOrientationPageState
    extends State<HseInductionSiteOrientationPage> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const String storageKey =
      'safenexus_hse_hse_induction_site_orientation';

  List<Map<String, dynamic>> records = [];
  String searchText = '';
  String statusFilter = 'All';

  final List<String> statuses = const [
    'Scheduled',
    'In Progress',
    'Completed',
    'Expired',
    'Refresher Required',
    'Cancelled',
  ];

  final List<String> inductionTypes = const [
    'Initial Site Induction',
    'Project HSE Induction',
    'Visitor Orientation',
    'Contractor Induction',
    'Subcontractor Induction',
    'Refresher Induction',
    'Job-Specific Orientation',
    'Emergency Orientation',
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
      'inductionType': get(8),
      'scheduledDate': get(9),
      'completionDate': get(10),
      'expiryDate': get(11),
      'trainer': get(12),
      'orientation': get(13),
      'topics': get(14),
      'acknowledged': get(15),
      'assessment': get(16),
      'score': get(17),
      'status': get(18).isEmpty ? 'Scheduled' : get(18),
      'remarks': get(19),
      'createdAt': get(20),
      'updatedAt': get(21),
    };
  }

  String _safe(Object? value) =>
      (value?.toString() ?? '').replaceAll('|', '/').trim();

  Future<void> _saveRecords() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = records.map((r) {
      final keys = [
        'id',
        'workerId',
        'workerName',
        'company',
        'project',
        'site',
        'department',
        'jobRole',
        'inductionType',
        'scheduledDate',
        'completionDate',
        'expiryDate',
        'trainer',
        'orientation',
        'topics',
        'acknowledged',
        'assessment',
        'score',
        'status',
        'remarks',
        'createdAt',
        'updatedAt',
      ];
      return keys.map((key) => _safe(r[key])).join('|');
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
      return matchesSearch && matchesStatus;
    }).toList();
  }

  int _count(String status) =>
      records.where((r) => r['status'] == status).length;

  int get _overdueCount =>
      records.where(_isOverdue).length;

  bool _isOverdue(Map<String, dynamic> record) {
    final expiry =
        DateTime.tryParse(record['expiryDate']?.toString() ?? '');
    if (expiry == null) return false;
    return expiry.isBefore(DateTime.now()) &&
        record['status'] != 'Cancelled';
  }

  Future<void> _openForm({Map<String, dynamic>? existing}) async {
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _InductionFormSheet(
        existing: existing,
        statuses: statuses,
        inductionTypes: inductionTypes,
      ),
    );

    if (result == null) return;

    final now = DateTime.now().toIso8601String();

    if (existing == null) {
      result['id'] = 'IND-${DateTime.now().millisecondsSinceEpoch}';
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
              : 'Induction Details',
        ),
        content: SizedBox(
          width: 500,
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
        title: const Text('HSE Induction & Site Orientation'),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            tooltip: 'Add Induction',
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
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: 'Search worker, ID, company, site...',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) =>
                        setState(() => searchText = value),
                  ),
                ),
                const SizedBox(width: 8),
                DropdownButton<String>(
                  value: statusFilter,
                  items: ['All', ...statuses]
                      .map(
                        (status) => DropdownMenuItem(
                          value: status,
                          child: Text(status),
                        ),
                      )
                      .toList(),
                  onChanged: (value) => setState(
                    () => statusFilter = value ?? 'All',
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: filteredRecords.isEmpty
                ? const Center(
                    child: Text('No induction records found.'),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: filteredRecords.length,
                    itemBuilder: (_, index) {
                      final record = filteredRecords[index];
                      final overdue = _isOverdue(record);
                      return Card(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: ListTile(
                          leading: const CircleAvatar(
                            backgroundColor: primaryGreen,
                            child: Icon(
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
                            '${record['workerId']} • ${record['company']}\n'
                            '${record['inductionType']} • '
                            '${record['status']}'
                            '${overdue ? ' • OVERDUE' : ''}',
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
        label: const Text('Add Induction'),
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
          _stat('COMPLETED', _count('Completed'), Icons.verified),
          _stat('ACTIVE', _count('In Progress'), Icons.play_circle),
          _stat(
            'REFRESHER',
            _count('Refresher Required'),
            Icons.refresh,
          ),
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

class _InductionFormSheet extends StatefulWidget {
  final Map<String, dynamic>? existing;
  final List<String> statuses;
  final List<String> inductionTypes;

  const _InductionFormSheet({
    required this.existing,
    required this.statuses,
    required this.inductionTypes,
  });

  @override
  State<_InductionFormSheet> createState() =>
      _InductionFormSheetState();
}

class _InductionFormSheetState extends State<_InductionFormSheet> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);

  final _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> controllers = {};

  String inductionType = 'Initial Site Induction';
  String status = 'Scheduled';
  String acknowledged = 'No';

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
      'scheduledDate',
      'completionDate',
      'expiryDate',
      'trainer',
      'orientation',
      'topics',
      'assessment',
      'score',
      'remarks',
    ];

    for (final field in fields) {
      controllers[field] = TextEditingController(
        text: widget.existing?[field]?.toString() ?? '',
      );
    }

    final existingType =
        widget.existing?['inductionType']?.toString();
    if (existingType != null &&
        widget.inductionTypes.contains(existingType)) {
      inductionType = existingType;
    }

    final existingStatus = widget.existing?['status']?.toString();
    if (existingStatus != null &&
        widget.statuses.contains(existingStatus)) {
      status = existingStatus;
    }

    acknowledged =
        widget.existing?['acknowledged']?.toString() ?? 'No';
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
        height: MediaQuery.of(context).size.height * 0.92,
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
                      'Induction & Site Orientation',
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
                    DropdownButtonFormField<String>(
                      initialValue: inductionType,
                      decoration: const InputDecoration(
                        labelText: 'Induction Type',
                        border: OutlineInputBorder(),
                      ),
                      items: widget.inductionTypes
                          .map(
                            (value) => DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            ),
                          )
                          .toList(),
                      onChanged: (value) => setState(
                        () => inductionType =
                            value ?? widget.inductionTypes.first,
                      ),
                    ),
                    const SizedBox(height: 10),
                    _field(
                      'scheduledDate',
                      'Scheduled Date (YYYY-MM-DD)',
                      validator: _required,
                    ),
                    _field(
                      'completionDate',
                      'Completion Date (YYYY-MM-DD)',
                    ),
                    _field(
                      'expiryDate',
                      'Expiry Date (YYYY-MM-DD)',
                    ),
                    _field(
                      'trainer',
                      'Induction Trainer / HSE Officer',
                    ),
                    _field(
                      'orientation',
                      'Site Orientation / Areas Covered',
                      maxLines: 2,
                    ),
                    _field(
                      'topics',
                      'Topics Covered: PPE, Emergency, PTW, Traffic, Welfare, Rules',
                      maxLines: 3,
                    ),
                    DropdownButtonFormField<String>(
                      initialValue: acknowledged,
                      decoration: const InputDecoration(
                        labelText: 'Worker Acknowledgement',
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
                        () => acknowledged = value ?? 'No',
                      ),
                    ),
                    const SizedBox(height: 10),
                    _field(
                      'assessment',
                      'Knowledge / Induction Assessment',
                    ),
                    _field('score', 'Assessment Score'),
                    DropdownButtonFormField<String>(
                      initialValue: status,
                      decoration: const InputDecoration(
                        labelText: 'Status',
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

  void _save() {
    if (!_formKey.currentState!.validate()) return;

    final data = <String, dynamic>{};
    for (final entry in controllers.entries) {
      data[entry.key] = entry.value.text.trim();
    }

    data['inductionType'] = inductionType;
    data['acknowledged'] = acknowledged;
    data['status'] = status;

    Navigator.pop(context, data);
  }
}
