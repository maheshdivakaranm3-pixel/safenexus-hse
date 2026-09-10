import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// SafeNexus HSE - Step 2F
/// HSE Document Control & Master Register
///
/// Self-contained module.
/// Stores document-control records locally using SharedPreferences.
/// Includes document status, controlled-copy status and revision history.
class HseDocumentControlPage extends StatefulWidget {
  const HseDocumentControlPage({super.key});

  @override
  State<HseDocumentControlPage> createState() =>
      _HseDocumentControlPageState();
}

class _HseDocumentControlPageState
    extends State<HseDocumentControlPage> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);

  static const String _storageKey =
      'safenexus_hse_document_control_records';

  final TextEditingController _searchController =
      TextEditingController();

  List<Map<String, dynamic>> _records = [];
  String _filter = 'All';
  bool _loaded = false;

  final List<String> _documentTypes = const [
    'Policy',
    'Plan',
    'Procedure',
    'Method Statement',
    'Risk Assessment',
    'Form / Checklist',
    'Register',
    'Report',
    'Certificate',
    'Emergency Document',
    'Training Document',
    'Inspection Document',
    'Audit Document',
    'Legal / Authority Document',
    'Other',
  ];

  final List<String> _categories = const [
    'HSE General',
    'Risk Management',
    'Permit to Work',
    'Emergency',
    'Training & Competency',
    'Inspection & Audit',
    'Incident Management',
    'Occupational Health',
    'Environmental',
    'Equipment & Machinery',
    'High-Risk Activities',
    'Welfare',
    'HSE Reporting',
    'Legal / Compliance',
    'Other',
  ];

  final List<String> _statuses = const [
    'Draft',
    'Under Review',
    'Approved',
    'Active',
    'Superseded',
    'Archived',
  ];

  final List<String> _copyTypes = const [
    'Controlled Copy',
    'Uncontrolled Copy',
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
                (item) => Map<String, dynamic>.from(item),
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
      _loaded = true;
    });
  }

  Future<void> _saveRecords() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(
      _storageKey,
      jsonEncode(_records),
    );
  }

  void _refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  List<Map<String, dynamic>> get _filteredRecords {
    final query = _searchController.text.trim().toLowerCase();

    return _records.where((record) {
      final status = (record['status'] ?? '').toString();

      final matchesFilter =
          _filter == 'All' || status == _filter;

      if (!matchesFilter) {
        return false;
      }

      if (query.isEmpty) {
        return true;
      }

      final searchable = [
        record['documentNo'],
        record['title'],
        record['documentType'],
        record['category'],
        record['revision'],
        record['issueDate'],
        record['reviewDate'],
        record['owner'],
        record['preparedBy'],
        record['approvedBy'],
        record['status'],
        record['copyType'],
        record['distribution'],
        record['description'],
        record['requirements'],
      ].join(' ').toLowerCase();

      return searchable.contains(query);
    }).toList();
  }

  int get _totalCount => _records.length;

  int get _draftCount => _records.where(
        (record) => record['status'] == 'Draft',
      ).length;

  int get _reviewCount => _records.where(
        (record) => record['status'] == 'Under Review',
      ).length;

  int get _approvedCount => _records.where(
        (record) => record['status'] == 'Approved',
      ).length;

  int get _activeCount => _records.where(
        (record) => record['status'] == 'Active',
      ).length;

  int get _supersededCount => _records.where(
        (record) => record['status'] == 'Superseded',
      ).length;

  int get _archivedCount => _records.where(
        (record) => record['status'] == 'Archived',
      ).length;

  Future<void> _openDocumentForm({
    Map<String, dynamic>? record,
  }) async {
    final isEditing = record != null;

    final result =
        await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return _DocumentFormSheet(
          record: record,
          documentTypes: _documentTypes,
          categories: _categories,
          statuses: _statuses,
          copyTypes: _copyTypes,
        );
      },
    );

    if (result == null) {
      return;
    }

    final existingId = result['id']?.toString();

    setState(() {
      final index = _records.indexWhere(
        (item) => item['id']?.toString() == existingId,
      );

      if (index >= 0) {
        _records[index] = result;
      } else {
        _records.insert(0, result);
      }
    });

    await _saveRecords();

    if (!mounted) return;

    _showMessage(
      isEditing
          ? 'Document updated successfully.'
          : 'Document saved successfully.',
    );
  }

  Future<void> _deleteDocument(
    Map<String, dynamic> record,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Delete Document?'),
          content: Text(
            'Delete "${record['title'] ?? 'this document'}" '
            'from the master register?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, false);
              },
              child: const Text('Cancel'),
            ),
            FilledButton(
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
      _records.removeWhere(
        (item) =>
            item['id']?.toString() ==
            record['id']?.toString(),
      );
    });

    await _saveRecords();

    if (!mounted) return;

    _showMessage('Document deleted.');
  }

  void _showMessage(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'Draft':
        return Colors.blue;
      case 'Under Review':
        return Colors.orange;
      case 'Approved':
        return Colors.teal;
      case 'Active':
        return Colors.green;
      case 'Superseded':
        return Colors.deepOrange;
      case 'Archived':
        return Colors.blueGrey;
      default:
        return Colors.grey;
    }
  }

  Widget _summaryCard() {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: primaryGreen.withValues(
                      alpha: 0.10,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.library_books_outlined,
                    color: primaryGreen,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    'HSE Document Master Register',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: darkGreen,
                    ),
                  ),
                ),
                Text(
                  _totalCount.toString(),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    color: primaryGreen,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: _metric(
                    'Total',
                    _totalCount.toString(),
                    Icons.list_alt_outlined,
                  ),
                ),
                Expanded(
                  child: _metric(
                    'Active',
                    _activeCount.toString(),
                    Icons.check_circle_outline,
                  ),
                ),
                Expanded(
                  child: _metric(
                    'Review',
                    _reviewCount.toString(),
                    Icons.rate_review_outlined,
                  ),
                ),
                Expanded(
                  child: _metric(
                    'Draft',
                    _draftCount.toString(),
                    Icons.edit_note_outlined,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _metric(
                    'Approved',
                    _approvedCount.toString(),
                    Icons.verified_outlined,
                  ),
                ),
                Expanded(
                  child: _metric(
                    'Superseded',
                    _supersededCount.toString(),
                    Icons.swap_horiz_outlined,
                  ),
                ),
                Expanded(
                  child: _metric(
                    'Archived',
                    _archivedCount.toString(),
                    Icons.archive_outlined,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _metric(
    String label,
    String value,
    IconData icon,
  ) {
    return Column(
      children: [
        Icon(
          icon,
          size: 20,
          color: primaryGreen,
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w900,
          ),
        ),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 10,
            color: Colors.grey.shade700,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _filters() {
    return Column(
      children: [
        TextField(
          controller: _searchController,
          decoration: InputDecoration(
            labelText: 'Search documents',
            prefixIcon: const Icon(Icons.search),
            suffixIcon: _searchController.text.isEmpty
                ? null
                : IconButton(
                    onPressed: _searchController.clear,
                    icon: const Icon(Icons.clear),
                  ),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              'All',
              ..._statuses,
            ].map((status) {
              final selected = _filter == status;

              return Padding(
                padding: const EdgeInsets.only(
                  right: 8,
                ),
                child: ChoiceChip(
                  label: Text(status),
                  selected: selected,
                  onSelected: (_) {
                    setState(() {
                      _filter = status;
                    });
                  },
                  selectedColor:
                      primaryGreen.withValues(
                    alpha: 0.18,
                  ),
                  labelStyle: TextStyle(
                    color: selected
                        ? darkGreen
                        : Colors.black87,
                    fontWeight: selected
                        ? FontWeight.w800
                        : FontWeight.w500,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _documentCard(
    Map<String, dynamic> record,
  ) {
    final status =
        (record['status'] ?? 'Draft').toString();

    final statusColor = _statusColor(status);

    final history = record['history'];

    final historyCount =
        history is List ? history.length : 0;

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () {
          _openDocumentForm(record: record);
        },
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
                      (record['title'] ??
                              'Untitled Document')
                          .toString(),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: darkGreen,
                      ),
                    ),
                  ),
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'edit') {
                        _openDocumentForm(
                          record: record,
                        );
                      } else if (value == 'history') {
                        _showHistory(record);
                      } else if (value == 'delete') {
                        _deleteDocument(record);
                      }
                    },
                    itemBuilder: (context) => const [
                      PopupMenuItem(
                        value: 'edit',
                        child: Text('Edit'),
                      ),
                      PopupMenuItem(
                        value: 'history',
                        child: Text('Revision History'),
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
                spacing: 8,
                runSpacing: 8,
                children: [
                  _tag(
                    'No: ${(record['documentNo'] ?? '-')}',
                    Icons.numbers_outlined,
                  ),
                  _tag(
                    'Rev: ${(record['revision'] ?? '-')}',
                    Icons.history_outlined,
                  ),
                  _tag(
                    (record['documentType'] ?? 'Other')
                        .toString(),
                    Icons.description_outlined,
                  ),
                  _statusTag(
                    status,
                    statusColor,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: _valueLine(
                      'Category',
                      (record['category'] ?? '-')
                          .toString(),
                    ),
                  ),
                  Expanded(
                    child: _valueLine(
                      'Copy Type',
                      (record['copyType'] ?? '-')
                          .toString(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              if ((record['description'] ?? '')
                  .toString()
                  .isNotEmpty)
                Text(
                  (record['description'] ?? '')
                      .toString(),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.grey.shade800,
                    fontSize: 13,
                  ),
                ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: _valueLine(
                      'Issue Date',
                      (record['issueDate'] ?? '-')
                          .toString(),
                    ),
                  ),
                  Expanded(
                    child: _valueLine(
                      'Review / Expiry',
                      (record['reviewDate'] ?? '-')
                          .toString(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: _valueLine(
                      'Owner',
                      (record['owner'] ?? '-')
                          .toString(),
                    ),
                  ),
                  Expanded(
                    child: _valueLine(
                      'Approved By',
                      (record['approvedBy'] ?? '-')
                          .toString(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              _valueLine(
                'Distribution / Applicable Location',
                (record['distribution'] ?? '-')
                    .toString(),
              ),
              if ((record['requirements'] ?? '')
                  .toString()
                  .isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  'Key Requirements: '
                  '${record['requirements']}',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 12,
                  ),
                ),
              ],
              if (historyCount > 0) ...[
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(
                      Icons.history,
                      size: 15,
                      color: primaryGreen,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      '$historyCount revision'
                      '${historyCount == 1 ? '' : 's'} in history',
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: primaryGreen,
                      ),
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

  Widget _tag(
    String text,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: Colors.grey.withValues(
          alpha: 0.10,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
          ),
          const SizedBox(width: 4),
          Text(
            text,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusTag(
    String status,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: color.withValues(
          alpha: 0.12,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  Widget _valueLine(
    String label,
    String value,
  ) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 11,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 13,
          ),
        ),
      ],
    );
  }

  Future<void> _showHistory(
    Map<String, dynamic> record,
  ) async {
    final rawHistory = record['history'];

    final history = rawHistory is List
        ? rawHistory
            .whereType<Map>()
            .map(
              (item) =>
                  Map<String, dynamic>.from(item),
            )
            .toList()
        : <Map<String, dynamic>>[];

    if (!mounted) return;

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return SafeArea(
          child: Container(
            height:
                MediaQuery.sizeOf(sheetContext).height *
                    0.75,
            decoration: const BoxDecoration(
              color: pageBackground,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(22),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 10),
                Container(
                  width: 42,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius:
                        BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(height: 14),
                const Text(
                  'Document Revision History',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: darkGreen,
                  ),
                ),
                const SizedBox(height: 4),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: Text(
                    (record['title'] ?? '')
                        .toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                Expanded(
                  child: history.isEmpty
                      ? const Center(
                          child: Text(
                            'No revision history available.',
                          ),
                        )
                      : ListView.builder(
                          padding:
                              const EdgeInsets.fromLTRB(
                            16,
                            0,
                            16,
                            20,
                          ),
                          itemCount: history.length,
                          itemBuilder:
                              (context, index) {
                            final item =
                                history[index];

                            return Card(
                              elevation: 0,
                              margin:
                                  const EdgeInsets.only(
                                bottom: 10,
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.all(
                                  14,
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment
                                          .start,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons
                                              .history_outlined,
                                          color:
                                              primaryGreen,
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Expanded(
                                          child: Text(
                                            'Revision '
                                            '${item['revision'] ?? '-'}',
                                            style:
                                                const TextStyle(
                                              fontWeight:
                                                  FontWeight
                                                      .w800,
                                              color:
                                                  darkGreen,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                        height: 8),
                                    _historyLine(
                                      'Date',
                                      (item['date'] ??
                                              '-')
                                          .toString(),
                                    ),
                                    _historyLine(
                                      'Status',
                                      (item['status'] ??
                                              '-')
                                          .toString(),
                                    ),
                                    _historyLine(
                                      'Owner',
                                      (item['owner'] ??
                                              '-')
                                          .toString(),
                                    ),
                                    _historyLine(
                                      'Approved By',
                                      (item['approvedBy'] ??
                                              '-')
                                          .toString(),
                                    ),
                                  ],
                                ),
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

  Widget _historyLine(
    String label,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 82,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!_loaded) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final records = _filteredRecords;

    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: darkGreen,
        elevation: 0,
        title: const Text(
          'HSE Document Control',
          style: TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      floatingActionButton:
          FloatingActionButton.extended(
        onPressed: () {
          _openDocumentForm();
        },
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text(
          'Add Document',
          style: TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
          16,
          16,
          16,
          100,
        ),
        children: [
          _summaryCard(),
          const SizedBox(height: 16),
          _filters(),
          const SizedBox(height: 16),
          if (_records.isEmpty)
            _emptyState()
          else if (records.isEmpty)
            _noResults()
          else
            ...records.map(_documentCard),
        ],
      ),
    );
  }

  Widget _emptyState() {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          children: [
            const Icon(
              Icons.library_books_outlined,
              size: 48,
              color: primaryGreen,
            ),
            const SizedBox(height: 12),
            const Text(
              'No controlled documents yet',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w800,
                color: darkGreen,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Add your first document to start '
              'building the HSE master register.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: () {
                _openDocumentForm();
              },
              icon: const Icon(Icons.add),
              label: const Text(
                'Add First Document',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _noResults() {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Icon(
              Icons.search_off,
              size: 42,
            ),
            const SizedBox(height: 10),
            const Text(
              'No matching documents',
              style: TextStyle(
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Try another search term or status filter.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _DocumentFormSheet extends StatefulWidget {
  final Map<String, dynamic>? record;
  final List<String> documentTypes;
  final List<String> categories;
  final List<String> statuses;
  final List<String> copyTypes;

  const _DocumentFormSheet({
    required this.record,
    required this.documentTypes,
    required this.categories,
    required this.statuses,
    required this.copyTypes,
  });

  @override
  State<_DocumentFormSheet> createState() =>
      _DocumentFormSheetState();
}

class _DocumentFormSheetState
    extends State<_DocumentFormSheet> {
  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>();

  late final TextEditingController _documentNoController;
  late final TextEditingController _titleController;
  late final TextEditingController _revisionController;
  late final TextEditingController _issueDateController;
  late final TextEditingController _reviewDateController;
  late final TextEditingController _ownerController;
  late final TextEditingController _preparedByController;
  late final TextEditingController _approvedByController;
  late final TextEditingController _distributionController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _requirementsController;

  late String _documentType;
  late String _category;
  late String _status;
  late String _copyType;

  @override
  void initState() {
    super.initState();

    final record = widget.record;

    _documentNoController = TextEditingController(
      text: record?['documentNo']?.toString() ?? '',
    );

    _titleController = TextEditingController(
      text: record?['title']?.toString() ?? '',
    );

    _revisionController = TextEditingController(
      text: record?['revision']?.toString() ?? 'Rev 00',
    );

    _issueDateController = TextEditingController(
      text: record?['issueDate']?.toString() ?? '',
    );

    _reviewDateController = TextEditingController(
      text: record?['reviewDate']?.toString() ?? '',
    );

    _ownerController = TextEditingController(
      text: record?['owner']?.toString() ?? '',
    );

    _preparedByController = TextEditingController(
      text: record?['preparedBy']?.toString() ?? '',
    );

    _approvedByController = TextEditingController(
      text: record?['approvedBy']?.toString() ?? '',
    );

    _distributionController = TextEditingController(
      text: record?['distribution']?.toString() ?? '',
    );

    _descriptionController = TextEditingController(
      text: record?['description']?.toString() ?? '',
    );

    _requirementsController = TextEditingController(
      text: record?['requirements']?.toString() ?? '',
    );

    _documentType = widget.documentTypes.contains(
      record?['documentType'],
    )
        ? record!['documentType'].toString()
        : widget.documentTypes.first;

    _category = widget.categories.contains(
      record?['category'],
    )
        ? record!['category'].toString()
        : widget.categories.first;

    _status = widget.statuses.contains(
      record?['status'],
    )
        ? record!['status'].toString()
        : 'Draft';

    _copyType = widget.copyTypes.contains(
      record?['copyType'],
    )
        ? record!['copyType'].toString()
        : widget.copyTypes.first;
  }

  @override
  void dispose() {
    _documentNoController.dispose();
    _titleController.dispose();
    _revisionController.dispose();
    _issueDateController.dispose();
    _reviewDateController.dispose();
    _ownerController.dispose();
    _preparedByController.dispose();
    _approvedByController.dispose();
    _distributionController.dispose();
    _descriptionController.dispose();
    _requirementsController.dispose();
    super.dispose();
  }

  InputDecoration _decoration(
    String label, {
    String? hint,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: Colors.grey.shade300,
        ),
      ),
    );
  }

  Widget _field(
    TextEditingController controller,
    String label, {
    bool required = false,
    String? hint,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 12,
      ),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        decoration: _decoration(
          label,
          hint: hint,
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

  Widget _dropdown(
    String label,
    String value,
    List<String> items,
    ValueChanged<String?> onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 12,
      ),
      child: DropdownButtonFormField<String>(
        initialValue: value,
        decoration: _decoration(label),
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

  Future<void> _pickDate(
    TextEditingController controller,
  ) async {
    final now = DateTime.now();

    DateTime initialDate = now;

    final existing = DateTime.tryParse(
      controller.text.trim(),
    );

    if (existing != null) {
      initialDate = existing;
    }

    final selected = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (selected == null) {
      return;
    }

    final month =
        selected.month.toString().padLeft(2, '0');

    final day =
        selected.day.toString().padLeft(2, '0');

    controller.text =
        '${selected.year}-$month-$day';
  }

  List<Map<String, dynamic>> _buildHistory(
    Map<String, dynamic>? oldRecord,
  ) {
    final history = <Map<String, dynamic>>[];

    if (oldRecord != null) {
      final oldHistory = oldRecord['history'];

      if (oldHistory is List) {
        for (final item in oldHistory) {
          if (item is Map) {
            history.add(
              Map<String, dynamic>.from(item),
            );
          }
        }
      }

      final oldRevision =
          oldRecord['revision']?.toString() ?? '';

      if (oldRevision.isNotEmpty) {
        history.insert(
          0,
          {
            'revision': oldRevision,
            'date':
                oldRecord['updatedAt']?.toString() ??
                    DateTime.now()
                        .toIso8601String(),
            'status':
                oldRecord['status']?.toString() ??
                    'Draft',
            'owner':
                oldRecord['owner']?.toString() ??
                    '',
            'approvedBy':
                oldRecord['approvedBy']?.toString() ??
                    '',
          },
        );
      }
    }

    final unique = <String>{};
    final cleaned = <Map<String, dynamic>>[];

    for (final item in history) {
      final key = [
        item['revision'],
        item['date'],
        item['status'],
        item['owner'],
      ].join('|');

      if (unique.add(key)) {
        cleaned.add(item);
      }
    }

    return cleaned;
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final existingId =
        widget.record?['id']?.toString();

    final id = existingId == null ||
            existingId.isEmpty
        ? DateTime.now()
            .microsecondsSinceEpoch
            .toString()
        : existingId;

    final now =
        DateTime.now().toIso8601String();

    final history = _buildHistory(
      widget.record,
    );

    final record = <String, dynamic>{
      'id': id,
      'documentNo':
          _documentNoController.text.trim(),
      'title':
          _titleController.text.trim(),
      'documentType':
          _documentType,
      'category':
          _category,
      'revision':
          _revisionController.text.trim(),
      'issueDate':
          _issueDateController.text.trim(),
      'reviewDate':
          _reviewDateController.text.trim(),
      'owner':
          _ownerController.text.trim(),
      'preparedBy':
          _preparedByController.text.trim(),
      'approvedBy':
          _approvedByController.text.trim(),
      'status':
          _status,
      'copyType':
          _copyType,
      'distribution':
          _distributionController.text.trim(),
      'description':
          _descriptionController.text.trim(),
      'requirements':
          _requirementsController.text.trim(),
      'updatedAt':
          now,
      'history':
          history,
    };

    Navigator.pop(context, record);
  }

  @override
  Widget build(BuildContext context) {
    final bottom =
        MediaQuery.viewInsetsOf(context).bottom;

    return SafeArea(
      child: Container(
        height:
            MediaQuery.sizeOf(context).height *
                0.94,
        padding: EdgeInsets.fromLTRB(
          16,
          10,
          16,
          bottom + 16,
        ),
        decoration: const BoxDecoration(
          color: Color(0xFFF6F8F7),
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(22),
          ),
        ),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Center(
                child: Container(
                  width: 42,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius:
                        BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Text(
                widget.record == null
                    ? 'Add HSE Document'
                    : 'Edit HSE Document',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF0B5D4B),
                ),
              ),
              const SizedBox(height: 16),

              _field(
                _documentNoController,
                'Document Number',
                required: true,
                hint:
                    'Example: SN-HSE-DOC-001',
              ),

              _field(
                _titleController,
                'Document Title',
                required: true,
                maxLines: 2,
                hint:
                    'Example: HSE Management Plan',
              ),

              _dropdown(
                'Document Type',
                _documentType,
                widget.documentTypes,
                (value) {
                  if (value != null) {
                    setState(() {
                      _documentType = value;
                    });
                  }
                },
              ),

              _dropdown(
                'Category',
                _category,
                widget.categories,
                (value) {
                  if (value != null) {
                    setState(() {
                      _category = value;
                    });
                  }
                },
              ),

              _field(
                _revisionController,
                'Revision Number',
                required: true,
                hint: 'Example: Rev 00',
              ),

              _field(
                _issueDateController,
                'Issue Date',
                required: true,
                hint: 'Select or enter date',
              ),

              Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  onPressed: () {
                    _pickDate(
                      _issueDateController,
                    );
                  },
                  icon: const Icon(
                    Icons.calendar_month,
                  ),
                  label:
                      const Text('Pick Date'),
                ),
              ),

              _field(
                _reviewDateController,
                'Review / Expiry Date',
                required: true,
                hint: 'Select or enter date',
              ),

              Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  onPressed: () {
                    _pickDate(
                      _reviewDateController,
                    );
                  },
                  icon: const Icon(
                    Icons.calendar_month,
                  ),
                  label:
                      const Text('Pick Date'),
                ),
              ),

              _field(
                _ownerController,
                'Document Owner',
                required: true,
                hint:
                    'Example: HSE Manager',
              ),

              _field(
                _preparedByController,
                'Prepared By',
                required: true,
                hint:
                    'Example: HSE Officer',
              ),

              _field(
                _approvedByController,
                'Approved By',
                required: false,
                hint:
                    'Example: Project Manager',
              ),

              _dropdown(
                'Approval / Document Status',
                _status,
                widget.statuses,
                (value) {
                  if (value != null) {
                    setState(() {
                      _status = value;
                    });
                  }
                },
              ),

              _dropdown(
                'Copy Control',
                _copyType,
                widget.copyTypes,
                (value) {
                  if (value != null) {
                    setState(() {
                      _copyType = value;
                    });
                  }
                },
              ),

              _field(
                _distributionController,
                'Distribution / Applicable Location',
                required: true,
                maxLines: 2,
                hint:
                    'Example: Project Site / HSE Department / All Supervisors',
              ),

              _field(
                _descriptionController,
                'Description',
                required: true,
                maxLines: 4,
                hint:
                    'Describe the purpose, scope and use of this document.',
              ),

              _field(
                _requirementsController,
                'Key Requirements',
                required: false,
                maxLines: 5,
                hint:
                    'List important controls, responsibilities or document requirements.',
              ),

              const SizedBox(height: 8),

              SizedBox(
                height: 52,
                child: FilledButton.icon(
                  onPressed: _submit,
                  icon: const Icon(
                    Icons.save_outlined,
                  ),
                  label: Text(
                    widget.record == null
                        ? 'Save Document'
                        : 'Update Document',
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  style:
                      FilledButton.styleFrom(
                    backgroundColor:
                        const Color(0xFF159447),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
