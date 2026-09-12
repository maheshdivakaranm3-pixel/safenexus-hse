import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PermitClosureHandoverPage extends StatefulWidget {
  const PermitClosureHandoverPage({super.key});

  @override
  State<PermitClosureHandoverPage> createState() =>
      _PermitClosureHandoverPageState();
}

class _PermitClosureHandoverPageState
    extends State<PermitClosureHandoverPage> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const String storageKey =
      'safenexus_hse_permit_closure_handover';

  final permitTypes = const [
    'General Work Permit',
    'Hot Work Permit',
    'Confined Space Entry Permit',
    'Work at Height Permit',
    'Excavation / Trenching Permit',
    'Electrical / LOTO Permit',
    'Lifting / Critical Lift Permit',
    'Line Breaking / Breaking Containment Permit',
    'Cold Work Permit',
    'Other',
  ];

  final statuses = const [
    'Draft',
    'Closure Requested',
    'Under HSE Verification',
    'Actions Required',
    'Ready for Closure',
    'Closed',
    'Rejected',
    'Cancelled',
  ];

  final handoverTypes = const [
    'Normal Work Completion',
    'Shift Handover',
    'Area Handover',
    'Equipment Handover',
    'Temporary Work Completion',
    'Emergency Closure',
    'Other',
  ];

  List<Map<String, dynamic>> records = [];
  bool loading = true;
  String search = '';
  String statusFilter = 'All';

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
    await prefs.setStringList(storageKey, records.map(_encode).toList());
  }

  List<Map<String, dynamic>> get filteredRecords {
    final q = search.trim().toLowerCase();
    return records.where((record) {
      final matchesSearch = q.isEmpty ||
          [
            record['closureNo'],
            record['permitNo'],
            record['project'],
            record['location'],
            record['department'],
            record['activity'],
            record['permitType'],
            record['status'],
            record['permitHolder'],
            record['hseVerifier'],
          ].join(' ').toLowerCase().contains(q);

      final matchesStatus =
          statusFilter == 'All' || record['status'] == statusFilter;

      return matchesSearch && matchesStatus;
    }).toList();
  }

  int _count(String status) =>
      records.where((record) => record['status'] == status).length;

  int get closedCount => _count('Closed');
  int get actionRequiredCount => _count('Actions Required');
  int get verificationCount => _count('Under HSE Verification');
  int get readyCount => _count('Ready for Closure');

  bool _isOverdue(Map<String, dynamic> record) {
    final dateText = record['closureDueDate']?.toString() ?? '';
    final date = DateTime.tryParse(dateText);
    if (date == null) return false;

    final status = record['status']?.toString() ?? '';
    return date.isBefore(DateTime.now()) &&
        !['Closed', 'Cancelled', 'Rejected'].contains(status);
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
      builder: (_) => _PermitClosureForm(
        existing: existing,
        permitTypes: permitTypes,
        statuses: statuses,
        handoverTypes: handoverTypes,
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
        title: const Text('Delete Record'),
        content: const Text(
          'Delete this permit closure and handover record?',
        ),
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
      builder: (_) => _PermitClosureDetails(record: record),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Permit Closure & Handover'),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        onPressed: () => _openForm(),
        icon: const Icon(Icons.assignment_turned_in),
        label: const Text('New Closure'),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                _ClosureDashboard(
                  total: records.length,
                  closed: closedCount,
                  actions: actionRequiredCount,
                  verification: verificationCount,
                  ready: readyCount,
                  overdue: overdueCount,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 4, 12, 8),
                  child: Column(
                    children: [
                      TextField(
                        decoration: const InputDecoration(
                          labelText: 'Search closure records',
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) =>
                            setState(() => search = value),
                      ),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        initialValue: statusFilter,
                        decoration: const InputDecoration(
                          labelText: 'Status Filter',
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
                        onChanged: (value) =>
                            setState(() => statusFilter = value ?? 'All'),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: filteredRecords.isEmpty
                      ? const Center(
                          child: Text('No permit closure records found.'),
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
                                  child: const Icon(
                                    Icons.assignment_turned_in,
                                  ),
                                ),
                                title: Text(
                                  record['closureNo']?.toString().isNotEmpty ==
                                          true
                                      ? record['closureNo'].toString()
                                      : 'Permit Closure',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  '${record['permitNo'] ?? ''} • '
                                  '${record['permitType'] ?? ''}\n'
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

class _ClosureDashboard extends StatelessWidget {
  final int total;
  final int closed;
  final int actions;
  final int verification;
  final int ready;
  final int overdue;

  const _ClosureDashboard({
    required this.total,
    required this.closed,
    required this.actions,
    required this.verification,
    required this.ready,
    required this.overdue,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          _DashboardTile(
            label: 'Total',
            value: total,
            icon: Icons.assignment,
          ),
          _DashboardTile(
            label: 'Closed',
            value: closed,
            icon: Icons.check_circle,
          ),
          _DashboardTile(
            label: 'Actions',
            value: actions,
            icon: Icons.warning,
          ),
          _DashboardTile(
            label: 'Verification',
            value: verification,
            icon: Icons.verified,
          ),
          _DashboardTile(
            label: 'Ready',
            value: ready,
            icon: Icons.task_alt,
          ),
          _DashboardTile(
            label: 'Overdue',
            value: overdue,
            icon: Icons.schedule,
          ),
        ],
      ),
    );
  }
}

class _DashboardTile extends StatelessWidget {
  final String label;
  final int value;
  final IconData icon;

  const _DashboardTile({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 106,
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
          Text(
            label,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _PermitClosureForm extends StatefulWidget {
  final Map<String, dynamic>? existing;
  final List<String> permitTypes;
  final List<String> statuses;
  final List<String> handoverTypes;

  const _PermitClosureForm({
    required this.existing,
    required this.permitTypes,
    required this.statuses,
    required this.handoverTypes,
  });

  @override
  State<_PermitClosureForm> createState() => _PermitClosureFormState();
}

class _PermitClosureFormState extends State<_PermitClosureForm> {
  static const Color primaryGreen = Color(0xFF159447);

  final formKey = GlobalKey<FormState>();
  final controllers = <String, TextEditingController>{};

  late String permitType;
  late String status;
  late String handoverType;

  bool workCompleted = false;
  bool areaInspected = false;
  bool housekeepingComplete = false;
  bool toolsRemoved = false;
  bool personnelCleared = false;
  bool temporaryMaterialsRemoved = false;
  bool isolationRestored = false;
  bool lotoRemovedByAuthorizedPerson = false;
  bool gasTestCompleted = false;
  bool finalAtmosphereAcceptable = false;
  bool equipmentReturned = false;
  bool barricadesRemoved = false;
  bool warningSignsRemoved = false;
  bool wasteRemoved = false;
  bool environmentalRestorationComplete = false;
  bool outstandingActionsClosed = false;
  bool finalHseVerificationComplete = false;
  bool handoverAccepted = false;
  bool closureApproved = false;

  @override
  void initState() {
    super.initState();

    const fields = [
      'closureNo',
      'permitNo',
      'project',
      'location',
      'department',
      'activity',
      'permitHolder',
      'workSupervisor',
      'issuingAuthority',
      'receivingAuthority',
      'hseVerifier',
      'workCompletionDate',
      'finalInspectionDate',
      'handoverDate',
      'closureDate',
      'closureDueDate',
      'workCompletionSummary',
      'siteInspectionFindings',
      'housekeepingDetails',
      'toolsEquipmentDetails',
      'personnelClearanceDetails',
      'temporaryMaterialsDetails',
      'isolationRestorationDetails',
      'lotoRemovalDetails',
      'gasTestDetails',
      'equipmentReturnDetails',
      'barricadeSignDetails',
      'wasteEnvironmentalDetails',
      'outstandingActions',
      'correctiveActionReference',
      'finalHseFindings',
      'handoverConditions',
      'handoverRemarks',
      'lessonsLearned',
      'permitFileReference',
      'supportingDocuments',
      'remarks',
    ];

    for (final field in fields) {
      controllers[field] = TextEditingController(
        text: widget.existing?[field]?.toString() ?? '',
      );
    }

    permitType =
        widget.existing?['permitType']?.toString() ?? widget.permitTypes.first;
    status = widget.existing?['status']?.toString() ?? 'Draft';
    handoverType = widget.existing?['handoverType']?.toString() ??
        widget.handoverTypes.first;

    workCompleted =
        widget.existing?['workCompleted']?.toString() == 'true';
    areaInspected =
        widget.existing?['areaInspected']?.toString() == 'true';
    housekeepingComplete =
        widget.existing?['housekeepingComplete']?.toString() == 'true';
    toolsRemoved =
        widget.existing?['toolsRemoved']?.toString() == 'true';
    personnelCleared =
        widget.existing?['personnelCleared']?.toString() == 'true';
    temporaryMaterialsRemoved =
        widget.existing?['temporaryMaterialsRemoved']?.toString() == 'true';
    isolationRestored =
        widget.existing?['isolationRestored']?.toString() == 'true';
    lotoRemovedByAuthorizedPerson =
        widget.existing?['lotoRemovedByAuthorizedPerson']?.toString() ==
            'true';
    gasTestCompleted =
        widget.existing?['gasTestCompleted']?.toString() == 'true';
    finalAtmosphereAcceptable =
        widget.existing?['finalAtmosphereAcceptable']?.toString() == 'true';
    equipmentReturned =
        widget.existing?['equipmentReturned']?.toString() == 'true';
    barricadesRemoved =
        widget.existing?['barricadesRemoved']?.toString() == 'true';
    warningSignsRemoved =
        widget.existing?['warningSignsRemoved']?.toString() == 'true';
    wasteRemoved =
        widget.existing?['wasteRemoved']?.toString() == 'true';
    environmentalRestorationComplete =
        widget.existing?['environmentalRestorationComplete']?.toString() ==
            'true';
    outstandingActionsClosed =
        widget.existing?['outstandingActionsClosed']?.toString() == 'true';
    finalHseVerificationComplete =
        widget.existing?['finalHseVerificationComplete']?.toString() == 'true';
    handoverAccepted =
        widget.existing?['handoverAccepted']?.toString() == 'true';
    closureApproved =
        widget.existing?['closureApproved']?.toString() == 'true';
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
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: controllers[name],
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: required ? '$label *' : label,
          border: const OutlineInputBorder(),
        ),
        validator: required
            ? (value) => value == null || value.trim().isEmpty
                ? '$label is required'
                : null
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
            ? (value) => value == null || value.trim().isEmpty
                ? '$label is required'
                : null
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
    final completion = DateTime.tryParse(_text('workCompletionDate'));
    final inspection = DateTime.tryParse(_text('finalInspectionDate'));
    final handover = DateTime.tryParse(_text('handoverDate'));
    final closure = DateTime.tryParse(_text('closureDate'));

    if (completion != null &&
        inspection != null &&
        inspection.isBefore(completion)) {
      _error('Final inspection cannot be before work completion.');
      return false;
    }

    if (inspection != null &&
        handover != null &&
        handover.isBefore(inspection)) {
      _error('Handover cannot be before final inspection.');
      return false;
    }

    if (handover != null &&
        closure != null &&
        closure.isBefore(handover)) {
      _error('Closure cannot be before handover.');
      return false;
    }

    if (!workCompleted) {
      _error('Work completion must be confirmed before closure.');
      return false;
    }

    if (!areaInspected) {
      _error('Final area inspection must be confirmed.');
      return false;
    }

    if (!housekeepingComplete ||
        !toolsRemoved ||
        !personnelCleared ||
        !temporaryMaterialsRemoved) {
      _error('Site restoration and clearance checks must be confirmed.');
      return false;
    }

    if (!equipmentReturned) {
      _error('Equipment return / clearance must be confirmed.');
      return false;
    }

    if (!barricadesRemoved || !warningSignsRemoved) {
      _error('Barricade and warning-sign status must be confirmed.');
      return false;
    }

    if (!wasteRemoved || !environmentalRestorationComplete) {
      _error('Waste and environmental restoration must be confirmed.');
      return false;
    }

    if (!isolationRestored) {
      _error('Isolation restoration status must be confirmed.');
      return false;
    }

    if (!outstandingActionsClosed) {
      if (_text('outstandingActions').isEmpty) {
        _error(
          'Outstanding action status or details must be recorded.',
        );
        return false;
      }
      if (status == 'Closed') {
        _error('All outstanding actions must be closed before permit closure.');
        return false;
      }
    }

    if (!finalHseVerificationComplete &&
        ['Ready for Closure', 'Closed'].contains(status)) {
      _error('Final HSE verification is required.');
      return false;
    }

    if (status == 'Closed') {
      if (!handoverAccepted) {
        _error('Handover acceptance is required before closure.');
        return false;
      }
      if (!closureApproved) {
        _error('Closure approval is required.');
        return false;
      }
      if (_text('closureDate').isEmpty) {
        _error('Closure date is required.');
        return false;
      }
    }

    if (lotoRemovedByAuthorizedPerson && !isolationRestored) {
      _error('LOTO removal cannot be confirmed before isolation restoration.');
      return false;
    }

    if (gasTestCompleted && !finalAtmosphereAcceptable) {
      _error('Final atmosphere must be confirmed acceptable.');
      return false;
    }

    if (!handoverAccepted &&
        ['Ready for Closure', 'Closed'].contains(status)) {
      _error('Handover acceptance is required.');
      return false;
    }

    return true;
  }

  void _submit() {
    FocusScope.of(context).unfocus();

    if (!formKey.currentState!.validate()) return;
    if (!_validateBusinessRules()) return;

    final record = <String, dynamic>{
      'closureNo': _text('closureNo'),
      'permitNo': _text('permitNo'),
      'project': _text('project'),
      'location': _text('location'),
      'department': _text('department'),
      'permitType': permitType,
      'handoverType': handoverType,
      'status': status,
      'activity': _text('activity'),
      'permitHolder': _text('permitHolder'),
      'workSupervisor': _text('workSupervisor'),
      'issuingAuthority': _text('issuingAuthority'),
      'receivingAuthority': _text('receivingAuthority'),
      'hseVerifier': _text('hseVerifier'),
      'workCompletionDate': _text('workCompletionDate'),
      'finalInspectionDate': _text('finalInspectionDate'),
      'handoverDate': _text('handoverDate'),
      'closureDate': _text('closureDate'),
      'closureDueDate': _text('closureDueDate'),
      'workCompletionSummary': _text('workCompletionSummary'),
      'siteInspectionFindings': _text('siteInspectionFindings'),
      'housekeepingDetails': _text('housekeepingDetails'),
      'toolsEquipmentDetails': _text('toolsEquipmentDetails'),
      'personnelClearanceDetails': _text('personnelClearanceDetails'),
      'temporaryMaterialsDetails': _text('temporaryMaterialsDetails'),
      'isolationRestorationDetails': _text('isolationRestorationDetails'),
      'lotoRemovalDetails': _text('lotoRemovalDetails'),
      'gasTestDetails': _text('gasTestDetails'),
      'equipmentReturnDetails': _text('equipmentReturnDetails'),
      'barricadeSignDetails': _text('barricadeSignDetails'),
      'wasteEnvironmentalDetails': _text('wasteEnvironmentalDetails'),
      'outstandingActions': _text('outstandingActions'),
      'correctiveActionReference': _text('correctiveActionReference'),
      'finalHseFindings': _text('finalHseFindings'),
      'handoverConditions': _text('handoverConditions'),
      'handoverRemarks': _text('handoverRemarks'),
      'lessonsLearned': _text('lessonsLearned'),
      'permitFileReference': _text('permitFileReference'),
      'supportingDocuments': _text('supportingDocuments'),
      'remarks': _text('remarks'),
      'workCompleted': workCompleted,
      'areaInspected': areaInspected,
      'housekeepingComplete': housekeepingComplete,
      'toolsRemoved': toolsRemoved,
      'personnelCleared': personnelCleared,
      'temporaryMaterialsRemoved': temporaryMaterialsRemoved,
      'isolationRestored': isolationRestored,
      'lotoRemovedByAuthorizedPerson': lotoRemovedByAuthorizedPerson,
      'gasTestCompleted': gasTestCompleted,
      'finalAtmosphereAcceptable': finalAtmosphereAcceptable,
      'equipmentReturned': equipmentReturned,
      'barricadesRemoved': barricadesRemoved,
      'warningSignsRemoved': warningSignsRemoved,
      'wasteRemoved': wasteRemoved,
      'environmentalRestorationComplete':
          environmentalRestorationComplete,
      'outstandingActionsClosed': outstandingActionsClosed,
      'finalHseVerificationComplete': finalHseVerificationComplete,
      'handoverAccepted': handoverAccepted,
      'closureApproved': closureApproved,
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
                      'Permit Closure & Handover',
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
                      '1. Permit & Work Details',
                      Icons.assignment,
                      [
                        _field(
                          'closureNo',
                          'Closure Record No.',
                          required: true,
                        ),
                        _field(
                          'permitNo',
                          'Permit No.',
                          required: true,
                        ),
                        _dropdown(
                          'Permit Type',
                          permitType,
                          widget.permitTypes,
                          (value) => setState(
                            () => permitType = value ?? permitType,
                          ),
                        ),
                        _dropdown(
                          'Handover Type',
                          handoverType,
                          widget.handoverTypes,
                          (value) => setState(
                            () => handoverType = value ?? handoverType,
                          ),
                        ),
                        _field('project', 'Project', required: true),
                        _field('location', 'Location', required: true),
                        _field('department', 'Department'),
                        _field(
                          'activity',
                          'Activity / Work',
                          required: true,
                        ),
                        _field(
                          'permitHolder',
                          'Permit Holder',
                          required: true,
                        ),
                        _field(
                          'workSupervisor',
                          'Work Supervisor',
                          required: true,
                        ),
                        _field(
                          'issuingAuthority',
                          'Permit Issuing Authority',
                          required: true,
                        ),
                        _field(
                          'receivingAuthority',
                          'Receiving / Handover Authority',
                          required: true,
                        ),
                        _field('hseVerifier', 'HSE Verifier'),
                      ],
                    ),
                    _section(
                      '2. Completion & Inspection',
                      Icons.fact_check,
                      [
                        _dateField(
                          'workCompletionDate',
                          'Work Completion Date',
                          required: true,
                        ),
                        _dateField(
                          'finalInspectionDate',
                          'Final Inspection Date',
                          required: true,
                        ),
                        _field(
                          'workCompletionSummary',
                          'Work Completion Summary',
                          maxLines: 4,
                          required: true,
                        ),
                        _field(
                          'siteInspectionFindings',
                          'Final Site Inspection Findings',
                          maxLines: 4,
                          required: true,
                        ),
                        _switch(
                          'Work Completed',
                          workCompleted,
                          (value) => setState(
                            () => workCompleted = value,
                          ),
                        ),
                        _switch(
                          'Final Area Inspection Completed',
                          areaInspected,
                          (value) => setState(
                            () => areaInspected = value,
                          ),
                        ),
                        _field(
                          'housekeepingDetails',
                          'Housekeeping / Restoration Details',
                          maxLines: 3,
                          required: true,
                        ),
                        _switch(
                          'Housekeeping Complete',
                          housekeepingComplete,
                          (value) => setState(
                            () => housekeepingComplete = value,
                          ),
                        ),
                      ],
                    ),
                    _section(
                      '3. Site Clearance & Restoration',
                      Icons.cleaning_services,
                      [
                        _field(
                          'toolsEquipmentDetails',
                          'Tools / Equipment Removal Details',
                          maxLines: 3,
                          required: true,
                        ),
                        _switch(
                          'Tools & Equipment Removed',
                          toolsRemoved,
                          (value) => setState(
                            () => toolsRemoved = value,
                          ),
                        ),
                        _field(
                          'personnelClearanceDetails',
                          'Personnel Clearance Details',
                          maxLines: 3,
                          required: true,
                        ),
                        _switch(
                          'Personnel Cleared from Work Area',
                          personnelCleared,
                          (value) => setState(
                            () => personnelCleared = value,
                          ),
                        ),
                        _field(
                          'temporaryMaterialsDetails',
                          'Temporary Materials / Structures Removal',
                          maxLines: 3,
                          required: true,
                        ),
                        _switch(
                          'Temporary Materials Removed',
                          temporaryMaterialsRemoved,
                          (value) => setState(
                            () => temporaryMaterialsRemoved = value,
                          ),
                        ),
                        _switch(
                          'Equipment Returned / Area Cleared',
                          equipmentReturned,
                          (value) => setState(
                            () => equipmentReturned = value,
                          ),
                        ),
                        _field(
                          'equipmentReturnDetails',
                          'Equipment Return Details',
                          maxLines: 3,
                        ),
                        _switch(
                          'Barricades Removed',
                          barricadesRemoved,
                          (value) => setState(
                            () => barricadesRemoved = value,
                          ),
                        ),
                        _switch(
                          'Warning Signs Removed',
                          warningSignsRemoved,
                          (value) => setState(
                            () => warningSignsRemoved = value,
                          ),
                        ),
                        _field(
                          'barricadeSignDetails',
                          'Barricade / Sign Details',
                          maxLines: 3,
                        ),
                      ],
                    ),
                    _section(
                      '4. Isolation / LOTO / Gas Test',
                      Icons.power_settings_new,
                      [
                        _field(
                          'isolationRestorationDetails',
                          'Isolation Restoration Details',
                          maxLines: 4,
                          required: true,
                        ),
                        _switch(
                          'Isolation Restored / System Safe',
                          isolationRestored,
                          (value) => setState(
                            () => isolationRestored = value,
                          ),
                        ),
                        _field(
                          'lotoRemovalDetails',
                          'LOTO Removal Details',
                          maxLines: 3,
                        ),
                        _switch(
                          'LOTO Removed by Authorized Person',
                          lotoRemovedByAuthorizedPerson,
                          (value) => setState(
                            () => lotoRemovedByAuthorizedPerson = value,
                          ),
                        ),
                        _switch(
                          'Final Gas / Atmospheric Test Completed',
                          gasTestCompleted,
                          (value) => setState(
                            () => gasTestCompleted = value,
                          ),
                        ),
                        _switch(
                          'Final Atmosphere Acceptable',
                          finalAtmosphereAcceptable,
                          (value) => setState(
                            () => finalAtmosphereAcceptable = value,
                          ),
                        ),
                        _field(
                          'gasTestDetails',
                          'Final Gas Test / Atmospheric Details',
                          maxLines: 4,
                        ),
                      ],
                    ),
                    _section(
                      '5. Waste & Environmental Restoration',
                      Icons.eco,
                      [
                        _field(
                          'wasteEnvironmentalDetails',
                          'Waste / Environmental Restoration Details',
                          maxLines: 4,
                          required: true,
                        ),
                        _switch(
                          'Waste Removed / Disposed Correctly',
                          wasteRemoved,
                          (value) => setState(
                            () => wasteRemoved = value,
                          ),
                        ),
                        _switch(
                          'Environmental Restoration Complete',
                          environmentalRestorationComplete,
                          (value) => setState(
                            () => environmentalRestorationComplete = value,
                          ),
                        ),
                      ],
                    ),
                    _section(
                      '6. Outstanding Actions',
                      Icons.assignment_late,
                      [
                        _field(
                          'outstandingActions',
                          'Outstanding HSE / Corrective Actions',
                          maxLines: 4,
                          required: true,
                        ),
                        _field(
                          'correctiveActionReference',
                          'Corrective Action Reference',
                          maxLines: 2,
                        ),
                        _switch(
                          'All Outstanding Actions Closed',
                          outstandingActionsClosed,
                          (value) => setState(
                            () => outstandingActionsClosed = value,
                          ),
                        ),
                      ],
                    ),
                    _section(
                      '7. Final HSE Verification',
                      Icons.verified_user,
                      [
                        _field(
                          'finalHseFindings',
                          'Final HSE Verification Findings',
                          maxLines: 4,
                          required: true,
                        ),
                        _switch(
                          'Final HSE Verification Complete',
                          finalHseVerificationComplete,
                          (value) => setState(
                            () => finalHseVerificationComplete = value,
                          ),
                        ),
                        _field(
                          'lessonsLearned',
                          'Lessons Learned / Improvement Notes',
                          maxLines: 4,
                        ),
                      ],
                    ),
                    _section(
                      '8. Handover & Closure',
                      Icons.handshake,
                      [
                        _dateField(
                          'handoverDate',
                          'Handover Date',
                          required: true,
                        ),
                        _field(
                          'handoverConditions',
                          'Handover Conditions',
                          maxLines: 4,
                          required: true,
                        ),
                        _field(
                          'handoverRemarks',
                          'Handover Remarks',
                          maxLines: 3,
                        ),
                        _switch(
                          'Handover Accepted',
                          handoverAccepted,
                          (value) => setState(
                            () => handoverAccepted = value,
                          ),
                        ),
                        _dropdown(
                          'Status',
                          status,
                          widget.statuses,
                          (value) =>
                              setState(() => status = value ?? status),
                        ),
                        _dateField(
                          'closureDueDate',
                          'Closure Due Date',
                        ),
                        _dateField(
                          'closureDate',
                          'Closure Date',
                        ),
                        _switch(
                          'Closure Approved',
                          closureApproved,
                          (value) => setState(
                            () => closureApproved = value,
                          ),
                        ),
                        _field(
                          'permitFileReference',
                          'Final Permit File / Archive Reference',
                          maxLines: 2,
                        ),
                        _field(
                          'supportingDocuments',
                          'Supporting Documents',
                          maxLines: 3,
                        ),
                        _field(
                          'remarks',
                          'Final Remarks',
                          maxLines: 3,
                        ),
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
                              ? 'Save Closure'
                              : 'Update Closure',
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

class _PermitClosureDetails extends StatelessWidget {
  final Map<String, dynamic> record;

  const _PermitClosureDetails({required this.record});

  String _label(String key) {
    const labels = {
      'closureNo': 'Closure Record No.',
      'permitNo': 'Permit No.',
      'project': 'Project',
      'location': 'Location',
      'department': 'Department',
      'permitType': 'Permit Type',
      'handoverType': 'Handover Type',
      'status': 'Status',
      'activity': 'Activity / Work',
      'permitHolder': 'Permit Holder',
      'workSupervisor': 'Work Supervisor',
      'issuingAuthority': 'Issuing Authority',
      'receivingAuthority': 'Receiving Authority',
      'hseVerifier': 'HSE Verifier',
      'workCompletionDate': 'Work Completion Date',
      'finalInspectionDate': 'Final Inspection Date',
      'handoverDate': 'Handover Date',
      'closureDate': 'Closure Date',
      'closureDueDate': 'Closure Due Date',
      'workCompletionSummary': 'Work Completion Summary',
      'siteInspectionFindings': 'Final Site Inspection Findings',
      'housekeepingDetails': 'Housekeeping / Restoration',
      'toolsEquipmentDetails': 'Tools / Equipment Removal',
      'personnelClearanceDetails': 'Personnel Clearance',
      'temporaryMaterialsDetails': 'Temporary Materials',
      'isolationRestorationDetails': 'Isolation Restoration',
      'lotoRemovalDetails': 'LOTO Removal',
      'gasTestDetails': 'Gas Test',
      'equipmentReturnDetails': 'Equipment Return',
      'barricadeSignDetails': 'Barricades / Signs',
      'wasteEnvironmentalDetails': 'Waste / Environment',
      'outstandingActions': 'Outstanding Actions',
      'correctiveActionReference': 'Corrective Action Reference',
      'finalHseFindings': 'Final HSE Findings',
      'handoverConditions': 'Handover Conditions',
      'handoverRemarks': 'Handover Remarks',
      'lessonsLearned': 'Lessons Learned',
      'permitFileReference': 'Permit File Reference',
      'supportingDocuments': 'Supporting Documents',
      'remarks': 'Remarks',
    };
    return labels[key] ?? key;
  }

  @override
  Widget build(BuildContext context) {
    const excluded = {
      'createdAt',
      'updatedAt',
      'workCompleted',
      'areaInspected',
      'housekeepingComplete',
      'toolsRemoved',
      'personnelCleared',
      'temporaryMaterialsRemoved',
      'isolationRestored',
      'lotoRemovedByAuthorizedPerson',
      'gasTestCompleted',
      'finalAtmosphereAcceptable',
      'equipmentReturned',
      'barricadesRemoved',
      'warningSignsRemoved',
      'wasteRemoved',
      'environmentalRestorationComplete',
      'outstandingActionsClosed',
      'finalHseVerificationComplete',
      'handoverAccepted',
      'closureApproved',
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
              'Permit Closure Details',
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
