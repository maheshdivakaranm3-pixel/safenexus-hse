import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// SafeNexus HSE - Step 34
/// HSE Document & Records Center
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
/// Workflow:
/// Create -> Review -> Approve -> Issue -> Monitor -> Review/Renew
/// -> Supersede/Archive -> Analyze
///
/// Local storage:
/// SharedPreferences
///
/// Cross-module navigation:
/// Optional sourceOpener callback.

class SafeNexusStep34DocumentsRecordsPage extends StatefulWidget {
  const SafeNexusStep34DocumentsRecordsPage({
    super.key,
    this.sourceOpener,
  });

  final void Function(String referenceType, String referenceId)? sourceOpener;

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

  final TextEditingController _searchController = TextEditingController();

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

  static const List<String> documentTypes = [
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

  static const List<String> expiryFilters = [
    'All',
    'No Expiry',
    'Valid',
    'Due Soon',
    'Expired',
  ];

  static const List<String> referenceTypes = [
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

  Future<void> _loadRecords() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(storageKey);

    if (raw == null || raw.trim().isEmpty) {
      if (mounted) {
        setState(() {
          _records = [];
          _loading = false;
        });
      }
      return;
    }

    try {
      final decoded = jsonDecode(raw);
      final list = decoded is List ? decoded : <dynamic>[];

      final records = list
          .whereType<Map>()
          .map((item) => Map<String, dynamic>.from(item))
          .toList();

      if (mounted) {
        setState(() {
          _records = records;
          _loading = false;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _records = [];
          _loading = false;
        });
      }
    }
  }

  Future<void> _saveRecords() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(storageKey, jsonEncode(_records));
  }

  void _refreshView() {
    if (mounted) {
      setState(() {});
    }
  }

  List<Map<String, dynamic>> get _filteredRecords {
    final query = _searchController.text.trim().toLowerCase();

    return _records.where((record) {
      final status = '${record['status'] ?? ''}';
      final category = '${record['category'] ?? ''}';
      final priority = '${record['priority'] ?? ''}';

      if (_statusFilter != 'All' && status != _statusFilter) {
        return false;
      }

      if (_categoryFilter != 'All' && category != _categoryFilter) {
        return false;
      }

      if (_priorityFilter != 'All' && priority != _priorityFilter) {
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
        record['referenceId'],
        record['notes'],
        record['status'],
      ].map((value) => '$value').join(' ').toLowerCase();

      return searchable.contains(query);
    }).toList();
  }

  int _countWhere(bool Function(Map<String, dynamic>) test) {
    return _records.where(test).length;
  }

  int get _activeCount =>
      _countWhere((r) => '${r['status'] ?? ''}' == 'Active');

  int get _underReviewCount =>
      _countWhere((r) => '${r['status'] ?? ''}' == 'Under Review');

  int get _approvedCount =>
      _countWhere((r) => '${r['status'] ?? ''}' == 'Approved');

  int get _criticalCount =>
      _countWhere((r) => '${r['priority'] ?? ''}' == 'Critical');

  int get _archivedCount =>
      _countWhere((r) => '${r['status'] ?? ''}' == 'Archived');

  int get _expiringSoonCount =>
      _countWhere((r) => _expiryState(r) == 'Due Soon');

  int get _expiredCount =>
      _countWhere((r) => _expiryState(r) == 'Expired');

  int get _reviewDueCount {
    final today = DateTime.now();

    return _countWhere((record) {
      final review = DateTime.tryParse('${record['reviewDate'] ?? ''}');

      if (review == null) {
        return false;
      }

      final status = '${record['status'] ?? ''}';

      return review.isBefore(
            DateTime(today.year, today.month, today.day),
          ) &&
          status != 'Archived' &&
          status != 'Superseded';
    });
  }

  String _expiryState(Map<String, dynamic> record) {
    final expiryText = '${record['expiryDate'] ?? ''}'.trim();

    if (expiryText.isEmpty) {
      return 'No Expiry';
    }

    final expiry = DateTime.tryParse(expiryText);

    if (expiry == null) {
      return 'No Expiry';
    }

    final today = DateTime.now();
    final todayOnly = DateTime(today.year, today.month, today.day);
    final expiryOnly = DateTime(expiry.year, expiry.month, expiry.day);

    if (expiryOnly.isBefore(todayOnly)) {
      return 'Expired';
    }

    final dueSoonDate = todayOnly.add(const Duration(days: 30));

    if (!expiryOnly.isAfter(dueSoonDate)) {
      return 'Due Soon';
    }

    return 'Valid';
  }

  Future<void> _openForm({
    Map<String, dynamic>? existing,
  }) async {
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) {
        return _DocumentForm(existing: existing);
      },
    );

    if (result == null) {
      return;
    }

    final record = Map<String, dynamic>.from(result);
    final existingId = existing?['id'];

    if (existingId != null) {
      final index = _records.indexWhere(
        (item) => item['id'] == existingId,
      );

      if (index >= 0) {
        record['id'] = existingId;
        record['createdAt'] = _records[index]['createdAt'];
        record['updatedAt'] = DateTime.now().toIso8601String();

        final oldHistory =
            List<dynamic>.from(_records[index]['history'] ?? const []);

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
      final now = DateTime.now().toIso8601String();

      record['id'] = 'DOC-${DateTime.now().millisecondsSinceEpoch}';
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

    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _deleteRecord(Map<String, dynamic> record) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete document record?'),
          content: Text(
            'Remove "${record['title'] ?? 'this document'}" '
            'from the Step 34 register?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirmed != true) {
      return;
    }

    _records.removeWhere((item) => item['id'] == record['id']);

    await _saveRecords();

    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _clearAll() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Clear Step 34 records?'),
          content: const Text(
            'All locally stored document and record data '
            'will be deleted.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context, true),
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

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredRecords;

    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        title: const Text('Step 34 • Documents & Records'),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            tooltip: 'Clear all',
            onPressed: _records.isEmpty ? null : _clearAll,
            icon: const Icon(Icons.delete_sweep_outlined),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
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
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
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

  Widget _headerCard() {
    return Card(
      elevation: 0,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: const LinearGradient(
            colors: [
              darkGreen,
              primaryGreen,
            ],
          ),
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
              'Step 34 manages controlled HSE documents, records, '
              'revisions, approvals, reviews, expiry, renewal and '
              'audit history across UAE operations.',
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

  Widget _workflowCard() {
    const workflow = [
      'Create',
      'Review',
      'Approve',
      'Issue',
      'Monitor',
      'Review / Renew',
      'Supersede',
      'Archive',
      'Analyze',
    ];

    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '34 Workflow',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (var i = 0; i < workflow.length; i++)
                  Chip(
                    avatar: CircleAvatar(
                      backgroundColor: primaryGreen,
                      child: Text(
                        '${i + 1}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                        ),
                      ),
                    ),
                    label: Text(workflow[i]),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _dashboardCard() {
    final values = [
      ('Total', _records.length, Icons.folder_outlined),
      ('Active', _activeCount, Icons.check_circle_outline),
      ('Under Review', _underReviewCount, Icons.rate_review_outlined),
      ('Expiring Soon', _expiringSoonCount, Icons.timer_outlined),
      ('Expired', _expiredCount, Icons.warning_amber_outlined),
      ('Critical', _criticalCount, Icons.priority_high_outlined),
      ('Approved', _approvedCount, Icons.verified_outlined),
      ('Archived', _archivedCount, Icons.archive_outlined),
      ('Review Due', _reviewDueCount, Icons.event_note_outlined),
    ];

    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '34L • Document Intelligence Dashboard',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: values.length,
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 2.15,
              ),
              itemBuilder: (context, index) {
                final item = values[index];

                return Card(
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(11),
                    child: Row(
                      children: [
                        Icon(
                          item.$3,
                          color: primaryGreen,
                        ),
                        const SizedBox(width: 9),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${item.$2}',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(item.$1),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

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
                labelText: 'Search documents & records',
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
            const SizedBox(height: 10),
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
            const SizedBox(height: 10),
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
            const SizedBox(height: 10),
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
    final safeValue = values.contains(value) ? value : values.first;

    return DropdownButtonFormField<String>(
      value: safeValue,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      items: values
          .map(
            (item) => DropdownMenuItem<String>(
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

  Widget _emptyState() {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          children: [
            Icon(
              Icons.folder_open_outlined,
              size: 54,
              color: primaryGreen,
            ),
            const SizedBox(height: 12),
            const Text(
              'No document records found',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Create an HSE document, certificate, RAMS, risk '
              'assessment, inspection, training or other record.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 14),
            FilledButton.icon(
              onPressed: () => _openForm(),
              icon: const Icon(Icons.add),
              label: const Text('Create First Document'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _recordCard(Map<String, dynamic> record) {
    final status = '${record['status'] ?? 'Draft'}';
    final priority = '${record['priority'] ?? 'Medium'}';
    final expiryState = _expiryState(record);

    final expiryDate =
        DateTime.tryParse('${record['expiryDate'] ?? ''}');
    final reviewDate =
        DateTime.tryParse('${record['reviewDate'] ?? ''}');

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () => _showDetails(record),
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
                      '${record['title'] ?? 'Untitled document'}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'edit') {
                        _openForm(existing: record);
                      } else if (value == 'delete') {
                        _deleteRecord(record);
                      }
                    },
                    itemBuilder: (context) => const [
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
              const SizedBox(height: 5),
              Text(
                '${record['documentId'] ?? '-'} • '
                '${record['category'] ?? '-'}',
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  Chip(
                    label: Text(status),
                  ),
                  Chip(
                    label: Text(priority),
                  ),
                  Chip(
                    label: Text(expiryState),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              _detailLine(
                Icons.description_outlined,
                '${record['documentType'] ?? '-'}',
              ),
              _detailLine(
                Icons.business_outlined,
                '${record['project'] ?? '-'} • '
                '${record['site'] ?? '-'}',
              ),
              _detailLine(
                Icons.place_outlined,
                '${record['location'] ?? '-'}',
              ),
              _detailLine(
                Icons.person_outline,
                'Owner: ${record['owner'] ?? '-'}',
              ),
              _detailLine(
                Icons.history_edu_outlined,
                'Revision: ${record['revision'] ?? '-'}',
              ),
              if (reviewDate != null)
                _detailLine(
                  Icons.event_note_outlined,
                  'Review: ${_dateOnly(reviewDate)}',
                ),
              if (expiryDate != null)
                _detailLine(
                  Icons.event_outlined,
                  'Expiry: ${_dateOnly(expiryDate)}',
                ),
              const SizedBox(height: 8),
              _referenceWrap(record),
            ],
          ),
        ),
      ),
    );
  }

  Widget _detailLine(
    IconData icon,
    String text,
  ) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 18,
            color: darkGreen,
          ),
          const SizedBox(width: 7),
          Expanded(
            child: Text(text),
          ),
        ],
      ),
    );
  }

  Widget _referenceWrap(Map<String, dynamic> record) {
    final refs =
        List<dynamic>.from(record['references'] ?? const []);

    if (refs.isEmpty) {
      return const SizedBox.shrink();
    }

    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: refs.map((item) {
        final map =
            item is Map ? Map<String, dynamic>.from(item) : {};

        final type = '${map['type'] ?? 'Reference'}';
        final id = '${map['id'] ?? ''}';

        return ActionChip(
          avatar: const Icon(
            Icons.link,
            size: 16,
          ),
          label: Text(
            '$type${id.isEmpty ? '' : ': $id'}',
          ),
          onPressed:
              id.isEmpty || widget.sourceOpener == null
                  ? null
                  : () => widget.sourceOpener!(type, id),
        );
      }).toList(),
    );
  }

  void _showDetails(Map<String, dynamic> record) {
    final history =
        List<dynamic>.from(record['history'] ?? const []);

    final refs =
        List<dynamic>.from(record['references'] ?? const []);

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: DraggableScrollableSheet(
            expand: false,
            initialChildSize: 0.86,
            minChildSize: 0.5,
            maxChildSize: 0.95,
            builder: (context, controller) {
              return ListView(
                controller: controller,
                padding:
                    const EdgeInsets.fromLTRB(18, 4, 18, 30),
                children: [
                  Text(
                    '${record['title'] ?? 'Document Record'}',
                    style: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${record['documentId'] ?? '-'}',
                  ),
                  const Divider(height: 28),
                  _detailLine(
                    Icons.category_outlined,
                    'Category: ${record['category']}',
                  ),
                  _detailLine(
                    Icons.description_outlined,
                    'Type: ${record['documentType']}',
                  ),
                  _detailLine(
                    Icons.info_outline,
                    'Status: ${record['status']}',
                  ),
                  _detailLine(
                    Icons.flag_outlined,
                    'Priority: ${record['priority']}',
                  ),
                  _detailLine(
                    Icons.business_outlined,
                    'Project: ${record['project']}',
                  ),
                  _detailLine(
                    Icons.location_city_outlined,
                    'Site: ${record['site']}',
                  ),
                  _detailLine(
                    Icons.place_outlined,
                    'Location: ${record['location']}',
                  ),
                  _detailLine(
                    Icons.person_outline,
                    'Owner: ${record['owner']}',
                  ),
                  _detailLine(
                    Icons.rate_review_outlined,
                    'Reviewer: ${record['reviewer']}',
                  ),
                  _detailLine(
                    Icons.verified_user_outlined,
                    'Approver: ${record['approver']}',
                  ),
                  _detailLine(
                    Icons.account_tree_outlined,
                    'Department: ${record['department']}',
                  ),
                  _detailLine(
                    Icons.history_edu_outlined,
                    'Revision: ${record['revision']}',
                  ),
                  if ('${record['issueDate'] ?? ''}'
                      .trim()
                      .isNotEmpty)
                    _detailLine(
                      Icons.event_outlined,
                      'Issue Date: ${record['issueDate']}',
                    ),
                  if ('${record['reviewDate'] ?? ''}'
                      .trim()
                      .isNotEmpty)
                    _detailLine(
                      Icons.event_note_outlined,
                      'Review Date: ${record['reviewDate']}',
                    ),
                  if ('${record['expiryDate'] ?? ''}'
                      .trim()
                      .isNotEmpty)
                    _detailLine(
                      Icons.timer_outlined,
                      'Expiry Date: ${record['expiryDate']}',
                    ),
                  _sectionText(
                    'Description',
                    '${record['description'] ?? ''}',
                  ),
                  if ('${record['revisionNotes'] ?? ''}'
                      .trim()
                      .isNotEmpty)
                    _sectionText(
                      'Revision Notes',
                      '${record['revisionNotes']}',
                    ),
                  if ('${record['renewalAction'] ?? ''}'
                      .trim()
                      .isNotEmpty)
                    _sectionText(
                      'Review / Renewal Follow-up',
                      '${record['renewalAction']}',
                    ),
                  if ('${record['notes'] ?? ''}'
                      .trim()
                      .isNotEmpty)
                    _sectionText(
                      'Notes',
                      '${record['notes']}',
                    ),
                  if (refs.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    const Text(
                      'Integrated References',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _referenceWrap(record),
                  ],
                  if (history.isNotEmpty) ...[
                    const SizedBox(height: 18),
                    const Text(
                      'History / Audit Trail',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...history.reversed.map(
                      (event) => ListTile(
                        dense: true,
                        leading:
                            const Icon(Icons.history),
                        title: Text(
                          '${event['event'] ?? 'Event'}',
                        ),
                        subtitle: Text(
                          '${event['at'] ?? ''}',
                        ),
                      ),
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

  Widget _sectionText(
    String title,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.only(top: 14),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 5),
          Text(value),
        ],
      ),
    );
  }

  String _dateOnly(DateTime date) {
    return '${date.year.toString().padLeft(4, '0')}-'
        '${date.month.toString().padLeft(2, '0')}-'
        '${date.day.toString().padLeft(2, '0')}';
  }
}

class _DocumentForm extends StatefulWidget {
  const _DocumentForm({
    this.existing,
  });

  final Map<String, dynamic>? existing;

  @override
  State<_DocumentForm> createState() => _DocumentFormState();
}

class _DocumentFormState extends State<_DocumentForm> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _titleController;
  late final TextEditingController _documentIdController;
  late final TextEditingController _projectController;
  late final TextEditingController _siteController;
  late final TextEditingController _locationController;
  late final TextEditingController _ownerController;
  late final TextEditingController _reviewerController;
  late final TextEditingController _approverController;
  late final TextEditingController _departmentController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _revisionController;
  late final TextEditingController _revisionNotesController;
  late final TextEditingController _issueDateController;
  late final TextEditingController _reviewDateController;
  late final TextEditingController _expiryDateController;
  late final TextEditingController _renewalActionController;
  late final TextEditingController _referenceIdController;
  late final TextEditingController _notesController;

  String _category = 'Policy';
  String _documentType = 'Controlled Document';
  String _status = 'Draft';
  String _priority = 'Medium';
  String _referenceType = 'Step 9 Daily HSE';

  bool _reviewRequired = true;
  bool _renewalRequired = false;
  bool _controlledCopy = true;

  @override
  void initState() {
    super.initState();

    final e = widget.existing ?? {};

    _titleController = TextEditingController(
      text: '${e['title'] ?? ''}',
    );

    _documentIdController = TextEditingController(
      text: '${e['documentId'] ?? ''}',
    );

    _projectController = TextEditingController(
      text: '${e['project'] ?? ''}',
    );

    _siteController = TextEditingController(
      text: '${e['site'] ?? ''}',
    );

    _locationController = TextEditingController(
      text: '${e['location'] ?? ''}',
    );

    _ownerController = TextEditingController(
      text: '${e['owner'] ?? ''}',
    );

    _reviewerController = TextEditingController(
      text: '${e['reviewer'] ?? ''}',
    );

    _approverController = TextEditingController(
      text: '${e['approver'] ?? ''}',
    );

    _departmentController = TextEditingController(
      text: '${e['department'] ?? ''}',
    );

    _descriptionController = TextEditingController(
      text: '${e['description'] ?? ''}',
    );

    _revisionController = TextEditingController(
      text: '${e['revision'] ?? 'Rev. 0'}',
    );

    _revisionNotesController = TextEditingController(
      text: '${e['revisionNotes'] ?? ''}',
    );

    _issueDateController = TextEditingController(
      text: '${e['issueDate'] ?? ''}',
    );

    _reviewDateController = TextEditingController(
      text: '${e['reviewDate'] ?? ''}',
    );

    _expiryDateController = TextEditingController(
      text: '${e['expiryDate'] ?? ''}',
    );

    _renewalActionController = TextEditingController(
      text: '${e['renewalAction'] ?? ''}',
    );

    _referenceIdController = TextEditingController(
      text: '${e['referenceId'] ?? ''}',
    );

    _notesController = TextEditingController(
      text: '${e['notes'] ?? ''}',
    );

    _category = '${e['category'] ?? _category}';
    _documentType =
        '${e['documentType'] ?? _documentType}';
    _status = '${e['status'] ?? _status}';
    _priority = '${e['priority'] ?? _priority}';
    _referenceType =
        '${e['referenceType'] ?? _referenceType}';

    _reviewRequired = e['reviewRequired'] != false;
    _renewalRequired = e['renewalRequired'] == true;
    _controlledCopy = e['controlledCopy'] != false;
  }

  @override
  void dispose() {
    for (final controller in [
      _titleController,
      _documentIdController,
      _projectController,
      _siteController,
      _locationController,
      _ownerController,
      _reviewerController,
      _approverController,
      _departmentController,
      _descriptionController,
      _revisionController,
      _revisionNotesController,
      _issueDateController,
      _reviewDateController,
      _expiryDateController,
      _renewalActionController,
      _referenceIdController,
      _notesController,
    ]) {
      controller.dispose();
    }

    super.dispose();
  }

  Future<void> _pickDate(
    TextEditingController controller,
    String title,
  ) async {
    final current =
        DateTime.tryParse(controller.text);

    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      initialDate: current ?? DateTime.now(),
      helpText: title,
    );

    if (picked == null) {
      return;
    }

    controller.text =
        '${picked.year.toString().padLeft(4, '0')}-'
        '${picked.month.toString().padLeft(2, '0')}-'
        '${picked.day.toString().padLeft(2, '0')}';

    setState(() {});
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final references = <Map<String, dynamic>>[];

    if (_referenceIdController.text.trim().isNotEmpty) {
      references.add({
        'type': _referenceType,
        'id': _referenceIdController.text.trim(),
      });
    }

    Navigator.pop(
      context,
      {
        'title': _titleController.text.trim(),
        'documentId':
            _documentIdController.text.trim(),
        'category': _category,
        'documentType': _documentType,
        'status': _status,
        'priority': _priority,
        'project':
            _projectController.text.trim(),
        'site': _siteController.text.trim(),
        'location':
            _locationController.text.trim(),
        'owner': _ownerController.text.trim(),
        'reviewer':
            _reviewerController.text.trim(),
        'approver':
            _approverController.text.trim(),
        'department':
            _departmentController.text.trim(),
        'description':
            _descriptionController.text.trim(),
        'revision':
            _revisionController.text.trim(),
        'revisionNotes':
            _revisionNotesController.text.trim(),
        'issueDate':
            _issueDateController.text.trim(),
        'reviewDate':
            _reviewDateController.text.trim(),
        'expiryDate':
            _expiryDateController.text.trim(),
        'renewalAction':
            _renewalActionController.text.trim(),
        'referenceType': _referenceType,
        'referenceId':
            _referenceIdController.text.trim(),
        'references': references,
        'notes':
            _notesController.text.trim(),
        'reviewRequired': _reviewRequired,
        'renewalRequired': _renewalRequired,
        'controlledCopy': _controlledCopy,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final editing = widget.existing != null;

    return AlertDialog(
      title: Text(
        editing
            ? 'Edit Document / Record'
            : 'New Document / Record',
      ),
      content: SizedBox(
        width: 640,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _textField(
                  _titleController,
                  'Document title',
                  required: true,
                ),
                _textField(
                  _documentIdController,
                  'Document Number / ID',
                  required: true,
                ),
                _dropdown(
                  'Category',
                  _category,
                  const [
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
                  ],
                  (value) {
                    setState(() {
                      _category = value;
                    });
                  },
                ),
                _dropdown(
                  'Document type',
                  _documentType,
                  const [
                    'Controlled Document',
                    'HSE Record',
                    'Certificate',
                    'Permit',
                    'Inspection Record',
                    'Training Record',
                    'Audit Record',
                    'Incident Record',
                    'Other',
                  ],
                  (value) {
                    setState(() {
                      _documentType = value;
                    });
                  },
                ),
                _dropdown(
                  'Status',
                  _status,
                  const [
                    'Draft',
                    'Under Review',
                    'Approved',
                    'Rejected',
                    'Active',
                    'Superseded',
                    'Archived',
                  ],
                  (value) {
                    setState(() {
                      _status = value;
                    });
                  },
                ),
                _dropdown(
                  'Priority',
                  _priority,
                  const [
                    'Low',
                    'Medium',
                    'High',
                    'Critical',
                  ],
                  (value) {
                    setState(() {
                      _priority = value;
                    });
                  },
                ),
                _textField(
                  _projectController,
                  'Project',
                ),
                _textField(
                  _siteController,
                  'Site',
                ),
                _textField(
                  _locationController,
                  'Location / Area',
                ),
                _textField(
                  _departmentController,
                  'Department',
                ),
                _textField(
                  _ownerController,
                  'Document Owner / Responsible Person',
                ),
                _textField(
                  _reviewerController,
                  'Reviewer',
                ),
                _textField(
                  _approverController,
                  'Approver',
                ),
                _textField(
                  _revisionController,
                  'Revision Number',
                ),
                _textField(
                  _descriptionController,
                  'Description / Purpose',
                  maxLines: 4,
                ),
                _textField(
                  _revisionNotesController,
                  'Revision Notes',
                  maxLines: 3,
                ),
                _dateTile(
                  'Issue Date',
                  _issueDateController,
                  () => _pickDate(
                    _issueDateController,
                    'Select Issue Date',
                  ),
                ),
                _dateTile(
                  'Review Date',
                  _reviewDateController,
                  () => _pickDate(
                    _reviewDateController,
                    'Select Review Date',
                  ),
                ),
                _dateTile(
                  'Expiry Date',
                  _expiryDateController,
                  () => _pickDate(
                    _expiryDateController,
                    'Select Expiry Date',
                  ),
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text(
                    'Review required',
                  ),
                  value: _reviewRequired,
                  onChanged: (value) {
                    setState(() {
                      _reviewRequired = value;
                    });
                  },
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text(
                    'Renewal required',
                  ),
                  value: _renewalRequired,
                  onChanged: (value) {
                    setState(() {
                      _renewalRequired = value;
                    });
                  },
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text(
                    'Controlled copy',
                  ),
                  value: _controlledCopy,
                  onChanged: (value) {
                    setState(() {
                      _controlledCopy = value;
                    });
                  },
                ),
                _textField(
                  _renewalActionController,
                  'Review / Renewal Follow-up',
                  maxLines: 3,
                ),
                const Divider(height: 22),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Integration Reference',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                _dropdown(
                  'Reference source',
                  _referenceType,
                  const [
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
                  ],
                  (value) {
                    setState(() {
                      _referenceType = value;
                    });
                  },
                ),
                _textField(
                  _referenceIdController,
                  'Reference ID',
                ),
                _textField(
                  _notesController,
                  'Notes',
                  maxLines: 3,
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton.icon(
          onPressed: _submit,
          icon: const Icon(
            Icons.save_outlined,
          ),
          label: Text(
            editing ? 'Update' : 'Save',
          ),
        ),
      ],
    );
  }

  Widget _textField(
    TextEditingController controller,
    String label, {
    bool required = false,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 10,
      ),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: required
            ? (value) {
                if (value == null ||
                    value.trim().isEmpty) {
                  return 'Required';
                }

                return null;
              }
            : null,
      ),
    );
  }

  Widget _dropdown(
    String label,
    String value,
    List<String> values,
    ValueChanged<String> onChanged,
  ) {
    final safeValue =
        values.contains(value) ? value : values.first;

    return Padding(
      padding: const EdgeInsets.only(
        bottom: 10,
      ),
      child: DropdownButtonFormField<String>(
        value: safeValue,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        items: values
            .map(
              (item) => DropdownMenuItem<String>(
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

  Widget _dateTile(
    String title,
    TextEditingController controller,
    VoidCallback onTap,
  ) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title),
      subtitle: Text(
        controller.text.isEmpty
            ? 'Not set'
            : controller.text,
      ),
      trailing: IconButton(
        onPressed: onTap,
        icon: const Icon(
          Icons.calendar_month_outlined,
        ),
      ),
    );
  }
}
