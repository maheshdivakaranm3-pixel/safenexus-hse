import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SkillCompetencyMatrixPage extends StatefulWidget {
  const SkillCompetencyMatrixPage({super.key});

  @override
  State<SkillCompetencyMatrixPage> createState() =>
      _SkillCompetencyMatrixPageState();
}

class _SkillCompetencyMatrixPageState
    extends State<SkillCompetencyMatrixPage> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const String storageKey =
      'safenexus_hse_skill_competency_matrix';

  List<Map<String, dynamic>> records = [];
  String searchText = '';
  String statusFilter = 'All';
  String gapFilter = 'All';

  final List<String> statuses = const [
    'Not Assessed',
    'Gap Identified',
    'Training Required',
    'Assessment Pending',
    'Competent',
    'Competent with Conditions',
    'Authorized',
    'Expired',
    'Under Review',
    'Closed',
  ];

  final List<String> levels = const [
    'Awareness',
    'Basic',
    'Intermediate',
    'Advanced',
    'Expert',
  ];

  final List<String> gapOptions = const [
    'No Gap',
    'Minor Gap',
    'Major Gap',
    'Critical Gap',
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
      'skillCode': get(8),
      'skillName': get(9),
      'skillCategory': get(10),
      'requiredLevel': get(11),
      'achievedLevel': get(12),
      'assessmentReference': get(13),
      'assessmentDate': get(14),
      'assessor': get(15),
      'trainingReference': get(16),
      'authorizationReference': get(17),
      'gapLevel': get(18).isEmpty ? 'No Gap' : get(18),
      'gapDetails': get(19),
      'developmentAction': get(20),
      'targetDate': get(21),
      'validUntil': get(22),
      'status': get(23).isEmpty ? 'Not Assessed' : get(23),
      'verification': get(24),
      'verifiedBy': get(25),
      'verifiedDate': get(26),
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
      'skillCode',
      'skillName',
      'skillCategory',
      'requiredLevel',
      'achievedLevel',
      'assessmentReference',
      'assessmentDate',
      'assessor',
      'trainingReference',
      'authorizationReference',
      'gapLevel',
      'gapDetails',
      'developmentAction',
      'targetDate',
      'validUntil',
      'status',
      'verification',
      'verifiedBy',
      'verifiedDate',
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
      final matchesGap =
          gapFilter == 'All' || record['gapLevel'] == gapFilter;
      return matchesSearch && matchesStatus && matchesGap;
    }).toList();
  }

  int _count(String status) =>
      records.where((r) => r['status'] == status).length;

  int get _gapCount => records.where((r) =>
      r['gapLevel'] != 'No Gap' &&
      r['status'] != 'Closed').length;

  int get _overdueCount => records.where(_isOverdue).length;

  int get _expiringSoonCount =>
      records.where(_isExpiringSoon).length;

  bool _isOverdue(Map<String, dynamic> record) {
    final date =
        DateTime.tryParse(record['validUntil']?.toString() ?? '');
    if (date == null) return false;
    return date.isBefore(DateTime.now()) &&
        record['status'] != 'Closed' &&
        record['status'] != 'Expired';
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
      builder: (_) => _MatrixFormSheet(
        existing: existing,
        statuses: statuses,
        levels: levels,
        gapOptions: gapOptions,
      ),
    );
    if (result == null) return;

    final now = DateTime.now().toIso8601String();
    if (existing == null) {
      result['id'] = 'MTR-${DateTime.now().millisecondsSinceEpoch}';
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
          record['skillName']?.toString().isNotEmpty == true
              ? record['skillName'].toString()
              : 'Skill Matrix Details',
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
                  .map((e) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          '${_label(e.key)}: ${e.value}',
                          style: const TextStyle(fontSize: 13),
                        ),
                      ))
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
      (m) => ' ${m.group(1)}',
    );
    return spaced.isEmpty
        ? key
        : '${spaced[0].toUpperCase()}${spaced.substring(1)}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Skill / Competency Matrix'),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            tooltip: 'Add Matrix Record',
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
                        'Search worker, skill, role, assessor...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (v) =>
                      setState(() => searchText = v),
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
                            .map((v) => DropdownMenuItem(
                                  value: v,
                                  child: Text(v),
                                ))
                            .toList(),
                        onChanged: (v) => setState(
                          () => statusFilter = v ?? 'All',
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        initialValue: gapFilter,
                        decoration: const InputDecoration(
                          labelText: 'Gap Level',
                          border: OutlineInputBorder(),
                        ),
                        items: ['All', ...gapOptions]
                            .map((v) => DropdownMenuItem(
                                  value: v,
                                  child: Text(v),
                                ))
                            .toList(),
                        onChanged: (v) => setState(
                          () => gapFilter = v ?? 'All',
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
                    child: Text('No competency matrix records found.'),
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
                              Icons.grid_view,
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
                            '${record['skillName']} • '
                            '${record['achievedLevel']}\n'
                            '${record['status']} • '
                            '${record['gapLevel']}'
                            '${overdue ? ' • OVERDUE' : ''}'
                            '${expiring ? ' • EXPIRING ≤30 DAYS' : ''}',
                          ),
                          isThreeLine: true,
                          onTap: () => _showDetails(record),
                          trailing: PopupMenuButton<String>(
                            onSelected: (v) {
                              if (v == 'edit') {
                                _openForm(existing: record);
                              } else if (v == 'delete') {
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
        label: const Text('Add Matrix Record'),
      ),
    );
  }

  Widget _dashboard() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          _stat('TOTAL', records.length, Icons.grid_view),
          _stat('COMPETENT', _count('Competent'), Icons.verified),
          _stat('AUTHORIZED', _count('Authorized'), Icons.badge),
          _stat('GAPS', _gapCount, Icons.warning_amber),
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

class _MatrixFormSheet extends StatefulWidget {
  final Map<String, dynamic>? existing;
  final List<String> statuses;
  final List<String> levels;
  final List<String> gapOptions;

  const _MatrixFormSheet({
    required this.existing,
    required this.statuses,
    required this.levels,
    required this.gapOptions,
  });

  @override
  State<_MatrixFormSheet> createState() => _MatrixFormSheetState();
}

class _MatrixFormSheetState extends State<_MatrixFormSheet> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);

  final _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> controllers = {};

  String requiredLevel = 'Intermediate';
  String achievedLevel = 'Awareness';
  String gapLevel = 'No Gap';
  String status = 'Not Assessed';

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
      'skillCode',
      'skillName',
      'skillCategory',
      'assessmentReference',
      'assessmentDate',
      'assessor',
      'trainingReference',
      'authorizationReference',
      'gapDetails',
      'developmentAction',
      'targetDate',
      'validUntil',
      'verification',
      'verifiedBy',
      'verifiedDate',
      'remarks',
    ];

    for (final field in fields) {
      controllers[field] = TextEditingController(
        text: widget.existing?[field]?.toString() ?? '',
      );
    }

    final req = widget.existing?['requiredLevel']?.toString();
    if (req != null && widget.levels.contains(req)) {
      requiredLevel = req;
    }

    final achieved = widget.existing?['achievedLevel']?.toString();
    if (achieved != null && widget.levels.contains(achieved)) {
      achievedLevel = achieved;
    }

    final gap = widget.existing?['gapLevel']?.toString();
    if (gap != null && widget.gapOptions.contains(gap)) {
      gapLevel = gap;
    }

    final existingStatus = widget.existing?['status']?.toString();
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
                    Icon(Icons.grid_view, color: Colors.white),
                    SizedBox(width: 10),
                    Text(
                      'Skill / Competency Matrix Record',
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
                    _section('SKILL REQUIREMENT'),
                    _field('skillCode', 'Skill / Competency Code'),
                    _field(
                      'skillName',
                      'Skill / Competency Name',
                      validator: _required,
                    ),
                    _field('skillCategory', 'Skill Category'),
                    DropdownButtonFormField<String>(
                      initialValue: requiredLevel,
                      decoration: const InputDecoration(
                        labelText: 'Required Level',
                        border: OutlineInputBorder(),
                      ),
                      items: widget.levels
                          .map((v) => DropdownMenuItem(
                                value: v,
                                child: Text(v),
                              ))
                          .toList(),
                      onChanged: (v) => setState(
                        () => requiredLevel =
                            v ?? widget.levels.first,
                      ),
                    ),
                    const SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      initialValue: achievedLevel,
                      decoration: const InputDecoration(
                        labelText: 'Achieved Level',
                        border: OutlineInputBorder(),
                      ),
                      items: widget.levels
                          .map((v) => DropdownMenuItem(
                                value: v,
                                child: Text(v),
                              ))
                          .toList(),
                      onChanged: (v) => setState(
                        () => achievedLevel =
                            v ?? widget.levels.first,
                      ),
                    ),
                    const SizedBox(height: 10),
                    _section('ASSESSMENT & EVIDENCE'),
                    _field(
                      'assessmentReference',
                      'Assessment Reference',
                    ),
                    _field(
                      'assessmentDate',
                      'Assessment Date (YYYY-MM-DD)',
                    ),
                    _field('assessor', 'Assessor / Evaluator'),
                    _field(
                      'trainingReference',
                      'Training / Qualification Reference',
                    ),
                    _field(
                      'authorizationReference',
                      'Authorization Reference',
                    ),
                    _section('COMPETENCY GAP & DEVELOPMENT'),
                    DropdownButtonFormField<String>(
                      initialValue: gapLevel,
                      decoration: const InputDecoration(
                        labelText: 'Competency Gap Level',
                        border: OutlineInputBorder(),
                      ),
                      items: widget.gapOptions
                          .map((v) => DropdownMenuItem(
                                value: v,
                                child: Text(v),
                              ))
                          .toList(),
                      onChanged: (v) => setState(
                        () => gapLevel =
                            v ?? widget.gapOptions.first,
                      ),
                    ),
                    const SizedBox(height: 10),
                    _field(
                      'gapDetails',
                      'Gap / Deficiency Details',
                      maxLines: 3,
                    ),
                    _field(
                      'developmentAction',
                      'Development / Corrective Action',
                      maxLines: 3,
                    ),
                    _field(
                      'targetDate',
                      'Action Target Date (YYYY-MM-DD)',
                    ),
                    _section('VALIDITY & VERIFICATION'),
                    _field(
                      'validUntil',
                      'Competency Valid Until (YYYY-MM-DD)',
                    ),
                    DropdownButtonFormField<String>(
                      initialValue: status,
                      decoration: const InputDecoration(
                        labelText: 'Matrix Status',
                        border: OutlineInputBorder(),
                      ),
                      items: widget.statuses
                          .map((v) => DropdownMenuItem(
                                value: v,
                                child: Text(v),
                              ))
                          .toList(),
                      onChanged: (v) => setState(
                        () => status = v ?? 'Not Assessed',
                      ),
                    ),
                    const SizedBox(height: 10),
                    _field(
                      'verification',
                      'Verification / Effectiveness Result',
                      maxLines: 2,
                    ),
                    _field('verifiedBy', 'Verified By'),
                    _field(
                      'verifiedDate',
                      'Verification Date (YYYY-MM-DD)',
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
                        label: const Text('Save Matrix'),
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

    data['requiredLevel'] = requiredLevel;
    data['achievedLevel'] = achievedLevel;
    data['gapLevel'] = gapLevel;
    data['status'] = status;

    Navigator.pop(context, data);
  }
}
