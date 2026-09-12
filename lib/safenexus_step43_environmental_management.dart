import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// SafeNexus HSE - Step 43
/// HSE Environmental Management Center
///
/// Workflow:
/// Identify → Assess → Control → Monitor → Inspect → Correct → Verify → Comply → Analyze
///
/// Integration:
/// Step 9 → 31 → 32 → 34 → 35 → 36 → 37 → 38 → 39 → 40 → 41 → 42 → 43
///
/// English + Malayalam ready
/// UAE-wide scalable
/// Local persistence via SharedPreferences
/// No new dependency

class SafeNexusStep43EnvironmentalManagementPage extends StatefulWidget {
  const SafeNexusStep43EnvironmentalManagementPage({
    super.key,
    this.sourceOpener,
  });

  final void Function(String referenceType, String referenceId)? sourceOpener;

  @override
  State<SafeNexusStep43EnvironmentalManagementPage> createState() =>
      _SafeNexusStep43EnvironmentalManagementPageState();
}

class _SafeNexusStep43EnvironmentalManagementPageState
    extends State<SafeNexusStep43EnvironmentalManagementPage> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);

  static const String storageKey =
      'safenexus_hse_step43_environmental_management';

  final TextEditingController _searchController = TextEditingController();

  final List<String> _environmentalTypes = const [
    'Environmental Aspect / Impact',
    'Waste Management',
    'Hazardous Waste',
    'Air / Emission Monitoring',
    'Noise Monitoring',
    'Water Management',
    'Effluent / Discharge',
    'Spill Prevention',
    'Spill Response',
    'Environmental Inspection',
    'Environmental Compliance',
    'Environmental Permit',
    'Energy / Resource Efficiency',
    'Biodiversity / Ecology',
    'Marine / Coastal Environment',
    'Other',
  ];

  final List<String> _statuses = const [
    'Planned',
    'Active',
    'Monitoring',
    'Inspection Required',
    'Non-Compliant',
    'Corrective Action Required',
    'Verified',
    'Compliant',
    'Closed',
  ];

  final List<String> _severityOptions = const [
    'Low',
    'Medium',
    'High',
    'Critical',
  ];

  final List<String> _complianceOptions = const [
    'Not Assessed',
    'Compliant',
    'Partially Compliant',
    'Non-Compliant',
    'Not Applicable',
  ];

  final List<String> _wasteOptions = const [
    'Not Applicable',
    'General Waste',
    'Recyclable Waste',
    'Hazardous Waste',
    'Chemical Waste',
    'Oil / Used Oil',
    'Contaminated Material',
    'E-Waste',
    'Construction Waste',
    'Other',
  ];

  final List<String> _monitoringOptions = const [
    'Not Required',
    'Pending',
    'Within Limit',
    'Action Required',
    'Over Limit',
  ];

  List<Map<String, dynamic>> _records = <Map<String, dynamic>>[];
  List<Map<String, dynamic>> _history = <Map<String, dynamic>>[];

  String _statusFilter = 'All';
  String _typeFilter = 'All';
  String _severityFilter = 'All';
  String _complianceFilter = 'All';

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
      // Ignore malformed local data and return an empty list.
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

  String _newId() => 'ENV43-${DateTime.now().millisecondsSinceEpoch}';

  int _count(bool Function(Map<String, dynamic>) test) {
    return _records.where(test).length;
  }

  int get _total => _records.length;

  int get _active => _count(
        (Map<String, dynamic> record) => <String>[
          'Active',
          'Monitoring',
          'Inspection Required',
        ].contains(_value(record, 'status')),
      );

  int get _nonCompliant =>
      _count((record) => _value(record, 'compliance') == 'Non-Compliant');

  int get _actionRequired =>
      _count((record) => _value(record, 'status') == 'Corrective Action Required');

  int get _compliant =>
      _count((record) => _value(record, 'compliance') == 'Compliant');

  int get _hazardousWaste =>
      _count((record) => _value(record, 'wasteType') == 'Hazardous Waste');

  int get _monitoringAction => _count(
        (record) => <String>[
          'Action Required',
          'Over Limit',
        ].contains(_value(record, 'monitoringStatus')),
      );

  int get _critical =>
      _count((record) => _value(record, 'severity') == 'Critical');

  int get _overdue => _count((record) => _reviewStatus(record) == 'Overdue');

  String _reviewStatus(Map<String, dynamic> record) {
    final DateTime? date = _parseDate(record['nextReviewDate']);
    if (date == null) {
      return 'Not Scheduled';
    }

    final DateTime now = DateTime.now();
    final DateTime today = DateTime(now.year, now.month, now.day);
    final DateTime reviewDate = DateTime(date.year, date.month, date.day);
    final int days = reviewDate.difference(today).inDays;

    if (days < 0) {
      return 'Overdue';
    }
    if (days <= 30) {
      return 'Due Soon';
    }
    return 'Scheduled';
  }

  List<Map<String, dynamic>> get _filteredRecords {
    final String query = _searchController.text.trim().toLowerCase();

    return _records.where((Map<String, dynamic> record) {
      final String searchable = <String>[
        _value(record, 'environmentId'),
        _value(record, 'title'),
        _value(record, 'environmentalType'),
        _value(record, 'site'),
        _value(record, 'owner'),
        _value(record, 'permitReference'),
        _value(record, 'wasteType'),
      ].join(' ').toLowerCase();

      final bool matchesSearch =
          query.isEmpty || searchable.contains(query);
      final bool matchesStatus =
          _statusFilter == 'All' ||
          _value(record, 'status') == _statusFilter;
      final bool matchesType =
          _typeFilter == 'All' ||
          _value(record, 'environmentalType') == _typeFilter;
      final bool matchesSeverity =
          _severityFilter == 'All' ||
          _value(record, 'severity') == _severityFilter;
      final bool matchesCompliance =
          _complianceFilter == 'All' ||
          _value(record, 'compliance') == _complianceFilter;

      return matchesSearch &&
          matchesStatus &&
          matchesType &&
          matchesSeverity &&
          matchesCompliance;
    }).toList();
  }

  Future<void> _addRecord() async {
    final Map<String, dynamic>? values = await _recordDialog();

    if (values == null) {
      return;
    }

    final Map<String, dynamic> record = <String, dynamic>{
      ...values,
      'environmentId': _newId(),
      'createdAt': _now(),
      'updatedAt': _now(),
    };

    setState(() {
      _records.insert(0, record);
      _history.insert(0, <String, dynamic>{
        'action': 'Created',
        'environmentId': record['environmentId'],
        'title': record['title'],
        'timestamp': _now(),
        'details': 'Environmental management record created.',
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
          _value(item, 'environmentId') ==
          _value(record, 'environmentId'),
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
        'environmentId': updated['environmentId'],
        'title': updated['title'],
        'timestamp': _now(),
        'details': 'Environmental management record updated.',
      });
    });

    await _save();
  }

  Future<void> _deleteRecord(Map<String, dynamic> record) async {
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Delete Environmental Record'),
          content: Text(
            'Delete ${_value(record, 'title')} '
            '(${_value(record, 'environmentId')})?',
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
            _value(item, 'environmentId') ==
            _value(record, 'environmentId'),
      );

      _history.insert(0, <String, dynamic>{
        'action': 'Deleted',
        'environmentId': record['environmentId'],
        'title': record['title'],
        'timestamp': _now(),
        'details': 'Environmental management record deleted.',
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
      'site': TextEditingController(
        text: _value(existing ?? <String, dynamic>{}, 'site'),
      ),
      'owner': TextEditingController(
        text: _value(existing ?? <String, dynamic>{}, 'owner'),
      ),
      'permitReference': TextEditingController(
        text: _value(existing ?? <String, dynamic>{}, 'permitReference'),
      ),
      'nextReviewDate': TextEditingController(
        text: _value(existing ?? <String, dynamic>{}, 'nextReviewDate'),
      ),
      'aspect': TextEditingController(
        text: _value(existing ?? <String, dynamic>{}, 'aspect'),
      ),
      'impact': TextEditingController(
        text: _value(existing ?? <String, dynamic>{}, 'impact'),
      ),
      'controls': TextEditingController(
        text: _value(existing ?? <String, dynamic>{}, 'controls'),
      ),
      'monitoring': TextEditingController(
        text: _value(existing ?? <String, dynamic>{}, 'monitoring'),
      ),
      'quantity': TextEditingController(
        text: _value(existing ?? <String, dynamic>{}, 'quantity'),
      ),
      'unit': TextEditingController(
        text: _value(existing ?? <String, dynamic>{}, 'unit'),
      ),
      'correctiveAction': TextEditingController(
        text: _value(existing ?? <String, dynamic>{}, 'correctiveAction'),
      ),
      'notes': TextEditingController(
        text: _value(existing ?? <String, dynamic>{}, 'notes'),
      ),
    };

    String type =
        _value(existing ?? <String, dynamic>{}, 'environmentalType');
    String status = _value(existing ?? <String, dynamic>{}, 'status');
    String severity = _value(existing ?? <String, dynamic>{}, 'severity');
    String compliance = _value(existing ?? <String, dynamic>{}, 'compliance');
    String waste = _value(existing ?? <String, dynamic>{}, 'wasteType');
    String monitoring =
        _value(existing ?? <String, dynamic>{}, 'monitoringStatus');

    if (!_environmentalTypes.contains(type)) {
      type = _environmentalTypes.first;
    }
    if (!_statuses.contains(status)) {
      status = _statuses.first;
    }
    if (!_severityOptions.contains(severity)) {
      severity = _severityOptions.first;
    }
    if (!_complianceOptions.contains(compliance)) {
      compliance = _complianceOptions.first;
    }
    if (!_wasteOptions.contains(waste)) {
      waste = _wasteOptions.first;
    }
    if (!_monitoringOptions.contains(monitoring)) {
      monitoring = _monitoringOptions.first;
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
                    ? 'Create Environmental Record'
                    : 'Edit Environmental Record',
              ),
              content: SizedBox(
                width: 680,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      _textField(
                        controllers['title']!,
                        'Environmental Record Title',
                        Icons.eco_outlined,
                        required: true,
                      ),
                      const SizedBox(height: 10),
                      _dropdown(
                        'Environmental Type',
                        type,
                        _environmentalTypes,
                        (String? value) {
                          if (value != null) {
                            setDialogState(() => type = value);
                          }
                        },
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: _textField(
                              controllers['site']!,
                              'Site / Location',
                              Icons.location_on_outlined,
                              required: true,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _textField(
                              controllers['owner']!,
                              'Environmental Owner',
                              Icons.person_outline,
                              required: true,
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
                              'Severity',
                              severity,
                              _severityOptions,
                              (String? value) {
                                if (value != null) {
                                  setDialogState(() => severity = value);
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
                              'Compliance',
                              compliance,
                              _complianceOptions,
                              (String? value) {
                                if (value != null) {
                                  setDialogState(
                                    () => compliance = value,
                                  );
                                }
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _dropdown(
                              'Monitoring Status',
                              monitoring,
                              _monitoringOptions,
                              (String? value) {
                                if (value != null) {
                                  setDialogState(
                                    () => monitoring = value,
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      _dropdown(
                        'Waste Type',
                        waste,
                        _wasteOptions,
                        (String? value) {
                          if (value != null) {
                            setDialogState(() => waste = value);
                          }
                        },
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: _textField(
                              controllers['quantity']!,
                              'Quantity / Reading',
                              Icons.scale_outlined,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _textField(
                              controllers['unit']!,
                              'Unit',
                              Icons.straighten_outlined,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      _textField(
                        controllers['permitReference']!,
                        'Environmental Permit / Legal Reference',
                        Icons.gavel_outlined,
                      ),
                      const SizedBox(height: 10),
                      _textField(
                        controllers['nextReviewDate']!,
                        'Next Review / Monitoring (YYYY-MM-DD)',
                        Icons.event_available_outlined,
                      ),
                      const SizedBox(height: 10),
                      _textField(
                        controllers['aspect']!,
                        'Environmental Aspect / Source',
                        Icons.category_outlined,
                        maxLines: 2,
                      ),
                      const SizedBox(height: 10),
                      _textField(
                        controllers['impact']!,
                        'Environmental Impact / Risk',
                        Icons.warning_amber_outlined,
                        maxLines: 3,
                      ),
                      const SizedBox(height: 10),
                      _textField(
                        controllers['controls']!,
                        'Control Measures',
                        Icons.shield_outlined,
                        maxLines: 3,
                      ),
                      const SizedBox(height: 10),
                      _textField(
                        controllers['monitoring']!,
                        'Monitoring Details / Results',
                        Icons.monitor_heart_outlined,
                        maxLines: 3,
                      ),
                      const SizedBox(height: 10),
                      _textField(
                        controllers['correctiveAction']!,
                        'Corrective / Preventive Action',
                        Icons.build_circle_outlined,
                        maxLines: 3,
                      ),
                      const SizedBox(height: 10),
                      _textField(
                        controllers['notes']!,
                        'Environmental / HSE Notes',
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
                    final String site =
                        controllers['site']!.text.trim();
                    final String owner =
                        controllers['owner']!.text.trim();

                    if (title.isEmpty ||
                        site.isEmpty ||
                        owner.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Title, Site and Environmental Owner are required.',
                          ),
                        ),
                      );
                      return;
                    }

                    Navigator.pop(
                      dialogContext,
                      <String, dynamic>{
                        'title': title,
                        'environmentalType': type,
                        'site': site,
                        'owner': owner,
                        'status': status,
                        'severity': severity,
                        'compliance': compliance,
                        'wasteType': waste,
                        'monitoringStatus': monitoring,
                        'quantity':
                            controllers['quantity']!.text.trim(),
                        'unit': controllers['unit']!.text.trim(),
                        'permitReference':
                            controllers['permitReference']!.text.trim(),
                        'nextReviewDate':
                            controllers['nextReviewDate']!.text.trim(),
                        'aspect': controllers['aspect']!.text.trim(),
                        'impact': controllers['impact']!.text.trim(),
                        'controls': controllers['controls']!.text.trim(),
                        'monitoring':
                            controllers['monitoring']!.text.trim(),
                        'correctiveAction':
                            controllers['correctiveAction']!.text.trim(),
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
              '43L — Environmental Intelligence Dashboard',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w800,
                color: darkGreen,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Identify → Assess → Control → Monitor → Inspect → Correct → Verify',
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
                    'Total Records',
                    '$_total',
                    Icons.eco_outlined,
                  ],
                  <dynamic>[
                    'Active / Monitoring',
                    '$_active',
                    Icons.monitor_heart_outlined,
                  ],
                  <dynamic>[
                    'Compliant',
                    '$_compliant',
                    Icons.check_circle_outline,
                  ],
                  <dynamic>[
                    'Non-Compliant',
                    '$_nonCompliant',
                    Icons.warning_amber_outlined,
                  ],
                  <dynamic>[
                    'Action Required',
                    '$_actionRequired',
                    Icons.assignment_late_outlined,
                  ],
                  <dynamic>[
                    'Hazardous Waste',
                    '$_hazardousWaste',
                    Icons.delete_sweep_outlined,
                  ],
                  <dynamic>[
                    'Monitoring Action',
                    '$_monitoringAction',
                    Icons.analytics_outlined,
                  ],
                  <dynamic>[
                    'Critical',
                    '$_critical',
                    Icons.priority_high_outlined,
                  ],
                  <dynamic>[
                    'Review Overdue',
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
            width: 155,
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
            initialChildSize: 0.84,
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
                    _value(record, 'environmentId'),
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 14),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: <Widget>[
                      _statusChip(_value(record, 'status')),
                      _statusChip(_value(record, 'severity')),
                      _statusChip(_value(record, 'compliance')),
                      _statusChip(_value(record, 'monitoringStatus')),
                      _statusChip(_reviewStatus(record)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _section(
                    '43A–43L Environmental Management Control',
                    <Widget>[
                      _detailRow(
                        'Environmental Type',
                        _value(record, 'environmentalType'),
                      ),
                      _detailRow(
                        'Site / Location',
                        _value(record, 'site'),
                      ),
                      _detailRow(
                        'Environmental Owner',
                        _value(record, 'owner'),
                      ),
                      _detailRow(
                        'Status',
                        _value(record, 'status'),
                      ),
                      _detailRow(
                        'Severity',
                        _value(record, 'severity'),
                      ),
                      _detailRow(
                        'Compliance',
                        _value(record, 'compliance'),
                      ),
                      _detailRow(
                        'Waste Type',
                        _value(record, 'wasteType'),
                      ),
                      _detailRow(
                        'Quantity / Reading',
                        '${_value(record, 'quantity')} '
                        '${_value(record, 'unit')}'.trim(),
                      ),
                      _detailRow(
                        'Monitoring Status',
                        _value(record, 'monitoringStatus'),
                      ),
                      _detailRow(
                        'Permit / Legal Ref.',
                        _value(record, 'permitReference'),
                      ),
                      _detailRow(
                        'Next Review',
                        _formatDate(record['nextReviewDate']),
                      ),
                      _detailRow(
                        'Review Status',
                        _reviewStatus(record),
                      ),
                    ],
                  ),
                  if (_value(record, 'aspect').isNotEmpty) ...<Widget>[
                    const SizedBox(height: 12),
                    _section(
                      'Environmental Aspect / Source',
                      <Widget>[Text(_value(record, 'aspect'))],
                    ),
                  ],
                  if (_value(record, 'impact').isNotEmpty) ...<Widget>[
                    const SizedBox(height: 12),
                    _section(
                      'Environmental Impact / Risk',
                      <Widget>[Text(_value(record, 'impact'))],
                    ),
                  ],
                  if (_value(record, 'controls').isNotEmpty) ...<Widget>[
                    const SizedBox(height: 12),
                    _section(
                      'Control Measures',
                      <Widget>[Text(_value(record, 'controls'))],
                    ),
                  ],
                  if (_value(record, 'monitoring').isNotEmpty) ...<Widget>[
                    const SizedBox(height: 12),
                    _section(
                      'Monitoring Details / Results',
                      <Widget>[Text(_value(record, 'monitoring'))],
                    ),
                  ],
                  if (_value(record, 'correctiveAction').isNotEmpty) ...<Widget>[
                    const SizedBox(height: 12),
                    _section(
                      'Corrective / Preventive Action',
                      <Widget>[
                        Text(_value(record, 'correctiveAction')),
                      ],
                    ),
                  ],
                  if (_value(record, 'notes').isNotEmpty) ...<Widget>[
                    const SizedBox(height: 12),
                    _section(
                      'Environmental / HSE Notes',
                      <Widget>[Text(_value(record, 'notes'))],
                    ),
                  ],
                  if (widget.sourceOpener != null) ...<Widget>[
                    const SizedBox(height: 16),
                    OutlinedButton.icon(
                      onPressed: () {
                        Navigator.pop(sheetContext);
                        widget.sourceOpener!(
                          'environmental_management',
                          _value(record, 'environmentId'),
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
                      'Environmental Management History',
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
      '43A — Environmental Management Master':
          'Central register for environmental activities, aspects, impacts and controls.',
      '43B — Environmental Aspect & Impact':
          'Identify environmental aspects, sources, impacts and associated risk.',
      '43C — Waste Management':
          'Track general, recyclable, construction and other waste streams.',
      '43D — Hazardous Waste Tracking':
          'Record hazardous waste categories, quantities and control requirements.',
      '43E — Air / Noise / Emission Monitoring':
          'Track environmental monitoring results and action status.',
      '43F — Water & Effluent Management':
          'Record water, discharge and effluent-related environmental controls.',
      '43G — Spill Prevention & Response':
          'Link spill prevention and environmental response controls.',
      '43H — Environmental Inspection & Compliance':
          'Track inspections, findings and compliance outcomes.',
      '43I — Environmental Legal / Permit Tracking':
          'Record environmental permits and legal reference information.',
      '43J — Environmental Corrective Actions':
          'Capture corrective and preventive actions arising from environmental issues.',
      '43K — Environmental History / Audit Trail':
          'Maintain local environmental management history.',
      '43L — Environmental Intelligence Dashboard':
          'Management view of compliance, monitoring, waste, actions and review status.',
    };

    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Step 43 — Module Guide'),
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
      _complianceFilter = 'All';
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
                    child: Icon(Icons.eco_outlined),
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
                          '${_value(record, 'environmentId')} • '
                          '${_value(record, 'environmentalType')}',
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
                    itemBuilder: (BuildContext context) => const <PopupMenuEntry<String>>[
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
                  _statusChip(_value(record, 'compliance')),
                  _statusChip(_value(record, 'monitoringStatus')),
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
                      _value(record, 'owner').isEmpty
                          ? 'Unassigned'
                          : _value(record, 'owner'),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
              if (_value(record, 'wasteType') != 'Not Applicable' &&
                  _value(record, 'wasteType').isNotEmpty) ...<Widget>[
                const SizedBox(height: 8),
                Row(
                  children: <Widget>[
                    const Icon(
                      Icons.delete_sweep_outlined,
                      size: 17,
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(_value(record, 'wasteType')),
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
          'Step 43 • Environmental Management',
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
        label: const Text('New Environmental Record'),
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
                              labelText: 'Search environmental record',
                              hintText:
                                  'ID, title, site, owner, permit, waste type',
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
                                'Environmental Type',
                                _typeFilter,
                                <String>['All', ..._environmentalTypes],
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
                                'Compliance',
                                _complianceFilter,
                                <String>['All', ..._complianceOptions],
                                (String? value) {
                                  if (value != null) {
                                    setState(
                                      () => _complianceFilter = value,
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
                        label: const Text('43A–43L'),
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
                              Icons.eco_outlined,
                              size: 48,
                              color: darkGreen,
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'No environmental records found.',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 6),
                            const Text(
                              'Create an environmental record to begin '
                              'Step 43 management.',
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 14),
                            FilledButton.icon(
                              onPressed: _addRecord,
                              icon: const Icon(Icons.add),
                              label: const Text(
                                'Create First Record',
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
