import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// SafeNexus HSE — Step 116
/// HSE Record Detail & Review.
///
/// Read-only review layer for existing Step 111–115 Daily Work data.
/// This file does not change existing storage schemas or records.
class SafeNexusRecordDetailReviewPage extends StatefulWidget {
  final String? recordId;

  const SafeNexusRecordDetailReviewPage({
    super.key,
    this.recordId,
  });

  @override
  State<SafeNexusRecordDetailReviewPage> createState() =>
      _SafeNexusRecordDetailReviewPageState();
}

class _SafeNexusRecordDetailReviewPageState
    extends State<SafeNexusRecordDetailReviewPage> {
  static const String _dailyLogsKey = 'workhub_daily_logs_v1';
  static const String _linkKey = 'workhub_daily_log_record_links_v1';
  static const String _evidenceKey = 'workhub_daily_evidence_v1';

  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);

  List<Map<String, dynamic>> _logs = <Map<String, dynamic>>[];
  Map<String, Map<String, dynamic>> _links =
      <String, Map<String, dynamic>>{};
  Map<String, List<Map<String, dynamic>>> _evidence =
      <String, List<Map<String, dynamic>>>{};

  bool _loading = true;
  String? _selectedId;

  @override
  void initState() {
    super.initState();
    _selectedId = widget.recordId;
    _loadData();
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

    final evidenceMap = <String, List<Map<String, dynamic>>>{};
    for (final item in evidence) {
      final id = (item['logId'] ?? item['dailyLogId'] ?? '').toString();
      if (id.isEmpty) continue;
      evidenceMap.putIfAbsent(id, () => <Map<String, dynamic>>[]).add(item);
    }

    if (!mounted) return;

    setState(() {
      _logs = logs;
      _links = linkMap;
      _evidence = evidenceMap;
      _loading = false;
    });

    if (_selectedId != null && _findLog(_selectedId!) == null) {
      setState(() {
        _selectedId = null;
      });
    }
  }

  List<Map<String, dynamic>> _decodeList(String? raw) {
    if (raw == null || raw.trim().isEmpty) {
      return <Map<String, dynamic>>[];
    }

    try {
      final decoded = jsonDecode(raw);
      if (decoded is! List) {
        return <Map<String, dynamic>>[];
      }

      return decoded
          .whereType<Map>()
          .map(
            (item) => Map<String, dynamic>.from(item),
          )
          .toList();
    } catch (_) {
      return <Map<String, dynamic>>[];
    }
  }

  Map<String, dynamic>? _findLog(String id) {
    for (final log in _logs) {
      final currentId = _recordId(log);
      if (currentId == id) {
        return log;
      }
    }
    return null;
  }

  String _recordId(Map<String, dynamic> log) {
    return (log['id'] ??
            log['logId'] ??
            log['dailyLogId'] ??
            log['recordId'] ??
            '')
        .toString();
  }

  String _company(Map<String, dynamic> log) {
    return (log['companyName'] ??
            log['company'] ??
            log['contractor'] ??
            '')
        .toString();
  }

  String _project(Map<String, dynamic> log) {
    return (log['projectName'] ?? log['project'] ?? '').toString();
  }

  String _site(Map<String, dynamic> log) {
    return (log['siteLocation'] ??
            log['location'] ??
            log['projectLocation'] ??
            '')
        .toString();
  }

  String _date(Map<String, dynamic> log) {
    return (log['date'] ?? log['workDate'] ?? log['logDate'] ?? '').toString();
  }

  String _status(Map<String, dynamic> log) {
    return (log['status'] ?? 'Draft').toString();
  }

  String _value(Map<String, dynamic> map, List<String> keys) {
    for (final key in keys) {
      final value = map[key];
      if (value != null && value.toString().trim().isNotEmpty) {
        return value.toString();
      }
    }
    return '';
  }

  String _linkValue(Map<String, dynamic> link, List<String> keys) {
    return _value(link, keys);
  }

  String _joinListValue(dynamic value) {
    if (value is List) {
      return value
          .map((item) => item.toString().trim())
          .where((item) => item.isNotEmpty)
          .join(', ');
    }
    return value?.toString() ?? '';
  }

  List<Map<String, dynamic>> _selectedEvidence() {
    if (_selectedId == null) return <Map<String, dynamic>>[];
    return _evidence[_selectedId!] ?? <Map<String, dynamic>>[];
  }

  Map<String, dynamic>? _selectedLog() {
    if (_selectedId == null) return null;
    return _findLog(_selectedId!);
  }

  void _selectRecord(String id) {
    setState(() {
      _selectedId = id;
    });
  }

  Future<void> _copyRecord() async {
    final log = _selectedLog();
    if (log == null) {
      _message('Please select a Daily Work Record first.');
      return;
    }

    final id = _recordId(log);
    final link = _links[id];
    final evidence = _selectedEvidence();

    final buffer = StringBuffer()
      ..writeln('SafeNexus HSE — HSE Record Review')
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
          <String>[
            'workDescription',
            'description',
            'work',
            'activity',
          ],
        ),
      )
      ..writeln()
      ..writeln('Start: ${_value(log, <String>['startTime', 'start'])}')
      ..writeln('Finish: ${_value(log, <String>['finishTime', 'finish'])}')
      ..writeln('Workforce: ${_joinListValue(log['workforce'] ?? log['workforceCount'])}')
      ..writeln('Equipment: ${_joinListValue(log['equipment'] ?? log['equipmentCount'])}')
      ..writeln('PTW: ${_value(log, <String>['ptwReference', 'ptwRef', 'permitReference'])}')
      ..writeln('RAMS: ${_value(log, <String>['ramsReference', 'ramsRef'])}')
      ..writeln('HSE Observations: ${_value(log, <String>['hseObservations', 'observations'])}')
      ..writeln('Hazards / Unsafe Conditions: ${_value(log, <String>['hazards', 'unsafeConditions'])}')
      ..writeln('Corrective Actions: ${_value(log, <String>['correctiveActions', 'actions'])}')
      ..writeln('Incident / Near Miss: ${_value(log, <String>['incident', 'incidentNearMiss'])}')
      ..writeln('Supervisor: ${_value(log, <String>['supervisor'])}')
      ..writeln('HSE Officer: ${_value(log, <String>['hseOfficer'])}');

    if (link != null) {
      buffer
        ..writeln()
        ..writeln('Record Linkage:')
        ..writeln(
          'PTW ID: ${_linkValue(link, <String>['ptwId', 'ptwRecordId'])}',
        )
        ..writeln(
          'RAMS ID: ${_linkValue(link, <String>['ramsId', 'ramsRecordId'])}',
        )
        ..writeln(
          'Risk ID: ${_linkValue(link, <String>['riskId', 'riskRecordId', 'hiraId'])}',
        )
        ..writeln(
          'Workforce IDs: ${_joinListValue(link['workforceIds'])}',
        )
        ..writeln(
          'Equipment IDs: ${_joinListValue(link['equipmentIds'])}',
        );
    }

    if (evidence.isNotEmpty) {
      buffer
        ..writeln()
        ..writeln('Evidence: ${evidence.length} item(s)');
      for (var i = 0; i < evidence.length; i++) {
        final item = evidence[i];
        buffer
          ..writeln('Evidence ${i + 1}:')
          ..writeln(
            _value(
              item,
              <String>[
                'title',
                'note',
                'description',
                'observation',
              ],
            ),
          )
          ..writeln(
            'Hazard: ${_value(item, <String>['hazard', 'hazards'])}',
          )
          ..writeln(
            'Action: ${_value(item, <String>['correctiveAction', 'action'])}',
          );
      }
    }

    await Clipboard.setData(ClipboardData(text: buffer.toString()));
    _message('Record review copied.');
  }

  void _showEvidenceDetail(Map<String, dynamic> item, int index) {
    final title = _value(
      item,
      <String>['title', 'note', 'description', 'observation'],
    );
    final imagePath = _value(
      item,
      <String>['imagePath', 'image', 'photoPath', 'filePath'],
    );
    final observation = _value(item, <String>['observation', 'note']);
    final hazard = _value(item, <String>['hazard', 'hazards']);
    final action = _value(
      item,
      <String>['correctiveAction', 'action', 'correctiveActions'],
    );

    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Evidence ${index + 1}'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                if (title.isNotEmpty) ...[
                  const Text(
                    'Title / Note',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 4),
                  Text(title),
                  const SizedBox(height: 12),
                ],
                if (observation.isNotEmpty) ...[
                  const Text(
                    'Observation',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 4),
                  Text(observation),
                  const SizedBox(height: 12),
                ],
                if (hazard.isNotEmpty) ...[
                  const Text(
                    'Hazard / Unsafe Condition',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 4),
                  Text(hazard),
                  const SizedBox(height: 12),
                ],
                if (action.isNotEmpty) ...[
                  const Text(
                    'Corrective Action',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 4),
                  Text(action),
                  const SizedBox(height: 12),
                ],
                if (imagePath.isNotEmpty) ...[
                  const Text(
                    'Photo / File',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 4),
                  SelectableText(imagePath),
                ],
                if (title.isEmpty &&
                    observation.isEmpty &&
                    hazard.isEmpty &&
                    action.isEmpty &&
                    imagePath.isEmpty)
                  const Text('No additional evidence details available.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _message(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final selected = _selectedLog();

    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: darkGreen,
        elevation: 0,
        title: const Text(
          'HSE Record Detail',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        actions: <Widget>[
          IconButton(
            tooltip: 'Copy review',
            onPressed: selected == null ? null : _copyRecord,
            icon: const Icon(Icons.copy_outlined),
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
      return _emptyState(
        'No Daily Work Records',
        'Create a Daily Work Record first. Existing records will appear here for review.',
        Icons.description_outlined,
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final wide = constraints.maxWidth >= 900;

        if (wide) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: 360,
                child: _buildRecordList(),
              ),
              const VerticalDivider(width: 1),
              Expanded(
                child: selected == null
                    ? _emptyState(
                        'Select a Record',
                        'Choose a Daily Work Record from the list.',
                        Icons.touch_app_outlined,
                      )
                    : _buildDetail(selected),
              ),
            ],
          );
        }

        return Column(
          children: <Widget>[
            _buildMobileSelector(),
            Expanded(
              child: selected == null
                  ? _emptyState(
                      'Select a Record',
                      'Choose a Daily Work Record above.',
                      Icons.touch_app_outlined,
                    )
                  : _buildDetail(selected),
            ),
          ],
        );
      },
    );
  }

  Widget _buildRecordList() {
    return Material(
      color: Colors.white,
      child: ListView.separated(
        padding: const EdgeInsets.all(12),
        itemCount: _logs.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          final log = _logs[index];
          final id = _recordId(log);
          final evidenceCount = _evidence[id]?.length ?? 0;
          final selected = id == _selectedId;

          return InkWell(
            borderRadius: BorderRadius.circular(14),
            onTap: id.isEmpty ? null : () => _selectRecord(id),
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
                      fontWeight: FontWeight.w800,
                      color: darkGreen,
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
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: <Widget>[
                      _miniChip(_date(log), Icons.calendar_today_outlined),
                      _miniChip(_status(log), Icons.flag_outlined),
                      _miniChip(
                        '$evidenceCount evidence',
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

  Widget _buildMobileSelector() {
    final selectedExists = _selectedId != null &&
        _findLog(_selectedId!) != null;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
      color: Colors.white,
      child: DropdownButtonFormField<String>(
        initialValue: selectedExists ? _selectedId : null,
        decoration: InputDecoration(
          labelText: 'Select Daily Work Record',
          prefixIcon: const Icon(Icons.description_outlined),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        items: _logs.map((log) {
          final id = _recordId(log);
          final company = _company(log);
          final date = _date(log);
          return DropdownMenuItem<String>(
            value: id,
            child: Text(
              [
                if (company.isNotEmpty) company,
                if (date.isNotEmpty) date,
                if (id.isNotEmpty) id,
              ].join(' • '),
              overflow: TextOverflow.ellipsis,
            ),
          );
        }).toList(),
        onChanged: (value) {
          if (value != null) _selectRecord(value);
        },
      ),
    );
  }

  Widget _buildDetail(Map<String, dynamic> log) {
    final id = _recordId(log);
    final link = _links[id];
    final evidence = _selectedEvidence();

    return RefreshIndicator(
      onRefresh: _loadData,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          _buildHeader(log),
          const SizedBox(height: 12),
          _section(
            title: 'Work Record',
            icon: Icons.work_outline,
            children: <Widget>[
              _detailRow(
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
              _detailRow(
                'Start Time',
                _value(log, <String>['startTime', 'start']),
              ),
              _detailRow(
                'Finish Time',
                _value(log, <String>['finishTime', 'finish']),
              ),
              _detailRow(
                'Workforce',
                _joinListValue(
                  log['workforce'] ?? log['workforceCount'],
                ),
              ),
              _detailRow(
                'Equipment / Machinery',
                _joinListValue(
                  log['equipment'] ?? log['equipmentCount'],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _section(
            title: 'HSE Review',
            icon: Icons.health_and_safety_outlined,
            children: <Widget>[
              _detailRow(
                'HSE Observations',
                _value(log, <String>['hseObservations', 'observations']),
              ),
              _detailRow(
                'Hazards / Unsafe Conditions',
                _value(log, <String>['hazards', 'unsafeConditions']),
              ),
              _detailRow(
                'Corrective Actions',
                _value(log, <String>['correctiveActions', 'actions']),
              ),
              _detailRow(
                'Incident / Near Miss',
                _value(log, <String>['incident', 'incidentNearMiss']),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _section(
            title: 'Permit & RAMS',
            icon: Icons.assignment_outlined,
            children: <Widget>[
              _detailRow(
                'PTW Reference',
                _value(
                  log,
                  <String>[
                    'ptwReference',
                    'ptwRef',
                    'permitReference',
                  ],
                ),
              ),
              _detailRow(
                'PTW Status',
                _value(log, <String>['ptwStatus', 'permitStatus']),
              ),
              _detailRow(
                'RAMS Reference',
                _value(log, <String>['ramsReference', 'ramsRef']),
              ),
              _detailRow(
                'RAMS Status',
                _value(log, <String>['ramsStatus']),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildLinkageSection(link),
          const SizedBox(height: 12),
          _buildEvidenceSection(evidence),
          const SizedBox(height: 12),
          _section(
            title: 'Responsibility',
            icon: Icons.badge_outlined,
            children: <Widget>[
              _detailRow(
                'Supervisor',
                _value(log, <String>['supervisor']),
              ),
              _detailRow(
                'HSE Officer',
                _value(log, <String>['hseOfficer']),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _reviewFooter(id),
        ],
      ),
    );
  }

  Widget _buildHeader(Map<String, dynamic> log) {
    final status = _status(log);
    final statusLower = status.toLowerCase();

    IconData statusIcon = Icons.edit_note_outlined;
    if (statusLower.contains('complete')) {
      statusIcon = Icons.check_circle_outline;
    } else if (statusLower.contains('progress')) {
      statusIcon = Icons.timelapse_outlined;
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            primaryGreen,
            darkGreen,
          ],
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
          const SizedBox(height: 8),
          Text(
            _company(log).isEmpty ? 'Company not specified' : _company(log),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          if (_project(log).isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 3),
              child: Text(
                _project(log),
                style: const TextStyle(color: Colors.white70),
              ),
            ),
          if (_site(log).isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 3),
              child: Text(
                _site(log),
                style: const TextStyle(color: Colors.white70),
              ),
            ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              _headerChip(Icons.calendar_today_outlined, _date(log)),
              _headerChip(statusIcon, status),
              _headerChip(
                Icons.tag_outlined,
                _recordId(log).isEmpty ? 'No ID' : _recordId(log),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLinkageSection(Map<String, dynamic>? link) {
    if (link == null) {
      return _section(
        title: 'Record Linkage',
        icon: Icons.link_off_outlined,
        children: <Widget>[
          const Text(
            'No linked PTW, RAMS, Risk, Workforce or Equipment record is stored for this Daily Work Record.',
            style: TextStyle(color: Colors.black54),
          ),
        ],
      );
    }

    final workforceIds = _joinListValue(link['workforceIds']);
    final equipmentIds = _joinListValue(link['equipmentIds']);

    return _section(
      title: 'Record Linkage',
      icon: Icons.link_outlined,
      children: <Widget>[
        _detailRow(
          'PTW ID',
          _linkValue(link, <String>['ptwId', 'ptwRecordId']),
        ),
        _detailRow(
          'RAMS ID',
          _linkValue(link, <String>['ramsId', 'ramsRecordId']),
        ),
        _detailRow(
          'Risk / HIRA ID',
          _linkValue(
            link,
            <String>['riskId', 'riskRecordId', 'hiraId'],
          ),
        ),
        _detailRow('Workforce IDs', workforceIds),
        _detailRow('Equipment IDs', equipmentIds),
      ],
    );
  }

  Widget _buildEvidenceSection(List<Map<String, dynamic>> evidence) {
    return _section(
      title: 'Evidence Review',
      icon: Icons.photo_library_outlined,
      children: <Widget>[
        if (evidence.isEmpty)
          const Text(
            'No Daily Work Evidence is attached to this record.',
            style: TextStyle(color: Colors.black54),
          )
        else
          ...evidence.asMap().entries.map(
            (entry) {
              final index = entry.key;
              final item = entry.value;
              final title = _value(
                item,
                <String>[
                  'title',
                  'note',
                  'description',
                  'observation',
                ],
              );
              final imagePath = _value(
                item,
                <String>[
                  'imagePath',
                  'image',
                  'photoPath',
                  'filePath',
                ],
              );

              return Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  leading: Icon(
                    imagePath.isEmpty
                        ? Icons.note_alt_outlined
                        : Icons.photo_outlined,
                    color: primaryGreen,
                  ),
                  title: Text(
                    title.isEmpty
                        ? 'Evidence ${index + 1}'
                        : title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    imagePath.isEmpty
                        ? 'Review evidence details'
                        : 'Photo / file attached',
                  ),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => _showEvidenceDetail(item, index),
                ),
              );
            },
          ),
      ],
    );
  }

  Widget _reviewFooter(String id) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: <Widget>[
          const Icon(
            Icons.verified_user_outlined,
            color: darkGreen,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              id.isEmpty
                  ? 'Review-only view. Existing records are not modified.'
                  : 'Review-only view for record $id. Existing records are not modified.',
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

  Widget _section({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
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

  Widget _detailRow(String label, String value) {
    if (value.trim().isEmpty) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 145,
              child: Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
            ),
            const Expanded(
              child: Text(
                '—',
                style: TextStyle(color: Colors.black38),
              ),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 145,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
          ),
          Expanded(
            child: SelectableText(
              value,
              style: const TextStyle(color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  Widget _miniChip(String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: pageBackground,
        borderRadius: BorderRadius.circular(20),
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

  Widget _headerChip(IconData icon, String label) {
    if (label.trim().isEmpty) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, size: 14, color: Colors.white),
          const SizedBox(width: 5),
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

  Widget _emptyState(
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
            Icon(
              icon,
              size: 58,
              color: primaryGreen,
            ),
            const SizedBox(height: 14),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: darkGreen,
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 8),
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
