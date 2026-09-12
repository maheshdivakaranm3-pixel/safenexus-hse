import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CompetencyAssessmentPage extends StatefulWidget {
  const CompetencyAssessmentPage({super.key});

  @override
  State<CompetencyAssessmentPage> createState() =>
      _CompetencyAssessmentPageState();
}

class _CompetencyAssessmentPageState extends State<CompetencyAssessmentPage> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const String storageKey =
      'safenexus_hse_competency_assessment';

  List<Map<String, dynamic>> records = [];
  String searchText = '';
  String statusFilter = 'All';
  String levelFilter = 'All';

  final List<String> statuses = const [
    'Planned',
    'Scheduled',
    'Under Assessment',
    'Competent',
    'Competent with Conditions',
    'Not Yet Competent',
    'Reassessment Required',
    'Expired',
    'Closed',
    'Cancelled',
  ];

  final List<String> competencyLevels = const [
    'Not Assessed',
    'Awareness',
    'Basic',
    'Intermediate',
    'Advanced',
    'Competent',
  ];

  final List<String> assessmentMethods = const [
    'Practical Assessment',
    'Theory / Written Test',
    'Oral Assessment',
    'Observation',
    'Interview',
    'Simulation',
    'Document Review',
    'Combined Practical & Theory',
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
      'skillCode': get(8),
      'skillName': get(9),
      'requiredLevel': get(10),
      'assessmentMethod': get(11),
      'assessmentDate': get(12),
      'assessor': get(13),
      'assessorId': get(14),
      'criteria': get(15),
      'practicalResult': get(16),
      'theoryResult': get(17),
      'score': get(18),
      'competencyLevel':
          get(19).isEmpty ? 'Not Assessed' : get(19),
      'gaps': get(20),
      'correctiveTraining': get(21),
      'validFrom': get(22),
      'validUntil': get(23),
      'status': get(24).isEmpty ? 'Planned' : get(24),
      'evidence': get(25),
      'recommendation': get(26),
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
      'requiredLevel',
      'assessmentMethod',
      'assessmentDate',
      'assessor',
      'assessorId',
      'criteria',
      'practicalResult',
      'theoryResult',
      'score',
      'competencyLevel',
      'gaps',
      'correctiveTraining',
      'validFrom',
      'validUntil',
      'status',
      'evidence',
      'recommendation',
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
      final matchesLevel = levelFilter == 'All' ||
          record['competencyLevel'] == levelFilter;

      return matchesSearch && matchesStatus && matchesLevel;
    }).toList();
  }

  int _count(String status) =>
      records.where((record) => record['status'] == status).length;

  int get _overdueCount =>
      records.where(_isOverdue).length;

  int get _expiringSoonCount =>
      records.where(_isExpiringSoon).length;

  int get _gapCount => records.where((record) {
        final gaps = record['gaps']?.toString().trim() ?? '';
        return gaps.isNotEmpty &&
            record['status'] != 'Cancelled' &&
            record['status'] != 'Closed';
      }).length;

  bool _isOverdue(Map<String, dynamic> record) {
    final date =
        DateTime.tryParse(record['validUntil']?.toString() ?? '');
    if (date == null) return false;

    return date.isBefore(DateTime.now()) &&
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
      builder: (_) => _CompetencyAssessmentForm(
        existing: existing,
        statuses: statuses,
        competencyLevels: competencyLevels,
        assessmentMethods: assessmentMethods,
      ),
    );

    if (result == null) return;

    final now = DateTime.now().toIso8601String();

    if (existing == null) {
      result['id'] = 'CMP-${DateTime.now().millisecondsSinceEpoch}';
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
          record['skillName']?.toString().isNotEmpty == true
              ? record['skillName'].toString()
              : 'Competency Assessment',
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
        title: const Text('Competency Assessment'),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            tooltip: 'Add Assessment',
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
                        'Search worker, skill, assessor, certificate...',
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
                        initialValue: levelFilter,
                        decoration: const InputDecoration(
                          labelText: 'Competency Level',
                          border: OutlineInputBorder(),
                        ),
                        items: ['All', ...competencyLevels]
                            .map(
                              (value) => DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              ),
                            )
                            .toList(),
                        onChanged: (value) => setState(
                          () => levelFilter = value ?? 'All',
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
                    child: Text('No competency assessments found.'),
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
                              Icons.fact_check,
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
                            '${record['competencyLevel']}\n'
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
        label: const Text('Add Assessment'),
      ),
    );
  }

  Widget _dashboard() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          _stat('TOTAL', records.length, Icons.fact_check),
          _stat('COMPETENT', _count('Competent'), Icons.verified),
          _stat(
            'CONDITIONS',
            _count('Competent with Conditions'),
            Icons.rule,
          ),
          _stat(
            'REASSESS',
            _count('Reassessment Required'),
            Icons.refresh,
          ),
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

class _CompetencyAssessmentForm extends StatefulWidget {
  final Map<String, dynamic>? existing;
  final List<String> statuses;
  final List<String> competencyLevels;
  final List<String> assessmentMethods;

  const _CompetencyAssessmentForm({
    required this.existing,
    required this.statuses,
    required this.competencyLevels,
    required this.assessmentMethods,
  });

  @override
  State<_CompetencyAssessmentForm> createState() =>
      _CompetencyAssessmentFormState();
}

class _CompetencyAssessmentFormState
    extends State<_CompetencyAssessmentForm> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);

  final _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> controllers = {};

  String requiredLevel = 'Intermediate';
  String assessmentMethod = 'Practical Assessment';
  String competencyLevel = 'Not Assessed';
  String status = 'Planned';

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
      'assessmentDate',
      'assessor',
      'assessorId',
      'criteria',
      'practicalResult',
      'theoryResult',
      'score',
      'gaps',
      'correctiveTraining',
      'validFrom',
      'validUntil',
      'evidence',
      'recommendation',
      'remarks',
    ];

    for (final field in fields) {
      controllers[field] = TextEditingController(
        text: widget.existing?[field]?.toString() ?? '',
      );
    }

    final existingRequired =
        widget.existing?['requiredLevel']?.toString();
    if (existingRequired != null &&
        widget.competencyLevels.contains(existingRequired)) {
      requiredLevel = existingRequired;
    }

    final existingMethod =
        widget.existing?['assessmentMethod']?.toString();
    if (existingMethod != null &&
        widget.assessmentMethods.contains(existingMethod)) {
      assessmentMethod = existingMethod;
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
                    Icon(Icons.fact_check, color: Colors.white),
                    SizedBox(width: 10),
                    Text(
                      'Competency Assessment Record',
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
                    _section('WORKER & ASSIGNMENT'),
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
                    DropdownButtonFormField<String>(
                      initialValue: requiredLevel,
                      decoration: const InputDecoration(
                        labelText: 'Required Competency Level',
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
                        () => requiredLevel =
                            value ?? widget.competencyLevels.first,
                      ),
                    ),
                    const SizedBox(height: 10),
                    _section('ASSESSMENT'),
                    DropdownButtonFormField<String>(
                      initialValue: assessmentMethod,
                      decoration: const InputDecoration(
                        labelText: 'Assessment Method',
                        border: OutlineInputBorder(),
                      ),
                      items: widget.assessmentMethods
                          .map(
                            (value) => DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            ),
                          )
                          .toList(),
                      onChanged: (value) => setState(
                        () => assessmentMethod =
                            value ?? widget.assessmentMethods.first,
                      ),
                    ),
                    const SizedBox(height: 10),
                    _field(
                      'assessmentDate',
                      'Assessment Date (YYYY-MM-DD)',
                      validator: _required,
                    ),
                    _field(
                      'assessor',
                      'Assessor / Competency Evaluator',
                      validator: _required,
                    ),
                    _field('assessorId', 'Assessor ID / Authorization'),
                    _field(
                      'criteria',
                      'Assessment Criteria / Performance Standard',
                      maxLines: 3,
                    ),
                    _field(
                      'practicalResult',
                      'Practical Assessment Result',
                      maxLines: 2,
                    ),
                    _field(
                      'theoryResult',
                      'Theory / Written Test Result',
                      maxLines: 2,
                    ),
                    _field('score', 'Overall Score / Percentage'),
                    DropdownButtonFormField<String>(
                      initialValue: competencyLevel,
                      decoration: const InputDecoration(
                        labelText: 'Achieved Competency Level',
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
                    _section('GAP & IMPROVEMENT'),
                    _field(
                      'gaps',
                      'Competency Gaps / Deficiencies',
                      maxLines: 3,
                    ),
                    _field(
                      'correctiveTraining',
                      'Corrective / Additional Training Required',
                      maxLines: 3,
                    ),
                    _field(
                      'recommendation',
                      'Assessor Recommendation',
                      maxLines: 3,
                    ),
                    _section('VALIDITY & STATUS'),
                    _field(
                      'validFrom',
                      'Competency Valid From (YYYY-MM-DD)',
                    ),
                    _field(
                      'validUntil',
                      'Competency Valid Until (YYYY-MM-DD)',
                    ),
                    DropdownButtonFormField<String>(
                      initialValue: status,
                      decoration: const InputDecoration(
                        labelText: 'Assessment Status',
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
                      'evidence',
                      'Evidence / Certificate / Assessment Reference',
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
                        label: const Text('Save Assessment'),
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
    data['assessmentMethod'] = assessmentMethod;
    data['competencyLevel'] = competencyLevel;
    data['status'] = status;

    Navigator.pop(context, data);
  }
}
