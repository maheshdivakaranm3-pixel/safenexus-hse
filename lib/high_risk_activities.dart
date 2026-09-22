import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HighRiskActivitiesPage extends StatefulWidget {
  const HighRiskActivitiesPage({super.key});

  @override
  State<HighRiskActivitiesPage> createState() =>
      _HighRiskActivitiesPageState();
}

class _HighRiskActivitiesPageState extends State<HighRiskActivitiesPage> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const String storageKey =
      'safenexus_hse_high_risk_activities';

  List<Map<String, dynamic>> records = [];
  String searchText = '';
  String statusFilter = 'All';
  String activityFilter = 'All';
  String clearanceFilter = 'All';

  final List<String> activityTypes = const [
    'All',
    'Work at Height',
    'Confined Space',
    'Excavation / Trenching',
    'Lifting / Critical Lifting',
    'Hot Work',
    'Electrical / LOTO',
    'SIMOPS / Interface',
    'Other High-Risk Activity',
  ];

  final List<String> statuses = const [
    'Draft',
    'Risk Assessment Required',
    'RAMS Required',
    'PTW Required',
    'Under HSE Review',
    'Approved',
    'Active',
    'Action Required',
    'Suspended',
    'Closed',
    'Cancelled',
  ];

  final List<String> clearanceOptions = const [
    'Cleared',
    'Cleared with Conditions',
    'Not Cleared',
    'Pending',
  ];

  final List<String> riskLevels = const [
    'Low',
    'Medium',
    'High',
    'Critical',
  ];

  final List<String> yesNoOptions = const [
    'Yes',
    'No',
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
    final p = item.split('|');
    String v(int i) => i < p.length ? p[i] : '';

    return {
      'id': v(0),
      'activityNo': v(1),
      'activityType': v(2),
      'activityTitle': v(3),
      'project': v(4),
      'site': v(5),
      'location': v(6),
      'department': v(7),
      'workFront': v(8),
      'contractor': v(9),
      'responsiblePerson': v(10),
      'supervisor': v(11),
      'hseOfficer': v(12),
      'scope': v(13),
      'workSequence': v(14),
      'hazards': v(15),
      'initialRisk': v(16),
      'riskControls': v(17),
      'residualRisk': v(18),
      'hiraRef': v(19),
      'jsaRef': v(20),
      'ramsRef': v(21),
      'ptwRef': v(22),
      'permitStatus': v(23),
      'competencyCheck': v(24),
      'equipmentCheck': v(25),
      'ppeCheck': v(26),
      'emergencyPlan': v(27),
      'rescuePlan': v(28),
      'tbtCompleted': v(29),
      'preStartInspection': v(30),
      'barriersControls': v(31),
      'simopsInterface': v(32),
      'inspectionDate': v(33),
      'inspectionFindings': v(34),
      'correctiveAction': v(35),
      'actionOwner': v(36),
      'actionDue': v(37),
      'actionStatus': v(38),
      'verification': v(39),
      'verificationDate': v(40),
      'clearance': v(41),
      'clearanceBy': v(42),
      'clearanceDate': v(43),
      'validUntil': v(44),
      'reviewDate': v(45),
      'status': v(46).isEmpty ? 'Draft' : v(46),
      'lessonsLearned': v(47),
      'remarks': v(48),
      'createdAt': v(49),
      'updatedAt': v(50),
    };
  }

  String _safe(Object? value) =>
      (value?.toString() ?? '').replaceAll('|', '/').trim();

  Future<void> _saveRecords() async {
    final prefs = await SharedPreferences.getInstance();

    const keys = [
      'id',
      'activityNo',
      'activityType',
      'activityTitle',
      'project',
      'site',
      'location',
      'department',
      'workFront',
      'contractor',
      'responsiblePerson',
      'supervisor',
      'hseOfficer',
      'scope',
      'workSequence',
      'hazards',
      'initialRisk',
      'riskControls',
      'residualRisk',
      'hiraRef',
      'jsaRef',
      'ramsRef',
      'ptwRef',
      'permitStatus',
      'competencyCheck',
      'equipmentCheck',
      'ppeCheck',
      'emergencyPlan',
      'rescuePlan',
      'tbtCompleted',
      'preStartInspection',
      'barriersControls',
      'simopsInterface',
      'inspectionDate',
      'inspectionFindings',
      'correctiveAction',
      'actionOwner',
      'actionDue',
      'actionStatus',
      'verification',
      'verificationDate',
      'clearance',
      'clearanceBy',
      'clearanceDate',
      'validUntil',
      'reviewDate',
      'status',
      'lessonsLearned',
      'remarks',
      'createdAt',
      'updatedAt',
    ];

    final raw = records
        .map((r) => keys.map((k) => _safe(r[k])).join('|'))
        .toList();

    await prefs.setStringList(storageKey, raw);
  }

  List<Map<String, dynamic>> get filteredRecords {
    final query = searchText.trim().toLowerCase();

    return records.where((r) {
      final searchable = r.values.join(' ').toLowerCase();
      return (query.isEmpty || searchable.contains(query)) &&
          (statusFilter == 'All' || r['status'] == statusFilter) &&
          (activityFilter == 'All' || r['activityType'] == activityFilter) &&
          (clearanceFilter == 'All' || r['clearance'] == clearanceFilter);
    }).toList();
  }

  int _countStatus(String value) =>
      records.where((r) => r['status'] == value).length;

  int _countField(String field, String value) =>
      records.where((r) => r[field] == value).length;

  int get _activeCount => _countStatus('Active');
  int get _approvedCount => _countStatus('Approved');
  int get _suspendedCount => _countStatus('Suspended');
  int get _actionCount => _countStatus('Action Required');
  int get _criticalCount => _countField('residualRisk', 'Critical');
  int get _highCount => _countField('residualRisk', 'High');
  int get _clearedCount => _countField('clearance', 'Cleared');
  int get _overdueCount =>
      records.where(_isOverdue).length;
  int get _expiringCount =>
      records.where(_isExpiringSoon).length;

  bool _isOverdue(Map<String, dynamic> record) {
    final date = DateTime.tryParse(
      record['validUntil']?.toString() ?? '',
    );
    if (date == null) return false;

    return date.isBefore(DateTime.now()) &&
        record['status'] != 'Closed' &&
        record['status'] != 'Cancelled' &&
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

  Future<void> _openForm({Map<String, dynamic>? existing}) async {
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _HighRiskFormSheet(
        existing: existing,
        activityTypes:
            activityTypes.where((v) => v != 'All').toList(),
        statuses: statuses,
        clearanceOptions: clearanceOptions,
        riskLevels: riskLevels,
        yesNoOptions: yesNoOptions,
      ),
    );

    if (result == null) return;

    final now = DateTime.now().toIso8601String();

    if (existing == null) {
      result['id'] = 'HRA-${DateTime.now().millisecondsSinceEpoch}';
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
          record['activityTitle']?.toString().isNotEmpty == true
              ? record['activityTitle'].toString()
              : 'High-Risk Activity Details',
        ),
        content: SizedBox(
          width: 600,
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
                      padding: const EdgeInsets.only(bottom: 7),
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
        title: const Text('High-Risk Activities'),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () => _openForm(),
            icon: const Icon(Icons.add),
            tooltip: 'Add High-Risk Activity',
          ),
        ],
      ),
      body: Column(
        children: [
          _dashboard(),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 2, 12, 8),
            child: Column(
              children: [
                TextField(
                  decoration: const InputDecoration(
                    labelText:
                        'Search activity, project, HIRA, JSA, RAMS, PTW...',
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
                            .map(
                              (v) => DropdownMenuItem(
                                value: v,
                                child: Text(v),
                              ),
                            )
                            .toList(),
                        onChanged: (v) =>
                            setState(() => statusFilter = v ?? 'All'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        initialValue: activityFilter,
                        decoration: const InputDecoration(
                          labelText: 'Activity',
                          border: OutlineInputBorder(),
                        ),
                        items: activityTypes
                            .map(
                              (v) => DropdownMenuItem(
                                value: v,
                                child: Text(v),
                              ),
                            )
                            .toList(),
                        onChanged: (v) =>
                            setState(() => activityFilter = v ?? 'All'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  initialValue: clearanceFilter,
                  decoration: const InputDecoration(
                    labelText: 'Clearance',
                    border: OutlineInputBorder(),
                  ),
                  items: ['All', ...clearanceOptions]
                      .map(
                        (v) => DropdownMenuItem(
                          value: v,
                          child: Text(v),
                        ),
                      )
                      .toList(),
                  onChanged: (v) =>
                      setState(() => clearanceFilter = v ?? 'All'),
                ),
              ],
            ),
          ),
          Expanded(
            child: filteredRecords.isEmpty
                ? const Center(
                    child: Text('No high-risk activity records found.'),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: filteredRecords.length,
                    itemBuilder: (_, index) {
                      final r = filteredRecords[index];
                      final overdue = _isOverdue(r);
                      final expiring = _isExpiringSoon(r);

                      return Card(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor:
                                r['clearance'] == 'Not Cleared'
                                    ? Colors.red
                                    : primaryGreen,
                            child: const Icon(
                              Icons.warning_amber_rounded,
                              color: Colors.white,
                            ),
                          ),
                          title: Text(
                            r['activityTitle']?.toString() ?? '',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            '${r['activityNo']} • ${r['activityType']}\n'
                            '${r['residualRisk']} residual risk • '
                            '${r['clearance']} • ${r['status']}'
                            '${overdue ? ' • OVERDUE' : ''}'
                            '${expiring ? ' • EXPIRING ≤30 DAYS' : ''}',
                          ),
                          isThreeLine: true,
                          onTap: () => _showDetails(r),
                          trailing: PopupMenuButton<String>(
                            onSelected: (value) {
                              if (value == 'edit') {
                                _openForm(existing: r);
                              } else if (value == 'delete') {
                                _deleteRecord(r);
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
        label: const Text('Add Activity'),
      ),
    );
  }

  Widget _dashboard() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          _stat('TOTAL', records.length, Icons.warning),
          _stat('ACTIVE', _activeCount, Icons.play_circle),
          _stat('APPROVED', _approvedCount, Icons.verified),
          _stat('CLEARED', _clearedCount, Icons.task_alt),
          _stat('HIGH', _highCount, Icons.priority_high),
          _stat('CRITICAL', _criticalCount, Icons.dangerous),
          _stat('ACTION', _actionCount, Icons.assignment_late),
          _stat('SUSPENDED', _suspendedCount, Icons.pause_circle),
          _stat('EXPIRING', _expiringCount, Icons.schedule),
          _stat('OVERDUE', _overdueCount, Icons.error),
        ],
      ),
    );
  }

  Widget _stat(String title, int value, IconData icon) {
    return SizedBox(
      width: 88,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 9,
            horizontal: 3,
          ),
          child: Column(
            children: [
              Icon(icon, color: primaryGreen, size: 19),
              const SizedBox(height: 3),
              Text(
                '$value',
                style: const TextStyle(
                  fontSize: 17,
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

class _HighRiskFormSheet extends StatefulWidget {
  final Map<String, dynamic>? existing;
  final List<String> activityTypes;
  final List<String> statuses;
  final List<String> clearanceOptions;
  final List<String> riskLevels;
  final List<String> yesNoOptions;

  const _HighRiskFormSheet({
    required this.existing,
    required this.activityTypes,
    required this.statuses,
    required this.clearanceOptions,
    required this.riskLevels,
    required this.yesNoOptions,
  });

  @override
  State<_HighRiskFormSheet> createState() =>
      _HighRiskFormSheetState();
}

class _HighRiskFormSheetState extends State<_HighRiskFormSheet> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);

  final formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> controllers = {};

  String activityType = 'Work at Height';
  String initialRisk = 'High';
  String residualRisk = 'Medium';
  String permitStatus = 'Pending';
  String competencyCheck = 'Pending';
  String equipmentCheck = 'Pending';
  String ppeCheck = 'Pending';
  String emergencyPlan = 'Pending';
  String rescuePlan = 'Pending';
  String tbtCompleted = 'Pending';
  String preStartInspection = 'Pending';
  String simopsInterface = 'Pending';
  String actionStatus = 'Open';
  String verification = 'Pending';
  String clearance = 'Pending';
  String status = 'Draft';

  @override
  void initState() {
    super.initState();

    const fields = [
      'activityNo',
      'activityTitle',
      'project',
      'site',
      'location',
      'department',
      'workFront',
      'contractor',
      'responsiblePerson',
      'supervisor',
      'hseOfficer',
      'scope',
      'workSequence',
      'hazards',
      'riskControls',
      'hiraRef',
      'jsaRef',
      'ramsRef',
      'ptwRef',
      'barriersControls',
      'inspectionDate',
      'inspectionFindings',
      'correctiveAction',
      'actionOwner',
      'actionDue',
      'verificationDate',
      'clearanceBy',
      'clearanceDate',
      'validUntil',
      'reviewDate',
      'lessonsLearned',
      'remarks',
    ];

    for (final field in fields) {
      controllers[field] = TextEditingController(
        text: widget.existing?[field]?.toString() ?? '',
      );
    }

    _loadExisting();
  }

  void _loadExisting() {
    final e = widget.existing;
    if (e == null) return;

    final activity = e['activityType']?.toString();
    if (widget.activityTypes.contains(activity)) {
      activityType = activity!;
    }

    final initial = e['initialRisk']?.toString();
    if (widget.riskLevels.contains(initial)) {
      initialRisk = initial!;
    }

    final residual = e['residualRisk']?.toString();
    if (widget.riskLevels.contains(residual)) {
      residualRisk = residual!;
    }

    final permit = e['permitStatus']?.toString();
    if (widget.yesNoOptions.contains(permit)) {
      permitStatus = permit!;
    }

    competencyCheck = _safeChoice(
      e['competencyCheck'],
      widget.yesNoOptions,
      competencyCheck,
    );
    equipmentCheck = _safeChoice(
      e['equipmentCheck'],
      widget.yesNoOptions,
      equipmentCheck,
    );
    ppeCheck = _safeChoice(
      e['ppeCheck'],
      widget.yesNoOptions,
      ppeCheck,
    );
    emergencyPlan = _safeChoice(
      e['emergencyPlan'],
      widget.yesNoOptions,
      emergencyPlan,
    );
    rescuePlan = _safeChoice(
      e['rescuePlan'],
      widget.yesNoOptions,
      rescuePlan,
    );
    tbtCompleted = _safeChoice(
      e['tbtCompleted'],
      widget.yesNoOptions,
      tbtCompleted,
    );
    preStartInspection = _safeChoice(
      e['preStartInspection'],
      widget.yesNoOptions,
      preStartInspection,
    );
    simopsInterface = _safeChoice(
      e['simopsInterface'],
      widget.yesNoOptions,
      simopsInterface,
    );

    final action = e['actionStatus']?.toString();
    if ([
      'Open',
      'In Progress',
      'Completed',
      'Overdue',
      'Closed',
      'Not Applicable',
    ].contains(action)) {
      actionStatus = action!;
    }

    final verify = e['verification']?.toString();
    if ([
      'Effective',
      'Ineffective',
      'Pending',
      'Not Required',
    ].contains(verify)) {
      verification = verify!;
    }

    final clear = e['clearance']?.toString();
    if (widget.clearanceOptions.contains(clear)) {
      clearance = clear!;
    }

    final currentStatus = e['status']?.toString();
    if (widget.statuses.contains(currentStatus)) {
      status = currentStatus!;
    }
  }

  String _safeChoice(
    Object? value,
    List<String> options,
    String fallback,
  ) {
    final text = value?.toString();
    return text != null && options.contains(text) ? text : fallback;
  }

  @override
  void dispose() {
    for (final c in controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  TextEditingController _c(String key) => controllers[key]!;

  String? _required(String? value) =>
      value == null || value.trim().isEmpty ? 'Required' : null;

  Widget _field(
    String key,
    String label, {
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: _c(key),
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
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _dropdown(
    String label,
    String value,
    List<String> options,
    ValueChanged<String?> onChanged,
  ) {
    final safeValue =
        options.contains(value) ? value : options.first;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: DropdownButtonFormField<String>(
        initialValue: safeValue,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        items: options
            .map(
              (v) => DropdownMenuItem(
                value: v,
                child: Text(v),
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
        height: MediaQuery.of(context).size.height * 0.95,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(22),
          ),
        ),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                color: darkGreen,
                child: const Row(
                  children: [
                    Icon(
                      Icons.warning_amber_rounded,
                      color: Colors.white,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'High-Risk Activity Control Register',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    _section('8A • HIGH-RISK ACTIVITY MASTER'),
                    _field(
                      'activityNo',
                      'Activity Reference Number',
                      validator: _required,
                    ),
                    _field(
                      'activityTitle',
                      'High-Risk Activity Title',
                      validator: _required,
                    ),
                    _dropdown(
                      'Activity Type',
                      activityType,
                      widget.activityTypes,
                      (v) => setState(
                        () => activityType = v ?? activityType,
                      ),
                    ),
                    _field('project', 'Project'),
                    _field('site', 'Site'),
                    _field('location', 'Work Location'),
                    _field('department', 'Department'),
                    _field('workFront', 'Work Front / Area'),
                    _field('contractor', 'Contractor / Company'),
                    _field(
                      'responsiblePerson',
                      'Responsible Person',
                    ),
                    _field('supervisor', 'Supervisor'),
                    _field('hseOfficer', 'HSE Officer'),

                    _section('RISK + RAMS + JSA INTEGRATION'),
                    _field('scope', 'Scope of Work', maxLines: 3),
                    _field(
                      'workSequence',
                      'Work Sequence / Method',
                      maxLines: 4,
                    ),
                    _field(
                      'hazards',
                      'Key Hazards',
                      maxLines: 4,
                    ),
                    _dropdown(
                      'Initial Risk',
                      initialRisk,
                      widget.riskLevels,
                      (v) => setState(
                        () => initialRisk = v ?? initialRisk,
                      ),
                    ),
                    _field(
                      'riskControls',
                      'Critical Risk Controls',
                      maxLines: 5,
                    ),
                    _dropdown(
                      'Residual Risk',
                      residualRisk,
                      widget.riskLevels,
                      (v) => setState(
                        () => residualRisk = v ?? residualRisk,
                      ),
                    ),
                    _field('hiraRef', 'HIRA Reference'),
                    _field('jsaRef', 'JSA / JHA Reference'),
                    _field('ramsRef', 'RAMS / Method Statement Reference'),

                    _section('4 • PERMIT TO WORK INTEGRATION'),
                    _field('ptwRef', 'PTW Reference'),
                    _dropdown(
                      'Permit Status',
                      permitStatus,
                      widget.yesNoOptions,
                      (v) => setState(
                        () => permitStatus = v ?? permitStatus,
                      ),
                    ),

                    _section('6 • COMPETENCY / WORKFORCE'),
                    _dropdown(
                      'Competency Check',
                      competencyCheck,
                      widget.yesNoOptions,
                      (v) => setState(
                        () => competencyCheck =
                            v ?? competencyCheck,
                      ),
                    ),

                    _section('7 • EQUIPMENT & PPE'),
                    _dropdown(
                      'Equipment Check',
                      equipmentCheck,
                      widget.yesNoOptions,
                      (v) => setState(
                        () => equipmentCheck =
                            v ?? equipmentCheck,
                      ),
                    ),
                    _dropdown(
                      'PPE Check',
                      ppeCheck,
                      widget.yesNoOptions,
                      (v) => setState(
                        () => ppeCheck = v ?? ppeCheck,
                      ),
                    ),

                    _section('8B–8H • CRITICAL ACTIVITY CONTROLS'),
                    _field(
                      'barriersControls',
                      'Physical Barriers / Critical Controls',
                      maxLines: 4,
                    ),
                    _dropdown(
                      'Emergency Plan',
                      emergencyPlan,
                      widget.yesNoOptions,
                      (v) => setState(
                        () => emergencyPlan = v ?? emergencyPlan,
                      ),
                    ),
                    _dropdown(
                      'Rescue Plan',
                      rescuePlan,
                      widget.yesNoOptions,
                      (v) => setState(
                        () => rescuePlan = v ?? rescuePlan,
                      ),
                    ),
                    _dropdown(
                      'SIMOPS / Interface Control',
                      simopsInterface,
                      widget.yesNoOptions,
                      (v) => setState(
                        () => simopsInterface =
                            v ?? simopsInterface,
                      ),
                    ),

                    _section('9 • DAILY / PRE-START CONTROL'),
                    _dropdown(
                      'TBT Completed',
                      tbtCompleted,
                      widget.yesNoOptions,
                      (v) => setState(
                        () => tbtCompleted = v ?? tbtCompleted,
                      ),
                    ),
                    _dropdown(
                      'Pre-Start Inspection',
                      preStartInspection,
                      widget.yesNoOptions,
                      (v) => setState(
                        () => preStartInspection =
                            v ?? preStartInspection,
                      ),
                    ),

                    _section('8I • HIGH-RISK INSPECTION'),
                    _field(
                      'inspectionDate',
                      'Inspection Date (YYYY-MM-DD)',
                    ),
                    _field(
                      'inspectionFindings',
                      'Inspection Findings',
                      maxLines: 4,
                    ),
                    _field(
                      'correctiveAction',
                      'Corrective Action',
                      maxLines: 4,
                    ),
                    _field('actionOwner', 'Action Owner'),
                    _field(
                      'actionDue',
                      'Action Due Date (YYYY-MM-DD)',
                    ),
                    _dropdown(
                      'Action Status',
                      actionStatus,
                      const [
                        'Open',
                        'In Progress',
                        'Completed',
                        'Overdue',
                        'Closed',
                        'Not Applicable',
                      ],
                      (v) => setState(
                        () => actionStatus = v ?? actionStatus,
                      ),
                    ),
                    _dropdown(
                      'Control Verification',
                      verification,
                      const [
                        'Effective',
                        'Ineffective',
                        'Pending',
                        'Not Required',
                      ],
                      (v) => setState(
                        () => verification = v ?? verification,
                      ),
                    ),
                    _field(
                      'verificationDate',
                      'Verification Date (YYYY-MM-DD)',
                    ),

                    _section('8J • HSE READINESS & CLEARANCE'),
                    _dropdown(
                      'HSE Clearance',
                      clearance,
                      widget.clearanceOptions,
                      (v) => setState(
                        () => clearance = v ?? clearance,
                      ),
                    ),
                    _field('clearanceBy', 'Clearance By'),
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

                    _section('STATUS & LESSONS'),
                    _dropdown(
                      'Activity Status',
                      status,
                      widget.statuses,
                      (v) => setState(
                        () => status = v ?? status,
                      ),
                    ),
                    _field(
                      'lessonsLearned',
                      'Lessons Learned / Improvement',
                      maxLines: 4,
                    ),
                    _field(
                      'remarks',
                      'Remarks',
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
                        label: const Text('Save Activity'),
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
    if (!formKey.currentState!.validate()) return;

    final data = <String, dynamic>{};

    for (final entry in controllers.entries) {
      data[entry.key] = entry.value.text.trim();
    }

    data['activityType'] = activityType;
    data['initialRisk'] = initialRisk;
    data['residualRisk'] = residualRisk;
    data['permitStatus'] = permitStatus;
    data['competencyCheck'] = competencyCheck;
    data['equipmentCheck'] = equipmentCheck;
    data['ppeCheck'] = ppeCheck;
    data['emergencyPlan'] = emergencyPlan;
    data['rescuePlan'] = rescuePlan;
    data['tbtCompleted'] = tbtCompleted;
    data['preStartInspection'] = preStartInspection;
    data['simopsInterface'] = simopsInterface;
    data['actionStatus'] = actionStatus;
    data['verification'] = verification;
    data['clearance'] = clearance;
    data['status'] = status;

    Navigator.pop(context, data);
  }
}
