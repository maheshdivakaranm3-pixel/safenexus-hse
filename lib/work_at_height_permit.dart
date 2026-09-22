import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WorkAtHeightPermitPage extends StatefulWidget {
  const WorkAtHeightPermitPage({super.key});

  @override
  State<WorkAtHeightPermitPage> createState() => _WorkAtHeightPermitPageState();
}

class _WorkAtHeightPermitPageState extends State<WorkAtHeightPermitPage> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const String storageKey =
      'safenexus_hse_work_at_height_permits';

  final List<String> statuses = const [
    'Draft',
    'Requested',
    'Under Review',
    'Changes Required',
    'Approved',
    'Issued',
    'Active',
    'Suspended',
    'Extended / Revalidated',
    'Closure Pending',
    'Closed',
    'Cancelled',
  ];

  final List<String> workTypes = const [
    'General Work at Height',
    'Roof Work',
    'Scaffolding Work',
    'Ladder Work',
    'MEWP / Aerial Work Platform',
    'Work Near Open Edge',
    'Work Over Fragile Surface',
    'Work Near Excavation',
    'Work at Height + Hot Work',
    'Other',
  ];

  final List<String> accessMethods = const [
    'Scaffold',
    'Mobile Scaffold',
    'Ladder',
    'MEWP / AWP',
    'Fixed Access',
    'Rope Access',
    'Temporary Platform',
    'Other',
  ];

  List<Map<String, dynamic>> records = [];
  String search = '';
  String statusFilter = 'All';
  String workTypeFilter = 'All';
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _loadRecords();
  }

  Future<void> _loadRecords() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(storageKey) ?? [];
    setState(() {
      records = raw.map((item) {
        final parts = item.split('\u001f');
        final map = <String, dynamic>{};
        for (var i = 0; i + 1 < parts.length; i += 2) {
          map[parts[i]] = parts[i + 1];
        }
        return map;
      }).toList();
      loading = false;
    });
  }

  String _encode(Map<String, dynamic> record) {
    final values = <String>[];
    record.forEach((key, value) {
      values.add(key);
      values.add(value?.toString() ?? '');
    });
    return values.join('\u001f');
  }

  Future<void> _saveRecords() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      storageKey,
      records.map(_encode).toList(),
    );
  }

  List<Map<String, dynamic>> get filteredRecords {
    final query = search.trim().toLowerCase();
    return records.where((record) {
      final matchesSearch = query.isEmpty ||
          [
            record['permitNo'],
            record['project'],
            record['location'],
            record['activity'],
            record['workType'],
            record['accessMethod'],
            record['responsiblePerson'],
            record['status'],
          ].join(' ').toLowerCase().contains(query);
      final matchesStatus =
          statusFilter == 'All' || record['status'] == statusFilter;
      final matchesType =
          workTypeFilter == 'All' || record['workType'] == workTypeFilter;
      return matchesSearch && matchesStatus && matchesType;
    }).toList();
  }

  int _count(String status) =>
      records.where((record) => record['status'] == status).length;

  bool _isOverdue(Map<String, dynamic> record) {
    final end = DateTime.tryParse(record['workEnd']?.toString() ?? '');
    if (end == null) return false;
    final status = record['status']?.toString() ?? '';
    return end.isBefore(DateTime.now()) &&
        !['Closed', 'Cancelled'].contains(status);
  }

  int get overdueCount => records.where(_isOverdue).length;

  Future<void> _openForm({
    Map<String, dynamic>? existing,
    int? index,
  }) async {
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _WorkAtHeightForm(
        existing: existing,
        statuses: statuses,
        workTypes: workTypes,
        accessMethods: accessMethods,
      ),
    );

    if (result == null) return;

    setState(() {
      if (index != null) {
        result['createdAt'] = records[index]['createdAt'] ??
            DateTime.now().toIso8601String();
        result['updatedAt'] = DateTime.now().toIso8601String();
        records[index] = result;
      } else {
        result['createdAt'] = DateTime.now().toIso8601String();
        result['updatedAt'] = result['createdAt'];
        records.insert(0, result);
      }
    });

    await _saveRecords();
  }

  Future<void> _deleteRecord(int index) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete Permit'),
        content: const Text('Delete this work-at-height permit record?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    setState(() => records.removeAt(index));
    await _saveRecords();
  }

  void _showDetails(Map<String, dynamic> record) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => _DetailsSheet(record: record),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pending = _count('Requested') +
        _count('Under Review') +
        _count('Changes Required') +
        _count('Closure Pending');
    final active = _count('Issued') + _count('Active');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Work at Height Permit'),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        onPressed: () => _openForm(),
        icon: const Icon(Icons.add),
        label: const Text('New Permit'),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                _Dashboard(
                  total: records.length,
                  pending: pending,
                  active: active,
                  overdue: overdueCount,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 4, 12, 8),
                  child: Column(
                    children: [
                      TextField(
                        decoration: const InputDecoration(
                          labelText: 'Search permits',
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) => setState(() => search = value),
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
                              items: [
                                const DropdownMenuItem(
                                  value: 'All',
                                  child: Text('All'),
                                ),
                                ...statuses.map(
                                  (value) => DropdownMenuItem(
                                    value: value,
                                    child: Text(value),
                                  ),
                                ),
                              ],
                              onChanged: (value) => setState(
                                () => statusFilter = value ?? 'All',
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              initialValue: workTypeFilter,
                              decoration: const InputDecoration(
                                labelText: 'Work Type',
                                border: OutlineInputBorder(),
                              ),
                              items: [
                                const DropdownMenuItem(
                                  value: 'All',
                                  child: Text('All'),
                                ),
                                ...workTypes.map(
                                  (value) => DropdownMenuItem(
                                    value: value,
                                    child: Text(
                                      value,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ],
                              onChanged: (value) => setState(
                                () => workTypeFilter = value ?? 'All',
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
                          child: Text('No work-at-height permit records found.'),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.fromLTRB(12, 0, 12, 90),
                          itemCount: filteredRecords.length,
                          itemBuilder: (_, index) {
                            final record = filteredRecords[index];
                            final realIndex = records.indexOf(record);
                            final overdue = _isOverdue(record);

                            return Card(
                              margin: const EdgeInsets.only(bottom: 10),
                              child: ListTile(
                                onTap: () => _showDetails(record),
                                leading: CircleAvatar(
                                  backgroundColor:
                                      overdue ? Colors.red : primaryGreen,
                                  foregroundColor: Colors.white,
                                  child: const Icon(Icons.height),
                                ),
                                title: Text(
                                  record['permitNo']?.toString().isNotEmpty ==
                                          true
                                      ? record['permitNo'].toString()
                                      : 'Permit',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  '${record['workType'] ?? ''} • ${record['location'] ?? ''}\n'
                                  '${record['status'] ?? ''}'
                                  '${overdue ? ' • OVERDUE' : ''}',
                                ),
                                isThreeLine: true,
                                trailing: PopupMenuButton<String>(
                                  onSelected: (value) {
                                    if (value == 'edit') {
                                      _openForm(
                                        existing: record,
                                        index: realIndex,
                                      );
                                    } else if (value == 'delete') {
                                      _deleteRecord(realIndex);
                                    } else {
                                      _showDetails(record);
                                    }
                                  },
                                  itemBuilder: (_) => const [
                                    PopupMenuItem(
                                      value: 'details',
                                      child: Text('Details'),
                                    ),
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
    );
  }
}

class _Dashboard extends StatelessWidget {
  final int total;
  final int pending;
  final int active;
  final int overdue;

  const _Dashboard({
    required this.total,
    required this.pending,
    required this.active,
    required this.overdue,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          _Tile(label: 'Total', value: total, icon: Icons.assignment),
          _Tile(label: 'Pending', value: pending, icon: Icons.pending_actions),
          _Tile(label: 'Active', value: active, icon: Icons.play_circle),
          _Tile(label: 'Overdue', value: overdue, icon: Icons.warning),
        ],
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  final String label;
  final int value;
  final IconData icon;

  const _Tile({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 112,
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black12),
      ),
      child: Column(
        children: [
          Icon(icon),
          const SizedBox(height: 4),
          Text(
            '$value',
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(label),
        ],
      ),
    );
  }
}

class _WorkAtHeightForm extends StatefulWidget {
  final Map<String, dynamic>? existing;
  final List<String> statuses;
  final List<String> workTypes;
  final List<String> accessMethods;

  const _WorkAtHeightForm({
    required this.existing,
    required this.statuses,
    required this.workTypes,
    required this.accessMethods,
  });

  @override
  State<_WorkAtHeightForm> createState() => _WorkAtHeightFormState();
}

class _WorkAtHeightFormState extends State<_WorkAtHeightForm> {
  static const Color primaryGreen = Color(0xFF159447);

  final formKey = GlobalKey<FormState>();
  final controllers = <String, TextEditingController>{};

  late String workType;
  late String accessMethod;
  late String status;

  bool scaffoldInspectionRequired = true;
  bool harnessRequired = true;
  bool lifelineRequired = true;
  bool anchorageRequired = true;
  bool edgeProtectionRequired = true;
  bool safetyNetRequired = false;
  bool droppedObjectControlRequired = true;
  bool weatherCheckRequired = true;
  bool rescuePlanRequired = true;
  bool exclusionZoneRequired = true;
  bool toolTetheringRequired = true;
  bool isolationRequired = false;

  @override
  void initState() {
    super.initState();

    const fields = [
      'permitNo',
      'project',
      'location',
      'department',
      'activity',
      'workDescription',
      'riskAssessmentRef',
      'jsaJhaRef',
      'ramsRef',
      'responsiblePerson',
      'competentPerson',
      'workers',
      'equipmentDetails',
      'workingHeight',
      'platformHeight',
      'scaffoldDetails',
      'ladderDetails',
      'mewpDetails',
      'anchorDetails',
      'lifelineDetails',
      'edgeProtectionDetails',
      'safetyNetDetails',
      'droppedObjectDetails',
      'exclusionZoneDetails',
      'weatherDetails',
      'rescueDetails',
      'isolationDetails',
      'permitConditions',
      'requiredPpe',
      'emergencyContacts',
      'supportingDocuments',
      'approvedBy',
      'approvalDate',
      'issueDate',
      'workStart',
      'workEnd',
      'suspensionDate',
      'extensionDate',
      'closureDate',
      'closedBy',
      'approvalComments',
      'closureComments',
      'remarks',
    ];

    for (final field in fields) {
      controllers[field] = TextEditingController(
        text: widget.existing?[field]?.toString() ?? '',
      );
    }

    workType =
        widget.existing?['workType']?.toString() ?? widget.workTypes.first;
    accessMethod = widget.existing?['accessMethod']?.toString() ??
        widget.accessMethods.first;
    status = widget.existing?['status']?.toString() ?? 'Draft';

    scaffoldInspectionRequired =
        widget.existing?['scaffoldInspectionRequired']?.toString() != 'false';
    harnessRequired =
        widget.existing?['harnessRequired']?.toString() != 'false';
    lifelineRequired =
        widget.existing?['lifelineRequired']?.toString() != 'false';
    anchorageRequired =
        widget.existing?['anchorageRequired']?.toString() != 'false';
    edgeProtectionRequired =
        widget.existing?['edgeProtectionRequired']?.toString() != 'false';
    safetyNetRequired =
        widget.existing?['safetyNetRequired']?.toString() == 'true';
    droppedObjectControlRequired =
        widget.existing?['droppedObjectControlRequired']?.toString() !=
            'false';
    weatherCheckRequired =
        widget.existing?['weatherCheckRequired']?.toString() != 'false';
    rescuePlanRequired =
        widget.existing?['rescuePlanRequired']?.toString() != 'false';
    exclusionZoneRequired =
        widget.existing?['exclusionZoneRequired']?.toString() != 'false';
    toolTetheringRequired =
        widget.existing?['toolTetheringRequired']?.toString() != 'false';
    isolationRequired =
        widget.existing?['isolationRequired']?.toString() == 'true';
  }

  @override
  void dispose() {
    for (final controller in controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  String _text(String name) => controllers[name]!.text.trim();

  Future<String?> _pickDateTime(String current) async {
    final initial = DateTime.tryParse(current) ?? DateTime.now();

    final date = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (date == null || !mounted) return null;

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(initial),
    );
    if (time == null) return null;

    return DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    ).toIso8601String();
  }

  Widget _field(
    String name,
    String label, {
    int maxLines = 1,
    bool required = false,
    TextInputType? keyboardType,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: controllers[name],
        maxLines: maxLines,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: required ? '$label *' : label,
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
      ),
    );
  }

  Widget _dateField(
    String name,
    String label, {
    bool required = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: controllers[name],
        readOnly: true,
        decoration: InputDecoration(
          labelText: required ? '$label *' : label,
          border: const OutlineInputBorder(),
          suffixIcon: const Icon(Icons.calendar_month),
        ),
        onTap: () async {
          final value = await _pickDateTime(controllers[name]!.text);
          if (value != null) {
            setState(() => controllers[name]!.text = value);
          }
        },
        validator: required
            ? (value) {
                if (value == null || value.trim().isEmpty) {
                  return '$label is required';
                }
                return null;
              }
            : null,
      ),
    );
  }

  Widget _dropdown(
    String label,
    String value,
    List<String> values,
    ValueChanged<String?> onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: DropdownButtonFormField<String>(
        initialValue: value,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        items: values
            .map(
              (item) => DropdownMenuItem(
                value: item,
                child: Text(
                  item,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            )
            .toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _switch(
    String title,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return SwitchListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title),
      value: value,
      activeThumbColor: primaryGreen,
      onChanged: onChanged,
    );
  }

  void _error(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  bool _validateBusinessRules() {
    final start = DateTime.tryParse(_text('workStart'));
    final end = DateTime.tryParse(_text('workEnd'));

    if (start != null && end != null && !end.isAfter(start)) {
      _error('Work End must be after Work Start.');
      return false;
    }

    if (['Under Review', 'Approved', 'Issued', 'Active'].contains(status) &&
        _text('competentPerson').isEmpty) {
      _error('Competent Person is required for this status.');
      return false;
    }

    if (['Approved', 'Issued', 'Active'].contains(status) &&
        _text('approvedBy').isEmpty) {
      _error('Approved By is required.');
      return false;
    }

    if (['Issued', 'Active'].contains(status)) {
      if (_text('approvalDate').isEmpty ||
          _text('issueDate').isEmpty ||
          _text('workStart').isEmpty ||
          _text('workEnd').isEmpty) {
        _error(
          'Approval Date, Issue Date, Work Start and Work End are required.',
        );
        return false;
      }
    }

    if (status == 'Suspended' && _text('suspensionDate').isEmpty) {
      _error('Suspension Date is required.');
      return false;
    }

    if (status == 'Extended / Revalidated' &&
        _text('extensionDate').isEmpty) {
      _error('Extension / Revalidation Date is required.');
      return false;
    }

    if (status == 'Closed') {
      if (_text('closedBy').isEmpty || _text('closureDate').isEmpty) {
        _error('Closed By and Closure Date are required.');
        return false;
      }
    }

    if (scaffoldInspectionRequired &&
        (accessMethod.contains('Scaffold') &&
            _text('scaffoldDetails').isEmpty)) {
      _error('Scaffold inspection/details are required.');
      return false;
    }

    if (harnessRequired && _text('requiredPpe').isEmpty) {
      _error('Required PPE including fall protection is required.');
      return false;
    }

    if (lifelineRequired && _text('lifelineDetails').isEmpty) {
      _error('Lifeline details are required.');
      return false;
    }

    if (anchorageRequired && _text('anchorDetails').isEmpty) {
      _error('Anchorage details are required.');
      return false;
    }

    if (edgeProtectionRequired && _text('edgeProtectionDetails').isEmpty) {
      _error('Edge protection details are required.');
      return false;
    }

    if (droppedObjectControlRequired &&
        _text('droppedObjectDetails').isEmpty) {
      _error('Dropped-object control details are required.');
      return false;
    }

    if (exclusionZoneRequired && _text('exclusionZoneDetails').isEmpty) {
      _error('Exclusion-zone details are required.');
      return false;
    }

    if (weatherCheckRequired && _text('weatherDetails').isEmpty) {
      _error('Weather / wind condition details are required.');
      return false;
    }

    if (rescuePlanRequired && _text('rescueDetails').isEmpty) {
      _error('Height-rescue plan/details are required.');
      return false;
    }

    if (isolationRequired && _text('isolationDetails').isEmpty) {
      _error('Isolation / LOTO details are required.');
      return false;
    }

    return true;
  }

  void _submit() {
    FocusScope.of(context).unfocus();

    if (!formKey.currentState!.validate()) return;
    if (!_validateBusinessRules()) return;

    final record = <String, dynamic>{
      'permitNo': _text('permitNo'),
      'project': _text('project'),
      'location': _text('location'),
      'department': _text('department'),
      'workType': workType,
      'accessMethod': accessMethod,
      'activity': _text('activity'),
      'workDescription': _text('workDescription'),
      'riskAssessmentRef': _text('riskAssessmentRef'),
      'jsaJhaRef': _text('jsaJhaRef'),
      'ramsRef': _text('ramsRef'),
      'responsiblePerson': _text('responsiblePerson'),
      'competentPerson': _text('competentPerson'),
      'workers': _text('workers'),
      'equipmentDetails': _text('equipmentDetails'),
      'workingHeight': _text('workingHeight'),
      'platformHeight': _text('platformHeight'),
      'scaffoldDetails': _text('scaffoldDetails'),
      'ladderDetails': _text('ladderDetails'),
      'mewpDetails': _text('mewpDetails'),
      'anchorDetails': _text('anchorDetails'),
      'lifelineDetails': _text('lifelineDetails'),
      'edgeProtectionDetails': _text('edgeProtectionDetails'),
      'safetyNetDetails': _text('safetyNetDetails'),
      'droppedObjectDetails': _text('droppedObjectDetails'),
      'exclusionZoneDetails': _text('exclusionZoneDetails'),
      'weatherDetails': _text('weatherDetails'),
      'rescueDetails': _text('rescueDetails'),
      'isolationDetails': _text('isolationDetails'),
      'permitConditions': _text('permitConditions'),
      'requiredPpe': _text('requiredPpe'),
      'emergencyContacts': _text('emergencyContacts'),
      'supportingDocuments': _text('supportingDocuments'),
      'approvedBy': _text('approvedBy'),
      'approvalDate': _text('approvalDate'),
      'issueDate': _text('issueDate'),
      'workStart': _text('workStart'),
      'workEnd': _text('workEnd'),
      'suspensionDate': _text('suspensionDate'),
      'extensionDate': _text('extensionDate'),
      'closureDate': _text('closureDate'),
      'closedBy': _text('closedBy'),
      'approvalComments': _text('approvalComments'),
      'closureComments': _text('closureComments'),
      'remarks': _text('remarks'),
      'scaffoldInspectionRequired': scaffoldInspectionRequired,
      'harnessRequired': harnessRequired,
      'lifelineRequired': lifelineRequired,
      'anchorageRequired': anchorageRequired,
      'edgeProtectionRequired': edgeProtectionRequired,
      'safetyNetRequired': safetyNetRequired,
      'droppedObjectControlRequired': droppedObjectControlRequired,
      'weatherCheckRequired': weatherCheckRequired,
      'rescuePlanRequired': rescuePlanRequired,
      'exclusionZoneRequired': exclusionZoneRequired,
      'toolTetheringRequired': toolTetheringRequired,
      'isolationRequired': isolationRequired,
      'status': status,
    };

    Navigator.pop(context, record);
  }

  Widget _section(
    String title,
    IconData icon,
    List<Widget> children,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: primaryGreen),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.grey.shade100,
      child: Padding(
        padding: EdgeInsets.only(
          top: 12,
          left: 12,
          right: 12,
          bottom: MediaQuery.viewInsetsOf(context).bottom + 12,
        ),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Container(
                width: 42,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Work at Height Permit',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              Expanded(
                child: ListView(
                  children: [
                    _section(
                      '1. Permit & Work Information',
                      Icons.assignment,
                      [
                        _field('permitNo', 'Permit No.', required: true),
                        _dropdown(
                          'Work at Height Type',
                          workType,
                          widget.workTypes,
                          (value) =>
                              setState(() => workType = value ?? workType),
                        ),
                        _dropdown(
                          'Access Method',
                          accessMethod,
                          widget.accessMethods,
                          (value) => setState(
                            () => accessMethod = value ?? accessMethod,
                          ),
                        ),
                        _field('project', 'Project', required: true),
                        _field('location', 'Location', required: true),
                        _field('department', 'Department'),
                        _field('activity', 'Activity / Work', required: true),
                        _field(
                          'workDescription',
                          'Work Description',
                          maxLines: 3,
                          required: true,
                        ),
                        _field(
                          'workingHeight',
                          'Working Height',
                          required: true,
                        ),
                        _field('platformHeight', 'Platform / Access Height'),
                      ],
                    ),
                    _section(
                      '2. Risk & Documents',
                      Icons.health_and_safety,
                      [
                        _field(
                          'riskAssessmentRef',
                          'HIRA / Risk Assessment Reference',
                          required: true,
                        ),
                        _field(
                          'jsaJhaRef',
                          'JSA / JHA Reference',
                          required: true,
                        ),
                        _field(
                          'ramsRef',
                          'RAMS / Method Statement Reference',
                          required: true,
                        ),
                        _field(
                          'supportingDocuments',
                          'Supporting Documents',
                          maxLines: 2,
                        ),
                      ],
                    ),
                    _section(
                      '3. Competency & Work Team',
                      Icons.groups,
                      [
                        _field(
                          'responsiblePerson',
                          'Responsible Person',
                          required: true,
                        ),
                        _field(
                          'competentPerson',
                          'Competent Person / Supervisor',
                          required: true,
                        ),
                        _field(
                          'workers',
                          'Authorized Workers',
                          maxLines: 3,
                          required: true,
                        ),
                        _field(
                          'equipmentDetails',
                          'Equipment / Access Equipment',
                          maxLines: 2,
                          required: true,
                        ),
                      ],
                    ),
                    _section(
                      '4. Fall Protection Controls',
                      Icons.security,
                      [
                        _switch(
                          'Scaffold Inspection Required',
                          scaffoldInspectionRequired,
                          (value) => setState(
                            () => scaffoldInspectionRequired = value,
                          ),
                        ),
                        if (accessMethod.contains('Scaffold'))
                          _field(
                            'scaffoldDetails',
                            'Scaffold Inspection / Tag / Details',
                            maxLines: 3,
                            required: true,
                          ),
                        if (accessMethod == 'Ladder')
                          _field(
                            'ladderDetails',
                            'Ladder Inspection / Positioning Details',
                            maxLines: 3,
                            required: true,
                          ),
                        if (accessMethod.contains('MEWP'))
                          _field(
                            'mewpDetails',
                            'MEWP / AWP Inspection & Operator Details',
                            maxLines: 3,
                            required: true,
                          ),
                        _switch(
                          'Full Body Harness Required',
                          harnessRequired,
                          (value) =>
                              setState(() => harnessRequired = value),
                        ),
                        _switch(
                          'Lifeline Required',
                          lifelineRequired,
                          (value) =>
                              setState(() => lifelineRequired = value),
                        ),
                        if (lifelineRequired)
                          _field(
                            'lifelineDetails',
                            'Lifeline / Fall-Arrest System Details',
                            maxLines: 3,
                            required: true,
                          ),
                        _switch(
                          'Approved Anchorage Required',
                          anchorageRequired,
                          (value) =>
                              setState(() => anchorageRequired = value),
                        ),
                        if (anchorageRequired)
                          _field(
                            'anchorDetails',
                            'Anchorage Point / System Details',
                            maxLines: 3,
                            required: true,
                          ),
                        _switch(
                          'Edge Protection Required',
                          edgeProtectionRequired,
                          (value) => setState(
                            () => edgeProtectionRequired = value,
                          ),
                        ),
                        if (edgeProtectionRequired)
                          _field(
                            'edgeProtectionDetails',
                            'Guardrails / Toe Boards / Edge Protection',
                            maxLines: 3,
                            required: true,
                          ),
                        _switch(
                          'Safety Net Required',
                          safetyNetRequired,
                          (value) =>
                              setState(() => safetyNetRequired = value),
                        ),
                        if (safetyNetRequired)
                          _field(
                            'safetyNetDetails',
                            'Safety Net Details',
                            maxLines: 2,
                            required: true,
                          ),
                      ],
                    ),
                    _section(
                      '5. Dropped Objects & Area Controls',
                      Icons.warning_amber,
                      [
                        _switch(
                          'Dropped Object Controls Required',
                          droppedObjectControlRequired,
                          (value) => setState(
                            () => droppedObjectControlRequired = value,
                          ),
                        ),
                        if (droppedObjectControlRequired)
                          _field(
                            'droppedObjectDetails',
                            'Dropped Object Prevention / Tool Tethering',
                            maxLines: 3,
                            required: true,
                          ),
                        _switch(
                          'Exclusion Zone Required',
                          exclusionZoneRequired,
                          (value) => setState(
                            () => exclusionZoneRequired = value,
                          ),
                        ),
                        if (exclusionZoneRequired)
                          _field(
                            'exclusionZoneDetails',
                            'Barricade / Exclusion Zone / Signage',
                            maxLines: 3,
                            required: true,
                          ),
                        _switch(
                          'Tool Tethering Required',
                          toolTetheringRequired,
                          (value) => setState(
                            () => toolTetheringRequired = value,
                          ),
                        ),
                      ],
                    ),
                    _section(
                      '6. Weather & Emergency Controls',
                      Icons.cloud,
                      [
                        _switch(
                          'Weather / Wind Check Required',
                          weatherCheckRequired,
                          (value) => setState(
                            () => weatherCheckRequired = value,
                          ),
                        ),
                        if (weatherCheckRequired)
                          _field(
                            'weatherDetails',
                            'Weather / Wind / Visibility Check',
                            maxLines: 3,
                            required: true,
                          ),
                        _switch(
                          'Rescue Plan Required',
                          rescuePlanRequired,
                          (value) =>
                              setState(() => rescuePlanRequired = value),
                        ),
                        if (rescuePlanRequired)
                          _field(
                            'rescueDetails',
                            'Height Rescue Plan / Equipment / Rescue Team',
                            maxLines: 4,
                            required: true,
                          ),
                        _field(
                          'emergencyContacts',
                          'Emergency Contacts',
                          maxLines: 2,
                          required: true,
                        ),
                      ],
                    ),
                    _section(
                      '7. Isolation, PPE & Conditions',
                      Icons.construction,
                      [
                        _switch(
                          'Isolation / LOTO Required',
                          isolationRequired,
                          (value) =>
                              setState(() => isolationRequired = value),
                        ),
                        if (isolationRequired)
                          _field(
                            'isolationDetails',
                            'Isolation / LOTO Details',
                            maxLines: 3,
                            required: true,
                          ),
                        _field(
                          'requiredPpe',
                          'Required PPE / Fall Protection PPE',
                          maxLines: 4,
                          required: true,
                        ),
                        _field(
                          'permitConditions',
                          'Permit Conditions / Special Precautions',
                          maxLines: 4,
                          required: true,
                        ),
                      ],
                    ),
                    _section(
                      '8. Approval, Issue & Closure',
                      Icons.verified,
                      [
                        _dropdown(
                          'Status',
                          status,
                          widget.statuses,
                          (value) => setState(
                            () => status = value ?? status,
                          ),
                        ),
                        _field('approvedBy', 'Approved By'),
                        _dateField('approvalDate', 'Approval Date'),
                        _dateField('issueDate', 'Permit Issue Date'),
                        _dateField('workStart', 'Work Start', required: true),
                        _dateField('workEnd', 'Work End', required: true),
                        _dateField('suspensionDate', 'Suspension Date'),
                        _dateField(
                          'extensionDate',
                          'Extension / Revalidation Date',
                        ),
                        _field(
                          'approvalComments',
                          'Approval Comments / Conditions',
                          maxLines: 3,
                        ),
                        _dateField('closureDate', 'Closure Date'),
                        _field('closedBy', 'Closed By'),
                        _field(
                          'closureComments',
                          'Completion / Closure Comments',
                          maxLines: 3,
                        ),
                        _field('remarks', 'Remarks', maxLines: 3),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                      child: FilledButton.icon(
                        style: FilledButton.styleFrom(
                          backgroundColor: primaryGreen,
                        ),
                        onPressed: _submit,
                        icon: const Icon(Icons.save),
                        label: Text(
                          widget.existing == null
                              ? 'Save Permit'
                              : 'Update Permit',
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DetailsSheet extends StatelessWidget {
  final Map<String, dynamic> record;

  const _DetailsSheet({required this.record});

  String _label(String key) {
    const labels = {
      'permitNo': 'Permit No.',
      'project': 'Project',
      'location': 'Location',
      'department': 'Department',
      'workType': 'Work Type',
      'accessMethod': 'Access Method',
      'activity': 'Activity',
      'workDescription': 'Work Description',
      'riskAssessmentRef': 'Risk Assessment Ref.',
      'jsaJhaRef': 'JSA / JHA Ref.',
      'ramsRef': 'RAMS Ref.',
      'responsiblePerson': 'Responsible Person',
      'competentPerson': 'Competent Person',
      'workers': 'Authorized Workers',
      'equipmentDetails': 'Equipment',
      'workingHeight': 'Working Height',
      'platformHeight': 'Platform Height',
      'scaffoldDetails': 'Scaffold Details',
      'ladderDetails': 'Ladder Details',
      'mewpDetails': 'MEWP Details',
      'anchorDetails': 'Anchorage',
      'lifelineDetails': 'Lifeline',
      'edgeProtectionDetails': 'Edge Protection',
      'safetyNetDetails': 'Safety Net',
      'droppedObjectDetails': 'Dropped Object Controls',
      'exclusionZoneDetails': 'Exclusion Zone',
      'weatherDetails': 'Weather / Wind',
      'rescueDetails': 'Rescue Plan',
      'isolationDetails': 'Isolation / LOTO',
      'permitConditions': 'Permit Conditions',
      'requiredPpe': 'Required PPE',
      'emergencyContacts': 'Emergency Contacts',
      'supportingDocuments': 'Supporting Documents',
      'approvedBy': 'Approved By',
      'approvalDate': 'Approval Date',
      'issueDate': 'Issue Date',
      'workStart': 'Work Start',
      'workEnd': 'Work End',
      'suspensionDate': 'Suspension Date',
      'extensionDate': 'Extension Date',
      'closureDate': 'Closure Date',
      'closedBy': 'Closed By',
      'approvalComments': 'Approval Comments',
      'closureComments': 'Closure Comments',
      'remarks': 'Remarks',
      'status': 'Status',
    };

    return labels[key] ?? key;
  }

  @override
  Widget build(BuildContext context) {
    final excluded = {
      'createdAt',
      'updatedAt',
      'scaffoldInspectionRequired',
      'harnessRequired',
      'lifelineRequired',
      'anchorageRequired',
      'edgeProtectionRequired',
      'safetyNetRequired',
      'droppedObjectControlRequired',
      'weatherCheckRequired',
      'rescuePlanRequired',
      'exclusionZoneRequired',
      'toolTetheringRequired',
      'isolationRequired',
    };

    final visible = record.entries.where((entry) {
      return !excluded.contains(entry.key) &&
          entry.value.toString().trim().isNotEmpty;
    }).toList();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Permit Details',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Flexible(
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: visible.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (_, index) {
                  final item = visible[index];
                  return ListTile(
                    dense: true,
                    title: Text(
                      _label(item.key),
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(item.value.toString()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
