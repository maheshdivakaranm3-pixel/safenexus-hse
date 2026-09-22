import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PermitExtensionSuspensionRevalidationPage extends StatefulWidget {
  const PermitExtensionSuspensionRevalidationPage({super.key});

  @override
  State<PermitExtensionSuspensionRevalidationPage> createState() =>
      _PermitExtensionSuspensionRevalidationPageState();
}

class _PermitExtensionSuspensionRevalidationPageState
    extends State<PermitExtensionSuspensionRevalidationPage> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const String storageKey =
      'safenexus_hse_permit_extension_suspension_revalidation';

  final actionTypes = const [
    'Extension',
    'Suspension',
    'Revalidation',
    'Extension + Revalidation',
    'Suspension + Revalidation',
    'Other',
  ];

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
    'Requested',
    'Under Review',
    'Changes Required',
    'Approved',
    'Extended',
    'Suspended',
    'Revalidated',
    'Active',
    'Rejected',
    'Closed',
    'Cancelled',
  ];

  final suspensionReasons = const [
    'Weather / Environmental Condition',
    'Unsafe Site Condition',
    'Change in Work Scope',
    'Change in Risk',
    'Emergency',
    'Equipment Failure',
    'Permit Condition Not Met',
    'Gas Test / Atmospheric Condition',
    'Isolation / LOTO Issue',
    'Personnel / Competency Issue',
    'Work Stoppage',
    'Other',
  ];

  final revalidationTriggers = const [
    'Shift Change',
    'Work Resumption After Suspension',
    'Change of Work Crew',
    'Change of Supervisor',
    'Change of Work Location',
    'Change of Work Method',
    'Change in Risk Assessment',
    'Change in Weather',
    'Permit Nearing Expiry',
    'Periodic Verification',
    'Other',
  ];

  List<Map<String, dynamic>> records = [];
  bool loading = true;
  String search = '';
  String actionFilter = 'All';
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
            record['recordNo'],
            record['permitNo'],
            record['project'],
            record['location'],
            record['permitType'],
            record['activity'],
            record['actionType'],
            record['reason'],
            record['responsiblePerson'],
            record['status'],
          ].join(' ').toLowerCase().contains(q);
      final matchesAction =
          actionFilter == 'All' || record['actionType'] == actionFilter;
      final matchesStatus =
          statusFilter == 'All' || record['status'] == statusFilter;
      return matchesSearch && matchesAction && matchesStatus;
    }).toList();
  }

  int _count(String status) =>
      records.where((record) => record['status'] == status).length;

  int get activeCount => _count('Active');
  int get extendedCount => _count('Extended');
  int get suspendedCount => _count('Suspended');
  int get revalidatedCount => _count('Revalidated');

  bool _isOverdue(Map<String, dynamic> record) {
    final dateText = record['newExpiryDate']?.toString() ??
        record['requestedExpiryDate']?.toString() ??
        '';
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
      builder: (_) => _PermitActionForm(
        existing: existing,
        actionTypes: actionTypes,
        permitTypes: permitTypes,
        statuses: statuses,
        suspensionReasons: suspensionReasons,
        revalidationTriggers: revalidationTriggers,
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
          'Delete this permit extension / suspension / revalidation record?',
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
      builder: (_) => _PermitActionDetails(record: record),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Permit Extension / Suspension / Revalidation'),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        onPressed: () => _openForm(),
        icon: const Icon(Icons.add),
        label: const Text('New Action'),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                _PermitActionDashboard(
                  total: records.length,
                  active: activeCount,
                  extended: extendedCount,
                  suspended: suspendedCount,
                  revalidated: revalidatedCount,
                  overdue: overdueCount,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 4, 12, 8),
                  child: Column(
                    children: [
                      TextField(
                        decoration: const InputDecoration(
                          labelText: 'Search permit actions',
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
                              initialValue: actionFilter,
                              decoration: const InputDecoration(
                                labelText: 'Action',
                                border: OutlineInputBorder(),
                              ),
                              items: [
                                const DropdownMenuItem(
                                  value: 'All',
                                  child: Text('All'),
                                ),
                                ...actionTypes.map(
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
                                () => actionFilter = value ?? 'All',
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
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
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: filteredRecords.isEmpty
                      ? const Center(
                          child: Text('No permit action records found.'),
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
                                  child: const Icon(Icons.update),
                                ),
                                title: Text(
                                  record['recordNo']?.toString().isNotEmpty ==
                                          true
                                      ? record['recordNo'].toString()
                                      : 'Permit Action',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  '${record['actionType'] ?? ''} • '
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

class _PermitActionDashboard extends StatelessWidget {
  final int total;
  final int active;
  final int extended;
  final int suspended;
  final int revalidated;
  final int overdue;

  const _PermitActionDashboard({
    required this.total,
    required this.active,
    required this.extended,
    required this.suspended,
    required this.revalidated,
    required this.overdue,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          _DashboardTile(label: 'Total', value: total, icon: Icons.assignment),
          _DashboardTile(label: 'Active', value: active, icon: Icons.play_circle),
          _DashboardTile(label: 'Extended', value: extended, icon: Icons.update),
          _DashboardTile(label: 'Suspended', value: suspended, icon: Icons.pause_circle),
          _DashboardTile(label: 'Revalidated', value: revalidated, icon: Icons.verified),
          _DashboardTile(label: 'Overdue', value: overdue, icon: Icons.warning),
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
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Text(label, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class _PermitActionForm extends StatefulWidget {
  final Map<String, dynamic>? existing;
  final List<String> actionTypes;
  final List<String> permitTypes;
  final List<String> statuses;
  final List<String> suspensionReasons;
  final List<String> revalidationTriggers;

  const _PermitActionForm({
    required this.existing,
    required this.actionTypes,
    required this.permitTypes,
    required this.statuses,
    required this.suspensionReasons,
    required this.revalidationTriggers,
  });

  @override
  State<_PermitActionForm> createState() => _PermitActionFormState();
}

class _PermitActionFormState extends State<_PermitActionForm> {
  static const Color primaryGreen = Color(0xFF159447);

  final formKey = GlobalKey<FormState>();
  final controllers = <String, TextEditingController>{};

  late String actionType;
  late String permitType;
  late String status;
  late String suspensionReason;
  late String revalidationTrigger;

  bool conditionsReviewed = true;
  bool riskAssessmentStillValid = true;
  bool jsaStillValid = true;
  bool ramsStillValid = true;
  bool permitConditionsStillValid = true;
  bool isolationStillValid = false;
  bool gasTestStillValid = false;
  bool competencyStillValid = true;
  bool equipmentStillValid = true;
  bool siteConditionsStillValid = true;
  bool emergencyArrangementsStillValid = true;
  bool extensionApproved = false;
  bool suspensionCommunicated = false;
  bool revalidationApproved = false;
  bool toolboxTalkRequired = true;
  bool additionalControlsRequired = false;
  bool permitCopyUpdated = true;

  @override
  void initState() {
    super.initState();

    const fields = [
      'recordNo',
      'permitNo',
      'project',
      'location',
      'department',
      'activity',
      'permitHolder',
      'performingAuthority',
      'issuingAuthority',
      'hseReviewer',
      'originalStartDate',
      'originalExpiryDate',
      'requestedExpiryDate',
      'newExpiryDate',
      'suspensionDate',
      'resumptionDate',
      'revalidationDate',
      'approvalDate',
      'approvedBy',
      'reason',
      'changeDescription',
      'workProgress',
      'conditionsReview',
      'riskAssessmentReference',
      'jsaReference',
      'ramsReference',
      'permitConditions',
      'isolationDetails',
      'gasTestDetails',
      'competencyDetails',
      'equipmentDetails',
      'siteConditionDetails',
      'emergencyDetails',
      'additionalControls',
      'suspensionAction',
      'resumptionConditions',
      'revalidationFindings',
      'communicationDetails',
      'toolboxTalkDetails',
      'updatedPermitReference',
      'supportingDocuments',
      'remarks',
    ];

    for (final field in fields) {
      controllers[field] = TextEditingController(
        text: widget.existing?[field]?.toString() ?? '',
      );
    }

    actionType =
        widget.existing?['actionType']?.toString() ?? widget.actionTypes.first;
    permitType =
        widget.existing?['permitType']?.toString() ?? widget.permitTypes.first;
    status = widget.existing?['status']?.toString() ?? 'Draft';
    suspensionReason = widget.existing?['suspensionReason']?.toString() ??
        widget.suspensionReasons.first;
    revalidationTrigger =
        widget.existing?['revalidationTrigger']?.toString() ??
            widget.revalidationTriggers.first;

    conditionsReviewed =
        widget.existing?['conditionsReviewed']?.toString() != 'false';
    riskAssessmentStillValid =
        widget.existing?['riskAssessmentStillValid']?.toString() != 'false';
    jsaStillValid =
        widget.existing?['jsaStillValid']?.toString() != 'false';
    ramsStillValid =
        widget.existing?['ramsStillValid']?.toString() != 'false';
    permitConditionsStillValid =
        widget.existing?['permitConditionsStillValid']?.toString() != 'false';
    isolationStillValid =
        widget.existing?['isolationStillValid']?.toString() == 'true';
    gasTestStillValid =
        widget.existing?['gasTestStillValid']?.toString() == 'true';
    competencyStillValid =
        widget.existing?['competencyStillValid']?.toString() != 'false';
    equipmentStillValid =
        widget.existing?['equipmentStillValid']?.toString() != 'false';
    siteConditionsStillValid =
        widget.existing?['siteConditionsStillValid']?.toString() != 'false';
    emergencyArrangementsStillValid =
        widget.existing?['emergencyArrangementsStillValid']?.toString() !=
            'false';
    extensionApproved =
        widget.existing?['extensionApproved']?.toString() == 'true';
    suspensionCommunicated =
        widget.existing?['suspensionCommunicated']?.toString() == 'true';
    revalidationApproved =
        widget.existing?['revalidationApproved']?.toString() == 'true';
    toolboxTalkRequired =
        widget.existing?['toolboxTalkRequired']?.toString() != 'false';
    additionalControlsRequired =
        widget.existing?['additionalControlsRequired']?.toString() == 'true';
    permitCopyUpdated =
        widget.existing?['permitCopyUpdated']?.toString() != 'false';
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
                child: Text(item, overflow: TextOverflow.ellipsis),
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
    final originalExpiry = DateTime.tryParse(_text('originalExpiryDate'));
    final requestedExpiry =
        DateTime.tryParse(_text('requestedExpiryDate'));
    final newExpiry = DateTime.tryParse(_text('newExpiryDate'));
    final suspension = DateTime.tryParse(_text('suspensionDate'));
    final resumption = DateTime.tryParse(_text('resumptionDate'));

    if (originalExpiry != null &&
        requestedExpiry != null &&
        !requestedExpiry.isAfter(originalExpiry)) {
      _error('Requested expiry must be after the original expiry.');
      return false;
    }

    if (requestedExpiry != null &&
        newExpiry != null &&
        !newExpiry.isAfter(requestedExpiry)) {
      _error('New expiry must be after the requested expiry.');
      return false;
    }

    if (suspension != null &&
        resumption != null &&
        !resumption.isAfter(suspension)) {
      _error('Resumption must be after suspension.');
      return false;
    }

    if (!conditionsReviewed ||
        !riskAssessmentStillValid ||
        !jsaStillValid ||
        !ramsStillValid ||
        !permitConditionsStillValid ||
        !competencyStillValid ||
        !equipmentStillValid ||
        !siteConditionsStillValid ||
        !emergencyArrangementsStillValid) {
      _error('All required permit-condition checks must be confirmed.');
      return false;
    }

    if (actionType == 'Extension' ||
        actionType == 'Extension + Revalidation') {
      if (_text('requestedExpiryDate').isEmpty ||
          _text('newExpiryDate').isEmpty) {
        _error('Requested and new expiry dates are required for extension.');
        return false;
      }
      if (!extensionApproved && status == 'Extended') {
        _error('Extension approval must be confirmed.');
        return false;
      }
    }

    if (actionType == 'Suspension' ||
        actionType == 'Suspension + Revalidation') {
      if (_text('suspensionDate').isEmpty ||
          _text('suspensionAction').isEmpty) {
        _error('Suspension date and suspension action are required.');
        return false;
      }
      if (!suspensionCommunicated) {
        _error('Suspension communication must be confirmed.');
        return false;
      }
    }

    if (actionType == 'Revalidation' ||
        actionType == 'Extension + Revalidation' ||
        actionType == 'Suspension + Revalidation') {
      if (_text('revalidationDate').isEmpty ||
          _text('revalidationFindings').isEmpty) {
        _error('Revalidation date and findings are required.');
        return false;
      }
      if (!revalidationApproved && status == 'Revalidated') {
        _error('Revalidation approval must be confirmed.');
        return false;
      }
    }

    if (additionalControlsRequired && _text('additionalControls').isEmpty) {
      _error('Additional controls are required.');
      return false;
    }

    if (toolboxTalkRequired && _text('toolboxTalkDetails').isEmpty) {
      _error('Toolbox talk / re-brief details are required.');
      return false;
    }

    if (!permitCopyUpdated && status == 'Active') {
      _error('Updated permit copy must be confirmed.');
      return false;
    }

    if (['Approved', 'Extended', 'Revalidated', 'Active'].contains(status) &&
        _text('approvedBy').isEmpty) {
      _error('Approved By is required for this status.');
      return false;
    }

    if (['Approved', 'Extended', 'Revalidated'].contains(status) &&
        _text('approvalDate').isEmpty) {
      _error('Approval Date is required.');
      return false;
    }

    if (status == 'Suspended' && _text('suspensionDate').isEmpty) {
      _error('Suspension Date is required.');
      return false;
    }

    if (status == 'Active' && _text('newExpiryDate').isEmpty) {
      _error('New expiry date is required for an active permit.');
      return false;
    }

    return true;
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    if (!formKey.currentState!.validate()) return;
    if (!_validateBusinessRules()) return;

    final record = <String, dynamic>{
      'recordNo': _text('recordNo'),
      'permitNo': _text('permitNo'),
      'project': _text('project'),
      'location': _text('location'),
      'department': _text('department'),
      'actionType': actionType,
      'permitType': permitType,
      'suspensionReason': suspensionReason,
      'revalidationTrigger': revalidationTrigger,
      'status': status,
      'activity': _text('activity'),
      'permitHolder': _text('permitHolder'),
      'performingAuthority': _text('performingAuthority'),
      'issuingAuthority': _text('issuingAuthority'),
      'hseReviewer': _text('hseReviewer'),
      'originalStartDate': _text('originalStartDate'),
      'originalExpiryDate': _text('originalExpiryDate'),
      'requestedExpiryDate': _text('requestedExpiryDate'),
      'newExpiryDate': _text('newExpiryDate'),
      'suspensionDate': _text('suspensionDate'),
      'resumptionDate': _text('resumptionDate'),
      'revalidationDate': _text('revalidationDate'),
      'approvalDate': _text('approvalDate'),
      'approvedBy': _text('approvedBy'),
      'reason': _text('reason'),
      'changeDescription': _text('changeDescription'),
      'workProgress': _text('workProgress'),
      'conditionsReview': _text('conditionsReview'),
      'riskAssessmentReference': _text('riskAssessmentReference'),
      'jsaReference': _text('jsaReference'),
      'ramsReference': _text('ramsReference'),
      'permitConditions': _text('permitConditions'),
      'isolationDetails': _text('isolationDetails'),
      'gasTestDetails': _text('gasTestDetails'),
      'competencyDetails': _text('competencyDetails'),
      'equipmentDetails': _text('equipmentDetails'),
      'siteConditionDetails': _text('siteConditionDetails'),
      'emergencyDetails': _text('emergencyDetails'),
      'additionalControls': _text('additionalControls'),
      'suspensionAction': _text('suspensionAction'),
      'resumptionConditions': _text('resumptionConditions'),
      'revalidationFindings': _text('revalidationFindings'),
      'communicationDetails': _text('communicationDetails'),
      'toolboxTalkDetails': _text('toolboxTalkDetails'),
      'updatedPermitReference': _text('updatedPermitReference'),
      'supportingDocuments': _text('supportingDocuments'),
      'remarks': _text('remarks'),
      'conditionsReviewed': conditionsReviewed,
      'riskAssessmentStillValid': riskAssessmentStillValid,
      'jsaStillValid': jsaStillValid,
      'ramsStillValid': ramsStillValid,
      'permitConditionsStillValid': permitConditionsStillValid,
      'isolationStillValid': isolationStillValid,
      'gasTestStillValid': gasTestStillValid,
      'competencyStillValid': competencyStillValid,
      'equipmentStillValid': equipmentStillValid,
      'siteConditionsStillValid': siteConditionsStillValid,
      'emergencyArrangementsStillValid': emergencyArrangementsStillValid,
      'extensionApproved': extensionApproved,
      'suspensionCommunicated': suspensionCommunicated,
      'revalidationApproved': revalidationApproved,
      'toolboxTalkRequired': toolboxTalkRequired,
      'additionalControlsRequired': additionalControlsRequired,
      'permitCopyUpdated': permitCopyUpdated,
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
                      'Permit Extension / Suspension / Revalidation',
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
                      '1. Permit Action',
                      Icons.update,
                      [
                        _field('recordNo', 'Action Record No.', required: true),
                        _field('permitNo', 'Original Permit No.', required: true),
                        _dropdown(
                          'Action Type',
                          actionType,
                          widget.actionTypes,
                          (value) =>
                              setState(() => actionType = value ?? actionType),
                        ),
                        _dropdown(
                          'Permit Type',
                          permitType,
                          widget.permitTypes,
                          (value) =>
                              setState(() => permitType = value ?? permitType),
                        ),
                        _field('project', 'Project', required: true),
                        _field('location', 'Location', required: true),
                        _field('department', 'Department'),
                        _field('activity', 'Activity / Work', required: true),
                        _field(
                          'permitHolder',
                          'Permit Holder',
                          required: true,
                        ),
                        _field(
                          'performingAuthority',
                          'Performing Authority',
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
                      '2. Original & Revised Schedule',
                      Icons.calendar_month,
                      [
                        _dateField(
                          'originalStartDate',
                          'Original Start Date',
                          required: true,
                        ),
                        _dateField(
                          'originalExpiryDate',
                          'Original Expiry Date',
                          required: true,
                        ),
                        _dateField(
                          'requestedExpiryDate',
                          'Requested New Expiry Date',
                        ),
                        _dateField(
                          'newExpiryDate',
                          'Approved / Revised Expiry Date',
                        ),
                        _dateField('suspensionDate', 'Suspension Date'),
                        _dateField('resumptionDate', 'Resumption Date'),
                        _dateField(
                          'revalidationDate',
                          'Revalidation Date',
                        ),
                        _field(
                          'workProgress',
                          'Work Progress / Remaining Work',
                          maxLines: 3,
                        ),
                        _field(
                          'reason',
                          'Reason for Action',
                          maxLines: 4,
                          required: true,
                        ),
                        _field(
                          'changeDescription',
                          'Change / Condition Description',
                          maxLines: 4,
                        ),
                      ],
                    ),
                    _section(
                      '3. Permit Condition Review',
                      Icons.fact_check,
                      [
                        _switch(
                          'Permit Conditions Reviewed',
                          conditionsReviewed,
                          (value) => setState(
                            () => conditionsReviewed = value,
                          ),
                        ),
                        _switch(
                          'Risk Assessment Still Valid',
                          riskAssessmentStillValid,
                          (value) => setState(
                            () => riskAssessmentStillValid = value,
                          ),
                        ),
                        _switch(
                          'JSA / JHA Still Valid',
                          jsaStillValid,
                          (value) =>
                              setState(() => jsaStillValid = value),
                        ),
                        _switch(
                          'RAMS Still Valid',
                          ramsStillValid,
                          (value) => setState(() => ramsStillValid = value),
                        ),
                        _switch(
                          'Permit Conditions Still Valid',
                          permitConditionsStillValid,
                          (value) => setState(
                            () => permitConditionsStillValid = value,
                          ),
                        ),
                        _switch(
                          'Isolation Still Valid',
                          isolationStillValid,
                          (value) => setState(
                            () => isolationStillValid = value,
                          ),
                        ),
                        _switch(
                          'Gas Test Still Valid',
                          gasTestStillValid,
                          (value) =>
                              setState(() => gasTestStillValid = value),
                        ),
                        _switch(
                          'Competency Still Valid',
                          competencyStillValid,
                          (value) => setState(
                            () => competencyStillValid = value,
                          ),
                        ),
                        _switch(
                          'Equipment / Certificate Still Valid',
                          equipmentStillValid,
                          (value) => setState(
                            () => equipmentStillValid = value,
                          ),
                        ),
                        _switch(
                          'Site Conditions Still Suitable',
                          siteConditionsStillValid,
                          (value) => setState(
                            () => siteConditionsStillValid = value,
                          ),
                        ),
                        _switch(
                          'Emergency Arrangements Still Valid',
                          emergencyArrangementsStillValid,
                          (value) => setState(
                            () => emergencyArrangementsStillValid = value,
                          ),
                        ),
                        _field(
                          'conditionsReview',
                          'Condition Review Findings',
                          maxLines: 4,
                          required: true,
                        ),
                      ],
                    ),
                    _section(
                      '4. Risk, Isolation & Safety Verification',
                      Icons.health_and_safety,
                      [
                        _field(
                          'riskAssessmentReference',
                          'HIRA / Risk Assessment Reference',
                          required: true,
                        ),
                        _field(
                          'jsaReference',
                          'JSA / JHA Reference',
                          required: true,
                        ),
                        _field(
                          'ramsReference',
                          'RAMS Reference',
                          required: true,
                        ),
                        _field(
                          'permitConditions',
                          'Current Permit Conditions',
                          maxLines: 4,
                          required: true,
                        ),
                        _field(
                          'isolationDetails',
                          'Isolation / LOTO Verification',
                          maxLines: 4,
                        ),
                        _field(
                          'gasTestDetails',
                          'Gas Test / Atmospheric Verification',
                          maxLines: 4,
                        ),
                        _field(
                          'competencyDetails',
                          'Competency / Training Verification',
                          maxLines: 3,
                          required: true,
                        ),
                        _field(
                          'equipmentDetails',
                          'Equipment / Certificate Verification',
                          maxLines: 3,
                          required: true,
                        ),
                        _field(
                          'siteConditionDetails',
                          'Site Condition Verification',
                          maxLines: 3,
                          required: true,
                        ),
                        _field(
                          'emergencyDetails',
                          'Emergency / Rescue Verification',
                          maxLines: 3,
                          required: true,
                        ),
                      ],
                    ),
                    _section(
                      '5. Extension Controls',
                      Icons.more_time,
                      [
                        _switch(
                          'Extension Approved',
                          extensionApproved,
                          (value) => setState(
                            () => extensionApproved = value,
                          ),
                        ),
                        _field(
                          'additionalControls',
                          'Additional Controls / Conditions',
                          maxLines: 4,
                        ),
                        _switch(
                          'Updated Permit Copy Prepared',
                          permitCopyUpdated,
                          (value) => setState(
                            () => permitCopyUpdated = value,
                          ),
                        ),
                        _field(
                          'updatedPermitReference',
                          'Updated Permit / Revision Reference',
                          maxLines: 2,
                        ),
                      ],
                    ),
                    _section(
                      '6. Suspension & Resumption',
                      Icons.pause_circle,
                      [
                        _dropdown(
                          'Suspension Reason',
                          suspensionReason,
                          widget.suspensionReasons,
                          (value) => setState(
                            () => suspensionReason =
                                value ?? suspensionReason,
                          ),
                        ),
                        _field(
                          'suspensionAction',
                          'Immediate Suspension Action',
                          maxLines: 4,
                        ),
                        _switch(
                          'Suspension Communicated',
                          suspensionCommunicated,
                          (value) => setState(
                            () => suspensionCommunicated = value,
                          ),
                        ),
                        _field(
                          'communicationDetails',
                          'Communication / Notification Details',
                          maxLines: 3,
                          required: true,
                        ),
                        _field(
                          'resumptionConditions',
                          'Conditions Required for Resumption',
                          maxLines: 4,
                        ),
                      ],
                    ),
                    _section(
                      '7. Revalidation & Re-Authorization',
                      Icons.verified,
                      [
                        _dropdown(
                          'Revalidation Trigger',
                          revalidationTrigger,
                          widget.revalidationTriggers,
                          (value) => setState(
                            () => revalidationTrigger =
                                value ?? revalidationTrigger,
                          ),
                        ),
                        _field(
                          'revalidationFindings',
                          'Revalidation Findings / Verification',
                          maxLines: 4,
                        ),
                        _switch(
                          'Revalidation Approved',
                          revalidationApproved,
                          (value) => setState(
                            () => revalidationApproved = value,
                          ),
                        ),
                        _switch(
                          'Toolbox Talk / Re-Brief Required',
                          toolboxTalkRequired,
                          (value) => setState(
                            () => toolboxTalkRequired = value,
                          ),
                        ),
                        _field(
                          'toolboxTalkDetails',
                          'Toolbox Talk / Re-Brief Details',
                          maxLines: 3,
                        ),
                        _switch(
                          'Additional Controls Required',
                          additionalControlsRequired,
                          (value) => setState(
                            () => additionalControlsRequired = value,
                          ),
                        ),
                        _field(
                          'additionalControls',
                          'Additional Controls',
                          maxLines: 4,
                        ),
                      ],
                    ),
                    _section(
                      '8. Approval & Closure',
                      Icons.approval,
                      [
                        _dropdown(
                          'Status',
                          status,
                          widget.statuses,
                          (value) => setState(() => status = value ?? status),
                        ),
                        _field('approvedBy', 'Approved By'),
                        _dateField('approvalDate', 'Approval Date'),
                        _field(
                          'supportingDocuments',
                          'Supporting Documents',
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
                              ? 'Save Action'
                              : 'Update Action',
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

class _PermitActionDetails extends StatelessWidget {
  final Map<String, dynamic> record;

  const _PermitActionDetails({required this.record});

  String _label(String key) {
    const labels = {
      'recordNo': 'Action Record No.',
      'permitNo': 'Original Permit No.',
      'project': 'Project',
      'location': 'Location',
      'department': 'Department',
      'actionType': 'Action Type',
      'permitType': 'Permit Type',
      'suspensionReason': 'Suspension Reason',
      'revalidationTrigger': 'Revalidation Trigger',
      'status': 'Status',
      'activity': 'Activity',
      'permitHolder': 'Permit Holder',
      'performingAuthority': 'Performing Authority',
      'issuingAuthority': 'Issuing Authority',
      'hseReviewer': 'HSE Reviewer',
      'originalStartDate': 'Original Start',
      'originalExpiryDate': 'Original Expiry',
      'requestedExpiryDate': 'Requested Expiry',
      'newExpiryDate': 'New Expiry',
      'suspensionDate': 'Suspension Date',
      'resumptionDate': 'Resumption Date',
      'revalidationDate': 'Revalidation Date',
      'approvalDate': 'Approval Date',
      'approvedBy': 'Approved By',
      'reason': 'Reason',
      'changeDescription': 'Change Description',
      'workProgress': 'Work Progress',
      'conditionsReview': 'Condition Review',
      'riskAssessmentReference': 'Risk Assessment Ref.',
      'jsaReference': 'JSA / JHA Ref.',
      'ramsReference': 'RAMS Ref.',
      'permitConditions': 'Permit Conditions',
      'isolationDetails': 'Isolation / LOTO',
      'gasTestDetails': 'Gas Test',
      'competencyDetails': 'Competency',
      'equipmentDetails': 'Equipment',
      'siteConditionDetails': 'Site Conditions',
      'emergencyDetails': 'Emergency',
      'additionalControls': 'Additional Controls',
      'suspensionAction': 'Suspension Action',
      'resumptionConditions': 'Resumption Conditions',
      'revalidationFindings': 'Revalidation Findings',
      'communicationDetails': 'Communication',
      'toolboxTalkDetails': 'Toolbox Talk',
      'updatedPermitReference': 'Updated Permit Ref.',
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
      'conditionsReviewed',
      'riskAssessmentStillValid',
      'jsaStillValid',
      'ramsStillValid',
      'permitConditionsStillValid',
      'isolationStillValid',
      'gasTestStillValid',
      'competencyStillValid',
      'equipmentStillValid',
      'siteConditionsStillValid',
      'emergencyArrangementsStillValid',
      'extensionApproved',
      'suspensionCommunicated',
      'revalidationApproved',
      'toolboxTalkRequired',
      'additionalControlsRequired',
      'permitCopyUpdated',
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
              'Permit Action Details',
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
