import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// SafeNexus HSE — Step 115
/// HSE Record Search & Filter Hub.
///
/// Read-only review layer for existing Daily Work, linkage and evidence data.
/// Existing Step 111–114 storage is not modified.
class SafeNexusRecordSearchFilterPage extends StatefulWidget {
  const SafeNexusRecordSearchFilterPage({super.key});

  @override
  State<SafeNexusRecordSearchFilterPage> createState() =>
      _SafeNexusRecordSearchFilterPageState();
}

class _SafeNexusRecordSearchFilterPageState
    extends State<SafeNexusRecordSearchFilterPage> {
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
  Map<String, int> _evidenceCounts = <String, int>{};

  String _companyFilter = 'All';
  String _statusFilter = 'All';
  DateTimeRange? _dateFilter;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onFilterChanged);
    _loadData();
  }

  @override
  void dispose() {
    _searchController
      ..removeListener(_onFilterChanged)
      ..dispose();
    super.dispose();
  }

  void _onFilterChanged() {
    if (mounted) setState(() {});
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();

    final logs = _decodeList(prefs.getString(_dailyLogsKey));
    final links = _decodeList(prefs.getString(_linkKey));
    final evidence = _decodeList(prefs.getString(_evidenceKey));

    final linkMap = <String, Map<String, dynamic>>{};
    for (final item in links) {
      final id = (item['logId'] ?? item['dailyLogId'] ?? '').toString();
      if (id.isNotEmpty) {
        linkMap[id] = item;
      }
    }

    final evidenceMap = <String, int>{};
    for (final item in evidence) {
      final id = (item['logId'] ?? item['dailyLogId'] ?? '').toString();
      if (id.isEmpty) continue;
      evidenceMap[id] = (evidenceMap[id] ?? 0) + 1;
    }

    if (!mounted) return;

    setState(() {
      _logs = logs;
      _links = linkMap;
      _evidenceCounts = evidenceMap;
      _loading = false;
    });
  }

  List<Map<String, dynamic>> _decodeList(String? raw) {
    if (raw == null || raw.trim().isEmpty) {
      return <Map<String, dynamic>>[];
    }

    try {
      final decoded = jsonDecode(raw);
      if (decoded is! List) return <Map<String, dynamic>>[];

      return decoded
          .whereType<Map>()
          .map((item) => Map<String, dynamic>.from(item))
          .toList();
    } catch (_) {
      return <Map<String, dynamic>>[];
    }
  }

  String _id(Map<String, dynamic> log) =>
      (log['id'] ?? '').toString().trim();

  String _company(Map<String, dynamic> log) {
    final value = (log['companyName'] ??
            log['company'] ??
            log['company_name'] ??
            '')
        .toString()
        .trim();
    return value.isEmpty ? 'Unassigned Company' : value;
  }

  String _status(Map<String, dynamic> log) {
    final value = (log['status'] ?? 'Draft').toString().trim();
    return value.isEmpty ? 'Draft' : value;
  }

  String _dateText(Map<String, dynamic> log) {
    return (log['date'] ??
            log['workDate'] ??
            log['createdAt'] ??
            '')
        .toString()
        .trim();
  }

  DateTime? _dateOf(Map<String, dynamic> log) {
    final raw = _dateText(log);
    if (raw.isEmpty) return null;
    return DateTime.tryParse(raw);
  }

  String _title(Map<String, dynamic> log) {
    final value = (log['workDescription'] ??
            log['description'] ??
            log['activity'] ??
            log['work'] ??
            'Daily HSE Work')
        .toString()
        .trim();
    return value.isEmpty ? 'Daily HSE Work' : value;
  }

  List<String> get _companies {
    final values = _logs.map(_company).toSet().toList()..sort();
    return <String>['All', ...values];
  }

  List<String> get _statuses {
    final values = _logs.map(_status).toSet().toList()..sort();
    return <String>['All', ...values];
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

      final date = _dateOf(log);
      if (_dateFilter != null && date != null) {
        final start = DateTime(
          _dateFilter!.start.year,
          _dateFilter!.start.month,
          _dateFilter!.start.day,
        );
        final end = DateTime(
          _dateFilter!.end.year,
          _dateFilter!.end.month,
          _dateFilter!.end.day,
          23,
          59,
          59,
          999,
        );
        if (date.isBefore(start) || date.isAfter(end)) {
          return false;
        }
      }

      if (query.isEmpty) return true;

      final searchable = <String>[
        _id(log),
        _title(log),
        _company(log),
        _status(log),
        _dateText(log),
        (log['location'] ?? '').toString(),
        (log['project'] ?? '').toString(),
        (log['supervisor'] ?? '').toString(),
        (log['hseOfficer'] ?? '').toString(),
        (log['ptwReference'] ?? '').toString(),
        (log['ramsReference'] ?? '').toString(),
        (log['hazards'] ?? '').toString(),
        (log['correctiveActions'] ?? '').toString(),
      ].join(' ').toLowerCase();

      return searchable.contains(query);
    }).toList();

    result.sort((a, b) => _dateText(b).compareTo(_dateText(a)));
    return result;
  }

  Future<void> _pickDateRange() async {
    final selected = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      initialDateRange: _dateFilter,
    );

    if (selected == null || !mounted) return;

    setState(() {
      _dateFilter = selected;
    });
  }

  void _clearFilters() {
    _searchController.clear();
    setState(() {
      _companyFilter = 'All';
      _statusFilter = 'All';
      _dateFilter = null;
    });
  }

  Future<void> _copyRecord(Map<String, dynamic> log) async {
    final id = _id(log);
    final link = _links[id];
    final evidenceCount = _evidenceCounts[id] ?? 0;

    final buffer = StringBuffer()
      ..writeln('SafeNexus HSE - HSE Record Review')
      ..writeln('Record ID: $id')
      ..writeln('Company: ${_company(log)}')
      ..writeln('Date: ${_dateText(log)}')
      ..writeln('Status: ${_status(log)}')
      ..writeln('Work: ${_title(log)}')
      ..writeln('Project: ${(log['project'] ?? '').toString()}')
      ..writeln('Location: ${(log['location'] ?? '').toString()}')
      ..writeln('Supervisor: ${(log['supervisor'] ?? '').toString()}')
      ..writeln('HSE Officer: ${(log['hseOfficer'] ?? '').toString()}')
      ..writeln('Evidence Count: $evidenceCount');

    if (link != null) {
      buffer
        ..writeln('Linked PTW: ${_linkedValue(link, 'ptwIds', 'ptwId')}')
        ..writeln('Linked RAMS: ${_linkedValue(link, 'ramsIds', 'ramsId')}')
        ..writeln(
          'Linked Risk/HIRA: '
          '${_linkedValue(link, 'riskIds', 'riskId')}',
        )
        ..writeln(
          'Linked Workforce: '
          '${_linkedValue(link, 'workforceIds', 'workforceId')}',
        )
        ..writeln(
          'Linked Equipment: '
          '${_linkedValue(link, 'equipmentIds', 'equipmentId')}',
        );
    }

    await Clipboard.setData(
      ClipboardData(text: buffer.toString().trim()),
    );
    _message('Record summary copied.');
  }

  String _linkedValue(
    Map<String, dynamic> link,
    String listKey,
    String singleKey,
  ) {
    final list = link[listKey];
    if (list is List) {
      final values = list.map((item) => item.toString()).toList();
      if (values.isNotEmpty) return values.join(', ');
    }

    final single = (link[singleKey] ?? '').toString().trim();
    return single.isEmpty ? 'Not linked' : single;
  }

  void _showRecord(Map<String, dynamic> log) {
    final id = _id(log);
    final link = _links[id];
    final evidenceCount = _evidenceCounts[id] ?? 0;

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 18, 18, 24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  _title(log),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: darkGreen,
                  ),
                ),
                const SizedBox(height: 8),
                _detail('Record ID', id),
                _detail('Company', _company(log)),
                _detail('Date', _dateText(log)),
                _detail('Status', _status(log)),
                _detail(
                  'Project',
                  (log['project'] ?? '').toString(),
                ),
                _detail(
                  'Location',
                  (log['location'] ?? '').toString(),
                ),
                _detail(
                  'Supervisor',
                  (log['supervisor'] ?? '').toString(),
                ),
                _detail(
                  'HSE Officer',
                  (log['hseOfficer'] ?? '').toString(),
                ),
                _detail('Evidence', '$evidenceCount item(s)'),
                if (link != null) ...<Widget>[
                  const SizedBox(height: 8),
                  const Text(
                    'Record Linkage',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: darkGreen,
                    ),
                  ),
                  _detail(
                    'PTW',
                    _linkedValue(link, 'ptwIds', 'ptwId'),
                  ),
                  _detail(
                    'RAMS',
                    _linkedValue(link, 'ramsIds', 'ramsId'),
                  ),
                  _detail(
                    'Risk / HIRA',
                    _linkedValue(link, 'riskIds', 'riskId'),
                  ),
                  _detail(
                    'Workforce',
                    _linkedValue(
                      link,
                      'workforceIds',
                      'workforceId',
                    ),
                  ),
                  _detail(
                    'Equipment',
                    _linkedValue(
                      link,
                      'equipmentIds',
                      'equipmentId',
                    ),
                  ),
                ],
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: () {
                      Navigator.of(context).pop();
                      _copyRecord(log);
                    },
                    icon: const Icon(Icons.copy_all_outlined),
                    label: const Text('Copy Record Summary'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _detail(String label, String value) {
    final display = value.trim().isEmpty ? 'Not recorded' : value;
    return Padding(
      padding: const EdgeInsets.only(top: 7),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 105,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
          Expanded(child: Text(display)),
        ],
      ),
    );
  }

  Widget _buildFilterCard() {
    final dateLabel = _dateFilter == null
        ? 'Any date'
        : '${_formatDate(_dateFilter!.start)} - '
            '${_formatDate(_dateFilter!.end)}';

    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: primaryGreen.withValues(alpha: 0.16),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search HSE records',
                hintText:
                    'Work, company, project, location, ID...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isEmpty
                    ? null
                    : IconButton(
                        onPressed: _searchController.clear,
                        icon: const Icon(Icons.clear),
                      ),
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: <Widget>[
                Expanded(
                  child: DropdownButtonFormField<String>(
                    initialValue: _companies.contains(_companyFilter)
                        ? _companyFilter
                        : 'All',
                    decoration: const InputDecoration(
                      labelText: 'Company',
                      border: OutlineInputBorder(),
                    ),
                    items: _companies
                        .map(
                          (value) => DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value == null) return;
                      setState(() {
                        _companyFilter = value;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    initialValue: _statuses.contains(_statusFilter)
                        ? _statusFilter
                        : 'All',
                    decoration: const InputDecoration(
                      labelText: 'Status',
                      border: OutlineInputBorder(),
                    ),
                    items: _statuses
                        .map(
                          (value) => DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value == null) return;
                      setState(() {
                        _statusFilter = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: <Widget>[
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _pickDateRange,
                    icon: const Icon(Icons.date_range_outlined),
                    label: Text(
                      dateLabel,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  tooltip: 'Clear filters',
                  onPressed: _clearFilters,
                  icon: const Icon(Icons.filter_alt_off_outlined),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecordCard(Map<String, dynamic> log) {
    final id = _id(log);
    final links = _links[id];
    final evidenceCount = _evidenceCounts[id] ?? 0;
    final linkedCount = links == null ? 0 : _linkedCount(links);

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () => _showRecord(log),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      _title(log),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: darkGreen,
                      ),
                    ),
                  ),
                  _statusChip(_status(log)),
                ],
              ),
              const SizedBox(height: 7),
              Text(
                '${_company(log)} • ${_dateText(log)}',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              if ((log['location'] ?? '').toString().trim().isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    (log['location'] ?? '').toString(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 7,
                runSpacing: 7,
                children: <Widget>[
                  _metricChip(
                    Icons.link_outlined,
                    'Links $linkedCount',
                  ),
                  _metricChip(
                    Icons.photo_library_outlined,
                    'Evidence $evidenceCount',
                  ),
                ],
              ),
              const SizedBox(height: 7),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      'ID: $id',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    tooltip: 'Copy',
                    onPressed: () => _copyRecord(log),
                    icon: const Icon(Icons.copy_outlined),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  int _linkedCount(Map<String, dynamic> link) {
    var count = 0;
    const listKeys = <String>[
      'ptwIds',
      'ramsIds',
      'riskIds',
      'workforceIds',
      'equipmentIds',
    ];
    const singleKeys = <String>[
      'ptwId',
      'ramsId',
      'riskId',
      'workforceId',
      'equipmentId',
    ];

    for (final key in listKeys) {
      final value = link[key];
      if (value is List) {
        count += value.where(
          (item) => item.toString().trim().isNotEmpty,
        ).length;
      }
    }

    for (final key in singleKeys) {
      final value = (link[key] ?? '').toString().trim();
      if (value.isNotEmpty) count++;
    }

    return count;
  }

  Widget _statusChip(String status) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: primaryGreen.withValues(alpha: 0.10),
      ),
      child: Text(
        status,
        style: const TextStyle(
          color: darkGreen,
          fontSize: 12,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  Widget _metricChip(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: pageBackground,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, size: 15, color: primaryGreen),
          const SizedBox(width: 5),
          Text(
            text,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    if (_logs.isEmpty) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(18),
        children: <Widget>[
          _emptyCard(
            Icons.assignment_outlined,
            'No Daily Work Records',
            'Create a Daily Work Record first. This search hub reads existing records only.',
          ),
        ],
      );
    }

    final records = _filteredLogs;

    return RefreshIndicator(
      onRefresh: _loadData,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
        children: <Widget>[
          _buildFilterCard(),
          const SizedBox(height: 14),
          Row(
            children: <Widget>[
              const Expanded(
                child: Text(
                  'HSE Records',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: darkGreen,
                  ),
                ),
              ),
              Text(
                '${records.length} result(s)',
                style: const TextStyle(
                  color: primaryGreen,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          if (records.isEmpty)
            _emptyCard(
              Icons.search_off_outlined,
              'No Matching Records',
              'Try another search term or clear one of the filters.',
            )
          else
            ...records.map(_buildRecordCard),
        ],
      ),
    );
  }

  Widget _emptyCard(IconData icon, String title, String text) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(icon, color: primaryGreen, size: 30),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: const TextStyle(
                      color: darkGreen,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(text),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime value) {
    return '${value.day.toString().padLeft(2, '0')}/'
        '${value.month.toString().padLeft(2, '0')}/'
        '${value.year}';
  }

  void _message(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: darkGreen,
        elevation: 0,
        title: const Text(
          'HSE Record Search',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        actions: <Widget>[
          IconButton(
            tooltip: 'Refresh',
            onPressed: _loadData,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _buildBody(),
    );
  }
}
