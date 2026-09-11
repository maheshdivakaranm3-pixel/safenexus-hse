import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RamsMethodStatementPage extends StatefulWidget {
  const RamsMethodStatementPage({super.key});

  @override
  State<RamsMethodStatementPage> createState() =>
      _RamsMethodStatementPageState();
}

class _RamsMethodStatementPageState extends State<RamsMethodStatementPage> {
  static const String _storageKey = 'safenexus_hse_rams_method_statements';

  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);

  final TextEditingController _searchController = TextEditingController();

  List<Map<String, dynamic>> _records = [];
  String _statusFilter = 'All';
  bool _loading = true;

  static const List<String> _statuses = <String>[
    'Draft',
    'Under Review',
    'Approved',
    'Active',
    'Revision Required',
    'Superseded',
    'Closed',
    'Cancelled',
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

  static const List<String> _permitTypes = <String>[
    'Not Required',
    'Permit to Work',
    'Hot Work Permit',
    'Cold Work Permit',
    'Work at Height Permit',
    'Confined Space Entry Permit',
    'Excavation Permit',
    'Lifting Permit',
    'Electrical Isolation / LOTO',
    'Road / Traffic Permit',
    'Other',
  ];

  static const List<String> _competencyLevels = <String>[
    'Not Specified',
    'Induction Required',
    'Trained',
    'Competent',
    'Authorized / Certified',
    'Competent Person Required',
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

  void _refresh() {
    if (mounted) setState(() {});
  }

  Future<void> _loadRecords() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_storageKey);

    if (raw != null && raw.isNotEmpty) {
      try {
        final decoded = jsonDecode(raw);
        if (decoded is List) {
          _records = decoded
              .whereType<Map>()
              .map(
                (item) => Map<String, dynamic>.from(
                  item.map((key, value) => MapEntry(key.toString(), value)),
                ),
              )
              .toList();
        }
      } catch (_) {
        _records = [];
      }
    }

    if (mounted) {
      setState(() {
        _loading = false;
      });
    }
  }

  Future<void> _saveRecords() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_storageKey, jsonEncode(_records));
  }

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    return '$day/$month/${date.year}';
  }

  DateTime? _parseDate(dynamic value) {
    if (value == null || value.toString().trim().isEmpty) return null;
    return DateTime.tryParse(value.toString());
  }

  String _text(dynamic value) {
    final text = value?.toString() ?? '';
    return text.trim();
  }

  bool _isOverdue(Map<String, dynamic> record) {
    final reviewDate = _parseDate(record['reviewDate']);
    if (reviewDate == null) return false;

    final status = _text(record['status']);
    if (status == 'Closed' || status == 'Cancelled' || status == 'Superseded') {
      return false;
    }

    final today = DateTime.now();
    final dateOnly = DateTime(
      reviewDate.year,
      reviewDate.month,
      reviewDate.day,
    );
    final todayOnly = DateTime(today.year, today.month, today.day);

    return dateOnly.isBefore(todayOnly);
  }

  List<Map<String, dynamic>> get _filteredRecords {
    final query = _searchController.text.trim().toLowerCase();

    final result = _records.where((record) {
      final status = _text(record['status']);
      if (_statusFilter != 'All' && status != _statusFilter) {
        return false;
      }

      if (query.isEmpty) return true;

      final searchable = <String>[
        _text(record['ramsNo']),
        _text(record['project']),
        _text(record['location']),
        _text(record['department']),
        _text(record['activity']),
        _text(record['scope']),
        _text(record['hazards']),
        _text(record['controls']),
        _text(record['responsiblePerson']),
        _text(record['status']),
        _text(record['remarks']),
      ].join(' ').toLowerCase();

      return searchable.contains(query);
    }).toList();

    result.sort((a, b) {
      final aUpdated = _text(a['updatedAt']);
      final bUpdated = _text(b['updatedAt']);
      return bUpdated.compareTo(aUpdated);
    });

    return result;
  }

  int get _totalCount => _records.length;

  int get _draftCount =>
      _records.where((record) => record['status'] == 'Draft').length;

  int get _underReviewCount =>
      _records.where((record) => record['status'] == 'Under Review').length;

  int get _approvedCount => _records
      .where((record) => record['status'] == 'Approved')
      .length;

  int get _activeCount =>
      _records.where((record) => record['status'] == 'Active').length;

  int get _revisionRequiredCount => _records
      .where((record) => record['status'] == 'Revision Required')
      .length;

  int get _overdueCount => _records.where(_isOverdue).length;

  Future<void> _deleteRecord(Map<String, dynamic> record) async {
    final ramsNo = _text(record['ramsNo']).isEmpty
        ? 'this RAMS'
        : _text(record['ramsNo']);

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Delete RAMS?'),
          content: Text('Delete $ramsNo permanently?'),
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

    if (mounted) {
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('RAMS deleted successfully')),
      );
    }
  }

  Future<void> _openForm({Map<String, dynamic>? existingRecord}) async {
    final saved = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _RamsFormSheet(
        existingRecord: existingRecord,
        statuses: _statuses,
        departments: _departments,
        hazardCategories: _hazardCategories,
        permitTypes: _permitTypes,
        competencyLevels: _competencyLevels,
      ),
    );

    if (saved != true || !mounted) return;

    await _loadRecords();
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'Active':
        return primaryGreen;
      case 'Approved':
        return darkGreen;
      case 'Under Review':
        return Colors.orange.shade700;
      case 'Revision Required':
        return Colors.deepOrange;
      case 'Draft':
        return Colors.blueGrey;
      case 'Closed':
        return Colors.grey.shade700;
      case 'Superseded':
        return Colors.indigo;
      case 'Cancelled':
        return Colors.red.shade700;
      default:
        return Colors.grey;
    }
  }

  Widget _summaryCard(String title, int value, IconData icon) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: primaryGreen.withValues(alpha: 0.10),
              child: Icon(icon, color: primaryGreen, size: 21),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
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

  Widget _buildRecordCard(Map<String, dynamic> record) {
    final status = _text(record['status']).isEmpty
        ? 'Draft'
        : _text(record['status']);
    final overdue = _isOverdue(record);
    final reviewDate = _parseDate(record['reviewDate']);

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
                    _text(record['ramsNo']).isEmpty
                        ? 'RAMS'
                        : _text(record['ramsNo']),
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: darkGreen,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 9,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: _statusColor(status).withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: _statusColor(status),
                    ),
                  ),
                ),
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
              _text(record['activity']).isEmpty
                  ? 'Activity / Scope not specified'
                  : _text(record['activity']),
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            if (_text(record['project']).isNotEmpty)
              _infoRow(Icons.business, 'Project', _text(record['project'])),
            if (_text(record['location']).isNotEmpty)
              _infoRow(Icons.location_on_outlined, 'Location',
                  _text(record['location'])),
            if (_text(record['department']).isNotEmpty)
              _infoRow(Icons.groups_outlined, 'Department',
                  _text(record['department'])),
            if (_text(record['responsiblePerson']).isNotEmpty)
              _infoRow(Icons.person_outline, 'Responsible',
                  _text(record['responsiblePerson'])),
            if (_text(record['issueRevision']).isNotEmpty)
              _infoRow(Icons.history, 'Issue / Revision',
                  _text(record['issueRevision'])),
            if (reviewDate != null)
              _infoRow(
                overdue ? Icons.warning_amber_rounded : Icons.event_outlined,
                'Review Date',
                '${_formatDate(reviewDate)}${overdue ? ' 鈥� OVERDUE' : ''}',
                valueColor: overdue ? Colors.red.shade700 : null,
              ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 7,
              runSpacing: 7,
              children: [
                if (_text(record['requiredPermit']).isNotEmpty &&
                    _text(record['requiredPermit']) != 'Not Required')
                  _smallTag(
                    'Permit: ${_text(record['requiredPermit'])}',
                    Colors.orange,
                  ),
                if (_text(record['competencyLevel']).isNotEmpty &&
                    _text(record['competencyLevel']) != 'Not Specified')
                  _smallTag(
                    'Competency: ${_text(record['competencyLevel'])}',
                    primaryGreen,
                  ),
              ],
            ),
            if (_text(record['createdAt']).isNotEmpty ||
                _text(record['updatedAt']).isNotEmpty) ...[
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
          ],
        ),
      ),
    );
  }

  Widget _smallTag(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10.5,
          color: color,
          fontWeight: FontWeight.w600,
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
          Icon(icon, size: 17, color: Colors.grey.shade600),
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
    if (value == null || value.toString().isEmpty) return '-';
    final parsed = DateTime.tryParse(value.toString());
    if (parsed == null) return value.toString();

    final date = _formatDate(parsed);
    final hour = parsed.hour.toString().padLeft(2, '0');
    final minute = parsed.minute.toString().padLeft(2, '0');
    return '$date $hour:$minute';
  }

  @override
  Widget build(BuildContext context) {
    final records = _filteredRecords;

    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        title: const Text('RAMS / Method Statement'),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openForm(),
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Add RAMS'),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadRecords,
              child: ListView(
                padding: const EdgeInsets.fromLTRB(14, 14, 14, 100),
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
                            'RAMS Register',
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              color: darkGreen,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Risk Assessment & Method Statement control',
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
                                  'Search RAMS, project, activity, location...',
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
                              const DropdownMenuItem(
                                value: 'All',
                                child: Text('All'),
                              ),
                              ..._statuses.map(
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
                        Icons.description_outlined,
                      ),
                      _summaryCard(
                        'Active',
                        _activeCount,
                        Icons.play_circle_outline,
                      ),
                      _summaryCard(
                        'Under Review',
                        _underReviewCount,
                        Icons.rate_review_outlined,
                      ),
                      _summaryCard(
                        'Approved',
                        _approvedCount,
                        Icons.verified_outlined,
                      ),
                      _summaryCard(
                        'Draft',
                        _draftCount,
                        Icons.edit_note_outlined,
                      ),
                      _summaryCard(
                        'Revision Required',
                        _revisionRequiredCount,
                        Icons.sync_problem_outlined,
                      ),
                      _summaryCard(
                        'Overdue',
                        _overdueCount,
                        Icons.warning_amber_rounded,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'RAMS Records',
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
                              Icons.description_outlined,
                              size: 48,
                              color: Colors.grey.shade400,
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'No RAMS records found',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              _records.isEmpty
                                  ? 'Tap Add RAMS to create the first record.'
                                  : 'Try changing the search or filter.',
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

class _RamsFormSheet extends StatefulWidget {
  final Map<String, dynamic>? existingRecord;
  final List<String> statuses;
  final List<String> departments;
  final List<String> hazardCategories;
  final List<String> permitTypes;
  final List<String> competencyLevels;

  const _RamsFormSheet({
    required this.existingRecord,
    required this.statuses,
    required this.departments,
    required this.hazardCategories,
    required this.permitTypes,
    required this.competencyLevels,
  });

  @override
  State<_RamsFormSheet> createState() => _RamsFormSheetState();
}

class _RamsFormSheetState extends State<_RamsFormSheet> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);

  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _ramsNoController;
  late final TextEditingController _projectController;
  late final TextEditingController _locationController;
  late final TextEditingController _activityController;
  late final TextEditingController _scopeController;
  late final TextEditingController _methodController;
  late final TextEditingController _hazardsController;
  late final TextEditingController _hiraReferenceController;
  late final TextEditingController _jsaReferenceController;
  late final TextEditingController _controlsController;
  late final TextEditingController _ppeController;
  late final TextEditingController _equipmentController;
  late final TextEditingController _emergencyController;
  late final TextEditingController _environmentController;
  late final TextEditingController _inspectionController;
  late final TextEditingController _responsibleController;
  late final TextEditingController _preparedByController;
  late final TextEditingController _reviewedByController;
  late final TextEditingController _approvedByController;
  late final TextEditingController _issueRevisionController;
  late final TextEditingController _remarksController;

  String? _department;
  String _hazardCategory = 'General';
  String _competencyLevel = 'Not Specified';
  String _requiredPermit = 'Not Required';
  String _status = 'Draft';
  DateTime? _reviewDate;

  bool _saving = false;

  bool get _isEditing => widget.existingRecord != null;

  @override
  void initState() {
    super.initState();

    final record = widget.existingRecord;

    _ramsNoController =
        TextEditingController(text: _value(record, 'ramsNo'));
    _projectController =
        TextEditingController(text: _value(record, 'project'));
    _locationController =
        TextEditingController(text: _value(record, 'location'));
    _activityController =
        TextEditingController(text: _value(record, 'activity'));
    _scopeController =
        TextEditingController(text: _value(record, 'scope'));
    _methodController =
        TextEditingController(text: _value(record, 'method'));
    _hazardsController =
        TextEditingController(text: _value(record, 'hazards'));
    _hiraReferenceController =
        TextEditingController(text: _value(record, 'hiraReference'));
    _jsaReferenceController =
        TextEditingController(text: _value(record, 'jsaReference'));
    _controlsController =
        TextEditingController(text: _value(record, 'controls'));
    _ppeController =
        TextEditingController(text: _value(record, 'ppe'));
    _equipmentController =
        TextEditingController(text: _value(record, 'equipment'));
    _emergencyController =
        TextEditingController(text: _value(record, 'emergency'));
    _environmentController =
        TextEditingController(text: _value(record, 'environment'));
    _inspectionController =
        TextEditingController(text: _value(record, 'inspection'));
    _responsibleController =
        TextEditingController(text: _value(record, 'responsiblePerson'));
    _preparedByController =
        TextEditingController(text: _value(record, 'preparedBy'));
    _reviewedByController =
        TextEditingController(text: _value(record, 'reviewedBy'));
    _approvedByController =
        TextEditingController(text: _value(record, 'approvedBy'));
    _issueRevisionController =
        TextEditingController(text: _value(record, 'issueRevision'));
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

    final savedCompetency = _value(record, 'competencyLevel');
    if (widget.competencyLevels.contains(savedCompetency)) {
      _competencyLevel = savedCompetency;
    }

    final savedPermit = _value(record, 'requiredPermit');
    if (widget.permitTypes.contains(savedPermit)) {
      _requiredPermit = savedPermit;
    }

    final savedStatus = _value(record, 'status');
    if (widget.statuses.contains(savedStatus)) {
      _status = savedStatus;
    }

    _reviewDate = _parseDate(record?['reviewDate']);
  }

  String _value(Map<String, dynamic>? record, String key) {
    return record?[key]?.toString() ?? '';
  }

  DateTime? _parseDate(dynamic value) {
    if (value == null || value.toString().trim().isEmpty) return null;
    return DateTime.tryParse(value.toString());
  }

  @override
  void dispose() {
    _ramsNoController.dispose();
    _projectController.dispose();
    _locationController.dispose();
    _activityController.dispose();
    _scopeController.dispose();
    _methodController.dispose();
    _hazardsController.dispose();
    _hiraReferenceController.dispose();
    _jsaReferenceController.dispose();
    _controlsController.dispose();
    _ppeController.dispose();
    _equipmentController.dispose();
    _emergencyController.dispose();
    _environmentController.dispose();
    _inspectionController.dispose();
    _responsibleController.dispose();
    _preparedByController.dispose();
    _reviewedByController.dispose();
    _approvedByController.dispose();
    _issueRevisionController.dispose();
    _remarksController.dispose();
    super.dispose();
  }

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    return '$day/$month/${date.year}';
  }

  Future<void> _pickReviewDate() async {
    final selected = await showDatePicker(
      context: context,
      initialDate: _reviewDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (selected != null) {
      setState(() {
        _reviewDate = selected;
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
      prefixIcon: icon == null ? null : Icon(icon),
      border: const OutlineInputBorder(),
      filled: true,
      fillColor: Colors.grey.shade50,
      alignLabelWithHint: true,
    );
  }

  String? _requiredValidator(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  Widget _sectionTitle(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(top: 18, bottom: 9),
      child: Row(
        children: [
          Icon(icon, color: primaryGreen, size: 21),
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
    String? hint,
    IconData? icon,
    int maxLines = 1,
    TextInputType? keyboardType,
    bool required = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 11),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: keyboardType,
        textCapitalization: TextCapitalization.sentences,
        decoration: _decoration(label, hint: hint, icon: icon),
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
        decoration: _decoration(label, icon: icon),
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

  Widget _dateField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 11),
      child: InkWell(
        onTap: _pickReviewDate,
        borderRadius: BorderRadius.circular(4),
        child: InputDecorator(
          decoration: _decoration(
            'Review / Valid Until',
            icon: Icons.event_outlined,
          ),
          child: Text(
            _reviewDate == null
                ? 'Select review date'
                : _formatDate(_reviewDate!),
            style: TextStyle(
              color: _reviewDate == null
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

    if (_status == 'Approved' &&
        (_reviewedByController.text.trim().isEmpty ||
            _approvedByController.text.trim().isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Approved RAMS requires Reviewed By and Approved By.',
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
      'safenexus_hse_rams_method_statements',
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
                    (key, value) => MapEntry(key.toString(), value),
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
      'ramsNo': _ramsNoController.text.trim(),
      'project': _projectController.text.trim(),
      'location': _locationController.text.trim(),
      'department': _department ?? '',
      'activity': _activityController.text.trim(),
      'scope': _scopeController.text.trim(),
      'method': _methodController.text.trim(),
      'hazardCategory': _hazardCategory,
      'hazards': _hazardsController.text.trim(),
      'hiraReference': _hiraReferenceController.text.trim(),
      'jsaReference': _jsaReferenceController.text.trim(),
      'controls': _controlsController.text.trim(),
      'competencyLevel': _competencyLevel,
      'ppe': _ppeController.text.trim(),
      'requiredPermit': _requiredPermit,
      'equipment': _equipmentController.text.trim(),
      'emergency': _emergencyController.text.trim(),
      'environment': _environmentController.text.trim(),
      'inspection': _inspectionController.text.trim(),
      'responsiblePerson': _responsibleController.text.trim(),
      'preparedBy': _preparedByController.text.trim(),
      'reviewedBy': _reviewedByController.text.trim(),
      'approvedBy': _approvedByController.text.trim(),
      'issueRevision': _issueRevisionController.text.trim(),
      'reviewDate': _reviewDate?.toIso8601String(),
      'status': _status,
      'remarks': _remarksController.text.trim(),
      'createdAt': existing?['createdAt'] ?? now,
      'updatedAt': now,
    };

    final existingIndex = existing == null
        ? -1
        : records.indexWhere((item) => item['id'] == existing['id']);

    if (existingIndex >= 0) {
      records[existingIndex] = record;
    } else {
      records.add(record);
    }

    await prefs.setString(
      'safenexus_hse_rams_method_statements',
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
              padding: const EdgeInsets.fromLTRB(18, 12, 8, 12),
              decoration: BoxDecoration(
                color: darkGreen,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(22),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _isEditing ? 'Edit RAMS' : 'Add RAMS',
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
                      '1. RAMS Identification',
                      Icons.badge_outlined,
                    ),
                    _field(
                      _ramsNoController,
                      'RAMS No.',
                      hint: 'Example: RAMS-001',
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
                      _department ?? widget.departments.first,
                      widget.departments,
                      (value) => setState(() {
                        _department = value;
                      }),
                      icon: Icons.groups_outlined,
                    ),
                    _field(
                      _activityController,
                      'Activity / Work Title',
                      icon: Icons.work_outline,
                      required: true,
                    ),
                    _field(
                      _scopeController,
                      'Scope of Work',
                      icon: Icons.subject_outlined,
                      maxLines: 4,
                      required: true,
                    ),
                    _dropdown(
                      'Status',
                      _status,
                      widget.statuses,
                      (value) => setState(() {
                        _status = value ?? 'Draft';
                      }),
                      icon: Icons.flag_outlined,
                    ),

                    _sectionTitle(
                      '2. Method & Work Sequence',
                      Icons.format_list_numbered,
                    ),
                    _field(
                      _methodController,
                      'Method / Work Sequence',
                      hint: 'Describe the safe step-by-step work method.',
                      icon: Icons.alt_route,
                      maxLines: 7,
                      required: true,
                    ),

                    _sectionTitle(
                      '3. Hazards & Risk References',
                      Icons.warning_amber_rounded,
                    ),
                    _dropdown(
                      'Hazard Category',
                      _hazardCategory,
                      widget.hazardCategories,
                      (value) => setState(() {
                        _hazardCategory = value ?? 'General';
                      }),
                      icon: Icons.category_outlined,
                    ),
                    _field(
                      _hazardsController,
                      'Hazards / Risks',
                      icon: Icons.warning_outlined,
                      maxLines: 5,
                      required: true,
                    ),
                    _field(
                      _hiraReferenceController,
                      'HIRA Reference',
                      hint: 'Example: HIRA-001',
                      icon: Icons.fact_check_outlined,
                    ),
                    _field(
                      _jsaReferenceController,
                      'JSA / JHA Reference',
                      hint: 'Example: JSA-001',
                      icon: Icons.assignment_outlined,
                    ),
                    _field(
                      _controlsController,
                      'Control Measures',
                      icon: Icons.shield_outlined,
                      maxLines: 7,
                      required: true,
                    ),

                    _sectionTitle(
                      '4. Competency, PPE & Permit',
                      Icons.engineering_outlined,
                    ),
                    _dropdown(
                      'Required Competency / Training',
                      _competencyLevel,
                      widget.competencyLevels,
                      (value) => setState(() {
                        _competencyLevel =
                            value ?? 'Not Specified';
                      }),
                      icon: Icons.school_outlined,
                    ),
                    _field(
                      _ppeController,
                      'Required PPE',
                      hint: 'Example: Helmet, safety shoes, gloves...',
                      icon: Icons.health_and_safety_outlined,
                      maxLines: 3,
                    ),
                    _dropdown(
                      'Required Permit',
                      _requiredPermit,
                      widget.permitTypes,
                      (value) => setState(() {
                        _requiredPermit =
                            value ?? 'Not Required';
                      }),
                      icon: Icons.approval_outlined,
                    ),
                    _field(
                      _equipmentController,
                      'Equipment / Tools',
                      icon: Icons.construction_outlined,
                      maxLines: 4,
                    ),

                    _sectionTitle(
                      '5. Emergency & Environmental Controls',
                      Icons.emergency_outlined,
                    ),
                    _field(
                      _emergencyController,
                      'Emergency / Rescue Arrangements',
                      icon: Icons.emergency_share_outlined,
                      maxLines: 5,
                    ),
                    _field(
                      _environmentController,
                      'Environmental Controls',
                      icon: Icons.eco_outlined,
                      maxLines: 5,
                    ),
                    _field(
                      _inspectionController,
                      'Inspection / Hold Points',
                      icon: Icons.rule_outlined,
                      maxLines: 5,
                    ),

                    _sectionTitle(
                      '6. Responsibility & Approval',
                      Icons.approval_outlined,
                    ),
                    _field(
                      _responsibleController,
                      'Responsible Person',
                      icon: Icons.person_outline,
                      required: true,
                    ),
                    _field(
                      _preparedByController,
                      'Prepared By',
                      icon: Icons.edit_note_outlined,
                    ),
                    _field(
                      _reviewedByController,
                      'Reviewed By',
                      icon: Icons.rate_review_outlined,
                    ),
                    _field(
                      _approvedByController,
                      'Approved By',
                      icon: Icons.verified_outlined,
                    ),
                    _field(
                      _issueRevisionController,
                      'Issue / Revision',
                      hint: 'Example: Rev. 00',
                      icon: Icons.history,
                    ),
                    _dateField(),

                    _sectionTitle(
                      '7. Remarks & Record History',
                      Icons.notes_outlined,
                    ),
                    _field(
                      _remarksController,
                      'Remarks / Additional Requirements',
                      icon: Icons.notes,
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
                                  ? 'Update RAMS'
                                  : 'Save RAMS',
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
