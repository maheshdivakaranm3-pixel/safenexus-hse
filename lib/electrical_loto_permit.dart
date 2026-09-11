import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ElectricalLotoPermitPage extends StatefulWidget {
  const ElectricalLotoPermitPage({super.key});

  @override
  State<ElectricalLotoPermitPage> createState() =>
      _ElectricalLotoPermitPageState();
}

class _ElectricalLotoPermitPageState extends State<ElectricalLotoPermitPage> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const String storageKey =
      'safenexus_hse_electrical_loto_permits';

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

  final workTypes = const [
    'Electrical Installation',
    'Electrical Maintenance',
    'Testing / Commissioning',
    'Cable Installation / Termination',
    'Panel / Switchgear Work',
    'Electrical Isolation / LOTO',
    'Temporary Electrical Work',
    'Energization / De-energization',
    'Electrical Work + Hot Work',
    'Other',
  ];

  final voltageLevels = const [
    'Extra Low Voltage',
    'Low Voltage',
    'Medium Voltage',
    'High Voltage',
    'Not Applicable / Unknown',
  ];

  final isolationMethods = const [
    'Main Breaker / Disconnect',
    'Circuit Breaker',
    'Fuse Removal',
    'Switch Disconnector',
    'Physical Isolation',
    'Mechanical Isolation',
    'Multiple Isolation Points',
    'Other',
  ];

  List<Map<String, dynamic>> records = [];
  bool loading = true;
  String search = '';
  String statusFilter = 'All';
  String workTypeFilter = 'All';

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
            record['workType'],
            record['voltageLevel'],
            record['responsiblePerson'],
            record['status'],
          ].join(' ').toLowerCase().contains(q);
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
      builder: (_) => _ElectricalLotoForm(
        existing: existing,
        statuses: statuses,
        workTypes: workTypes,
        voltageLevels: voltageLevels,
        isolationMethods: isolationMethods,
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
        content: const Text('Delete this electrical / LOTO permit?'),
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
        title: const Text('Electrical / LOTO Permit'),
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
                          child: Text(
                            'No electrical / LOTO permit records found.',
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
                                  child: const Icon(Icons.electrical_services),
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
                                  '${record['workType'] ?? ''} • '
                                  '${record['voltageLevel'] ?? ''}\n'
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
          _Tile(label: 'Active', value: active, icon: Icons.power),
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

class _ElectricalLotoForm extends StatefulWidget {
  final Map<String, dynamic>? existing;
  final List<String> statuses;
  final List<String> workTypes;
  final List<String> voltageLevels;
  final List<String> isolationMethods;

  const _ElectricalLotoForm({
    required this.existing,
    required this.statuses,
    required this.workTypes,
    required this.voltageLevels,
    required this.isolationMethods,
  });

  @override
  State<_ElectricalLotoForm> createState() => _ElectricalLotoFormState();
}

class _ElectricalLotoFormState extends State<_ElectricalLotoForm> {
  static const Color primaryGreen = Color(0xFF159447);

  final formKey = GlobalKey<FormState>();
  final controllers = <String, TextEditingController>{};

  late String workType;
  late String voltageLevel;
  late String isolationMethod;
  late String status;

  bool deEnergizationRequired = true;
  bool isolationRequired = true;
  bool lockoutRequired = true;
  bool tagoutRequired = true;
  bool tryTestRequired = true;
  bool absenceOfVoltageRequired = true;
  bool groundingRequired = false;
  bool arcFlashAssessmentRequired = true;
  bool competentElectricianRequired = true;
  bool electricalInspectionRequired = true;
  bool barricadeRequired = true;
  bool warningSignRequired = true;
  bool emergencyRescueRequired = true;
  bool standbyRequired = false;

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
      'authorizedElectricians',
      'equipmentDetails',
      'electricalSystem',
      'equipmentId',
      'voltage',
      'isolationPoint',
      'isolationDetails',
      'lockoutDetails',
      'tagoutDetails',
      'tryTestDetails',
      'absenceVoltageDetails',
      'groundingDetails',
      'arcFlashDetails',
      'inspectionDetails',
      'barricadeDetails',
      'warningSignDetails',
      'emergencyRescueDetails',
      'standbyDetails',
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

    workType =
        widget.existing?['workType']?.toString() ?? widget.workTypes.first;
    voltageLevel = widget.existing?['voltageLevel']?.toString() ??
        widget.voltageLevels.first;
    isolationMethod = widget.existing?['isolationMethod']?.toString() ??
        widget.isolationMethods.first;
    status = widget.existing?['status']?.toString() ?? 'Draft';

    deEnergizationRequired =
        widget.existing?['deEnergizationRequired']?.toString() != 'false';
    isolationRequired =
        widget.existing?['isolationRequired']?.toString() != 'false';
    lockoutRequired =
        widget.existing?['lockoutRequired']?.toString() != 'false';
    tagoutRequired =
        widget.existing?['tagoutRequired']?.toString() != 'false';
    tryTestRequired =
        widget.existing?['tryTestRequired']?.toString() != 'false';
    absenceOfVoltageRequired =
        widget.existing?['absenceOfVoltageRequired']?.toString() != 'false';
    groundingRequired =
        widget.existing?['groundingRequired']?.toString() == 'true';
    arcFlashAssessmentRequired =
        widget.existing?['arcFlashAssessmentRequired']?.toString() != 'false';
    competentElectricianRequired =
        widget.existing?['competentElectricianRequired']?.toString() !=
            'false';
    electricalInspectionRequired =
        widget.existing?['electricalInspectionRequired']?.toString() != 'false';
    barricadeRequired =
        widget.existing?['barricadeRequired']?.toString() != 'false';
    warningSignRequired =
        widget.existing?['warningSignRequired']?.toString() != 'false';
    emergencyRescueRequired =
        widget.existing?['emergencyRescueRequired']?.toString() != 'false';
    standbyRequired =
        widget.existing?['standbyRequired']?.toString() == 'true';
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

    if (competentElectricianRequired &&
        _text('competentPerson').isEmpty) {
      _error('Competent Electrical Person is required.');
      return false;
    }

    if (isolationRequired && _text('isolationDetails').isEmpty) {
      _error('Isolation point and isolation details are required.');
      return false;
    }

    if (lockoutRequired && _text('lockoutDetails').isEmpty) {
      _error('Lockout details are required.');
      return false;
    }

    if (tagoutRequired && _text('tagoutDetails').isEmpty) {
      _error('Tagout details are required.');
      return false;
    }

    if (tryTestRequired && _text('tryTestDetails').isEmpty) {
      _error('Try / test verification details are required.');
      return false;
    }

    if (absenceOfVoltageRequired &&
        _text('absenceVoltageDetails').isEmpty) {
      _error('Absence-of-voltage verification details are required.');
      return false;
    }

    if (groundingRequired && _text('groundingDetails').isEmpty) {
      _error('Grounding / earthing details are required.');
      return false;
    }

    if (arcFlashAssessmentRequired && _text('arcFlashDetails').isEmpty) {
      _error('Arc-flash assessment / control details are required.');
      return false;
    }

    if (electricalInspectionRequired &&
        _text('inspectionDetails').isEmpty) {
      _error('Electrical inspection details are required.');
      return false;
    }

    if (barricadeRequired && _text('barricadeDetails').isEmpty) {
      _error('Barricade / exclusion-zone details are required.');
      return false;
    }

    if (warningSignRequired && _text('warningSignDetails').isEmpty) {
      _error('Electrical warning-sign details are required.');
      return false;
    }

    if (emergencyRescueRequired &&
        _text('emergencyRescueDetails').isEmpty) {
      _error('Electrical emergency / rescue arrangements are required.');
      return false;
    }

    if (standbyRequired && _text('standbyDetails').isEmpty) {
      _error('Standby person details are required.');
      return false;
    }

    if (deEnergizationRequired && _text('isolationPoint').isEmpty) {
      _error('De-energization / isolation point is required.');
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
      'workType': workType,
      'voltageLevel': voltageLevel,
      'isolationMethod': isolationMethod,
      'activity': _text('activity'),
      'workDescription': _text('workDescription'),
      'riskAssessmentRef': _text('riskAssessmentRef'),
      'jsaJhaRef': _text('jsaJhaRef'),
      'ramsRef': _text('ramsRef'),
      'responsiblePerson': _text('responsiblePerson'),
      'competentPerson': _text('competentPerson'),
      'authorizedElectricians': _text('authorizedElectricians'),
      'equipmentDetails': _text('equipmentDetails'),
      'electricalSystem': _text('electricalSystem'),
      'equipmentId': _text('equipmentId'),
      'voltage': _text('voltage'),
      'isolationPoint': _text('isolationPoint'),
      'isolationDetails': _text('isolationDetails'),
      'lockoutDetails': _text('lockoutDetails'),
      'tagoutDetails': _text('tagoutDetails'),
      'tryTestDetails': _text('tryTestDetails'),
      'absenceVoltageDetails': _text('absenceVoltageDetails'),
      'groundingDetails': _text('groundingDetails'),
      'arcFlashDetails': _text('arcFlashDetails'),
      'inspectionDetails': _text('inspectionDetails'),
      'barricadeDetails': _text('barricadeDetails'),
      'warningSignDetails': _text('warningSignDetails'),
      'emergencyRescueDetails': _text('emergencyRescueDetails'),
      'standbyDetails': _text('standbyDetails'),
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
      'hseReviewer': _text('hseReviewer'),
      'deEnergizationRequired': deEnergizationRequired,
      'isolationRequired': isolationRequired,
      'lockoutRequired': lockoutRequired,
      'tagoutRequired': tagoutRequired,
      'tryTestRequired': tryTestRequired,
      'absenceOfVoltageRequired': absenceOfVoltageRequired,
      'groundingRequired': groundingRequired,
      'arcFlashAssessmentRequired': arcFlashAssessmentRequired,
      'competentElectricianRequired': competentElectricianRequired,
      'electricalInspectionRequired': electricalInspectionRequired,
      'barricadeRequired': barricadeRequired,
      'warningSignRequired': warningSignRequired,
      'emergencyRescueRequired': emergencyRescueRequired,
      'standbyRequired': standbyRequired,
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
                      'Electrical / LOTO Permit',
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
                      '1. Permit & Electrical Work',
                      Icons.assignment,
                      [
                        _field('permitNo', 'Permit No.', required: true),
                        _dropdown(
                          'Electrical Work Type',
                          workType,
                          widget.workTypes,
                          (value) => setState(
                            () => workType = value ?? workType,
                          ),
                        ),
                        _dropdown(
                          'Voltage Level',
                          voltageLevel,
                          widget.voltageLevels,
                          (value) => setState(
                            () => voltageLevel = value ?? voltageLevel,
                          ),
                        ),
                        _dropdown(
                          'Isolation Method',
                          isolationMethod,
                          widget.isolationMethods,
                          (value) => setState(
                            () => isolationMethod = value ?? isolationMethod,
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
                          'electricalSystem',
                          'Electrical System / Circuit',
                          required: true,
                        ),
                        _field('equipmentId', 'Equipment / Panel ID'),
                        _field('voltage', 'Measured / Nominal Voltage'),
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
                      '3. Competency & Authorized Team',
                      Icons.groups,
                      [
                        _field(
                          'responsiblePerson',
                          'Responsible Person',
                          required: true,
                        ),
                        _field(
                          'competentPerson',
                          'Competent Electrical Person',
                          required: true,
                        ),
                        _field(
                          'authorizedElectricians',
                          'Authorized Electricians / Workers',
                          maxLines: 3,
                          required: true,
                        ),
                        _field(
                          'equipmentDetails',
                          'Test Equipment / Tools',
                          maxLines: 3,
                          required: true,
                        ),
                        _field('hseReviewer', 'HSE Reviewer'),
                      ],
                    ),
                    _section(
                      '4. Isolation & LOTO',
                      Icons.lock,
                      [
                        _switch(
                          'De-energization Required',
                          deEnergizationRequired,
                          (value) => setState(
                            () => deEnergizationRequired = value,
                          ),
                        ),
                        if (deEnergizationRequired)
                          _field(
                            'isolationPoint',
                            'Isolation Point / Source',
                            maxLines: 2,
                            required: true,
                          ),
                        _switch(
                          'Isolation Required',
                          isolationRequired,
                          (value) => setState(
                            () => isolationRequired = value,
                          ),
                        ),
                        if (isolationRequired)
                          _field(
                            'isolationDetails',
                            'Isolation Details',
                            maxLines: 3,
                            required: true,
                          ),
                        _switch(
                          'Lockout Required',
                          lockoutRequired,
                          (value) =>
                              setState(() => lockoutRequired = value),
                        ),
                        if (lockoutRequired)
                          _field(
                            'lockoutDetails',
                            'Lockout / Lock Details',
                            maxLines: 3,
                            required: true,
                          ),
                        _switch(
                          'Tagout Required',
                          tagoutRequired,
                          (value) => setState(() => tagoutRequired = value),
                        ),
                        if (tagoutRequired)
                          _field(
                            'tagoutDetails',
                            'Tagout / Warning Tag Details',
                            maxLines: 3,
                            required: true,
                          ),
                      ],
                    ),
                    _section(
                      '5. Zero-Energy Verification',
                      Icons.fact_check,
                      [
                        _switch(
                          'Try / Test Verification Required',
                          tryTestRequired,
                          (value) =>
                              setState(() => tryTestRequired = value),
                        ),
                        if (tryTestRequired)
                          _field(
                            'tryTestDetails',
                            'Try / Test Procedure & Result',
                            maxLines: 3,
                            required: true,
                          ),
                        _switch(
                          'Absence-of-Voltage Verification Required',
                          absenceOfVoltageRequired,
                          (value) => setState(
                            () => absenceOfVoltageRequired = value,
                          ),
                        ),
                        if (absenceOfVoltageRequired)
                          _field(
                            'absenceVoltageDetails',
                            'Voltage Tester / Absence-of-Voltage Verification',
                            maxLines: 3,
                            required: true,
                          ),
                        _switch(
                          'Grounding / Earthing Required',
                          groundingRequired,
                          (value) =>
                              setState(() => groundingRequired = value),
                        ),
                        if (groundingRequired)
                          _field(
                            'groundingDetails',
                            'Grounding / Earthing Details',
                            maxLines: 3,
                            required: true,
                          ),
                      ],
                    ),
                    _section(
                      '6. Electrical Safety Controls',
                      Icons.warning_amber,
                      [
                        _switch(
                          'Arc-Flash Assessment Required',
                          arcFlashAssessmentRequired,
                          (value) => setState(
                            () => arcFlashAssessmentRequired = value,
                          ),
                        ),
                        if (arcFlashAssessmentRequired)
                          _field(
                            'arcFlashDetails',
                            'Arc-Flash / Electrical Incident Energy Controls',
                            maxLines: 3,
                            required: true,
                          ),
                        _switch(
                          'Electrical Inspection Required',
                          electricalInspectionRequired,
                          (value) => setState(
                            () => electricalInspectionRequired = value,
                          ),
                        ),
                        if (electricalInspectionRequired)
                          _field(
                            'inspectionDetails',
                            'Electrical Inspection / Test Details',
                            maxLines: 3,
                            required: true,
                          ),
                        _switch(
                          'Barricade / Exclusion Zone Required',
                          barricadeRequired,
                          (value) =>
                              setState(() => barricadeRequired = value),
                        ),
                        if (barricadeRequired)
                          _field(
                            'barricadeDetails',
                            'Barricade / Exclusion Zone',
                            maxLines: 3,
                            required: true,
                          ),
                        _switch(
                          'Electrical Warning Signs Required',
                          warningSignRequired,
                          (value) =>
                              setState(() => warningSignRequired = value),
                        ),
                        if (warningSignRequired)
                          _field(
                            'warningSignDetails',
                            'Warning Signs / Tags',
                            maxLines: 2,
                            required: true,
                          ),
                      ],
                    ),
                    _section(
                      '7. Emergency, PPE & Permit Conditions',
                      Icons.emergency,
                      [
                        _switch(
                          'Emergency / Rescue Arrangement Required',
                          emergencyRescueRequired,
                          (value) => setState(
                            () => emergencyRescueRequired = value,
                          ),
                        ),
                        if (emergencyRescueRequired)
                          _field(
                            'emergencyRescueDetails',
                            'Electrical Emergency / Rescue Arrangement',
                            maxLines: 4,
                            required: true,
                          ),
                        _switch(
                          'Standby Person Required',
                          standbyRequired,
                          (value) =>
                              setState(() => standbyRequired = value),
                        ),
                        if (standbyRequired)
                          _field(
                            'standbyDetails',
                            'Standby Person Details',
                            maxLines: 2,
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
                          'Emergency Contacts',
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
                      '8. Approval, Issue & Closure',
                      Icons.verified,
                      [
                        _dropdown(
                          'Status',
                          status,
                          widget.statuses,
                          (value) =>
                              setState(() => status = value ?? status),
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
      'voltageLevel': 'Voltage Level',
      'isolationMethod': 'Isolation Method',
      'activity': 'Activity',
      'workDescription': 'Work Description',
      'riskAssessmentRef': 'Risk Assessment Ref.',
      'jsaJhaRef': 'JSA / JHA Ref.',
      'ramsRef': 'RAMS Ref.',
      'responsiblePerson': 'Responsible Person',
      'competentPerson': 'Competent Person',
      'authorizedElectricians': 'Authorized Workers',
      'equipmentDetails': 'Equipment / Tools',
      'electricalSystem': 'Electrical System',
      'equipmentId': 'Equipment ID',
      'voltage': 'Voltage',
      'isolationPoint': 'Isolation Point',
      'isolationDetails': 'Isolation Details',
      'lockoutDetails': 'Lockout',
      'tagoutDetails': 'Tagout',
      'tryTestDetails': 'Try / Test',
      'absenceVoltageDetails': 'Absence of Voltage',
      'groundingDetails': 'Grounding / Earthing',
      'arcFlashDetails': 'Arc-Flash Controls',
      'inspectionDetails': 'Electrical Inspection',
      'barricadeDetails': 'Barricade / Exclusion Zone',
      'warningSignDetails': 'Warning Signs',
      'emergencyRescueDetails': 'Emergency / Rescue',
      'standbyDetails': 'Standby Person',
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
      'hseReviewer',
      'deEnergizationRequired',
      'isolationRequired',
      'lockoutRequired',
      'tagoutRequired',
      'tryTestRequired',
      'absenceOfVoltageRequired',
      'groundingRequired',
      'arcFlashAssessmentRequired',
      'competentElectricianRequired',
      'electricalInspectionRequired',
      'barricadeRequired',
      'warningSignRequired',
      'emergencyRescueRequired',
      'standbyRequired',
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
