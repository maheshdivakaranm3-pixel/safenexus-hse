import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// SafeNexus HSE - Step 44
/// HSE Incident, Event & Investigation Management Center
///
/// Workflow:
/// Report → Triage → Contain → Investigate → Identify Cause
/// → Correct → Verify → Close → Learn → Analyze
///
/// Integration:
/// Step 9 → 31 → 32 → 34 → 35 → 36 → 37 → 38 → 39
/// → 40 → 41 → 42 → 43 → 44
///
/// English + Malayalam ready
/// UAE-wide scalable
/// Local persistence via SharedPreferences
/// No new dependency

class SafeNexusStep44IncidentInvestigationPage extends StatefulWidget {
  const SafeNexusStep44IncidentInvestigationPage({
    super.key,
    this.sourceOpener,
  });

  final void Function(String referenceType, String referenceId)? sourceOpener;

  @override
  State<SafeNexusStep44IncidentInvestigationPage> createState() =>
      _SafeNexusStep44IncidentInvestigationPageState();
}

class _SafeNexusStep44IncidentInvestigationPageState
    extends State<SafeNexusStep44IncidentInvestigationPage> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);

  static const String storageKey =
      'safenexus_hse_step44_incident_investigation';

  final TextEditingController _searchController = TextEditingController();

  final List<String> _incidentTypes = const [
    'Incident',
    'Near Miss',
    'First Aid Case',
    'Medical Treatment Case',
    'Lost Time Injury',
    'Restricted Work Case',
    'Property Damage',
    'Environmental Event',
    'Fire / Emergency Event',
    'Vehicle / Traffic Event',
    'Security Event',
    'Unsafe Act / Condition',
    'Other',
  ];

  final List<String> _statuses = const [
    'Reported',
    'Under Triage',
    'Contained',
    'Under Investigation',
    'Cause Identified',
    'Action Required',
    'Verification Required',
    'Closed',
    'Lessons Learned',
  ];

  final List<String> _severityOptions = const [
    'Low',
    'Medium',
    'High',
    'Critical',
  ];

  final List<String> _classificationOptions = const [
    'Near Miss',
    'First Aid',
    'Medical Treatment',
    'Lost Time Injury',
    'Restricted Work',
    'Fatality',
    'Property Damage',
    'Environmental',
    'Fire / Emergency',
    'Vehicle / Traffic',
    'Security',
    'Other',
  ];

  final List<String> _investigationOptions = const [
    'Not Started',
    'Planned',
    'In Progress',
    'Cause Identified',
    'Completed',
    'Approved',
  ];

  final List<String> _causeOptions = const [
    'Not Determined',
    'Unsafe Act',
    'Unsafe Condition',
    'Human Factors',
    'Equipment Failure',
    'Procedure / Process',
    'Training / Competency',
    'Supervision',
    'Management System',
    'Environmental Factor',
    'Multiple Causes',
  ];

  final List<String> _actionOptions = const [
    'Not Required',
    'Pending',
    'In Progress',
    'Verification Required',
    'Completed',
  ];

  final List<String> _approvalOptions = const [
    'Not Required',
    'Pending Review',
    'Approved',
    'Returned for Action',
  ];

  List<Map<String, dynamic>> _records = <Map<String, dynamic>>[];
  List<Map<String, dynamic>> _history = <Map<String, dynamic>>[];

  String _statusFilter = 'All';
  String _typeFilter = 'All';
  String _severityFilter = 'All';
  String _classificationFilter = 'All';

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
    final SharedPreferences preferences =
        await SharedPreferences.getInstance();

    final List<Map<String, dynamic>> records =
        _decode(preferences.getString(storageKey));
    final List<Map<String, dynamic>> history =
        _decode(preferences.getString('${storageKey}_history'));

    if (!mounted) {
      return;
    }

    setState(() {
      _records = records;
      _history = history;
      _loading = false;
    });
  }

  List<Map<String, dynamic>> _decode(String? raw) {
    if (raw == null || raw.isEmpty) {
      return <Map<String, dynamic>>[];
    }

    try {
      final dynamic decoded = jsonDecode(raw);
      if (decoded is List) {
        return decoded
            .whereType<Map>()
            .map(
              (Map item) => Map<String, dynamic>.from(item),
            )
            .toList();
      }
    } catch (_) {
      // Ignore malformed local data.
    }

    return <Map<String, dynamic>>[];
  }

  Future<void> _save() async {
    final SharedPreferences preferences =
        await SharedPreferences.getInstance();

    await preferences.setString(storageKey, jsonEncode(_records));
    await preferences.setString(
      '${storageKey}_history',
      jsonEncode(_history),
    );
  }

  void _refreshView() {
    if (mounted) {
      setState(() {});
    }
  }

  String _value(Map<String, dynamic> record, String key) {
    final dynamic value = record[key];
    if (value == null) {
      return '';
    }
    return '$value';
  }

  DateTime? _parseDate(dynamic value) {
    if (value == null) {
      return null;
    }
    return DateTime.tryParse('$value');
  }

  String _now() => DateTime.now().toIso8601String();

  String _newId() => 'INC44-${DateTime.now().millisecondsSinceEpoch}';

  int _count(bool Function(Map<String, dynamic>) test) {
    return _records.where(test).length;
  }

  int get _total => _records.length;

  int get _open => _count(
        (Map<String, dynamic> record) => !_value(record, 'status').contains(
          'Closed',
        ),
      );

  int get _critical =>
      _count((record) => _value(record, 'severity') == 'Critical');

  int get _highOrCritical => _count(
        (record) => <String>['High', 'Critical'].contains(
          _value(record, 'severity'),
        ),
      );

  int get _nearMiss =>
      _count((record) => _value(record, 'incidentType') == 'Near Miss');

  int get _investigationOpen => _count(
        (record) => <String>[
          'Planned',
          'In Progress',
        ].contains(_value(record, 'investigationStatus')),
      );

  int get _actionsPending => _count(
        (record) => <String>[
          'Pending',
          'In Progress',
          'Verification Required',
        ].contains(_value(record, 'actionStatus')),
      );

  int get _lessonsLearned =>
      _count((record) => _value(record, 'status') == 'Lessons Learned');

  int get _overdue => _count((record) => _reviewStatus(record) == 'Overdue');

  String _reviewStatus(Map<String, dynamic> record) {
    final DateTime? date = _parseDate(record['targetClosureDate']);

    if (date == null) {
      return 'Not Scheduled';
    }

    final DateTime now = DateTime.now();
    final DateTime today = DateTime(now.year, now.month, now.day);
    final DateTime target = DateTime(date.year, date.month, date.day);
    final int days = target.difference(today).inDays;

    if (days < 0 && _value(record, 'status') != 'Closed') {
      return 'Overdue';
    }
    if (days <= 30 && _value(record, 'status') != 'Closed') {
      return 'Due Soon';
    }
    return 'Scheduled';
  }

  List<Map<String, dynamic>> get _filteredRecords {
    final String query = _searchController.text.trim().toLowerCase();

    return _records.where((Map<String, dynamic> record) {
      final String searchable = <String>[
        _value(record, 'incidentId'),
        _value(record, 'title'),
        _value(record, 'incidentType'),
        _value(record, 'site'),
        _value(record, 'reportedBy'),
        _value(record, 'classification'),
        _value(record, 'causeCategory'),
        _value(record, 'referenceNumber'),
      ].join(' ').toLowerCase();

      final bool matchesSearch =
          query.isEmpty || searchable.contains(query);
      final bool matchesStatus =
          _statusFilter == 'All' ||
          _value(record, 'status') == _statusFilter;
      final bool matchesType =
          _typeFilter == 'All' ||
          _value(record, 'incidentType') == _typeFilter;
      final bool matchesSeverity =
          _severityFilter == 'All' ||
          _value(record, 'severity') == _severityFilter;
      final bool matchesClassification =
          _classificationFilter == 'All' ||
          _value(record, 'classification') == _classificationFilter;

      return matchesSearch &&
          matchesStatus &&
          matchesType &&
          matchesSeverity &&
          matchesClassification;
    }).toList();
  }

  Future<void> _addRecord() async {
    final Map<String, dynamic>? values = await _recordDialog();

    if (values == null) {
      return;
    }

    final Map<String, dynamic> record = <String, dynamic>{
      ...values,
      'incidentId': _newId(),
      'createdAt': _now(),
      'updatedAt': _now(),
    };

    setState(() {
      _records.insert(0, record);
      _history.insert(0, <String, dynamic>{
        'action': 'Created',
        'incidentId': record['incidentId'],
        'title': record['title'],
        'timestamp': _now(),
        'details': 'Incident / event record created.',
      });
    });

    await _save();
  }

  Future<void> _editRecord(Map<String, dynamic> record) async {
    final Map<String, dynamic>? values =
        await _recordDialog(existing: record);

    if (values == null) {
      return;
    }

    final int index = _records.indexWhere(
      (Map<String, dynamic> item) =>
          _value(item, 'incidentId') ==
          _value(record, 'incidentId'),
    );

    if (index < 0) {
      return;
    }

    final Map<String, dynamic> updated = <String, dynamic>{
      ...record,
      ...values,
      'updatedAt': _now(),
    };

    setState(() {
      _records[index] = updated;
      _history.insert(0, <String, dynamic>{
        'action': 'Updated',
        'incidentId': updated['incidentId'],
        'title': updated['title'],
        'timestamp': _now(),
        'details': 'Incident / event record updated.',
      });
    });

    await _save();
  }

  Future<void> _deleteRecord(Map<String, dynamic> record) async {
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Delete Incident / Event'),
          content: Text(
            'Delete ${_value(record, 'title')} '
            '(${_value(record, 'incidentId')})?',
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirmed != true) {
      return;
    }

    setState(() {
      _records.removeWhere(
        (Map<String, dynamic> item) =>
            _value(item, 'incidentId') ==
            _value(record, 'incidentId'),
      );
      _history.insert(0, <String, dynamic>{
        'action': 'Deleted',
        'incidentId': record['incidentId'],
        'title': record['title'],
        'timestamp': _now(),
        'details': 'Incident / event record deleted.',
      });
    });

    await _save();
  }

  Future<Map<String, dynamic>?> _recordDialog({
    Map<String, dynamic>? existing,
  }) async {
    final Map<String, TextEditingController> controllers =
        <String, TextEditingController>{
      'title': TextEditingController(
        text: _value(existing ?? <String, dynamic>{}, 'title'),
      ),
      'referenceNumber': TextEditingController(
        text: _value(existing ?? <String, dynamic>{}, 'referenceNumber'),
      ),
      'date': TextEditingController(
        text: _value(existing ?? <String, dynamic>{}, 'date'),
      ),
      'site': TextEditingController(
        text: _value(existing ?? <String, dynamic>{}, 'site'),
      ),
      'reportedBy': TextEditingController(
        text: _value(existing ?? <String, dynamic>{}, 'reportedBy'),
      ),
      'affectedPerson': TextEditingController(
        text: _value(existing ?? <String, dynamic>{}, 'affectedPerson'),
      ),
      'description': TextEditingController(
        text: _value(existing ?? <String, dynamic>{}, 'description'),
      ),
      'immediateAction': TextEditingController(
        text: _value(existing ?? <String, dynamic>{}, 'immediateAction'),
      ),
      'rootCause': TextEditingController(
        text: _value(existing ?? <String, dynamic>{}, 'rootCause'),
      ),
      'contributingFactors': TextEditingController(
        text: _value(existing ?? <String, dynamic>{}, 'contributingFactors'),
      ),
      'evidence': TextEditingController(
        text: _value(existing ?? <String, dynamic>{}, 'evidence'),
      ),
      'witnesses': TextEditingController(
        text: _value(existing ?? <String, dynamic>{}, 'witnesses'),
      ),
      'correctiveAction': TextEditingController(
        text: _value(existing ?? <String, dynamic>{}, 'correctiveAction'),
      ),
      'targetClosureDate': TextEditingController(
        text: _value(existing ?? <String, dynamic>{}, 'targetClosureDate'),
      ),
      'lessonsLearned': TextEditingController(
        text: _value(existing ?? <String, dynamic>{}, 'lessonsLearned'),
      ),
      'safetyAlert': TextEditingController(
        text: _value(existing ?? <String, dynamic>{}, 'safetyAlert'),
      ),
      'notes': TextEditingController(
        text: _value(existing ?? <String, dynamic>{}, 'notes'),
      ),
    };

    String incidentType =
        _value(existing ?? <String, dynamic>{}, 'incidentType');
    String status = _value(existing ?? <String, dynamic>{}, 'status');
    String severity = _value(existing ?? <String, dynamic>{}, 'severity');
    String classification =
        _value(existing ?? <String, dynamic>{}, 'classification');
    String investigation =
        _value(existing ?? <String, dynamic>{}, 'investigationStatus');
    String cause = _value(existing ?? <String, dynamic>{}, 'causeCategory');
    String action = _value(existing ?? <String, dynamic>{}, 'actionStatus');
    String approval =
        _value(existing ?? <String, dynamic>{}, 'approvalStatus');

    if (!_incidentTypes.contains(incidentType)) {
      incidentType = _incidentTypes.first;
    }
    if (!_statuses.contains(status)) {
      status = _statuses.first;
    }
    if (!_severityOptions.contains(severity)) {
      severity = _severityOptions.first;
    }
    if (!_classificationOptions.contains(classification)) {
      classification = _classificationOptions.first;
    }
    if (!_investigationOptions.contains(investigation)) {
      investigation = _investigationOptions.first;
    }
    if (!_causeOptions.contains(cause)) {
      cause = _causeOptions.first;
    }
    if (!_actionOptions.contains(action)) {
      action = _actionOptions.first;
    }
    if (!_approvalOptions.contains(approval)) {
      approval = _approvalOptions.first;
    }

    final Map<String, dynamic>? result =
        await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          builder: (
            BuildContext context,
            void Function(void Function()) setDialogState,
          ) {
            return AlertDialog(
              title: Text(
                existing == null
                    ? 'Create Incident / Event'
                    : 'Edit Incident / Event',
              ),
              content: SizedBox(
                width: 700,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      _textField(
                        controllers['title']!,
                        'Incident / Event Title',
                        Icons.report_problem_outlined,
                        required: true,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: _dropdown(
                              'Incident Type',
                              incidentType,
                              _incidentTypes,
                              (String? value) {
                                if (value != null) {
                                  setDialogState(
                                    () => incidentType = value,
                                  );
                                }
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _dropdown(
                              'Severity',
                              severity,
                              _severityOptions,
                              (String? value) {
                                if (value != null) {
                                  setDialogState(
                                    () => severity = value,
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: _dropdown(
                              'Status',
                              status,
                              _statuses,
                              (String? value) {
                                if (value != null) {
                                  setDialogState(() => status = value);
                                }
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _dropdown(
                              'Classification',
                              classification,
                              _classificationOptions,
                              (String? value) {
                                if (value != null) {
                                  setDialogState(
                                    () => classification = value,
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: _dropdown(
                              'Investigation',
                              investigation,
                              _investigationOptions,
                              (String? value) {
                                if (value != null) {
                                  setDialogState(
                                    () => investigation = value,
                                  );
                                }
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _dropdown(
                              'Root Cause',
                              cause,
                              _causeOptions,
                              (String? value) {
                                if (value != null) {
                                  setDialogState(() => cause = value);
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: _dropdown(
                              'Action Status',
                              action,
                              _actionOptions,
                              (String? value) {
                                if (value != null) {
                                  setDialogState(() => action = value);
                                }
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _dropdown(
                              'Approval',
                              approval,
                              _approvalOptions,
                              (String? value) {
                                if (value != null) {
                                  setDialogState(
                                    () => approval = value,
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      _textField(
                        controllers['referenceNumber']!,
                        'External / Source Reference',
                        Icons.tag_outlined,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: _textField(
                              controllers['date']!,
                              'Incident Date (YYYY-MM-DD)',
                              Icons.event_outlined,
                              required: true,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _textField(
                              controllers['site']!,
                              'Site / Location',
                              Icons.location_on_outlined,
                              required: true,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: _textField(
                              controllers['reportedBy']!,
                              'Reported By',
                              Icons.person_outline,
                              required: true,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _textField(
                              controllers['affectedPerson']!,
                              'Affected Person / Asset',
                              Icons.accessibility_new_outlined,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      _textField(
                        controllers['description']!,
                        'Incident / Event Description',
                        Icons.description_outlined,
                        maxLines: 4,
                      ),
                      const SizedBox(height: 10),
                      _textField(
                        controllers['immediateAction']!,
                        'Immediate / Interim Controls',
                        Icons.shield_outlined,
                        maxLines: 3,
                      ),
                      const SizedBox(height: 10),
                      _textField(
                        controllers['rootCause']!,
                        'Root Cause / Investigation Findings',
                        Icons.account_tree_outlined,
                        maxLines: 4,
                      ),
                      const SizedBox(height: 10),
                      _textField(
                        controllers['contributingFactors']!,
                        'Contributing Factors',
                        Icons.merge_type_outlined,
                        maxLines: 3,
                      ),
                      const SizedBox(height: 10),
                      _textField(
                        controllers['evidence']!,
                        'Evidence / Documents / Photos Reference',
                        Icons.folder_outlined,
                        maxLines: 3,
                      ),
                      const SizedBox(height: 10),
                      _textField(
                        controllers['witnesses']!,
                        'Witnesses / Interviews',
                        Icons.groups_outlined,
                        maxLines: 3,
                      ),
                      const SizedBox(height: 10),
                      _textField(
                        controllers['correctiveAction']!,
                        'Corrective / Preventive Action',
                        Icons.assignment_turned_in_outlined,
                        maxLines: 3,
                      ),
                      const SizedBox(height: 10),
                      _textField(
                        controllers['targetClosureDate']!,
                        'Target Closure Date (YYYY-MM-DD)',
                        Icons.event_available_outlined,
                      ),
                      const SizedBox(height: 10),
                      _textField(
                        controllers['lessonsLearned']!,
                        'Lessons Learned',
                        Icons.lightbulb_outline,
                        maxLines: 3,
                      ),
                      const SizedBox(height: 10),
                      _textField(
                        controllers['safetyAlert']!,
                        'Safety Alert / Communication Reference',
                        Icons.campaign_outlined,
                        maxLines: 3,
                      ),
                      const SizedBox(height: 10),
                      _textField(
                        controllers['notes']!,
                        'HSE Investigation Notes',
                        Icons.notes_outlined,
                        maxLines: 3,
                      ),
                    ],
                  ),
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: const Text('Cancel'),
                ),
                FilledButton.icon(
                  onPressed: () {
                    final String title =
                        controllers['title']!.text.trim();
                    final String date =
                        controllers['date']!.text.trim();
                    final String site =
                        controllers['site']!.text.trim();
                    final String reportedBy =
                        controllers['reportedBy']!.text.trim();

                    if (title.isEmpty ||
                        date.isEmpty ||
                        site.isEmpty ||
                        reportedBy.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Title, Incident Date, Site and Reported By '
                            'are required.',
                          ),
                        ),
                      );
                      return;
                    }

                    Navigator.pop(
                      dialogContext,
                      <String, dynamic>{
                        'title': title,
                        'incidentType': incidentType,
                        'status': status,
                        'severity': severity,
                        'classification': classification,
                        'investigationStatus': investigation,
                        'causeCategory': cause,
                        'actionStatus': action,
                        'approvalStatus': approval,
                        'referenceNumber':
                            controllers['referenceNumber']!.text.trim(),
                        'date': date,
                        'site': site,
                        'reportedBy': reportedBy,
                        'affectedPerson':
                            controllers['affectedPerson']!.text.trim(),
                        'description':
                            controllers['description']!.text.trim(),
                        'immediateAction':
                            controllers['immediateAction']!.text.trim(),
                        'rootCause':
                            controllers['rootCause']!.text.trim(),
                        'contributingFactors':
                            controllers['contributingFactors']!.text.trim(),
                        'evidence':
                            controllers['evidence']!.text.trim(),
                        'witnesses':
                            controllers['witnesses']!.text.trim(),
                        'correctiveAction':
                            controllers['correctiveAction']!.text.trim(),
                        'targetClosureDate':
                            controllers['targetClosureDate']!.text.trim(),
                        'lessonsLearned':
                            controllers['lessonsLearned']!.text.trim(),
                        'safetyAlert':
                            controllers['safetyAlert']!.text.trim(),
                        'notes': controllers['notes']!.text.trim(),
                      },
                    );
                  },
                  icon: const Icon(Icons.save_outlined),
                  label: Text(existing == null ? 'Create' : 'Save'),
                ),
              ],
            );
          },
        );
      },
    );

    for (final TextEditingController controller in controllers.values) {
      controller.dispose();
    }

    return result;
  }

  Widget _textField(
    TextEditingController controller,
    String label,
    IconData icon, {
    bool required = false,
    int maxLines = 1,
  }) {
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

  Widget _dropdown(
    String label,
    String value,
    List<String> items,
    ValueChanged<String?> onChanged,
  ) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      isExpanded: true,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      items: items
          .map(
            (String item) => DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          )
          .toList(),
      onChanged: onChanged,
    );
  }

  Widget _metricCard(
    String title,
    String value,
    IconData icon,
  ) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: <Widget>[
            CircleAvatar(
              backgroundColor: primaryGreen.withValues(alpha: 0.10),
              child: Icon(icon, color: darkGreen),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w800,
                      color: darkGreen,
                    ),
                  ),
                  Text(
                    title,
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _dashboard() {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              '44L — Incident Intelligence Dashboard',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w800,
                color: darkGreen,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Report → Triage → Contain → Investigate → Correct → Verify → Learn',
            ),
            const SizedBox(height: 12),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final int columns = constraints.maxWidth > 850
                    ? 4
                    : constraints.maxWidth > 560
                        ? 3
                        : 2;
                final double width =
                    (constraints.maxWidth - ((columns - 1) * 10)) /
                        columns;

                final List<List<dynamic>> metrics = <List<dynamic>>[
                  <dynamic>[
                    'Total Events',
                    '$_total',
                    Icons.report_problem_outlined,
                  ],
                  <dynamic>[
                    'Open Events',
                    '$_open',
                    Icons.pending_actions_outlined,
                  ],
                  <dynamic>[
                    'Critical',
                    '$_critical',
                    Icons.priority_high_outlined,
                  ],
                  <dynamic>[
                    'High / Critical',
                    '$_highOrCritical',
                    Icons.warning_amber_outlined,
                  ],
                  <dynamic>[
                    'Near Miss',
                    '$_nearMiss',
                    Icons.visibility_outlined,
                  ],
                  <dynamic>[
                    'Investigation Open',
                    '$_investigationOpen',
                    Icons.search_outlined,
                  ],
                  <dynamic>[
                    'Actions Pending',
                    '$_actionsPending',
                    Icons.assignment_late_outlined,
                  ],
                  <dynamic>[
                    'Lessons Learned',
                    '$_lessonsLearned',
                    Icons.lightbulb_outline,
                  ],
                  <dynamic>[
                    'Overdue Closure',
                    '$_overdue',
                    Icons.event_busy_outlined,
                  ],
                ];

                return Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: metrics
                      .map(
                        (List<dynamic> metric) => SizedBox(
                          width: width,
                          child: _metricCard(
                            metric[0] as String,
                            metric[1] as String,
                            metric[2] as IconData,
                          ),
                        ),
                      )
                      .toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _section(
    String title,
    List<Widget> children,
  ) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                color: darkGreen,
              ),
            ),
            const SizedBox(height: 8),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 165,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
          Expanded(
            child: Text(value.isEmpty ? '-' : value),
          ),
        ],
      ),
    );
  }

  String _formatDate(dynamic value) {
    final DateTime? date = _parseDate(value);

    if (date == null) {
      final String text = '$value';
      if (value == null || text == 'null' || text.isEmpty) {
        return '-';
      }
      return text;
    }

    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }

  Widget _statusChip(String text) {
    return Chip(
      label: Text(text.isEmpty ? '-' : text),
      visualDensity: VisualDensity.compact,
    );
  }

  Future<void> _showDetails(Map<String, dynamic> record) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (BuildContext sheetContext) {
        return SafeArea(
          child: DraggableScrollableSheet(
            expand: false,
            initialChildSize: 0.86,
            minChildSize: 0.55,
            maxChildSize: 0.96,
            builder: (
              BuildContext context,
              ScrollController controller,
            ) {
              return ListView(
                controller: controller,
                padding: const EdgeInsets.fromLTRB(18, 4, 18, 24),
                children: <Widget>[
                  Text(
                    _value(record, 'title'),
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: darkGreen,
                        ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    _value(record, 'incidentId'),
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 14),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: <Widget>[
                      _statusChip(_value(record, 'status')),
                      _statusChip(_value(record, 'incidentType')),
                      _statusChip(_value(record, 'severity')),
                      _statusChip(_value(record, 'classification')),
                      _statusChip(_reviewStatus(record)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _section(
                    '44A–44L Incident & Investigation Control',
                    <Widget>[
                      _detailRow(
                        'Incident Type',
                        _value(record, 'incidentType'),
                      ),
                      _detailRow(
                        'Classification',
                        _value(record, 'classification'),
                      ),
                      _detailRow(
                        'Severity',
                        _value(record, 'severity'),
                      ),
                      _detailRow(
                        'Status',
                        _value(record, 'status'),
                      ),
                      _detailRow(
                        'Incident Date',
                        _formatDate(record['date']),
                      ),
                      _detailRow(
                        'Site / Location',
                        _value(record, 'site'),
                      ),
                      _detailRow(
                        'Reported By',
                        _value(record, 'reportedBy'),
                      ),
                      _detailRow(
                        'Affected Person / Asset',
                        _value(record, 'affectedPerson'),
                      ),
                      _detailRow(
                        'Investigation',
                        _value(record, 'investigationStatus'),
                      ),
                      _detailRow(
                        'Root Cause',
                        _value(record, 'causeCategory'),
                      ),
                      _detailRow(
                        'Action Status',
                        _value(record, 'actionStatus'),
                      ),
                      _detailRow(
                        'Approval',
                        _value(record, 'approvalStatus'),
                      ),
                      _detailRow(
                        'Target Closure',
                        _formatDate(record['targetClosureDate']),
                      ),
                      _detailRow(
                        'Closure Status',
                        _reviewStatus(record),
                      ),
                      _detailRow(
                        'Source Reference',
                        _value(record, 'referenceNumber'),
                      ),
                    ],
                  ),
                  if (_value(record, 'description').isNotEmpty) ...<Widget>[
                    const SizedBox(height: 12),
                    _section(
                      '44B — Incident / Event Description',
                      <Widget>[Text(_value(record, 'description'))],
                    ),
                  ],
                  if (_value(record, 'immediateAction').isNotEmpty) ...<Widget>[
                    const SizedBox(height: 12),
                    _section(
                      '44F — Immediate / Interim Controls',
                      <Widget>[
                        Text(_value(record, 'immediateAction')),
                      ],
                    ),
                  ],
                  if (_value(record, 'rootCause').isNotEmpty) ...<Widget>[
                    const SizedBox(height: 12),
                    _section(
                      '44E — Investigation & Root Cause',
                      <Widget>[Text(_value(record, 'rootCause'))],
                    ),
                  ],
                  if (_value(record, 'contributingFactors').isNotEmpty) ...<Widget>[
                    const SizedBox(height: 12),
                    _section(
                      'Contributing Factors',
                      <Widget>[
                        Text(_value(record, 'contributingFactors')),
                      ],
                    ),
                  ],
                  if (_value(record, 'evidence').isNotEmpty) ...<Widget>[
                    const SizedBox(height: 12),
                    _section(
                      '44H — Evidence / Documentation',
                      <Widget>[Text(_value(record, 'evidence'))],
                    ),
                  ],
                  if (_value(record, 'witnesses').isNotEmpty) ...<Widget>[
                    const SizedBox(height: 12),
                    _section(
                      '44H — Witnesses / Interviews',
                      <Widget>[Text(_value(record, 'witnesses'))],
                    ),
                  ],
                  if (_value(record, 'correctiveAction').isNotEmpty) ...<Widget>[
                    const SizedBox(height: 12),
                    _section(
                      '44G — Corrective / Preventive Action',
                      <Widget>[
                        Text(_value(record, 'correctiveAction')),
                      ],
                    ),
                  ],
                  if (_value(record, 'lessonsLearned').isNotEmpty) ...<Widget>[
                    const SizedBox(height: 12),
                    _section(
                      '44J — Lessons Learned',
                      <Widget>[
                        Text(_value(record, 'lessonsLearned')),
                      ],
                    ),
                  ],
                  if (_value(record, 'safetyAlert').isNotEmpty) ...<Widget>[
                    const SizedBox(height: 12),
                    _section(
                      '44J — Safety Alert / Communication',
                      <Widget>[
                        Text(_value(record, 'safetyAlert')),
                      ],
                    ),
                  ],
                  if (_value(record, 'notes').isNotEmpty) ...<Widget>[
                    const SizedBox(height: 12),
                    _section(
                      'HSE Investigation Notes',
                      <Widget>[Text(_value(record, 'notes'))],
                    ),
                  ],
                  if (widget.sourceOpener != null) ...<Widget>[
                    const SizedBox(height: 16),
                    OutlinedButton.icon(
                      onPressed: () {
                        Navigator.pop(sheetContext);
                        widget.sourceOpener!(
                          'incident_investigation',
                          _value(record, 'incidentId'),
                        );
                      },
                      icon: const Icon(Icons.open_in_new_outlined),
                      label: const Text('Open Integration Reference'),
                    ),
                  ],
                ],
              );
            },
          ),
        );
      },
    );
  }

  Future<void> _showHistory() async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (BuildContext context) {
        return SafeArea(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.78,
            child: Column(
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.fromLTRB(18, 4, 18, 12),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Incident / Investigation History',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w800,
                        color: darkGreen,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: _history.isEmpty
                      ? const Center(
                          child: Text('No history records yet.'),
                        )
                      : ListView.separated(
                          padding: const EdgeInsets.all(14),
                          itemCount: _history.length,
                          separatorBuilder: (
                            BuildContext context,
                            int index,
                          ) =>
                              const SizedBox(height: 8),
                          itemBuilder: (
                            BuildContext context,
                            int index,
                          ) {
                            final Map<String, dynamic> item =
                                _history[index];

                            return Card(
                              elevation: 0,
                              child: ListTile(
                                leading: const CircleAvatar(
                                  child: Icon(Icons.history),
                                ),
                                title: Text(
                                  '${_value(item, 'action')} — '
                                  '${_value(item, 'title')}',
                                ),
                                subtitle: Text(
                                  '${_value(item, 'details')}\n'
                                  '${_formatDate(item['timestamp'])}',
                                ),
                                isThreeLine: true,
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _showGuide() async {
    const Map<String, String> modules = <String, String>{
      '44A — Incident / Event Master':
          'Central register for incidents, events and investigation status.',
      '44B — Incident / Near Miss Reporting':
          'Capture incidents, near misses and initial event information.',
      '44C — Initial Notification & Triage':
          'Record initial notification, classification and response priority.',
      '44D — Severity & Classification':
          'Classify event type, severity and potential consequence.',
      '44E — Investigation & Root Cause':
          'Capture investigation findings, causes and contributing factors.',
      '44F — Immediate / Interim Controls':
          'Record containment and immediate control measures.',
      '44G — Corrective & Preventive Action Link':
          'Connect investigation findings to corrective and preventive actions.',
      '44H — Evidence / Witness / Documentation':
          'Maintain references to evidence, witnesses and investigation documents.',
      '44I — Investigation Review & Approval':
          'Track investigation review, approval and return-for-action status.',
      '44J — Lessons Learned & Safety Alerts':
          'Capture learning and safety communication outputs.',
      '44K — Incident History / Audit Trail':
          'Maintain local incident and investigation history.',
      '44L — Incident Intelligence Dashboard':
          'Management view of events, severity, investigations, actions and closure.',
    };

    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Step 44 — Module Guide'),
          content: SizedBox(
            width: 650,
            child: ListView(
              shrinkWrap: true,
              children: modules.entries
                  .map(
                    (MapEntry<String, String> entry) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: const Icon(
                          Icons.check_circle_outline,
                          color: primaryGreen,
                        ),
                        title: Text(
                          entry.key,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        subtitle: Text(entry.value),
                      ),
                    ),
                  )
                  .toList(),
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

  void _resetFilters() {
    setState(() {
      _statusFilter = 'All';
      _typeFilter = 'All';
      _severityFilter = 'All';
      _classificationFilter = 'All';
      _searchController.clear();
    });
  }

  Widget _filterDropdown(
    String label,
    String value,
    List<String> items,
    ValueChanged<String?> onChanged,
  ) {
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
            .map(
              (String item) => DropdownMenuItem<String>(
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

  Widget _recordCard(Map<String, dynamic> record) {
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
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const CircleAvatar(
                    child: Icon(Icons.report_problem_outlined),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          _value(record, 'title'),
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                            color: darkGreen,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${_value(record, 'incidentId')} • '
                          '${_value(record, 'incidentType')}',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuButton<String>(
                    onSelected: (String action) {
                      if (action == 'view') {
                        _showDetails(record);
                      } else if (action == 'edit') {
                        _editRecord(record);
                      } else if (action == 'delete') {
                        _deleteRecord(record);
                      }
                    },
                    itemBuilder: (BuildContext context) =>
                        const <PopupMenuEntry<String>>[
                      PopupMenuItem<String>(
                        value: 'view',
                        child: Text('View Details'),
                      ),
                      PopupMenuItem<String>(
                        value: 'edit',
                        child: Text('Edit'),
                      ),
                      PopupMenuItem<String>(
                        value: 'delete',
                        child: Text('Delete'),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: <Widget>[
                  _statusChip(_value(record, 'status')),
                  _statusChip(_value(record, 'severity')),
                  _statusChip(_value(record, 'classification')),
                  _statusChip(_value(record, 'investigationStatus')),
                  _statusChip(_reviewStatus(record)),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: <Widget>[
                  const Icon(
                    Icons.location_on_outlined,
                    size: 17,
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Text(_value(record, 'site')),
                  ),
                  const SizedBox(width: 8),
                  const Icon(
                    Icons.person_outline,
                    size: 17,
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      _value(record, 'reportedBy').isEmpty
                          ? 'Unassigned'
                          : _value(record, 'reportedBy'),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
              if (_value(record, 'correctiveAction').isNotEmpty) ...<Widget>[
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Icon(
                      Icons.assignment_turned_in_outlined,
                      size: 17,
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(_value(record, 'correctiveAction')),
                    ),
                  ],
                ),
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
        title: const Text(
          'Step 44 • Incident & Investigation',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            tooltip: 'Module Guide',
            onPressed: _showGuide,
            icon: const Icon(Icons.menu_book_outlined),
          ),
          IconButton(
            tooltip: 'History',
            onPressed: _showHistory,
            icon: const Icon(Icons.history_outlined),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _loading ? null : _addRecord,
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('New Incident / Event'),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadData,
              child: ListView(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 100),
                children: <Widget>[
                  _dashboard(),
                  const SizedBox(height: 12),
                  Card(
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        children: <Widget>[
                          TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              labelText: 'Search incident / event',
                              hintText:
                                  'ID, title, site, reporter, classification, cause',
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
                          const SizedBox(height: 10),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: <Widget>[
                              _filterDropdown(
                                'Status',
                                _statusFilter,
                                <String>['All', ..._statuses],
                                (String? value) {
                                  if (value != null) {
                                    setState(
                                      () => _statusFilter = value,
                                    );
                                  }
                                },
                              ),
                              _filterDropdown(
                                'Incident Type',
                                _typeFilter,
                                <String>['All', ..._incidentTypes],
                                (String? value) {
                                  if (value != null) {
                                    setState(
                                      () => _typeFilter = value,
                                    );
                                  }
                                },
                              ),
                              _filterDropdown(
                                'Severity',
                                _severityFilter,
                                <String>['All', ..._severityOptions],
                                (String? value) {
                                  if (value != null) {
                                    setState(
                                      () => _severityFilter = value,
                                    );
                                  }
                                },
                              ),
                              _filterDropdown(
                                'Classification',
                                _classificationFilter,
                                <String>[
                                  'All',
                                  ..._classificationOptions,
                                ],
                                (String? value) {
                                  if (value != null) {
                                    setState(
                                      () => _classificationFilter = value,
                                    );
                                  }
                                },
                              ),
                              OutlinedButton.icon(
                                onPressed: _resetFilters,
                                icon: const Icon(Icons.filter_alt_off),
                                label: const Text('Reset'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          '${_filteredRecords.length} record(s) found',
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            color: darkGreen,
                          ),
                        ),
                      ),
                      TextButton.icon(
                        onPressed: _showGuide,
                        icon: const Icon(Icons.info_outline),
                        label: const Text('44A–44L'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  if (_filteredRecords.isEmpty)
                    Card(
                      elevation: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(30),
                        child: Column(
                          children: <Widget>[
                            const Icon(
                              Icons.report_problem_outlined,
                              size: 48,
                              color: darkGreen,
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'No incident / event records found.',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 6),
                            const Text(
                              'Create an incident or event record to begin '
                              'Step 44 management.',
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 14),
                            FilledButton.icon(
                              onPressed: _addRecord,
                              icon: const Icon(Icons.add),
                              label: const Text(
                                'Create First Incident',
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  else
                    ..._filteredRecords.map(_recordCard),
                ],
              ),
            ),
    );
  }
}
