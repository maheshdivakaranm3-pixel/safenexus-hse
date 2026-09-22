import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ToolboxTalkAttendancePage extends StatefulWidget {
  const ToolboxTalkAttendancePage({super.key});

  @override
  State<ToolboxTalkAttendancePage> createState() =>
      _ToolboxTalkAttendancePageState();
}

class _ToolboxTalkAttendancePageState
    extends State<ToolboxTalkAttendancePage> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const String storageKey =
      'safenexus_hse_toolbox_talk_attendance';

  List<Map<String, dynamic>> records = [];
  String searchText = '';
  String statusFilter = 'All';
  String attendanceFilter = 'All';

  final List<String> statuses = const [
    'Planned',
    'Scheduled',
    'In Progress',
    'Completed',
    'Action Pending',
    'Closed',
    'Cancelled',
  ];

  final List<String> attendanceStatuses = const [
    'Present',
    'Absent',
    'Late',
    'Excused',
    'Pending',
  ];

  final List<String> talkTypes = const [
    'Toolbox Talk',
    'Safety Briefing',
    'Pre-Start Briefing',
    'Task Briefing',
    'Daily Safety Meeting',
    'Emergency Briefing',
    'Safety Awareness Session',
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
    final parts = item.split('|');

    String getValue(int index) =>
        index < parts.length ? parts[index] : '';

    return {
      'id': getValue(0),
      'talkNo': getValue(1),
      'date': getValue(2),
      'time': getValue(3),
      'project': getValue(4),
      'site': getValue(5),
      'location': getValue(6),
      'department': getValue(7),
      'workActivity': getValue(8),
      'talkType': getValue(9),
      'topic': getValue(10),
      'hazardRisk': getValue(11),
      'conductedBy': getValue(12),
      'hseOfficer': getValue(13),
      'speaker': getValue(14),
      'targetWorkers': getValue(15),
      'workerId': getValue(16),
      'workerName': getValue(17),
      'jobRole': getValue(18),
      'company': getValue(19),
      'attendanceStatus':
          getValue(20).isEmpty ? 'Present' : getValue(20),
      'acknowledged': getValue(21),
      'acknowledgementRef': getValue(22),
      'questionsConcerns': getValue(23),
      'actions': getValue(24),
      'actionOwner': getValue(25),
      'actionDueDate': getValue(26),
      'actionStatus': getValue(27),
      'verification': getValue(28),
      'status': getValue(29).isEmpty ? 'Planned' : getValue(29),
      'remarks': getValue(30),
      'createdAt': getValue(31),
      'updatedAt': getValue(32),
    };
  }

  String _safe(Object? value) =>
      (value?.toString() ?? '').replaceAll('|', '/').trim();

  Future<void> _saveRecords() async {
    final prefs = await SharedPreferences.getInstance();

    const keys = [
      'id',
      'talkNo',
      'date',
      'time',
      'project',
      'site',
      'location',
      'department',
      'workActivity',
      'talkType',
      'topic',
      'hazardRisk',
      'conductedBy',
      'hseOfficer',
      'speaker',
      'targetWorkers',
      'workerId',
      'workerName',
      'jobRole',
      'company',
      'attendanceStatus',
      'acknowledged',
      'acknowledgementRef',
      'questionsConcerns',
      'actions',
      'actionOwner',
      'actionDueDate',
      'actionStatus',
      'verification',
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

      final matchesAttendance =
          attendanceFilter == 'All' ||
          record['attendanceStatus'] == attendanceFilter;

      return matchesSearch &&
          matchesStatus &&
          matchesAttendance;
    }).toList();
  }

  int _countStatus(String status) =>
      records.where((r) => r['status'] == status).length;

  int _countAttendance(String status) =>
      records.where((r) => r['attendanceStatus'] == status).length;

  int get _completedCount => _countStatus('Completed');

  int get _actionPendingCount =>
      _countStatus('Action Pending');

  int get _presentCount => _countAttendance('Present');

  int get _absentCount => _countAttendance('Absent');

  int get _lateCount => _countAttendance('Late');

  int get _overdueActionCount =>
      records.where(_isActionOverdue).length;

  bool _isActionOverdue(Map<String, dynamic> record) {
    final dueDate = DateTime.tryParse(
      record['actionDueDate']?.toString() ?? '',
    );

    if (dueDate == null) return false;

    return dueDate.isBefore(DateTime.now()) &&
        record['actionStatus'] != 'Completed' &&
        record['actionStatus'] != 'Closed' &&
        record['status'] != 'Cancelled';
  }

  Future<void> _openForm({
    Map<String, dynamic>? existing,
  }) async {
    final result =
        await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _ToolboxTalkFormSheet(
        existing: existing,
        statuses: statuses,
        attendanceStatuses: attendanceStatuses,
        talkTypes: talkTypes,
      ),
    );

    if (result == null) return;

    final now = DateTime.now().toIso8601String();

    if (existing == null) {
      result['id'] =
          'TBT-${DateTime.now().millisecondsSinceEpoch}';
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
          record['topic']?.toString().isNotEmpty == true
              ? record['topic'].toString()
              : 'Toolbox Talk Details',
        ),
        content: SizedBox(
          width: 520,
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
            const Text('Toolbox Talk / Briefing Attendance'),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            tooltip: 'Add TBT',
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
                        'Search TBT, worker, topic, site...',
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
                        initialValue: attendanceFilter,
                        decoration:
                            const InputDecoration(
                          labelText: 'Attendance',
                          border: OutlineInputBorder(),
                        ),
                        items: [
                          'All',
                          ...attendanceStatuses,
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
                          () => attendanceFilter =
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
                      'No toolbox talk / briefing records found.',
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
                          _isActionOverdue(record);

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
                              Icons.groups,
                              color: Colors.white,
                            ),
                          ),
                          title: Text(
                            record['topic']
                                    ?.toString() ??
                                '',
                            style:
                                const TextStyle(
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            '${record['talkNo']} • '
                            '${record['workerName']}\n'
                            '${record['date']} • '
                            '${record['attendanceStatus']} • '
                            '${record['status']}'
                            '${overdue ? ' • ACTION OVERDUE' : ''}',
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
        label: const Text('Add TBT'),
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
            Icons.groups,
          ),
          _stat(
            'COMPLETED',
            _completedCount,
            Icons.check_circle,
          ),
          _stat(
            'PRESENT',
            _presentCount,
            Icons.person,
          ),
          _stat(
            'ABSENT',
            _absentCount,
            Icons.person_off,
          ),
          _stat(
            'LATE',
            _lateCount,
            Icons.schedule,
          ),
          _stat(
            'ACTION',
            _actionPendingCount,
            Icons.assignment_late,
          ),
          _stat(
            'OVERDUE',
            _overdueActionCount,
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

class _ToolboxTalkFormSheet extends StatefulWidget {
  final Map<String, dynamic>? existing;
  final List<String> statuses;
  final List<String> attendanceStatuses;
  final List<String> talkTypes;

  const _ToolboxTalkFormSheet({
    required this.existing,
    required this.statuses,
    required this.attendanceStatuses,
    required this.talkTypes,
  });

  @override
  State<_ToolboxTalkFormSheet> createState() =>
      _ToolboxTalkFormSheetState();
}

class _ToolboxTalkFormSheetState
    extends State<_ToolboxTalkFormSheet> {
  static const Color primaryGreen =
      Color(0xFF159447);
  static const Color darkGreen =
      Color(0xFF0B5D4B);

  final _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController>
      controllers = {};

  String talkType = 'Toolbox Talk';
  String attendanceStatus = 'Present';
  String status = 'Planned';

  @override
  void initState() {
    super.initState();

    const fields = [
      'talkNo',
      'date',
      'time',
      'project',
      'site',
      'location',
      'department',
      'workActivity',
      'topic',
      'hazardRisk',
      'conductedBy',
      'hseOfficer',
      'speaker',
      'targetWorkers',
      'workerId',
      'workerName',
      'jobRole',
      'company',
      'acknowledged',
      'acknowledgementRef',
      'questionsConcerns',
      'actions',
      'actionOwner',
      'actionDueDate',
      'actionStatus',
      'verification',
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

    final existingType =
        widget.existing?['talkType']?.toString();

    if (existingType != null &&
        widget.talkTypes.contains(existingType)) {
      talkType = existingType;
    }

    final existingAttendance =
        widget.existing?['attendanceStatus']
            ?.toString();

    if (existingAttendance != null &&
        widget.attendanceStatuses
            .contains(existingAttendance)) {
      attendanceStatus = existingAttendance;
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
                      Icons.groups,
                      color: Colors.white,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Toolbox Talk / Briefing Attendance',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight:
                            FontWeight.bold,
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
                      'TBT / BRIEFING DETAILS',
                    ),
                    _field(
                      'talkNo',
                      'TBT / Briefing Number',
                      validator: _required,
                    ),
                    _field(
                      'date',
                      'Date (YYYY-MM-DD)',
                      validator: _required,
                    ),
                    _field(
                      'time',
                      'Time',
                    ),
                    DropdownButtonFormField<String>(
                      initialValue: talkType,
                      decoration:
                          const InputDecoration(
                        labelText:
                            'TBT / Briefing Type',
                        border:
                            OutlineInputBorder(),
                      ),
                      items: widget.talkTypes
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
                        () => talkType =
                            value ??
                                widget.talkTypes
                                    .first,
                      ),
                    ),
                    const SizedBox(height: 10),
                    _field(
                      'project',
                      'Project',
                    ),
                    _field(
                      'site',
                      'Site',
                    ),
                    _field(
                      'location',
                      'Location',
                    ),
                    _field(
                      'department',
                      'Department',
                    ),
                    _field(
                      'workActivity',
                      'Work Activity / Task',
                    ),
                    _section(
                      'TOPIC & RISK',
                    ),
                    _field(
                      'topic',
                      'Topic / Subject',
                      maxLines: 2,
                      validator: _required,
                    ),
                    _field(
                      'hazardRisk',
                      'Hazard / Risk Discussed',
                      maxLines: 3,
                    ),
                    _section(
                      'CONDUCTOR & WORKFORCE',
                    ),
                    _field(
                      'conductedBy',
                      'Conducted By',
                      validator: _required,
                    ),
                    _field(
                      'hseOfficer',
                      'HSE Officer / Supervisor',
                    ),
                    _field(
                      'speaker',
                      'Trainer / Speaker',
                    ),
                    _field(
                      'targetWorkers',
                      'Target Workers / Crew',
                      maxLines: 2,
                    ),
                    _field(
                      'workerId',
                      'Worker ID',
                    ),
                    _field(
                      'workerName',
                      'Worker Name',
                      validator: _required,
                    ),
                    _field(
                      'jobRole',
                      'Job Role / Trade',
                    ),
                    _field(
                      'company',
                      'Company / Contractor',
                    ),
                    _section(
                      'ATTENDANCE & ACKNOWLEDGEMENT',
                    ),
                    DropdownButtonFormField<String>(
                      initialValue:
                          attendanceStatus,
                      decoration:
                          const InputDecoration(
                        labelText:
                            'Attendance Status',
                        border:
                            OutlineInputBorder(),
                      ),
                      items:
                          widget.attendanceStatuses
                              .map(
                                (value) =>
                                    DropdownMenuItem(
                                  value: value,
                                  child:
                                      Text(value),
                                ),
                              )
                              .toList(),
                      onChanged: (value) =>
                          setState(
                        () =>
                            attendanceStatus =
                                value ??
                                    widget
                                        .attendanceStatuses
                                        .first,
                      ),
                    ),
                    const SizedBox(height: 10),
                    _field(
                      'acknowledged',
                      'Acknowledgement / Worker Confirmation',
                    ),
                    _field(
                      'acknowledgementRef',
                      'Signature / Acknowledgement Reference',
                    ),
                    _section(
                      'QUESTIONS & ACTIONS',
                    ),
                    _field(
                      'questionsConcerns',
                      'Questions / Concerns Raised',
                      maxLines: 3,
                    ),
                    _field(
                      'actions',
                      'Actions / Corrective Actions',
                      maxLines: 3,
                    ),
                    _field(
                      'actionOwner',
                      'Action Owner',
                    ),
                    _field(
                      'actionDueDate',
                      'Action Due Date (YYYY-MM-DD)',
                    ),
                    _field(
                      'actionStatus',
                      'Action Status',
                    ),
                    _field(
                      'verification',
                      'Verification / Effectiveness',
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
                            'Record Status',
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
                            value ?? 'Planned',
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
                          'Save TBT',
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

    data['talkType'] = talkType;
    data['attendanceStatus'] =
        attendanceStatus;
    data['status'] = status;

    Navigator.pop(context, data);
  }
}
