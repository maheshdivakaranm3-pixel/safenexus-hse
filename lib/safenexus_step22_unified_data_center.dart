import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// SafeNexus HSE - Step 22
/// Unified HSE Data Integration & Global Search
///
/// This is a safe, modular data-index/search layer.
/// It does not alter the existing Phase 1-16, Step 17-21 files.
///
/// Existing modules can register their records with:
///   SafeNexusRecordSource
///
/// The source can either:
/// 1. supply records directly, or
/// 2. supply a SharedPreferences key containing JSON record lists.
///
/// For production integration, register the exact storage keys used by
/// existing modules. This keeps their business logic unchanged.

typedef SafeNexusRecordsLoader =
    Future<List<Map<String, dynamic>>> Function();

typedef SafeNexusRecordOpener = Future<void> Function(
  BuildContext context,
  SafeNexusUnifiedRecord record,
);

class SafeNexusRecordSource {
  final String id;
  final String phase;
  final String title;
  final String group;
  final String? sharedPreferencesKey;
  final SafeNexusRecordsLoader? loader;
  final SafeNexusRecordOpener? opener;

  const SafeNexusRecordSource({
    required this.id,
    required this.phase,
    required this.title,
    required this.group,
    this.sharedPreferencesKey,
    this.loader,
    this.opener,
  });
}

class SafeNexusUnifiedRecord {
  final String sourceId;
  final String phase;
  final String module;
  final String recordId;
  final String title;
  final String subtitle;
  final String status;
  final String priority;
  final String project;
  final String site;
  final String location;
  final DateTime? recordDate;
  final DateTime? dueDate;
  final Map<String, dynamic> data;

  const SafeNexusUnifiedRecord({
    required this.sourceId,
    required this.phase,
    required this.module,
    required this.recordId,
    required this.title,
    required this.subtitle,
    required this.status,
    required this.priority,
    required this.project,
    required this.site,
    required this.location,
    required this.recordDate,
    required this.dueDate,
    required this.data,
  });

  bool get isOverdue {
    if (dueDate == null) return false;
    final normalized = DateTime(
      dueDate!.year,
      dueDate!.month,
      dueDate!.day,
    );
    final today = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );
    return normalized.isBefore(today) &&
        !_isClosedStatus(status);
  }

  bool get isCritical {
    final value = priority.toLowerCase();
    return value == 'critical' || value == 'very high';
  }

  static bool _isClosedStatus(String value) {
    final status = value.toLowerCase();
    return status == 'closed' ||
        status == 'completed' ||
        status == 'cancelled' ||
        status == 'approved';
  }
}

class SafeNexusStep22DataCenter extends StatefulWidget {
  final List<SafeNexusRecordSource> sources;

  const SafeNexusStep22DataCenter({
    super.key,
    this.sources = const <SafeNexusRecordSource>[],
  });

  @override
  State<SafeNexusStep22DataCenter> createState() =>
      _SafeNexusStep22DataCenterState();
}

class _SafeNexusStep22DataCenterState
    extends State<SafeNexusStep22DataCenter> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);

  static const String _favoritesKey = 'safenexus_step22_favorite_records';

  final TextEditingController _searchController = TextEditingController();

  List<SafeNexusUnifiedRecord> _records =
      <SafeNexusUnifiedRecord>[];
  List<String> _favoriteRecordIds = <String>[];

  String _query = '';
  String _phaseFilter = 'All';
  String _statusFilter = 'All';
  String _priorityFilter = 'All';
  String _projectFilter = 'All';
  String _siteFilter = 'All';
  bool _overdueOnly = false;
  bool _criticalOnly = false;
  bool _loading = false;

  List<SafeNexusRecordSource> get _sources {
    final custom = <String, SafeNexusRecordSource>{
      for (final source in widget.sources) source.id: source,
    };

    final result = _defaultSources
        .map((source) => custom[source.id] ?? source)
        .toList();

    for (final source in widget.sources) {
      if (!result.any((item) => item.id == source.id)) {
        result.add(source);
      }
    }

    return result;
  }

  final List<SafeNexusRecordSource> _defaultSources =
      const <SafeNexusRecordSource>[
    SafeNexusRecordSource(
      id: 'phase1',
      phase: 'Phase 1',
      title: 'Project Pre-Start',
      group: 'Core HSE',
    ),
    SafeNexusRecordSource(
      id: 'phase2',
      phase: 'Phase 2',
      title: 'HSE Management System',
      group: 'Core HSE',
    ),
    SafeNexusRecordSource(
      id: 'phase3',
      phase: 'Phase 3',
      title: 'Risk & Planning',
      group: 'Risk & Control',
    ),
    SafeNexusRecordSource(
      id: 'phase4',
      phase: 'Phase 4',
      title: 'Permit to Work',
      group: 'Risk & Control',
    ),
    SafeNexusRecordSource(
      id: 'phase5',
      phase: 'Phase 5',
      title: 'Site Mobilization',
      group: 'Operations',
    ),
    SafeNexusRecordSource(
      id: 'phase6',
      phase: 'Phase 6',
      title: 'Workforce & Competency',
      group: 'People & Resources',
    ),
    SafeNexusRecordSource(
      id: 'phase7',
      phase: 'Phase 7',
      title: 'Equipment & Machinery',
      group: 'People & Resources',
    ),
    SafeNexusRecordSource(
      id: 'phase8',
      phase: 'Phase 8',
      title: 'High-Risk Activities',
      group: 'Risk & Control',
    ),
    SafeNexusRecordSource(
      id: 'phase9',
      phase: 'Phase 9',
      title: 'Daily HSE Work',
      group: 'Operations',
    ),
    SafeNexusRecordSource(
      id: 'phase10',
      phase: 'Phase 10',
      title: 'Emergency Management',
      group: 'Emergency',
    ),
    SafeNexusRecordSource(
      id: 'phase11',
      phase: 'Phase 11',
      title: 'Occupational Health',
      group: 'Health & Environment',
    ),
    SafeNexusRecordSource(
      id: 'phase12',
      phase: 'Phase 12',
      title: 'Chemical & Environment',
      group: 'Health & Environment',
    ),
    SafeNexusRecordSource(
      id: 'phase13',
      phase: 'Phase 13',
      title: 'Inspection & Audit',
      group: 'Assurance',
    ),
    SafeNexusRecordSource(
      id: 'phase14',
      phase: 'Phase 14',
      title: 'Incident Management',
      group: 'Assurance',
    ),
    SafeNexusRecordSource(
      id: 'phase15',
      phase: 'Phase 15',
      title: 'HSE Reporting',
      group: 'Reporting',
    ),
    SafeNexusRecordSource(
      id: 'phase16',
      phase: 'Phase 16',
      title: 'Legal / Authority',
      group: 'Compliance',
    ),
    SafeNexusRecordSource(
      id: 'step17',
      phase: 'Step 17',
      title: 'Master Dashboard',
      group: 'Management',
    ),
    SafeNexusRecordSource(
      id: 'step18',
      phase: 'Step 18',
      title: 'HSE Action Center',
      group: 'Management',
    ),
    SafeNexusRecordSource(
      id: 'step19',
      phase: 'Step 19',
      title: 'Integration & Navigation',
      group: 'Management',
    ),
    SafeNexusRecordSource(
      id: 'step20',
      phase: 'Step 20',
      title: 'Production App Shell',
      group: 'Management',
    ),
    SafeNexusRecordSource(
      id: 'step21',
      phase: 'Step 21',
      title: 'Real Module Connection',
      group: 'Management',
    ),
  ];

  List<String> get _phases {
    final values = <String>{'All'};
    for (final record in _records) {
      values.add(record.phase);
    }
    return values.toList();
  }

  List<String> get _statuses {
    final values = <String>{'All'};
    for (final record in _records) {
      if (record.status.trim().isNotEmpty) {
        values.add(record.status);
      }
    }
    return values.toList();
  }

  List<String> get _priorities {
    final values = <String>{'All'};
    for (final record in _records) {
      if (record.priority.trim().isNotEmpty) {
        values.add(record.priority);
      }
    }
    return values.toList();
  }

  List<String> get _projects {
    final values = <String>{'All'};
    for (final record in _records) {
      if (record.project.trim().isNotEmpty) {
        values.add(record.project);
      }
    }
    return values.toList();
  }

  List<String> get _sites {
    final values = <String>{'All'};
    for (final record in _records) {
      if (record.site.trim().isNotEmpty) {
        values.add(record.site);
      }
    }
    return values.toList();
  }

  List<SafeNexusUnifiedRecord> get _filteredRecords {
    final query = _query.trim().toLowerCase();

    return _records.where((record) {
      final searchable = [
        record.recordId,
        record.title,
        record.subtitle,
        record.module,
        record.phase,
        record.status,
        record.priority,
        record.project,
        record.site,
        record.location,
        ...record.data.entries.map(
          (entry) => '${entry.key} ${entry.value}',
        ),
      ].join(' ').toLowerCase();

      final queryMatch =
          query.isEmpty || searchable.contains(query);

      final phaseMatch =
          _phaseFilter == 'All' ||
          record.phase == _phaseFilter;

      final statusMatch =
          _statusFilter == 'All' ||
          record.status == _statusFilter;

      final priorityMatch =
          _priorityFilter == 'All' ||
          record.priority == _priorityFilter;

      final projectMatch =
          _projectFilter == 'All' ||
          record.project == _projectFilter;

      final siteMatch =
          _siteFilter == 'All' ||
          record.site == _siteFilter;

      final overdueMatch =
          !_overdueOnly || record.isOverdue;

      final criticalMatch =
          !_criticalOnly || record.isCritical;

      return queryMatch &&
          phaseMatch &&
          statusMatch &&
          priorityMatch &&
          projectMatch &&
          siteMatch &&
          overdueMatch &&
          criticalMatch;
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearch);
    _loadFavorites();
    _loadRecords();
  }

  void _onSearch() {
    final value = _searchController.text;
    if (value != _query) {
      setState(() => _query = value);
    }
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;

    setState(() {
      _favoriteRecordIds =
          prefs.getStringList(_favoritesKey) ?? <String>[];
    });
  }

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      _favoritesKey,
      _favoriteRecordIds,
    );
  }

  Future<void> _loadRecords() async {
    setState(() => _loading = true);

    final combined = <SafeNexusUnifiedRecord>[];

    for (final source in _sources) {
      try {
        final raw = await _readSource(source);

        for (var index = 0; index < raw.length; index++) {
          final record = _mapRecord(
            source,
            raw[index],
            index,
          );

          if (record != null) {
            combined.add(record);
          }
        }
      } catch (_) {
        // One unavailable source must not stop other HSE sources.
      }
    }

    if (!mounted) return;

    setState(() {
      _records = combined;
      _loading = false;
    });
  }

  Future<List<Map<String, dynamic>>> _readSource(
    SafeNexusRecordSource source,
  ) async {
    if (source.loader != null) {
      return source.loader!();
    }

    final key = source.sharedPreferencesKey;
    if (key == null || key.trim().isEmpty) {
      return <Map<String, dynamic>>[];
    }

    final prefs = await SharedPreferences.getInstance();
    final jsonList = prefs.getStringList(key);

    if (jsonList == null) {
      return <Map<String, dynamic>>[];
    }

    final records = <Map<String, dynamic>>[];

    for (final item in jsonList) {
      final decoded = _decodeMap(item);
      if (decoded != null) {
        records.add(decoded);
      }
    }

    return records;
  }

  Map<String, dynamic>? _decodeMap(String value) {
    try {
      final dynamic decoded = _decodeJson(value);

      if (decoded is Map) {
        return Map<String, dynamic>.from(decoded);
      }
    } catch (_) {
      return null;
    }

    return null;
  }

  dynamic _decodeJson(String value) {
    return jsonDecode(value);
  }

  SafeNexusUnifiedRecord? _mapRecord(
    SafeNexusRecordSource source,
    Map<String, dynamic> raw,
    int index,
  ) {
    final recordId = _firstString(
      raw,
      const [
        'id',
        'recordId',
        'number',
        'no',
        'reference',
        'ref',
        'permitNo',
        'incidentNo',
        'actionNo',
        'documentNo',
      ],
    );

    final title = _firstString(
      raw,
      const [
        'title',
        'name',
        'subject',
        'activityTitle',
        'recordTitle',
        'description',
        'courseTitle',
      ],
    );

    final status = _firstString(
      raw,
      const [
        'status',
        'approvalStatus',
        'actionStatus',
        'permitStatus',
        'complianceStatus',
      ],
    );

    final priority = _firstString(
      raw,
      const [
        'priority',
        'riskLevel',
        'severity',
        'initialRiskLevel',
        'residualRiskLevel',
      ],
    );

    final project = _firstString(
      raw,
      const [
        'project',
        'projectName',
      ],
    );

    final site = _firstString(
      raw,
      const [
        'site',
        'siteName',
      ],
    );

    final location = _firstString(
      raw,
      const [
        'location',
        'workLocation',
        'area',
      ],
    );

    final subtitle = _firstString(
      raw,
      const [
        'description',
        'subtitle',
        'remarks',
        'scope',
        'activity',
        'subject',
      ],
    );

    final recordDate = _firstDate(
      raw,
      const [
        'date',
        'recordDate',
        'createdAt',
        'updatedAt',
        'inspectionDate',
        'incidentDate',
        'trainingDate',
      ],
    );

    final dueDate = _firstDate(
      raw,
      const [
        'dueDate',
        'actionDue',
        'targetDate',
        'reviewDate',
        'nextReview',
        'nextReviewDate',
        'validUntil',
        'expiryDate',
        'submissionDue',
      ],
    );

    final safeId = recordId.isEmpty
        ? '${source.id}-$index'
        : recordId;

    return SafeNexusUnifiedRecord(
      sourceId: source.id,
      phase: source.phase,
      module: source.title,
      recordId: safeId,
      title: title.isEmpty ? source.title : title,
      subtitle: subtitle,
      status: status.isEmpty ? 'Not Set' : status,
      priority: priority.isEmpty ? 'Not Set' : priority,
      project: project,
      site: site,
      location: location,
      recordDate: recordDate,
      dueDate: dueDate,
      data: raw,
    );
  }

  String _firstString(
    Map<String, dynamic> data,
    List<String> keys,
  ) {
    for (final key in keys) {
      final value = data[key];
      if (value == null) continue;

      final text = value.toString().trim();
      if (text.isNotEmpty) {
        return text;
      }
    }

    return '';
  }

  DateTime? _firstDate(
    Map<String, dynamic> data,
    List<String> keys,
  ) {
    for (final key in keys) {
      final value = data[key];
      if (value == null) continue;

      final parsed = _parseDate(value);
      if (parsed != null) return parsed;
    }

    return null;
  }

  DateTime? _parseDate(dynamic value) {
    if (value is DateTime) return value;

    final text = value.toString().trim();
    if (text.isEmpty) return null;

    return DateTime.tryParse(text);
  }

  Future<void> _toggleFavorite(
    SafeNexusUnifiedRecord record,
  ) async {
    setState(() {
      if (_favoriteRecordIds.contains(_recordKey(record))) {
        _favoriteRecordIds.remove(_recordKey(record));
      } else {
        _favoriteRecordIds.add(_recordKey(record));
      }
    });

    await _saveFavorites();
  }

  String _recordKey(SafeNexusUnifiedRecord record) {
    return '${record.sourceId}:${record.recordId}';
  }

  bool _isFavorite(SafeNexusUnifiedRecord record) {
    return _favoriteRecordIds.contains(_recordKey(record));
  }

  Future<void> _openRecord(
    SafeNexusUnifiedRecord record,
  ) async {
    final source = _sources.firstWhere(
      (item) => item.id == record.sourceId,
      orElse: () => SafeNexusRecordSource(
        id: record.sourceId,
        phase: record.phase,
        title: record.module,
        group: 'HSE',
      ),
    );

    if (source.opener != null) {
      await source.opener!(context, record);
      return;
    }

    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => _RecordDetailsPage(
          record: record,
        ),
      ),
    );
  }

  void _resetFilters() {
    setState(() {
      _phaseFilter = 'All';
      _statusFilter = 'All';
      _priorityFilter = 'All';
      _projectFilter = 'All';
      _siteFilter = 'All';
      _overdueOnly = false;
      _criticalOnly = false;
    });
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearch);
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final records = _filteredRecords;

    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
        title: const Text(
          'SafeNexus HSE Data Center',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            tooltip: 'Refresh',
            onPressed: _loadRecords,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchHeader(),
          _buildFilterBar(),
          _buildSummary(),
          Expanded(
            child: _loading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : records.isEmpty
                    ? _emptyState()
                    : ListView.builder(
                        padding: const EdgeInsets.fromLTRB(
                          12,
                          5,
                          12,
                          20,
                        ),
                        itemCount: records.length,
                        itemBuilder: (_, index) {
                          return _recordCard(records[index]);
                        },
                      ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchHeader() {
    return Container(
      color: darkGreen,
      padding: const EdgeInsets.fromLTRB(
        12,
        10,
        12,
        12,
      ),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Search all HSE records...',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: _query.isEmpty
              ? null
              : IconButton(
                  onPressed: _searchController.clear,
                  icon: const Icon(Icons.clear),
                ),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildFilterBar() {
    return SizedBox(
      height: 54,
      child: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 8,
        ),
        scrollDirection: Axis.horizontal,
        children: [
          _filterChip(
            'Phase',
            _phaseFilter,
            _phases,
            (value) {
              setState(() => _phaseFilter = value);
            },
          ),
          _filterChip(
            'Status',
            _statusFilter,
            _statuses,
            (value) {
              setState(() => _statusFilter = value);
            },
          ),
          _filterChip(
            'Priority',
            _priorityFilter,
            _priorities,
            (value) {
              setState(() => _priorityFilter = value);
            },
          ),
          _filterChip(
            'Project',
            _projectFilter,
            _projects,
            (value) {
              setState(() => _projectFilter = value);
            },
          ),
          _filterChip(
            'Site',
            _siteFilter,
            _sites,
            (value) {
              setState(() => _siteFilter = value);
            },
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: const Text('Overdue'),
              selected: _overdueOnly,
              selectedColor:
                  Colors.red.withValues(alpha: 0.12),
              onSelected: (value) {
                setState(() => _overdueOnly = value);
              },
            ),
          ),
          FilterChip(
            label: const Text('Critical'),
            selected: _criticalOnly,
            selectedColor:
                Colors.red.withValues(alpha: 0.12),
            onSelected: (value) {
              setState(() => _criticalOnly = value);
            },
          ),
          IconButton(
            tooltip: 'Reset filters',
            onPressed: _resetFilters,
            icon: const Icon(Icons.filter_alt_off),
          ),
        ],
      ),
    );
  }

  Widget _filterChip(
    String label,
    String selected,
    List<String> values,
    ValueChanged<String> onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: PopupMenuButton<String>(
        onSelected: onChanged,
        itemBuilder: (_) => values
            .map(
              (value) => PopupMenuItem<String>(
                value: value,
                child: Text(value),
              ),
            )
            .toList(),
        child: Chip(
          label: Text('$label: $selected'),
          avatar: const Icon(
            Icons.filter_list,
            size: 17,
          ),
        ),
      ),
    );
  }

  Widget _buildSummary() {
    final filtered = _filteredRecords;
    final overdue =
        filtered.where((record) => record.isOverdue).length;
    final critical =
        filtered.where((record) => record.isCritical).length;

    return Container(
      margin: const EdgeInsets.fromLTRB(
        12,
        3,
        12,
        8,
      ),
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: primaryGreen.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: primaryGreen.withValues(alpha: 0.15),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: _summaryValue(
              '${filtered.length}',
              'Results',
            ),
          ),
          Expanded(
            child: _summaryValue(
              '$overdue',
              'Overdue',
            ),
          ),
          Expanded(
            child: _summaryValue(
              '$critical',
              'Critical',
            ),
          ),
          Expanded(
            child: _summaryValue(
              '${_records.length}',
              'Indexed',
            ),
          ),
        ],
      ),
    );
  }

  Widget _summaryValue(
    String value,
    String label,
  ) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: darkGreen,
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 10),
        ),
      ],
    );
  }

  Widget _recordCard(
    SafeNexusUnifiedRecord record,
  ) {
    final favorite = _isFavorite(record);
    final overdue = record.isOverdue;
    final critical = record.isCritical;

    return Card(
      margin: const EdgeInsets.only(bottom: 9),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _openRecord(record),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor:
                    primaryGreen.withValues(alpha: 0.10),
                child: const Icon(
                  Icons.description,
                  color: primaryGreen,
                ),
              ),
              const SizedBox(width: 11),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      record.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${record.phase} • ${record.module}',
                      style: const TextStyle(
                        color: darkGreen,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (record.recordId.isNotEmpty) ...[
                      const SizedBox(height: 3),
                      Text(
                        'Ref: ${record.recordId}',
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 11,
                        ),
                      ),
                    ],
                    const SizedBox(height: 5),
                    Wrap(
                      spacing: 5,
                      runSpacing: 4,
                      children: [
                        _statusBadge(
                          record.status,
                          _statusColor(record.status),
                        ),
                        if (record.priority != 'Not Set')
                          _statusBadge(
                            record.priority,
                            critical
                                ? Colors.red
                                : Colors.orange.shade700,
                          ),
                        if (overdue)
                          _statusBadge(
                            'OVERDUE',
                            Colors.red,
                          ),
                      ],
                    ),
                    if (record.project.isNotEmpty ||
                        record.site.isNotEmpty) ...[
                      const SizedBox(height: 5),
                      Text(
                        [
                          if (record.project.isNotEmpty)
                            record.project,
                          if (record.site.isNotEmpty)
                            record.site,
                        ].join(' • '),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              IconButton(
                tooltip: favorite
                    ? 'Remove favourite'
                    : 'Add favourite',
                onPressed: () => _toggleFavorite(record),
                icon: Icon(
                  favorite
                      ? Icons.star
                      : Icons.star_border,
                  color: favorite
                      ? Colors.amber.shade700
                      : Colors.grey,
                ),
              ),
              const Icon(
                Icons.chevron_right,
                size: 22,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statusBadge(
    String text,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 7,
        vertical: 3,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 9,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Color _statusColor(String status) {
    final value = status.toLowerCase();

    if (value.contains('closed') ||
        value.contains('completed') ||
        value.contains('approved') ||
        value.contains('compliant')) {
      return primaryGreen;
    }

    if (value.contains('critical') ||
        value.contains('rejected') ||
        value.contains('non-compliant') ||
        value.contains('overdue')) {
      return Colors.red;
    }

    if (value.contains('progress') ||
        value.contains('review') ||
        value.contains('pending')) {
      return Colors.orange.shade700;
    }

    return darkGreen;
  }

  Widget _emptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 54,
              color: Colors.grey.shade500,
            ),
            const SizedBox(height: 12),
            const Text(
              'No HSE records found',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              _records.isEmpty
                  ? 'Register existing module storage keys or loaders '
                    'to populate the unified data index.'
                  : 'Try a different search or reset the filters.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey.shade700,
                height: 1.4,
              ),
            ),
            if (_records.isNotEmpty) ...[
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: _resetFilters,
                icon: const Icon(Icons.filter_alt_off),
                label: const Text('Reset Filters'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _RecordDetailsPage extends StatelessWidget {
  final SafeNexusUnifiedRecord record;

  const _RecordDetailsPage({
    required this.record,
  });

  @override
  Widget build(BuildContext context) {
    const primaryGreen = Color(0xFF159447);
    const darkGreen = Color(0xFF0B5D4B);

    final entries = record.data.entries.toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
        title: const Text('Record Details'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(14),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    record.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    '${record.phase} • ${record.module}',
                    style: const TextStyle(
                      color: darkGreen,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _detailRow(
                    'Reference',
                    record.recordId,
                  ),
                  _detailRow(
                    'Status',
                    record.status,
                  ),
                  _detailRow(
                    'Priority / Risk',
                    record.priority,
                  ),
                  if (record.project.isNotEmpty)
                    _detailRow(
                      'Project',
                      record.project,
                    ),
                  if (record.site.isNotEmpty)
                    _detailRow(
                      'Site',
                      record.site,
                    ),
                  if (record.location.isNotEmpty)
                    _detailRow(
                      'Location',
                      record.location,
                    ),
                  if (record.recordDate != null)
                    _detailRow(
                      'Record Date',
                      _formatDate(record.recordDate!),
                    ),
                  if (record.dueDate != null)
                    _detailRow(
                      'Due / Review Date',
                      _formatDate(record.dueDate!),
                    ),
                  if (record.isOverdue)
                    const Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Row(
                        children: [
                          Icon(
                            Icons.warning,
                            color: Colors.red,
                          ),
                          SizedBox(width: 7),
                          Text(
                            'This record is overdue.',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Source Data',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: darkGreen,
            ),
          ),
          const SizedBox(height: 6),
          ...entries.map(
            (entry) => Card(
              child: ListTile(
                title: Text(entry.key),
                subtitle: Text(
                  entry.value?.toString() ?? '',
                ),
                leading: const Icon(
                  Icons.data_object,
                  color: primaryGreen,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _detailRow(
    String label,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 7),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value.isEmpty ? 'Not set' : value,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    return '$day/${date.year}-$month';
  }
}

/// Convenience helper.
///
/// Example:
///
/// MaterialApp(
///   home: safeNexusStep22DataCenter(
///     sources: [
///       SafeNexusRecordSource(
///         id: 'phase3',
///         phase: 'Phase 3',
///         title: 'Risk & Planning',
///         group: 'Risk & Control',
///         sharedPreferencesKey:
///             'your_existing_storage_key',
///       ),
///     ],
///   ),
/// );
Widget safeNexusStep22DataCenter({
  List<SafeNexusRecordSource> sources =
      const <SafeNexusRecordSource>[],
}) {
  return SafeNexusStep22DataCenter(
    sources: sources,
  );
}
