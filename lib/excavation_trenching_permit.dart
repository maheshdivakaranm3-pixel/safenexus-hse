import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExcavationTrenchingPermitPage extends StatefulWidget {
  const ExcavationTrenchingPermitPage({super.key});

  @override
  State<ExcavationTrenchingPermitPage> createState() =>
      _ExcavationTrenchingPermitPageState();
}

class _ExcavationTrenchingPermitPageState
    extends State<ExcavationTrenchingPermitPage> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const String storageKey =
      'safenexus_hse_excavation_trenching_permits';

  final statuses = const [
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

  final excavationTypes = const [
    'Excavation',
    'Trenching',
    'Deep Excavation',
    'Shallow Excavation',
    'Manhole / Chamber Excavation',
    'Foundation Excavation',
    'Road / Pavement Cutting',
    'Utility Excavation',
    'Other',
  ];

  final methods = const [
    'Manual',
    'Mechanical Excavator',
    'Backhoe Loader',
    'Vacuum Excavation',
    'Hydro Excavation',
    'Combination',
    'Other',
  ];

  final soilTypes = const [
    'Stable / Rock',
    'Cohesive Soil',
    'Granular Soil',
    'Mixed Soil',
    'Made Ground / Fill',
    'Unknown / To Be Confirmed',
  ];

  List<Map<String, dynamic>> records = [];
  bool loading = true;
  String search = '';
  String statusFilter = 'All';
  String typeFilter = 'All';

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(storageKey) ?? [];
    setState(() {
      records = raw.map(_decode).toList();
      loading = false;
    });
  }

  Map<String, dynamic> _decode(String value) {
    final parts = value.split('\u001f');
    final result = <String, dynamic>{};
    for (var i = 0; i + 1 < parts.length; i += 2) {
      result[parts[i]] = parts[i + 1];
    }
    return result;
  }

  String _encode(Map<String, dynamic> record) {
    final parts = <String>[];
    record.forEach((key, value) {
      parts.add(key);
      parts.add(value?.toString() ?? '');
    });
    return parts.join('\u001f');
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      storageKey,
      records.map(_encode).toList(),
    );
  }

  List<Map<String, dynamic>> get filteredRecords {
    final q = search.trim().toLowerCase();
    return records.where((record) {
      final matchesSearch = q.isEmpty ||
          [
            record['permitNo'],
            record['project'],
            record['location'],
            record['activity'],
            record['excavationType'],
            record['responsiblePerson'],
            record['status'],
          ].join(' ').toLowerCase().contains(q);
      final matchesStatus =
          statusFilter == 'All' || record['status'] == statusFilter;
      final matchesType =
          typeFilter == 'All' || record['excavationType'] == typeFilter;
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
      builder: (_) => _ExcavationForm(
        existing: existing,
        statuses: statuses,
        excavationTypes: excavationTypes,
        methods: methods,
        soilTypes: soilTypes,
      ),
    );

    if (result == null) return;

    setState(() {
      if (index == null) {
        result['createdAt'] = DateTime.now().toIso8601String();
        result['updatedAt'] = result['createdAt'];
        records.insert(0, result);
      } else {
        result['createdAt'] =
            records[index]['createdAt'] ?? DateTime.now().toIso8601String();
        result['updatedAt'] = DateTime.now().toIso8601String();
        records[index] = result;
      }
    });

    await _save();
  }

  Future<void> _delete(int index) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete Permit'),
        content: const Text('Delete this excavation / trenching permit?'),
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
    await _save();
  }

  void _details(Map<String, dynamic> record) {
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
        title: const Text('Excavation / Trenching Permit'),
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
                              initialValue: typeFilter,
                              decoration: const InputDecoration(
                                labelText: 'Excavation Type',
                                border: OutlineInputBorder(),
                              ),
                              items: [
                                const DropdownMenuItem(
                                  value: 'All',
                                  child: Text('All'),
                                ),
                                ...excavationTypes.map(
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
                                () => typeFilter = value ?? 'All',
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
                            'No excavation / trenching permit records found.',
                          ),
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
                                onTap: () => _details(record),
                                leading: CircleAvatar(
                                  backgroundColor:
                                      overdue ? Colors.red : primaryGreen,
                                  foregroundColor: Colors.white,
                                  child: const Icon(Icons.construction),
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
                                  '${record['excavationType'] ?? ''} • '
                                  '${record['location'] ?? ''}\n'
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
                                      _delete(realIndex);
                                    } else {
                                      _details(record);
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

class _ExcavationForm extends StatefulWidget {
  final Map<String, dynamic>? existing;
  final List<String> statuses;
  final List<String> excavationTypes;
  final List<String> methods;
  final List<String> soilTypes;

  const _ExcavationForm({
    required this.existing,
    required this.statuses,
    required this.excavationTypes,
    required this.methods,
    required this.soilTypes,
  });

  @override
  State<_ExcavationForm> createState() => _ExcavationFormState();
}

class _ExcavationFormState extends State<_ExcavationForm> {
  static const Color primaryGreen = Color(0xFF159447);

  final formKey = GlobalKey<FormState>();
  final controllers = <String, TextEditingController>{};

  late String excavationType;
  late String method;
  late String soilType;
  late String status;

  bool utilityScanRequired = true;
  bool utilityScanCompleted = false;
  bool shoringRequired = true;
  bool benchingSlopingRequired = true;
  bool safeAccessRequired = true;
  bool barricadeRequired = true;
  bool spoilSetbackRequired = true;
  bool waterControlRequired = true;
  bool atmosphericTestRequired = false;
  bool trafficControlRequired = false;
  bool liftingNearExcavation = false;
  bool adjacentStructureCheckRequired = true;
  bool dailyInspectionRequired = true;
  bool isolationRequired = false;
  bool rescuePlanRequired = true;

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
      'excavationDimensions',
      'depth',
      'soilDetails',
      'utilityDetails',
      'utilityOwner',
      'shoringDetails',
      'benchingDetails',
      'accessDetails',
      'barricadeDetails',
      'spoilSetbackDetails',
      'waterControlDetails',
      'atmosphericDetails',
      'trafficControlDetails',
      'adjacentStructureDetails',
      'dailyInspectionDetails',
      'liftingDetails',
      'isolationDetails',
      'rescueDetails',
      'requiredPpe',
      'permitConditions',
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

    excavationType = widget.existing?['excavationType']?.toString() ??
        widget.excavationTypes.first;
    method = widget.existing?['method']?.toString() ?? widget.methods.first;
    soilType =
        widget.existing?['soilType']?.toString() ?? widget.soilTypes.first;
    status = widget.existing?['status']?.toString() ?? 'Draft';

    utilityScanRequired =
        widget.existing?['utilityScanRequired']?.toString() != 'false';
    utilityScanCompleted =
        widget.existing?['utilityScanCompleted']?.toString() == 'true';
    shoringRequired =
        widget.existing?['shoringRequired']?.toString() != 'false';
    benchingSlopingRequired =
        widget.existing?['benchingSlopingRequired']?.toString() != 'false';
    safeAccessRequired =
        widget.existing?['safeAccessRequired']?.toString() != 'false';
    barricadeRequired =
        widget.existing?['barricadeRequired']?.toString() != 'false';
    spoilSetbackRequired =
        widget.existing?['spoilSetbackRequired']?.toString() != 'false';
    waterControlRequired =
        widget.existing?['waterControlRequired']?.toString() != 'false';
    atmosphericTestRequired =
        widget.existing?['atmosphericTestRequired']?.toString() == 'true';
    trafficControlRequired =
        widget.existing?['trafficControlRequired']?.toString() == 'true';
    liftingNearExcavation =
        widget.existing?['liftingNearExcavation']?.toString() == 'true';
    adjacentStructureCheckRequired =
        widget.existing?['adjacentStructureCheckRequired']?.toString() !=
            'false';
    dailyInspectionRequired =
        widget.existing?['dailyInspectionRequired']?.toString() != 'false';
    isolationRequired =
        widget.existing?['isolationRequired']?.toString() == 'true';
    rescuePlanRequired =
        widget.existing?['rescuePlanRequired']?.toString() != 'false';
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

    if (utilityScanRequired && !utilityScanCompleted) {
      _error('Utility scan / underground service check must be completed.');
      return false;
    }

    if (shoringRequired && _text('shoringDetails').isEmpty) {
      _error('Shoring / protective system details are required.');
      return false;
    }

    if (benchingSlopingRequired && _text('benchingDetails').isEmpty) {
      _error('Benching / sloping details are required.');
      return false;
    }

    if (safeAccessRequired && _text('accessDetails').isEmpty) {
      _error('Safe access / egress details are required.');
      return false;
    }

    if (barricadeRequired && _text('barricadeDetails').isEmpty) {
      _error('Barricade / warning-sign details are required.');
      return false;
    }

    if (spoilSetbackRequired && _text('spoilSetbackDetails').isEmpty) {
      _error('Spoil / material setback controls are required.');
      return false;
    }

    if (waterControlRequired && _text('waterControlDetails').isEmpty) {
      _error('Water ingress / dewatering controls are required.');
      return false;
    }

    if (atmosphericTestRequired && _text('atmosphericDetails').isEmpty) {
      _error('Atmospheric testing details are required.');
      return false;
    }

    if (trafficControlRequired && _text('trafficControlDetails').isEmpty) {
      _error('Traffic-control details are required.');
      return false;
    }

    if (adjacentStructureCheckRequired &&
        _text('adjacentStructureDetails').isEmpty) {
      _error('Adjacent-structure assessment details are required.');
      return false;
    }

    if (dailyInspectionRequired &&
        _text('dailyInspectionDetails').isEmpty) {
      _error('Daily excavation inspection details are required.');
      return false;
    }

    if (liftingNearExcavation && _text('liftingDetails').isEmpty) {
      _error('Lifting-near-excavation control details are required.');
      return false;
    }

    if (isolationRequired && _text('isolationDetails').isEmpty) {
      _error('Isolation / LOTO details are required.');
      return false;
    }

    if (rescuePlanRequired && _text('rescueDetails').isEmpty) {
      _error('Excavation rescue plan/details are required.');
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

    if (status == 'Closed' &&
        (_text('closedBy').isEmpty || _text('closureDate').isEmpty)) {
      _error('Closed By and Closure Date are required.');
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
      'excavationType': excavationType,
      'method': method,
      'soilType': soilType,
      'activity': _text('activity'),
      'workDescription': _text('workDescription'),
      'riskAssessmentRef': _text('riskAssessmentRef'),
      'jsaJhaRef': _text('jsaJhaRef'),
      'ramsRef': _text('ramsRef'),
      'responsiblePerson': _text('responsiblePerson'),
      'competentPerson': _text('competentPerson'),
      'workers': _text('workers'),
      'equipmentDetails': _text('equipmentDetails'),
      'excavationDimensions': _text('excavationDimensions'),
      'depth': _text('depth'),
      'soilDetails': _text('soilDetails'),
      'utilityDetails': _text('utilityDetails'),
      'utilityOwner': _text('utilityOwner'),
      'shoringDetails': _text('shoringDetails'),
      'benchingDetails': _text('benchingDetails'),
      'accessDetails': _text('accessDetails'),
      'barricadeDetails': _text('barricadeDetails'),
      'spoilSetbackDetails': _text('spoilSetbackDetails'),
      'waterControlDetails': _text('waterControlDetails'),
      'atmosphericDetails': _text('atmosphericDetails'),
      'trafficControlDetails': _text('trafficControlDetails'),
      'adjacentStructureDetails': _text('adjacentStructureDetails'),
      'dailyInspectionDetails': _text('dailyInspectionDetails'),
      'liftingDetails': _text('liftingDetails'),
      'isolationDetails': _text('isolationDetails'),
      'rescueDetails': _text('rescueDetails'),
      'requiredPpe': _text('requiredPpe'),
      'permitConditions': _text('permitConditions'),
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
      'utilityScanRequired': utilityScanRequired,
      'utilityScanCompleted': utilityScanCompleted,
      'shoringRequired': shoringRequired,
      'benchingSlopingRequired': benchingSlopingRequired,
      'safeAccessRequired': safeAccessRequired,
      'barricadeRequired': barricadeRequired,
      'spoilSetbackRequired': spoilSetbackRequired,
      'waterControlRequired': waterControlRequired,
      'atmosphericTestRequired': atmosphericTestRequired,
      'trafficControlRequired': trafficControlRequired,
      'liftingNearExcavation': liftingNearExcavation,
      'adjacentStructureCheckRequired': adjacentStructureCheckRequired,
      'dailyInspectionRequired': dailyInspectionRequired,
      'isolationRequired': isolationRequired,
      'rescuePlanRequired': rescuePlanRequired,
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
                      'Excavation / Trenching Permit',
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
                          'Excavation Type',
                          excavationType,
                          widget.excavationTypes,
                          (value) => setState(
                            () => excavationType = value ?? excavationType,
                          ),
                        ),
                        _dropdown(
                          'Excavation Method',
                          method,
                          widget.methods,
                          (value) => setState(
                            () => method = value ?? method,
                          ),
                        ),
                        _dropdown(
                          'Soil Type',
                          soilType,
                          widget.soilTypes,
                          (value) => setState(
                            () => soilType = value ?? soilType,
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
                          'excavationDimensions',
                          'Excavation Dimensions (L × W × D)',
                          required: true,
                        ),
                        _field(
                          'depth',
                          'Maximum Excavation Depth',
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
                      '3. Competency, Team & Equipment',
                      Icons.groups,
                      [
                        _field(
                          'responsiblePerson',
                          'Responsible Person',
                          required: true,
                        ),
                        _field(
                          'competentPerson',
                          'Competent Person / Excavation Supervisor',
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
                          'Plant / Equipment',
                          maxLines: 3,
                          required: true,
                        ),
                      ],
                    ),
                    _section(
                      '4. Underground Services & Soil',
                      Icons.cable,
                      [
                        _switch(
                          'Underground Utility Scan / Service Check Required',
                          utilityScanRequired,
                          (value) => setState(
                            () => utilityScanRequired = value,
                          ),
                        ),
                        if (utilityScanRequired)
                          _switch(
                            'Utility Scan / Service Check Completed',
                            utilityScanCompleted,
                            (value) => setState(
                              () => utilityScanCompleted = value,
                            ),
                          ),
                        _field(
                          'utilityDetails',
                          'Underground Services / Utility Details',
                          maxLines: 3,
                          required: true,
                        ),
                        _field(
                          'utilityOwner',
                          'Utility Owner / Authority',
                        ),
                        _field(
                          'soilDetails',
                          'Soil Investigation / Ground Condition Details',
                          maxLines: 3,
                          required: true,
                        ),
                      ],
                    ),
                    _section(
                      '5. Excavation Protection & Access',
                      Icons.security,
                      [
                        _switch(
                          'Shoring / Protective System Required',
                          shoringRequired,
                          (value) =>
                              setState(() => shoringRequired = value),
                        ),
                        if (shoringRequired)
                          _field(
                            'shoringDetails',
                            'Shoring / Protective System Details',
                            maxLines: 3,
                            required: true,
                          ),
                        _switch(
                          'Benching / Sloping Required',
                          benchingSlopingRequired,
                          (value) => setState(
                            () => benchingSlopingRequired = value,
                          ),
                        ),
                        if (benchingSlopingRequired)
                          _field(
                            'benchingDetails',
                            'Benching / Sloping / Angle Details',
                            maxLines: 3,
                            required: true,
                          ),
                        _switch(
                          'Safe Access / Egress Required',
                          safeAccessRequired,
                          (value) => setState(
                            () => safeAccessRequired = value,
                          ),
                        ),
                        if (safeAccessRequired)
                          _field(
                            'accessDetails',
                            'Access / Egress Arrangement',
                            maxLines: 3,
                            required: true,
                          ),
                        _switch(
                          'Barricade / Warning Sign Required',
                          barricadeRequired,
                          (value) =>
                              setState(() => barricadeRequired = value),
                        ),
                        if (barricadeRequired)
                          _field(
                            'barricadeDetails',
                            'Barricade / Signage / Edge Protection',
                            maxLines: 3,
                            required: true,
                          ),
                      ],
                    ),
                    _section(
                      '6. Spoil, Water, Structures & Traffic',
                      Icons.warning_amber,
                      [
                        _switch(
                          'Spoil / Material Setback Control Required',
                          spoilSetbackRequired,
                          (value) => setState(
                            () => spoilSetbackRequired = value,
                          ),
                        ),
                        if (spoilSetbackRequired)
                          _field(
                            'spoilSetbackDetails',
                            'Spoil / Material Setback Arrangement',
                            maxLines: 3,
                            required: true,
                          ),
                        _switch(
                          'Water / Dewatering Control Required',
                          waterControlRequired,
                          (value) => setState(
                            () => waterControlRequired = value,
                          ),
                        ),
                        if (waterControlRequired)
                          _field(
                            'waterControlDetails',
                            'Dewatering / Water Ingress Controls',
                            maxLines: 3,
                            required: true,
                          ),
                        _switch(
                          'Adjacent Structure Check Required',
                          adjacentStructureCheckRequired,
                          (value) => setState(
                            () => adjacentStructureCheckRequired = value,
                          ),
                        ),
                        if (adjacentStructureCheckRequired)
                          _field(
                            'adjacentStructureDetails',
                            'Adjacent Building / Road / Structure Assessment',
                            maxLines: 3,
                            required: true,
                          ),
                        _switch(
                          'Traffic Control Required',
                          trafficControlRequired,
                          (value) => setState(
                            () => trafficControlRequired = value,
                          ),
                        ),
                        if (trafficControlRequired)
                          _field(
                            'trafficControlDetails',
                            'Traffic Management / Plant Movement Controls',
                            maxLines: 3,
                            required: true,
                          ),
                      ],
                    ),
                    _section(
                      '7. Inspection, Atmosphere & Special Controls',
                      Icons.fact_check,
                      [
                        _switch(
                          'Daily Excavation Inspection Required',
                          dailyInspectionRequired,
                          (value) => setState(
                            () => dailyInspectionRequired = value,
                          ),
                        ),
                        if (dailyInspectionRequired)
                          _field(
                            'dailyInspectionDetails',
                            'Daily Inspection / Competent Person Check',
                            maxLines: 3,
                            required: true,
                          ),
                        _switch(
                          'Atmospheric Testing Required',
                          atmosphericTestRequired,
                          (value) => setState(
                            () => atmosphericTestRequired = value,
                          ),
                        ),
                        if (atmosphericTestRequired)
                          _field(
                            'atmosphericDetails',
                            'Atmospheric Test / Gas Monitoring Details',
                            maxLines: 3,
                            required: true,
                          ),
                        _switch(
                          'Lifting Near Excavation',
                          liftingNearExcavation,
                          (value) => setState(
                            () => liftingNearExcavation = value,
                          ),
                        ),
                        if (liftingNearExcavation)
                          _field(
                            'liftingDetails',
                            'Lifting / Crane Near Excavation Controls',
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
                      ],
                    ),
                    _section(
                      '8. Rescue, PPE & Permit Conditions',
                      Icons.emergency,
                      [
                        _switch(
                          'Excavation Rescue Plan Required',
                          rescuePlanRequired,
                          (value) =>
                              setState(() => rescuePlanRequired = value),
                        ),
                        if (rescuePlanRequired)
                          _field(
                            'rescueDetails',
                            'Rescue / Emergency Response Plan',
                            maxLines: 4,
                            required: true,
                          ),
                        _field(
                          'requiredPpe',
                          'Required PPE',
                          maxLines: 4,
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
                      '9. Approval, Issue & Closure',
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
      'excavationType': 'Excavation Type',
      'method': 'Excavation Method',
      'soilType': 'Soil Type',
      'activity': 'Activity',
      'workDescription': 'Work Description',
      'riskAssessmentRef': 'Risk Assessment Ref.',
      'jsaJhaRef': 'JSA / JHA Ref.',
      'ramsRef': 'RAMS Ref.',
      'responsiblePerson': 'Responsible Person',
      'competentPerson': 'Competent Person',
      'workers': 'Workers',
      'equipmentDetails': 'Equipment',
      'excavationDimensions': 'Dimensions',
      'depth': 'Maximum Depth',
      'soilDetails': 'Soil Details',
      'utilityDetails': 'Utility Details',
      'utilityOwner': 'Utility Owner',
      'shoringDetails': 'Shoring',
      'benchingDetails': 'Benching / Sloping',
      'accessDetails': 'Access / Egress',
      'barricadeDetails': 'Barricade / Signage',
      'spoilSetbackDetails': 'Spoil Setback',
      'waterControlDetails': 'Water / Dewatering',
      'atmosphericDetails': 'Atmospheric Testing',
      'trafficControlDetails': 'Traffic Control',
      'adjacentStructureDetails': 'Adjacent Structures',
      'dailyInspectionDetails': 'Daily Inspection',
      'liftingDetails': 'Lifting Near Excavation',
      'isolationDetails': 'Isolation / LOTO',
      'rescueDetails': 'Rescue Plan',
      'requiredPpe': 'Required PPE',
      'permitConditions': 'Permit Conditions',
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
    const excluded = {
      'createdAt',
      'updatedAt',
      'utilityScanRequired',
      'utilityScanCompleted',
      'shoringRequired',
      'benchingSlopingRequired',
      'safeAccessRequired',
      'barricadeRequired',
      'spoilSetbackRequired',
      'waterControlRequired',
      'atmosphericTestRequired',
      'trafficControlRequired',
      'liftingNearExcavation',
      'adjacentStructureCheckRequired',
      'dailyInspectionRequired',
      'isolationRequired',
      'rescuePlanRequired',
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
