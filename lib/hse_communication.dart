import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// SafeNexus HSE - Step 2G
/// HSE Communication & Consultation Register
///
/// Self-contained module.
/// Stores communication and consultation records locally
/// using SharedPreferences.
class HseCommunicationPage extends StatefulWidget {
  const HseCommunicationPage({super.key});

  @override
  State<HseCommunicationPage> createState() =>
      _HseCommunicationPageState();
}

class _HseCommunicationPageState
    extends State<HseCommunicationPage> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);

  static const String _storageKey =
      'safenexus_hse_communication_records';

  final TextEditingController _searchController =
      TextEditingController();

  List<Map<String, dynamic>> _records = [];
  String _filter = 'All';
  bool _loaded = false;

  final List<String> _communicationTypes = const [
    'Toolbox Talk',
    'HSE Meeting',
    'Safety Briefing',
    'Consultation',
    'Awareness Session',
    'Safety Campaign',
    'Emergency Communication',
    'Induction',
    'Training Session',
    'Other',
  ];

  final List<String> _statuses = const [
    'Open',
    'In Progress',
    'Completed',
    'Cancelled',
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
      final status =
          (record['status'] ?? '').toString();

      final matchesFilter =
          _filter == 'All' || status == _filter;

      if (!matchesFilter) {
        return false;
      }

      if (query.isEmpty) {
        return true;
      }

      final searchable = [
        record['communicationNo'],
        record['date'],
        record['time'],
        record['location'],
        record['communicationType'],
        record['subject'],
        record['conductedBy'],
        record['department'],
        record['attendees'],
        record['issues'],
        record['actions'],
        record['actionOwner'],
        record['dueDate'],
        record['status'],
        record['remarks'],
      ].join(' ').toLowerCase();

      return searchable.contains(query);
    }).toList();
  }

  int get _totalCount => _records.length;

  int get _openCount => _records.where(
        (record) => record['status'] == 'Open',
      ).length;

  int get _inProgressCount => _records.where(
        (record) => record['status'] == 'In Progress',
      ).length;

  int get _completedCount => _records.where(
        (record) => record['status'] == 'Completed',
      ).length;

  Future<void> _openCommunicationForm({
    Map<String, dynamic>? record,
  }) async {
    final isEditing = record != null;

    final result =
        await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return _CommunicationFormSheet(
          record: record,
          communicationTypes: _communicationTypes,
          statuses: _statuses,
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
          ? 'Communication record updated successfully.'
          : 'Communication record saved successfully.',
    );
  }

  Future<void> _deleteCommunication(
    Map<String, dynamic> record,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text(
            'Delete Communication Record?',
          ),
          content: Text(
            'Delete "${record['subject'] ?? 'this record'}" '
            'from the communication register?',
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

    _showMessage('Communication record deleted.');
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
      case 'Open':
        return Colors.orange;
      case 'In Progress':
        return Colors.blue;
      case 'Completed':
        return Colors.green;
      case 'Cancelled':
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
                    Icons.groups_outlined,
                    color: primaryGreen,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    'HSE Communication & Consultation',
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
                    'Open',
                    _openCount.toString(),
                    Icons.pending_actions_outlined,
                  ),
                ),
                Expanded(
                  child: _metric(
                    'Progress',
                    _inProgressCount.toString(),
                    Icons.autorenew_outlined,
                  ),
                ),
                Expanded(
                  child: _metric(
                    'Done',
                    _completedCount.toString(),
                    Icons.check_circle_outline,
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
            fontSize: 11,
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
            labelText:
                'Search communication records',
            prefixIcon: const Icon(Icons.search),
            suffixIcon: _searchController.text.isEmpty
                ? null
                : IconButton(
                    onPressed:
                        _searchController.clear,
                    icon: const Icon(Icons.clear),
                  ),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(12),
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

  Widget _communicationCard(
    Map<String, dynamic> record,
  ) {
    final status =
        (record['status'] ?? 'Open').toString();

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
          _openCommunicationForm(
            record: record,
          );
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
                      (record['subject'] ??
                              'Untitled Communication')
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
                        _openCommunicationForm(
                          record: record,
                        );
                      } else if (value == 'history') {
                        _showHistory(record);
                      } else if (value == 'delete') {
                        _deleteCommunication(
                          record,
                        );
                      }
                    },
                    itemBuilder: (context) => const [
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
                spacing: 8,
                runSpacing: 8,
                children: [
                  _tag(
                    'No: '
                    '${record['communicationNo'] ?? '-'}',
                    Icons.numbers_outlined,
                  ),
                  _tag(
                    (record['communicationType'] ??
                            'Other')
                        .toString(),
                    Icons.forum_outlined,
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
                      'Date',
                      (record['date'] ?? '-')
                          .toString(),
                    ),
                  ),
                  Expanded(
                    child: _valueLine(
                      'Time',
                      (record['time'] ?? '-')
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
                      'Location',
                      (record['location'] ?? '-')
                          .toString(),
                    ),
                  ),
                  Expanded(
                    child: _valueLine(
                      'Conducted By',
                      (record['conductedBy'] ?? '-')
                          .toString(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              _valueLine(
                'Department / Work Group',
                (record['department'] ?? '-')
                    .toString(),
              ),
              const SizedBox(height: 8),
              _valueLine(
                'Attendees',
                (record['attendees'] ?? '-')
                    .toString(),
              ),
              if ((record['issues'] ?? '')
                  .toString()
                  .isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  'Key Safety Issues: '
                  '${record['issues']}',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.grey.shade800,
                    fontSize: 12,
                  ),
                ),
              ],
              if ((record['actions'] ?? '')
                  .toString()
                  .isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  'Actions / Recommendations: '
                  '${record['actions']}',
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 12,
                  ),
                ),
              ],
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: _valueLine(
                      'Action Owner',
                      (record['actionOwner'] ??
                              '-')
                          .toString(),
                    ),
                  ),
                  Expanded(
                    child: _valueLine(
                      'Due Date',
                      (record['dueDate'] ?? '-')
                          .toString(),
                    ),
                  ),
                ],
              ),
              if ((record['remarks'] ?? '')
                  .toString()
                  .isNotEmpty) ...[
                const SizedBox(height: 8),
                _valueLine(
                  'Remarks',
                  (record['remarks'] ?? '')
                      .toString(),
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
                      '$historyCount update'
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
        borderRadius:
            BorderRadius.circular(20),
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
        borderRadius:
            BorderRadius.circular(20),
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
                MediaQuery.sizeOf(sheetContext)
                        .height *
                    0.75,
            decoration: const BoxDecoration(
              color: pageBackground,
              borderRadius:
                  BorderRadius.vertical(
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
                  'Communication History',
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
                    (record['subject'] ?? '')
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
                            'No history available.',
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
                          itemCount:
                              history.length,
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
                                            (item['type'] ??
                                                    'Update')
                                                .toString(),
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
                                      height: 8,
                                    ),
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
                                      'Updated By',
                                      (item['updatedBy'] ??
                                              '-')
                                          .toString(),
                                    ),
                                    _historyLine(
                                      'Remarks',
                                      (item['remarks'] ??
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
      padding:
          const EdgeInsets.only(bottom: 4),
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
          'HSE Communication',
          style: TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      floatingActionButton:
          FloatingActionButton.extended(
        onPressed: () {
          _openCommunicationForm();
        },
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text(
          'Add Communication',
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
            ...records.map(_communicationCard),
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
              Icons.groups_outlined,
              size: 48,
              color: primaryGreen,
            ),
            const SizedBox(height: 12),
            const Text(
              'No communication records yet',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w800,
                color: darkGreen,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Add your first HSE communication '
              'or consultation record.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: () {
                _openCommunicationForm();
              },
              icon: const Icon(Icons.add),
              label: const Text(
                'Add First Record',
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
              'No matching records',
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

class _CommunicationFormSheet
    extends StatefulWidget {
  final Map<String, dynamic>? record;
  final List<String> communicationTypes;
  final List<String> statuses;

  const _CommunicationFormSheet({
    required this.record,
    required this.communicationTypes,
    required this.statuses,
  });

  @override
  State<_CommunicationFormSheet> createState() =>
      _CommunicationFormSheetState();
}

class _CommunicationFormSheetState
    extends State<_CommunicationFormSheet> {
  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>();

  late final TextEditingController
      _communicationNoController;

  late final TextEditingController
      _dateController;

  late final TextEditingController
      _timeController;

  late final TextEditingController
      _locationController;

  late final TextEditingController
      _subjectController;

  late final TextEditingController
      _conductedByController;

  late final TextEditingController
      _departmentController;

  late final TextEditingController
      _attendeesController;

  late final TextEditingController
      _issuesController;

  late final TextEditingController
      _actionsController;

  late final TextEditingController
      _actionOwnerController;

  late final TextEditingController
      _dueDateController;

  late final TextEditingController
      _updatedByController;

  late final TextEditingController
      _remarksController;

  late String _communicationType;
  late String _status;

  @override
  void initState() {
    super.initState();

    final record = widget.record;

    _communicationNoController =
        TextEditingController(
      text:
          record?['communicationNo']
                  ?.toString() ??
              '',
    );

    _dateController =
        TextEditingController(
      text:
          record?['date']?.toString() ?? '',
    );

    _timeController =
        TextEditingController(
      text:
          record?['time']?.toString() ?? '',
    );

    _locationController =
        TextEditingController(
      text:
          record?['location']
                  ?.toString() ??
              '',
    );

    _subjectController =
        TextEditingController(
      text:
          record?['subject']?.toString() ??
              '',
    );

    _conductedByController =
        TextEditingController(
      text:
          record?['conductedBy']
                  ?.toString() ??
              '',
    );

    _departmentController =
        TextEditingController(
      text:
          record?['department']
                  ?.toString() ??
              '',
    );

    _attendeesController =
        TextEditingController(
      text:
          record?['attendees']
                  ?.toString() ??
              '',
    );

    _issuesController =
        TextEditingController(
      text:
          record?['issues']?.toString() ??
              '',
    );

    _actionsController =
        TextEditingController(
      text:
          record?['actions']?.toString() ??
              '',
    );

    _actionOwnerController =
        TextEditingController(
      text:
          record?['actionOwner']
                  ?.toString() ??
              '',
    );

    _dueDateController =
        TextEditingController(
      text:
          record?['dueDate']?.toString() ??
              '',
    );

    _updatedByController =
        TextEditingController(
      text:
          record?['updatedBy']
                  ?.toString() ??
              '',
    );

    _remarksController =
        TextEditingController(
      text:
          record?['remarks']?.toString() ??
              '',
    );

    _communicationType =
        widget.communicationTypes.contains(
      record?['communicationType'],
    )
            ? record!['communicationType']
                .toString()
            : widget.communicationTypes.first;

    _status =
        widget.statuses.contains(
      record?['status'],
    )
            ? record!['status'].toString()
            : 'Open';
  }

  @override
  void dispose() {
    _communicationNoController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    _locationController.dispose();
    _subjectController.dispose();
    _conductedByController.dispose();
    _departmentController.dispose();
    _attendeesController.dispose();
    _issuesController.dispose();
    _actionsController.dispose();
    _actionOwnerController.dispose();
    _dueDateController.dispose();
    _updatedByController.dispose();
    _remarksController.dispose();
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
        borderRadius:
            BorderRadius.circular(12),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(12),
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
      padding:
          const EdgeInsets.only(bottom: 12),
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
      padding:
          const EdgeInsets.only(bottom: 12),
      child:
          DropdownButtonFormField<String>(
        initialValue: value,
        decoration: _decoration(label),
        items: items
            .map(
              (item) =>
                  DropdownMenuItem<String>(
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

    final existing =
        DateTime.tryParse(
      controller.text.trim(),
    );

    if (existing != null) {
      initialDate = existing;
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

    final month = selected.month
        .toString()
        .padLeft(2, '0');

    final day = selected.day
        .toString()
        .padLeft(2, '0');

    controller.text =
        '${selected.year}-$month-$day';
  }

  List<Map<String, dynamic>> _buildHistory(
    Map<String, dynamic>? oldRecord,
  ) {
    final history =
        <Map<String, dynamic>>[];

    if (oldRecord != null) {
      final oldHistory =
          oldRecord['history'];

      if (oldHistory is List) {
        for (final item in oldHistory) {
          if (item is Map) {
            history.add(
              Map<String, dynamic>.from(
                item,
              ),
            );
          }
        }
      }

      history.insert(
        0,
        {
          'type': 'Record Update',
          'date':
              oldRecord['updatedAt']
                      ?.toString() ??
                  DateTime.now()
                      .toIso8601String(),
          'status':
              oldRecord['status']
                      ?.toString() ??
                  'Open',
          'updatedBy':
              oldRecord['updatedBy']
                      ?.toString() ??
                  '',
          'remarks':
              oldRecord['remarks']
                      ?.toString() ??
                  '',
        },
      );
    }

    final unique = <String>{};
    final cleaned =
        <Map<String, dynamic>>[];

    for (final item in history) {
      final key = [
        item['type'],
        item['date'],
        item['status'],
        item['updatedBy'],
        item['remarks'],
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

    final record =
        <String, dynamic>{
      'id': id,
      'communicationNo':
          _communicationNoController
              .text
              .trim(),
      'date':
          _dateController.text.trim(),
      'time':
          _timeController.text.trim(),
      'location':
          _locationController.text.trim(),
      'communicationType':
          _communicationType,
      'subject':
          _subjectController.text.trim(),
      'conductedBy':
          _conductedByController.text
              .trim(),
      'department':
          _departmentController.text
              .trim(),
      'attendees':
          _attendeesController.text
              .trim(),
      'issues':
          _issuesController.text.trim(),
      'actions':
          _actionsController.text.trim(),
      'actionOwner':
          _actionOwnerController.text
              .trim(),
      'dueDate':
          _dueDateController.text.trim(),
      'status':
          _status,
      'updatedBy':
          _updatedByController.text
              .trim(),
      'remarks':
          _remarksController.text.trim(),
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
        MediaQuery.viewInsetsOf(context)
            .bottom;

    return SafeArea(
      child: Container(
        height:
            MediaQuery.sizeOf(context)
                    .height *
                0.94,
        padding:
            EdgeInsets.fromLTRB(
          16,
          10,
          16,
          bottom + 16,
        ),
        decoration:
            const BoxDecoration(
          color: Color(0xFFF6F8F7),
          borderRadius:
              BorderRadius.vertical(
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
                  decoration:
                      BoxDecoration(
                    color: Colors.grey,
                    borderRadius:
                        BorderRadius.circular(
                      10,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              Text(
                widget.record == null
                    ? 'Add HSE Communication'
                    : 'Edit HSE Communication',
                style:
                    const TextStyle(
                  fontSize: 20,
                  fontWeight:
                      FontWeight.w900,
                  color:
                      Color(0xFF0B5D4B),
                ),
              ),
              const SizedBox(
                height: 16,
              ),

              _field(
                _communicationNoController,
                'Communication Number',
                required: true,
                hint:
                    'Example: SN-HSE-COM-001',
              ),

              _field(
                _dateController,
                'Date',
                required: true,
                hint:
                    'Select or enter date',
              ),

              Align(
                alignment:
                    Alignment.centerRight,
                child: TextButton.icon(
                  onPressed: () {
                    _pickDate(
                      _dateController,
                    );
                  },
                  icon: const Icon(
                    Icons.calendar_month,
                  ),
                  label:
                      const Text(
                    'Pick Date',
                  ),
                ),
              ),

              _field(
                _timeController,
                'Time',
                required: false,
                hint:
                    'Example: 08:00 AM',
              ),

              _field(
                _locationController,
                'Location',
                required: true,
                hint:
                    'Example: Site Office / Work Area',
              ),

              _dropdown(
                'Communication Type',
                _communicationType,
                widget.communicationTypes,
                (value) {
                  if (value != null) {
                    setState(() {
                      _communicationType =
                          value;
                    });
                  }
                },
              ),

              _field(
                _subjectController,
                'Subject / Topic',
                required: true,
                maxLines: 2,
                hint:
                    'Example: Heat Stress Prevention Toolbox Talk',
              ),

              _field(
                _conductedByController,
                'Conducted By',
                required: true,
                hint:
                    'Example: HSE Officer',
              ),

              _field(
                _departmentController,
                'Department / Work Group',
                required: true,
                hint:
                    'Example: Civil Team / Electrical Team',
              ),

              _field(
                _attendeesController,
                'Attendees',
                required: true,
                maxLines: 3,
                hint:
                    'Names, employee IDs or attendee group',
              ),

              _field(
                _issuesController,
                'Key Safety Issues',
                required: false,
                maxLines: 4,
                hint:
                    'Record concerns, feedback or safety issues discussed.',
              ),

              _field(
                _actionsController,
                'Actions / Recommendations',
                required: false,
                maxLines: 4,
                hint:
                    'Record agreed actions and recommendations.',
              ),

              _field(
                _actionOwnerController,
                'Action Owner',
                required: false,
                hint:
                    'Example: Site Supervisor',
              ),

              _field(
                _dueDateController,
                'Action Due Date',
                required: false,
                hint:
                    'Select or enter date',
              ),

              Align(
                alignment:
                    Alignment.centerRight,
                child: TextButton.icon(
                  onPressed: () {
                    _pickDate(
                      _dueDateController,
                    );
                  },
                  icon: const Icon(
                    Icons.event_outlined,
                  ),
                  label:
                      const Text(
                    'Pick Due Date',
                  ),
                ),
              ),

              _dropdown(
                'Status',
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

              _field(
                _updatedByController,
                'Updated / Recorded By',
                required: true,
                hint:
                    'Example: HSE Officer',
              ),

              _field(
                _remarksController,
                'Remarks',
                required: false,
                maxLines: 4,
                hint:
                    'Additional remarks or follow-up notes.',
              ),

              const SizedBox(
                height: 8,
              ),

              SizedBox(
                height: 52,
                child:
                    FilledButton.icon(
                  onPressed: _submit,
                  icon: const Icon(
                    Icons.save_outlined,
                  ),
                  label: Text(
                    widget.record == null
                        ? 'Save Communication'
                        : 'Update Communication',
                    style:
                        const TextStyle(
                      fontWeight:
                          FontWeight.w800,
                    ),
                  ),
                  style:
                      FilledButton.styleFrom(
                    backgroundColor:
                        const Color(
                      0xFF159447,
                    ),
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
