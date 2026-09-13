import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'equipment_machinery.dart';
import 'hira_risk_assessment.dart';
import 'ptw_master_register.dart';
import 'rams_method_statement.dart';
import 'workforce_master_register.dart';

/// SafeNexus HSE — Step 112
/// Full Record Linkage for Company & Daily Work Log.
///
/// This layer intentionally keeps Step 111's existing Daily Work Log storage
/// unchanged. It stores only the real record IDs selected from existing
/// modules in a separate linkage table.
///
/// Linked modules:
/// - PTW Master Register
/// - RAMS / Method Statement
/// - HIRA / Risk Assessment
/// - Workforce Master Register
/// - Equipment & Machinery
///
/// Storage:
/// - Existing module storage is read as-is.
/// - Link mappings are stored in:
///   workhub_daily_log_record_links_v1
///
/// This is local/offline linkage. It does not create duplicate PTW, RAMS,
/// workforce, equipment or risk records.
class WorkHubRecordLink {
  const WorkHubRecordLink({
    required this.logId,
    this.ptwId = '',
    this.ramsId = '',
    this.riskId = '',
    this.workforceIds = const <String>[],
    this.equipmentIds = const <String>[],
    this.updatedAt = '',
  });

  final String logId;
  final String ptwId;
  final String ramsId;
  final String riskId;
  final List<String> workforceIds;
  final List<String> equipmentIds;
  final String updatedAt;

  WorkHubRecordLink copyWith({
    String? logId,
    String? ptwId,
    String? ramsId,
    String? riskId,
    List<String>? workforceIds,
    List<String>? equipmentIds,
    String? updatedAt,
  }) {
    return WorkHubRecordLink(
      logId: logId ?? this.logId,
      ptwId: ptwId ?? this.ptwId,
      ramsId: ramsId ?? this.ramsId,
      riskId: riskId ?? this.riskId,
      workforceIds: workforceIds ?? this.workforceIds,
      equipmentIds: equipmentIds ?? this.equipmentIds,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'logId': logId,
        'ptwId': ptwId,
        'ramsId': ramsId,
        'riskId': riskId,
        'workforceIds': workforceIds,
        'equipmentIds': equipmentIds,
        'updatedAt': updatedAt,
      };

  factory WorkHubRecordLink.fromJson(Map<String, dynamic> json) {
    List<String> stringList(dynamic value) {
      if (value is! List) return <String>[];
      return value.map((item) => item.toString()).where((item) => item.isNotEmpty).toList();
    }

    return WorkHubRecordLink(
      logId: (json['logId'] ?? '').toString(),
      ptwId: (json['ptwId'] ?? '').toString(),
      ramsId: (json['ramsId'] ?? '').toString(),
      riskId: (json['riskId'] ?? '').toString(),
      workforceIds: stringList(json['workforceIds']),
      equipmentIds: stringList(json['equipmentIds']),
      updatedAt: (json['updatedAt'] ?? '').toString(),
    );
  }
}

class WorkHubRecordLinkagePage extends StatefulWidget {
  const WorkHubRecordLinkagePage({super.key});

  @override
  State<WorkHubRecordLinkagePage> createState() =>
      _WorkHubRecordLinkagePageState();
}

class _WorkHubRecordLinkagePageState extends State<WorkHubRecordLinkagePage> {
  static const String _dailyLogsKey = 'workhub_daily_logs_v1';
  static const String _ptwKey = 'safenexus_hse_ptw_master_register';
  static const String _ramsKey = 'safenexus_hse_rams_method_statements';
  static const String _riskKey = 'safenexus_hse_hira_risk_assessments';
  static const String _workforceKey =
      'safenexus_hse_workforce_master_register';
  static const String _equipmentKey = 'safenexus_hse_equipment_machinery';
  static const String _linksKey = 'workhub_daily_log_record_links_v1';

  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);

  bool _loading = true;
  List<Map<String, dynamic>> _dailyLogs = <Map<String, dynamic>>[];
  List<Map<String, dynamic>> _ptwRecords = <Map<String, dynamic>>[];
  List<Map<String, dynamic>> _ramsRecords = <Map<String, dynamic>>[];
  List<Map<String, dynamic>> _riskRecords = <Map<String, dynamic>>[];
  List<Map<String, dynamic>> _workforceRecords = <Map<String, dynamic>>[];
  List<Map<String, dynamic>> _equipmentRecords = <Map<String, dynamic>>[];
  List<WorkHubRecordLink> _links = <WorkHubRecordLink>[];

  String? _selectedLogId;
  String _search = '';

  WorkHubRecordLink? get _selectedLink {
    if (_selectedLogId == null) return null;
    for (final link in _links) {
      if (link.logId == _selectedLogId) return link;
    }
    return null;
  }

  Map<String, dynamic>? get _selectedLog {
    if (_selectedLogId == null) return null;
    for (final log in _dailyLogs) {
      if (_recordId(log, const <String>['id']) == _selectedLogId) {
        return log;
      }
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    _loadAll();
  }

  Future<void> _loadAll() async {
    final prefs = await SharedPreferences.getInstance();

    final dailyLogs = _readJsonList(
      prefs.getString(_dailyLogsKey),
    );
    final ptwRecords = _readJsonList(
      prefs.getString(_ptwKey),
    );
    final ramsRecords = _readJsonList(
      prefs.getString(_ramsKey),
    );
    final riskRecords = _readJsonList(
      prefs.getString(_riskKey),
    );

    final workforceRecords = _readStringListJson(
      prefs.getStringList(_workforceKey) ?? <String>[],
    );

    final equipmentRecords = _readEquipmentList(
      prefs.getStringList(_equipmentKey) ?? <String>[],
    );

    final links = _readJsonList(
      prefs.getString(_linksKey),
    ).map(WorkHubRecordLink.fromJson).toList();

    if (!mounted) return;

    setState(() {
      _dailyLogs = dailyLogs;
      _ptwRecords = ptwRecords;
      _ramsRecords = ramsRecords;
      _riskRecords = riskRecords;
      _workforceRecords = workforceRecords;
      _equipmentRecords = equipmentRecords;
      _links = links;
      _loading = false;

      if (_selectedLogId == null && _dailyLogs.isNotEmpty) {
        _selectedLogId = _recordId(_dailyLogs.first, const <String>['id']);
      }
    });
  }

  List<Map<String, dynamic>> _readJsonList(String? raw) {
    if (raw == null || raw.trim().isEmpty) {
      return <Map<String, dynamic>>[];
    }

    try {
      final decoded = jsonDecode(raw);
      if (decoded is! List) return <Map<String, dynamic>>[];

      return decoded
          .whereType<Map>()
          .map(
            (item) => Map<String, dynamic>.from(
              item.map(
                (key, value) => MapEntry(key.toString(), value),
              ),
            ),
          )
          .toList();
    } catch (_) {
      return <Map<String, dynamic>>[];
    }
  }

  List<Map<String, dynamic>> _readStringListJson(List<String> raw) {
    final result = <Map<String, dynamic>>[];

    for (final item in raw) {
      try {
        final decoded = jsonDecode(item);
        if (decoded is Map) {
          result.add(
            Map<String, dynamic>.from(
              decoded.map(
                (key, value) => MapEntry(key.toString(), value),
              ),
            ),
          );
        }
      } catch (_) {
        // Ignore malformed legacy workforce records.
      }
    }

    return result;
  }

  List<Map<String, dynamic>> _readEquipmentList(List<String> raw) {
    const keys = <String>[
      'id',
      'equipmentNo',
      'equipmentName',
      'category',
      'manufacturer',
      'model',
      'serialNo',
      'assetNo',
      'ownerCompany',
      'project',
      'site',
      'location',
      'department',
      'responsiblePerson',
      'operatorName',
      'operatorId',
      'operatorVerification',
      'capacityRating',
      'safeWorkingLoad',
      'inspectionDate',
      'inspectionExpiry',
      'inspectionStatus',
      'certificateNo',
      'certificateType',
      'certificateExpiry',
      'thirdPartyInspector',
      'maintenanceDate',
      'nextMaintenanceDate',
      'maintenanceStatus',
      'calibrationDate',
      'calibrationExpiry',
      'defectDescription',
      'quarantineReason',
      'releaseDate',
      'releaseBy',
      'preUseInspection',
      'readiness',
      'deploymentClearance',
      'clearanceBy',
      'clearanceDate',
      'status',
      'nextReviewDate',
      'remarks',
      'createdAt',
      'updatedAt',
    ];

    final result = <Map<String, dynamic>>[];

    for (final item in raw) {
      final parts = item.split('|');
      final record = <String, dynamic>{};

      for (var index = 0; index < keys.length; index++) {
        record[keys[index]] =
            index < parts.length ? parts[index] : '';
      }

      result.add(record);
    }

    return result;
  }

  String _recordId(
    Map<String, dynamic> record,
    List<String> preferredKeys,
  ) {
    for (final key in preferredKeys) {
      final value = record[key]?.toString().trim() ?? '';
      if (value.isNotEmpty) return value;
    }

    final fallbackKeys = <String>[
      'id',
      'permitNo',
      'ramsNo',
      'riskAssessmentNo',
      'assessmentNo',
      'workerNo',
      'equipmentNo',
      'assetNo',
    ];

    for (final key in fallbackKeys) {
      final value = record[key]?.toString().trim() ?? '';
      if (value.isNotEmpty) return value;
    }

    return '';
  }

  String _displayId(
    Map<String, dynamic> record,
    List<String> preferredKeys,
  ) {
    return _recordId(record, preferredKeys);
  }

  String _value(Map<String, dynamic> record, List<String> keys) {
    for (final key in keys) {
      final value = record[key]?.toString().trim() ?? '';
      if (value.isNotEmpty) return value;
    }
    return '';
  }

  String _recordSubtitle(
    Map<String, dynamic> record,
    String module,
  ) {
    switch (module) {
      case 'PTW':
        return _joinNonEmpty(<String>[
          _value(record, const <String>['permitType']),
          _value(record, const <String>['activity', 'workDescription']),
          _value(record, const <String>['location']),
          _value(record, const <String>['status']),
        ]);
      case 'RAMS':
        return _joinNonEmpty(<String>[
          _value(record, const <String>['activity', 'scope']),
          _value(record, const <String>['project']),
          _value(record, const <String>['location']),
          _value(record, const <String>['status']),
        ]);
      case 'Risk':
        return _joinNonEmpty(<String>[
          _value(record, const <String>['activity', 'hazard']),
          _value(record, const <String>['residualRiskLevel', 'riskLevel']),
          _value(record, const <String>['status']),
        ]);
      case 'Workforce':
        return _joinNonEmpty(<String>[
          _value(record, const <String>['jobTitle', 'trade']),
          _value(record, const <String>['workerCategory']),
          _value(record, const <String>['status']),
        ]);
      case 'Equipment':
        return _joinNonEmpty(<String>[
          _value(record, const <String>['equipmentName']),
          _value(record, const <String>['category']),
          _value(record, const <String>['readiness']),
          _value(record, const <String>['status']),
        ]);
      default:
        return '';
    }
  }

  String _joinNonEmpty(List<String> values) {
    return values.where((value) => value.trim().isNotEmpty).join(' • ');
  }

  String _logTitle(Map<String, dynamic> log) {
    final work = _value(
      log,
      const <String>['workDescription'],
    );
    return work.isEmpty ? 'Daily Work Log' : work;
  }

  List<Map<String, dynamic>> get _filteredLogs {
    final query = _search.trim().toLowerCase();

    final result = _dailyLogs.where((log) {
      if (query.isEmpty) return true;

      final searchable = <String>[
        _value(log, const <String>['id']),
        _value(log, const <String>['date']),
        _value(log, const <String>['companyId']),
        _value(log, const <String>['workDescription']),
        _value(log, const <String>['status']),
        _value(log, const <String>['ptw']),
        _value(log, const <String>['rams']),
      ].join(' ').toLowerCase();

      return searchable.contains(query);
    }).toList();

    result.sort(
      (a, b) => _value(
        b,
        const <String>['date', 'updatedAt'],
      ).compareTo(
        _value(
          a,
          const <String>['date', 'updatedAt'],
        ),
      ),
    );

    return result;
  }

  WorkHubRecordLink _linkFor(String logId) {
    for (final link in _links) {
      if (link.logId == logId) return link;
    }

    return WorkHubRecordLink(logId: logId);
  }

  Future<void> _saveLinks() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _linksKey,
      jsonEncode(
        _links.map((link) => link.toJson()).toList(),
      ),
    );
  }

  Future<void> _saveLink(WorkHubRecordLink link) async {
    final index = _links.indexWhere(
      (item) => item.logId == link.logId,
    );

    final updated = <WorkHubRecordLink>[..._links];

    if (index == -1) {
      updated.add(link);
    } else {
      updated[index] = link;
    }

    setState(() => _links = updated);
    await _saveLinks();
  }

  Future<void> _editLinks() async {
    final log = _selectedLog;
    if (log == null) return;

    final current = _linkFor(_selectedLogId!);

    final result = await Navigator.of(context).push<WorkHubRecordLink>(
      MaterialPageRoute<WorkHubRecordLink>(
        builder: (_) => _RecordLinkEditorPage(
          log: log,
          current: current,
          ptwRecords: _ptwRecords,
          ramsRecords: _ramsRecords,
          riskRecords: _riskRecords,
          workforceRecords: _workforceRecords,
          equipmentRecords: _equipmentRecords,
          recordId: _recordId,
          value: _value,
          displaySubtitle: _recordSubtitle,
        ),
      ),
    );

    if (result == null) return;

    await _saveLink(result);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Daily Work Log linked to existing HSE records.',
        ),
      ),
    );
  }

  Future<void> _clearLinks() async {
    final log = _selectedLog;
    if (log == null) return;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Clear linked records?'),
        content: const Text(
          'This removes only the links. Existing PTW, RAMS, Risk, Workforce and Equipment records are not deleted.',
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Clear Links'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    setState(() {
      _links = _links
          .where((link) => link.logId != _selectedLogId)
          .toList();
    });

    await _saveLinks();

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Record links cleared.')),
    );
  }

  void _openModule(BuildContext context, String module) {
    final Widget page;

    switch (module) {
      case 'PTW':
        page = const PtwMasterRegisterPage();
        break;
      case 'RAMS':
        page = const RamsMethodStatementPage();
        break;
      case 'Risk':
        page = const HiraRiskAssessmentPage();
        break;
      case 'Workforce':
        page = const WorkforceMasterRegisterPage();
        break;
      case 'Equipment':
        page = const EquipmentMachineryPage();
        break;
      default:
        return;
    }

    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => page,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final logs = _filteredLogs;
    final link = _selectedLink;

    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: darkGreen,
        elevation: 0,
        title: const Text(
          'Daily Work Record Linkage',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        actions: <Widget>[
          IconButton(
            tooltip: 'Refresh existing module records',
            onPressed: _loadAll,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Row(
        children: <Widget>[
          SizedBox(
            width: 285,
            child: _buildLogList(logs),
          ),
          const VerticalDivider(width: 1),
          Expanded(
            child: _buildDetails(link),
          ),
        ],
      ),
    );
  }

  Widget _buildLogList(List<Map<String, dynamic>> logs) {
    return Material(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
            child: TextField(
              onChanged: (value) {
                setState(() => _search = value);
              },
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                labelText: 'Search Daily Work',
                border: OutlineInputBorder(),
                isDense: true,
              ),
            ),
          ),
          Expanded(
            child: logs.isEmpty
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.all(18),
                      child: Text(
                        'No Daily Work Logs found.\nCreate a log first in Company & Daily Work Log.',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: logs.length,
                    itemBuilder: (context, index) {
                      final log = logs[index];
                      final id = _recordId(
                        log,
                        const <String>['id'],
                      );
                      final selected = id == _selectedLogId;

                      return ListTile(
                        selected: selected,
                        selectedTileColor:
                            primaryGreen.withValues(alpha: 0.08),
                        leading: CircleAvatar(
                          backgroundColor:
                              primaryGreen.withValues(alpha: 0.12),
                          foregroundColor: darkGreen,
                          child: const Icon(
                            Icons.fact_check_outlined,
                            size: 20,
                          ),
                        ),
                        title: Text(
                          _logTitle(log),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(
                          '${_value(log, const <String>['date'])} • '
                          '${_value(log, const <String>['status'])}',
                        ),
                        onTap: () {
                          setState(() => _selectedLogId = id);
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetails(WorkHubRecordLink? link) {
    final log = _selectedLog;

    if (log == null) {
      return const Center(
        child: Text(
          'Select a Daily Work Log to link its HSE records.',
        ),
      );
    }

    final actualLink = link ?? _linkFor(_selectedLogId!);

    return ListView(
      padding: const EdgeInsets.all(18),
      children: <Widget>[
        _logHeader(log),
        const SizedBox(height: 14),
        _summaryCard(actualLink),
        const SizedBox(height: 14),
        _moduleCard(
          title: 'PTW',
          icon: Icons.fact_check_outlined,
          id: actualLink.ptwId,
          record: _findRecord(_ptwRecords, actualLink.ptwId),
          emptyText: 'No PTW linked',
        ),
        _moduleCard(
          title: 'RAMS / Method Statement',
          icon: Icons.description_outlined,
          id: actualLink.ramsId,
          record: _findRecord(_ramsRecords, actualLink.ramsId),
          emptyText: 'No RAMS linked',
        ),
        _moduleCard(
          title: 'Risk / HIRA',
          icon: Icons.warning_amber_outlined,
          id: actualLink.riskId,
          record: _findRecord(_riskRecords, actualLink.riskId),
          emptyText: 'No Risk / HIRA linked',
        ),
        _multiModuleCard(
          title: 'Workforce',
          icon: Icons.groups_outlined,
          ids: actualLink.workforceIds,
          records: _workforceRecords,
          emptyText: 'No workforce records linked',
          preferredKeys: const <String>['id', 'workerNo'],
        ),
        _multiModuleCard(
          title: 'Equipment / Machinery',
          icon: Icons.construction_outlined,
          ids: actualLink.equipmentIds,
          records: _equipmentRecords,
          emptyText: 'No equipment records linked',
          preferredKeys: const <String>['id', 'equipmentNo'],
        ),
        const SizedBox(height: 8),
        Row(
          children: <Widget>[
            Expanded(
              child: FilledButton.icon(
                onPressed: _editLinks,
                icon: const Icon(Icons.link),
                label: const Text('Select / Update Links'),
                style: FilledButton.styleFrom(
                  backgroundColor: primaryGreen,
                ),
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              tooltip: 'Clear links',
              onPressed: _clearLinks,
              icon: const Icon(
                Icons.link_off_outlined,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _logHeader(Map<String, dynamic> log) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Selected Daily Work Log',
              style: TextStyle(
                color: darkGreen,
                fontWeight: FontWeight.w800,
                fontSize: 17,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _logTitle(log),
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'ID: ${_recordId(log, const <String>['id'])}',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 3),
            Text(
              'Date: ${_value(log, const <String>['date'])}',
              style: const TextStyle(fontSize: 12),
            ),
            Text(
              'Company: ${_value(log, const <String>['companyId'])}',
              style: const TextStyle(fontSize: 12),
            ),
            Text(
              'Status: ${_value(log, const <String>['status'])}',
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _summaryCard(WorkHubRecordLink link) {
    final count = <String>[
      if (link.ptwId.isNotEmpty) 'PTW',
      if (link.ramsId.isNotEmpty) 'RAMS',
      if (link.riskId.isNotEmpty) 'Risk',
      if (link.workforceIds.isNotEmpty) 'Workforce',
      if (link.equipmentIds.isNotEmpty) 'Equipment',
    ].length;

    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: <Widget>[
            CircleAvatar(
              backgroundColor: primaryGreen.withValues(alpha: 0.12),
              foregroundColor: darkGreen,
              child: Text(
                '$count',
                style: const TextStyle(fontWeight: FontWeight.w900),
              ),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Text(
                'Existing module records are linked by ID. No duplicate record is created.',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _moduleCard({
    required String title,
    required IconData icon,
    required String id,
    required Map<String, dynamic>? record,
    required String emptyText,
  }) {
    final linked = id.isNotEmpty && record != null;

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: primaryGreen.withValues(alpha: 0.10),
          foregroundColor: darkGreen,
          child: Icon(icon),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w800),
        ),
        subtitle: Text(
          linked
              ? '${_displayId(record, const <String>['id'])}\n'
                  '${_recordSubtitle(record, title == 'PTW' ? 'PTW' : title.startsWith('RAMS') ? 'RAMS' : 'Risk')}'
              : emptyText,
        ),
        isThreeLine: true,
        trailing: Icon(
          linked ? Icons.link : Icons.link_off_outlined,
          color: linked ? primaryGreen : Colors.grey,
        ),
      ),
    );
  }

  Widget _multiModuleCard({
    required String title,
    required IconData icon,
    required List<String> ids,
    required List<Map<String, dynamic>> records,
    required String emptyText,
    required List<String> preferredKeys,
  }) {
    final linkedRecords = ids
        .map((id) => _findRecord(records, id, preferredKeys: preferredKeys))
        .whereType<Map<String, dynamic>>()
        .toList();

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      child: ExpansionTile(
        leading: CircleAvatar(
          backgroundColor: primaryGreen.withValues(alpha: 0.10),
          foregroundColor: darkGreen,
          child: Icon(icon),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w800),
        ),
        subtitle: Text(
          linkedRecords.isEmpty
              ? emptyText
              : '${linkedRecords.length} record(s) linked',
        ),
        children: linkedRecords.isEmpty
            ? const <Widget>[]
            : linkedRecords
                .map(
                  (record) => ListTile(
                    dense: true,
                    title: Text(
                      _displayId(record, preferredKeys),
                    ),
                    subtitle: Text(
                      _recordSubtitle(
                        record,
                        title == 'Workforce'
                            ? 'Workforce'
                            : 'Equipment',
                      ),
                    ),
                  ),
                )
                .toList(),
      ),
    );
  }

  Map<String, dynamic>? _findRecord(
    List<Map<String, dynamic>> records,
    String id, {
    List<String> preferredKeys = const <String>['id'],
  }) {
    if (id.isEmpty) return null;

    for (final record in records) {
      if (_recordId(record, preferredKeys) == id) {
        return record;
      }
    }

    return null;
  }
}

class _RecordLinkEditorPage extends StatefulWidget {
  const _RecordLinkEditorPage({
    required this.log,
    required this.current,
    required this.ptwRecords,
    required this.ramsRecords,
    required this.riskRecords,
    required this.workforceRecords,
    required this.equipmentRecords,
    required this.recordId,
    required this.value,
    required this.displaySubtitle,
  });

  final Map<String, dynamic> log;
  final WorkHubRecordLink current;
  final List<Map<String, dynamic>> ptwRecords;
  final List<Map<String, dynamic>> ramsRecords;
  final List<Map<String, dynamic>> riskRecords;
  final List<Map<String, dynamic>> workforceRecords;
  final List<Map<String, dynamic>> equipmentRecords;

  final String Function(
    Map<String, dynamic>,
    List<String>,
  ) recordId;

  final String Function(
    Map<String, dynamic>,
    List<String>,
  ) value;

  final String Function(
    Map<String, dynamic>,
    String,
  ) displaySubtitle;

  @override
  State<_RecordLinkEditorPage> createState() =>
      _RecordLinkEditorPageState();
}

class _RecordLinkEditorPageState extends State<_RecordLinkEditorPage> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);

  String _ptwId = '';
  String _ramsId = '';
  String _riskId = '';
  Set<String> _workforceIds = <String>{};
  Set<String> _equipmentIds = <String>{};

  @override
  void initState() {
    super.initState();

    _ptwId = widget.current.ptwId;
    _ramsId = widget.current.ramsId;
    _riskId = widget.current.riskId;
    _workforceIds = widget.current.workforceIds.toSet();
    _equipmentIds = widget.current.equipmentIds.toSet();
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.viewInsetsOf(context).bottom;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F8F7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: darkGreen,
        elevation: 0,
        title: const Text(
          'Select HSE Records',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(16, 16, 16, bottom + 24),
        children: <Widget>[
          _selectedLogCard(),
          const SizedBox(height: 12),
          _singleSelector(
            title: 'PTW',
            icon: Icons.fact_check_outlined,
            records: widget.ptwRecords,
            selectedId: _ptwId,
            preferredKeys: const <String>['id', 'permitNo'],
            module: 'PTW',
            onChanged: (value) {
              setState(() => _ptwId = value);
            },
          ),
          _singleSelector(
            title: 'RAMS / Method Statement',
            icon: Icons.description_outlined,
            records: widget.ramsRecords,
            selectedId: _ramsId,
            preferredKeys: const <String>['id', 'ramsNo'],
            module: 'RAMS',
            onChanged: (value) {
              setState(() => _ramsId = value);
            },
          ),
          _singleSelector(
            title: 'Risk / HIRA',
            icon: Icons.warning_amber_outlined,
            records: widget.riskRecords,
            selectedId: _riskId,
            preferredKeys: const <String>[
              'id',
              'riskAssessmentNo',
              'assessmentNo',
            ],
            module: 'Risk',
            onChanged: (value) {
              setState(() => _riskId = value);
            },
          ),
          _multiSelector(
            title: 'Workforce',
            icon: Icons.groups_outlined,
            records: widget.workforceRecords,
            selectedIds: _workforceIds,
            preferredKeys: const <String>['id', 'workerNo'],
            module: 'Workforce',
            onChanged: (value) {
              setState(() => _workforceIds = value);
            },
          ),
          _multiSelector(
            title: 'Equipment / Machinery',
            icon: Icons.construction_outlined,
            records: widget.equipmentRecords,
            selectedIds: _equipmentIds,
            preferredKeys: const <String>['id', 'equipmentNo'],
            module: 'Equipment',
            onChanged: (value) {
              setState(() => _equipmentIds = value);
            },
          ),
          const SizedBox(height: 8),
          FilledButton.icon(
            onPressed: _save,
            icon: const Icon(Icons.save_outlined),
            label: const Text('Save Record Links'),
            style: FilledButton.styleFrom(
              backgroundColor: primaryGreen,
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _selectedLogCard() {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Daily Work Log',
              style: TextStyle(
                color: darkGreen,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              widget.value(
                widget.log,
                const <String>['workDescription'],
              ),
              style: const TextStyle(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 3),
            Text(
              'Date: ${widget.value(widget.log, const <String>['date'])}',
            ),
          ],
        ),
      ),
    );
  }

  Widget _singleSelector({
    required String title,
    required IconData icon,
    required List<Map<String, dynamic>> records,
    required String selectedId,
    required List<String> preferredKeys,
    required String module,
    required ValueChanged<String> onChanged,
  }) {
    if (records.isEmpty) {
      return _emptyModuleCard(
        title: title,
        icon: icon,
        message: 'No records available. Create a record in $module first.',
      );
    }

    final validIds = records
        .map((record) => widget.recordId(record, preferredKeys))
        .where((id) => id.isNotEmpty)
        .toList();

    final currentValue =
        validIds.contains(selectedId) ? selectedId : '';

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(icon, color: primaryGreen),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    color: darkGreen,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              initialValue: currentValue.isEmpty ? null : currentValue,
              isExpanded: true,
              decoration: InputDecoration(
                labelText: 'Select $title',
                border: const OutlineInputBorder(),
              ),
              items: <DropdownMenuItem<String>>[
                const DropdownMenuItem<String>(
                  value: '',
                  child: Text('Not linked'),
                ),
                ...records
                    .map(
                      (record) => DropdownMenuItem<String>(
                        value: widget.recordId(
                          record,
                          preferredKeys,
                        ),
                        child: Text(
                          _menuText(record, module, preferredKeys),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    )
                    .where(
                      (item) => item.value != null && item.value!.isNotEmpty,
                    ),
              ],
              onChanged: (value) => onChanged(value ?? ''),
            ),
          ],
        ),
      ),
    );
  }

  Widget _multiSelector({
    required String title,
    required IconData icon,
    required List<Map<String, dynamic>> records,
    required Set<String> selectedIds,
    required List<String> preferredKeys,
    required String module,
    required ValueChanged<Set<String>> onChanged,
  }) {
    if (records.isEmpty) {
      return _emptyModuleCard(
        title: title,
        icon: icon,
        message: 'No records available. Create a record in $module first.',
      );
    }

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(icon, color: primaryGreen),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    color: darkGreen,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              selectedIds.isEmpty
                  ? 'No $module records selected'
                  : '${selectedIds.length} $module record(s) selected',
              style: const TextStyle(fontSize: 12, color: Colors.black54),
            ),
            const SizedBox(height: 8),
            ...records.map(
              (record) {
                final id = widget.recordId(
                  record,
                  preferredKeys,
                );
                if (id.isEmpty) return const SizedBox.shrink();

                return CheckboxListTile(
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  value: selectedIds.contains(id),
                  activeColor: primaryGreen,
                  title: Text(
                    _menuText(
                      record,
                      module,
                      preferredKeys,
                    ),
                  ),
                  subtitle: Text(
                    widget.displaySubtitle(record, module),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  onChanged: (checked) {
                    final next = <String>{...selectedIds};

                    if (checked == true) {
                      next.add(id);
                    } else {
                      next.remove(id);
                    }

                    onChanged(next);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _emptyModuleCard({
    required String title,
    required IconData icon,
    required String message,
  }) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: primaryGreen.withValues(alpha: 0.10),
          foregroundColor: darkGreen,
          child: Icon(icon),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w800),
        ),
        subtitle: Text(message),
      ),
    );
  }

  String _menuText(
    Map<String, dynamic> record,
    String module,
    List<String> preferredKeys,
  ) {
    final id = widget.recordId(record, preferredKeys);
    final title = widget.value(
      record,
      module == 'PTW'
          ? const <String>['permitNo', 'activity']
          : module == 'RAMS'
              ? const <String>['ramsNo', 'activity', 'scope']
              : module == 'Risk'
                  ? const <String>[
                      'riskAssessmentNo',
                      'assessmentNo',
                      'activity',
                    ]
                  : module == 'Workforce'
                      ? const <String>['fullName', 'workerNo']
                      : const <String>[
                          'equipmentName',
                          'equipmentNo',
                        ],
    );

    return title.isEmpty ? id : '$title • $id';
  }

  void _save() {
    final now = DateTime.now().toIso8601String();

    Navigator.of(context).pop(
      WorkHubRecordLink(
        logId: widget.recordId(
          widget.log,
          const <String>['id'],
        ),
        ptwId: _ptwId,
        ramsId: _ramsId,
        riskId: _riskId,
        workforceIds: _workforceIds.toList()..sort(),
        equipmentIds: _equipmentIds.toList()..sort(),
        updatedAt: now,
      ),
    );
  }
}
