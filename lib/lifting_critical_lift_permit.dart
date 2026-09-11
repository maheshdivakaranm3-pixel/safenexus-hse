import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LiftingCriticalLiftPermitPage extends StatefulWidget {
  const LiftingCriticalLiftPermitPage({super.key});

  @override
  State<LiftingCriticalLiftPermitPage> createState() =>
      _LiftingCriticalLiftPermitPageState();
}

class _LiftingCriticalLiftPermitPageState
    extends State<LiftingCriticalLiftPermitPage> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const String storageKey =
      'safenexus_hse_lifting_critical_lift_permits';

  final permitStatuses = const [
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

  final liftTypes = const [
    'Routine Lift',
    'Heavy Lift',
    'Critical Lift',
    'Tandem / Multiple Crane Lift',
    'Blind Lift',
    'Personnel Lifting',
    'Lifting Near Live Plant',
    'Lifting Near Power Line',
    'Other',
  ];

  final craneTypes = const [
    'Mobile Crane',
    'Crawler Crane',
    'Tower Crane',
    'Rough Terrain Crane',
    'Truck Mounted Crane',
    'All Terrain Crane',
    'Overhead / Gantry Crane',
    'Other',
  ];

  final accessoryTypes = const [
    'Web Sling',
    'Wire Rope Sling',
    'Chain Sling',
    'Shackle',
    'Spreader Beam',
    'Lifting Beam',
    'Plate Clamp',
    'Lifting Magnet',
    'Other',
  ];

  final groundConditions = const [
    'Verified Suitable',
    'Suitable with Matting',
    'Requires Improvement',
    'Not Verified',
  ];

  final weatherConditions = const [
    'Suitable',
    'Monitor',
    'Unsuitable',
    'Not Applicable',
  ];

  final communicationMethods = const [
    'Radio',
    'Hand Signals',
    'Radio + Hand Signals',
    'Direct Verbal Communication',
    'Other',
  ];

  List<Map<String, dynamic>> records = [];
  bool loading = true;
  String search = '';
  String statusFilter = 'All';
  String liftTypeFilter = 'All';

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
            record['loadDescription'],
            record['liftType'],
            record['craneType'],
            record['liftingSupervisor'],
            record['status'],
          ].join(' ').toLowerCase().contains(q);
      final matchesStatus =
          statusFilter == 'All' || record['status'] == statusFilter;
      final matchesType =
          liftTypeFilter == 'All' || record['liftType'] == liftTypeFilter;
      return matchesSearch && matchesStatus && matchesType;
    }).toList();
  }

  int _count(String status) =>
      records.where((record) => record['status'] == status).length;

  int get activeCount => _count('Issued') + _count('Active');

  int get pendingCount =>
      _count('Requested') +
      _count('Under Review') +
      _count('Changes Required') +
      _count('Closure Pending');

  int get criticalCount =>
      records.where((record) => record['liftType'] == 'Critical Lift').length;

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
      builder: (_) => _LiftingPermitForm(
        existing: existing,
        permitStatuses: permitStatuses,
        liftTypes: liftTypes,
        craneTypes: craneTypes,
        accessoryTypes: accessoryTypes,
        groundConditions: groundConditions,
        weatherConditions: weatherConditions,
        communicationMethods: communicationMethods,
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
        content: const Text('Delete this lifting / critical lift permit?'),
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
      builder: (_) => _LiftingDetailsSheet(record: record),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lifting & Critical Lift Permit'),
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
                _LiftingDashboard(
                  total: records.length,
                  pending: pendingCount,
                  active: activeCount,
                  critical: criticalCount,
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
                                ...permitStatuses.map(
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
                              initialValue: liftTypeFilter,
                              decoration: const InputDecoration(
                                labelText: 'Lift Type',
                                border: OutlineInputBorder(),
                              ),
                              items: [
                                const DropdownMenuItem(
                                  value: 'All',
                                  child: Text('All'),
                                ),
                                ...liftTypes.map(
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
                                () => liftTypeFilter = value ?? 'All',
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
                            'No lifting permit records found.',
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.fromLTRB(12, 0, 12, 90),
                          itemCount: filteredRecords.length,
                          itemBuilder: (_, index) {
                            final record = filteredRecords[index];
                            final realIndex = records.indexOf(record);
                            final overdue = _isOverdue(record);
                            final critical =
                                record['liftType'] == 'Critical Lift';
                            return Card(
                              margin: const EdgeInsets.only(bottom: 10),
                              child: ListTile(
                                onTap: () => _details(record),
                                leading: CircleAvatar(
                                  backgroundColor: overdue
                                      ? Colors.red
                                      : critical
                                          ? Colors.orange
                                          : primaryGreen,
                                  foregroundColor: Colors.white,
                                  child: const Icon(Icons.precision_manufacturing),
                                ),
                                title: Text(
                                  record['permitNo']?.toString().isNotEmpty ==
                                          true
                                      ? record['permitNo'].toString()
                                      : 'Lift Permit',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  '${record['liftType'] ?? ''} • '
                                  '${record['craneType'] ?? ''}\n'
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

class _LiftingDashboard extends StatelessWidget {
  final int total;
  final int pending;
  final int active;
  final int critical;
  final int overdue;

  const _LiftingDashboard({
    required this.total,
    required this.pending,
    required this.active,
    required this.critical,
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
            label: 'Pending',
            value: pending,
            icon: Icons.pending_actions,
          ),
          _DashboardTile(
            label: 'Active',
            value: active,
            icon: Icons.construction,
          ),
          _DashboardTile(
            label: 'Critical',
            value: critical,
            icon: Icons.warning,
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
      width: 104,
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

class _LiftingPermitForm extends StatefulWidget {
  final Map<String, dynamic>? existing;
  final List<String> permitStatuses;
  final List<String> liftTypes;
  final List<String> craneTypes;
  final List<String> accessoryTypes;
  final List<String> groundConditions;
  final List<String> weatherConditions;
  final List<String> communicationMethods;

  const _LiftingPermitForm({
    required this.existing,
    required this.permitStatuses,
    required this.liftTypes,
    required this.craneTypes,
    required this.accessoryTypes,
    required this.groundConditions,
    required this.weatherConditions,
    required this.communicationMethods,
  });

  @override
  State<_LiftingPermitForm> createState() => _LiftingPermitFormState();
}

class _LiftingPermitFormState extends State<_LiftingPermitForm> {
  static const Color primaryGreen = Color(0xFF159447);

  final formKey = GlobalKey<FormState>();
  final controllers = <String, TextEditingController>{};

  late String liftType;
  late String craneType;
  late String accessoryType;
  late String groundCondition;
  late String weatherCondition;
  late String communicationMethod;
  late String status;

  bool criticalLiftAssessment = false;
  bool tandemLift = false;
  bool blindLift = false;
  bool powerLineRisk = false;
  bool livePlantRisk = false;
  bool groundVerified = true;
  bool craneCertificateVerified = true;
  bool craneInspectionVerified = true;
  bool accessoryCertificateVerified = true;
  bool operatorCompetent = true;
  bool liftingSupervisorCompetent = true;
  bool banksmanSlingerCompetent = true;
  bool loadWeightVerified = true;
  bool centreOfGravityVerified = true;
  bool liftingPointVerified = true;
  bool exclusionZoneRequired = true;
  bool tagLineRequired = true;
  bool trialLiftRequired = true;
  bool communicationConfirmed = true;
  bool weatherMonitoringRequired = true;
  bool emergencyRescueRequired = true;

  @override
  void initState() {
    super.initState();

    const fields = [
      'permitNo',
      'project',
      'location',
      'department',
      'activity',
      'liftDescription',
      'loadDescription',
      'loadWeight',
      'loadDimensions',
      'centreOfGravity',
      'liftingPoints',
      'liftRadius',
      'liftingHeight',
      'groundDetails',
      'craneModel',
      'craneId',
      'craneCapacity',
      'maxRadiusCapacity',
      'boomLength',
      'counterweight',
      'outriggerDetails',
      'craneCertificate',
      'craneInspection',
      'accessoryDetails',
      'accessoryCertificate',
      'accessorySwl',
      'liftingSupervisor',
      'operator',
      'banksmanSlinger',
      'additionalWorkers',
      'competencyCertificates',
      'riskAssessmentRef',
      'jsaJhaRef',
      'ramsRef',
      'liftPlanRef',
      'criticalLiftCriteria',
      'powerLineDetails',
      'livePlantDetails',
      'exclusionZoneDetails',
      'tagLineDetails',
      'trialLiftDetails',
      'communicationDetails',
      'weatherDetails',
      'windSpeed',
      'weatherMonitoringDetails',
      'emergencyRescueDetails',
      'requiredPpe',
      'permitConditions',
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

    liftType =
        widget.existing?['liftType']?.toString() ?? widget.liftTypes.first;
    craneType =
        widget.existing?['craneType']?.toString() ?? widget.craneTypes.first;
    accessoryType = widget.existing?['accessoryType']?.toString() ??
        widget.accessoryTypes.first;
    groundCondition = widget.existing?['groundCondition']?.toString() ??
        widget.groundConditions.first;
    weatherCondition = widget.existing?['weatherCondition']?.toString() ??
        widget.weatherConditions.first;
    communicationMethod =
        widget.existing?['communicationMethod']?.toString() ??
            widget.communicationMethods.first;
    status = widget.existing?['status']?.toString() ?? 'Draft';

    criticalLiftAssessment =
        widget.existing?['criticalLiftAssessment']?.toString() == 'true';
    tandemLift = widget.existing?['tandemLift']?.toString() == 'true';
    blindLift = widget.existing?['blindLift']?.toString() == 'true';
    powerLineRisk = widget.existing?['powerLineRisk']?.toString() == 'true';
    livePlantRisk = widget.existing?['livePlantRisk']?.toString() == 'true';
    groundVerified =
        widget.existing?['groundVerified']?.toString() != 'false';
    craneCertificateVerified =
        widget.existing?['craneCertificateVerified']?.toString() != 'false';
    craneInspectionVerified =
        widget.existing?['craneInspectionVerified']?.toString() != 'false';
    accessoryCertificateVerified =
        widget.existing?['accessoryCertificateVerified']?.toString() !=
            'false';
    operatorCompetent =
        widget.existing?['operatorCompetent']?.toString() != 'false';
    liftingSupervisorCompetent =
        widget.existing?['liftingSupervisorCompetent']?.toString() != 'false';
    banksmanSlingerCompetent =
        widget.existing?['banksmanSlingerCompetent']?.toString() != 'false';
    loadWeightVerified =
        widget.existing?['loadWeightVerified']?.toString() != 'false';
    centreOfGravityVerified =
        widget.existing?['centreOfGravityVerified']?.toString() != 'false';
    liftingPointVerified =
        widget.existing?['liftingPointVerified']?.toString() != 'false';
    exclusionZoneRequired =
        widget.existing?['exclusionZoneRequired']?.toString() != 'false';
    tagLineRequired =
        widget.existing?['tagLineRequired']?.toString() != 'false';
    trialLiftRequired =
        widget.existing?['trialLiftRequired']?.toString() != 'false';
    communicationConfirmed =
        widget.existing?['communicationConfirmed']?.toString() != 'false';
    weatherMonitoringRequired =
        widget.existing?['weatherMonitoringRequired']?.toString() != 'false';
    emergencyRescueRequired =
        widget.existing?['emergencyRescueRequired']?.toString() != 'false';
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

    if (liftType == 'Critical Lift' && !criticalLiftAssessment) {
      _error('Critical Lift Assessment must be confirmed.');
      return false;
    }

    if (tandemLift && _text('criticalLiftCriteria').isEmpty) {
      _error('Tandem lift control / critical lift criteria are required.');
      return false;
    }

    if (!loadWeightVerified || _text('loadWeight').isEmpty) {
      _error('Verified load weight is required.');
      return false;
    }

    if (!centreOfGravityVerified || _text('centreOfGravity').isEmpty) {
      _error('Centre of gravity must be verified.');
      return false;
    }

    if (!liftingPointVerified || _text('liftingPoints').isEmpty) {
      _error('Lifting points must be verified.');
      return false;
    }

    if (!groundVerified || groundCondition == 'Not Verified') {
      _error('Crane ground condition must be verified.');
      return false;
    }

    if (!craneCertificateVerified || _text('craneCertificate').isEmpty) {
      _error('Crane certificate details are required.');
      return false;
    }

    if (!craneInspectionVerified || _text('craneInspection').isEmpty) {
      _error('Crane inspection details are required.');
      return false;
    }

    if (!accessoryCertificateVerified ||
        _text('accessoryCertificate').isEmpty) {
      _error('Lifting accessory certificate details are required.');
      return false;
    }

    if (_text('accessorySwl').isEmpty) {
      _error('Lifting accessory SWL is required.');
      return false;
    }

    if (!operatorCompetent || _text('operator').isEmpty) {
      _error('Competent crane operator is required.');
      return false;
    }

    if (!liftingSupervisorCompetent ||
        _text('liftingSupervisor').isEmpty) {
      _error('Competent lifting supervisor is required.');
      return false;
    }

    if (!banksmanSlingerCompetent ||
        _text('banksmanSlinger').isEmpty) {
      _error('Competent banksman / slinger is required.');
      return false;
    }

    if (_text('riskAssessmentRef').isEmpty ||
        _text('jsaJhaRef').isEmpty ||
        _text('ramsRef').isEmpty ||
        _text('liftPlanRef').isEmpty) {
      _error('HIRA, JSA/JHA, RAMS and Lift Plan references are required.');
      return false;
    }

    if (powerLineRisk && _text('powerLineDetails').isEmpty) {
      _error('Power-line risk controls are required.');
      return false;
    }

    if (livePlantRisk && _text('livePlantDetails').isEmpty) {
      _error('Live-plant lifting controls are required.');
      return false;
    }

    if (exclusionZoneRequired && _text('exclusionZoneDetails').isEmpty) {
      _error('Lifting exclusion-zone details are required.');
      return false;
    }

    if (tagLineRequired && _text('tagLineDetails').isEmpty) {
      _error('Tag-line requirements/details are required.');
      return false;
    }

    if (trialLiftRequired && _text('trialLiftDetails').isEmpty) {
      _error('Trial-lift procedure/details are required.');
      return false;
    }

    if (!communicationConfirmed || _text('communicationDetails').isEmpty) {
      _error('Lifting communication arrangements are required.');
      return false;
    }

    if (weatherMonitoringRequired &&
        (_text('weatherDetails').isEmpty || _text('windSpeed').isEmpty)) {
      _error('Weather and wind-speed controls are required.');
      return false;
    }

    if (emergencyRescueRequired &&
        _text('emergencyRescueDetails').isEmpty) {
      _error('Emergency / rescue arrangements are required.');
      return false;
    }

    if (['Under Review', 'Approved', 'Issued', 'Active'].contains(status) &&
        _text('approvedBy').isEmpty) {
      _error('Approved By is required for this status.');
      return false;
    }

    if (['Issued', 'Active'].contains(status) &&
        (_text('approvalDate').isEmpty ||
            _text('issueDate').isEmpty ||
            _text('workStart').isEmpty ||
            _text('workEnd').isEmpty)) {
      _error(
        'Approval Date, Issue Date, Work Start and Work End are required.',
      );
      return false;
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
        (_text('closureDate').isEmpty || _text('closedBy').isEmpty)) {
      _error('Closure Date and Closed By are required.');
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
      'liftType': liftType,
      'craneType': craneType,
      'accessoryType': accessoryType,
      'groundCondition': groundCondition,
      'weatherCondition': weatherCondition,
      'communicationMethod': communicationMethod,
      'activity': _text('activity'),
      'liftDescription': _text('liftDescription'),
      'loadDescription': _text('loadDescription'),
      'loadWeight': _text('loadWeight'),
      'loadDimensions': _text('loadDimensions'),
      'centreOfGravity': _text('centreOfGravity'),
      'liftingPoints': _text('liftingPoints'),
      'liftRadius': _text('liftRadius'),
      'liftingHeight': _text('liftingHeight'),
      'groundDetails': _text('groundDetails'),
      'craneModel': _text('craneModel'),
      'craneId': _text('craneId'),
      'craneCapacity': _text('craneCapacity'),
      'maxRadiusCapacity': _text('maxRadiusCapacity'),
      'boomLength': _text('boomLength'),
      'counterweight': _text('counterweight'),
      'outriggerDetails': _text('outriggerDetails'),
      'craneCertificate': _text('craneCertificate'),
      'craneInspection': _text('craneInspection'),
      'accessoryDetails': _text('accessoryDetails'),
      'accessoryCertificate': _text('accessoryCertificate'),
      'accessorySwl': _text('accessorySwl'),
      'liftingSupervisor': _text('liftingSupervisor'),
      'operator': _text('operator'),
      'banksmanSlinger': _text('banksmanSlinger'),
      'additionalWorkers': _text('additionalWorkers'),
      'competencyCertificates': _text('competencyCertificates'),
      'riskAssessmentRef': _text('riskAssessmentRef'),
      'jsaJhaRef': _text('jsaJhaRef'),
      'ramsRef': _text('ramsRef'),
      'liftPlanRef': _text('liftPlanRef'),
      'criticalLiftCriteria': _text('criticalLiftCriteria'),
      'powerLineDetails': _text('powerLineDetails'),
      'livePlantDetails': _text('livePlantDetails'),
      'exclusionZoneDetails': _text('exclusionZoneDetails'),
      'tagLineDetails': _text('tagLineDetails'),
      'trialLiftDetails': _text('trialLiftDetails'),
      'communicationDetails': _text('communicationDetails'),
      'weatherDetails': _text('weatherDetails'),
      'windSpeed': _text('windSpeed'),
      'weatherMonitoringDetails': _text('weatherMonitoringDetails'),
      'emergencyRescueDetails': _text('emergencyRescueDetails'),
      'requiredPpe': _text('requiredPpe'),
      'permitConditions': _text('permitConditions'),
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
      'criticalLiftAssessment': criticalLiftAssessment,
      'tandemLift': tandemLift,
      'blindLift': blindLift,
      'powerLineRisk': powerLineRisk,
      'livePlantRisk': livePlantRisk,
      'groundVerified': groundVerified,
      'craneCertificateVerified': craneCertificateVerified,
      'craneInspectionVerified': craneInspectionVerified,
      'accessoryCertificateVerified': accessoryCertificateVerified,
      'operatorCompetent': operatorCompetent,
      'liftingSupervisorCompetent': liftingSupervisorCompetent,
      'banksmanSlingerCompetent': banksmanSlingerCompetent,
      'loadWeightVerified': loadWeightVerified,
      'centreOfGravityVerified': centreOfGravityVerified,
      'liftingPointVerified': liftingPointVerified,
      'exclusionZoneRequired': exclusionZoneRequired,
      'tagLineRequired': tagLineRequired,
      'trialLiftRequired': trialLiftRequired,
      'communicationConfirmed': communicationConfirmed,
      'weatherMonitoringRequired': weatherMonitoringRequired,
      'emergencyRescueRequired': emergencyRescueRequired,
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
                      'Lifting & Critical Lift Permit',
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
                      '1. Permit & Lift Details',
                      Icons.assignment,
                      [
                        _field('permitNo', 'Permit No.', required: true),
                        _dropdown(
                          'Lift Type',
                          liftType,
                          widget.liftTypes,
                          (value) => setState(
                            () => liftType = value ?? liftType,
                          ),
                        ),
                        _field('project', 'Project', required: true),
                        _field('location', 'Location', required: true),
                        _field('department', 'Department'),
                        _field('activity', 'Lifting Activity', required: true),
                        _field(
                          'liftDescription',
                          'Lift Description',
                          maxLines: 3,
                          required: true,
                        ),
                        _field(
                          'loadDescription',
                          'Load Description',
                          maxLines: 3,
                          required: true,
                        ),
                        _field(
                          'loadWeight',
                          'Load Weight / Unit',
                          required: true,
                        ),
                        _field(
                          'loadDimensions',
                          'Load Dimensions',
                          required: true,
                        ),
                        _field(
                          'centreOfGravity',
                          'Centre of Gravity',
                          required: true,
                        ),
                        _field(
                          'liftingPoints',
                          'Lifting Points / Attachment Details',
                          maxLines: 3,
                          required: true,
                        ),
                        _field('liftRadius', 'Lift Radius'),
                        _field('liftingHeight', 'Lifting Height'),
                      ],
                    ),
                    _section(
                      '2. Crane & Lifting Equipment',
                      Icons.precision_manufacturing,
                      [
                        _dropdown(
                          'Crane Type',
                          craneType,
                          widget.craneTypes,
                          (value) => setState(
                            () => craneType = value ?? craneType,
                          ),
                        ),
                        _field('craneModel', 'Crane Model / Make', required: true),
                        _field('craneId', 'Crane ID / Registration', required: true),
                        _field(
                          'craneCapacity',
                          'Crane Rated Capacity / SWL',
                          required: true,
                        ),
                        _field(
                          'maxRadiusCapacity',
                          'Capacity at Maximum Lift Radius',
                          required: true,
                        ),
                        _field('boomLength', 'Boom Length / Configuration'),
                        _field('counterweight', 'Counterweight'),
                        _field(
                          'outriggerDetails',
                          'Outrigger / Crane Setup Details',
                          maxLines: 3,
                          required: true,
                        ),
                        _field(
                          'craneCertificate',
                          'Crane Certificate / Third-Party Inspection',
                          maxLines: 3,
                          required: true,
                        ),
                        _field(
                          'craneInspection',
                          'Pre-Use Crane Inspection',
                          maxLines: 3,
                          required: true,
                        ),
                        _dropdown(
                          'Primary Lifting Accessory',
                          accessoryType,
                          widget.accessoryTypes,
                          (value) => setState(
                            () => accessoryType = value ?? accessoryType,
                          ),
                        ),
                        _field(
                          'accessoryDetails',
                          'Lifting Accessories Details',
                          maxLines: 3,
                          required: true,
                        ),
                        _field(
                          'accessoryCertificate',
                          'Accessory Certificates / Inspection',
                          maxLines: 3,
                          required: true,
                        ),
                        _field(
                          'accessorySwl',
                          'Accessory SWL / WLL',
                          required: true,
                        ),
                      ],
                    ),
                    _section(
                      '3. Ground & Site Conditions',
                      Icons.foundation,
                      [
                        _dropdown(
                          'Ground Condition',
                          groundCondition,
                          widget.groundConditions,
                          (value) => setState(
                            () => groundCondition =
                                value ?? groundCondition,
                          ),
                        ),
                        _switch(
                          'Ground Condition Verified',
                          groundVerified,
                          (value) => setState(
                            () => groundVerified = value,
                          ),
                        ),
                        _field(
                          'groundDetails',
                          'Ground Bearing / Matting / Outrigger Details',
                          maxLines: 4,
                          required: true,
                        ),
                        _switch(
                          'Exclusion / Lifting Zone Required',
                          exclusionZoneRequired,
                          (value) => setState(
                            () => exclusionZoneRequired = value,
                          ),
                        ),
                        if (exclusionZoneRequired)
                          _field(
                            'exclusionZoneDetails',
                            'Exclusion Zone / Barricade Details',
                            maxLines: 3,
                            required: true,
                          ),
                      ],
                    ),
                    _section(
                      '4. Competency & Lifting Team',
                      Icons.groups,
                      [
                        _field(
                          'liftingSupervisor',
                          'Lifting Supervisor',
                          required: true,
                        ),
                        _switch(
                          'Lifting Supervisor Competent',
                          liftingSupervisorCompetent,
                          (value) => setState(
                            () => liftingSupervisorCompetent = value,
                          ),
                        ),
                        _field(
                          'operator',
                          'Crane Operator',
                          required: true,
                        ),
                        _switch(
                          'Crane Operator Competent / Certified',
                          operatorCompetent,
                          (value) => setState(
                            () => operatorCompetent = value,
                          ),
                        ),
                        _field(
                          'banksmanSlinger',
                          'Banksman / Slinger',
                          required: true,
                        ),
                        _switch(
                          'Banksman / Slinger Competent',
                          banksmanSlingerCompetent,
                          (value) => setState(
                            () => banksmanSlingerCompetent = value,
                          ),
                        ),
                        _field(
                          'additionalWorkers',
                          'Additional Lifting Team',
                          maxLines: 3,
                        ),
                        _field(
                          'competencyCertificates',
                          'Competency / Certification References',
                          maxLines: 3,
                          required: true,
                        ),
                      ],
                    ),
                    _section(
                      '5. Risk Assessment & Lift Plan',
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
                          'liftPlanRef',
                          'Lift Plan / Lifting Study Reference',
                          required: true,
                        ),
                        _switch(
                          'Critical Lift Assessment Confirmed',
                          criticalLiftAssessment,
                          (value) => setState(
                            () => criticalLiftAssessment = value,
                          ),
                        ),
                        _switch(
                          'Tandem / Multiple Crane Lift',
                          tandemLift,
                          (value) => setState(
                            () => tandemLift = value,
                          ),
                        ),
                        _switch(
                          'Blind Lift',
                          blindLift,
                          (value) => setState(
                            () => blindLift = value,
                          ),
                        ),
                        _field(
                          'criticalLiftCriteria',
                          'Critical Lift Criteria / Controls',
                          maxLines: 4,
                        ),
                      ],
                    ),
                    _section(
                      '6. Special Hazards & Controls',
                      Icons.warning_amber,
                      [
                        _switch(
                          'Power-Line Risk',
                          powerLineRisk,
                          (value) => setState(
                            () => powerLineRisk = value,
                          ),
                        ),
                        if (powerLineRisk)
                          _field(
                            'powerLineDetails',
                            'Power-Line Clearance / Control Details',
                            maxLines: 4,
                            required: true,
                          ),
                        _switch(
                          'Live Plant / Operating Facility Risk',
                          livePlantRisk,
                          (value) => setState(
                            () => livePlantRisk = value,
                          ),
                        ),
                        if (livePlantRisk)
                          _field(
                            'livePlantDetails',
                            'Live Plant / Interface Controls',
                            maxLines: 4,
                            required: true,
                          ),
                        _switch(
                          'Tag Line Required',
                          tagLineRequired,
                          (value) => setState(
                            () => tagLineRequired = value,
                          ),
                        ),
                        if (tagLineRequired)
                          _field(
                            'tagLineDetails',
                            'Tag Line / Load Control Details',
                            maxLines: 3,
                            required: true,
                          ),
                        _switch(
                          'Trial Lift Required',
                          trialLiftRequired,
                          (value) => setState(
                            () => trialLiftRequired = value,
                          ),
                        ),
                        if (trialLiftRequired)
                          _field(
                            'trialLiftDetails',
                            'Trial Lift / Balance Verification',
                            maxLines: 3,
                            required: true,
                          ),
                      ],
                    ),
                    _section(
                      '7. Communication, Weather & Emergency',
                      Icons.settings_remote,
                      [
                        _dropdown(
                          'Communication Method',
                          communicationMethod,
                          widget.communicationMethods,
                          (value) => setState(
                            () => communicationMethod =
                                value ?? communicationMethod,
                          ),
                        ),
                        _switch(
                          'Communication Confirmed',
                          communicationConfirmed,
                          (value) => setState(
                            () => communicationConfirmed = value,
                          ),
                        ),
                        _field(
                          'communicationDetails',
                          'Communication / Signal Plan',
                          maxLines: 3,
                          required: true,
                        ),
                        _dropdown(
                          'Weather Condition',
                          weatherCondition,
                          widget.weatherConditions,
                          (value) => setState(
                            () => weatherCondition =
                                value ?? weatherCondition,
                          ),
                        ),
                        _switch(
                          'Weather / Wind Monitoring Required',
                          weatherMonitoringRequired,
                          (value) => setState(
                            () => weatherMonitoringRequired = value,
                          ),
                        ),
                        _field(
                          'weatherDetails',
                          'Weather / Wind Control Details',
                          maxLines: 3,
                          required: true,
                        ),
                        _field(
                          'windSpeed',
                          'Permitted / Current Wind Speed',
                          required: true,
                        ),
                        _field(
                          'weatherMonitoringDetails',
                          'Weather Monitoring / Stop-Work Criteria',
                          maxLines: 3,
                        ),
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
                            'Emergency / Rescue Arrangement',
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
                          'permitConditions',
                          'Permit Conditions / Special Precautions',
                          maxLines: 4,
                          required: true,
                        ),
                        _field(
                          'supportingDocuments',
                          'Supporting Documents',
                          maxLines: 3,
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
                          widget.permitStatuses,
                          (value) => setState(
                            () => status = value ?? status,
                          ),
                        ),
                        _field('approvedBy', 'Approved By'),
                        _dateField('approvalDate', 'Approval Date'),
                        _dateField('issueDate', 'Permit Issue Date'),
                        _dateField(
                          'workStart',
                          'Lift Work Start',
                          required: true,
                        ),
                        _dateField(
                          'workEnd',
                          'Lift Work End',
                          required: true,
                        ),
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

class _LiftingDetailsSheet extends StatelessWidget {
  final Map<String, dynamic> record;

  const _LiftingDetailsSheet({required this.record});

  String _label(String key) {
    const labels = {
      'permitNo': 'Permit No.',
      'project': 'Project',
      'location': 'Location',
      'department': 'Department',
      'liftType': 'Lift Type',
      'craneType': 'Crane Type',
      'accessoryType': 'Primary Accessory',
      'groundCondition': 'Ground Condition',
      'weatherCondition': 'Weather Condition',
      'communicationMethod': 'Communication Method',
      'activity': 'Lifting Activity',
      'liftDescription': 'Lift Description',
      'loadDescription': 'Load Description',
      'loadWeight': 'Load Weight',
      'loadDimensions': 'Load Dimensions',
      'centreOfGravity': 'Centre of Gravity',
      'liftingPoints': 'Lifting Points',
      'liftRadius': 'Lift Radius',
      'liftingHeight': 'Lifting Height',
      'groundDetails': 'Ground Details',
      'craneModel': 'Crane Model',
      'craneId': 'Crane ID',
      'craneCapacity': 'Crane Capacity',
      'maxRadiusCapacity': 'Capacity at Max Radius',
      'boomLength': 'Boom Length',
      'counterweight': 'Counterweight',
      'outriggerDetails': 'Outrigger Setup',
      'craneCertificate': 'Crane Certificate',
      'craneInspection': 'Crane Inspection',
      'accessoryDetails': 'Accessories',
      'accessoryCertificate': 'Accessory Certificate',
      'accessorySwl': 'Accessory SWL / WLL',
      'liftingSupervisor': 'Lifting Supervisor',
      'operator': 'Crane Operator',
      'banksmanSlinger': 'Banksman / Slinger',
      'additionalWorkers': 'Additional Team',
      'competencyCertificates': 'Competency Certificates',
      'riskAssessmentRef': 'Risk Assessment Ref.',
      'jsaJhaRef': 'JSA / JHA Ref.',
      'ramsRef': 'RAMS Ref.',
      'liftPlanRef': 'Lift Plan Ref.',
      'criticalLiftCriteria': 'Critical Lift Criteria',
      'powerLineDetails': 'Power-Line Controls',
      'livePlantDetails': 'Live Plant Controls',
      'exclusionZoneDetails': 'Exclusion Zone',
      'tagLineDetails': 'Tag Line Controls',
      'trialLiftDetails': 'Trial Lift',
      'communicationDetails': 'Communication Plan',
      'weatherDetails': 'Weather Controls',
      'windSpeed': 'Wind Speed',
      'weatherMonitoringDetails': 'Weather Monitoring',
      'emergencyRescueDetails': 'Emergency / Rescue',
      'requiredPpe': 'Required PPE',
      'permitConditions': 'Permit Conditions',
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
      'criticalLiftAssessment',
      'tandemLift',
      'blindLift',
      'powerLineRisk',
      'livePlantRisk',
      'groundVerified',
      'craneCertificateVerified',
      'craneInspectionVerified',
      'accessoryCertificateVerified',
      'operatorCompetent',
      'liftingSupervisorCompetent',
      'banksmanSlingerCompetent',
      'loadWeightVerified',
      'centreOfGravityVerified',
      'liftingPointVerified',
      'exclusionZoneRequired',
      'tagLineRequired',
      'trialLiftRequired',
      'communicationConfirmed',
      'weatherMonitoringRequired',
      'emergencyRescueRequired',
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
              'Lifting Permit Details',
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
