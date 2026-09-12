import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// SafeNexus HSE - Step 42
/// Emergency Preparedness & Response Center
///
/// Workflow:
/// Plan → Prepare → Report → Respond → Escalate → Control → Recover → Close → Analyze
///
/// Integration:
/// Step 9 Daily HSE
/// Step 31 Smart Checklists
/// Step 32 Field Operations
/// Step 34 Documents & Records
/// Step 35 Action Center
/// Step 36 Risk & Control
/// Step 37 RAMS
/// Step 38 PTW
/// Step 39 Workforce & Competency
/// Step 40 Equipment & Assets
/// Step 41 Inspection & Certification
///
/// No new dependency beyond SharedPreferences.

class SafeNexusStep42EmergencyResponsePage extends StatefulWidget {
  const SafeNexusStep42EmergencyResponsePage({
    super.key,
    this.sourceOpener,
  });

  final void Function(String referenceType, String referenceId)? sourceOpener;

  @override
  State<SafeNexusStep42EmergencyResponsePage> createState() =>
      _SafeNexusStep42EmergencyResponsePageState();
}

class _SafeNexusStep42EmergencyResponsePageState
    extends State<SafeNexusStep42EmergencyResponsePage> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);
  static const String storageKey =
      'safenexus_hse_step42_emergency_response';

  final TextEditingController _searchController = TextEditingController();

  final List<String> _emergencyTypes = const [
    'Fire',
    'Medical Emergency',
    'Serious Injury',
    'Chemical Spill / Release',
    'Gas Leak',
    'Confined Space Rescue',
    'Work at Height Rescue',
    'Electrical Emergency',
    'Explosion',
    'Vehicle / Traffic Incident',
    'Lifting Incident',
    'Marine / Port Emergency',
    'Environmental Emergency',
    'Extreme Weather / Heat',
    'Security Emergency',
    'Missing Person',
    'Evacuation',
    'Other',
  ];

  final List<String> _statuses = const [
    'Planned',
    'Ready',
    'Activated',
    'Responding',
    'Escalated',
    'Controlled',
    'Recovered',
    'Closed',
  ];

  final List<String> _severityOptions = const [
    'Low',
    'Medium',
    'High',
    'Critical',
  ];

  final List<String> _drillOptions = const [
    'Not a Drill',
    'Planned Drill',
    'Completed Drill',
    'Exercise',
  ];

  final List<String> _readinessOptions = const [
    'Not Assessed',
    'Ready',
    'Needs Improvement',
    'Not Ready',
  ];

  List<Map<String, dynamic>> _records = [];
  List<Map<String, dynamic>> _history = [];

  String _statusFilter = 'All';
  String _typeFilter = 'All';
  String _severityFilter = 'All';
  String _readinessFilter = 'All';

  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_refreshView);
    _loadData();
  }

  @override
  void dispose() {
    _searchController
      ..removeListener(_refreshView)
      ..dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final rawRecords = prefs.getString(storageKey);
    final rawHistory = prefs.getString('${storageKey}_history');
    if (!mounted) return;
    setState(() {
      _records = _decodeList(rawRecords);
      _history = _decodeList(rawHistory);
      _loading = false;
    });
  }

  List<Map<String, dynamic>> _decodeList(String? raw) {
    if (raw == null || raw.isEmpty) return [];
    try {
      final decoded = jsonDecode(raw);
      if (decoded is List) {
        return decoded
            .whereType<Map>()
            .map((item) => Map<String, dynamic>.from(item))
            .toList();
      }
    } catch (_) {}
    return [];
  }

  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(storageKey, jsonEncode(_records));
    await prefs.setString('${storageKey}_history', jsonEncode(_history));
  }

  void _refreshView() {
    if (mounted) setState(() {});
  }

  String _value(Map<String, dynamic> item, String key) {
    final value = item[key];
    return value == null ? '' : '$value';
  }

  DateTime? _parseDate(dynamic value) =>
      value == null ? null : DateTime.tryParse('$value');

  String _now() => DateTime.now().toIso8601String();

  String _newId() => 'EMR42-${DateTime.now().millisecondsSinceEpoch}';

  int _countWhere(bool Function(Map<String, dynamic>) test) =>
      _records.where(test).length;

  int get _totalCount => _records.length;
  int get _activeCount => _countWhere((r) =>
      ['Activated', 'Responding', 'Escalated'].contains(_value(r, 'status')));
  int get _criticalCount =>
      _countWhere((r) => _value(r, 'severity') == 'Critical');
  int get _openCount =>
      _countWhere((r) => _value(r, 'status') != 'Closed');
  int get _drillCount => _countWhere((r) =>
      ['Planned Drill', 'Completed Drill', 'Exercise']
          .contains(_value(r, 'drillType')));
  int get _readyCount =>
      _countWhere((r) => _readinessState(r) == 'Ready');
  int get _needsImprovementCount =>
      _countWhere((r) => _readinessState(r) == 'Needs Improvement');
  int get _overdueCount =>
      _countWhere((r) => _responseDueState(r) == 'Overdue');

  String _readinessState(Map<String, dynamic> record) {
    final explicit = _value(record, 'readiness');
    if (explicit == 'Ready' || explicit == 'Not Ready') return explicit;
    if (explicit == 'Needs Improvement') return explicit;
    return 'Not Assessed';
  }

  String _responseDueState(Map<String, dynamic> record) {
    final due = _parseDate(record['nextDrillDate']);
    if (due == null) return 'Not Scheduled';
    final today = DateTime.now();
    final d = DateTime(due.year, due.month, due.day)
        .difference(DateTime(today.year, today.month, today.day))
        .inDays;
    if (d < 0) return 'Overdue';
    if (d <= 30) return 'Due Soon';
    return 'Scheduled';
  }

  List<Map<String, dynamic>> get _filteredRecords {
    final query = _searchController.text.trim().toLowerCase();
    return _records.where((record) {
      final searchable = [
        _value(record, 'emergencyId'),
        _value(record, 'title'),
        _value(record, 'emergencyType'),
        _value(record, 'site'),
        _value(record, 'incidentCommander'),
        _value(record, 'assemblyPoint'),
        _value(record, 'contact'),
      ].join(' ').toLowerCase();

      return (query.isEmpty || searchable.contains(query)) &&
          (_statusFilter == 'All' ||
              _value(record, 'status') == _statusFilter) &&
          (_typeFilter == 'All' ||
              _value(record, 'emergencyType') == _typeFilter) &&
          (_severityFilter == 'All' ||
              _value(record, 'severity') == _severityFilter) &&
          (_readinessFilter == 'All' ||
              _readinessState(record) == _readinessFilter);
    }).toList();
  }

  Future<void> _addRecord() async {
    final result = await _showRecordDialog();
    if (result == null) return;

    final record = <String, dynamic>{
      ...result,
      'emergencyId': _newId(),
      'createdAt': _now(),
      'updatedAt': _now(),
    };

    setState(() {
      _records.insert(0, record);
      _history.insert(0, {
        'action': 'Created',
        'emergencyId': record['emergencyId'],
        'title': record['title'],
        'timestamp': _now(),
        'details': 'Emergency preparedness / response record created.',
      });
    });
    await _saveData();
  }

  Future<void> _editRecord(Map<String, dynamic> record) async {
    final result = await _showRecordDialog(existing: record);
    if (result == null) return;

    final index = _records.indexWhere((item) =>
        _value(item, 'emergencyId') == _value(record, 'emergencyId'));
    if (index < 0) return;

    final updated = <String, dynamic>{
      ...record,
      ...result,
      'updatedAt': _now(),
    };

    setState(() {
      _records[index] = updated;
      _history.insert(0, {
        'action': 'Updated',
        'emergencyId': updated['emergencyId'],
        'title': updated['title'],
        'timestamp': _now(),
        'details': 'Emergency response record updated.',
      });
    });
    await _saveData();
  }

  Future<void> _deleteRecord(Map<String, dynamic> record) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Emergency Record'),
        content: Text(
          'Delete ${_value(record, 'title')} '
          '(${_value(record, 'emergencyId')})?',
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

    setState(() {
      _records.removeWhere((item) =>
          _value(item, 'emergencyId') == _value(record, 'emergencyId'));
      _history.insert(0, {
        'action': 'Deleted',
        'emergencyId': record['emergencyId'],
        'title': record['title'],
        'timestamp': _now(),
        'details': 'Emergency response record deleted.',
      });
    });
    await _saveData();
  }

  Future<Map<String, dynamic>?> _showRecordDialog({
    Map<String, dynamic>? existing,
  }) async {
    final title = TextEditingController(text: _value(existing ?? {}, 'title'));
    final site = TextEditingController(text: _value(existing ?? {}, 'site'));
    final commander = TextEditingController(
        text: _value(existing ?? {}, 'incidentCommander'));
    final contact =
        TextEditingController(text: _value(existing ?? {}, 'contact'));
    final assembly = TextEditingController(
        text: _value(existing ?? {}, 'assemblyPoint'));
    final emergencyNumber = TextEditingController(
        text: _value(existing ?? {}, 'emergencyNumber'));
    final planRef =
        TextEditingController(text: _value(existing ?? {}, 'planReference'));
    final drillDate = TextEditingController(
        text: _value(existing ?? {}, 'nextDrillDate'));
    final hazards =
        TextEditingController(text: _value(existing ?? {}, 'hazards'));
    final resources =
        TextEditingController(text: _value(existing ?? {}, 'resources'));
    final actions =
        TextEditingController(text: _value(existing ?? {}, 'responseActions'));
    final lessons =
        TextEditingController(text: _value(existing ?? {}, 'lessons'));
    final notes = TextEditingController(text: _value(existing ?? {}, 'notes'));

    String type = _value(existing ?? {}, 'emergencyType');
    String status = _value(existing ?? {}, 'status');
    String severity = _value(existing ?? {}, 'severity');
    String drill = _value(existing ?? {}, 'drillType');
    String readiness = _value(existing ?? {}, 'readiness');

    if (!_emergencyTypes.contains(type)) type = _emergencyTypes.first;
    if (!_statuses.contains(status)) status = _statuses.first;
    if (!_severityOptions.contains(severity)) severity = 'Medium';
    if (!_drillOptions.contains(drill)) drill = 'Not a Drill';
    if (!_readinessOptions.contains(readiness)) readiness = 'Not Assessed';

    final response = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text(existing == null
              ? 'Create Emergency Response Record'
              : 'Edit Emergency Response Record'),
          content: SizedBox(
            width: 680,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _field(title, 'Emergency Plan / Event Title',
                      Icons.emergency_outlined, true),
                  const SizedBox(height: 10),
                  _dropdown('Emergency Type', type, _emergencyTypes,
                      (v) => setDialogState(() => type = v!)),
                  const SizedBox(height: 10),
                  Row(children: [
                    Expanded(
                        child: _field(site, 'Site / Location',
                            Icons.location_on_outlined, true)),
                    const SizedBox(width: 10),
                    Expanded(
                        child: _field(commander, 'Incident Commander',
                            Icons.person_outline, true)),
                  ]),
                  const SizedBox(height: 10),
                  Row(children: [
                    Expanded(
                        child: _field(contact, 'Response Contact',
                            Icons.phone_outlined)),
                    const SizedBox(width: 10),
                    Expanded(
                        child: _field(emergencyNumber, 'Emergency Number',
                            Icons.call_outlined)),
                  ]),
                  const SizedBox(height: 10),
                  _field(assembly, 'Assembly / Muster Point',
                      Icons.groups_outlined, true),
                  const SizedBox(height: 10),
                  _field(planRef, 'Emergency Plan / Document Reference',
                      Icons.description_outlined),
                  const SizedBox(height: 10),
                  Row(children: [
                    Expanded(
                        child: _dropdown('Status', status, _statuses,
                            (v) => setDialogState(() => status = v!))),
                    const SizedBox(width: 10),
                    Expanded(
                        child: _dropdown('Severity', severity, _severityOptions,
                            (v) => setDialogState(() => severity = v!))),
                  ]),
                  const SizedBox(height: 10),
                  Row(children: [
                    Expanded(
                        child: _dropdown('Drill / Exercise Type', drill,
                            _drillOptions,
                            (v) => setDialogState(() => drill = v!))),
                    const SizedBox(width: 10),
                    Expanded(
                        child: _dropdown('Readiness', readiness,
                            _readinessOptions,
                            (v) => setDialogState(() => readiness = v!))),
                  ]),
                  const SizedBox(height: 10),
                  _field(drillDate, 'Next Drill / Review (YYYY-MM-DD)',
                      Icons.event_available_outlined),
                  const SizedBox(height: 10),
                  _field(hazards, 'Emergency Hazards / Scenarios',
                      Icons.warning_amber_outlined, false, 3),
                  const SizedBox(height: 10),
                  _field(resources, 'Emergency Resources / Equipment',
                      Icons.inventory_2_outlined, false, 3),
                  const SizedBox(height: 10),
                  _field(actions, 'Response / Evacuation Actions',
                      Icons.directions_run_outlined, false, 3),
                  const SizedBox(height: 10),
                  _field(lessons, 'Drill Findings / Lessons Learned',
                      Icons.lightbulb_outline, false, 3),
                  const SizedBox(height: 10),
                  _field(notes, 'HSE Notes', Icons.notes_outlined, false, 3),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            FilledButton.icon(
              onPressed: () {
                if (title.text.trim().isEmpty ||
                    site.text.trim().isEmpty ||
                    commander.text.trim().isEmpty ||
                    assembly.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Title, Site, Incident Commander and Assembly Point are required.',
                      ),
                    ),
                  );
                  return;
                }
                Navigator.pop(dialogContext, {
                  'title': title.text.trim(),
                  'emergencyType': type,
                  'site': site.text.trim(),
                  'incidentCommander': commander.text.trim(),
                  'contact': contact.text.trim(),
                  'emergencyNumber': emergencyNumber.text.trim(),
                  'assemblyPoint': assembly.text.trim(),
                  'planReference': planRef.text.trim(),
                  'status': status,
                  'severity': severity,
                  'drillType': drill,
                  'readiness': readiness,
                  'nextDrillDate': drillDate.text.trim(),
                  'hazards': hazards.text.trim(),
                  'resources': resources.text.trim(),
                  'responseActions': actions.text.trim(),
                  'lessons': lessons.text.trim(),
                  'notes': notes.text.trim(),
                });
              },
              icon: const Icon(Icons.save_outlined),
              label: Text(existing == null ? 'Create' : 'Save'),
            ),
          ],
        ),
      ),
    );

    for (final controller in [
      title,
      site,
      commander,
      contact,
      assembly,
      emergencyNumber,
      planRef,
      drillDate,
      hazards,
      resources,
      actions,
      lessons,
      notes,
    ]) {
      controller.dispose();
    }
    return response;
  }

  Widget _field(TextEditingController controller, String label, IconData icon,
      [bool required = false, int maxLines = 1]) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: required ? '$label *' : label,
        prefixIcon: Icon(icon),
        border: const OutlineInputBorder(),
      ),
    );
  }

  Widget _dropdown(String label, String value, List<String> items,
      ValueChanged<String?> onChanged) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      isExpanded: true,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      items: items
          .map((item) => DropdownMenuItem<String>(
                value: item,
                child: Text(item, overflow: TextOverflow.ellipsis),
              ))
          .toList(),
      onChanged: onChanged,
    );
  }

  Widget _statusChip(String text) => Chip(
        label: Text(text.isEmpty ? '-' : text),
        visualDensity: VisualDensity.compact,
      );

  Widget _dashboardCard(String title, String value, IconData icon) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(children: [
          CircleAvatar(
            backgroundColor: primaryGreen.withValues(alpha: 0.10),
            child: Icon(icon, color: darkGreen),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(value,
                    style: const TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w800,
                        color: darkGreen)),
                Text(title, style: const TextStyle(fontSize: 12)),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  Widget _buildDashboard() {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('42L — Emergency Preparedness Intelligence',
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: darkGreen)),
            const SizedBox(height: 4),
            const Text(
                'Plan → Prepare → Report → Respond → Escalate → Recover → Close'),
            const SizedBox(height: 12),
            LayoutBuilder(builder: (context, constraints) {
              final columns = constraints.maxWidth > 850
                  ? 4
                  : constraints.maxWidth > 560
                      ? 3
                      : 2;
              final width =
                  (constraints.maxWidth - ((columns - 1) * 10)) / columns;
              final cards = [
                ['Total Records', '$_totalCount', Icons.emergency_outlined],
                ['Active Response', '$_activeCount', Icons.sos_outlined],
                ['Critical', '$_criticalCount', Icons.warning_outlined],
                ['Open', '$_openCount', Icons.folder_open_outlined],
                ['Drills / Exercises', '$_drillCount', Icons.fitness_center_outlined],
                ['Ready', '$_readyCount', Icons.check_circle_outline],
                ['Needs Improvement', '$_needsImprovementCount', Icons.build_outlined],
                ['Drill Overdue', '$_overdueCount', Icons.event_busy_outlined],
              ];
              return Wrap(
                spacing: 10,
                runSpacing: 10,
                children: cards
                    .map((c) => SizedBox(
                          width: width,
                          child: _dashboardCard(
                              c[0] as String, c[1] as String, c[2] as IconData),
                        ))
                    .toList(),
              );
            }),
          ],
        ),
      ),
    );
  }

  Future<void> _showDetails(Map<String, dynamic> record) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) => SafeArea(
        child: DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.84,
          minChildSize: 0.55,
          maxChildSize: 0.96,
          builder: (context, controller) => ListView(
            controller: controller,
            padding: const EdgeInsets.fromLTRB(18, 4, 18, 24),
            children: [
              Text(_value(record, 'title'),
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w800, color: darkGreen)),
              const SizedBox(height: 3),
              Text(_value(record, 'emergencyId'),
                  style: const TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 14),
              Wrap(spacing: 8, runSpacing: 8, children: [
                _statusChip(_value(record, 'status')),
                _statusChip(_value(record, 'severity')),
                _statusChip(_readinessState(record)),
                _statusChip(_responseDueState(record)),
              ]),
              const SizedBox(height: 16),
              _section('42A–42L Emergency Preparedness & Response Control', [
                _row('Emergency Type', _value(record, 'emergencyType')),
                _row('Site / Location', _value(record, 'site')),
                _row('Incident Commander', _value(record, 'incidentCommander')),
                _row('Response Contact', _value(record, 'contact')),
                _row('Emergency Number', _value(record, 'emergencyNumber')),
                _row('Assembly / Muster Point', _value(record, 'assemblyPoint')),
                _row('Plan Reference', _value(record, 'planReference')),
                _row('Drill / Exercise', _value(record, 'drillType')),
                _row('Next Drill / Review', _formatDate(record['nextDrillDate'])),
                _row('Readiness', _readinessState(record)),
              ]),
              if (_value(record, 'hazards').isNotEmpty) ...[
                const SizedBox(height: 12),
                _section('Emergency Hazards / Scenarios',
                    [Text(_value(record, 'hazards'))]),
              ],
              if (_value(record, 'resources').isNotEmpty) ...[
                const SizedBox(height: 12),
                _section('Emergency Resources / Equipment',
                    [Text(_value(record, 'resources'))]),
              ],
              if (_value(record, 'responseActions').isNotEmpty) ...[
                const SizedBox(height: 12),
                _section('Response / Evacuation Actions',
                    [Text(_value(record, 'responseActions'))]),
              ],
              if (_value(record, 'lessons').isNotEmpty) ...[
                const SizedBox(height: 12),
                _section('Drill Findings / Lessons Learned',
                    [Text(_value(record, 'lessons'))]),
              ],
              if (_value(record, 'notes').isNotEmpty) ...[
                const SizedBox(height: 12),
                _section('HSE Notes', [Text(_value(record, 'notes'))]),
              ],
              if (widget.sourceOpener != null) ...[
                const SizedBox(height: 16),
                OutlinedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    widget.sourceOpener!(
                      'emergency_response',
                      _value(record, 'emergencyId'),
                    );
                  },
                  icon: const Icon(Icons.open_in_new_outlined),
                  label: const Text('Open Integration Reference'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _section(String title, List<Widget> children) => Card(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.w800, color: darkGreen)),
                const SizedBox(height: 8),
                ...children,
              ]),
        ),
      );

  Widget _row(String label, String value) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            width: 155,
            child: Text(label,
                style: const TextStyle(fontWeight: FontWeight.w700)),
          ),
          Expanded(child: Text(value.isEmpty ? '-' : value)),
        ]),
      );

  String _formatDate(dynamic value) {
    final date = _parseDate(value);
    if (date == null) {
      final text = '$value';
      return value == null || text == 'null' || text.isEmpty ? '-' : text;
    }
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  Future<void> _showHistory() async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) => SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.78,
          child: Column(children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(18, 4, 18, 12),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('Emergency Response History',
                    style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w800,
                        color: darkGreen)),
              ),
            ),
            Expanded(
              child: _history.isEmpty
                  ? const Center(child: Text('No history records yet.'))
                  : ListView.separated(
                      padding: const EdgeInsets.all(14),
                      itemCount: _history.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 8),
                      itemBuilder: (context, index) {
                        final item = _history[index];
                        return Card(
                          elevation: 0,
                          child: ListTile(
                            leading: const CircleAvatar(
                                child: Icon(Icons.history)),
                            title: Text(
                                '${_value(item, 'action')} — ${_value(item, 'title')}'),
                            subtitle: Text(
                                '${_value(item, 'details')}\n${_formatDateTime(item['timestamp'])}'),
                            isThreeLine: true,
                          ),
                        );
                      },
                    ),
            ),
          ]),
        ),
      ),
    );
  }

  String _formatDateTime(dynamic value) {
    final date = _parseDate(value);
    if (date == null) return '-';
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/${date.year} '
        '${date.hour.toString().padLeft(2, '0')}:'
        '${date.minute.toString().padLeft(2, '0')}';
  }

  Future<void> _showModuleGuide() async {
    const modules = {
      '42A — Emergency Master':
          'Central register for emergency plans, events and response records.',
      '42B — Emergency Planning':
          'Define emergency scenarios, response ownership and preparedness requirements.',
      '42C — Emergency Contacts':
          'Maintain response contacts, emergency numbers and command responsibility.',
      '42D — Evacuation & Muster':
          'Record assembly points and evacuation arrangements.',
      '42E — Emergency Resources':
          'Track emergency equipment, resources and response capability references.',
      '42F — Emergency Activation':
          'Record activation, response and escalation status.',
      '42G — Incident Command & Escalation':
          'Support command, escalation and coordination during response.',
      '42H — Drill & Exercise Management':
          'Plan and record drills, exercises and emergency preparedness tests.',
      '42I — Readiness & Verification':
          'Track readiness, gaps and improvement requirements.',
      '42J — Recovery & Closure':
          'Capture recovery, lessons learned and final closure.',
      '42K — Integration References':
          'Connect Emergency Response with Risk, RAMS, PTW, Workforce, Assets, Inspections and Actions.',
      '42L — Emergency Intelligence Dashboard':
          'Management view of active response, readiness, drills and overdue preparedness items.',
    };

    await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Step 42 — Module Guide'),
        content: SizedBox(
          width: 650,
          child: ListView(
            shrinkWrap: true,
            children: modules.entries
                .map((entry) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: const Icon(Icons.check_circle_outline,
                            color: primaryGreen),
                        title: Text(entry.key,
                            style:
                                const TextStyle(fontWeight: FontWeight.w700)),
                        subtitle: Text(entry.value),
                      ),
                    ))
                .toList(),
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

  void _resetFilters() {
    setState(() {
      _statusFilter = 'All';
      _typeFilter = 'All';
      _severityFilter = 'All';
      _readinessFilter = 'All';
      _searchController.clear();
    });
  }

  Widget _filterDropdown(String label, String value, List<String> items,
      ValueChanged<String?> onChanged) {
    return SizedBox(
      width: 195,
      child: DropdownButtonFormField<String>(
        initialValue: value,
        isExpanded: true,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          border: const OutlineInputBorder(),
          isDense: true,
        ),
        items: items
            .map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(item, overflow: TextOverflow.ellipsis),
                ))
            .toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildRecordCard(Map<String, dynamic> record) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _showDetails(record),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const CircleAvatar(
                    child: Icon(Icons.emergency_outlined)),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(_value(record, 'title'),
                            style: const TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 16,
                                color: darkGreen)),
                        const SizedBox(height: 2),
                        Text(
                            '${_value(record, 'emergencyId')} • ${_value(record, 'emergencyType')}',
                            style: const TextStyle(fontSize: 12)),
                      ]),
                ),
                PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'view') _showDetails(record);
                    if (value == 'edit') _editRecord(record);
                    if (value == 'delete') _deleteRecord(record);
                  },
                  itemBuilder: (context) => const [
                    PopupMenuItem(
                        value: 'view', child: Text('View Details')),
                    PopupMenuItem(value: 'edit', child: Text('Edit')),
                    PopupMenuItem(value: 'delete', child: Text('Delete')),
                  ],
                ),
              ]),
              const SizedBox(height: 10),
              Wrap(spacing: 6, runSpacing: 6, children: [
                _statusChip(_value(record, 'status')),
                _statusChip(_value(record, 'severity')),
                _statusChip(_readinessState(record)),
                _statusChip(_responseDueState(record)),
              ]),
              const SizedBox(height: 10),
              Row(children: [
                const Icon(Icons.location_on_outlined, size: 17),
                const SizedBox(width: 5),
                Expanded(child: Text(_value(record, 'site'))),
                const SizedBox(width: 8),
                const Icon(Icons.person_outline, size: 17),
                const SizedBox(width: 5),
                Expanded(
                  child: Text(
                    _value(record, 'incidentCommander').isEmpty
                        ? 'Unassigned'
                        : _value(record, 'incidentCommander'),
                    textAlign: TextAlign.end,
                  ),
                ),
              ]),
              if (_value(record, 'assemblyPoint').isNotEmpty) ...[
                const SizedBox(height: 8),
                Row(children: [
                  const Icon(Icons.groups_outlined, size: 17),
                  const SizedBox(width: 5),
                  Expanded(child: Text(_value(record, 'assemblyPoint'))),
                ]),
              ],
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        title: const Text('Step 42 • Emergency Response',
            style: TextStyle(fontWeight: FontWeight.w800)),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
              tooltip: 'Module Guide',
              onPressed: _showModuleGuide,
              icon: const Icon(Icons.menu_book_outlined)),
          IconButton(
              tooltip: 'History',
              onPressed: _showHistory,
              icon: const Icon(Icons.history_outlined)),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _loading ? null : _addRecord,
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('New Emergency Record'),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadData,
              child: ListView(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 100),
                children: [
                  _buildDashboard(),
                  const SizedBox(height: 12),
                  Card(
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(children: [
                        TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            labelText: 'Search emergency / response record',
                            hintText:
                                'ID, title, site, commander, muster point',
                            prefixIcon: const Icon(Icons.search),
                            suffixIcon: _searchController.text.isEmpty
                                ? null
                                : IconButton(
                                    onPressed: _searchController.clear,
                                    icon: const Icon(Icons.clear)),
                            border: const OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Wrap(spacing: 8, runSpacing: 8, children: [
                          _filterDropdown(
                              'Status',
                              _statusFilter,
                              ['All', ..._statuses],
                              (v) => setState(() => _statusFilter = v!)),
                          _filterDropdown(
                              'Emergency Type',
                              _typeFilter,
                              ['All', ..._emergencyTypes],
                              (v) => setState(() => _typeFilter = v!)),
                          _filterDropdown(
                              'Severity',
                              _severityFilter,
                              ['All', ..._severityOptions],
                              (v) => setState(() => _severityFilter = v!)),
                          _filterDropdown(
                              'Readiness',
                              _readinessFilter,
                              ['All', ..._readinessOptions],
                              (v) => setState(() => _readinessFilter = v!)),
                          OutlinedButton.icon(
                            onPressed: _resetFilters,
                            icon: const Icon(Icons.filter_alt_off),
                            label: const Text('Reset'),
                          ),
                        ]),
                      ]),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(children: [
                    Expanded(
                      child: Text('${_filteredRecords.length} record(s) found',
                          style: const TextStyle(
                              fontWeight: FontWeight.w800,
                              color: darkGreen)),
                    ),
                    TextButton.icon(
                      onPressed: _showModuleGuide,
                      icon: const Icon(Icons.info_outline),
                      label: const Text('42A–42L'),
                    ),
                  ]),
                  const SizedBox(height: 4),
                  if (_filteredRecords.isEmpty)
                    Card(
                      elevation: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(30),
                        child: Column(children: [
                          const Icon(Icons.emergency_outlined,
                              size: 48, color: darkGreen),
                          const SizedBox(height: 10),
                          const Text('No emergency records found.',
                              style: TextStyle(fontWeight: FontWeight.w700)),
                          const SizedBox(height: 6),
                          const Text(
                              'Create an emergency preparedness record to begin Step 42.',
                              textAlign: TextAlign.center),
                          const SizedBox(height: 14),
                          FilledButton.icon(
                            onPressed: _addRecord,
                            icon: const Icon(Icons.add),
                            label: const Text('Create First Record'),
                          ),
                        ]),
                      ),
                    )
                  else
                    ..._filteredRecords.map(_buildRecordCard),
                ],
              ),
            ),
    );
  }
}
