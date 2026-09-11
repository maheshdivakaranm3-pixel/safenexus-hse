import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RiskAssessmentReviewApprovalPage extends StatefulWidget {
  const RiskAssessmentReviewApprovalPage({
    super.key,
  });

  @override
  State<RiskAssessmentReviewApprovalPage> createState() =>
      _RiskAssessmentReviewApprovalPageState();
}

class _RiskAssessmentReviewApprovalPageState
    extends State<RiskAssessmentReviewApprovalPage> {
  static const String _storageKey =
      'safenexus_hse_risk_assessment_review_approval';

  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);

  final List<String> _documentTypes = const [
    'HIRA',
    'JSA / JHA',
    'RAMS',
    'Risk Control Action',
  ];

  final List<String> _reviewTriggers = const [
    'Scheduled Review',
    'New Activity',
    'Change in Scope',
    'Change in Method',
    'New Hazard',
    'Incident / Near Miss',
    'Regulatory Change',
    'Client Requirement',
    'Audit Finding',
    'Corrective Action',
    'Other',
  ];

  final List<String> _statuses = const [
    'Pending Review',
    'Under Review',
    'Changes Required',
    'Approved',
    'Rejected',
    'Closed',
  ];

  List<Map<String, dynamic>> _records = [];
  String _searchText = '';
  String _statusFilter = 'All';
  String _documentFilter = 'All';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadRecords();
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
                (item) => Map<String, dynamic>.from(item),
              )
              .toList();
        }
      } catch (_) {
        _records = [];
      }
    }

    if (!mounted) return;

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _saveRecords() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(
      _storageKey,
      jsonEncode(_records),
    );
  }

  String _value(
    Map<String, dynamic> record,
    String key,
  ) {
    final value = record[key];

    if (value == null) {
      return '';
    }

    return value.toString();
  }

  DateTime? _parseDate(String value) {
    if (value.isEmpty) {
      return null;
    }

    return DateTime.tryParse(value);
  }

  String _formatDate(String value) {
    final date = _parseDate(value);

    if (date == null) {
      return '-';
    }

    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }

  String _formatDateTime(String value) {
    final date = _parseDate(value);

    if (date == null) {
      return '-';
    }

    return '${_formatDate(value)} '
        '${date.hour.toString().padLeft(2, '0')}:'
        '${date.minute.toString().padLeft(2, '0')}';
  }

  List<Map<String, dynamic>> get _filteredRecords {
    final query = _searchText.trim().toLowerCase();

    return _records.where((record) {
      final status = _value(record, 'status');
      final documentType = _value(record, 'documentType');

      if (_statusFilter != 'All' && status != _statusFilter) {
        return false;
      }

      if (_documentFilter != 'All' &&
          documentType != _documentFilter) {
        return false;
      }

      if (query.isEmpty) {
        return true;
      }

      final searchable = [
        _value(record, 'reviewNo'),
        _value(record, 'project'),
        _value(record, 'location'),
        _value(record, 'department'),
        _value(record, 'activity'),
        _value(record, 'referenceNo'),
        _value(record, 'reviewer'),
        _value(record, 'findings'),
        _value(record, 'requiredChanges'),
        _value(record, 'actionOwner'),
        _value(record, 'approver'),
      ].join(' ').toLowerCase();

      return searchable.contains(query);
    }).toList();
  }

  bool _isOverdue(Map<String, dynamic> record) {
    final status = _value(record, 'status');

    if (status == 'Approved' ||
        status == 'Rejected' ||
        status == 'Closed') {
      return false;
    }

    final today = DateTime.now();

    final todayOnly = DateTime(
      today.year,
      today.month,
      today.day,
    );

    final reviewDate = _parseDate(
      _value(record, 'reviewDate'),
    );

    final actionDueDate = _parseDate(
      _value(record, 'actionDueDate'),
    );

    final reviewOverdue = reviewDate != null &&
        reviewDate.isBefore(todayOnly);

    final actionOverdue = actionDueDate != null &&
        actionDueDate.isBefore(todayOnly);

    return reviewOverdue || actionOverdue;
  }

  int _countStatus(String status) {
    return _records
        .where(
          (record) => _value(record, 'status') == status,
        )
        .length;
  }

  int get _overdueCount {
    return _records.where(_isOverdue).length;
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'Approved':
        return Colors.green;
      case 'Under Review':
        return Colors.blue;
      case 'Changes Required':
        return Colors.orange;
      case 'Rejected':
        return Colors.red;
      case 'Closed':
        return Colors.blueGrey;
      default:
        return Colors.grey;
    }
  }

  Future<void> _openForm({
    Map<String, dynamic>? record,
  }) async {
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return _RiskReviewFormSheet(
          record: record,
          documentTypes: _documentTypes,
          reviewTriggers: _reviewTriggers,
          statuses: _statuses,
        );
      },
    );

    if (result == null) {
      return;
    }

    final now = DateTime.now().toIso8601String();
    final id = _value(result, 'id');

    if (id.isNotEmpty &&
        _records.any(
          (item) => _value(item, 'id') == id,
        )) {
      final index = _records.indexWhere(
        (item) => _value(item, 'id') == id,
      );

      final existing = _records[index];
      final updated = Map<String, dynamic>.from(result);

      updated['createdAt'] = _value(
        existing,
        'createdAt',
      );

      updated['updatedAt'] = now;

      _records[index] = updated;
    } else {
      final created = Map<String, dynamic>.from(result);

      created['id'] =
          DateTime.now().microsecondsSinceEpoch.toString();

      created['createdAt'] = now;
      created['updatedAt'] = now;

      _records.insert(0, created);
    }

    await _saveRecords();

    if (!mounted) return;

    setState(() {});
  }

  Future<void> _deleteRecord(
    Map<String, dynamic> record,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Review Record'),
          content: const Text(
            'Are you sure you want to delete this review record?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(context, true);
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

    final id = _value(record, 'id');

    _records.removeWhere(
      (item) => _value(item, 'id') == id,
    );

    await _saveRecords();

    if (!mounted) return;

    setState(() {});
  }

  Future<void> _showHistory(
    Map<String, dynamic> record,
  ) async {
    await showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Record History'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _historyRow(
                'Created',
                _formatDateTime(
                  _value(record, 'createdAt'),
                ),
              ),
              const SizedBox(height: 10),
              _historyRow(
                'Last Updated',
                _formatDateTime(
                  _value(record, 'updatedAt'),
                ),
              ),
              const SizedBox(height: 10),
              _historyRow(
                'Revision',
                _value(record, 'revisionNo').isEmpty
                    ? '-'
                    : _value(record, 'revisionNo'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Widget _historyRow(
    String label,
    String value,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 105,
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Expanded(
          child: Text(value),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        title: const Text(
          'Risk Review & Approval',
        ),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            tooltip: 'Add Review',
            onPressed: () => _openForm(),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openForm(),
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Add Review'),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: _loadRecords,
              child: ListView(
                padding: const EdgeInsets.fromLTRB(
                  12,
                  12,
                  12,
                  100,
                ),
                children: [
                  _buildHeader(),
                  const SizedBox(height: 12),
                  _buildDashboard(),
                  const SizedBox(height: 12),
                  _buildFilters(),
                  const SizedBox(height: 12),
                  if (_filteredRecords.isEmpty)
                    _buildEmptyState()
                  else
                    ..._filteredRecords.map(
                      _buildRecordCard,
                    ),
                ],
              ),
            ),
    );
  }

  Widget _buildHeader() {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: primaryGreen.withValues(
                  alpha: 0.10,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.fact_check_outlined,
                color: primaryGreen,
                size: 30,
              ),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    'Risk Assessment Review & Approval Register',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Review, revise and approve HIRA, JSA/JHA, RAMS and risk controls.',
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
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _metricCard(
                'Total',
                '${_records.length}',
                Icons.list_alt,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _metricCard(
                'Pending',
                '${_countStatus('Pending Review')}',
                Icons.pending_actions,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _metricCard(
                'Review',
                '${_countStatus('Under Review')}',
                Icons.rate_review_outlined,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: _metricCard(
                'Changes',
                '${_countStatus('Changes Required')}',
                Icons.edit_note,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _metricCard(
                'Approved',
                '${_countStatus('Approved')}',
                Icons.verified_outlined,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _metricCard(
                'Overdue',
                '$_overdueCount',
                Icons.warning_amber_rounded,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _metricCard(
    String title,
    String value,
    IconData icon,
  ) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 6,
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 22,
              color: primaryGreen,
            ),
            const SizedBox(height: 5),
            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 11,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilters() {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  _searchText = value;
                });
              },
              decoration: InputDecoration(
                hintText:
                    'Search review no, project, activity...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchText.isEmpty
                    ? null
                    : IconButton(
                        onPressed: () {
                          setState(() {
                            _searchText = '';
                          });
                        },
                        icon: const Icon(Icons.clear),
                      ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    initialValue: _statusFilter,
                    decoration: const InputDecoration(
                      labelText: 'Status',
                      border: OutlineInputBorder(),
                    ),
                    items: [
                      const DropdownMenuItem(
                        value: 'All',
                        child: Text('All'),
                      ),
                      ..._statuses.map(
                        (item) => DropdownMenuItem(
                          value: item,
                          child: Text(item),
                        ),
                      ),
                    ],
                    onChanged: (value) {
                      if (value == null) return;

                      setState(() {
                        _statusFilter = value;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    initialValue: _documentFilter,
                    decoration: const InputDecoration(
                      labelText: 'Document',
                      border: OutlineInputBorder(),
                    ),
                    items: [
                      const DropdownMenuItem(
                        value: 'All',
                        child: Text('All'),
                      ),
                      ..._documentTypes.map(
                        (item) => DropdownMenuItem(
                          value: item,
                          child: Text(item),
                        ),
                      ),
                    ],
                    onChanged: (value) {
                      if (value == null) return;

                      setState(() {
                        _documentFilter = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            Icon(
              Icons.assignment_turned_in_outlined,
              size: 52,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 12),
            const Text(
              'No review records found',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Add a risk assessment review to start the register.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: () => _openForm(),
              icon: const Icon(Icons.add),
              label: const Text('Add Review'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecordCard(
    Map<String, dynamic> record,
  ) {
    final status = _value(record, 'status');
    final statusColor = _statusColor(status);
    final overdue = _isOverdue(record);

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    _value(record, 'reviewNo').isEmpty
                        ? 'Risk Review'
                        : _value(record, 'reviewNo'),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 9,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(
                      alpha: 0.12,
                    ),
                    borderRadius:
                        BorderRadius.circular(20),
                  ),
                  child: Text(
                    status.isEmpty
                        ? 'Pending Review'
                        : status,
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                _tag(
                  _value(record, 'documentType').isEmpty
                      ? 'Risk Document'
                      : _value(
                          record,
                          'documentType',
                        ),
                  primaryGreen,
                ),
                if (overdue)
                  _tag(
                    'OVERDUE',
                    Colors.red,
                  ),
                if (_value(record, 'revisionNo')
                    .isNotEmpty)
                  _tag(
                    _value(
                      record,
                      'revisionNo',
                    ),
                    Colors.blueGrey,
                  ),
              ],
            ),
            const SizedBox(height: 10),
            _infoRow(
              Icons.business_outlined,
              'Project',
              _value(record, 'project'),
            ),
            _infoRow(
              Icons.location_on_outlined,
              'Location',
              _value(record, 'location'),
            ),
            _infoRow(
              Icons.work_outline,
              'Activity',
              _value(record, 'activity'),
            ),
            _infoRow(
              Icons.link,
              'Reference',
              _value(record, 'referenceNo'),
            ),
            _infoRow(
              Icons.calendar_month_outlined,
              'Review Date',
              _formatDate(
                _value(record, 'reviewDate'),
              ),
            ),
            _infoRow(
              Icons.person_outline,
              'Reviewer',
              _value(record, 'reviewer'),
            ),
            _infoRow(
              Icons.verified_user_outlined,
              'Approver',
              _value(record, 'approver'),
            ),
            if (_value(record, 'findings').isNotEmpty) ...[
              const SizedBox(height: 8),
              _sectionLabel('Review Findings'),
              Text(
                _value(record, 'findings'),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
            if (_value(record, 'requiredChanges')
                .isNotEmpty) ...[
              const SizedBox(height: 8),
              _sectionLabel('Required Changes'),
              Text(
                _value(record, 'requiredChanges'),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _showHistory(record),
                    icon: const Icon(
                      Icons.history,
                      size: 18,
                    ),
                    label: const Text('History'),
                  ),
                ),
                const SizedBox(width: 7),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () =>
                        _openForm(record: record),
                    icon: const Icon(
                      Icons.edit_outlined,
                      size: 18,
                    ),
                    label: const Text('Edit'),
                  ),
                ),
                const SizedBox(width: 4),
                IconButton(
                  tooltip: 'Delete',
                  onPressed: () =>
                      _deleteRecord(record),
                  icon: const Icon(
                    Icons.delete_outline,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _tag(
    String text,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _infoRow(
    IconData icon,
    String label,
    String value,
  ) {
    if (value.isEmpty || value == '-') {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 17,
            color: darkGreen,
          ),
          const SizedBox(width: 7),
          SizedBox(
            width: 78,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.black54,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: darkGreen,
        ),
      ),
    );
  }
}

class _RiskReviewFormSheet extends StatefulWidget {
  final Map<String, dynamic>? record;
  final List<String> documentTypes;
  final List<String> reviewTriggers;
  final List<String> statuses;

  const _RiskReviewFormSheet({
    required this.record,
    required this.documentTypes,
    required this.reviewTriggers,
    required this.statuses,
  });

  @override
  State<_RiskReviewFormSheet> createState() =>
      _RiskReviewFormSheetState();
}

class _RiskReviewFormSheetState
    extends State<_RiskReviewFormSheet> {
  final _formKey = GlobalKey<FormState>();

  final _reviewNoController =
      TextEditingController();
  final _projectController =
      TextEditingController();
  final _locationController =
      TextEditingController();
  final _departmentController =
      TextEditingController();
  final _activityController =
      TextEditingController();
  final _referenceNoController =
      TextEditingController();
  final _reviewerController =
      TextEditingController();
  final _findingsController =
      TextEditingController();
  final _requiredChangesController =
      TextEditingController();
  final _actionOwnerController =
      TextEditingController();
  final _approverController =
      TextEditingController();
  final _remarksController =
      TextEditingController();

  String _documentType = 'HIRA';
  String _reviewTrigger = 'Scheduled Review';
  String _status = 'Pending Review';
  String _revisionNo = 'Rev 0';

  DateTime? _reviewDate;
  DateTime? _actionDueDate;
  DateTime? _approvalDate;

  bool get _isEdit => widget.record != null;

  @override
  void initState() {
    super.initState();

    final record = widget.record;

    if (record == null) {
      _reviewNoController.text =
          'RRA-${DateTime.now().millisecondsSinceEpoch}';

      _reviewDate = DateTime.now();

      return;
    }

    _reviewNoController.text =
        _value(record, 'reviewNo');
    _projectController.text =
        _value(record, 'project');
    _locationController.text =
        _value(record, 'location');
    _departmentController.text =
        _value(record, 'department');
    _activityController.text =
        _value(record, 'activity');
    _referenceNoController.text =
        _value(record, 'referenceNo');
    _reviewerController.text =
        _value(record, 'reviewer');
    _findingsController.text =
        _value(record, 'findings');
    _requiredChangesController.text =
        _value(record, 'requiredChanges');
    _actionOwnerController.text =
        _value(record, 'actionOwner');
    _approverController.text =
        _value(record, 'approver');
    _remarksController.text =
        _value(record, 'remarks');

    final savedDocumentType =
        _value(record, 'documentType');

    if (widget.documentTypes
        .contains(savedDocumentType)) {
      _documentType = savedDocumentType;
    }

    final savedTrigger =
        _value(record, 'reviewTrigger');

    if (widget.reviewTriggers
        .contains(savedTrigger)) {
      _reviewTrigger = savedTrigger;
    }

    final savedStatus =
        _value(record, 'status');

    if (widget.statuses.contains(savedStatus)) {
      _status = savedStatus;
    }

    final savedRevision =
        _value(record, 'revisionNo');

    if (savedRevision.isNotEmpty) {
      _revisionNo = savedRevision;
    }

    _reviewDate = _parseDate(
      _value(record, 'reviewDate'),
    );

    _actionDueDate = _parseDate(
      _value(record, 'actionDueDate'),
    );

    _approvalDate = _parseDate(
      _value(record, 'approvalDate'),
    );
  }

  String _value(
    Map<String, dynamic> record,
    String key,
  ) {
    final value = record[key];

    if (value == null) {
      return '';
    }

    return value.toString();
  }

  DateTime? _parseDate(String value) {
    if (value.isEmpty) {
      return null;
    }

    return DateTime.tryParse(value);
  }

  @override
  void dispose() {
    _reviewNoController.dispose();
    _projectController.dispose();
    _locationController.dispose();
    _departmentController.dispose();
    _activityController.dispose();
    _referenceNoController.dispose();
    _reviewerController.dispose();
    _findingsController.dispose();
    _requiredChangesController.dispose();
    _actionOwnerController.dispose();
    _approverController.dispose();
    _remarksController.dispose();

    super.dispose();
  }

  Future<void> _pickDate({
    required DateTime? current,
    required ValueChanged<DateTime> onSelected,
  }) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: current ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (picked == null || !mounted) {
      return;
    }

    setState(() {
      onSelected(picked);
    });
  }

  String _formatDate(DateTime? date) {
    if (date == null) {
      return 'Not selected';
    }

    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }

  String? _requiredValidator(
    String? value,
    String label,
  ) {
    if (value == null ||
        value.trim().isEmpty) {
      return '$label is required';
    }

    return null;
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_reviewDate == null) {
      _showError(
        'Please select the review date.',
      );
      return;
    }

    if (_status == 'Approved') {
      if (_reviewerController.text.trim().isEmpty) {
        _showError(
          'Reviewer is required for Approved status.',
        );
        return;
      }

      if (_approverController.text.trim().isEmpty) {
        _showError(
          'Approver is required for Approved status.',
        );
        return;
      }

      if (_approvalDate == null) {
        _showError(
          'Approval date is required for Approved status.',
        );
        return;
      }
    }

    if (_status == 'Changes Required' &&
        _requiredChangesController.text
            .trim()
            .isEmpty) {
      _showError(
        'Required changes must be entered when status is Changes Required.',
      );
      return;
    }

    if (_actionDueDate != null &&
        _actionDueDate!.isBefore(_reviewDate!)) {
      _showError(
        'Action due date cannot be before the review date.',
      );
      return;
    }

    final record = <String, dynamic>{
      'id': _isEdit
          ? _value(widget.record!, 'id')
          : '',
      'reviewNo':
          _reviewNoController.text.trim(),
      'project':
          _projectController.text.trim(),
      'location':
          _locationController.text.trim(),
      'department':
          _departmentController.text.trim(),
      'activity':
          _activityController.text.trim(),
      'documentType':
          _documentType,
      'referenceNo':
          _referenceNoController.text.trim(),
      'reviewDate':
          _reviewDate!.toIso8601String(),
      'reviewTrigger':
          _reviewTrigger,
      'reviewer':
          _reviewerController.text.trim(),
      'findings':
          _findingsController.text.trim(),
      'requiredChanges':
          _requiredChangesController.text.trim(),
      'actionOwner':
          _actionOwnerController.text.trim(),
      'actionDueDate':
          _actionDueDate?.toIso8601String() ?? '',
      'approver':
          _approverController.text.trim(),
      'approvalDate':
          _approvalDate?.toIso8601String() ?? '',
      'revisionNo':
          _revisionNo,
      'status':
          _status,
      'remarks':
          _remarksController.text.trim(),
    };

    Navigator.pop(
      context,
      record,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset =
        MediaQuery.viewInsetsOf(context).bottom;

    return SafeArea(
      child: Container(
        height:
            MediaQuery.sizeOf(context).height * 0.94,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(22),
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                16,
                12,
                8,
                8,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _isEdit
                          ? 'Edit Risk Review'
                          : 'Add Risk Review',
                      style: const TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: Form(
                key: _formKey,
                child: ListView(
                  padding: EdgeInsets.fromLTRB(
                    16,
                    16,
                    16,
                    24 + bottomInset,
                  ),
                  children: [
                    _sectionTitle(
                      'Review Identification',
                    ),
                    _textField(
                      controller:
                          _reviewNoController,
                      label: 'Review No.',
                      icon: Icons.numbers,
                      validator: (value) =>
                          _requiredValidator(
                        value,
                        'Review No.',
                      ),
                    ),
                    _textField(
                      controller:
                          _projectController,
                      label: 'Project',
                      icon:
                          Icons.business_outlined,
                    ),
                    _textField(
                      controller:
                          _locationController,
                      label: 'Location',
                      icon: Icons
                          .location_on_outlined,
                    ),
                    _textField(
                      controller:
                          _departmentController,
                      label: 'Department',
                      icon: Icons
                          .account_tree_outlined,
                    ),
                    _textField(
                      controller:
                          _activityController,
                      label: 'Activity / Task',
                      icon:
                          Icons.work_outline,
                    ),
                    _dropdown(
                      label: 'Risk Document Type',
                      value: _documentType,
                      items: widget.documentTypes,
                      onChanged: (value) {
                        if (value == null) return;

                        setState(() {
                          _documentType = value;
                        });
                      },
                    ),
                    _textField(
                      controller:
                          _referenceNoController,
                      label: 'Reference No.',
                      icon: Icons.link,
                      hint:
                          'HIRA / JSA / RAMS / Action Register No.',
                    ),
                    const SizedBox(height: 4),
                    _dateTile(
                      label: 'Review Date',
                      date: _reviewDate,
                      required: true,
                      onTap: () => _pickDate(
                        current: _reviewDate,
                        onSelected: (date) {
                          _reviewDate = date;
                        },
                      ),
                    ),
                    _dropdown(
                      label: 'Review Trigger',
                      value: _reviewTrigger,
                      items: widget.reviewTriggers,
                      onChanged: (value) {
                        if (value == null) return;

                        setState(() {
                          _reviewTrigger = value;
                        });
                      },
                    ),
                    const SizedBox(height: 8),
                    _sectionTitle(
                      'Review & Findings',
                    ),
                    _textField(
                      controller:
                          _reviewerController,
                      label: 'Reviewer',
                      icon:
                          Icons.person_outline,
                    ),
                    _textField(
                      controller:
                          _findingsController,
                      label: 'Review Findings',
                      icon: Icons
                          .rate_review_outlined,
                      maxLines: 4,
                    ),
                    _textField(
                      controller:
                          _requiredChangesController,
                      label: 'Required Changes',
                      icon:
                          Icons.edit_note,
                      maxLines: 4,
                    ),
                    _textField(
                      controller:
                          _actionOwnerController,
                      label: 'Action Owner',
                      icon: Icons
                          .person_pin_outlined,
                    ),
                    _dateTile(
                      label: 'Action Due Date',
                      date: _actionDueDate,
                      onTap: () => _pickDate(
                        current: _actionDueDate,
                        onSelected: (date) {
                          _actionDueDate = date;
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                    _sectionTitle(
                      'Approval & Revision',
                    ),
                    _textField(
                      controller:
                          _approverController,
                      label:
                          'Approved By / Approver',
                      icon: Icons
                          .verified_user_outlined,
                    ),
                    _dateTile(
                      label: 'Approval Date',
                      date: _approvalDate,
                      onTap: () => _pickDate(
                        current: _approvalDate,
                        onSelected: (date) {
                          _approvalDate = date;
                        },
                      ),
                    ),
                    _dropdown(
                      label: 'Revision',
                      value: _revisionNo,
                      items: const [
                        'Rev 0',
                        'Rev 1',
                        'Rev 2',
                        'Rev 3',
                        'Rev 4',
                        'Rev 5',
                        'Other',
                      ],
                      onChanged: (value) {
                        if (value == null) return;

                        setState(() {
                          _revisionNo = value;
                        });
                      },
                    ),
                    _dropdown(
                      label: 'Status',
                      value: _status,
                      items: widget.statuses,
                      onChanged: (value) {
                        if (value == null) return;

                        setState(() {
                          _status = value;
                        });
                      },
                    ),
                    _textField(
                      controller:
                          _remarksController,
                      label: 'Remarks',
                      icon:
                          Icons.notes_outlined,
                      maxLines: 4,
                    ),
                    const SizedBox(height: 18),
                    FilledButton.icon(
                      onPressed: _submit,
                      style: FilledButton.styleFrom(
                        minimumSize:
                            const Size.fromHeight(52),
                        backgroundColor:
                            primaryGreen,
                      ),
                      icon: Icon(
                        _isEdit
                            ? Icons.save_outlined
                            : Icons.add_task,
                      ),
                      label: Text(
                        _isEdit
                            ? 'Save Changes'
                            : 'Save Review',
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

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 10,
        top: 4,
      ),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 20,
            decoration: BoxDecoration(
              color: primaryGreen,
              borderRadius:
                  BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              color: darkGreen,
            ),
          ),
        ],
      ),
    );
  }

  Widget _textField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? hint,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 10,
      ),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          prefixIcon: Icon(icon),
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _dropdown({
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 10,
      ),
      child: DropdownButtonFormField<String>(
        initialValue:
            items.contains(value)
                ? value
                : items.first,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        items: items
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

  Widget _dateTile({
    required String label,
    required DateTime? date,
    required VoidCallback onTap,
    bool required = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 10,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius:
            BorderRadius.circular(4),
        child: InputDecorator(
          decoration: InputDecoration(
            labelText:
                required ? '$label *' : label,
            prefixIcon: const Icon(
              Icons.calendar_month_outlined,
            ),
            border:
                const OutlineInputBorder(),
          ),
          child: Text(
            _formatDate(date),
            style: TextStyle(
              color: date == null
                  ? Colors.black54
                  : Colors.black87,
            ),
          ),
        ),
      ),
    );
  }
}
