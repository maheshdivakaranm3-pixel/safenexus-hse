import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RiskCommunicationControlTrackingPage extends StatefulWidget {
  const RiskCommunicationControlTrackingPage({
    super.key,
  });

  @override
  State<RiskCommunicationControlTrackingPage> createState() =>
      _RiskCommunicationControlTrackingPageState();
}

class _RiskCommunicationControlTrackingPageState
    extends State<RiskCommunicationControlTrackingPage> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);

  static const String storageKey =
      'safenexus_hse_risk_communication_control_tracking';

  final TextEditingController _searchController = TextEditingController();

  List<Map<String, dynamic>> _records = [];

  String _statusFilter = 'All';
  String _communicationFilter = 'All';
  String _effectivenessFilter = 'All';

  static const List<String> statuses = [
    'Open',
    'In Progress',
    'Implemented',
    'Verification Required',
    'Effective',
    'Ineffective',
    'Closed',
    'Cancelled',
  ];

  static const List<String> communicationTypes = [
    'Risk Assessment Briefing',
    'Toolbox Talk',
    'JSA / JHA Briefing',
    'RAMS Briefing',
    'Pre-Task Briefing',
    'Safety Meeting',
    'Worker Consultation',
    'Induction',
    'Training',
    'Safety Campaign',
    'Other',
  ];

  static const List<String> effectivenessValues = [
    'Not Assessed',
    'Effective',
    'Partially Effective',
    'Ineffective',
  ];

  @override
  void initState() {
    super.initState();
    _loadRecords();
    _searchController.addListener(_refresh);
  }

  @override
  void dispose() {
    _searchController
      ..removeListener(_refresh)
      ..dispose();
    super.dispose();
  }

  Future<void> _loadRecords() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(storageKey);

    if (raw == null || raw.isEmpty) {
      return;
    }

    try {
      final decoded = jsonDecode(raw);

      if (decoded is List) {
        setState(() {
          _records = decoded
              .whereType<Map>()
              .map(
                (item) => Map<String, dynamic>.from(item),
              )
              .toList();
        });
      }
    } catch (_) {
      // Ignore invalid local data.
    }
  }

  Future<void> _saveRecords() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(storageKey, jsonEncode(_records));
  }

  void _refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  List<Map<String, dynamic>> get _filteredRecords {
    final query = _searchController.text.trim().toLowerCase();

    return _records.where((record) {
      final status = record['status']?.toString() ?? '';
      final communicationType =
          record['communicationType']?.toString() ?? '';
      final effectiveness =
          record['effectiveness']?.toString() ?? '';

      if (_statusFilter != 'All' && status != _statusFilter) {
        return false;
      }

      if (_communicationFilter != 'All' &&
          communicationType != _communicationFilter) {
        return false;
      }

      if (_effectivenessFilter != 'All' &&
          effectiveness != _effectivenessFilter) {
        return false;
      }

      if (query.isEmpty) {
        return true;
      }

      final searchable = [
        record['communicationNo'],
        record['project'],
        record['location'],
        record['department'],
        record['activity'],
        record['hazard'],
        record['risk'],
        record['riskReference'],
        record['communicatedBy'],
        record['responsiblePerson'],
        record['control'],
        record['controlOwner'],
        record['status'],
        record['effectiveness'],
      ].join(' ').toLowerCase();

      return searchable.contains(query);
    }).toList();
  }

  int _countByStatus(String status) {
    return _records.where(
      (record) => record['status'] == status,
    ).length;
  }

  int _countByEffectiveness(String effectiveness) {
    return _records.where(
      (record) => record['effectiveness'] == effectiveness,
    ).length;
  }

  bool _isOverdue(Map<String, dynamic> record) {
    final targetDate = _parseDate(record['targetDate']?.toString());

    if (targetDate == null) {
      return false;
    }

    final status = record['status']?.toString() ?? '';

    if (status == 'Implemented' ||
        status == 'Effective' ||
        status == 'Closed' ||
        status == 'Cancelled') {
      return false;
    }

    final today = DateTime.now();

    return DateTime(
      targetDate.year,
      targetDate.month,
      targetDate.day,
    ).isBefore(
      DateTime(
        today.year,
        today.month,
        today.day,
      ),
    );
  }

  DateTime? _parseDate(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }

    return DateTime.tryParse(value);
  }

  String _formatDate(String? value) {
    final date = _parseDate(value);

    if (date == null) {
      return '-';
    }

    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }

  String _formatDateTime(String? value) {
    final date = _parseDate(value);

    if (date == null) {
      return '-';
    }

    return '${_formatDate(value)} '
        '${date.hour.toString().padLeft(2, '0')}:'
        '${date.minute.toString().padLeft(2, '0')}';
  }

  Future<void> _openForm({
    Map<String, dynamic>? existingRecord,
    int? editIndex,
  }) async {
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return RiskCommunicationControlFormSheet(
          existingRecord: existingRecord,
        );
      },
    );

    if (result == null) {
      return;
    }

    setState(() {
      if (editIndex != null &&
          editIndex >= 0 &&
          editIndex < _records.length) {
        final oldRecord = Map<String, dynamic>.from(
          _records[editIndex],
        );

        result['createdAt'] = oldRecord['createdAt'] ??
            DateTime.now().toIso8601String();
        result['updatedAt'] = DateTime.now().toIso8601String();

        _records[editIndex] = result;
      } else {
        result['createdAt'] = DateTime.now().toIso8601String();
        result['updatedAt'] = DateTime.now().toIso8601String();

        _records.insert(0, result);
      }
    });

    await _saveRecords();
  }

  Future<void> _deleteRecord(int index) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Delete Record'),
          content: const Text(
            'Are you sure you want to delete this risk communication '
            'and control tracking record?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, false);
              },
              child: const Text('Cancel'),
            ),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: () {
                Navigator.pop(dialogContext, true);
              },
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
      _records.removeAt(index);
    });

    await _saveRecords();
  }

  void _showHistory(Map<String, dynamic> record) {
    final createdAt = record['createdAt']?.toString();
    final updatedAt = record['updatedAt']?.toString();

    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Record History'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Created',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(_formatDateTime(createdAt)),
              const SizedBox(height: 16),
              const Text(
                'Last Updated',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(_formatDateTime(updatedAt)),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'Open':
        return Colors.orange;
      case 'In Progress':
        return Colors.blue;
      case 'Implemented':
        return Colors.indigo;
      case 'Verification Required':
        return Colors.deepOrange;
      case 'Effective':
        return primaryGreen;
      case 'Ineffective':
        return Colors.red;
      case 'Closed':
        return darkGreen;
      case 'Cancelled':
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }

  Color _effectivenessColor(String value) {
    switch (value) {
      case 'Effective':
        return primaryGreen;
      case 'Partially Effective':
        return Colors.orange;
      case 'Ineffective':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredRecords;

    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        title: const Text(
          'Risk Communication & Control',
        ),
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            tooltip: 'Refresh',
            onPressed: _loadRecords,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        onPressed: () {
          _openForm();
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Record'),
      ),
      body: RefreshIndicator(
        onRefresh: _loadRecords,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 100),
          children: [
            _buildHeader(),
            const SizedBox(height: 12),
            _buildDashboard(),
            const SizedBox(height: 12),
            _buildSearchAndFilters(),
            const SizedBox(height: 12),
            if (filtered.isEmpty)
              _buildEmptyState()
            else
              ...filtered.map(
                (record) => _buildRecordCard(record),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: primaryGreen.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(
                Icons.campaign_outlined,
                color: primaryGreen,
                size: 30,
              ),
            ),
            const SizedBox(width: 14),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Risk Communication & Control Tracking',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Communicate risks, track controls, verify implementation '
                    'and monitor effectiveness.',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboard() {
    final total = _records.length;
    final open = _countByStatus('Open');
    final progress = _countByStatus('In Progress');
    final verification = _countByStatus('Verification Required');
    final effective = _countByEffectiveness('Effective');
    final ineffective = _countByEffectiveness('Ineffective');
    final closed = _countByStatus('Closed');
    final overdue =
        _records.where(_isOverdue).length;

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _metricCard(
                'Total',
                total.toString(),
                Icons.list_alt_outlined,
                primaryGreen,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _metricCard(
                'Open',
                open.toString(),
                Icons.pending_actions,
                Colors.orange,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _metricCard(
                'Progress',
                progress.toString(),
                Icons.sync,
                Colors.blue,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: _metricCard(
                'Verification',
                verification.toString(),
                Icons.fact_check_outlined,
                Colors.deepOrange,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _metricCard(
                'Effective',
                effective.toString(),
                Icons.verified_outlined,
                primaryGreen,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _metricCard(
                'Ineffective',
                ineffective.toString(),
                Icons.warning_amber_outlined,
                Colors.red,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: _metricCard(
                'Closed',
                closed.toString(),
                Icons.check_circle_outline,
                darkGreen,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _metricCard(
                'Overdue',
                overdue.toString(),
                Icons.schedule,
                Colors.red,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _metricCard(
                'Records',
                filteredRecordsCount.toString(),
                Icons.filter_alt_outlined,
                Colors.blueGrey,
              ),
            ),
          ],
        ),
      ],
    );
  }

  int get filteredRecordsCount {
    return _filteredRecords.length;
  }

  Widget _metricCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Card(
      elevation: 1,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 12,
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: color,
              size: 21,
            ),
            const SizedBox(height: 5),
            Text(
              value,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 10,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search',
                hintText:
                    'No, project, activity, hazard, control...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isEmpty
                    ? null
                    : IconButton(
                        onPressed: () {
                          _searchController.clear();
                        },
                        icon: const Icon(Icons.clear),
                      ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              initialValue: _statusFilter,
              decoration: _filterDecoration('Status'),
              items: [
                const DropdownMenuItem(
                  value: 'All',
                  child: Text('All'),
                ),
                ...statuses.map(
                  (status) => DropdownMenuItem(
                    value: status,
                    child: Text(status),
                  ),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _statusFilter = value ?? 'All';
                });
              },
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              initialValue: _communicationFilter,
              decoration: _filterDecoration(
                'Communication Type',
              ),
              items: [
                const DropdownMenuItem(
                  value: 'All',
                  child: Text('All'),
                ),
                ...communicationTypes.map(
                  (type) => DropdownMenuItem(
                    value: type,
                    child: Text(type),
                  ),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _communicationFilter = value ?? 'All';
                });
              },
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              initialValue: _effectivenessFilter,
              decoration: _filterDecoration(
                'Effectiveness',
              ),
              items: [
                const DropdownMenuItem(
                  value: 'All',
                  child: Text('All'),
                ),
                ...effectivenessValues.map(
                  (value) => DropdownMenuItem(
                    value: value,
                    child: Text(value),
                  ),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _effectivenessFilter = value ?? 'All';
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _filterDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 12,
      ),
    );
  }

  Widget _buildRecordCard(
    Map<String, dynamic> record,
  ) {
    final recordIndex = _records.indexOf(record);
    final status = record['status']?.toString() ?? '';
    final effectiveness =
        record['effectiveness']?.toString() ?? 'Not Assessed';
    final overdue = _isOverdue(record);

    return Card(
      elevation: 1,
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    record['communicationNo']?.toString() ??
                        'Risk Communication',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'edit') {
                      _openForm(
                        existingRecord: record,
                        editIndex: recordIndex,
                      );
                    } else if (value == 'history') {
                      _showHistory(record);
                    } else if (value == 'delete') {
                      _deleteRecord(recordIndex);
                    }
                  },
                  itemBuilder: (_) => const [
                    PopupMenuItem(
                      value: 'edit',
                      child: Text('Edit'),
                    ),
                    PopupMenuItem(
                      value: 'history',
                      child: Text('History'),
                    ),
                    PopupMenuItem(
                      value: 'delete',
                      child: Text('Delete'),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 6),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                _badge(
                  status,
                  _statusColor(status),
                ),
                _badge(
                  effectiveness,
                  _effectivenessColor(effectiveness),
                ),
                if (overdue)
                  _badge(
                    'OVERDUE',
                    Colors.red,
                  ),
              ],
            ),
            const SizedBox(height: 12),
            _infoRow(
              Icons.assignment_outlined,
              'Reference',
              record['riskReference'],
            ),
            _infoRow(
              Icons.business_outlined,
              'Project',
              record['project'],
            ),
            _infoRow(
              Icons.location_on_outlined,
              'Location',
              record['location'],
            ),
            _infoRow(
              Icons.work_outline,
              'Activity',
              record['activity'],
            ),
            _infoRow(
              Icons.warning_amber_outlined,
              'Risk',
              record['risk'],
            ),
            _infoRow(
              Icons.campaign_outlined,
              'Communication',
              record['communicationType'],
            ),
            _infoRow(
              Icons.person_outline,
              'Communicated By',
              record['communicatedBy'],
            ),
            _infoRow(
              Icons.engineering_outlined,
              'Responsible',
              record['responsiblePerson'],
            ),
            const Divider(height: 22),
            _infoRow(
              Icons.shield_outlined,
              'Control',
              record['control'],
            ),
            _infoRow(
              Icons.person_outline,
              'Control Owner',
              record['controlOwner'],
            ),
            _infoRow(
              Icons.event_outlined,
              'Target Date',
              _formatDate(
                record['targetDate']?.toString(),
              ),
            ),
            _infoRow(
              Icons.fact_check_outlined,
              'Implementation',
              record['implementationStatus'],
            ),
            _infoRow(
              Icons.verified_outlined,
              'Verification',
              _formatDate(
                record['verificationDate']?.toString(),
              ),
            ),
            _infoRow(
              Icons.person_search_outlined,
              'Verified By',
              record['verifiedBy'],
            ),
            if ((record['remarks']?.toString() ?? '').isNotEmpty)
              _infoRow(
                Icons.notes_outlined,
                'Remarks',
                record['remarks'],
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
        horizontal: 9,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _infoRow(
    IconData icon,
    String label,
    dynamic value,
  ) {
    final text = value?.toString() ?? '';

    if (text.isEmpty || text == '-') {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 7),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 17,
            color: darkGreen,
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 105,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 11,
                color: Colors.black54,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 5),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 40,
        ),
        child: Column(
          children: [
            Icon(
              Icons.campaign_outlined,
              size: 55,
              color: primaryGreen.withValues(alpha: 0.55),
            ),
            const SizedBox(height: 12),
            const Text(
              'No Risk Communication Records',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Add a record to start tracking risk communication '
              'and control effectiveness.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              style: FilledButton.styleFrom(
                backgroundColor: primaryGreen,
              ),
              onPressed: () {
                _openForm();
              },
              icon: const Icon(Icons.add),
              label: const Text('Add First Record'),
            ),
          ],
        ),
      ),
    );
  }
}

class RiskCommunicationControlFormSheet extends StatefulWidget {
  final Map<String, dynamic>? existingRecord;

  const RiskCommunicationControlFormSheet({
    super.key,
    this.existingRecord,
  });

  @override
  State<RiskCommunicationControlFormSheet> createState() =>
      _RiskCommunicationControlFormSheetState();
}

class _RiskCommunicationControlFormSheetState
    extends State<RiskCommunicationControlFormSheet> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);

  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>();

  late final TextEditingController _communicationNoController;
  late final TextEditingController _riskReferenceController;
  late final TextEditingController _projectController;
  late final TextEditingController _locationController;
  late final TextEditingController _departmentController;
  late final TextEditingController _activityController;
  late final TextEditingController _hazardController;
  late final TextEditingController _riskController;
  late final TextEditingController _consequenceController;
  late final TextEditingController _communicatedByController;
  late final TextEditingController _responsibleController;
  late final TextEditingController _participantsController;
  late final TextEditingController _keyPointsController;
  late final TextEditingController _controlController;
  late final TextEditingController _controlOwnerController;
  late final TextEditingController _verifiedByController;
  late final TextEditingController _remarksController;

  String _communicationType =
      'Risk Assessment Briefing';
  String _communicationMethod = 'Face-to-Face';
  String _status = 'Open';
  String _implementationStatus = 'Not Started';
  String _effectiveness = 'Not Assessed';
  bool _workerAcknowledgement = false;

  DateTime? _communicationDate;
  TimeOfDay? _communicationTime;
  DateTime? _targetDate;
  DateTime? _verificationDate;

  bool get _isEditing => widget.existingRecord != null;

  @override
  void initState() {
    super.initState();

    final record = widget.existingRecord;

    _communicationNoController =
        TextEditingController(
      text: record?['communicationNo']?.toString() ?? '',
    );
    _riskReferenceController =
        TextEditingController(
      text: record?['riskReference']?.toString() ?? '',
    );
    _projectController = TextEditingController(
      text: record?['project']?.toString() ?? '',
    );
    _locationController = TextEditingController(
      text: record?['location']?.toString() ?? '',
    );
    _departmentController = TextEditingController(
      text: record?['department']?.toString() ?? '',
    );
    _activityController = TextEditingController(
      text: record?['activity']?.toString() ?? '',
    );
    _hazardController = TextEditingController(
      text: record?['hazard']?.toString() ?? '',
    );
    _riskController = TextEditingController(
      text: record?['risk']?.toString() ?? '',
    );
    _consequenceController = TextEditingController(
      text: record?['consequence']?.toString() ?? '',
    );
    _communicatedByController =
        TextEditingController(
      text: record?['communicatedBy']?.toString() ?? '',
    );
    _responsibleController = TextEditingController(
      text: record?['responsiblePerson']?.toString() ?? '',
    );
    _participantsController = TextEditingController(
      text: record?['participants']?.toString() ?? '',
    );
    _keyPointsController = TextEditingController(
      text: record?['keyRiskControlPoints']?.toString() ?? '',
    );
    _controlController = TextEditingController(
      text: record?['control']?.toString() ?? '',
    );
    _controlOwnerController = TextEditingController(
      text: record?['controlOwner']?.toString() ?? '',
    );
    _verifiedByController = TextEditingController(
      text: record?['verifiedBy']?.toString() ?? '',
    );
    _remarksController = TextEditingController(
      text: record?['remarks']?.toString() ?? '',
    );

    _communicationType =
        record?['communicationType']?.toString() ??
            _communicationType;

    _communicationMethod =
        record?['communicationMethod']?.toString() ??
            _communicationMethod;

    _status =
        record?['status']?.toString() ?? _status;

    _implementationStatus =
        record?['implementationStatus']?.toString() ??
            _implementationStatus;

    _effectiveness =
        record?['effectiveness']?.toString() ??
            _effectiveness;

    _workerAcknowledgement =
        record?['workerAcknowledgement'] == true;

    _communicationDate = _parseDate(
      record?['communicationDate']?.toString(),
    );

    _targetDate = _parseDate(
      record?['targetDate']?.toString(),
    );

    _verificationDate = _parseDate(
      record?['verificationDate']?.toString(),
    );

    final timeText =
        record?['communicationTime']?.toString();

    if (timeText != null && timeText.contains(':')) {
      final parts = timeText.split(':');

      if (parts.length == 2) {
        final hour = int.tryParse(parts[0]);
        final minute = int.tryParse(parts[1]);

        if (hour != null &&
            minute != null &&
            hour >= 0 &&
            hour <= 23 &&
            minute >= 0 &&
            minute <= 59) {
          _communicationTime = TimeOfDay(
            hour: hour,
            minute: minute,
          );
        }
      }
    }
  }

  @override
  void dispose() {
    _communicationNoController.dispose();
    _riskReferenceController.dispose();
    _projectController.dispose();
    _locationController.dispose();
    _departmentController.dispose();
    _activityController.dispose();
    _hazardController.dispose();
    _riskController.dispose();
    _consequenceController.dispose();
    _communicatedByController.dispose();
    _responsibleController.dispose();
    _participantsController.dispose();
    _keyPointsController.dispose();
    _controlController.dispose();
    _controlOwnerController.dispose();
    _verifiedByController.dispose();
    _remarksController.dispose();
    super.dispose();
  }

  DateTime? _parseDate(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }

    return DateTime.tryParse(value);
  }

  String _dateToText(DateTime? date) {
    if (date == null) {
      return '';
    }

    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }

  String _timeToText(TimeOfDay? time) {
    if (time == null) {
      return '';
    }

    return '${time.hour.toString().padLeft(2, '0')}:'
        '${time.minute.toString().padLeft(2, '0')}';
  }

  Future<void> _pickCommunicationDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _communicationDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _communicationDate = picked;
      });
    }
  }

  Future<void> _pickTargetDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _targetDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _targetDate = picked;
      });
    }
  }

  Future<void> _pickVerificationDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _verificationDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _verificationDate = picked;
      });
    }
  }

  Future<void> _pickCommunicationTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime:
          _communicationTime ?? TimeOfDay.now(),
    );

    if (picked != null) {
      setState(() {
        _communicationTime = picked;
      });
    }
  }

  InputDecoration _decoration(
    String label, {
    String? hint,
    IconData? icon,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: icon == null
          ? null
          : Icon(
              icon,
              color: darkGreen,
            ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      filled: true,
      fillColor: Colors.white,
    );
  }

  Widget _sectionTitle(
    String title,
    IconData icon,
  ) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 18,
        bottom: 10,
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: primaryGreen,
            size: 21,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: darkGreen,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _textField(
    TextEditingController controller,
    String label, {
    IconData? icon,
    bool required = false,
    int maxLines = 1,
    String? hint,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        decoration: _decoration(
          label,
          hint: hint,
          icon: icon,
        ),
        validator: required
            ? (value) {
                if (value == null ||
                    value.trim().isEmpty) {
                  return '$label is required';
                }
                return null;
              }
            : null,
      ),
    );
  }

  Widget _dropdownField(
    String label,
    String value,
    List<String> values,
    ValueChanged<String?> onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: DropdownButtonFormField<String>(
        initialValue: value,
        decoration: _decoration(label),
        items: values
            .map(
              (item) => DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              ),
            )
            .toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _dateField(
    String label,
    DateTime? value,
    VoidCallback onTap, {
    bool required = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: InputDecorator(
          decoration: _decoration(
            label,
            icon: Icons.event_outlined,
          ).copyWith(
            errorText: required && value == null
                ? 'Select $label'
                : null,
          ),
          child: Text(
            value == null
                ? 'Select date'
                : _dateToText(value),
            style: TextStyle(
              color: value == null
                  ? Colors.black45
                  : Colors.black87,
            ),
          ),
        ),
      ),
    );
  }

  Widget _timeField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: _pickCommunicationTime,
        borderRadius: BorderRadius.circular(12),
        child: InputDecorator(
          decoration: _decoration(
            'Communication Time',
            icon: Icons.access_time,
          ),
          child: Text(
            _communicationTime == null
                ? 'Select time'
                : _timeToText(_communicationTime),
            style: TextStyle(
              color: _communicationTime == null
                  ? Colors.black45
                  : Colors.black87,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_communicationDate == null) {
      _showMessage(
        'Please select Communication Date.',
      );
      return;
    }

    if (_targetDate == null) {
      _showMessage(
        'Please select Target Date.',
      );
      return;
    }

    if (_verificationDate != null &&
        _communicationDate != null &&
        _verificationDate!.isBefore(
          _communicationDate!,
        )) {
      _showMessage(
        'Verification Date cannot be before Communication Date.',
      );
      return;
    }

    if (_status == 'Effective' &&
        _effectiveness != 'Effective') {
      _showMessage(
        'Effective status requires Effectiveness = Effective.',
      );
      return;
    }

    if (_status == 'Verification Required' &&
        _implementationStatus !=
            'Verification Required') {
      _showMessage(
        'Verification Required status should match '
        'the implementation status.',
      );
      return;
    }

    if (_implementationStatus == 'Verified' &&
        _verificationDate == null) {
      _showMessage(
        'Please select Verification Date for a verified control.',
      );
      return;
    }

    final result = <String, dynamic>{
      'communicationNo':
          _communicationNoController.text.trim(),
      'riskReference':
          _riskReferenceController.text.trim(),
      'project':
          _projectController.text.trim(),
      'location':
          _locationController.text.trim(),
      'department':
          _departmentController.text.trim(),
      'activity':
          _activityController.text.trim(),
      'hazard':
          _hazardController.text.trim(),
      'risk':
          _riskController.text.trim(),
      'consequence':
          _consequenceController.text.trim(),
      'communicationType':
          _communicationType,
      'communicationDate':
          _communicationDate!.toIso8601String(),
      'communicationTime':
          _timeToText(_communicationTime),
      'communicatedBy':
          _communicatedByController.text.trim(),
      'responsiblePerson':
          _responsibleController.text.trim(),
      'participants':
          _participantsController.text.trim(),
      'communicationMethod':
          _communicationMethod,
      'keyRiskControlPoints':
          _keyPointsController.text.trim(),
      'workerAcknowledgement':
          _workerAcknowledgement,
      'control':
          _controlController.text.trim(),
      'controlOwner':
          _controlOwnerController.text.trim(),
      'targetDate':
          _targetDate!.toIso8601String(),
      'implementationStatus':
          _implementationStatus,
      'verificationDate':
          _verificationDate?.toIso8601String() ?? '',
      'verifiedBy':
          _verifiedByController.text.trim(),
      'effectiveness':
          _effectiveness,
      'status':
          _status,
      'remarks':
          _remarksController.text.trim(),
    };

    if (!mounted) {
      return;
    }

    Navigator.pop(context, result);
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset =
        MediaQuery.viewInsetsOf(context).bottom;

    return SafeArea(
      child: Container(
        height: MediaQuery.sizeOf(context).height * 0.94,
        decoration: const BoxDecoration(
          color: Color(0xFFF6F8F7),
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(22),
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(
                18,
                12,
                8,
                12,
              ),
              decoration: const BoxDecoration(
                color: primaryGreen,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(22),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _isEditing
                          ? 'Edit Risk Communication'
                          : 'New Risk Communication',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    color: Colors.white,
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Form(
                key: _formKey,
                child: ListView(
                  padding: EdgeInsets.fromLTRB(
                    14,
                    4,
                    14,
                    30 + bottomInset,
                  ),
                  children: [
                    _sectionTitle(
                      '1. Risk Reference & Activity',
                      Icons.warning_amber_outlined,
                    ),
                    _textField(
                      _communicationNoController,
                      'Communication No.',
                      icon: Icons.numbers,
                      required: true,
                      hint: 'RC-001',
                    ),
                    _textField(
                      _riskReferenceController,
                      'Risk Reference',
                      icon: Icons.link,
                      hint: 'HIRA / JSA / RAMS / Risk Register No.',
                    ),
                    _textField(
                      _projectController,
                      'Project',
                      icon: Icons.business_outlined,
                      required: true,
                    ),
                    _textField(
                      _locationController,
                      'Location',
                      icon: Icons.location_on_outlined,
                      required: true,
                    ),
                    _textField(
                      _departmentController,
                      'Department',
                      icon: Icons.account_tree_outlined,
                    ),
                    _textField(
                      _activityController,
                      'Activity / Work',
                      icon: Icons.work_outline,
                      required: true,
                    ),
                    _textField(
                      _hazardController,
                      'Hazard',
                      icon: Icons.warning_outlined,
                      required: true,
                      maxLines: 2,
                    ),
                    _textField(
                      _riskController,
                      'Risk',
                      icon: Icons.report_problem_outlined,
                      required: true,
                      maxLines: 2,
                    ),
                    _textField(
                      _consequenceController,
                      'Consequence',
                      icon: Icons.error_outline,
                      maxLines: 2,
                    ),

                    _sectionTitle(
                      '2. Risk Communication',
                      Icons.campaign_outlined,
                    ),
                    _dropdownField(
                      'Communication Type',
                      _communicationType,
                      _riskCommunicationTypes,
                      (value) {
                        if (value == null) {
                          return;
                        }

                        setState(() {
                          _communicationType = value;
                        });
                      },
                    ),
                    _dateField(
                      'Communication Date',
                      _communicationDate,
                      _pickCommunicationDate,
                      required: true,
                    ),
                    _timeField(),
                    _textField(
                      _communicatedByController,
                      'Communicated By',
                      icon: Icons.person_outline,
                      required: true,
                    ),
                    _textField(
                      _responsibleController,
                      'Responsible Person',
                      icon: Icons.engineering_outlined,
                      required: true,
                    ),
                    _textField(
                      _participantsController,
                      'Workers / Participants',
                      icon: Icons.groups_outlined,
                      maxLines: 2,
                    ),
                    _dropdownField(
                      'Communication Method',
                      _communicationMethod,
                      _riskCommunicationMethods,
                      (value) {
                        if (value == null) {
                          return;
                        }

                        setState(() {
                          _communicationMethod = value;
                        });
                      },
                    ),
                    _textField(
                      _keyPointsController,
                      'Key Risk / Control Points',
                      icon: Icons.fact_check_outlined,
                      required: true,
                      maxLines: 4,
                    ),
                    SwitchListTile.adaptive(
                      contentPadding:
                          const EdgeInsets.symmetric(
                        horizontal: 4,
                      ),
                      title: const Text(
                        'Worker Acknowledgement',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: const Text(
                        'Workers have acknowledged the communicated risk/control.',
                        style: TextStyle(
                          fontSize: 11,
                        ),
                      ),
                      value: _workerAcknowledgement,
                      activeColor: primaryGreen,
                      onChanged: (value) {
                        setState(() {
                          _workerAcknowledgement = value;
                        });
                      },
                    ),

                    _sectionTitle(
                      '3. Control Implementation',
                      Icons.shield_outlined,
                    ),
                    _textField(
                      _controlController,
                      'Control / Action',
                      icon: Icons.security_outlined,
                      required: true,
                      maxLines: 4,
                    ),
                    _textField(
                      _controlOwnerController,
                      'Control Owner',
                      icon: Icons.person_outline,
                      required: true,
                    ),
                    _dateField(
                      'Target Date',
                      _targetDate,
                      _pickTargetDate,
                      required: true,
                    ),
                    _dropdownField(
                      'Implementation Status',
                      _implementationStatus,
                      _implementationStatuses,
                      (value) {
                        if (value == null) {
                          return;
                        }

                        setState(() {
                          _implementationStatus = value;
                        });
                      },
                    ),

                    _sectionTitle(
                      '4. Verification & Effectiveness',
                      Icons.verified_outlined,
                    ),
                    _dateField(
                      'Verification Date',
                      _verificationDate,
                      _pickVerificationDate,
                    ),
                    _textField(
                      _verifiedByController,
                      'Verified By',
                      icon: Icons.person_search_outlined,
                    ),
                    _dropdownField(
                      'Effectiveness',
                      _effectiveness,
                      _riskEffectivenessValues,
                      (value) {
                        if (value == null) {
                          return;
                        }

                        setState(() {
                          _effectiveness = value;
                        });
                      },
                    ),

                    _sectionTitle(
                      '5. Status & Remarks',
                      Icons.assignment_turned_in_outlined,
                    ),
                    _dropdownField(
                      'Status',
                      _status,
                      _riskStatuses,
                      (value) {
                        if (value == null) {
                          return;
                        }

                        setState(() {
                          _status = value;
                        });
                      },
                    ),
                    _textField(
                      _remarksController,
                      'Remarks',
                      icon: Icons.notes_outlined,
                      maxLines: 4,
                    ),

                    const SizedBox(height: 18),
                    SizedBox(
                      height: 50,
                      child: FilledButton.icon(
                        style: FilledButton.styleFrom(
                          backgroundColor: primaryGreen,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: _submit,
                        icon: Icon(
                          _isEditing
                              ? Icons.save_outlined
                              : Icons.add_task_outlined,
                        ),
                        label: Text(
                          _isEditing
                              ? 'Update Record'
                              : 'Save Record',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static const List<String> _riskCommunicationTypes = [
    'Risk Assessment Briefing',
    'Toolbox Talk',
    'JSA / JHA Briefing',
    'RAMS Briefing',
    'Pre-Task Briefing',
    'Safety Meeting',
    'Worker Consultation',
    'Induction',
    'Training',
    'Safety Campaign',
    'Other',
  ];

  static const List<String> _riskCommunicationMethods = [
    'Face-to-Face',
    'Toolbox Talk',
    'Meeting',
    'Training Session',
    'Written Notice',
    'Digital / Online',
    'Site Demonstration',
    'Other',
  ];

  static const List<String> _riskEffectivenessValues = [
    'Not Assessed',
    'Effective',
    'Partially Effective',
    'Ineffective',
  ];

  static const List<String> _riskStatuses = [
    'Open',
    'In Progress',
    'Implemented',
    'Verification Required',
    'Effective',
    'Ineffective',
    'Closed',
    'Cancelled',
  ];

  static const List<String> _implementationStatuses = [
    'Not Started',
    'In Progress',
    'Implemented',
    'Verification Required',
    'Verified',
  ];
}
