import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LineBreakingPermitPage extends StatefulWidget {
  const LineBreakingPermitPage({super.key});

  @override
  State<LineBreakingPermitPage> createState() => _LineBreakingPermitPageState();
}

class _LineBreakingPermitPageState extends State<LineBreakingPermitPage> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const String storageKey =
      'safenexus_hse_line_breaking_permits';

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

  final breakingTypes = const [
    'Flange Breaking',
    'Pipe Opening',
    'Valve Removal',
    'Pump / Equipment Opening',
    'Tank / Vessel Opening',
    'Filter / Strainer Opening',
    'Hose / Flexible Connection Breaking',
    'Line Disconnection',
    'Drain / Vent Opening',
    'Chemical Line Breaking',
    'Other',
  ];

  final substances = const [
    'Hydrocarbon',
    'Flammable Gas',
    'Flammable Liquid',
    'Toxic Gas',
    'Toxic Liquid',
    'Corrosive Chemical',
    'Steam / Hot Water',
    'Compressed Air / Gas',
    'Water',
    'Waste / Contaminated Fluid',
    'Other',
  ];

  final isolationMethods = const [
    'Single Valve Isolation',
    'Double Valve Isolation',
    'Double Block and Bleed',
    'Blind / Spade Isolation',
    'Blank Flange',
    'Electrical / LOTO Isolation',
    'Mechanical Isolation',
    'Combination Isolation',
    'Other',
  ];

  final gasTestStatuses = const [
    'Not Required',
    'Required - Pending',
    'Completed - Acceptable',
    'Continuous Monitoring Required',
    'Unsatisfactory - Work Prohibited',
  ];

  final decontaminationMethods = const [
    'Drained',
    'Flushed',
    'Purged',
    'Steam Cleaned',
    'Gas Freed',
    'Chemically Neutralized',
    'Not Required',
    'Combination',
  ];

  List<Map<String, dynamic>> records = [];
  bool loading = true;
  String search = '';
  String statusFilter = 'All';
  String breakingTypeFilter = 'All';

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
            record['permitNo'],
            record['project'],
            record['location'],
            record['activity'],
            record['lineEquipment'],
            record['substance'],
            record['breakingType'],
            record['responsiblePerson'],
            record['status'],
          ].join(' ').toLowerCase().contains(q);

      final matchesStatus =
          statusFilter == 'All' || record['status'] == statusFilter;
      final matchesType = breakingTypeFilter == 'All' ||
          record['breakingType'] == breakingTypeFilter;

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

  int get highHazardCount => records.where((record) {
        final value = record['highHazard']?.toString();
        return value == 'true';
      }).length;

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
      builder: (_) => _LineBreakingForm(
        existing: existing,
        statuses: statuses,
        breakingTypes: breakingTypes,
        substances: substances,
        isolationMethods: isolationMethods,
        gasTestStatuses: gasTestStatuses,
        decontaminationMethods: decontaminationMethods,
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
        content: const Text('Delete this line-breaking permit?'),
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
      builder: (_) => _LineBreakingDetailsSheet(record: record),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Line Breaking / Containment Permit'),
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
                _LineBreakingDashboard(
                  total: records.length,
                  pending: pendingCount,
                  active: activeCount,
                  highHazard: highHazardCount,
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
                              initialValue: breakingTypeFilter,
                              decoration: const InputDecoration(
                                labelText: 'Breaking Type',
                                border: OutlineInputBorder(),
                              ),
                              items: [
                                const DropdownMenuItem(
                                  value: 'All',
                                  child: Text('All'),
                                ),
                                ...breakingTypes.map(
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
                                () => breakingTypeFilter = value ?? 'All',
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
                            'No line-breaking permit records found.',
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.fromLTRB(12, 0, 12, 90),
                          itemCount: filteredRecords.length,
                          itemBuilder: (_, index) {
                            final record = filteredRecords[index];
                            final realIndex = records.indexOf(record);
                            final overdue = _isOverdue(record);
                            final highHazard =
                                record['highHazard']?.toString() == 'true';

                            return Card(
                              margin: const EdgeInsets.only(bottom: 10),
                              child: ListTile(
                                onTap: () => _details(record),
                                leading: CircleAvatar(
                                  backgroundColor: overdue
                                      ? Colors.red
                                      : highHazard
                                          ? Colors.orange
                                          : primaryGreen,
                                  foregroundColor: Colors.white,
                                  child: const Icon(Icons.water_damage),
                                ),
                                title: Text(
                                  record['permitNo']?.toString().isNotEmpty ==
                                          true
                                      ? record['permitNo'].toString()
                                      : 'Line-Breaking Permit',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  '${record['breakingType'] ?? ''} • '
                                  '${record['substance'] ?? ''}\n'
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

class _LineBreakingDashboard extends StatelessWidget {
  final int total;
  final int pending;
  final int active;
  final int highHazard;
  final int overdue;

  const _LineBreakingDashboard({
    required this.total,
    required this.pending,
    required this.active,
    required this.highHazard,
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
            icon: Icons.play_circle,
          ),
          _DashboardTile(
            label: 'High Hazard',
            value: highHazard,
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

class _LineBreakingForm extends StatefulWidget {
  final Map<String, dynamic>? existing;
  final List<String> statuses;
  final List<String> breakingTypes;
  final List<String> substances;
  final List<String> isolationMethods;
  final List<String> gasTestStatuses;
  final List<String> decontaminationMethods;

  const _LineBreakingForm({
    required this.existing,
    required this.statuses,
    required this.breakingTypes,
    required this.substances,
    required this.isolationMethods,
    required this.gasTestStatuses,
    required this.decontaminationMethods,
  });

  @override
  State<_LineBreakingForm> createState() => _LineBreakingFormState();
}

class _LineBreakingFormState extends State<_LineBreakingForm> {
  static const Color primaryGreen = Color(0xFF159447);

  final formKey = GlobalKey<FormState>();
  final controllers = <String, TextEditingController>{};

  late String breakingType;
  late String substance;
  late String isolationMethod;
  late String gasTestStatus;
  late String decontaminationMethod;
  late String status;

  bool highHazard = false;
  bool lineIsolationRequired = true;
  bool mechanicalIsolationRequired = true;
  bool electricalIsolationRequired = false;
  bool lotoRequired = false;
  bool depressurizationRequired = true;
  bool drainRequired = true;
  bool ventRequired = true;
  bool flushingRequired = true;
  bool purgingRequired = false;
  bool blindSpadeRequired = false;
  bool doubleBlockBleedRequired = false;
  bool zeroEnergyVerified = true;
  bool gasTestRequired = false;
  bool continuousGasMonitoring = false;
  bool toxicGasMonitoring = false;
  bool spillControlRequired = true;
  bool fireProtectionRequired = true;
  bool emergencyRescueRequired = true;
  bool standbyRequired = false;
  bool exclusionZoneRequired = true;
  bool competentPersonRequired = true;

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
      'lineEquipment',
      'lineNumber',
      'equipmentTag',
      'substanceDetails',
      'processService',
      'pressure',
      'temperature',
      'lineSize',
      'breakingLocation',
      'upstreamIsolation',
      'downstreamIsolation',
      'isolationPoints',
      'isolationVerification',
      'lotoDetails',
      'blindSpadeDetails',
      'doubleBlockBleedDetails',
      'depressurizationDetails',
      'drainDetails',
      'ventDetails',
      'flushingDetails',
      'purgingDetails',
      'decontaminationDetails',
      'zeroEnergyDetails',
      'gasTestO2',
      'gasTestLEL',
      'gasTestToxic',
      'gasTestOther',
      'gasTestDateTime',
      'gasTester',
      'gasTestLocation',
      'continuousMonitoringDetails',
      'toxicGasDetails',
      'spillControlDetails',
      'fireProtectionDetails',
      'exclusionZoneDetails',
      'standbyDetails',
      'emergencyRescueDetails',
      'competentPerson',
      'workTeam',
      'riskAssessmentRef',
      'jsaJhaRef',
      'ramsRef',
      'supportingDocuments',
      'requiredPpe',
      'permitConditions',
      'emergencyContacts',
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

    breakingType = widget.existing?['breakingType']?.toString() ??
        widget.breakingTypes.first;
    substance =
        widget.existing?['substance']?.toString() ?? widget.substances.first;
    isolationMethod = widget.existing?['isolationMethod']?.toString() ??
        widget.isolationMethods.first;
    gasTestStatus = widget.existing?['gasTestStatus']?.toString() ??
        widget.gasTestStatuses.first;
    decontaminationMethod =
        widget.existing?['decontaminationMethod']?.toString() ??
            widget.decontaminationMethods.first;
    status = widget.existing?['status']?.toString() ?? 'Draft';

    highHazard = widget.existing?['highHazard']?.toString() == 'true';
    lineIsolationRequired =
        widget.existing?['lineIsolationRequired']?.toString() != 'false';
    mechanicalIsolationRequired =
        widget.existing?['mechanicalIsolationRequired']?.toString() != 'false';
    electricalIsolationRequired =
        widget.existing?['electricalIsolationRequired']?.toString() == 'true';
    lotoRequired = widget.existing?['lotoRequired']?.toString() == 'true';
    depressurizationRequired =
        widget.existing?['depressurizationRequired']?.toString() != 'false';
    drainRequired =
        widget.existing?['drainRequired']?.toString() != 'false';
    ventRequired =
        widget.existing?['ventRequired']?.toString() != 'false';
    flushingRequired =
        widget.existing?['flushingRequired']?.toString() != 'false';
    purgingRequired =
        widget.existing?['purgingRequired']?.toString() == 'true';
    blindSpadeRequired =
        widget.existing?['blindSpadeRequired']?.toString() == 'true';
    doubleBlockBleedRequired =
        widget.existing?['doubleBlockBleedRequired']?.toString() == 'true';
    zeroEnergyVerified =
        widget.existing?['zeroEnergyVerified']?.toString() != 'false';
    gasTestRequired =
        widget.existing?['gasTestRequired']?.toString() == 'true';
    continuousGasMonitoring =
        widget.existing?['continuousGasMonitoring']?.toString() == 'true';
    toxicGasMonitoring =
        widget.existing?['toxicGasMonitoring']?.toString() == 'true';
    spillControlRequired =
        widget.existing?['spillControlRequired']?.toString() != 'false';
    fireProtectionRequired =
        widget.existing?['fireProtectionRequired']?.toString() != 'false';
    emergencyRescueRequired =
        widget.existing?['emergencyRescueRequired']?.toString() != 'false';
    standbyRequired =
        widget.existing?['standbyRequired']?.toString() == 'true';
    exclusionZoneRequired =
        widget.existing?['exclusionZoneRequired']?.toString() != 'false';
    competentPersonRequired =
        widget.existing?['competentPersonRequired']?.toString() != 'false';
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

    if (competentPersonRequired && _text('competentPerson').isEmpty) {
      _error('Competent Person is required.');
      return false;
    }

    if (lineIsolationRequired && _text('isolationPoints').isEmpty) {
      _error('Line isolation points are required.');
      return false;
    }

    if (mechanicalIsolationRequired &&
        _text('isolationVerification').isEmpty) {
      _error('Mechanical isolation verification is required.');
      return false;
    }

    if (lotoRequired && _text('lotoDetails').isEmpty) {
      _error('LOTO details are required.');
      return false;
    }

    if (blindSpadeRequired && _text('blindSpadeDetails').isEmpty) {
      _error('Blind / spade isolation details are required.');
      return false;
    }

    if (doubleBlockBleedRequired &&
        _text('doubleBlockBleedDetails').isEmpty) {
      _error('Double block and bleed details are required.');
      return false;
    }

    if (depressurizationRequired &&
        _text('depressurizationDetails').isEmpty) {
      _error('Depressurization details are required.');
      return false;
    }

    if (drainRequired && _text('drainDetails').isEmpty) {
      _error('Drain details are required.');
      return false;
    }

    if (ventRequired && _text('ventDetails').isEmpty) {
      _error('Vent details are required.');
      return false;
    }

    if (flushingRequired && _text('flushingDetails').isEmpty) {
      _error('Flushing details are required.');
      return false;
    }

    if (purgingRequired && _text('purgingDetails').isEmpty) {
      _error('Purging details are required.');
      return false;
    }

    if (!zeroEnergyVerified || _text('zeroEnergyDetails').isEmpty) {
      _error('Zero-energy verification is required.');
      return false;
    }

    if (gasTestRequired) {
      if (gasTestStatus == 'Required - Pending' ||
          gasTestStatus == 'Unsatisfactory - Work Prohibited') {
        _error('Acceptable gas-test status is required before work.');
        return false;
      }

      if (_text('gasTester').isEmpty ||
          _text('gasTestDateTime').isEmpty ||
          _text('gasTestLocation').isEmpty) {
        _error('Gas tester, test time and test location are required.');
        return false;
      }
    }

    if (continuousGasMonitoring &&
        _text('continuousMonitoringDetails').isEmpty) {
      _error('Continuous gas-monitoring details are required.');
      return false;
    }

    if (toxicGasMonitoring && _text('toxicGasDetails').isEmpty) {
      _error('Toxic-gas monitoring controls are required.');
      return false;
    }

    if (spillControlRequired && _text('spillControlDetails').isEmpty) {
      _error('Spill-control arrangements are required.');
      return false;
    }

    if (fireProtectionRequired && _text('fireProtectionDetails').isEmpty) {
      _error('Fire-protection arrangements are required.');
      return false;
    }

    if (exclusionZoneRequired && _text('exclusionZoneDetails').isEmpty) {
      _error('Exclusion-zone details are required.');
      return false;
    }

    if (standbyRequired && _text('standbyDetails').isEmpty) {
      _error('Standby person details are required.');
      return false;
    }

    if (emergencyRescueRequired &&
        _text('emergencyRescueDetails').isEmpty) {
      _error('Emergency / rescue arrangements are required.');
      return false;
    }

    if (_text('riskAssessmentRef').isEmpty ||
        _text('jsaJhaRef').isEmpty ||
        _text('ramsRef').isEmpty) {
      _error('HIRA, JSA/JHA and RAMS references are required.');
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
      'breakingType': breakingType,
      'substance': substance,
      'isolationMethod': isolationMethod,
      'gasTestStatus': gasTestStatus,
      'decontaminationMethod': decontaminationMethod,
      'activity': _text('activity'),
      'workDescription': _text('workDescription'),
      'lineEquipment': _text('lineEquipment'),
      'lineNumber': _text('lineNumber'),
      'equipmentTag': _text('equipmentTag'),
      'substanceDetails': _text('substanceDetails'),
      'processService': _text('processService'),
      'pressure': _text('pressure'),
      'temperature': _text('temperature'),
      'lineSize': _text('lineSize'),
      'breakingLocation': _text('breakingLocation'),
      'upstreamIsolation': _text('upstreamIsolation'),
      'downstreamIsolation': _text('downstreamIsolation'),
      'isolationPoints': _text('isolationPoints'),
      'isolationVerification': _text('isolationVerification'),
      'lotoDetails': _text('lotoDetails'),
      'blindSpadeDetails': _text('blindSpadeDetails'),
      'doubleBlockBleedDetails': _text('doubleBlockBleedDetails'),
      'depressurizationDetails': _text('depressurizationDetails'),
      'drainDetails': _text('drainDetails'),
      'ventDetails': _text('ventDetails'),
      'flushingDetails': _text('flushingDetails'),
      'purgingDetails': _text('purgingDetails'),
      'decontaminationDetails': _text('decontaminationDetails'),
      'zeroEnergyDetails': _text('zeroEnergyDetails'),
      'gasTestO2': _text('gasTestO2'),
      'gasTestLEL': _text('gasTestLEL'),
      'gasTestToxic': _text('gasTestToxic'),
      'gasTestOther': _text('gasTestOther'),
      'gasTestDateTime': _text('gasTestDateTime'),
      'gasTester': _text('gasTester'),
      'gasTestLocation': _text('gasTestLocation'),
      'continuousMonitoringDetails': _text('continuousMonitoringDetails'),
      'toxicGasDetails': _text('toxicGasDetails'),
      'spillControlDetails': _text('spillControlDetails'),
      'fireProtectionDetails': _text('fireProtectionDetails'),
      'exclusionZoneDetails': _text('exclusionZoneDetails'),
      'standbyDetails': _text('standbyDetails'),
      'emergencyRescueDetails': _text('emergencyRescueDetails'),
      'competentPerson': _text('competentPerson'),
      'workTeam': _text('workTeam'),
      'riskAssessmentRef': _text('riskAssessmentRef'),
      'jsaJhaRef': _text('jsaJhaRef'),
      'ramsRef': _text('ramsRef'),
      'supportingDocuments': _text('supportingDocuments'),
      'requiredPpe': _text('requiredPpe'),
      'permitConditions': _text('permitConditions'),
      'emergencyContacts': _text('emergencyContacts'),
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
      'highHazard': highHazard,
      'lineIsolationRequired': lineIsolationRequired,
      'mechanicalIsolationRequired': mechanicalIsolationRequired,
      'electricalIsolationRequired': electricalIsolationRequired,
      'lotoRequired': lotoRequired,
      'depressurizationRequired': depressurizationRequired,
      'drainRequired': drainRequired,
      'ventRequired': ventRequired,
      'flushingRequired': flushingRequired,
      'purgingRequired': purgingRequired,
      'blindSpadeRequired': blindSpadeRequired,
      'doubleBlockBleedRequired': doubleBlockBleedRequired,
      'zeroEnergyVerified': zeroEnergyVerified,
      'gasTestRequired': gasTestRequired,
      'continuousGasMonitoring': continuousGasMonitoring,
      'toxicGasMonitoring': toxicGasMonitoring,
      'spillControlRequired': spillControlRequired,
      'fireProtectionRequired': fireProtectionRequired,
      'emergencyRescueRequired': emergencyRescueRequired,
      'standbyRequired': standbyRequired,
      'exclusionZoneRequired': exclusionZoneRequired,
      'competentPersonRequired': competentPersonRequired,
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
                      'Line Breaking / Containment Permit',
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
                        _field('permitNo', 'Permit No.', required: true),
                        _dropdown(
                          'Breaking Type',
                          breakingType,
                          widget.breakingTypes,
                          (value) => setState(
                            () => breakingType = value ?? breakingType,
                          ),
                        ),
                        _dropdown(
                          'Process Substance',
                          substance,
                          widget.substances,
                          (value) => setState(
                            () => substance = value ?? substance,
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
                          'lineEquipment',
                          'Line / Equipment',
                          required: true,
                        ),
                        _field('lineNumber', 'Line Number / Service'),
                        _field('equipmentTag', 'Equipment Tag'),
                        _field(
                          'breakingLocation',
                          'Exact Breaking Point',
                          maxLines: 2,
                          required: true,
                        ),
                        _field('processService', 'Process Service'),
                        _field('substanceDetails', 'Substance / Chemical Details'),
                        _field('pressure', 'Normal / Expected Pressure'),
                        _field('temperature', 'Normal / Expected Temperature'),
                        _field('lineSize', 'Line Size / Rating'),
                        _switch(
                          'High-Hazard Line / Service',
                          highHazard,
                          (value) => setState(() => highHazard = value),
                        ),
                      ],
                    ),
                    _section(
                      '2. Risk Assessment & Documents',
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
                          maxLines: 3,
                        ),
                      ],
                    ),
                    _section(
                      '3. Isolation & Containment',
                      Icons.lock,
                      [
                        _dropdown(
                          'Primary Isolation Method',
                          isolationMethod,
                          widget.isolationMethods,
                          (value) => setState(
                            () => isolationMethod =
                                value ?? isolationMethod,
                          ),
                        ),
                        _switch(
                          'Line Isolation Required',
                          lineIsolationRequired,
                          (value) => setState(
                            () => lineIsolationRequired = value,
                          ),
                        ),
                        _field(
                          'upstreamIsolation',
                          'Upstream Isolation Point',
                          maxLines: 2,
                          required: true,
                        ),
                        _field(
                          'downstreamIsolation',
                          'Downstream Isolation Point',
                          maxLines: 2,
                          required: true,
                        ),
                        _field(
                          'isolationPoints',
                          'All Isolation Points / Valves',
                          maxLines: 4,
                          required: true,
                        ),
                        _switch(
                          'Mechanical Isolation Required',
                          mechanicalIsolationRequired,
                          (value) => setState(
                            () => mechanicalIsolationRequired = value,
                          ),
                        ),
                        _field(
                          'isolationVerification',
                          'Isolation Verification',
                          maxLines: 3,
                          required: true,
                        ),
                        _switch(
                          'Electrical Isolation / LOTO Required',
                          electricalIsolationRequired,
                          (value) => setState(
                            () => electricalIsolationRequired = value,
                          ),
                        ),
                        _switch(
                          'LOTO Required',
                          lotoRequired,
                          (value) => setState(
                            () => lotoRequired = value,
                          ),
                        ),
                        if (lotoRequired)
                          _field(
                            'lotoDetails',
                            'LOTO Details',
                            maxLines: 3,
                            required: true,
                          ),
                        _switch(
                          'Blind / Spade Isolation Required',
                          blindSpadeRequired,
                          (value) => setState(
                            () => blindSpadeRequired = value,
                          ),
                        ),
                        if (blindSpadeRequired)
                          _field(
                            'blindSpadeDetails',
                            'Blind / Spade Details',
                            maxLines: 3,
                            required: true,
                          ),
                        _switch(
                          'Double Block & Bleed Required',
                          doubleBlockBleedRequired,
                          (value) => setState(
                            () => doubleBlockBleedRequired = value,
                          ),
                        ),
                        if (doubleBlockBleedRequired)
                          _field(
                            'doubleBlockBleedDetails',
                            'Double Block & Bleed Details',
                            maxLines: 3,
                            required: true,
                          ),
                      ],
                    ),
                    _section(
                      '4. Depressurization & Decontamination',
                      Icons.cleaning_services,
                      [
                        _switch(
                          'Depressurization Required',
                          depressurizationRequired,
                          (value) => setState(
                            () => depressurizationRequired = value,
                          ),
                        ),
                        _field(
                          'depressurizationDetails',
                          'Depressurization / Pressure Release',
                          maxLines: 3,
                          required: true,
                        ),
                        _switch(
                          'Drain Required',
                          drainRequired,
                          (value) =>
                              setState(() => drainRequired = value),
                        ),
                        _field(
                          'drainDetails',
                          'Drain / Collection Details',
                          maxLines: 3,
                          required: true,
                        ),
                        _switch(
                          'Vent Required',
                          ventRequired,
                          (value) => setState(() => ventRequired = value),
                        ),
                        _field(
                          'ventDetails',
                          'Vent / Discharge Details',
                          maxLines: 3,
                          required: true,
                        ),
                        _switch(
                          'Flushing Required',
                          flushingRequired,
                          (value) =>
                              setState(() => flushingRequired = value),
                        ),
                        _field(
                          'flushingDetails',
                          'Flushing Details',
                          maxLines: 3,
                          required: true,
                        ),
                        _switch(
                          'Purging Required',
                          purgingRequired,
                          (value) =>
                              setState(() => purgingRequired = value),
                        ),
                        _field(
                          'purgingDetails',
                          'Purging Details',
                          maxLines: 3,
                        ),
                        _dropdown(
                          'Decontamination Method',
                          decontaminationMethod,
                          widget.decontaminationMethods,
                          (value) => setState(
                            () => decontaminationMethod =
                                value ?? decontaminationMethod,
                          ),
                        ),
                        _field(
                          'decontaminationDetails',
                          'Decontamination / Cleaning Details',
                          maxLines: 4,
                          required: true,
                        ),
                        _switch(
                          'Zero-Energy Verification Completed',
                          zeroEnergyVerified,
                          (value) => setState(
                            () => zeroEnergyVerified = value,
                          ),
                        ),
                        _field(
                          'zeroEnergyDetails',
                          'Zero-Energy / Zero-Pressure Verification',
                          maxLines: 4,
                          required: true,
                        ),
                      ],
                    ),
                    _section(
                      '5. Gas Test & Atmospheric Controls',
                      Icons.air,
                      [
                        _dropdown(
                          'Gas Test Status',
                          gasTestStatus,
                          widget.gasTestStatuses,
                          (value) => setState(
                            () => gasTestStatus =
                                value ?? gasTestStatus,
                          ),
                        ),
                        _switch(
                          'Gas Test Required',
                          gasTestRequired,
                          (value) => setState(
                            () => gasTestRequired = value,
                          ),
                        ),
                        if (gasTestRequired) ...[
                          _field('gasTestO2', 'O₂ Reading'),
                          _field('gasTestLEL', 'LEL Reading'),
                          _field('gasTestToxic', 'Toxic Gas Reading'),
                          _field('gasTestOther', 'Other Gas Reading'),
                          _dateField(
                            'gasTestDateTime',
                            'Gas Test Date / Time',
                            required: true,
                          ),
                          _field('gasTester', 'Gas Tester', required: true),
                          _field(
                            'gasTestLocation',
                            'Gas Test Location',
                            required: true,
                          ),
                        ],
                        _switch(
                          'Continuous Gas Monitoring',
                          continuousGasMonitoring,
                          (value) => setState(
                            () => continuousGasMonitoring = value,
                          ),
                        ),
                        if (continuousGasMonitoring)
                          _field(
                            'continuousMonitoringDetails',
                            'Continuous Monitoring Details',
                            maxLines: 3,
                            required: true,
                          ),
                        _switch(
                          'Toxic Gas Monitoring Required',
                          toxicGasMonitoring,
                          (value) => setState(
                            () => toxicGasMonitoring = value,
                          ),
                        ),
                        if (toxicGasMonitoring)
                          _field(
                            'toxicGasDetails',
                            'Toxic Gas Monitoring / Escape Controls',
                            maxLines: 3,
                            required: true,
                          ),
                      ],
                    ),
                    _section(
                      '6. Spill, Fire & Work Area Controls',
                      Icons.warning_amber,
                      [
                        _switch(
                          'Spill Control Required',
                          spillControlRequired,
                          (value) => setState(
                            () => spillControlRequired = value,
                          ),
                        ),
                        _field(
                          'spillControlDetails',
                          'Spill / Leak Control and Containment',
                          maxLines: 4,
                          required: true,
                        ),
                        _switch(
                          'Fire Protection Required',
                          fireProtectionRequired,
                          (value) => setState(
                            () => fireProtectionRequired = value,
                          ),
                        ),
                        _field(
                          'fireProtectionDetails',
                          'Fire Protection / Fire Watch Arrangements',
                          maxLines: 4,
                          required: true,
                        ),
                        _switch(
                          'Exclusion Zone Required',
                          exclusionZoneRequired,
                          (value) => setState(
                            () => exclusionZoneRequired = value,
                          ),
                        ),
                        _field(
                          'exclusionZoneDetails',
                          'Barricade / Exclusion Zone',
                          maxLines: 3,
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
                      ],
                    ),
                    _section(
                      '7. Personnel & Emergency',
                      Icons.groups,
                      [
                        _switch(
                          'Competent Person Required',
                          competentPersonRequired,
                          (value) => setState(
                            () => competentPersonRequired = value,
                          ),
                        ),
                        _field(
                          'competentPerson',
                          'Competent Person',
                          required: true,
                        ),
                        _field(
                          'workTeam',
                          'Work Team / Authorized Workers',
                          maxLines: 4,
                          required: true,
                        ),
                        _switch(
                          'Standby Person Required',
                          standbyRequired,
                          (value) => setState(
                            () => standbyRequired = value,
                          ),
                        ),
                        if (standbyRequired)
                          _field(
                            'standbyDetails',
                            'Standby Person Details',
                            maxLines: 2,
                            required: true,
                          ),
                        _switch(
                          'Emergency / Rescue Required',
                          emergencyRescueRequired,
                          (value) => setState(
                            () => emergencyRescueRequired = value,
                          ),
                        ),
                        _field(
                          'emergencyRescueDetails',
                          'Emergency / Rescue Arrangements',
                          maxLines: 4,
                          required: true,
                        ),
                        _field(
                          'emergencyContacts',
                          'Emergency Contacts',
                          maxLines: 3,
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
                        _dateField(
                          'workStart',
                          'Work Start',
                          required: true,
                        ),
                        _dateField(
                          'workEnd',
                          'Work End',
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

class _LineBreakingDetailsSheet extends StatelessWidget {
  final Map<String, dynamic> record;

  const _LineBreakingDetailsSheet({required this.record});

  String _label(String key) {
    const labels = {
      'permitNo': 'Permit No.',
      'project': 'Project',
      'location': 'Location',
      'department': 'Department',
      'breakingType': 'Breaking Type',
      'substance': 'Substance',
      'isolationMethod': 'Isolation Method',
      'gasTestStatus': 'Gas Test Status',
      'decontaminationMethod': 'Decontamination Method',
      'activity': 'Activity',
      'workDescription': 'Work Description',
      'lineEquipment': 'Line / Equipment',
      'lineNumber': 'Line Number',
      'equipmentTag': 'Equipment Tag',
      'substanceDetails': 'Substance Details',
      'processService': 'Process Service',
      'pressure': 'Pressure',
      'temperature': 'Temperature',
      'lineSize': 'Line Size',
      'breakingLocation': 'Breaking Point',
      'upstreamIsolation': 'Upstream Isolation',
      'downstreamIsolation': 'Downstream Isolation',
      'isolationPoints': 'Isolation Points',
      'isolationVerification': 'Isolation Verification',
      'lotoDetails': 'LOTO',
      'blindSpadeDetails': 'Blind / Spade',
      'doubleBlockBleedDetails': 'Double Block & Bleed',
      'depressurizationDetails': 'Depressurization',
      'drainDetails': 'Drain',
      'ventDetails': 'Vent',
      'flushingDetails': 'Flushing',
      'purgingDetails': 'Purging',
      'decontaminationDetails': 'Decontamination',
      'zeroEnergyDetails': 'Zero-Energy Verification',
      'gasTestO2': 'O₂',
      'gasTestLEL': 'LEL',
      'gasTestToxic': 'Toxic Gas',
      'gasTestOther': 'Other Gas',
      'gasTestDateTime': 'Gas Test Date / Time',
      'gasTester': 'Gas Tester',
      'gasTestLocation': 'Gas Test Location',
      'continuousMonitoringDetails': 'Continuous Monitoring',
      'toxicGasDetails': 'Toxic Gas Controls',
      'spillControlDetails': 'Spill Control',
      'fireProtectionDetails': 'Fire Protection',
      'exclusionZoneDetails': 'Exclusion Zone',
      'standbyDetails': 'Standby Person',
      'emergencyRescueDetails': 'Emergency / Rescue',
      'competentPerson': 'Competent Person',
      'workTeam': 'Work Team',
      'riskAssessmentRef': 'Risk Assessment Ref.',
      'jsaJhaRef': 'JSA / JHA Ref.',
      'ramsRef': 'RAMS Ref.',
      'supportingDocuments': 'Supporting Documents',
      'requiredPpe': 'Required PPE',
      'permitConditions': 'Permit Conditions',
      'emergencyContacts': 'Emergency Contacts',
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
      'highHazard',
      'lineIsolationRequired',
      'mechanicalIsolationRequired',
      'electricalIsolationRequired',
      'lotoRequired',
      'depressurizationRequired',
      'drainRequired',
      'ventRequired',
      'flushingRequired',
      'purgingRequired',
      'blindSpadeRequired',
      'doubleBlockBleedRequired',
      'zeroEnergyVerified',
      'gasTestRequired',
      'continuousGasMonitoring',
      'toxicGasMonitoring',
      'spillControlRequired',
      'fireProtectionRequired',
      'emergencyRescueRequired',
      'standbyRequired',
      'exclusionZoneRequired',
      'competentPersonRequired',
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
              'Line-Breaking Permit Details',
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
