import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// ===============================================================
/// SafeNexus HSE
/// STEP 34
/// HSE DOCUMENT & RECORDS CENTER
///
/// 34A Document Master
/// 34B HSE Records Register
/// 34C Document Category & Type
/// 34D Issue / Revision / Review Control
/// 34E Expiry & Renewal Tracking
/// 34F Approval & Status Control
/// 34G Responsible Person / Owner
/// 34H Document Reference & Integration
/// 34I Search & Advanced Filters
/// 34J Review / Renewal Follow-up
/// 34K Audit History
/// 34L Document Intelligence Dashboard
///
/// Storage:
/// SharedPreferences
///
/// Language:
/// English + Malayalam ready
///
/// Cross-module:
/// Optional sourceOpener callback
/// ===============================================================

class SafeNexusStep34DocumentsRecordsPage extends StatefulWidget {
  const SafeNexusStep34DocumentsRecordsPage({
    super.key,
    this.sourceOpener,
  });

  final void Function(String referenceType, String referenceId)?
      sourceOpener;

  @override
  State<SafeNexusStep34DocumentsRecordsPage> createState() =>
      _SafeNexusStep34DocumentsRecordsPageState();
}

class _SafeNexusStep34DocumentsRecordsPageState
    extends State<SafeNexusStep34DocumentsRecordsPage> {
  static const String storageKey =
      'safenexus_hse_step34_documents_records';

  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);

  final TextEditingController _searchController =
      TextEditingController();

  List<Map<String, dynamic>> _records = [];

  bool _loading = true;

  String _statusFilter = 'All';
  String _categoryFilter = 'All';
  String _priorityFilter = 'All';
  String _expiryFilter = 'All';

  static const List<String> statuses = [
    'Draft',
    'Under Review',
    'Approved',
    'Rejected',
    'Active',
    'Superseded',
    'Archived',
  ];

  static const List<String> priorities = [
    'Low',
    'Medium',
    'High',
    'Critical',
  ];

  static const List<String> categories = [
    'Policy',
    'Procedure',
    'SOP',
    'RAMS',
    'Risk Assessment',
    'JSA / JHA / HIRA',
    'PTW',
    'Inspection',
    'Training',
    'Incident',
    'Emergency',
    'Audit',
    'Certificate',
    'Legal / Authority',
    'Other',
  ];

  static const List<String> expiryFilters = [
    'All',
    'No Expiry',
    'Valid',
    'Due Soon',
    'Expired',
  ];

  @override
  void initState() {
    super.initState();

    _loadRecords();
    _searchController.addListener(_refreshView);
  }

  @override
  void dispose() {
    _searchController
      ..removeListener(_refreshView)
      ..dispose();

    super.dispose();
  }

  // =============================================================
  // STORAGE
  // =============================================================

  Future<void> _loadRecords() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(storageKey);

    if (raw == null || raw.trim().isEmpty) {
      if (!mounted) return;

      setState(() {
        _records = [];
        _loading = false;
      });

      return;
    }

    try {
      final decoded = jsonDecode(raw);

      final list = decoded is List ? decoded : <dynamic>[];

      final records = list
          .whereType<Map>()
          .map(
            (item) => Map<String, dynamic>.from(item),
          )
          .toList();

      if (!mounted) return;

      setState(() {
        _records = records;
        _loading = false;
      });
    } catch (_) {
      if (!mounted) return;

      setState(() {
        _records = [];
        _loading = false;
      });
    }
  }

  Future<void> _saveRecords() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(
      storageKey,
      jsonEncode(_records),
    );
  }

  void _refreshView() {
    if (!mounted) return;

    setState(() {});
  }

  // =============================================================
  // DATE / EXPIRY
  // =============================================================

  String _expiryState(
    Map<String, dynamic> record,
  ) {
    final expiryText =
        '${record['expiryDate'] ?? ''}'.trim();

    if (expiryText.isEmpty) {
      return 'No Expiry';
    }

    final expiry = DateTime.tryParse(expiryText);

    if (expiry == null) {
      return 'No Expiry';
    }

    final now = DateTime.now();

    final today = DateTime(
      now.year,
      now.month,
      now.day,
    );

    final expiryOnly = DateTime(
      expiry.year,
      expiry.month,
      expiry.day,
    );

    if (expiryOnly.isBefore(today)) {
      return 'Expired';
    }

    final dueSoon = today.add(
      const Duration(days: 30),
    );

    if (!expiryOnly.isAfter(dueSoon)) {
      return 'Due Soon';
    }

    return 'Valid';
  }

  // =============================================================
  // FILTERING
  // =============================================================

  List<Map<String, dynamic>> get _filteredRecords {
    final query =
        _searchController.text.trim().toLowerCase();

    return _records.where((record) {
      final status =
          '${record['status'] ?? ''}';

      final category =
          '${record['category'] ?? ''}';

      final priority =
          '${record['priority'] ?? ''}';

      if (_statusFilter != 'All' &&
          status != _statusFilter) {
        return false;
      }

      if (_categoryFilter != 'All' &&
          category != _categoryFilter) {
        return false;
      }

      if (_priorityFilter != 'All' &&
          priority != _priorityFilter) {
        return false;
      }

      if (_expiryFilter != 'All' &&
          _expiryState(record) != _expiryFilter) {
        return false;
      }

      if (query.isEmpty) {
        return true;
      }

      final searchable = [
        record['title'],
        record['documentId'],
        record['category'],
        record['documentType'],
        record['project'],
        record['site'],
        record['location'],
        record['owner'],
        record['reviewer'],
        record['approver'],
        record['department'],
        record['description'],
        record['revision'],
        record['revisionNotes'],
        record['referenceType'],
        record['referenceId'],
        record['notes'],
        record['status'],
        record['priority'],
      ].map(
        (value) => '$value',
      ).join(' ').toLowerCase();

      return searchable.contains(query);
    }).toList();
  }

  // =============================================================
  // DASHBOARD COUNTS
  // =============================================================

  int _countWhere(
    bool Function(Map<String, dynamic>) test,
  ) {
    return _records.where(test).length;
  }

  int get _totalCount => _records.length;

  int get _activeCount => _countWhere(
        (record) =>
            '${record['status'] ?? ''}' == 'Active',
      );

  int get _underReviewCount => _countWhere(
        (record) =>
            '${record['status'] ?? ''}' ==
            'Under Review',
      );

  int get _approvedCount => _countWhere(
        (record) =>
            '${record['status'] ?? ''}' == 'Approved',
      );

  int get _criticalCount => _countWhere(
        (record) =>
            '${record['priority'] ?? ''}' ==
            'Critical',
      );

  int get _archivedCount => _countWhere(
        (record) =>
            '${record['status'] ?? ''}' ==
            'Archived',
      );

  int get _expiringSoonCount => _countWhere(
        (record) =>
            _expiryState(record) == 'Due Soon',
      );

  int get _expiredCount => _countWhere(
        (record) =>
            _expiryState(record) == 'Expired',
      );

  int get _reviewDueCount {
    final now = DateTime.now();

    final today = DateTime(
      now.year,
      now.month,
      now.day,
    );

    return _countWhere((record) {
      final review = DateTime.tryParse(
        '${record['reviewDate'] ?? ''}',
      );

      if (review == null) {
        return false;
      }

      final status =
          '${record['status'] ?? ''}';

      final reviewOnly = DateTime(
        review.year,
        review.month,
        review.day,
      );

      return reviewOnly.isBefore(today) &&
          status != 'Archived' &&
          status != 'Superseded';
    });
  }

  // =============================================================
  // ADD / EDIT
  // =============================================================

  Future<void> _openForm({
    Map<String, dynamic>? existing,
  }) async {
    final result =
        await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) {
        return _DocumentForm(
          existing: existing,
        );
      },
    );

    if (result == null) {
      return;
    }

    final record =
        Map<String, dynamic>.from(result);

    final existingId = existing?['id'];

    if (existingId != null) {
      final index = _records.indexWhere(
        (item) => item['id'] == existingId,
      );

      if (index >= 0) {
        record['id'] = existingId;

        record['createdAt'] =
            _records[index]['createdAt'];

        record['updatedAt'] =
            DateTime.now().toIso8601String();

        final oldHistory =
            List<dynamic>.from(
          _records[index]['history'] ?? const [],
        );

        record['history'] = [
          ...oldHistory,
          {
            'event': 'Updated',
            'at': DateTime.now().toIso8601String(),
          },
        ];

        _records[index] = record;
      }
    } else {
      final now =
          DateTime.now().toIso8601String();

      record['id'] =
          'DOC-${DateTime.now().millisecondsSinceEpoch}';

      record['createdAt'] = now;
      record['updatedAt'] = now;

      record['history'] = [
        {
          'event': 'Created',
          'at': now,
        },
      ];

      _records.insert(0, record);
    }

    await _saveRecords();

    if (!mounted) return;

    setState(() {});

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          existingId == null
              ? 'Document created successfully'
              : 'Document updated successfully',
        ),
      ),
    );
  }

  // =============================================================
  // DELETE
  // =============================================================

  Future<void> _deleteRecord(
    Map<String, dynamic> record,
  ) async {
    final confirmed =
        await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Delete document record?',
          ),
          content: Text(
            'Remove "${record['title'] ?? 'this document'}" '
            'from the Step 34 register?',
          ),
          actions: [
            TextButton(
              onPressed: () =>
                  Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () =>
                  Navigator.pop(context, true),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirmed != true) {
      return;
    }

    _records.removeWhere(
      (item) => item['id'] == record['id'],
    );

    await _saveRecords();

    if (!mounted) return;

    setState(() {});

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Document deleted',
        ),
      ),
    );
  }

  // =============================================================
  // CLEAR ALL
  // =============================================================

  Future<void> _clearAll() async {
    final confirmed =
        await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Clear Step 34 records?',
          ),
          content: const Text(
            'All locally stored document and record '
            'data will be deleted.',
          ),
          actions: [
            TextButton(
              onPressed: () =>
                  Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () =>
                  Navigator.pop(context, true),
              child: const Text('Clear All'),
            ),
          ],
        );
      },
    );

    if (confirmed != true) {
      return;
    }

    _records.clear();

    await _saveRecords();

    if (!mounted) return;

    setState(() {});

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'All Step 34 records cleared',
        ),
      ),
    );
  }

  // =============================================================
  // BUILD
  // =============================================================

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredRecords;

    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        title: const Text(
          'Step 34 • Documents & Records',
        ),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            tooltip: 'Clear all',
            onPressed:
                _records.isEmpty ? null : _clearAll,
            icon: const Icon(
              Icons.delete_sweep_outlined,
            ),
          ),
        ],
      ),
      floatingActionButton:
          FloatingActionButton.extended(
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        onPressed: () => _openForm(),
        icon: const Icon(Icons.add),
        label: const Text('New Document'),
      ),
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: _loadRecords,
              child: ListView(
                padding:
                    const EdgeInsets.fromLTRB(
                  16,
                  16,
                  16,
                  100,
                ),
                children: [
                  _headerCard(),
                  const SizedBox(height: 12),
                  _workflowCard(),
                  const SizedBox(height: 12),
                  _dashboardCard(),
                  const SizedBox(height: 12),
                  _filters(),
                  const SizedBox(height: 12),
                  if (filtered.isEmpty)
                    _emptyState()
                  else
                    ...filtered.map(_recordCard),
                ],
              ),
            ),
    );
  }

  // =============================================================
  // HEADER
  // =============================================================

  Widget _headerCard() {
    return Card(
      elevation: 0,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(16),
          gradient: const LinearGradient(
            colors: [
              darkGreen,
              primaryGreen,
            ],
          ),
        ),
        child: const Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.folder_copy_outlined,
                  color: Colors.white,
                  size: 30,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'HSE Document & Records Center',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              'Control • Review • Approve • Monitor • Renew',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
            SizedBox(height: 12),
            Text(
              'Step 34 manages controlled HSE documents, '
              'records, revisions, approvals, reviews, '
              'expiry, renewal and audit history across '
              'UAE operations.',
              style: TextStyle(
                color: Colors.white,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =============================================================
  // WORKFLOW
  // =============================================================

  Widget _workflowCard() {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            const Text(
              'Document Control Workflow',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: darkGreen,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _workflowChip('Create'),
                _workflowChip('Review'),
                _workflowChip('Approve'),
                _workflowChip('Issue'),
                _workflowChip('Monitor'),
                _workflowChip('Renew'),
                _workflowChip('Archive'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _workflowChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 7,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF6F0),
        borderRadius:
            BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: darkGreen,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }

  // =============================================================
  // DASHBOARD
  // =============================================================

  Widget _dashboardCard() {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(
                left: 4,
                bottom: 10,
              ),
              child: Text(
                'Document Intelligence Dashboard',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: darkGreen,
                ),
              ),
            ),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics:
                  const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.55,
              children: [
                _summaryCard(
                  'Total',
                  _totalCount,
                  Icons.folder_outlined,
                ),
                _summaryCard(
                  'Active',
                  _activeCount,
                  Icons.check_circle_outline,
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
                  'Expiring Soon',
                  _expiringSoonCount,
                  Icons.schedule_outlined,
                ),
                _summaryCard(
                  'Expired',
                  _expiredCount,
                  Icons.warning_amber_outlined,
                ),
                _summaryCard(
                  'Critical',
                  _criticalCount,
                  Icons.priority_high_outlined,
                ),
                _summaryCard(
                  'Archived',
                  _archivedCount,
                  Icons.archive_outlined,
                ),
                _summaryCard(
                  'Review Due',
                  _reviewDueCount,
                  Icons.event_repeat_outlined,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _summaryCard(
    String title,
    int value,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FBF9),
        borderRadius:
            BorderRadius.circular(14),
        border: Border.all(
          color:
              const Color(0xFFE4EEE8),
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: primaryGreen,
            size: 23,
          ),
          const SizedBox(width: 9),
          Expanded(
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center,
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 2,
                  overflow:
                      TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$value',
                  style: const TextStyle(
                    fontSize: 21,
                    fontWeight:
                        FontWeight.bold,
                    color: darkGreen,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // =============================================================
  // FILTERS
  // =============================================================

  Widget _filters() {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText:
                    'Search title, document ID, project, site...',
                prefixIcon:
                    const Icon(Icons.search),
                suffixIcon:
                    _searchController.text.isEmpty
                        ? null
                        : IconButton(
                            onPressed: () {
                              _searchController
                                  .clear();
                            },
                            icon: const Icon(
                              Icons.clear,
                            ),
                          ),
                filled: true,
                fillColor:
                    const Color(0xFFF6F8F7),
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(12),
                  borderSide:
                      BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 10),
            _filterDropdown(
              'Status',
              _statusFilter,
              [
                'All',
                ...statuses,
              ],
              (value) {
                setState(() {
                  _statusFilter = value;
                });
              },
            ),
            const SizedBox(height: 8),
            _filterDropdown(
              'Category',
              _categoryFilter,
              [
                'All',
                ...categories,
              ],
              (value) {
                setState(() {
                  _categoryFilter = value;
                });
              },
            ),
            const SizedBox(height: 8),
            _filterDropdown(
              'Priority',
              _priorityFilter,
              [
                'All',
                ...priorities,
              ],
              (value) {
                setState(() {
                  _priorityFilter = value;
                });
              },
            ),
            const SizedBox(height: 8),
            _filterDropdown(
              'Expiry',
              _expiryFilter,
              expiryFilters,
              (value) {
                setState(() {
                  _expiryFilter = value;
                });
              },
            ),
            Align(
              alignment:
                  Alignment.centerRight,
              child: TextButton.icon(
                onPressed: _resetFilters,
                icon: const Icon(
                  Icons.refresh,
                ),
                label:
                    const Text('Reset Filters'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _filterDropdown(
    String label,
    String value,
    List<String> values,
    ValueChanged<String> onChanged,
  ) {
    final safeValue =
        values.contains(value)
            ? value
            : values.first;

    return DropdownButtonFormField<String>(
      initialValue: safeValue,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(12),
        ),
        isDense: true,
      ),
      items: values
          .map(
            (item) =>
                DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            ),
          )
          .toList(),
      onChanged: (selected) {
        if (selected != null) {
          onChanged(selected);
        }
      },
    );
  }

  void _resetFilters() {
    setState(() {
      _searchController.clear();
      _statusFilter = 'All';
      _categoryFilter = 'All';
      _priorityFilter = 'All';
      _expiryFilter = 'All';
    });
  }

  // =============================================================
  // EMPTY
  // =============================================================

  Widget _emptyState() {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            const Icon(
              Icons.folder_open_outlined,
              size: 52,
              color: Colors.grey,
            ),
            const SizedBox(height: 12),
            const Text(
              'No documents found',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Add a document or change the filters.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 15),
            FilledButton.icon(
              onPressed: () => _openForm(),
              icon: const Icon(Icons.add),
              label:
                  const Text('Add Document'),
            ),
          ],
        ),
      ),
    );
  }

  // =============================================================
  // RECORD CARD
  // =============================================================

  Widget _recordCard(
    Map<String, dynamic> record,
  ) {
    final expiry =
        _expiryState(record);

    final expired =
        expiry == 'Expired';

    final dueSoon =
        expiry == 'Due Soon';

    final title =
        '${record['title'] ?? 'Untitled Document'}';

    final documentId =
        '${record['documentId'] ?? '-'}';

    return Card(
      margin:
          const EdgeInsets.only(bottom: 12),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(16),
      ),
      child: InkWell(
        borderRadius:
            BorderRadius.circular(16),
        onTap: () =>
            _showDetails(record),
        child: Padding(
          padding:
              const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.all(10),
                    decoration:
                        BoxDecoration(
                      color:
                          const Color(0xFFEAF6F0),
                      borderRadius:
                          BorderRadius.circular(
                        12,
                      ),
                    ),
                    child: const Icon(
                      Icons.description_outlined,
                      color: primaryGreen,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          maxLines: 2,
                          overflow:
                              TextOverflow.ellipsis,
                          style:
                              const TextStyle(
                            fontSize: 16,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                            height: 5),
                        Text(
                          documentId,
                          style:
                              const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'edit') {
                        _openForm(
                          existing: record,
                        );
                      } else if (value ==
                          'delete') {
                        _deleteRecord(record);
                      } else if (value ==
                          'history') {
                        _showHistory(record);
                      }
                    },
                    itemBuilder:
                        (context) => const [
                      PopupMenuItem(
                        value: 'edit',
                        child:
                            Text('Edit'),
                      ),
                      PopupMenuItem(
                        value: 'history',
                        child:
                            Text('History'),
                      ),
                      PopupMenuItem(
                        value: 'delete',
                        child:
                            Text('Delete'),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  _tag(
                    '${record['category'] ?? '-'}',
                  ),
                  _tag(
                    '${record['status'] ?? '-'}',
                  ),
                  _tag(
                    '${record['priority'] ?? '-'}',
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _infoLine(
                Icons.person_outline,
                '${record['owner'] ?? ''}'.isEmpty
                    ? 'Owner not assigned'
                    : '${record['owner']}',
              ),
              const SizedBox(height: 6),
              _infoLine(
                Icons.location_on_outlined,
                '${record['site'] ?? ''}'.isEmpty
                    ? 'Site not specified'
                    : '${record['site']}',
              ),
              const SizedBox(height: 6),
              _infoLine(
                Icons.event_outlined,
                '${record['expiryDate'] ?? ''}'.isEmpty
                    ? 'No expiry date'
                    : 'Expiry: ${record['expiryDate']}',
              ),
              if (expired || dueSoon) ...[
                const SizedBox(height: 10),
                _expiryBanner(
                  expired,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoLine(
    IconData icon,
    String text,
  ) {
    return Row(
      children: [
        Icon(
          icon,
          size: 17,
          color: Colors.grey,
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            style:
                const TextStyle(fontSize: 12),
          ),
        ),
      ],
    );
  }

  Widget _expiryBanner(
    bool expired,
  ) {
    return Container(
      width: double.infinity,
      padding:
          const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: expired
            ? const Color(0xFFFFE9E9)
            : const Color(0xFFFFF5DD),
        borderRadius:
            BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(
            expired
                ? Icons.error_outline
                : Icons.schedule,
            size: 18,
            color: expired
                ? Colors.red
                : Colors.orange,
          ),
          const SizedBox(width: 7),
          Text(
            expired
                ? 'DOCUMENT EXPIRED'
                : 'EXPIRING WITHIN 30 DAYS',
            style: TextStyle(
              fontWeight:
                  FontWeight.bold,
              fontSize: 12,
              color: expired
                  ? Colors.red
                  : Colors.orange,
            ),
          ),
        ],
      ),
    );
  }

  Widget _tag(String value) {
    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color:
            const Color(0xFFEFF5F2),
        borderRadius:
            BorderRadius.circular(20),
      ),
      child: Text(
        value,
        style: const TextStyle(
          fontSize: 11,
          fontWeight:
              FontWeight.w600,
          color: darkGreen,
        ),
      ),
    );
  }

  // =============================================================
  // DETAILS
  // =============================================================

  void _showDetails(
    Map<String, dynamic> record,
  ) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return SafeArea(
          child: SizedBox(
            height:
                MediaQuery.of(context)
                        .size
                        .height *
                    .88,
            child: SingleChildScrollView(
              padding:
                  const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.description_outlined,
                        color: primaryGreen,
                        size: 28,
                      ),
                      const SizedBox(
                          width: 10),
                      Expanded(
                        child: Text(
                          '${record['title'] ?? 'Document'}',
                          style:
                              const TextStyle(
                            fontSize: 20,
                            fontWeight:
                                FontWeight.bold,
                            color: darkGreen,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  _detailRow(
                    'Document ID',
                    record['documentId'],
                  ),
                  _detailRow(
                    'Category',
                    record['category'],
                  ),
                  _detailRow(
                    'Type',
                    record['documentType'],
                  ),
                  _detailRow(
                    'Status',
                    record['status'],
                  ),
                  _detailRow(
                    'Priority',
                    record['priority'],
                  ),
                  _detailRow(
                    'Project',
                    record['project'],
                  ),
                  _detailRow(
                    'Site',
                    record['site'],
                  ),
                  _detailRow(
                    'Location',
                    record['location'],
                  ),
                  _detailRow(
                    'Department',
                    record['department'],
                  ),
                  _detailRow(
                    'Owner',
                    record['owner'],
                  ),
                  _detailRow(
                    'Reviewer',
                    record['reviewer'],
                  ),
                  _detailRow(
                    'Approver',
                    record['approver'],
                  ),
                  _detailRow(
                    'Revision',
                    record['revision'],
                  ),
                  _detailRow(
                    'Issue Date',
                    record['issueDate'],
                  ),
                  _detailRow(
                    'Review Date',
                    record['reviewDate'],
                  ),
                  _detailRow(
                    'Expiry Date',
                    record['expiryDate'],
                  ),
                  _detailRow(
                    'Approval',
                    record['approvalStatus'],
                  ),
                  _detailRow(
                    'Reference Type',
                    record['referenceType'],
                  ),
                  _detailRow(
                    'Reference ID',
                    record['referenceId'],
                  ),
                  const SizedBox(height: 12),
                  _textSection(
                    'Description',
                    record['description'],
                  ),
                  _textSection(
                    'Revision Notes',
                    record['revisionNotes'],
                  ),
                  _textSection(
                    'Follow-up',
                    record['followUp'],
                  ),
                  _textSection(
                    'Notes',
                    record['notes'],
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      Expanded(
                        child:
                            OutlinedButton.icon(
                          onPressed: () {
                            Navigator.pop(
                                context);
                            _openForm(
                              existing:
                                  record,
                            );
                          },
                          icon: const Icon(
                            Icons.edit_outlined,
                          ),
                          label:
                              const Text('Edit'),
                        ),
                      ),
                      const SizedBox(
                          width: 10),
                      Expanded(
                        child:
                            OutlinedButton.icon(
                          onPressed: () {
                            Navigator.pop(
                                context);
                            _showHistory(
                              record,
                            );
                          },
                          icon: const Icon(
                            Icons.history,
                          ),
                          label: const Text(
                              'History'),
                        ),
                      ),
                    ],
                  ),
                  if (widget.sourceOpener !=
                          null &&
                      '${record['referenceId'] ?? ''}'
                          .trim()
                          .isNotEmpty) ...[
                    const SizedBox(
                        height: 10),
                    SizedBox(
                      width: double.infinity,
                      child:
                          OutlinedButton.icon(
                        onPressed: () {
                          Navigator.pop(
                              context);

                          widget.sourceOpener!(
                            '${record['referenceType'] ?? ''}',
                            '${record['referenceId'] ?? ''}',
                          );
                        },
                        icon: const Icon(
                          Icons.open_in_new,
                        ),
                        label: const Text(
                          'Open Source Reference',
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _detailRow(
    String label,
    dynamic value,
  ) {
    final text =
        '${value ?? ''}'.trim();

    return Padding(
      padding:
          const EdgeInsets.only(
        bottom: 9,
      ),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 125,
            child: Text(
              label,
              style:
                  const TextStyle(
                fontWeight:
                    FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              text.isEmpty ? '-' : text,
            ),
          ),
        ],
      ),
    );
  }

  Widget _textSection(
    String title,
    dynamic value,
  ) {
    final text =
        '${value ?? ''}'.trim();

    return Padding(
      padding:
          const EdgeInsets.only(
        top: 8,
        bottom: 10,
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style:
                const TextStyle(
              fontWeight:
                  FontWeight.bold,
              color: darkGreen,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            text.isEmpty ? '-' : text,
          ),
        ],
      ),
    );
  }

  // =============================================================
  // HISTORY
  // =============================================================

  void _showHistory(
    Map<String, dynamic> record,
  ) {
    final history =
        List<dynamic>.from(
      record['history'] ?? const [],
    );

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return SafeArea(
          child: SizedBox(
            height:
                MediaQuery.of(context)
                        .size
                        .height *
                    .75,
            child: Padding(
              padding:
                  const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Document Audit History',
                    style:
                        TextStyle(
                      fontSize: 21,
                      fontWeight:
                          FontWeight.bold,
                      color: darkGreen,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '${record['title'] ?? 'Document'}',
                    style:
                        const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(
                      height: 16),
                  Expanded(
                    child: history.isEmpty
                        ? const Center(
                            child: Text(
                              'No history available',
                            ),
                          )
                        : ListView.separated(
                            itemCount:
                                history.length,
                            separatorBuilder:
                                (_, __) =>
                                    const Divider(),
                            itemBuilder:
                                (context,
                                    index) {
                              final item =
                                  history[index];

                              final map =
                                  item is Map
                                      ? Map<String,
                                          dynamic>.from(
                                          item,
                                        )
                                      : <String,
                                          dynamic>{};

                              return ListTile(
                                leading:
                                    const CircleAvatar(
                                  child:
                                      Icon(
                                    Icons
                                        .history,
                                  ),
                                ),
                                title:
                                    Text(
                                  '${map['event'] ?? 'Event'}',
                                ),
                                subtitle:
                                    Text(
                                  '${map['at'] ?? ''}',
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// =================================================================
// DOCUMENT FORM
// =================================================================

class _DocumentForm
    extends StatefulWidget {
  const _DocumentForm({
    this.existing,
  });

  final Map<String, dynamic>? existing;

  @override
  State<_DocumentForm> createState() =>
      _DocumentFormState();
}

class _DocumentFormState
    extends State<_DocumentForm> {
  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>();

  late final TextEditingController
      _titleController;

  late final TextEditingController
      _documentIdController;

  late final TextEditingController
      _projectController;

  late final TextEditingController
      _siteController;

  late final TextEditingController
      _locationController;

  late final TextEditingController
      _departmentController;

  late final TextEditingController
      _ownerController;

  late final TextEditingController
      _reviewerController;

  late final TextEditingController
      _approverController;

  late final TextEditingController
      _revisionController;

  late final TextEditingController
      _issueDateController;

  late final TextEditingController
      _reviewDateController;

  late final TextEditingController
      _expiryDateController;

  late final TextEditingController
      _referenceIdController;

  late final TextEditingController
      _descriptionController;

  late final TextEditingController
      _revisionNotesController;

  late final TextEditingController
      _followUpController;

  late final TextEditingController
      _notesController;

  String _category = 'Policy';
  String _documentType =
      'Controlled Document';

  String _status = 'Draft';
  String _priority = 'Medium';

  String _approvalStatus = 'Pending';

  String _referenceType =
      'Step 9 Daily HSE';

  static const List<String>
      _documentTypes = [
    'Controlled Document',
    'HSE Record',
    'Certificate',
    'Permit',
    'Inspection Record',
    'Training Record',
    'Audit Record',
    'Incident Record',
    'Other',
  ];

  static const List<String>
      _approvalStatuses = [
    'Pending',
    'Approved',
    'Rejected',
    'Not Required',
  ];

  static const List<String>
      _referenceTypes = [
    'Step 9 Daily HSE',
    'Step 31 Smart Checklist',
    'Step 32 Field Operations',
    'Step 33 Communication',
    'Risk / HIRA / JSA / JHA',
    'RAMS',
    'PTW',
    'Workforce / Competency',
    'Equipment',
    'Incident',
    'Action Center',
  ];

  @override
  void initState() {
    super.initState();

    final existing =
        widget.existing;

    _titleController =
        TextEditingController(
      text:
          '${existing?['title'] ?? ''}',
    );

    _documentIdController =
        TextEditingController(
      text:
          '${existing?['documentId'] ?? ''}',
    );

    _projectController =
        TextEditingController(
      text:
          '${existing?['project'] ?? ''}',
    );

    _siteController =
        TextEditingController(
      text:
          '${existing?['site'] ?? ''}',
    );

    _locationController =
        TextEditingController(
      text:
          '${existing?['location'] ?? ''}',
    );

    _departmentController =
        TextEditingController(
      text:
          '${existing?['department'] ?? ''}',
    );

    _ownerController =
        TextEditingController(
      text:
          '${existing?['owner'] ?? ''}',
    );

    _reviewerController =
        TextEditingController(
      text:
          '${existing?['reviewer'] ?? ''}',
    );

    _approverController =
        TextEditingController(
      text:
          '${existing?['approver'] ?? ''}',
    );

    _revisionController =
        TextEditingController(
      text:
          '${existing?['revision'] ?? '1.0'}',
    );

    _issueDateController =
        TextEditingController(
      text:
          '${existing?['issueDate'] ?? ''}',
    );

    _reviewDateController =
        TextEditingController(
      text:
          '${existing?['reviewDate'] ?? ''}',
    );

    _expiryDateController =
        TextEditingController(
      text:
          '${existing?['expiryDate'] ?? ''}',
    );

    _referenceIdController =
        TextEditingController(
      text:
          '${existing?['referenceId'] ?? ''}',
    );

    _descriptionController =
        TextEditingController(
      text:
          '${existing?['description'] ?? ''}',
    );

    _revisionNotesController =
        TextEditingController(
      text:
          '${existing?['revisionNotes'] ?? ''}',
    );

    _followUpController =
        TextEditingController(
      text:
          '${existing?['followUp'] ?? ''}',
    );

    _notesController =
        TextEditingController(
      text:
          '${existing?['notes'] ?? ''}',
    );

    if (existing != null) {
      _category =
          '${existing['category'] ?? 'Policy'}';

      _documentType =
          '${existing['documentType'] ?? 'Controlled Document'}';

      _status =
          '${existing['status'] ?? 'Draft'}';

      _priority =
          '${existing['priority'] ?? 'Medium'}';

      _approvalStatus =
          '${existing['approvalStatus'] ?? 'Pending'}';

      _referenceType =
          '${existing['referenceType'] ?? 'Step 9 Daily HSE'}';

      if (![
        'Policy',
        ..._SafeNexusStep34DocumentsPageState
            .categories,
      ].contains(_category)) {
        _category = 'Policy';
      }

      if (!_documentTypes
          .contains(_documentType)) {
        _documentType =
            'Controlled Document';
      }

      if (!_SafeNexusStep34DocumentsPageState
          .statuses
          .contains(_status)) {
        _status = 'Draft';
      }

      if (!_SafeNexusStep34DocumentsPageState
          .priorities
          .contains(_priority)) {
        _priority = 'Medium';
      }

      if (!_approvalStatuses
          .contains(_approvalStatus)) {
        _approvalStatus = 'Pending';
      }

      if (!_referenceTypes
          .contains(_referenceType)) {
        _referenceType =
            'Step 9 Daily HSE';
      }
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _documentIdController.dispose();
    _projectController.dispose();
    _siteController.dispose();
    _locationController.dispose();
    _departmentController.dispose();
    _ownerController.dispose();
    _reviewerController.dispose();
    _approverController.dispose();
    _revisionController.dispose();
    _issueDateController.dispose();
    _reviewDateController.dispose();
    _expiryDateController.dispose();
    _referenceIdController.dispose();
    _descriptionController.dispose();
    _revisionNotesController.dispose();
    _followUpController.dispose();
    _notesController.dispose();

    super.dispose();
  }

  // =============================================================
  // VALIDATION
  // =============================================================

  String? _requiredValidator(
    String? value,
  ) {
    if (value == null ||
        value.trim().isEmpty) {
      return 'This field is required';
    }

    return null;
  }

  String? _dateValidator(
    String? value,
  ) {
    if (value == null ||
        value.trim().isEmpty) {
      return null;
    }

    if (DateTime.tryParse(
          value.trim(),
        ) ==
        null) {
      return 'Use YYYY-MM-DD';
    }

    return null;
  }

  // =============================================================
  // DATE PICKER
  // =============================================================

  Future<void> _selectDate(
    TextEditingController controller,
  ) async {
    DateTime initialDate =
        DateTime.now();

    final current =
        DateTime.tryParse(
      controller.text.trim(),
    );

    if (current != null) {
      initialDate = current;
    }

    final selected =
        await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (selected == null) {
      return;
    }

    final month =
        selected.month.toString()
            .padLeft(2, '0');

    final day =
        selected.day.toString()
            .padLeft(2, '0');

    controller.text =
        '${selected.year}-$month-$day';
  }

  // =============================================================
  // SAVE
  // =============================================================

  void _save() {
    if (!_formKey.currentState!
        .validate()) {
      return;
    }

    final now =
        DateTime.now().toIso8601String();

    final result =
        <String, dynamic>{
      'title':
          _titleController.text.trim(),
      'documentId':
          _documentIdController.text.trim(),
      'category': _category,
      'documentType': _documentType,
      'status': _status,
      'priority': _priority,
      'project':
          _projectController.text.trim(),
      'site':
          _siteController.text.trim(),
      'location':
          _locationController.text.trim(),
      'department':
          _departmentController.text.trim(),
      'owner':
          _ownerController.text.trim(),
      'reviewer':
          _reviewerController.text.trim(),
      'approver':
          _approverController.text.trim(),
      'revision':
          _revisionController.text.trim(),
      'issueDate':
          _issueDateController.text.trim(),
      'reviewDate':
          _reviewDateController.text.trim(),
      'expiryDate':
          _expiryDateController.text.trim(),
      'approvalStatus':
          _approvalStatus,
      'referenceType':
          _referenceType,
      'referenceId':
          _referenceIdController.text.trim(),
      'description':
          _descriptionController.text.trim(),
      'revisionNotes':
          _revisionNotesController.text.trim(),
      'followUp':
          _followUpController.text.trim(),
      'notes':
          _notesController.text.trim(),
      'createdAt': now,
      'updatedAt': now,
    };

    Navigator.pop(
      context,
      result,
    );
  }

  // =============================================================
  // BUILD
  // =============================================================

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.existing == null
            ? 'Add HSE Document'
            : 'Edit HSE Document',
      ),
      content: SizedBox(
        width:
            MediaQuery.of(context)
                    .size
                    .width *
                .92,
        height:
            MediaQuery.of(context)
                    .size
                    .height *
                .72,
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _textField(
                controller:
                    _titleController,
                label:
                    'Document Title *',
                validator:
                    _requiredValidator,
              ),
              _textField(
                controller:
                    _documentIdController,
                label:
                    'Document ID / Number *',
                validator:
                    _requiredValidator,
              ),
              _dropdown(
                label: 'Category',
                value: _category,
                values:
                    _SafeNexusStep34DocumentsPageState
                        .categories,
                onChanged: (value) {
                  setState(() {
                    _category = value;
                  });
                },
              ),
              _dropdown(
                label: 'Document Type',
                value: _documentType,
                values: _documentTypes,
                onChanged: (value) {
                  setState(() {
                    _documentType = value;
                  });
                },
              ),
              _dropdown(
                label: 'Status',
                value: _status,
                values:
                    _SafeNexusStep34DocumentsPageState
                        .statuses,
                onChanged: (value) {
                  setState(() {
                    _status = value;
                  });
                },
              ),
              _dropdown(
                label: 'Priority',
                value: _priority,
                values:
                    _SafeNexusStep34DocumentsPageState
                        .priorities,
                onChanged: (value) {
                  setState(() {
                    _priority = value;
                  });
                },
              ),
              _textField(
                controller:
                    _projectController,
                label: 'Project',
              ),
              _textField(
                controller:
                    _siteController,
                label: 'Site',
              ),
              _textField(
                controller:
                    _locationController,
                label: 'Location',
              ),
              _textField(
                controller:
                    _departmentController,
                label: 'Department',
              ),
              _textField(
                controller:
                    _ownerController,
                label:
                    'Responsible Person / Owner',
              ),
              _textField(
                controller:
                    _reviewerController,
                label: 'Reviewer',
              ),
              _textField(
                controller:
                    _approverController,
                label: 'Approver',
              ),
              _textField(
                controller:
                    _revisionController,
                label: 'Revision',
              ),
              _dateField(
                controller:
                    _issueDateController,
                label: 'Issue Date',
              ),
              _dateField(
                controller:
                    _reviewDateController,
                label: 'Review Date',
              ),
              _dateField(
                controller:
                    _expiryDateController,
                label: 'Expiry Date',
              ),
              _dropdown(
                label: 'Approval Status',
                value:
                    _approvalStatus,
                values:
                    _approvalStatuses,
                onChanged: (value) {
                  setState(() {
                    _approvalStatus =
                        value;
                  });
                },
              ),
              _dropdown(
                label:
                    'Reference Type',
                value:
                    _referenceType,
                values:
                    _referenceTypes,
                onChanged: (value) {
                  setState(() {
                    _referenceType =
                        value;
                  });
                },
              ),
              _textField(
                controller:
                    _referenceIdController,
                label:
                    'Reference ID',
              ),
              _textField(
                controller:
                    _descriptionController,
                label:
                    'Description',
                maxLines: 3,
              ),
              _textField(
                controller:
                    _revisionNotesController,
                label:
                    'Revision Notes',
                maxLines: 3,
              ),
              _textField(
                controller:
                    _followUpController,
                label: 'Review / Renewal Follow-up',
                maxLines: 3,
              ),
              _textField(
                controller:
                    _notesController,
                label: 'Notes',
                maxLines: 3,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () =>
              Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton.icon(
          onPressed: _save,
          icon: const Icon(
            Icons.save_outlined,
          ),
          label: const Text('Save'),
        ),
      ],
    );
  }

  // =============================================================
  // FORM HELPERS
  // =============================================================

  Widget _textField({
    required TextEditingController
        controller,
    required String label,
    String? Function(String?)?
        validator,
    int maxLines = 1,
  }) {
    return Padding(
      padding:
          const EdgeInsets.only(
        bottom: 10,
      ),
      child: TextFormField(
        controller: controller,
        validator: validator,
        maxLines: maxLines,
        decoration:
            InputDecoration(
          labelText: label,
          border:
              const OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _dateField({
    required TextEditingController
        controller,
    required String label,
  }) {
    return Padding(
      padding:
          const EdgeInsets.only(
        bottom: 10,
      ),
      child: TextFormField(
        controller: controller,
        readOnly: true,
        validator: _dateValidator,
        onTap: () =>
            _selectDate(controller),
        decoration:
            InputDecoration(
          labelText: label,
          border:
              const OutlineInputBorder(),
          suffixIcon:
              const Icon(
            Icons.calendar_today_outlined,
          ),
        ),
      ),
    );
  }

  Widget _dropdown({
    required String label,
    required String value,
    required List<String> values,
    required ValueChanged<String>
        onChanged,
  }) {
    final safeValue =
        values.contains(value)
            ? value
            : values.first;

    return Padding(
      padding:
          const EdgeInsets.only(
        bottom: 10,
      ),
      child:
          DropdownButtonFormField<String>(
        initialValue: safeValue,
        decoration:
            InputDecoration(
          labelText: label,
          border:
              const OutlineInputBorder(),
        ),
        items: values
            .map(
              (item) =>
                  DropdownMenuItem<
                      String>(
                value: item,
                child: Text(item),
              ),
            )
            .toList(),
        onChanged: (selected) {
          if (selected != null) {
            onChanged(selected);
          }
        },
      ),
    );
  }
}
