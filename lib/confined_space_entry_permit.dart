import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfinedSpaceEntryPermitPage extends StatefulWidget {
  const ConfinedSpaceEntryPermitPage({super.key});

  @override
  State<ConfinedSpaceEntryPermitPage> createState() =>
      _ConfinedSpaceEntryPermitPageState();
}

class _ConfinedSpaceEntryPermitPageState
    extends State<ConfinedSpaceEntryPermitPage> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const String storageKey =
      'safenexus_hse_confined_space_entry_permits';

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

  final List<String> permitTypes = const [
    'Confined Space Entry Permit',
    'Confined Space Entry + Hot Work',
    'Confined Space Entry + Electrical',
    'Confined Space Entry + Excavation',
    'Other',
  ];

  final List<String> entryTypes = const [
    'Manhole',
    'Tank / Vessel',
    'Sump / Pit',
    'Sewer / Drain',
    'Chamber',
    'Trench / Excavation',
    'Duct / Tunnel',
    'Other',
  ];

  List<Map<String, dynamic>> records = [];
  String search = '';
  String statusFilter = 'All';
  String permitTypeFilter = 'All';
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
            record['entryType'],
            record['entrantSupervisor'],
            record['status'],
          ].join(' ').toLowerCase().contains(query);

      final matchesStatus =
          statusFilter == 'All' || record['status'] == statusFilter;
      final matchesType = permitTypeFilter == 'All' ||
          record['permitType'] == permitTypeFilter;
      return matchesSearch && matchesStatus && matchesType;
    }).toList();
  }

  int _count(String status) =>
      records.where((r) => r['status'] == status).length;

  bool _isOverdue(Map<String, dynamic> record) {
    final end = DateTime.tryParse(record['workEnd'] ?? '');
    if (end == null) return false;
    final status = record['status']?.toString() ?? '';
    return end.isBefore(DateTime.now()) &&
        !['Closed', 'Cancelled'].contains(status);
  }

  int get overdueCount => records.where(_isOverdue).length;

  Future<void> _openForm({Map<String, dynamic>? existing, int? index}) async {
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _ConfinedSpacePermitForm(
        existing: existing,
        statuses: statuses,
        permitTypes: permitTypes,
        entryTypes: entryTypes,
      ),
    );

    if (result == null) return;
    setState(() {
      if (index != null) {
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
        content: const Text('Delete this confined space permit record?'),
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
    final active = _count('Active') + _count('Issued');
    final pending = _count('Requested') +
        _count('Under Review') +
        _count('Changes Required') +
        _count('Closure Pending');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Confined Space Entry Permit'),
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
                              initialValue: permitTypeFilter,
                              decoration: const InputDecoration(
                                labelText: 'Permit Type',
                                border: OutlineInputBorder(),
                              ),
                              items: [
                                const DropdownMenuItem(
                                  value: 'All',
                                  child: Text('All'),
                                ),
                                ...permitTypes.map(
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
                                () => permitTypeFilter = value ?? 'All',
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
                          child: Text('No confined space permit records found.'),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.fromLTRB(12, 0, 12, 90),
                          itemCount: filteredRecords.length,
                          itemBuilder: (_, i) {
                            final record = filteredRecords[i];
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
                                  child: const Icon(Icons.meeting_room),
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
                                  '${record['entryType'] ?? ''} • ${record['location'] ?? ''}\n'
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
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Text(label),
        ],
      ),
    );
  }
}

class _ConfinedSpacePermitForm extends StatefulWidget {
  final Map<String, dynamic>? existing;
  final List<String> statuses;
  final List<String> permitTypes;
  final List<String> entryTypes;

  const _ConfinedSpacePermitForm({
    required this.existing,
    required this.statuses,
    required this.permitTypes,
    required this.entryTypes,
  });

  @override
  State<_ConfinedSpacePermitForm> createState() =>
      _ConfinedSpacePermitFormState();
}

class _ConfinedSpacePermitFormState
    extends State<_ConfinedSpacePermitForm> {
  static const Color primaryGreen = Color(0xFF159447);

  final formKey = GlobalKey<FormState>();
  final controllers = <String, TextEditingController>{};

  late String permitType;
  late String entryType;
  late String status;

  bool ventilationRequired = true;
  bool gasTestRequired = true;
  bool standbyPersonRequired = true;
  bool rescuePlanRequired = true;
  bool isolationRequired = false;
  bool communicationRequired = true;
  bool lightingRequired = true;
  bool continuousGasMonitoring = false;

  final gasTests = <String, TextEditingController>{};

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
      'entrySupervisor',
      'entrantSupervisor',
      'issuingAuthority',
      'hseReviewer',
      'entryTeam',
      'permitConditions',
      'requiredPpe',
      'isolationDetails',
      'ventilationDetails',
      'standbyDetails',
      'rescueDetails',
      'communicationDetails',
      'lightingDetails',
      'emergencyContacts',
      'supportingDocuments',
      'workStart',
      'workEnd',
      'approvalDate',
      'issueDate',
      'suspensionDate',
      'extensionDate',
      'closureDate',
      'approvedBy',
      'approvalComments',
      'closedBy',
      'closureComments',
      'remarks',
    ];
    for (final field in fields) {
      controllers[field] = TextEditingController(
        text: widget.existing?[field]?.toString() ?? '',
      );
    }

    permitType = widget.existing?['permitType']?.toString() ??
        widget.permitTypes.first;
    entryType =
        widget.existing?['entryType']?.toString() ?? widget.entryTypes.first;
    status = widget.existing?['status']?.toString() ?? 'Draft';

    ventilationRequired =
        widget.existing?['ventilationRequired']?.toString() != 'false';
    gasTestRequired =
        widget.existing?['gasTestRequired']?.toString() != 'false';
    standbyPersonRequired =
        widget.existing?['standbyPersonRequired']?.toString() != 'false';
    rescuePlanRequired =
        widget.existing?['rescuePlanRequired']?.toString() != 'false';
    isolationRequired =
        widget.existing?['isolationRequired']?.toString() == 'true';
    communicationRequired =
        widget.existing?['communicationRequired']?.toString() != 'false';
    lightingRequired =
        widget.existing?['lightingRequired']?.toString() != 'false';
    continuousGasMonitoring =
        widget.existing?['continuousGasMonitoring']?.toString() == 'true';

    for (final name in ['oxygen', 'lel', 'h2s', 'co', 'otherGas']) {
      gasTests[name] = TextEditingController(
        text: widget.existing?['gas_$name']?.toString() ?? '',
      );
    }
  }

  @override
  void dispose() {
    for (final controller in controllers.values) {
      controller.dispose();
    }
    for (final controller in gasTests.values) {
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

    final value = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
    return value.toIso8601String();
  }

  Widget _field(
    String name,
    String label, {
    int maxLines = 1,
    TextInputType? keyboardType,
    bool required = false,
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

  Widget _dateField(String name, String label, {bool required = false}) {
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

  bool _validateBusinessRules() {
    final start = DateTime.tryParse(_text('workStart'));
    final end = DateTime.tryParse(_text('workEnd'));
    if (start != null && end != null && !end.isAfter(start)) {
      _error('Work End must be after Work Start.');
      return false;
    }

    if (['Under Review', 'Approved', 'Issued', 'Active'].contains(status) &&
        _text('hseReviewer').isEmpty) {
      _error('HSE Reviewer is required for this status.');
      return false;
    }

    if (['Approved', 'Issued', 'Active'].contains(status) &&
        _text('approvedBy').isEmpty) {
      _error('Approved By is required.');
      return false;
    }

    if (['Issued', 'Active'].contains(status)) {
      if (_text('approvalDate').isEmpty) {
        _error('Approval Date is required before issue/active status.');
        return false;
      }
      if (_text('issueDate').isEmpty ||
          _text('workStart').isEmpty ||
          _text('workEnd').isEmpty) {
        _error('Issue Date, Work Start and Work End are required.');
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

    if (gasTestRequired) {
      if (gasTests['oxygen']!.text.trim().isEmpty ||
          gasTests['lel']!.text.trim().isEmpty) {
        _error('Oxygen and LEL gas-test readings are required.');
        return false;
      }
    }

    if (ventilationRequired && _text('ventilationDetails').isEmpty) {
      _error('Ventilation details are required.');
      return false;
    }

    if (standbyPersonRequired && _text('standbyDetails').isEmpty) {
      _error('Standby / attendant details are required.');
      return false;
    }

    if (rescuePlanRequired && _text('rescueDetails').isEmpty) {
      _error('Rescue plan / equipment details are required.');
      return false;
    }

    if (isolationRequired && _text('isolationDetails').isEmpty) {
      _error('Isolation / LOTO details are required.');
      return false;
    }

    if (communicationRequired && _text('communicationDetails').isEmpty) {
      _error('Communication details are required.');
      return false;
    }

    return true;
  }

  void _error(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
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
      'permitType': permitType,
      'entryType': entryType,
      'activity': _text('activity'),
      'workDescription': _text('workDescription'),
      'riskAssessmentRef': _text('riskAssessmentRef'),
      'jsaJhaRef': _text('jsaJhaRef'),
      'ramsRef': _text('ramsRef'),
      'entrySupervisor': _text('entrySupervisor'),
      'entrantSupervisor': _text('entrantSupervisor'),
      'issuingAuthority': _text('issuingAuthority'),
      'hseReviewer': _text('hseReviewer'),
      'entryTeam': _text('entryTeam'),
      'workStart': _text('workStart'),
      'workEnd': _text('workEnd'),
      'issueDate': _text('issueDate'),
      'approvalDate': _text('approvalDate'),
      'suspensionDate': _text('suspensionDate'),
      'extensionDate': _text('extensionDate'),
      'closureDate': _text('closureDate'),
      'permitConditions': _text('permitConditions'),
      'requiredPpe': _text('requiredPpe'),
      'isolationDetails': _text('isolationDetails'),
      'ventilationDetails': _text('ventilationDetails'),
      'standbyDetails': _text('standbyDetails'),
      'rescueDetails': _text('rescueDetails'),
      'communicationDetails': _text('communicationDetails'),
      'lightingDetails': _text('lightingDetails'),
      'emergencyContacts': _text('emergencyContacts'),
      'supportingDocuments': _text('supportingDocuments'),
      'approvedBy': _text('approvedBy'),
      'approvalComments': _text('approvalComments'),
      'closedBy': _text('closedBy'),
      'closureComments': _text('closureComments'),
      'remarks': _text('remarks'),
      'gas_oxygen': gasTests['oxygen']!.text.trim(),
      'gas_lel': gasTests['lel']!.text.trim(),
      'gas_h2s': gasTests['h2s']!.text.trim(),
      'gas_co': gasTests['co']!.text.trim(),
      'gas_otherGas': gasTests['otherGas']!.text.trim(),
      'ventilationRequired': ventilationRequired,
      'gasTestRequired': gasTestRequired,
      'standbyPersonRequired': standbyPersonRequired,
      'rescuePlanRequired': rescuePlanRequired,
      'isolationRequired': isolationRequired,
      'communicationRequired': communicationRequired,
      'lightingRequired': lightingRequired,
      'continuousGasMonitoring': continuousGasMonitoring,
      'status': status,
    };

    Navigator.pop(context, record);
  }

  Widget _section(String title, IconData icon, List<Widget> children) {
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
                      'Confined Space Entry Permit',
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
                          'Permit Type',
                          permitType,
                          widget.permitTypes,
                          (value) => setState(
                            () => permitType = value ?? permitType,
                          ),
                        ),
                        _dropdown(
                          'Entry Type',
                          entryType,
                          widget.entryTypes,
                          (value) =>
                              setState(() => entryType = value ?? entryType),
                        ),
                        _field('project', 'Project', required: true),
                        _field('location', 'Location / Confined Space', required: true),
                        _field('department', 'Department'),
                        _field('activity', 'Activity / Work', required: true),
                        _field(
                          'workDescription',
                          'Work Description',
                          maxLines: 3,
                          required: true,
                        ),
                      ],
                    ),
                    _section(
                      '2. Risk & Supporting Documents',
                      Icons.health_and_safety,
                      [
                        _field(
                          'riskAssessmentRef',
                          'HIRA / Risk Assessment Reference',
                          required: true,
                        ),
                        _field('jsaJhaRef', 'JSA / JHA Reference', required: true),
                        _field('ramsRef', 'RAMS / Method Statement Reference', required: true),
                        _field(
                          'supportingDocuments',
                          'Supporting Documents',
                          maxLines: 2,
                        ),
                      ],
                    ),
                    _section(
                      '3. Entry Team & Permit Authorities',
                      Icons.groups,
                      [
                        _field('entrySupervisor', 'Entry Supervisor', required: true),
                        _field(
                          'entrantSupervisor',
                          'Competent Entry Supervisor / Supervisor in Charge',
                          required: true,
                        ),
                        _field(
                          'entryTeam',
                          'Entrants / Authorized Workers',
                          maxLines: 3,
                          required: true,
                        ),
                        _field(
                          'issuingAuthority',
                          'Issuing Authority',
                          required: true,
                        ),
                        _field('hseReviewer', 'HSE Reviewer'),
                      ],
                    ),
                    _section(
                      '4. Work Schedule',
                      Icons.schedule,
                      [
                        _dateField('workStart', 'Work Start', required: true),
                        _dateField('workEnd', 'Work End', required: true),
                        _dateField('approvalDate', 'Approval Date'),
                        _dateField('issueDate', 'Permit Issue Date'),
                        _dateField('suspensionDate', 'Suspension Date'),
                        _dateField('extensionDate', 'Extension / Revalidation Date'),
                        _dateField('closureDate', 'Closure Date'),
                      ],
                    ),
                    _section(
                      '5. Atmospheric / Gas Testing',
                      Icons.air,
                      [
                        _switch(
                          'Gas Test Required',
                          gasTestRequired,
                          (value) => setState(() => gasTestRequired = value),
                        ),
                        _switch(
                          'Continuous Gas Monitoring',
                          continuousGasMonitoring,
                          (value) =>
                              setState(() => continuousGasMonitoring = value),
                        ),
                        if (gasTestRequired)
                          Row(
                            children: [
                              Expanded(
                                child: _field(
                                  'gas_oxygen',
                                  'O₂ %',
                                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                  required: true,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: _field(
                                  'gas_lel',
                                  'LEL %',
                                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                  required: true,
                                ),
                              ),
                            ],
                          ),
                        if (gasTestRequired)
                          Row(
                            children: [
                              Expanded(
                                child: _field(
                                  'gas_h2s',
                                  'H₂S ppm',
                                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: _field(
                                  'gas_co',
                                  'CO ppm',
                                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                ),
                              ),
                            ],
                          ),
                        if (gasTestRequired)
                          _field('gas_otherGas', 'Other Gas / Reading'),
                      ],
                    ),
                    _section(
                      '6. Critical Controls',
                      Icons.security,
                      [
                        _switch(
                          'Mechanical / Natural Ventilation Required',
                          ventilationRequired,
                          (value) =>
                              setState(() => ventilationRequired = value),
                        ),
                        if (ventilationRequired)
                          _field(
                            'ventilationDetails',
                            'Ventilation Arrangement / Equipment',
                            maxLines: 2,
                            required: true,
                          ),
                        _switch(
                          'Standby Person / Attendant Required',
                          standbyPersonRequired,
                          (value) => setState(
                            () => standbyPersonRequired = value,
                          ),
                        ),
                        if (standbyPersonRequired)
                          _field(
                            'standbyDetails',
                            'Standby Person / Attendant Details',
                            maxLines: 2,
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
                            'Rescue Plan / Equipment / Retrieval Arrangement',
                            maxLines: 3,
                            required: true,
                          ),
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
                        _switch(
                          'Communication System Required',
                          communicationRequired,
                          (value) => setState(
                            () => communicationRequired = value,
                          ),
                        ),
                        if (communicationRequired)
                          _field(
                            'communicationDetails',
                            'Communication Method / Backup',
                            maxLines: 2,
                            required: true,
                          ),
                        _switch(
                          'Adequate Lighting Required',
                          lightingRequired,
                          (value) => setState(() => lightingRequired = value),
                        ),
                        if (lightingRequired)
                          _field(
                            'lightingDetails',
                            'Lighting Arrangement',
                            maxLines: 2,
                          ),
                      ],
                    ),
                    _section(
                      '7. PPE, Emergency & Permit Conditions',
                      Icons.construction,
                      [
                        _field(
                          'requiredPpe',
                          'Required PPE',
                          maxLines: 3,
                          required: true,
                        ),
                        _field(
                          'emergencyContacts',
                          'Emergency Contacts / Rescue Team',
                          maxLines: 2,
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
                      '8. Approval & Closure',
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
                        _field(
                          'approvalComments',
                          'Approval Comments / Conditions',
                          maxLines: 3,
                        ),
                        _field('closedBy', 'Closed By'),
                        _field(
                          'closureComments',
                          'Closure / Area Re-check Comments',
                          maxLines: 3,
                        ),
                        _field('remarks', 'Remarks', maxLines: 3),
                      ],
                    ),
                    const SizedBox(height: 4),
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
      'permitType': 'Permit Type',
      'entryType': 'Entry Type',
      'project': 'Project',
      'location': 'Location',
      'department': 'Department',
      'activity': 'Activity',
      'workDescription': 'Work Description',
      'riskAssessmentRef': 'Risk Assessment Ref.',
      'jsaJhaRef': 'JSA / JHA Ref.',
      'ramsRef': 'RAMS Ref.',
      'entrySupervisor': 'Entry Supervisor',
      'entrantSupervisor': 'Entry Supervisor in Charge',
      'issuingAuthority': 'Issuing Authority',
      'hseReviewer': 'HSE Reviewer',
      'entryTeam': 'Entry Team',
      'workStart': 'Work Start',
      'workEnd': 'Work End',
      'approvalDate': 'Approval Date',
      'issueDate': 'Issue Date',
      'suspensionDate': 'Suspension Date',
      'extensionDate': 'Extension Date',
      'closureDate': 'Closure Date',
      'requiredPpe': 'Required PPE',
      'isolationDetails': 'Isolation / LOTO',
      'ventilationDetails': 'Ventilation',
      'standbyDetails': 'Standby / Attendant',
      'rescueDetails': 'Rescue Arrangement',
      'communicationDetails': 'Communication',
      'lightingDetails': 'Lighting',
      'emergencyContacts': 'Emergency Contacts',
      'permitConditions': 'Permit Conditions',
      'approvedBy': 'Approved By',
      'approvalComments': 'Approval Comments',
      'closedBy': 'Closed By',
      'closureComments': 'Closure Comments',
      'remarks': 'Remarks',
      'status': 'Status',
    };
    return labels[key] ?? key;
  }

  @override
  Widget build(BuildContext context) {
    final visible = record.entries.where((entry) {
      if (entry.key.startsWith('gas_')) return entry.value.toString().isNotEmpty;
      if (entry.key.endsWith('At')) return false;
      if ([
        'createdAt',
        'updatedAt',
        'ventilationRequired',
        'gasTestRequired',
        'standbyPersonRequired',
        'rescuePlanRequired',
        'isolationRequired',
        'communicationRequired',
        'lightingRequired',
        'continuousGasMonitoring',
      ].contains(entry.key)) {
        return false;
      }
      return entry.value.toString().trim().isNotEmpty;
    }).toList();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Permit Details',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                      style: const TextStyle(fontWeight: FontWeight.w600),
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
