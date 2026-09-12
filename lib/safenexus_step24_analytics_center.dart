import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// SafeNexus HSE - Step 24
/// HSE Analytics & Management Intelligence Center
///
/// A standalone analytics layer for SafeNexus HSE.
/// Existing Phase 1-16 and Step 17-23 files are not modified.
///
/// Architecture:
/// Data Sources -> Normalized KPI Records -> Analytics -> Trends ->
/// Management Priorities -> Action Intelligence
///
/// Existing modules can feed real records through
/// SafeNexusAnalyticsCenter.saveRecords(...).
///
/// The module also supports source-level loaders so future integration can
/// connect existing SharedPreferences registers without changing their UI.

enum SafeNexusAnalyticsCategory {
  project,
  risk,
  ptw,
  workforce,
  equipment,
  dailyHse,
  incident,
  audit,
  environment,
  emergency,
  legal,
  training,
  medical,
  action,
  report,
  general,
}

enum SafeNexusAnalyticsStatus {
  normal,
  attention,
  critical,
  overdue,
  completed,
}

class SafeNexusAnalyticsRecord {
  final String id;
  final String sourceId;
  final String phase;
  final String module;
  final SafeNexusAnalyticsCategory category;
  final String project;
  final String site;
  final String status;
  final String priority;
  final String title;
  final DateTime date;
  final DateTime? dueDate;
  final double score;
  final double target;
  final bool critical;
  final bool overdue;
  final Map<String, dynamic> metadata;

  const SafeNexusAnalyticsRecord({
    required this.id,
    required this.sourceId,
    required this.phase,
    required this.module,
    required this.category,
    required this.project,
    required this.site,
    required this.status,
    required this.priority,
    required this.title,
    required this.date,
    required this.dueDate,
    required this.score,
    required this.target,
    required this.critical,
    required this.overdue,
    required this.metadata,
  });

  SafeNexusAnalyticsRecord copyWith({
    String? status,
    bool? critical,
    bool? overdue,
  }) {
    return SafeNexusAnalyticsRecord(
      id: id,
      sourceId: sourceId,
      phase: phase,
      module: module,
      category: category,
      project: project,
      site: site,
      status: status ?? this.status,
      priority: priority,
      title: title,
      date: date,
      dueDate: dueDate,
      score: score,
      target: target,
      critical: critical ?? this.critical,
      overdue: overdue ?? this.overdue,
      metadata: metadata,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sourceId': sourceId,
      'phase': phase,
      'module': module,
      'category': category.name,
      'project': project,
      'site': site,
      'status': status,
      'priority': priority,
      'title': title,
      'date': date.toIso8601String(),
      'dueDate': dueDate?.toIso8601String(),
      'score': score,
      'target': target,
      'critical': critical,
      'overdue': overdue,
      'metadata': metadata,
    };
  }

  factory SafeNexusAnalyticsRecord.fromJson(
    Map<String, dynamic> json,
  ) {
    return SafeNexusAnalyticsRecord(
      id: _text(json['id']),
      sourceId: _text(json['sourceId']),
      phase: _text(json['phase']),
      module: _text(json['module']),
      category: _category(json['category']),
      project: _text(json['project']),
      site: _text(json['site']),
      status: _text(json['status']),
      priority: _text(json['priority']),
      title: _text(json['title']),
      date:
          DateTime.tryParse(_text(json['date'])) ??
          DateTime.now(),
      dueDate: _date(json['dueDate']),
      score: _number(json['score']),
      target: _number(json['target']),
      critical: json['critical'] == true,
      overdue: json['overdue'] == true,
      metadata: json['metadata'] is Map
          ? Map<String, dynamic>.from(
              json['metadata'] as Map,
            )
          : <String, dynamic>{},
    );
  }

  static String _text(dynamic value) {
    return value?.toString().trim() ?? '';
  }

  static double _number(dynamic value) {
    if (value is num) return value.toDouble();
    return double.tryParse(value?.toString() ?? '') ?? 0;
  }

  static DateTime? _date(dynamic value) {
    if (value == null) return null;
    return DateTime.tryParse(value.toString());
  }

  static SafeNexusAnalyticsCategory _category(dynamic value) {
    return SafeNexusAnalyticsCategory.values.firstWhere(
      (item) => item.name == value?.toString(),
      orElse: () => SafeNexusAnalyticsCategory.general,
    );
  }
}

typedef SafeNexusAnalyticsLoader =
    Future<List<SafeNexusAnalyticsRecord>> Function();

class SafeNexusAnalyticsSource {
  final String id;
  final String phase;
  final String module;
  final SafeNexusAnalyticsCategory category;
  final String? sharedPreferencesKey;
  final SafeNexusAnalyticsLoader? loader;

  const SafeNexusAnalyticsSource({
    required this.id,
    required this.phase,
    required this.module,
    required this.category,
    this.sharedPreferencesKey,
    this.loader,
  });
}

class SafeNexusAnalyticsCenter {
  static const String storageKey =
      'safenexus_hse_step24_analytics_records';

  static Future<List<SafeNexusAnalyticsRecord>> loadRecords() async {
    final prefs = await SharedPreferences.getInstance();
    final values = prefs.getStringList(storageKey) ?? <String>[];
    final records = <SafeNexusAnalyticsRecord>[];

    for (final value in values) {
      try {
        final decoded = jsonDecode(value);
        if (decoded is Map) {
          records.add(
            SafeNexusAnalyticsRecord.fromJson(
              Map<String, dynamic>.from(decoded),
            ),
          );
        }
      } catch (_) {
        // Ignore malformed analytics records.
      }
    }

    records.sort((a, b) => b.date.compareTo(a.date));
    return records;
  }

  static Future<void> saveRecords(
    List<SafeNexusAnalyticsRecord> records,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      storageKey,
      records.map((item) => jsonEncode(item.toJson())).toList(),
    );
  }

  static Future<void> upsert(
    SafeNexusAnalyticsRecord record,
  ) async {
    final records = await loadRecords();
    final index = records.indexWhere(
      (item) => item.id == record.id,
    );

    if (index >= 0) {
      records[index] = record;
    } else {
      records.add(record);
    }

    await saveRecords(records);
  }

  static Future<void> delete(String id) async {
    final records = await loadRecords();
    records.removeWhere((item) => item.id == id);
    await saveRecords(records);
  }

  static Future<void> clear() async {
    await saveRecords(<SafeNexusAnalyticsRecord>[]);
  }

  /// Reads JSON string-list records from a source SharedPreferences key.
  /// Records that cannot be mapped are safely skipped.
  static Future<List<SafeNexusAnalyticsRecord>> loadSource(
    SafeNexusAnalyticsSource source,
  ) async {
    if (source.loader != null) {
      try {
        return await source.loader!();
      } catch (_) {
        return <SafeNexusAnalyticsRecord>[];
      }
    }

    final key = source.sharedPreferencesKey;
    if (key == null || key.isEmpty) {
      return <SafeNexusAnalyticsRecord>[];
    }

    final prefs = await SharedPreferences.getInstance();
    final values = prefs.getStringList(key) ?? <String>[];
    final records = <SafeNexusAnalyticsRecord>[];

    for (var index = 0; index < values.length; index++) {
      try {
        final decoded = jsonDecode(values[index]);
        if (decoded is Map) {
          records.add(
            _mapGenericRecord(
              source,
              Map<String, dynamic>.from(decoded),
              index,
            ),
          );
        }
      } catch (_) {
        // Continue with other source records.
      }
    }

    return records;
  }

  static SafeNexusAnalyticsRecord _mapGenericRecord(
    SafeNexusAnalyticsSource source,
    Map<String, dynamic> json,
    int index,
  ) {
    final id = _first(
      json,
      const [
        'id',
        'recordId',
        'number',
        'no',
        'reference',
        'permitNo',
        'incidentNo',
        'actionNo',
        'documentNo',
      ],
    );

    final title = _first(
      json,
      const [
        'title',
        'name',
        'subject',
        'activityTitle',
        'courseTitle',
        'incidentTitle',
        'actionTitle',
        'description',
      ],
    );

    final status = _first(
      json,
      const [
        'status',
        'approvalStatus',
        'permitStatus',
        'actionStatus',
        'complianceStatus',
      ],
    );

    final priority = _first(
      json,
      const [
        'priority',
        'riskLevel',
        'severity',
        'riskRating',
      ],
    );

    final project = _first(
      json,
      const [
        'project',
        'projectName',
        'projectTitle',
      ],
    );

    final site = _first(
      json,
      const [
        'site',
        'siteName',
        'location',
      ],
    );

    final date = _firstDate(
      json,
      const [
        'date',
        'recordDate',
        'createdAt',
        'updatedAt',
        'trainingDate',
        'inspectionDate',
        'incidentDate',
        'reviewDate',
      ],
    );

    final dueDate = _firstDate(
      json,
      const [
        'dueDate',
        'targetDate',
        'actionDue',
        'nextReview',
        'nextReviewDate',
        'validUntil',
        'expiryDate',
      ],
    );

    final criticalText = [
      priority,
      status,
      title,
    ].join(' ').toLowerCase();

    final critical = criticalText.contains('critical');

    final overdue = dueDate != null &&
        _dayOnly(dueDate).isBefore(
          _dayOnly(DateTime.now()),
        ) &&
        !_isClosedStatus(status);

    return SafeNexusAnalyticsRecord(
      id: id.isEmpty
          ? '${source.id}-${index + 1}'
          : '${source.id}-$id',
      sourceId: source.id,
      phase: source.phase,
      module: source.module,
      category: source.category,
      project: project,
      site: site,
      status: status,
      priority: priority,
      title: title.isEmpty ? source.module : title,
      date: date ?? DateTime.now(),
      dueDate: dueDate,
      score: _firstNumber(
        json,
        const [
          'score',
          'riskScore',
          'actual',
          'kpiActual',
        ],
      ),
      target: _firstNumber(
        json,
        const [
          'target',
          'kpiTarget',
        ],
      ),
      critical: critical,
      overdue: overdue,
      metadata: json,
    );
  }

  static String _first(
    Map<String, dynamic> json,
    List<String> keys,
  ) {
    for (final key in keys) {
      final value = json[key]?.toString().trim() ?? '';
      if (value.isNotEmpty) return value;
    }
    return '';
  }

  static double _firstNumber(
    Map<String, dynamic> json,
    List<String> keys,
  ) {
    for (final key in keys) {
      final value = json[key];
      if (value is num) return value.toDouble();
      final parsed = double.tryParse(
        value?.toString() ?? '',
      );
      if (parsed != null) return parsed;
    }
    return 0;
  }

  static DateTime? _firstDate(
    Map<String, dynamic> json,
    List<String> keys,
  ) {
    for (final key in keys) {
      final value = json[key];
      if (value == null) continue;
      final parsed = DateTime.tryParse(value.toString());
      if (parsed != null) return parsed;
    }
    return null;
  }

  static bool _isClosedStatus(String status) {
    final value = status.toLowerCase();
    return value.contains('closed') ||
        value.contains('completed') ||
        value.contains('cancelled') ||
        value.contains('resolved');
  }

  static DateTime _dayOnly(DateTime value) {
    return DateTime(value.year, value.month, value.day);
  }
}

class SafeNexusAnalyticsCalculator {
  static int count(
    List<SafeNexusAnalyticsRecord> records,
    SafeNexusAnalyticsCategory category,
  ) {
    return records
        .where((item) => item.category == category)
        .length;
  }

  static int critical(
    List<SafeNexusAnalyticsRecord> records,
  ) {
    return records.where((item) => item.critical).length;
  }

  static int overdue(
    List<SafeNexusAnalyticsRecord> records,
  ) {
    return records.where((item) => item.overdue).length;
  }

  static int completed(
    List<SafeNexusAnalyticsRecord> records,
  ) {
    return records
        .where(
          (item) =>
              item.status.toLowerCase().contains('completed') ||
              item.status.toLowerCase().contains('closed') ||
              item.status.toLowerCase().contains('resolved'),
        )
        .length;
  }

  static double completionRate(
    List<SafeNexusAnalyticsRecord> records,
  ) {
    if (records.isEmpty) return 0;

    return completed(records) / records.length * 100;
  }

  static double averageScore(
    List<SafeNexusAnalyticsRecord> records,
  ) {
    final scored = records.where((item) => item.score > 0);
    if (scored.isEmpty) return 0;

    var total = 0.0;
    for (final item in scored) {
      total += item.score;
    }

    return total / scored.length;
  }

  static double kpiAchievementRate(
    List<SafeNexusAnalyticsRecord> records,
  ) {
    final kpis = records.where((item) => item.target > 0);
    if (kpis.isEmpty) return 0;

    var achieved = 0;
    for (final item in kpis) {
      if (item.score >= item.target) {
        achieved++;
      }
    }

    return achieved / kpis.length * 100;
  }

  static Map<String, int> byStatus(
    List<SafeNexusAnalyticsRecord> records,
  ) {
    final result = <String, int>{};

    for (final item in records) {
      final key =
          item.status.isEmpty ? 'Not Set' : item.status;
      result[key] = (result[key] ?? 0) + 1;
    }

    return result;
  }

  static Map<String, int> byPriority(
    List<SafeNexusAnalyticsRecord> records,
  ) {
    final result = <String, int>{};

    for (final item in records) {
      final key =
          item.priority.isEmpty ? 'Not Set' : item.priority;
      result[key] = (result[key] ?? 0) + 1;
    }

    return result;
  }

  static Map<String, int> byPhase(
    List<SafeNexusAnalyticsRecord> records,
  ) {
    final result = <String, int>{};

    for (final item in records) {
      result[item.phase] = (result[item.phase] ?? 0) + 1;
    }

    return result;
  }

  static Map<String, int> byCategory(
    List<SafeNexusAnalyticsRecord> records,
  ) {
    final result = <String, int>{};

    for (final item in records) {
      result[item.category.name] =
          (result[item.category.name] ?? 0) + 1;
    }

    return result;
  }
}

class SafeNexusStep24AnalyticsCenter extends StatefulWidget {
  final List<SafeNexusAnalyticsSource> sources;

  const SafeNexusStep24AnalyticsCenter({
    super.key,
    this.sources = const <SafeNexusAnalyticsSource>[],
  });

  @override
  State<SafeNexusStep24AnalyticsCenter> createState() =>
      _SafeNexusStep24AnalyticsCenterState();
}

class _SafeNexusStep24AnalyticsCenterState
    extends State<SafeNexusStep24AnalyticsCenter> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);

  final TextEditingController _searchController =
      TextEditingController();

  List<SafeNexusAnalyticsRecord> _records =
      <SafeNexusAnalyticsRecord>[];

  String _query = '';
  String _category = 'All';
  String _phase = 'All';
  String _priority = 'All';

  bool _loading = true;

  List<SafeNexusAnalyticsRecord> get _filtered {
    final query = _query.trim().toLowerCase();

    return _records.where((record) {
      final searchable = [
        record.id,
        record.phase,
        record.module,
        record.project,
        record.site,
        record.status,
        record.priority,
        record.title,
        record.category.name,
      ].join(' ').toLowerCase();

      final queryMatch =
          query.isEmpty || searchable.contains(query);

      final categoryMatch =
          _category == 'All' ||
          record.category.name == _category;

      final phaseMatch =
          _phase == 'All' || record.phase == _phase;

      final priorityMatch =
          _priority == 'All' ||
          record.priority.toLowerCase() ==
              _priority.toLowerCase();

      return queryMatch &&
          categoryMatch &&
          phaseMatch &&
          priorityMatch;
    }).toList();
  }

  int get _total => _records.length;

  int get _critical =>
      SafeNexusAnalyticsCalculator.critical(_records);

  int get _overdue =>
      SafeNexusAnalyticsCalculator.overdue(_records);

  int get _completed =>
      SafeNexusAnalyticsCalculator.completed(_records);

  double get _completionRate =>
      SafeNexusAnalyticsCalculator.completionRate(_records);

  double get _kpiAchievement =>
      SafeNexusAnalyticsCalculator.kpiAchievementRate(
        _records,
      );

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearch);
    _load();
  }

  void _onSearch() {
    final value = _searchController.text;
    if (value != _query) {
      setState(() => _query = value);
    }
  }

  Future<void> _load() async {
    setState(() => _loading = true);

    final stored =
        await SafeNexusAnalyticsCenter.loadRecords();

    var combined = List<SafeNexusAnalyticsRecord>.from(
      stored,
    );

    for (final source in widget.sources) {
      final sourceRecords =
          await SafeNexusAnalyticsCenter.loadSource(source);

      for (final record in sourceRecords) {
        final index = combined.indexWhere(
          (item) => item.id == record.id,
        );

        if (index >= 0) {
          combined[index] = record;
        } else {
          combined.add(record);
        }
      }
    }

    combined.sort(
      (a, b) => b.date.compareTo(a.date),
    );

    if (!mounted) return;

    setState(() {
      _records = combined;
      _loading = false;
    });
  }

  Future<void> _deleteRecord(
    SafeNexusAnalyticsRecord record,
  ) async {
    await SafeNexusAnalyticsCenter.delete(record.id);
    await _load();
  }

  Future<void> _clearStoredRecords() async {
    await SafeNexusAnalyticsCenter.clear();
    await _load();
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearch);
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
        title: const Text(
          'HSE Analytics',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            tooltip: 'Refresh',
            onPressed: _load,
            icon: const Icon(Icons.refresh),
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'clear') {
                _confirmClear();
              }
            },
            itemBuilder: (_) => const [
              PopupMenuItem<String>(
                value: 'clear',
                child: Text('Clear local analytics'),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          _searchHeader(),
          _filterBar(),
          Expanded(
            child: _loading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : RefreshIndicator(
                    onRefresh: _load,
                    child: ListView(
                      padding: const EdgeInsets.fromLTRB(
                        12,
                        6,
                        12,
                        24,
                      ),
                      children: [
                        _overviewCard(),
                        const SizedBox(height: 10),
                        _intelligenceCard(),
                        const SizedBox(height: 10),
                        _categoryAnalytics(),
                        const SizedBox(height: 10),
                        _phaseAnalytics(),
                        const SizedBox(height: 10),
                        _priorityAnalytics(),
                        const SizedBox(height: 12),
                        _recordHeader(),
                        const SizedBox(height: 6),
                        if (_filtered.isEmpty)
                          _emptyRecords()
                        else
                          ..._filtered.map(_recordCard),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _searchHeader() {
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
          hintText: 'Search analytics records...',
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

  Widget _filterBar() {
    final phases = <String>{
      'All',
      ..._records.map((item) => item.phase),
    }.toList();

    return SizedBox(
      height: 56,
      child: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 8,
        ),
        scrollDirection: Axis.horizontal,
        children: [
          _filterChip(
            'Category',
            _category,
            [
              'All',
              ...SafeNexusAnalyticsCategory.values.map(
                (item) => item.name,
              ),
            ],
            (value) {
              setState(() => _category = value);
            },
          ),
          _filterChip(
            'Phase',
            _phase,
            phases,
            (value) {
              setState(() => _phase = value);
            },
          ),
          _filterChip(
            'Priority',
            _priority,
            const [
              'All',
              'Low',
              'Medium',
              'High',
              'Critical',
            ],
            (value) {
              setState(() => _priority = value);
            },
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
          avatar: const Icon(
            Icons.filter_list,
            size: 17,
          ),
          label: Text('$label: $selected'),
        ),
      ),
    );
  }

  Widget _overviewCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '24A • HSE Analytics Dashboard',
              style: TextStyle(
                color: darkGreen,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 2.15,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              children: [
                _metric(
                  '$_total',
                  'Total Records',
                  Icons.dataset,
                ),
                _metric(
                  '$_critical',
                  'Critical',
                  Icons.dangerous,
                ),
                _metric(
                  '$_overdue',
                  'Overdue',
                  Icons.warning,
                ),
                _metric(
                  '$_completed',
                  'Completed',
                  Icons.task_alt,
                ),
                _metric(
                  '${_completionRate.toStringAsFixed(1)}%',
                  'Completion',
                  Icons.percent,
                ),
                _metric(
                  '${_kpiAchievement.toStringAsFixed(1)}%',
                  'KPI Achievement',
                  Icons.insights,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _metric(
    String value,
    String label,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(9),
      decoration: BoxDecoration(
        color: primaryGreen.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: primaryGreen,
            size: 22,
          ),
          const SizedBox(width: 7),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    color: darkGreen,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 10),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _intelligenceCard() {
    final priorities = <String>[];

    if (_critical > 0) {
      priorities.add(
        'Critical HSE records require management attention.',
      );
    }

    if (_overdue > 0) {
      priorities.add(
        'Overdue actions or reviews require follow-up.',
      );
    }

    if (_kpiAchievement > 0 && _kpiAchievement < 80) {
      priorities.add(
        'KPI achievement is below the 80% management threshold.',
      );
    }

    if (priorities.isEmpty) {
      priorities.add(
        _total == 0
            ? 'No analytics data is available yet.'
            : 'No high-priority management trigger detected.',
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(
                  Icons.psychology,
                  color: darkGreen,
                ),
                SizedBox(width: 7),
                Text(
                  '24K • Management Intelligence',
                  style: TextStyle(
                    color: darkGreen,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ...priorities.map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '• ',
                      style: TextStyle(
                        color: primaryGreen,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(child: Text(item)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _categoryAnalytics() {
    final values =
        SafeNexusAnalyticsCalculator.byCategory(_records);

    return _distributionCard(
      '24B–J • Category Analytics',
      Icons.dashboard_customize,
      values,
    );
  }

  Widget _phaseAnalytics() {
    final values =
        SafeNexusAnalyticsCalculator.byPhase(_records);

    return _distributionCard(
      '16-Phase • HSE Performance Distribution',
      Icons.account_tree,
      values,
    );
  }

  Widget _priorityAnalytics() {
    final values =
        SafeNexusAnalyticsCalculator.byPriority(_records);

    return _distributionCard(
      'Risk / Priority Trend',
      Icons.priority_high,
      values,
    );
  }

  Widget _distributionCard(
    String title,
    IconData icon,
    Map<String, int> values,
  ) {
    final entries = values.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: darkGreen,
                ),
                const SizedBox(width: 7),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: darkGreen,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (entries.isEmpty)
              Text(
                'No data available.',
                style: TextStyle(
                  color: Colors.grey.shade700,
                ),
              )
            else
              ...entries.take(10).map(
                    (entry) => _distributionRow(
                      entry.key,
                      entry.value,
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _distributionRow(
    String label,
    int value,
  ) {
    final maxValue = _records.isEmpty ? 1 : _records.length;
    final ratio = value / maxValue;

    return Padding(
      padding: const EdgeInsets.only(bottom: 7),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                '$value',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 3),
          LinearProgressIndicator(
            value: ratio.clamp(0.0, 1.0),
            minHeight: 6,
            backgroundColor:
                primaryGreen.withValues(alpha: 0.08),
          ),
        ],
      ),
    );
  }

  Widget _recordHeader() {
    return Row(
      children: [
        const Expanded(
          child: Text(
            'Analytics Records',
            style: TextStyle(
              color: darkGreen,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Text(
          '${_filtered.length} shown',
          style: TextStyle(
            color: Colors.grey.shade700,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _recordCard(
    SafeNexusAnalyticsRecord record,
  ) {
    final alert = record.critical || record.overdue;
    final statusColor = record.overdue
        ? Colors.red
        : record.critical
            ? Colors.deepOrange
            : primaryGreen;

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor:
                      statusColor.withValues(alpha: 0.10),
                  child: Icon(
                    alert
                        ? Icons.priority_high
                        : Icons.analytics,
                    color: statusColor,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        record.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        '${record.phase} • ${record.module}',
                        style: const TextStyle(
                          color: darkGreen,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'delete') {
                      _deleteRecord(record);
                    }
                  },
                  itemBuilder: (_) => const [
                    PopupMenuItem<String>(
                      value: 'delete',
                      child: Text('Delete local record'),
                    ),
                  ],
                  icon: const Icon(Icons.more_vert),
                ),
              ],
            ),
            const SizedBox(height: 7),
            Wrap(
              spacing: 5,
              runSpacing: 4,
              children: [
                _badge(
                  record.category.name,
                  darkGreen,
                ),
                if (record.status.isNotEmpty)
                  _badge(
                    record.status,
                    primaryGreen,
                  ),
                if (record.priority.isNotEmpty)
                  _badge(
                    record.priority,
                    _priorityColor(record.priority),
                  ),
                if (record.critical)
                  _badge(
                    'CRITICAL',
                    Colors.red,
                  ),
                if (record.overdue)
                  _badge(
                    'OVERDUE',
                    Colors.red,
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Project: ${record.project.isEmpty ? 'Not set' : record.project}',
              style: const TextStyle(fontSize: 11),
            ),
            Text(
              'Site: ${record.site.isEmpty ? 'Not set' : record.site}',
              style: const TextStyle(fontSize: 11),
            ),
            if (record.target > 0)
              Text(
                'Score: ${record.score.toStringAsFixed(1)} / '
                '${record.target.toStringAsFixed(1)}',
                style: const TextStyle(fontSize: 11),
              ),
            if (record.dueDate != null)
              Text(
                'Due: ${_formatDate(record.dueDate!)}',
                style: const TextStyle(fontSize: 11),
              ),
          ],
        ),
      ),
    );
  }

  Widget _badge(
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
        borderRadius: BorderRadius.circular(7),
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

  Color _priorityColor(String value) {
    switch (value.toLowerCase()) {
      case 'critical':
        return Colors.red;
      case 'high':
        return Colors.orange.shade700;
      case 'medium':
        return Colors.blueGrey;
      case 'low':
        return Colors.grey.shade700;
      default:
        return darkGreen;
    }
  }

  Widget _emptyRecords() {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        children: [
          Icon(
            Icons.analytics_outlined,
            size: 55,
            color: Colors.grey.shade500,
          ),
          const SizedBox(height: 10),
          const Text(
            'No analytics records found',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            _records.isEmpty
                ? 'Connect existing HSE modules or save analytics '
                  'records to populate this dashboard.'
                : 'Try another search or filter.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey.shade700,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmClear() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Clear local analytics?'),
          content: const Text(
            'This removes only records stored by Step 24. '
            'Existing HSE module records are not deleted.',
          ),
          actions: [
            TextButton(
              onPressed: () =>
                  Navigator.of(dialogContext).pop(false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () =>
                  Navigator.of(dialogContext).pop(true),
              child: const Text('Clear'),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      await _clearStoredRecords();
    }
  }

  String _formatDate(DateTime value) {
    final day = value.day.toString().padLeft(2, '0');
    final month = value.month.toString().padLeft(2, '0');
    return '$day/$month/${value.year}';
  }
}

/// Convenience widget factory for main.dart.
///
/// Example:
/// SafeNexusStep24AnalyticsCenter(
///   sources: [
///     SafeNexusAnalyticsSource(
///       id: 'phase3-hira',
///       phase: 'Phase 3',
///       module: 'HIRA',
///       category: SafeNexusAnalyticsCategory.risk,
///       sharedPreferencesKey: 'your_existing_key',
///     ),
///   ],
/// )
Widget safeNexusStep24AnalyticsCenter({
  List<SafeNexusAnalyticsSource> sources =
      const <SafeNexusAnalyticsSource>[],
}) {
  return SafeNexusStep24AnalyticsCenter(
    sources: sources,
  );
}
