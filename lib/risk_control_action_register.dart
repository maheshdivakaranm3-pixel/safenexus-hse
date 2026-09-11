import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RiskControlActionRegisterPage extends StatefulWidget {
  const RiskControlActionRegisterPage({super.key});

  @override
  State<RiskControlActionRegisterPage> createState() =>
      _RiskControlActionRegisterPageState();
}

class _RiskControlActionRegisterPageState
    extends State<RiskControlActionRegisterPage> {
  static const String _storageKey =
      'safenexus_hse_risk_control_action_register';

  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);

  final TextEditingController _searchController = TextEditingController();

  List<Map<String, dynamic>> _records = [];
  bool _loading = true;
  String _statusFilter = 'All';
  String _riskFilter = 'All';

  static const List<String> _statuses = <String>[
    'Open',
    'In Progress',
    'Completed',
    'Under Review',
    'Accepted',
    'Closed',
    'Cancelled',
  ];

  static const List<String> _riskLevels = <String>[
    'Low',
    'Medium',
    'High',
    'Critical',
  ];

  static const List<String> _departments = <String>[
    'HSE',
    'Civil',
    'Mechanical',
    'Electrical',
    'Lifting',
    'Scaffolding',
    'Operations',
    'Maintenance',
    'Construction',
    'Logistics',
    'Other',
  ];

  static const List<String> _hazardCategories = <String>[
    'General',
    'Work at Height',
    'Lifting & Rigging',
    'Confined Space',
    'Excavation',
    'Electrical',
    'Fire & Hot Work',
    'Chemical',
    'Mechanical',
    'Vehicle & Traffic',
    'Environmental',
    'Occupational Health',
    'Emergency',
    'Other',
  ];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_refresh);
    _loadRecords();
  }

  @override
  void dispose() {
    _searchController
      ..removeListener(_refresh)
      ..dispose();
    super.dispose();
  }

  void _refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _loadRecords() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_storageKey);

    List<Map<String, dynamic>> loaded = [];

    if (raw != null && raw.isNotEmpty) {
      try {
        final decoded = jsonDecode(raw);
        if (decoded is List) {
          loaded = decoded
              .whereType<Map>()
              .map(
                (item) => Map<String, dynamic>.from(
                  item.map(
                    (key, value) => MapEntry(key.toString(), value),
                  ),
                ),
              )
              .toList();
        }
      } catch (_) {
        loaded = [];
      }
    }

    if (!mounted) return;

    setState(() {
      _records = loaded;
      _loading = false;
    });
  }

  Future<void> _saveRecords() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_storageKey, jsonEncode(_records));
  }

  String _text(dynamic value) {
    return value?.toString().trim() ?? '';
  }

  DateTime? _parseDate(dynamic value) {
    if (value == null || value.toString().trim().isEmpty) {
      return null;
    }
    return DateTime.tryParse(value.toString());
  }

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    return '$day/$month/${date.year}';
  }

  bool _isOverdue(Map<String, dynamic> record) {
    final targetDate = _parseDate(record['targetDate']);
    if (targetDate == null) return false;

    final status = _text(record['status']);
    if (status == 'Completed' ||
        status == 'Closed' ||
        status == 'Cancelled') {
      return false;
    }

    final today = DateTime.now();
    final due = DateTime(
      targetDate.year,
      targetDate.month,
      targetDate.day,
    );
    final todayOnly = DateTime(today.year, today.month, today.day);

    return due.isBefore(todayOnly);
  }

  List<Map<String, dynamic>> get _filteredRecords {
    final query = _searchController.text.trim().toLowerCase();

    final filtered = _records.where((record) {
      final status = _text(record['status']);
      final initialRisk = _text(record['initialRiskLevel']);
      final residualRisk = _text(record['residualRiskLevel']);

      if (_statusFilter != 'All' && status != _statusFilter) {
        return false;
      }

      if (_riskFilter != 'All' &&
          initialRisk != _riskFilter &&
          residualRisk != _riskFilter) {
        return false;
      }

      if (query.isEmpty) return true;

      final searchable = <String>[
        _text(record['riskNo']),
        _text(record['project']),
        _text(record['location']),
        _text(record['department']),
        _text(record['activity']),
        _text(record['hazardCategory']),
        _text(record['hazard']),
        _text(record['consequence']),
        _text(record['existingControls']),
        _text(record['additionalControls']),
        _text(record['actionOwner']),
        _text(record['status']),
        _text(record['remarks']),
      ].join(' ').toLowerCase();

      return searchable.contains(query);
    }).toList();

    filtered.sort((a, b) {
      final aUpdated = _text(a['updatedAt']);
      final bUpdated = _text(b['updatedAt']);
      return bUpdated.compareTo(aUpdated);
    });

    return filtered;
  }

  int get _totalCount => _records.length;

  int get _openCount =>
      _records.where((record) => record['status'] == 'Open').length;

  int get _inProgressCount =>
      _records.where((record) => record['status'] == 'In Progress').length;

  int get _completedCount =>
      _records.where((record) => record['status'] == 'Completed').length;

  int get _highCriticalCount => _records.where((record) {
        final initial = _text(record['initialRiskLevel']);
        final residual = _text(record['residualRiskLevel']);
        return initial == 'High' ||
            initial == 'Critical' ||
            residual == 'High' ||
            residual == 'Critical';
      }).length;

  int get _overdueCount => _records.where(_isOverdue).length;

  Color _riskColor(String level) {
    switch (level) {
      case 'Low':
        return primaryGreen;
      case 'Medium':
        return Colors.orange.shade700;
      case 'High':
        return Colors.deepOrange;
      case 'Critical':
        return Colors.red.shade700;
      default:
        return Colors.grey.shade700;
    }
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'Open':
        return Colors.orange.shade700;
      case 'In Progress':
        return Colors.blue.shade700;
      case 'Completed':
        return primaryGreen;
      case 'Under Review':
        return Colors.indigo;
      case 'Accepted':
        return darkGreen;
      case 'Closed':
        return Colors.grey.shade700;
      case 'Cancelled':
        return Colors.red.shade700;
      default:
        return Colors.grey.shade700;
    }
  }

  Future<void> _deleteRecord(Map<String, dynamic> record) async {
    final riskNo = _text(record['riskNo']).isEmpty
        ? 'this risk record'
        : _text(record['riskNo']);

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Delete Risk Record?'),
          content: Text('Delete $riskNo permanently?'),
          actions: [
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

    if (confirmed != true) return;

    final id = record['id'];
    _records.removeWhere((item) => item['id'] == id);
    await _saveRecords();

    if (!mounted) return;

    setState(() {});
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Risk record deleted successfully'),
      ),
    );
  }

  Future<void> _openForm({
    Map<String, dynamic>? existingRecord,
  }) async {
    final saved = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _RiskControlFormSheet(
        existingRecord: existingRecord,
        statuses: _statuses,
        departments: _departments,
        hazardCategories: _hazardCategories,
        riskLevels: _riskLevels,
      ),
    );

    if (saved != true || !mounted) return;

    await _loadRecords();
  }

  Widget _summaryCard(
    String title,
    int value,
    IconData icon,
  ) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(13),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: primaryGreen.withValues(alpha: 0.10),
              child: Icon(
                icon,
                color: primaryGreen,
                size: 21,
              ),
            ),
            const SizedBox(width: 9),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 11.5,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    '$value',
                    style: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
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

  Widget _riskChip(String label) {
    final color = _riskColor(label);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 10.5,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _statusChip(String status) {
    final color = _statusColor(status);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: color,
          fontSize: 10.5,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _infoRow(
    IconData icon,
    String label,
    String value, {
    Color? valueColor,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 17,
            color: Colors.grey.shade600,
          ),
          const SizedBox(width: 7),
          Text(
            '$label: ',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w600,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 12,
                color: valueColor ?? Colors.grey.shade800,
                fontWeight: valueColor == null
                    ? FontWeight.normal
                    : FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _displayDateTime(dynamic value) {
    final text = _text(value);
    if (text.isEmpty) return '-';

    final parsed = DateTime.tryParse(text);
    if (parsed == null) return text;

    final hour = parsed.hour.toString().padLeft(2, '0');
    final minute = parsed.minute.toString().padLeft(2, '0');

    return '${_formatDate(parsed)} $hour:$minute';
  }

  Widget _buildRecordCard(Map<String, dynamic> record) {
    final riskNo =
        _text(record['riskNo']).isEmpty ? 'Risk Record' : _text(record['riskNo']);
    final activity = _text(record['activity']).isEmpty
        ? 'Activity / Task not specified'
        : _text(record['activity']);
    final status =
        _text(record['status']).isEmpty ? 'Open' : _text(record['status']);
    final initialRisk = _text(record['initialRiskLevel']);
    final residualRisk = _text(record['residualRiskLevel']);
    final targetDate = _parseDate(record['targetDate']);
    final overdue = _isOverdue(record);

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: overdue
              ? Colors.red.shade200
              : Colors.grey.shade200,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    riskNo,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: darkGreen,
                    ),
                  ),
                ),
                _statusChip(status),
                PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'edit') {
                      _openForm(existingRecord: record);
                    } else if (value == 'delete') {
                      _deleteRecord(record);
                    }
                  },
                  itemBuilder: (_) => const [
                    PopupMenuItem(
                      value: 'edit',
                      child: Text('Edit'),
                    ),
                    PopupMenuItem(
                      value: 'delete',
                      child: Text('Delete'),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 7),
            Text(
              activity,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 9),
            if (_text(record['project']).isNotEmpty)
              _infoRow(
                Icons.business_outlined,
                'Project',
                _text(record['project']),
              ),
            if (_text(record['location']).isNotEmpty)
              _infoRow(
                Icons.location_on_outlined,
                'Location',
                _text(record['location']),
              ),
            if (_text(record['department']).isNotEmpty)
              _infoRow(
                Icons.groups_outlined,
                'Department',
                _text(record['department']),
              ),
            if (_text(record['hazardCategory']).isNotEmpty)
              _infoRow(
                Icons.category_outlined,
                'Hazard Category',
                _text(record['hazardCategory']),
              ),
            if (_text(record['actionOwner']).isNotEmpty)
              _infoRow(
                Icons.person_outline,
                'Action Owner',
                _text(record['actionOwner']),
              ),
            if (targetDate != null)
              _infoRow(
                overdue
                    ? Icons.warning_amber_rounded
                    : Icons.event_outlined,
                'Target Date',
                '${_formatDate(targetDate)}${overdue ? ' 鈥� OVERDUE' : ''}',
                valueColor: overdue ? Colors.red.shade700 : null,
              ),
            const SizedBox(height: 9),
            Wrap(
              spacing: 7,
              runSpacing: 7,
              children: [
                if (initialRisk.isNotEmpty)
                  _riskChip('Initial: $initialRisk'),
                if (residualRisk.isNotEmpty)
                  _riskChip('Residual: $residualRisk'),
              ],
            ),
            if (_text(record['additionalControls']).isNotEmpty) ...[
              const SizedBox(height: 10),
              Text(
                'Additional Controls',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade700,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                _text(record['additionalControls']),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 12.5),
              ),
            ],
            const SizedBox(height: 10),
            Divider(color: Colors.grey.shade200),
            Text(
              'Created: ${_displayDateTime(record['createdAt'])}  鈥�  '
              'Updated: ${_displayDateTime(record['updatedAt'])}',
              style: TextStyle(
                fontSize: 10.5,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final records = _filteredRecords;

    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        title: const Text('Risk Control & Action Register'),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openForm(),
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Add Risk'),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadRecords,
              child: ListView(
                padding: const EdgeInsets.fromLTRB(
                  14,
                  14,
                  14,
                  100,
                ),
                children: [
                  Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(color: Colors.grey.shade200),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Risk & Planning Register',
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              color: darkGreen,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Risk controls, actions, owners and residual risk',
                            style: TextStyle(
                              fontSize: 12.5,
                              color: Colors.grey.shade700,
                            ),
                          ),
                          const SizedBox(height: 14),
                          TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              hintText:
                                  'Search risk, project, activity, hazard...',
                              prefixIcon: const Icon(Icons.search),
                              suffixIcon: _searchController.text.isEmpty
                                  ? null
                                  : IconButton(
                                      onPressed: _searchController.clear,
                                      icon: const Icon(Icons.clear),
                                    ),
                              filled: true,
                              fillColor: Colors.grey.shade50,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Colors.grey.shade300,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: Colors.grey.shade300,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          DropdownButtonFormField<String>(
                            initialValue: _statusFilter,
                            decoration: const InputDecoration(
                              labelText: 'Status Filter',
                              prefixIcon: Icon(Icons.filter_list),
                              border: OutlineInputBorder(),
                            ),
                            items: [
                              const DropdownMenuItem<String>(
                                value: 'All',
                                child: Text('All'),
                              ),
                              ..._statuses.map(
                                (status) => DropdownMenuItem<String>(
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
                            initialValue: _riskFilter,
                            decoration: const InputDecoration(
                              labelText: 'Risk Level Filter',
                              prefixIcon: Icon(Icons.warning_amber_outlined),
                              border: OutlineInputBorder(),
                            ),
                            items: [
                              const DropdownMenuItem<String>(
                                value: 'All',
                                child: Text('All'),
                              ),
                              ..._riskLevels.map(
                                (level) => DropdownMenuItem<String>(
                                  value: level,
                                  child: Text(level),
                                ),
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                _riskFilter = value ?? 'All';
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 2.0,
                    children: [
                      _summaryCard(
                        'Total',
                        _totalCount,
                        Icons.warning_amber_outlined,
                      ),
                      _summaryCard(
                        'Open',
                        _openCount,
                        Icons.pending_actions_outlined,
                      ),
                      _summaryCard(
                        'In Progress',
                        _inProgressCount,
                        Icons.autorenew,
                      ),
                      _summaryCard(
                        'Completed',
                        _completedCount,
                        Icons.task_alt,
                      ),
                      _summaryCard(
                        'High / Critical',
                        _highCriticalCount,
                        Icons.priority_high,
                      ),
                      _summaryCard(
                        'Overdue',
                        _overdueCount,
                        Icons.event_busy_outlined,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Risk Records',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: darkGreen,
                          ),
                        ),
                      ),
                      Text(
                        '${records.length} record${records.length == 1 ? '' : 's'}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  if (records.isEmpty)
                    Card(
                      elevation: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(30),
                        child: Column(
                          children: [
                            Icon(
                              Icons.fact_check_outlined,
                              size: 48,
                              color: Colors.grey.shade400,
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'No risk records found',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              _records.isEmpty
                                  ? 'Tap Add Risk to create the first record.'
                                  : 'Try changing the search or filters.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  else
                    ...records.map(_buildRecordCard),
                ],
              ),
            ),
    );
  }
}

class _RiskControlFormSheet extends StatefulWidget {
  final Map<String, dynamic>? existingRecord;
  final List<String> statuses;
  final List<String> departments;
  final List<String> hazardCategories;
  final List<String> riskLevels;

  const _RiskControlFormSheet({
    required this.existingRecord,
    required this.statuses,
    required this.departments,
    required this.hazardCategories,
    required this.riskLevels,
  });

  @override
  State<_RiskControlFormSheet> createState() =>
      _RiskControlFormSheetState();
}

class _RiskControlFormSheetState
    extends State<_RiskControlFormSheet> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);

  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _riskNoController;
  late final TextEditingController _projectController;
  late final TextEditingController _locationController;
  late final TextEditingController _activityController;
  late final TextEditingController _hazardController;
  late final TextEditingController _consequenceController;
  late final TextEditingController _existingControlsController;
  late final TextEditingController _additionalControlsController;
  late final TextEditingController _actionOwnerController;
  late final TextEditingController _referenceController;
  late final TextEditingController _remarksController;

  String _department = 'HSE';
  String _hazardCategory = 'General';
  String _initialRiskLevel = 'Medium';
  String _residualRiskLevel = 'Low';
  String _status = 'Open';

  int _initialLikelihood = 3;
  int _initialSeverity = 3;
  int _residualLikelihood = 2;
  int _residualSeverity = 2;

  DateTime? _targetDate;
  DateTime? _reviewDate;

  bool _saving = false;

  bool get _isEditing => widget.existingRecord != null;

  @override
  void initState() {
    super.initState();

    final record = widget.existingRecord;

    _riskNoController =
        TextEditingController(text: _value(record, 'riskNo'));
    _projectController =
        TextEditingController(text: _value(record, 'project'));
    _locationController =
        TextEditingController(text: _value(record, 'location'));
    _activityController =
        TextEditingController(text: _value(record, 'activity'));
    _hazardController =
        TextEditingController(text: _value(record, 'hazard'));
    _consequenceController =
        TextEditingController(text: _value(record, 'consequence'));
    _existingControlsController = TextEditingController(
      text: _value(record, 'existingControls'),
    );
    _additionalControlsController = TextEditingController(
      text: _value(record, 'additionalControls'),
    );
    _actionOwnerController =
        TextEditingController(text: _value(record, 'actionOwner'));
    _referenceController =
        TextEditingController(text: _value(record, 'reference'));
    _remarksController =
        TextEditingController(text: _value(record, 'remarks'));

    final savedDepartment = _value(record, 'department');
    if (widget.departments.contains(savedDepartment)) {
      _department = savedDepartment;
    }

    final savedCategory = _value(record, 'hazardCategory');
    if (widget.hazardCategories.contains(savedCategory)) {
      _hazardCategory = savedCategory;
    }

    final savedStatus = _value(record, 'status');
    if (widget.statuses.contains(savedStatus)) {
      _status = savedStatus;
    }

    _initialLikelihood = _parseRating(
      record?['initialLikelihood'],
      _initialLikelihood,
    );
    _initialSeverity = _parseRating(
      record?['initialSeverity'],
      _initialSeverity,
    );
    _residualLikelihood = _parseRating(
      record?['residualLikelihood'],
      _residualLikelihood,
    );
    _residualSeverity = _parseRating(
      record?['residualSeverity'],
      _residualSeverity,
    );

    _initialRiskLevel = _riskLevel(
      _initialLikelihood * _initialSeverity,
    );
    _residualRiskLevel = _riskLevel(
      _residualLikelihood * _residualSeverity,
    );

    final savedInitialRisk = _value(record, 'initialRiskLevel');
    if (widget.riskLevels.contains(savedInitialRisk)) {
      _initialRiskLevel = savedInitialRisk;
    }

    final savedResidualRisk = _value(record, 'residualRiskLevel');
    if (widget.riskLevels.contains(savedResidualRisk)) {
      _residualRiskLevel = savedResidualRisk;
    }

    _targetDate = _parseDate(record?['targetDate']);
    _reviewDate = _parseDate(record?['reviewDate']);
  }

  String _value(Map<String, dynamic>? record, String key) {
    return record?[key]?.toString() ?? '';
  }

  int _parseRating(dynamic value, int fallback) {
    final parsed = int.tryParse(value?.toString() ?? '');
    if (parsed == null || parsed < 1 || parsed > 5) {
      return fallback;
    }
    return parsed;
  }

  String _riskLevel(int score) {
    if (score <= 4) return 'Low';
    if (score <= 11) return 'Medium';
    if (score <= 19) return 'High';
    return 'Critical';
  }

  int _score(int likelihood, int severity) {
    return likelihood * severity;
  }

  @override
  void dispose() {
    _riskNoController.dispose();
    _projectController.dispose();
    _locationController.dispose();
    _activityController.dispose();
    _hazardController.dispose();
    _consequenceController.dispose();
    _existingControlsController.dispose();
    _additionalControlsController.dispose();
    _actionOwnerController.dispose();
    _referenceController.dispose();
    _remarksController.dispose();
    super.dispose();
  }

  DateTime? _parseDate(dynamic value) {
    if (value == null || value.toString().trim().isEmpty) {
      return null;
    }
    return DateTime.tryParse(value.toString());
  }

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    return '$day/$month/${date.year}';
  }

  Future<void> _pickDate({
    required bool target,
  }) async {
    final current = target ? _targetDate : _reviewDate;

    final selected = await showDatePicker(
      context: context,
      initialDate: current ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (selected == null) return;

    setState(() {
      if (target) {
        _targetDate = selected;
      } else {
        _reviewDate = selected;
      }
    });
  }

  InputDecoration _decoration(
    String label, {
    IconData? icon,
    String? hint,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: icon == null ? null : Icon(icon),
      border: const OutlineInputBorder(),
      filled: true,
      fillColor: Colors.grey.shade50,
      alignLabelWithHint: true,
    );
  }

  String? _requiredValidator(
    String? value,
    String fieldName,
  ) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  Widget _sectionTitle(
    String title,
    IconData icon,
  ) {
    return Padding(
      padding: const EdgeInsets.only(top: 18, bottom: 9),
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
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: darkGreen,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _field(
    TextEditingController controller,
    String label, {
    IconData? icon,
    String? hint,
    int maxLines = 1,
    bool required = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 11),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        textCapitalization: TextCapitalization.sentences,
        decoration: _decoration(
          label,
          icon: icon,
          hint: hint,
        ),
        validator: required
            ? (value) => _requiredValidator(value, label)
            : null,
      ),
    );
  }

  Widget _dropdown(
    String label,
    String value,
    List<String> items,
    ValueChanged<String?> onChanged, {
    IconData? icon,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 11),
      child: DropdownButtonFormField<String>(
        initialValue: value,
        decoration: _decoration(
          label,
          icon: icon,
        ),
        items: items
            .map(
              (item) => DropdownMenuItem<String>(
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

  Widget _ratingDropdown(
    String label,
    int value,
    ValueChanged<int?> onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 11),
      child: DropdownButtonFormField<int>(
        initialValue: value,
        decoration: _decoration(
          label,
          icon: Icons.speed_outlined,
        ),
        items: List.generate(
          5,
          (index) {
            final rating = index + 1;
            return DropdownMenuItem<int>(
              value: rating,
              child: Text('$rating'),
            );
          },
        ),
        onChanged: onChanged,
      ),
    );
  }

  Widget _riskResult(
    String title,
    int likelihood,
    int severity,
  ) {
    final score = _score(likelihood, severity);
    final level = _riskLevel(score);

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 11),
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: _riskColor(level).withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _riskColor(level).withValues(alpha: 0.30),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.assessment_outlined,
            color: _riskColor(level),
          ),
          const SizedBox(width: 9),
          Expanded(
            child: Text(
              '$title: Score $score',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Text(
            level,
            style: TextStyle(
              color: _riskColor(level),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Color _riskColor(String level) {
    switch (level) {
      case 'Low':
        return primaryGreen;
      case 'Medium':
        return Colors.orange.shade700;
      case 'High':
        return Colors.deepOrange;
      case 'Critical':
        return Colors.red.shade700;
      default:
        return Colors.grey.shade700;
    }
  }

  Widget _dateField(
    String label,
    DateTime? value,
    VoidCallback onTap,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 11),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(4),
        child: InputDecorator(
          decoration: _decoration(
            label,
            icon: Icons.event_outlined,
          ),
          child: Text(
            value == null
                ? 'Select date'
                : _formatDate(value),
            style: TextStyle(
              color: value == null
                  ? Colors.grey.shade600
                  : Colors.grey.shade900,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    final initialScore =
        _score(_initialLikelihood, _initialSeverity);
    final residualScore =
        _score(_residualLikelihood, _residualSeverity);

    final calculatedInitialLevel = _riskLevel(initialScore);
    final calculatedResidualLevel = _riskLevel(residualScore);

    if (_status == 'Completed' && _targetDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Completed action should have a target date.',
          ),
        ),
      );
      return;
    }

    setState(() {
      _saving = true;
    });

    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(
      'safenexus_hse_risk_control_action_register',
    );

    List<Map<String, dynamic>> records = [];

    if (raw != null && raw.isNotEmpty) {
      try {
        final decoded = jsonDecode(raw);
        if (decoded is List) {
          records = decoded
              .whereType<Map>()
              .map(
                (item) => Map<String, dynamic>.from(
                  item.map(
                    (key, value) => MapEntry(
                      key.toString(),
                      value,
                    ),
                  ),
                ),
              )
              .toList();
        }
      } catch (_) {
        records = [];
      }
    }

    final now = DateTime.now().toIso8601String();
    final existing = widget.existingRecord;

    final record = <String, dynamic>{
      'id': existing?['id'] ??
          '${DateTime.now().microsecondsSinceEpoch}',
      'riskNo': _riskNoController.text.trim(),
      'project': _projectController.text.trim(),
      'location': _locationController.text.trim(),
      'department': _department,
      'activity': _activityController.text.trim(),
      'hazardCategory': _hazardCategory,
      'hazard': _hazardController.text.trim(),
      'consequence': _consequenceController.text.trim(),
      'existingControls':
          _existingControlsController.text.trim(),
      'initialLikelihood': _initialLikelihood,
      'initialSeverity': _initialSeverity,
      'initialScore': initialScore,
      'initialRiskLevel': calculatedInitialLevel,
      'additionalControls':
          _additionalControlsController.text.trim(),
      'actionOwner': _actionOwnerController.text.trim(),
      'targetDate': _targetDate?.toIso8601String(),
      'residualLikelihood': _residualLikelihood,
      'residualSeverity': _residualSeverity,
      'residualScore': residualScore,
      'residualRiskLevel': calculatedResidualLevel,
      'reviewDate': _reviewDate?.toIso8601String(),
      'reference': _referenceController.text.trim(),
      'status': _status,
      'remarks': _remarksController.text.trim(),
      'createdAt': existing?['createdAt'] ?? now,
      'updatedAt': now,
    };

    final existingIndex = existing == null
        ? -1
        : records.indexWhere(
            (item) => item['id'] == existing['id'],
          );

    if (existingIndex >= 0) {
      records[existingIndex] = record;
    } else {
      records.add(record);
    }

    await prefs.setString(
      'safenexus_hse_risk_control_action_register',
      jsonEncode(records),
    );

    if (!mounted) return;

    setState(() {
      _saving = false;
    });

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return SafeArea(
      top: false,
      child: Container(
        height: MediaQuery.sizeOf(context).height * 0.94,
        decoration: const BoxDecoration(
          color: Colors.white,
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
                color: darkGreen,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(22),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _isEditing
                          ? 'Edit Risk Record'
                          : 'Add Risk Record',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: _saving
                        ? null
                        : () => Navigator.pop(context),
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
                    16,
                    4,
                    16,
                    24 + bottomInset,
                  ),
                  children: [
                    _sectionTitle(
                      '1. Risk Identification',
                      Icons.warning_amber_outlined,
                    ),
                    _field(
                      _riskNoController,
                      'Risk Register No.',
                      hint: 'Example: RISK-001',
                      icon: Icons.numbers,
                      required: true,
                    ),
                    _field(
                      _projectController,
                      'Project',
                      icon: Icons.business_outlined,
                    ),
                    _field(
                      _locationController,
                      'Location / Work Area',
                      icon: Icons.location_on_outlined,
                    ),
                    _dropdown(
                      'Department / Work Group',
                      _department,
                      widget.departments,
                      (value) {
                        if (value == null) return;
                        setState(() {
                          _department = value;
                        });
                      },
                      icon: Icons.groups_outlined,
                    ),
                    _field(
                      _activityController,
                      'Activity / Task',
                      icon: Icons.work_outline,
                      required: true,
                    ),
                    _dropdown(
                      'Hazard Category',
                      _hazardCategory,
                      widget.hazardCategories,
                      (value) {
                        if (value == null) return;
                        setState(() {
                          _hazardCategory = value;
                        });
                      },
                      icon: Icons.category_outlined,
                    ),
                    _field(
                      _hazardController,
                      'Hazard',
                      icon: Icons.warning_outlined,
                      maxLines: 4,
                      required: true,
                    ),
                    _field(
                      _consequenceController,
                      'Risk / Potential Consequence',
                      icon: Icons.report_problem_outlined,
                      maxLines: 4,
                      required: true,
                    ),

                    _sectionTitle(
                      '2. Existing Controls & Initial Risk',
                      Icons.shield_outlined,
                    ),
                    _field(
                      _existingControlsController,
                      'Existing Control Measures',
                      icon: Icons.security_outlined,
                      maxLines: 6,
                      required: true,
                    ),
                    _ratingDropdown(
                      'Initial Likelihood (1-5)',
                      _initialLikelihood,
                      (value) {
                        if (value == null) return;
                        setState(() {
                          _initialLikelihood = value;
                        });
                      },
                    ),
                    _ratingDropdown(
                      'Initial Severity (1-5)',
                      _initialSeverity,
                      (value) {
                        if (value == null) return;
                        setState(() {
                          _initialSeverity = value;
                        });
                      },
                    ),
                    _riskResult(
                      'Initial Risk',
                      _initialLikelihood,
                      _initialSeverity,
                    ),

                    _sectionTitle(
                      '3. Additional Controls & Action',
                      Icons.rule_outlined,
                    ),
                    _field(
                      _additionalControlsController,
                      'Additional Control Measures',
                      icon: Icons.add_task_outlined,
                      maxLines: 7,
                      required: true,
                    ),
                    _field(
                      _actionOwnerController,
                      'Action Owner',
                      icon: Icons.person_outline,
                      required: true,
                    ),
                    _dateField(
                      'Target / Action Due Date',
                      _targetDate,
                      () => _pickDate(target: true),
                    ),

                    _sectionTitle(
                      '4. Residual Risk',
                      Icons.assessment_outlined,
                    ),
                    _ratingDropdown(
                      'Residual Likelihood (1-5)',
                      _residualLikelihood,
                      (value) {
                        if (value == null) return;
                        setState(() {
                          _residualLikelihood = value;
                        });
                      },
                    ),
                    _ratingDropdown(
                      'Residual Severity (1-5)',
                      _residualSeverity,
                      (value) {
                        if (value == null) return;
                        setState(() {
                          _residualSeverity = value;
                        });
                      },
                    ),
                    _riskResult(
                      'Residual Risk',
                      _residualLikelihood,
                      _residualSeverity,
                    ),

                    _sectionTitle(
                      '5. Review & Status',
                      Icons.fact_check_outlined,
                    ),
                    _dateField(
                      'Review Date',
                      _reviewDate,
                      () => _pickDate(target: false),
                    ),
                    _field(
                      _referenceController,
                      'Reference / Related HIRA / JSA / RAMS',
                      hint: 'Example: HIRA-001, JSA-001, RAMS-001',
                      icon: Icons.link_outlined,
                    ),
                    _dropdown(
                      'Status',
                      _status,
                      widget.statuses,
                      (value) {
                        if (value == null) return;
                        setState(() {
                          _status = value;
                        });
                      },
                      icon: Icons.flag_outlined,
                    ),
                    _field(
                      _remarksController,
                      'Remarks / Additional Information',
                      icon: Icons.notes_outlined,
                      maxLines: 5,
                    ),

                    const SizedBox(height: 12),
                    SizedBox(
                      height: 50,
                      child: FilledButton.icon(
                        onPressed: _saving ? null : _save,
                        style: FilledButton.styleFrom(
                          backgroundColor: primaryGreen,
                          foregroundColor: Colors.white,
                        ),
                        icon: _saving
                            ? const SizedBox(
                                width: 19,
                                height: 19,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Icon(Icons.save_outlined),
                        label: Text(
                          _saving
                              ? 'Saving...'
                              : _isEditing
                                  ? 'Update Risk'
                                  : 'Save Risk',
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
}
