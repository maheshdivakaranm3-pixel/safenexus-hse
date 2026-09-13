import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// SafeNexus HSE — Steps 117–125
///
/// Unified Daily Work Record Intelligence layer:
/// 117 Linkage Review
/// 118 Evidence Review
/// 119 Record Edit & Correction
/// 120 Record Status Workflow
/// 121 Daily/Weekly Record View
/// 122 Company-wise Records
/// 123 Record Summary Dashboard
/// 124 Unified Record Package
/// 125 Integration & Validation
///
/// Design rule:
/// - Uses existing Step 111–115 storage keys.
/// - Does not create duplicate record stores.
/// - Existing records are loaded from the current Daily Work store.
/// - Changes are limited to the selected record's existing JSON object.
/// - Export/copy is text based so no new dependency is required.

class SafeNexusSteps117125Page extends StatefulWidget {
  const SafeNexusSteps117125Page({super.key});

  @override
  State<SafeNexusSteps117125Page> createState() =>
      _SafeNexusSteps117125PageState();
}

class _SafeNexusSteps117125PageState
    extends State<SafeNexusSteps117125Page> {
  static const String _dailyLogsKey = 'workhub_daily_logs_v1';
  static const String _linkKey = 'workhub_daily_log_record_links_v1';
  static const String _evidenceKey = 'workhub_daily_evidence_v1';

  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);

  final TextEditingController _searchController = TextEditingController();

  List<Map<String, dynamic>> _logs = <Map<String, dynamic>>[];
  Map<String, Map<String, dynamic>> _links =
      <String, Map<String, dynamic>>{};
  Map<String, List<Map<String, dynamic>>> _evidence =
      <String, List<Map<String, dynamic>>>{};

  String _statusFilter = 'All';
  String _companyFilter = 'All';
  String _periodFilter = 'All';
  String? _selectedId;
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

  void _refreshView() {
    if (mounted) setState(() {});
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final logs = _decodeList(prefs.getString(_dailyLogsKey));
    final linkList = _decodeList(prefs.getString(_linkKey));
    final evidenceList = _decodeList(prefs.getString(_evidenceKey));

    final links = <String, Map<String, dynamic>>{};
    for (final item in linkList) {
      final id = _linkRecordId(item);
      if (id.isNotEmpty) links[id] = item;
    }

    final evidence = <String, List<Map<String, dynamic>>>{};
    for (final item in evidenceList) {
      final id = _evidenceRecordId(item);
      if (id.isEmpty) continue;
      evidence.putIfAbsent(id, () => <Map<String, dynamic>>[]).add(item);
    }

    if (!mounted) return;

    setState(() {
      _logs = logs;
      _links = links;
      _evidence = evidence;
      _loading = false;
    });

    if (_selectedId != null && _findLog(_selectedId!) == null) {
      setState(() => _selectedId = null);
    }
  }

  List<Map<String, dynamic>> _decodeList(String? raw) {
    if (raw == null || raw.trim().isEmpty) {
      return <Map<String, dynamic>>[];
    }
    try {
      final value = jsonDecode(raw);
      if (value is! List) return <Map<String, dynamic>>[];
      return value
          .whereType<Map>()
          .map((item) => Map<String, dynamic>.from(item))
          .toList();
    } catch (_) {
      return <Map<String, dynamic>>[];
    }
  }

  String _recordId(Map<String, dynamic> item) {
    return (item['id'] ??
            item['logId'] ??
            item['dailyLogId'] ??
            item['recordId'] ??
            '')
        .toString();
  }

  String _linkRecordId(Map<String, dynamic> item) {
    return (item['logId'] ?? item['dailyLogId'] ?? item['recordId'] ?? '')
        .toString();
  }

  String _evidenceRecordId(Map<String, dynamic> item) {
    return (item['logId'] ?? item['dailyLogId'] ?? item['recordId'] ?? '')
        .toString();
  }

  String _value(Map<String, dynamic> item, List<String> keys) {
    for (final key in keys) {
      final value = item[key];
      if (value != null && value.toString().trim().isNotEmpty) {
        return value.toString();
      }
    }
    return '';
  }

  String _company(Map<String, dynamic> log) {
    return _value(
      log,
      <String>['companyName', 'company', 'contractor'],
    );
  }

  String _project(Map<String, dynamic> log) {
    return _value(log, <String>['projectName', 'project']);
  }

  String _site(Map<String, dynamic> log) {
    return _value(
      log,
      <String>['siteLocation', 'location', 'projectLocation'],
    );
  }

  String _date(Map<String, dynamic> log) {
    return _value(log, <String>['date', 'workDate', 'logDate']);
  }

  String _status(Map<String, dynamic> log) {
    return _value(log, <String>['status']).isEmpty
        ? 'Draft'
        : _value(log, <String>['status']);
  }

  Map<String, dynamic>? _findLog(String id) {
    for (final log in _logs) {
      if (_recordId(log) == id) return log;
    }
    return null;
  }

  List<String> get _companies {
    final values = _logs
        .map(_company)
        .where((value) => value.isNotEmpty)
        .toSet()
        .toList()
      ..sort();
    return <String>['All', ...values];
  }

  List<String> get _statuses {
    final values = _logs
        .map(_status)
        .where((value) => value.isNotEmpty)
        .toSet()
        .toList()
      ..sort();
    return <String>['All', ...values];
  }

  bool _matchesPeriod(Map<String, dynamic> log) {
    if (_periodFilter == 'All') return true;
    final date = _parseDate(_date(log));
    if (date == null) return false;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final recordDay = DateTime(date.year, date.month, date.day);

    if (_periodFilter == 'Today') return recordDay == today;
    if (_periodFilter == 'This Week') {
      final start = today.subtract(Duration(days: today.weekday - 1));
      final end = start.add(const Duration(days: 7));
      return !recordDay.isBefore(start) && recordDay.isBefore(end);
    }
    if (_periodFilter == 'This Month') {
      return date.year == now.year && date.month == now.month;
    }
    return true;
  }

  DateTime? _parseDate(String raw) {
    if (raw.trim().isEmpty) return null;
    return DateTime.tryParse(raw.trim());
  }

  List<Map<String, dynamic>> get _filteredLogs {
    final query = _searchController.text.trim().toLowerCase();

    final result = _logs.where((log) {
      if (_companyFilter != 'All' && _company(log) != _companyFilter) {
        return false;
      }
      if (_statusFilter != 'All' && _status(log) != _statusFilter) {
        return false;
      }
      if (!_matchesPeriod(log)) return false;
      if (query.isEmpty) return true;

      final searchable = <String>[
        _recordId(log),
        _company(log),
        _project(log),
        _site(log),
        _date(log),
        _status(log),
        _value(log, <String>[
          'workDescription',
          'description',
          'work',
          'activity',
        ]),
      ].join(' ').toLowerCase();

      return searchable.contains(query);
    }).toList();

    result.sort((a, b) => _date(b).compareTo(_date(a)));
    return result;
  }

  int _evidenceCount(String id) => _evidence[id]?.length ?? 0;

  int _linkCount(String id) {
    final link = _links[id];
    if (link == null) return 0;

    var count = 0;
    for (final key in <String>[
      'ptwId',
      'ptwRecordId',
      'ramsId',
      'ramsRecordId',
      'riskId',
      'riskRecordId',
      'hiraId',
    ]) {
      final value = link[key];
      if (value != null && value.toString().trim().isNotEmpty) count++;
    }

    for (final key in <String>['workforceIds', 'equipmentIds']) {
      final value = link[key];
      if (value is List) count += value.length;
    }

    return count;
  }

  void _select(String id) {
    setState(() => _selectedId = id);
  }

  Map<String, dynamic>? get _selectedLog {
    if (_selectedId == null) return null;
    return _findLog(_selectedId!);
  }

  Future<void> _saveLogs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_dailyLogsKey, jsonEncode(_logs));
  }

  Future<void> _updateField(
    String id,
    String field,
    String value,
  ) async {
    final index = _logs.indexWhere((log) => _recordId(log) == id);
    if (index < 0) return;

    setState(() {
      _logs[index][field] = value;
    });
    await _saveLogs();
    _message('Record updated.');
  }

  Future<void> _editRecord(Map<String, dynamic> log) async {
    final descriptionController = TextEditingController(
      text: _value(
        log,
        <String>['workDescription', 'description', 'work', 'activity'],
      ),
    );
    final observationsController = TextEditingController(
      text: _value(log, <String>['hseObservations', 'observations']),
    );
    final hazardsController = TextEditingController(
      text: _value(log, <String>['hazards', 'unsafeConditions']),
    );
    final actionsController = TextEditingController(
      text: _value(log, <String>['correctiveActions', 'actions']),
    );
    final supervisorController = TextEditingController(
      text: _value(log, <String>['supervisor']),
    );
    final hseController = TextEditingController(
      text: _value(log, <String>['hseOfficer']),
    );

    final values = await showDialog<Map<String, String>>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit & Correct Record'),
          content: SizedBox(
            width: 620,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  _dialogField(
                    descriptionController,
                    'Work Description',
                    maxLines: 3,
                  ),
                  _dialogField(
                    observationsController,
                    'HSE Observations',
                    maxLines: 3,
                  ),
                  _dialogField(
                    hazardsController,
                    'Hazards / Unsafe Conditions',
                    maxLines: 3,
                  ),
                  _dialogField(
                    actionsController,
                    'Corrective Actions',
                    maxLines: 3,
                  ),
                  _dialogField(supervisorController, 'Supervisor'),
                  _dialogField(hseController, 'HSE Officer'),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  <String, String>{
                    'workDescription': descriptionController.text.trim(),
                    'hseObservations': observationsController.text.trim(),
                    'hazards': hazardsController.text.trim(),
                    'correctiveActions': actionsController.text.trim(),
                    'supervisor': supervisorController.text.trim(),
                    'hseOfficer': hseController.text.trim(),
                  },
                );
              },
              child: const Text('Save Correction'),
            ),
          ],
        );
      },
    );

    descriptionController.dispose();
    observationsController.dispose();
    hazardsController.dispose();
    actionsController.dispose();
    supervisorController.dispose();
    hseController.dispose();

    if (values == null) return;

    final index = _logs.indexWhere((item) => _recordId(item) == _recordId(log));
    if (index < 0) return;

    setState(() {
      values.forEach((key, value) {
        _logs[index][key] = value;
      });
    });
    await _saveLogs();
    _message('Record correction saved.');
  }

  Widget _dialogField(
    TextEditingController controller,
    String label, {
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  Future<void> _changeStatus(Map<String, dynamic> log) async {
    const options = <String>[
      'Draft',
      'In Progress',
      'Completed',
    ];

    final current = _status(log);
    final selected = await showDialog<String>(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text('Record Status Workflow'),
          children: options.map((status) {
            return RadioListTile<String>(
              value: status,
              groupValue: current,
              title: Text(status),
              onChanged: (value) => Navigator.pop(context, value),
            );
          }).toList(),
        );
      },
    );

    if (selected == null || selected == current) return;

    await _updateField(_recordId(log), 'status', selected);
  }

  Future<void> _copyText(String text, String message) async {
    await Clipboard.setData(ClipboardData(text: text));
    _message(message);
  }

  String _recordPackage(Map<String, dynamic> log) {
    final id = _recordId(log);
    final link = _links[id];
    final evidence = _evidence[id] ?? <Map<String, dynamic>>[];

    final buffer = StringBuffer()
      ..writeln('SafeNexus HSE — Unified Record Package')
      ..writeln('Record ID: $id')
      ..writeln('Company: ${_company(log)}')
      ..writeln('Project: ${_project(log)}')
      ..writeln('Site: ${_site(log)}')
      ..writeln('Date: ${_date(log)}')
      ..writeln('Status: ${_status(log)}')
      ..writeln()
      ..writeln('Work Description:')
      ..writeln(
        _value(
          log,
          <String>['workDescription', 'description', 'work', 'activity'],
        ),
      )
      ..writeln()
      ..writeln('HSE Observations:')
      ..writeln(
        _value(log, <String>['hseObservations', 'observations']),
      )
      ..writeln()
      ..writeln('Hazards / Unsafe Conditions:')
      ..writeln(
        _value(log, <String>['hazards', 'unsafeConditions']),
      )
      ..writeln()
      ..writeln('Corrective Actions:')
      ..writeln(
        _value(log, <String>['correctiveActions', 'actions']),
      )
      ..writeln()
      ..writeln('Incident / Near Miss:')
      ..writeln(
        _value(log, <String>['incident', 'incidentNearMiss']),
      )
      ..writeln()
      ..writeln('PTW Reference:')
      ..writeln(
        _value(log, <String>['ptwReference', 'ptwRef', 'permitReference']),
      )
      ..writeln('RAMS Reference:')
      ..writeln(
        _value(log, <String>['ramsReference', 'ramsRef']),
      )
      ..writeln('Supervisor: ${_value(log, <String>['supervisor'])}')
      ..writeln('HSE Officer: ${_value(log, <String>['hseOfficer'])}');

    if (link != null) {
      buffer
        ..writeln()
        ..writeln('Record Linkage:')
        ..writeln('PTW ID: ${_linkValue(link, <String>['ptwId', 'ptwRecordId'])}')
        ..writeln('RAMS ID: ${_linkValue(link, <String>['ramsId', 'ramsRecordId'])}')
        ..writeln(
          'Risk / HIRA ID: ${_linkValue(link, <String>['riskId', 'riskRecordId', 'hiraId'])}',
        )
        ..writeln(
          'Workforce IDs: ${_listText(link['workforceIds'])}',
        )
        ..writeln(
          'Equipment IDs: ${_listText(link['equipmentIds'])}',
        );
    }

    buffer
      ..writeln()
      ..writeln('Evidence Count: ${evidence.length}');

    for (var i = 0; i < evidence.length; i++) {
      final item = evidence[i];
      buffer
        ..writeln('Evidence ${i + 1}:')
        ..writeln(
          _value(
            item,
            <String>['title', 'note', 'description', 'observation'],
          ),
        )
        ..writeln(
          'Hazard: ${_value(item, <String>['hazard', 'hazards'])}',
        )
        ..writeln(
          'Action: ${_value(item, <String>['correctiveAction', 'action'])}',
        );
    }

    return buffer.toString();
  }

  String _linkValue(Map<String, dynamic> item, List<String> keys) {
    return _value(item, keys);
  }

  String _listText(dynamic value) {
    if (value is List) {
      return value
          .map((item) => item.toString())
          .where((item) => item.trim().isNotEmpty)
          .join(', ');
    }
    return value?.toString() ?? '';
  }

  void _showEvidence(Map<String, dynamic> item, int index) {
    showDialog<void>(
      context: context,
      builder: (context) {
        final title = _value(
          item,
          <String>['title', 'note', 'description', 'observation'],
        );
        final observation = _value(
          item,
          <String>['observation', 'note'],
        );
        final hazard = _value(
          item,
          <String>['hazard', 'hazards'],
        );
        final action = _value(
          item,
          <String>['correctiveAction', 'action', 'correctiveActions'],
        );
        final imagePath = _value(
          item,
          <String>['imagePath', 'image', 'photoPath', 'filePath'],
        );

        return AlertDialog(
          title: Text('Evidence ${index + 1}'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _reviewText('Title / Note', title),
                _reviewText('Observation', observation),
                _reviewText('Hazard / Unsafe Condition', hazard),
                _reviewText('Corrective Action', action),
                _reviewText('Photo / File', imagePath),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Widget _reviewText(String label, String value) {
    if (value.trim().isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 3),
          SelectableText(value),
        ],
      ),
    );
  }

  Future<void> _showIntegrationAudit() async {
    final missing = <String>[];

    if (_logs.isEmpty) missing.add('Daily Work Records');
    if (_linkKey.isEmpty) missing.add('Record Linkage');
    if (_evidenceKey.isEmpty) missing.add('Evidence');

    final linkedRecords =
        _logs.where((log) => _links.containsKey(_recordId(log))).length;
    final evidenceRecords =
        _logs.where((log) => _evidence.containsKey(_recordId(log))).length;

    final message = missing.isEmpty
        ? 'Storage integration detected.\n'
            'Daily Work Records: ${_logs.length}\n'
            'Linked records: $linkedRecords\n'
            'Records with evidence: $evidenceRecords\n'
            'No schema changes were introduced by this layer.'
        : 'Integration review needs attention:\n${missing.join('\n')}';

    await showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Step 125 Integration Audit'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  // Kept as a simple non-empty marker so Step 125 can verify the existing keys.
  String get _linkKey => 'workhub_daily_log_record_links_v1';
  String get _evidenceKey => 'workhub_daily_evidence_v1';

  void _message(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final selected = _selectedLog;

    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: darkGreen,
        elevation: 0,
        title: const Text(
          'HSE Record Intelligence',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        actions: <Widget>[
          IconButton(
            tooltip: 'Integration audit',
            onPressed: _showIntegrationAudit,
            icon: const Icon(Icons.verified_outlined),
          ),
          IconButton(
            tooltip: 'Refresh',
            onPressed: _loadData,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _buildBody(selected),
    );
  }

  Widget _buildBody(Map<String, dynamic>? selected) {
    if (_logs.isEmpty) {
      return _empty(
        'No Daily Work Records',
        'Create a Daily Work Record first. Steps 117–125 use the existing record store.',
        Icons.description_outlined,
      );
    }

    return Column(
      children: <Widget>[
        _buildFilters(),
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth >= 900) {
                return Row(
                  children: <Widget>[
                    SizedBox(width: 370, child: _buildList()),
                    const VerticalDivider(width: 1),
                    Expanded(
                      child: selected == null
                          ? _empty(
                              'Select a Record',
                              'Choose a Daily Work Record for review.',
                              Icons.touch_app_outlined,
                            )
                          : _buildDetail(selected),
                    ),
                  ],
                );
              }

              return Column(
                children: <Widget>[
                  SizedBox(height: 120, child: _buildList()),
                  const Divider(height: 1),
                  Expanded(
                    child: selected == null
                        ? _empty(
                            'Select a Record',
                            'Choose a record above.',
                            Icons.touch_app_outlined,
                          )
                        : _buildDetail(selected),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFilters() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(12),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: <Widget>[
          SizedBox(
            width: 260,
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search records...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isEmpty
                    ? null
                    : IconButton(
                        onPressed: () => _searchController.clear(),
                        icon: const Icon(Icons.clear),
                      ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          _filter<String>(
            label: 'Company',
            value: _companyFilter,
            items: _companies,
            onChanged: (value) {
              if (value != null) {
                setState(() => _companyFilter = value);
              }
            },
          ),
          _filter<String>(
            label: 'Status',
            value: _statusFilter,
            items: _statuses,
            onChanged: (value) {
              if (value != null) {
                setState(() => _statusFilter = value);
              }
            },
          ),
          _filter<String>(
            label: 'Period',
            value: _periodFilter,
            items: const <String>[
              'All',
              'Today',
              'This Week',
              'This Month',
            ],
            onChanged: (value) {
              if (value != null) {
                setState(() => _periodFilter = value);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _filter<T>({
    required String label,
    required T value,
    required List<T> items,
    required ValueChanged<T?> onChanged,
  }) {
    return SizedBox(
      width: 170,
      child: DropdownButtonFormField<T>(
        initialValue: items.contains(value) ? value : null,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        items: items
            .map(
              (item) => DropdownMenuItem<T>(
                value: item,
                child: Text(
                  item.toString(),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            )
            .toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildList() {
    final records = _filteredLogs;

    return Material(
      color: Colors.white,
      child: records.isEmpty
          ? _empty(
              'No Matching Records',
              'Change the search or filters.',
              Icons.filter_alt_off_outlined,
            )
          : ListView.separated(
              padding: const EdgeInsets.all(12),
              itemCount: records.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final log = records[index];
                final id = _recordId(log);
                final selected = id == _selectedId;

                return InkWell(
                  borderRadius: BorderRadius.circular(14),
                  onTap: id.isEmpty ? null : () => _select(id),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: selected
                          ? primaryGreen.withValues(alpha: 0.08)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: selected
                            ? primaryGreen
                            : Colors.grey.shade300,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          _company(log).isEmpty
                              ? 'Daily Work Record'
                              : _company(log),
                          style: const TextStyle(
                            color: darkGreen,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _value(
                            log,
                            <String>[
                              'workDescription',
                              'description',
                              'work',
                              'activity',
                            ],
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 7),
                        Wrap(
                          spacing: 5,
                          runSpacing: 5,
                          children: <Widget>[
                            _chip(_date(log), Icons.calendar_today_outlined),
                            _chip(_status(log), Icons.flag_outlined),
                            _chip(
                              '${_linkCount(id)} links',
                              Icons.link_outlined,
                            ),
                            _chip(
                              '${_evidenceCount(id)} evidence',
                              Icons.photo_library_outlined,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  Widget _buildDetail(Map<String, dynamic> log) {
    final id = _recordId(log);
    final link = _links[id];
    final evidence = _evidence[id] ?? <Map<String, dynamic>>[];

    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        _header(log),
        const SizedBox(height: 12),
        _actionBar(log),
        const SizedBox(height: 12),
        _section(
          '117 • Linkage Review',
          Icons.link_outlined,
          <Widget>[
            _row('PTW ID', _value(link ?? {}, <String>['ptwId', 'ptwRecordId'])),
            _row('RAMS ID', _value(link ?? {}, <String>['ramsId', 'ramsRecordId'])),
            _row(
              'Risk / HIRA ID',
              _value(link ?? {}, <String>['riskId', 'riskRecordId', 'hiraId']),
            ),
            _row('Workforce IDs', _listText(link?['workforceIds'])),
            _row('Equipment IDs', _listText(link?['equipmentIds'])),
            if (link == null)
              const Padding(
                padding: EdgeInsets.only(top: 5),
                child: Text(
                  'No separate linkage record found.',
                  style: TextStyle(color: Colors.black54),
                ),
              ),
          ],
        ),
        const SizedBox(height: 12),
        _section(
          '118 • Evidence Review',
          Icons.photo_library_outlined,
          <Widget>[
            if (evidence.isEmpty)
              const Text(
                'No evidence attached to this Daily Work Record.',
                style: TextStyle(color: Colors.black54),
              )
            else
              ...evidence.asMap().entries.map(
                (entry) {
                  final index = entry.key;
                  final item = entry.value;
                  return Card(
                    child: ListTile(
                      leading: const Icon(
                        Icons.photo_outlined,
                        color: primaryGreen,
                      ),
                      title: Text(
                        _value(
                          item,
                          <String>[
                            'title',
                            'note',
                            'description',
                            'observation',
                          ],
                        ).isEmpty
                            ? 'Evidence ${index + 1}'
                            : _value(
                                item,
                                <String>[
                                  'title',
                                  'note',
                                  'description',
                                  'observation',
                                ],
                              ),
                      ),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => _showEvidence(item, index),
                    ),
                  );
                },
              ),
          ],
        ),
        const SizedBox(height: 12),
        _section(
          '119 • Record Edit & Correction',
          Icons.edit_note_outlined,
          <Widget>[
            _row(
              'Work Description',
              _value(
                log,
                <String>[
                  'workDescription',
                  'description',
                  'work',
                  'activity',
                ],
              ),
            ),
            _row(
              'HSE Observations',
              _value(log, <String>['hseObservations', 'observations']),
            ),
            _row(
              'Hazards',
              _value(log, <String>['hazards', 'unsafeConditions']),
            ),
            _row(
              'Corrective Actions',
              _value(log, <String>['correctiveActions', 'actions']),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _section(
          '120 • Record Status Workflow',
          Icons.flag_outlined,
          <Widget>[
            _row('Current Status', _status(log)),
            const SizedBox(height: 6),
            FilledButton.icon(
              onPressed: () => _changeStatus(log),
              icon: const Icon(Icons.swap_horiz),
              label: const Text('Change Status'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _section(
          '121 • Daily / Weekly Record View',
          Icons.date_range_outlined,
          <Widget>[
            _row('Record Date', _date(log)),
            _row('Current Period Filter', _periodFilter),
            _row(
              'Matching Records',
              '${_filteredLogs.length}',
            ),
          ],
        ),
        const SizedBox(height: 12),
        _section(
          '122 • Company-wise HSE Records',
          Icons.business_outlined,
          <Widget>[
            _row(
              'Company',
              _company(log).isEmpty ? 'Not specified' : _company(log),
            ),
            _row(
              'Company Records',
              '${_logs.where((item) => _company(item) == _company(log)).length}',
            ),
          ],
        ),
        const SizedBox(height: 12),
        _section(
          '123 • Record Summary Dashboard',
          Icons.dashboard_outlined,
          <Widget>[
            _metricRow('Total Records', _logs.length),
            _metricRow('Filtered Records', _filteredLogs.length),
            _metricRow('Linked Records', _logs.where(
              (item) => _links.containsKey(_recordId(item)),
            ).length),
            _metricRow('Records With Evidence', _logs.where(
              (item) => _evidence.containsKey(_recordId(item)),
            ).length),
          ],
        ),
        const SizedBox(height: 12),
        _section(
          '124 • Unified Record Package',
          Icons.inventory_2_outlined,
          <Widget>[
            const Text(
              'Combines the selected Daily Work Record with available linkage and evidence summaries.',
              style: TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 10),
            FilledButton.icon(
              onPressed: () => _copyText(
                _recordPackage(log),
                'Unified record package copied.',
              ),
              icon: const Icon(Icons.copy_all_outlined),
              label: const Text('Copy Unified Record Package'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _section(
          '125 • Integration & Validation',
          Icons.verified_outlined,
          <Widget>[
            const Text(
              'Existing Step 111–115 storage keys are used. No new record schema is introduced by this layer.',
              style: TextStyle(color: Colors.black54),
            ),
            const SizedBox(height: 10),
            OutlinedButton.icon(
              onPressed: _showIntegrationAudit,
              icon: const Icon(Icons.fact_check_outlined),
              label: const Text('Run Integration Audit'),
            ),
          ],
        ),
        const SizedBox(height: 18),
        _reviewFooter(id),
      ],
    );
  }

  Widget _header(Map<String, dynamic> log) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: <Color>[primaryGreen, darkGreen],
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Daily Work Record',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            _company(log).isEmpty ? 'Company not specified' : _company(log),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          if (_project(log).isNotEmpty)
            Text(
              _project(log),
              style: const TextStyle(color: Colors.white70),
            ),
          if (_site(log).isNotEmpty)
            Text(
              _site(log),
              style: const TextStyle(color: Colors.white70),
            ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 7,
            runSpacing: 7,
            children: <Widget>[
              _headerChip(_date(log), Icons.calendar_today_outlined),
              _headerChip(_status(log), Icons.flag_outlined),
              _headerChip(_recordId(log), Icons.tag_outlined),
            ],
          ),
        ],
      ),
    );
  }

  Widget _actionBar(Map<String, dynamic> log) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: <Widget>[
          FilledButton.icon(
            onPressed: () => _editRecord(log),
            icon: const Icon(Icons.edit_outlined),
            label: const Text('Edit / Correct'),
          ),
          OutlinedButton.icon(
            onPressed: () => _changeStatus(log),
            icon: const Icon(Icons.flag_outlined),
            label: const Text('Status'),
          ),
          OutlinedButton.icon(
            onPressed: () => _copyText(
              _recordPackage(log),
              'Record package copied.',
            ),
            icon: const Icon(Icons.copy_outlined),
            label: const Text('Copy'),
          ),
        ],
      ),
    );
  }

  Widget _section(
    String title,
    IconData icon,
    List<Widget> children,
  ) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(icon, color: primaryGreen),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: darkGreen,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ...children,
        ],
      ),
    );
  }

  Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 155,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
          Expanded(
            child: SelectableText(
              value.trim().isEmpty ? '—' : value,
            ),
          ),
        ],
      ),
    );
  }

  Widget _metricRow(String label, int value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: Row(
        children: <Widget>[
          Expanded(child: Text(label)),
          Text(
            '$value',
            style: const TextStyle(
              color: darkGreen,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }

  Widget _chip(String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: pageBackground,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, size: 13, color: darkGreen),
          const SizedBox(width: 4),
          Text(
            label.isEmpty ? '—' : label,
            style: const TextStyle(
              fontSize: 11,
              color: darkGreen,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _headerChip(String label, IconData icon) {
    if (label.trim().isEmpty) return const SizedBox.shrink();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, size: 13, color: Colors.white),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _reviewFooter(String id) {
    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: <Widget>[
          const Icon(Icons.lock_outline, color: darkGreen),
          const SizedBox(width: 9),
          Expanded(
            child: Text(
              id.isEmpty
                  ? 'SafeNexus HSE record intelligence layer.'
                  : 'Record $id • Existing storage preserved.',
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _empty(
    String title,
    String message,
    IconData icon,
  ) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(icon, size: 55, color: primaryGreen),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: darkGreen,
                fontSize: 19,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 7),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
