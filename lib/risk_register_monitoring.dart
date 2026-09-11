import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RiskRegisterMonitoringPage extends StatefulWidget {
  const RiskRegisterMonitoringPage({
    super.key,
  });

  @override
  State<RiskRegisterMonitoringPage> createState() =>
      _RiskRegisterMonitoringPageState();
}

class _RiskRegisterMonitoringPageState
    extends State<RiskRegisterMonitoringPage> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);

  static const String storageKey =
      'safenexus_hse_risk_register_monitoring';

  final TextEditingController _searchController =
      TextEditingController();

  List<Map<String, dynamic>> _records = [];

  String _statusFilter = 'All';
  String _riskFilter = 'All';

  final List<String> _statuses = const [
    'Open',
    'Under Review',
    'Monitoring',
    'Additional Control Required',
    'Accepted',
    'Closed',
    'Cancelled',
  ];

  final List<String> _riskLevels = const [
    'Low',
    'Medium',
    'High',
    'Critical',
  ];

  final List<String> _hazardCategories = const [
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
    _loadRecords();
    _searchController.addListener(_refresh);
  }

  @override
  void dispose() {
    _searchController.removeListener(_refresh);
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadRecords() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(storageKey);

    if (raw == null || raw.isEmpty) {
      if (mounted) {
        setState(() {
          _records = [];
        });
      }
      return;
    }

    try {
      final decoded = jsonDecode(raw);

      if (decoded is List) {
        final loaded = decoded
            .whereType<Map>()
            .map(
              (item) => Map<String, dynamic>.from(item),
            )
            .toList();

        if (mounted) {
          setState(() {
            _records = loaded;
          });
        }
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _records = [];
        });
      }
    }
  }

  Future<void> _saveRecords() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(
      storageKey,
      jsonEncode(_records),
    );
  }

  void _refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  List<Map<String, dynamic>> get _filteredRecords {
    final query =
        _searchController.text.trim().toLowerCase();

    return _records.where((record) {
      final status =
          record['status']?.toString() ?? '';

      final riskLevel =
          record['residualRiskLevel']?.toString() ?? '';

      final matchesStatus =
          _statusFilter == 'All' ||
          status == _statusFilter;

      final matchesRisk =
          _riskFilter == 'All' ||
          riskLevel == _riskFilter;

      if (!matchesStatus || !matchesRisk) {
        return false;
      }

      if (query.isEmpty) {
        return true;
      }

      final searchable = [
        record['registerNo'],
        record['project'],
        record['location'],
        record['department'],
        record['activity'],
        record['hazardCategory'],
        record['hazard'],
        record['riskOwner'],
        record['status'],
        record['relatedReference'],
        record['remarks'],
      ].map(
        (value) =>
            value?.toString().toLowerCase() ?? '',
      );

      return searchable.any(
        (value) => value.contains(query),
      );
    }).toList();
  }

  int get _totalCount => _records.length;

  int get _openCount => _records.where((record) {
        return record['status'] == 'Open';
      }).length;

  int get _monitoringCount =>
      _records.where((record) {
        return record['status'] == 'Monitoring';
      }).length;

  int get _highCriticalCount =>
      _records.where((record) {
        final level =
            record['residualRiskLevel']?.toString();

        return level == 'High' ||
            level == 'Critical';
      }).length;

  int get _mediumCount =>
      _records.where((record) {
        return record['residualRiskLevel'] ==
            'Medium';
      }).length;

  int get _lowCount =>
      _records.where((record) {
        return record['residualRiskLevel'] ==
            'Low';
      }).length;

  int get _acceptedCount =>
      _records.where((record) {
        return record['status'] == 'Accepted';
      }).length;

  int get _closedCount =>
      _records.where((record) {
        return record['status'] == 'Closed';
      }).length;

  int get _overdueCount =>
      _records.where(_isOverdue).length;

  bool _isOverdue(
    Map<String, dynamic> record,
  ) {
    final status =
        record['status']?.toString() ?? '';

    if (status == 'Closed' ||
        status == 'Cancelled') {
      return false;
    }

    final targetDateText =
        record['targetDate']?.toString() ?? '';

    if (targetDateText.isEmpty) {
      return false;
    }

    final targetDate =
        DateTime.tryParse(targetDateText);

    if (targetDate == null) {
      return false;
    }

    final today = DateTime.now();

    final targetOnly = DateTime(
      targetDate.year,
      targetDate.month,
      targetDate.day,
    );

    final todayOnly = DateTime(
      today.year,
      today.month,
      today.day,
    );

    return targetOnly.isBefore(todayOnly);
  }

  String _formatDate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Not set';
    }

    final date = DateTime.tryParse(value);

    if (date == null) {
      return value;
    }

    final day =
        date.day.toString().padLeft(2, '0');

    final month =
        date.month.toString().padLeft(2, '0');

    final year = date.year.toString();

    return '$day/$month/$year';
  }

  String _dateTimeNow() {
    return DateTime.now().toIso8601String();
  }

  Future<void> _openAddForm() async {
    await _openForm();
  }

  Future<void> _openEditForm(
    Map<String, dynamic> record,
    int index,
  ) async {
    await _openForm(
      existingRecord: record,
      editIndex: index,
    );
  }

  Future<void> _openForm({
    Map<String, dynamic>? existingRecord,
    int? editIndex,
  }) async {
    final result =
        await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return _RiskRegisterFormSheet(
          existingRecord: existingRecord,
          hazardCategories: _hazardCategories,
          statuses: _statuses,
        );
      },
    );

    if (result == null) {
      return;
    }

    final now = _dateTimeNow();

    if (editIndex != null &&
        editIndex >= 0 &&
        editIndex < _records.length) {
      final updated =
          Map<String, dynamic>.from(result);

      updated['id'] =
          _records[editIndex]['id']
                  ?.toString() ??
              now;

      updated['createdAt'] =
          _records[editIndex]['createdAt']
                  ?.toString() ??
              now;

      updated['updatedAt'] = now;

      _records[editIndex] = updated;
    } else {
      final created =
          Map<String, dynamic>.from(result);

      created['id'] = now;
      created['createdAt'] = now;
      created['updatedAt'] = now;

      _records.insert(0, created);
    }

    await _saveRecords();

    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _deleteRecord(int index) async {
    final record = _records[index];

    final confirmed =
        await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Delete Risk Record',
          ),
          content: Text(
            'Delete risk register '
            '${record['registerNo'] ?? ''}?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  false,
                );
              },
              child: const Text('Cancel'),
            ),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: () {
                Navigator.pop(
                  context,
                  true,
                );
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

    _records.removeAt(index);

    await _saveRecords();

    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _showHistory(
    Map<String, dynamic> record,
  ) async {
    await showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Record History',
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                'Register No: '
                '${record['registerNo'] ?? 'Not set'}',
              ),
              const SizedBox(height: 16),
              Text(
                'Created: '
                '${_formatDateTime(
                  record['createdAt']
                      ?.toString(),
                )}',
              ),
              const SizedBox(height: 8),
              Text(
                'Last Updated: '
                '${_formatDateTime(
                  record['updatedAt']
                      ?.toString(),
                )}',
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

  String _formatDateTime(String? value) {
    if (value == null || value.isEmpty) {
      return 'Not available';
    }

    final date = DateTime.tryParse(value);

    if (date == null) {
      return value;
    }

    final day =
        date.day.toString().padLeft(2, '0');

    final month =
        date.month.toString().padLeft(2, '0');

    final year = date.year.toString();

    final hour =
        date.hour.toString().padLeft(2, '0');

    final minute =
        date.minute.toString().padLeft(2, '0');

    return '$day/$month/$year $hour:$minute';
  }

  Color _riskColor(String level) {
    switch (level) {
      case 'Critical':
        return Colors.red.shade800;
      case 'High':
        return Colors.deepOrange;
      case 'Medium':
        return Colors.orange.shade800;
      case 'Low':
        return primaryGreen;
      default:
        return Colors.grey;
    }
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'Open':
        return Colors.blue;
      case 'Under Review':
        return Colors.deepPurple;
      case 'Monitoring':
        return Colors.teal;
      case 'Additional Control Required':
        return Colors.deepOrange;
      case 'Accepted':
        return primaryGreen;
      case 'Closed':
        return Colors.green.shade700;
      case 'Cancelled':
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }

  Widget _summaryCard(
    String title,
    int value,
    IconData icon,
    Color color,
  ) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(
        right: 10,
      ),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(16),
        border: Border.all(
          color: color.withValues(
            alpha: 0.18,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: 0.04,
            ),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withValues(
                alpha: 0.10,
              ),
              borderRadius:
                  BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: color,
              size: 21,
            ),
          ),
          const SizedBox(width: 10),
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
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight:
                        FontWeight.w600,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  value.toString(),
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight:
                        FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _filterSection() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.withValues(
            alpha: 0.15,
          ),
        ),
      ),
      child: Column(
        children: [
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText:
                  'Search risk no, project, hazard, activity...',
              prefixIcon:
                  const Icon(Icons.search),
              suffixIcon:
                  _searchController.text
                          .isNotEmpty
                      ? IconButton(
                          onPressed: () {
                            _searchController
                                .clear();
                          },
                          icon: const Icon(
                            Icons.clear,
                          ),
                        )
                      : null,
              filled: true,
              fillColor: pageBackground,
              border: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(
                  12,
                ),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child:
                    DropdownButtonFormField<
                        String>(
                  initialValue:
                      _statusFilter,
                  decoration:
                      InputDecoration(
                    labelText: 'Status',
                    filled: true,
                    fillColor:
                        pageBackground,
                    border:
                        OutlineInputBorder(
                      borderRadius:
                          BorderRadius
                              .circular(12),
                      borderSide:
                          BorderSide.none,
                    ),
                  ),
                  items: [
                    const DropdownMenuItem(
                      value: 'All',
                      child:
                          Text('All Status'),
                    ),
                    ..._statuses.map(
                      (status) =>
                          DropdownMenuItem(
                        value: status,
                        child: Text(
                          status,
                          overflow:
                              TextOverflow
                                  .ellipsis,
                        ),
                      ),
                    ),
                  ],
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }

                    setState(() {
                      _statusFilter =
                          value;
                    });
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child:
                    DropdownButtonFormField<
                        String>(
                  initialValue:
                      _riskFilter,
                  decoration:
                      InputDecoration(
                    labelText:
                        'Risk Level',
                    filled: true,
                    fillColor:
                        pageBackground,
                    border:
                        OutlineInputBorder(
                      borderRadius:
                          BorderRadius
                              .circular(12),
                      borderSide:
                          BorderSide.none,
                    ),
                  ),
                  items: [
                    const DropdownMenuItem(
                      value: 'All',
                      child:
                          Text('All Risk'),
                    ),
                    ..._riskLevels.map(
                      (level) =>
                          DropdownMenuItem(
                        value: level,
                        child:
                            Text(level),
                      ),
                    ),
                  ],
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }

                    setState(() {
                      _riskFilter = value;
                    });
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _riskMatrixReference() {
    return ExpansionTile(
      tilePadding:
          const EdgeInsets.symmetric(
        horizontal: 14,
      ),
      childrenPadding:
          const EdgeInsets.fromLTRB(
        14,
        0,
        14,
        14,
      ),
      backgroundColor: Colors.white,
      collapsedBackgroundColor:
          Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(14),
      ),
      collapsedShape:
          RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(14),
      ),
      title: const Text(
        '5 × 5 Risk Matrix Reference',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: const Icon(
        Icons.grid_view_rounded,
        color: darkGreen,
      ),
      children: [
        Table(
          border: TableBorder.all(
            color: Colors.grey.shade300,
          ),
          children: const [
            TableRow(
              children: [
                _MatrixCell(
                  'L × S',
                  bold: true,
                ),
                _MatrixCell(
                  '1',
                  bold: true,
                ),
                _MatrixCell(
                  '2',
                  bold: true,
                ),
                _MatrixCell(
                  '3',
                  bold: true,
                ),
                _MatrixCell(
                  '4',
                  bold: true,
                ),
                _MatrixCell(
                  '5',
                  bold: true,
                ),
              ],
            ),
            TableRow(
              children: [
                _MatrixCell(
                  '1',
                  bold: true,
                ),
                _MatrixCell('1'),
                _MatrixCell('2'),
                _MatrixCell('3'),
                _MatrixCell('4'),
                _MatrixCell('5'),
              ],
            ),
            TableRow(
              children: [
                _MatrixCell(
                  '2',
                  bold: true,
                ),
                _MatrixCell('2'),
                _MatrixCell('4'),
                _MatrixCell('6'),
                _MatrixCell('8'),
                _MatrixCell('10'),
              ],
            ),
            TableRow(
              children: [
                _MatrixCell(
                  '3',
                  bold: true,
                ),
                _MatrixCell('3'),
                _MatrixCell('6'),
                _MatrixCell('9'),
                _MatrixCell('12'),
                _MatrixCell('15'),
              ],
            ),
            TableRow(
              children: [
                _MatrixCell(
                  '4',
                  bold: true,
                ),
                _MatrixCell('4'),
                _MatrixCell('8'),
                _MatrixCell('12'),
                _MatrixCell('16'),
                _MatrixCell('20'),
              ],
            ),
            TableRow(
              children: [
                _MatrixCell(
                  '5',
                  bold: true,
                ),
                _MatrixCell('5'),
                _MatrixCell('10'),
                _MatrixCell('15'),
                _MatrixCell('20'),
                _MatrixCell('25'),
              ],
            ),
          ],
        ),
        const SizedBox(height: 10),
        const Text(
          '1–4 Low • 5–11 Medium • '
          '12–19 High • 20–25 Critical',
          style: TextStyle(
            fontSize: 12,
            color: Colors.black54,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _recordCard(
    Map<String, dynamic> record,
    int index,
  ) {
    final residualLevel =
        record['residualRiskLevel']
                ?.toString() ??
            'Not Rated';

    final status =
        record['status']?.toString() ??
            'Open';

    final overdue =
        _isOverdue(record);

    final riskColor =
        _riskColor(residualLevel);

    final statusColor =
        _statusColor(status);

    return Container(
      margin: const EdgeInsets.only(
        bottom: 12,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(16),
        border: Border.all(
          color: overdue
              ? Colors.red.withValues(
                  alpha: 0.30,
                )
              : Colors.grey.withValues(
                  alpha: 0.14,
                ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: 0.035,
            ),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding:
            const EdgeInsets.all(14),
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
                    record['registerNo']
                            ?.toString() ??
                        'Risk Register',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight:
                          FontWeight.bold,
                      color: darkGreen,
                    ),
                  ),
                ),
                PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'edit') {
                      _openEditForm(
                        record,
                        index,
                      );
                    } else if (value ==
                        'history') {
                      _showHistory(record);
                    } else if (value ==
                        'delete') {
                      _deleteRecord(index);
                    }
                  },
                  itemBuilder:
                      (context) => const [
                    PopupMenuItem(
                      value: 'edit',
                      child: ListTile(
                        contentPadding:
                            EdgeInsets.zero,
                        leading: Icon(
                          Icons.edit_outlined,
                        ),
                        title:
                            Text('Edit'),
                      ),
                    ),
                    PopupMenuItem(
                      value: 'history',
                      child: ListTile(
                        contentPadding:
                            EdgeInsets.zero,
                        leading: Icon(
                          Icons.history,
                        ),
                        title:
                            Text('History'),
                      ),
                    ),
                    PopupMenuItem(
                      value: 'delete',
                      child: ListTile(
                        contentPadding:
                            EdgeInsets.zero,
                        leading: Icon(
                          Icons
                              .delete_outline,
                          color: Colors.red,
                        ),
                        title:
                            Text('Delete'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 6,
              children: [
                _badge(
                  'Residual: $residualLevel',
                  riskColor,
                ),
                _badge(
                  status,
                  statusColor,
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
              Icons.business_outlined,
              'Project',
              record['project']
                  ?.toString(),
            ),
            _infoRow(
              Icons.location_on_outlined,
              'Location',
              record['location']
                  ?.toString(),
            ),
            _infoRow(
              Icons.work_outline,
              'Activity',
              record['activity']
                  ?.toString(),
            ),
            _infoRow(
              Icons.warning_amber_rounded,
              'Hazard',
              record['hazard']
                  ?.toString(),
            ),
            _infoRow(
              Icons.person_outline,
              'Risk Owner',
              record['riskOwner']
                  ?.toString(),
            ),
            _infoRow(
              Icons.event_outlined,
              'Target Date',
              _formatDate(
                record['targetDate']
                    ?.toString(),
              ),
            ),
            _infoRow(
              Icons.rate_review_outlined,
              'Review Date',
              _formatDate(
                record['reviewDate']
                    ?.toString(),
              ),
            ),
            const Divider(height: 20),
            Row(
              children: [
                Expanded(
                  child: _scoreBox(
                    'Initial',
                    record[
                        'initialRiskScore'],
                    record[
                        'initialRiskLevel'],
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _scoreBox(
                    'Residual',
                    record[
                        'residualRiskScore'],
                    record[
                        'residualRiskLevel'],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _scoreBox(
    String title,
    dynamic score,
    dynamic level,
  ) {
    final scoreText =
        score?.toString() ?? '—';

    final levelText =
        level?.toString() ??
            'Not Rated';

    return Container(
      padding:
          const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: pageBackground,
        borderRadius:
            BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.assessment_outlined,
            size: 20,
            color: darkGreen,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.black54,
                  ),
                ),
                Text(
                  '$scoreText • $levelText',
                  style: TextStyle(
                    fontWeight:
                        FontWeight.bold,
                    color:
                        _riskColor(
                      levelText,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(
    IconData icon,
    String label,
    String? value,
  ) {
    final text =
        value == null || value.isEmpty
            ? 'Not set'
            : value;

    return Padding(
      padding:
          const EdgeInsets.only(
        bottom: 7,
      ),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 18,
            color: Colors.black45,
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 82,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black54,
                fontWeight:
                    FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 13,
                fontWeight:
                    FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _badge(
    String text,
    Color color,
  ) {
    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: color.withValues(
          alpha: 0.10,
        ),
        borderRadius:
            BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight:
              FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filtered =
        _filteredRecords;

    return Scaffold(
      backgroundColor:
          pageBackground,
      appBar: AppBar(
        backgroundColor: darkGreen,
        foregroundColor:
            Colors.white,
        title: const Text(
          '3F Risk Register & Monitoring',
          style: TextStyle(
            fontWeight:
                FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'Refresh',
            onPressed: _loadRecords,
            icon: const Icon(
              Icons.refresh,
            ),
          ),
        ],
      ),
      floatingActionButton:
          FloatingActionButton.extended(
        backgroundColor:
            primaryGreen,
        foregroundColor:
            Colors.white,
        onPressed:
            _openAddForm,
        icon: const Icon(
          Icons.add,
        ),
        label: const Text(
          'Add Risk',
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _loadRecords,
        child: ListView(
          padding:
              const EdgeInsets.fromLTRB(
            14,
            14,
            14,
            90,
          ),
          children: [
            Container(
              padding:
                  const EdgeInsets.all(
                16,
              ),
              decoration:
                  BoxDecoration(
                gradient:
                    LinearGradient(
                  begin:
                      Alignment.topLeft,
                  end:
                      Alignment.bottomRight,
                  colors: [
                    darkGreen,
                    primaryGreen,
                  ],
                ),
                borderRadius:
                    BorderRadius.circular(
                  18,
                ),
              ),
              child:
                  const Column(
                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,
                children: [
                  Icon(
                    Icons
                        .monitor_heart_outlined,
                    color:
                        Colors.white,
                    size: 30,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Risk Profile & Monitoring',
                    style:
                        TextStyle(
                      color:
                          Colors.white,
                      fontSize: 20,
                      fontWeight:
                          FontWeight
                              .bold,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Maintain, monitor and review '
                    'project risks throughout '
                    'the work lifecycle.',
                    style:
                        TextStyle(
                      color:
                          Colors.white70,
                      fontSize: 13,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            SizedBox(
              height: 82,
              child: ListView(
                scrollDirection:
                    Axis.horizontal,
                children: [
                  _summaryCard(
                    'Total Risks',
                    _totalCount,
                    Icons
                        .warning_amber_rounded,
                    darkGreen,
                  ),
                  _summaryCard(
                    'Open',
                    _openCount,
                    Icons
                        .folder_open_outlined,
                    Colors.blue,
                  ),
                  _summaryCard(
                    'Monitoring',
                    _monitoringCount,
                    Icons
                        .visibility_outlined,
                    Colors.teal,
                  ),
                  _summaryCard(
                    'High / Critical',
                    _highCriticalCount,
                    Icons
                        .priority_high_rounded,
                    Colors.red,
                  ),
                  _summaryCard(
                    'Medium',
                    _mediumCount,
                    Icons
                        .warning_outlined,
                    Colors.orange,
                  ),
                  _summaryCard(
                    'Low',
                    _lowCount,
                    Icons
                        .check_circle_outline,
                    primaryGreen,
                  ),
                  _summaryCard(
                    'Accepted',
                    _acceptedCount,
                    Icons
                        .verified_outlined,
                    primaryGreen,
                  ),
                  _summaryCard(
                    'Closed',
                    _closedCount,
                    Icons.task_alt,
                    Colors.green
                        .shade700,
                  ),
                  _summaryCard(
                    'Overdue',
                    _overdueCount,
                    Icons
                        .event_busy_outlined,
                    Colors.red,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            _filterSection(),
            const SizedBox(
              height: 12,
            ),
            _riskMatrixReference(),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Risk Register',
                    style:
                        TextStyle(
                      fontSize: 18,
                      fontWeight:
                          FontWeight
                              .bold,
                      color:
                          darkGreen,
                    ),
                  ),
                ),
                Text(
                  '${filtered.length} record(s)',
                  style:
                      const TextStyle(
                    color:
                        Colors.black54,
                    fontWeight:
                        FontWeight
                            .w600,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            if (filtered.isEmpty)
              _emptyState()
            else
              ...filtered.map(
                (record) {
                  final index =
                      _records.indexOf(
                    record,
                  );

                  return _recordCard(
                    record,
                    index,
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _emptyState() {
    return Container(
      padding:
          const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(16),
      ),
      child: const Column(
        children: [
          Icon(
            Icons
                .fact_check_outlined,
            size: 52,
            color: Colors.black26,
          ),
          SizedBox(
            height: 12,
          ),
          Text(
            'No risk records found',
            style: TextStyle(
              fontSize: 17,
              fontWeight:
                  FontWeight.bold,
              color: darkGreen,
            ),
          ),
          SizedBox(
            height: 6,
          ),
          Text(
            'Add a risk to start monitoring '
            'the project risk profile.',
            textAlign:
                TextAlign.center,
            style: TextStyle(
              color:
                  Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}

class _MatrixCell
    extends StatelessWidget {
  final String text;
  final bool bold;

  const _MatrixCell(
    this.text, {
    this.bold = false,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Padding(
      padding:
          const EdgeInsets.all(7),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 11,
            fontWeight: bold
                ? FontWeight.bold
                : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

class _RiskRegisterFormSheet
    extends StatefulWidget {
  final Map<String, dynamic>?
      existingRecord;

  final List<String>
      hazardCategories;

  final List<String> statuses;

  const _RiskRegisterFormSheet({
    required this.existingRecord,
    required this.hazardCategories,
    required this.statuses,
  });

  @override
  State<_RiskRegisterFormSheet>
      createState() =>
          _RiskRegisterFormSheetState();
}

class _RiskRegisterFormSheetState
    extends State<
        _RiskRegisterFormSheet> {
  static const Color primaryGreen =
      Color(0xFF159447);

  static const Color darkGreen =
      Color(0xFF0B5D4B);

  final _formKey =
      GlobalKey<FormState>();

  late final TextEditingController
      _registerNoController;

  late final TextEditingController
      _projectController;

  late final TextEditingController
      _locationController;

  late final TextEditingController
      _departmentController;

  late final TextEditingController
      _activityController;

  late final TextEditingController
      _hazardController;

  late final TextEditingController
      _consequenceController;

  late final TextEditingController
      _existingControlsController;

  late final TextEditingController
      _additionalControlsController;

  late final TextEditingController
      _riskOwnerController;

  late final TextEditingController
      _relatedReferenceController;

  late final TextEditingController
      _remarksController;

  String _hazardCategory =
      'General';

  String _status = 'Open';

  int _initialLikelihood = 1;
  int _initialSeverity = 1;

  int _residualLikelihood = 1;
  int _residualSeverity = 1;

  DateTime? _targetDate;
  DateTime? _reviewDate;

  @override
  void initState() {
    super.initState();

    final record =
        widget.existingRecord;

    _registerNoController =
        TextEditingController(
      text: record?['registerNo']
              ?.toString() ??
          '',
    );

    _projectController =
        TextEditingController(
      text: record?['project']
              ?.toString() ??
          '',
    );

    _locationController =
        TextEditingController(
      text: record?['location']
              ?.toString() ??
          '',
    );

    _departmentController =
        TextEditingController(
      text: record?['department']
              ?.toString() ??
          '',
    );

    _activityController =
        TextEditingController(
      text: record?['activity']
              ?.toString() ??
          '',
    );

    _hazardController =
        TextEditingController(
      text: record?['hazard']
              ?.toString() ??
          '',
    );

    _consequenceController =
        TextEditingController(
      text: record?['consequence']
              ?.toString() ??
          '',
    );

    _existingControlsController =
        TextEditingController(
      text: record?['existingControls']
              ?.toString() ??
          '',
    );

    _additionalControlsController =
        TextEditingController(
      text: record?['additionalControls']
              ?.toString() ??
          '',
    );

    _riskOwnerController =
        TextEditingController(
      text: record?['riskOwner']
              ?.toString() ??
          '',
    );

    _relatedReferenceController =
        TextEditingController(
      text: record?['relatedReference']
              ?.toString() ??
          '',
    );

    _remarksController =
        TextEditingController(
      text: record?['remarks']
              ?.toString() ??
          '',
    );

    final existingCategory =
        record?['hazardCategory']
            ?.toString();

    if (existingCategory != null &&
        widget.hazardCategories
            .contains(existingCategory)) {
      _hazardCategory =
          existingCategory;
    }

    final existingStatus =
        record?['status']?.toString();

    if (existingStatus != null &&
        widget.statuses
            .contains(existingStatus)) {
      _status =
          existingStatus;
    }

    _initialLikelihood =
        _safeRiskNumber(
      record?['initialLikelihood'],
    );

    _initialSeverity =
        _safeRiskNumber(
      record?['initialSeverity'],
    );

    _residualLikelihood =
        _safeRiskNumber(
      record?['residualLikelihood'],
    );

    _residualSeverity =
        _safeRiskNumber(
      record?['residualSeverity'],
    );

    final target =
        record?['targetDate']
            ?.toString();

    if (target != null &&
        target.isNotEmpty) {
      _targetDate =
          DateTime.tryParse(target);
    }

    final review =
        record?['reviewDate']
            ?.toString();

    if (review != null &&
        review.isNotEmpty) {
      _reviewDate =
          DateTime.tryParse(review);
    }
  }

  int _safeRiskNumber(
    dynamic value,
  ) {
    final parsed =
        int.tryParse(
      value?.toString() ?? '',
    );

    if (parsed == null) {
      return 1;
    }

    if (parsed < 1) {
      return 1;
    }

    if (parsed > 5) {
      return 5;
    }

    return parsed;
  }

  @override
  void dispose() {
    _registerNoController.dispose();
    _projectController.dispose();
    _locationController.dispose();
    _departmentController.dispose();
    _activityController.dispose();
    _hazardController.dispose();
    _consequenceController.dispose();
    _existingControlsController
        .dispose();
    _additionalControlsController
        .dispose();
    _riskOwnerController.dispose();
    _relatedReferenceController
        .dispose();
    _remarksController.dispose();

    super.dispose();
  }

  int _score(
    int likelihood,
    int severity,
  ) {
    return likelihood * severity;
  }

  String _level(int score) {
    if (score <= 4) {
      return 'Low';
    }

    if (score <= 11) {
      return 'Medium';
    }

    if (score <= 19) {
      return 'High';
    }

    return 'Critical';
  }

  Color _riskColor(
    String level,
  ) {
    switch (level) {
      case 'Critical':
        return Colors.red.shade800;
      case 'High':
        return Colors.deepOrange;
      case 'Medium':
        return Colors.orange.shade800;
      case 'Low':
        return primaryGreen;
      default:
        return Colors.grey;
    }
  }

  Future<void> _selectDate({
    required bool target,
  }) async {
    final current =
        target ? _targetDate : _reviewDate;

    final selected =
        await showDatePicker(
      context: context,
      initialDate:
          current ?? DateTime.now(),
      firstDate:
          DateTime(2020),
      lastDate:
          DateTime(2100),
    );

    if (selected == null) {
      return;
    }

    setState(() {
      if (target) {
        _targetDate = selected;
      } else {
        _reviewDate = selected;
      }
    });
  }

  String _dateText(
    DateTime? date,
  ) {
    if (date == null) {
      return 'Select date';
    }

    final day =
        date.day.toString().padLeft(
              2,
              '0',
            );

    final month =
        date.month.toString().padLeft(
              2,
              '0',
            );

    final year =
        date.year.toString();

    return '$day/$month/$year';
  }

  InputDecoration _decoration(
    String label, {
    String? hint,
    IconData? icon,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon:
          icon == null
              ? null
              : Icon(icon),
      filled: true,
      fillColor:
          Colors.grey.shade50,
      border:
          OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(
          12,
        ),
        borderSide: BorderSide(
          color:
              Colors.grey.shade300,
        ),
      ),
      enabledBorder:
          OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(
          12,
        ),
        borderSide: BorderSide(
          color:
              Colors.grey.shade300,
        ),
      ),
      focusedBorder:
          OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(
          12,
        ),
        borderSide:
            const BorderSide(
          color: primaryGreen,
          width: 1.5,
        ),
      ),
    );
  }

  Widget _sectionTitle(
    String title,
    IconData icon,
  ) {
    return Padding(
      padding:
          const EdgeInsets.only(
        top: 18,
        bottom: 10,
      ),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration:
                BoxDecoration(
              color:
                  primaryGreen
                      .withValues(
                alpha: 0.10,
              ),
              borderRadius:
                  BorderRadius.circular(
                10,
              ),
            ),
            child: Icon(
              icon,
              size: 19,
              color:
                  primaryGreen,
            ),
          ),
          const SizedBox(
            width: 9,
          ),
          Text(
            title,
            style:
                const TextStyle(
              fontSize: 16,
              fontWeight:
                  FontWeight.bold,
              color:
                  darkGreen,
            ),
          ),
        ],
      ),
    );
  }

  Widget _riskSelector({
    required String title,
    required int likelihood,
    required int severity,
    required ValueChanged<int>
        onLikelihoodChanged,
    required ValueChanged<int>
        onSeverityChanged,
  }) {
    final score =
        _score(
      likelihood,
      severity,
    );

    final level =
        _level(score);

    final color =
        _riskColor(level);

    return Container(
      padding:
          const EdgeInsets.all(
        12,
      ),
      decoration:
          BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(
          14,
        ),
        border: Border.all(
          color:
              color.withValues(
            alpha: 0.25,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style:
                      const TextStyle(
                    fontWeight:
                        FontWeight.bold,
                    color:
                        darkGreen,
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets
                        .symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration:
                    BoxDecoration(
                  color:
                      color.withValues(
                    alpha: 0.10,
                  ),
                  borderRadius:
                      BorderRadius
                          .circular(
                    20,
                  ),
                ),
                child: Text(
                  '$score • $level',
                  style: TextStyle(
                    color: color,
                    fontWeight:
                        FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          DropdownButtonFormField<
              int>(
            initialValue:
                likelihood,
            decoration:
                _decoration(
              'Likelihood',
              icon:
                  Icons.trending_up,
            ),
            items:
                List.generate(
              5,
              (index) {
                final value =
                    index + 1;

                return DropdownMenuItem<
                    int>(
                  value: value,
                  child: Text(
                    '$value - '
                    '${_likelihoodLabel(value)}',
                  ),
                );
              },
            ),
            onChanged: (value) {
              if (value != null) {
                onLikelihoodChanged(
                  value,
                );
              }
            },
          ),
          const SizedBox(
            height: 10,
          ),
          DropdownButtonFormField<
              int>(
            initialValue:
                severity,
            decoration:
                _decoration(
              'Severity',
              icon:
                  Icons.priority_high,
            ),
            items:
                List.generate(
              5,
              (index) {
                final value =
                    index + 1;

                return DropdownMenuItem<
                    int>(
                  value: value,
                  child: Text(
                    '$value - '
                    '${_severityLabel(value)}',
                  ),
                );
              },
            ),
            onChanged: (value) {
              if (value != null) {
                onSeverityChanged(
                  value,
                );
              }
            },
          ),
        ],
      ),
    );
  }

  String _likelihoodLabel(
    int value,
  ) {
    switch (value) {
      case 1:
        return 'Rare';
      case 2:
        return 'Unlikely';
      case 3:
        return 'Possible';
      case 4:
        return 'Likely';
      case 5:
        return 'Almost Certain';
      default:
        return '';
    }
  }

  String _severityLabel(
    int value,
  ) {
    switch (value) {
      case 1:
        return 'Insignificant';
      case 2:
        return 'Minor';
      case 3:
        return 'Moderate';
      case 4:
        return 'Major';
      case 5:
        return 'Catastrophic';
      default:
        return '';
    }
  }

  Widget _dateField({
    required String label,
    required DateTime? value,
    required VoidCallback onTap,
    required IconData icon,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius:
          BorderRadius.circular(
        12,
      ),
      child: InputDecorator(
        decoration:
            _decoration(
          label,
          icon: icon,
        ),
        child: Text(
          _dateText(value),
          style: TextStyle(
            color: value == null
                ? Colors.black45
                : Colors.black87,
            fontWeight: value == null
                ? FontWeight.normal
                : FontWeight.w600,
          ),
        ),
      ),
    );
  }

  void _submit() {
    if (!_formKey.currentState!
        .validate()) {
      return;
    }

    if (_reviewDate != null &&
        _targetDate != null &&
        _reviewDate!
            .isBefore(
          _targetDate!,
        )) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(
        const SnackBar(
          content: Text(
            'Review Date should not be before Target Date.',
          ),
        ),
      );

      return;
    }

    final initialScore =
        _score(
      _initialLikelihood,
      _initialSeverity,
    );

    final residualScore =
        _score(
      _residualLikelihood,
      _residualSeverity,
    );

    final result =
        <String, dynamic>{
      'registerNo':
          _registerNoController
              .text
              .trim(),
      'project':
          _projectController.text
              .trim(),
      'location':
          _locationController.text
              .trim(),
      'department':
          _departmentController.text
              .trim(),
      'activity':
          _activityController.text
              .trim(),
      'hazardCategory':
          _hazardCategory,
      'hazard':
          _hazardController.text
              .trim(),
      'consequence':
          _consequenceController
              .text
              .trim(),
      'existingControls':
          _existingControlsController
              .text
              .trim(),
      'initialLikelihood':
          _initialLikelihood,
      'initialSeverity':
          _initialSeverity,
      'initialRiskScore':
          initialScore,
      'initialRiskLevel':
          _level(initialScore),
      'additionalControls':
          _additionalControlsController
              .text
              .trim(),
      'riskOwner':
          _riskOwnerController.text
              .trim(),
      'targetDate':
          _targetDate
              ?.toIso8601String(),
      'residualLikelihood':
          _residualLikelihood,
      'residualSeverity':
          _residualSeverity,
      'residualRiskScore':
          residualScore,
      'residualRiskLevel':
          _level(residualScore),
      'reviewDate':
          _reviewDate
              ?.toIso8601String(),
      'relatedReference':
          _relatedReferenceController
              .text
              .trim(),
      'status': _status,
      'remarks':
          _remarksController.text
              .trim(),
    };

    Navigator.pop(
      context,
      result,
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final bottomInset =
        MediaQuery.of(context)
            .viewInsets
            .bottom;

    final initialScore =
        _score(
      _initialLikelihood,
      _initialSeverity,
    );

    final residualScore =
        _score(
      _residualLikelihood,
      _residualSeverity,
    );

    return SafeArea(
      top: false,
      child: Container(
        height:
            MediaQuery.of(context)
                    .size
                    .height *
                0.94,
        decoration:
            const BoxDecoration(
          color:
              Color(0xFFF6F8F7),
          borderRadius:
              BorderRadius.vertical(
            top:
                Radius.circular(24),
          ),
        ),
        child: Column(
          children: [
            Container(
              padding:
                  const EdgeInsets
                      .fromLTRB(
                18,
                12,
                10,
                12,
              ),
              decoration:
                  const BoxDecoration(
                color:
                    darkGreen,
                borderRadius:
                    BorderRadius.vertical(
                  top:
                      Radius.circular(
                    24,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.existingRecord ==
                              null
                          ? 'Add Risk Register'
                          : 'Edit Risk Register',
                      style:
                          const TextStyle(
                        color:
                            Colors.white,
                        fontSize: 18,
                        fontWeight:
                            FontWeight
                                .bold,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(
                        context,
                      );
                    },
                    icon:
                        const Icon(
                      Icons.close,
                      color:
                          Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Form(
                key: _formKey,
                child: ListView(
                  padding:
                      EdgeInsets.fromLTRB(
                    14,
                    8,
                    14,
                    24 +
                        bottomInset,
                  ),
                  children: [
                    _sectionTitle(
                      'Risk Identification',
                      Icons
                          .warning_amber_rounded,
                    ),
                    TextFormField(
                      controller:
                          _registerNoController,
                      decoration:
                          _decoration(
                        'Risk Register No.',
                        hint:
                            'Example: RR-001',
                        icon:
                            Icons.tag,
                      ),
                      validator:
                          (value) {
                        if (value ==
                                null ||
                            value
                                .trim()
                                .isEmpty) {
                          return 'Risk Register No. is required';
                        }

                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller:
                          _projectController,
                      decoration:
                          _decoration(
                        'Project',
                        icon:
                            Icons
                                .business_outlined,
                      ),
                      validator:
                          (value) {
                        if (value ==
                                null ||
                            value
                                .trim()
                                .isEmpty) {
                          return 'Project is required';
                        }

                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller:
                          _locationController,
                      decoration:
                          _decoration(
                        'Location',
                        icon:
                            Icons
                                .location_on_outlined,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller:
                          _departmentController,
                      decoration:
                          _decoration(
                        'Department',
                        icon:
                            Icons
                                .account_tree_outlined,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller:
                          _activityController,
                      decoration:
                          _decoration(
                        'Activity / Work',
                        icon:
                            Icons
                                .work_outline,
                      ),
                      validator:
                          (value) {
                        if (value ==
                                null ||
                            value
                                .trim()
                                .isEmpty) {
                          return 'Activity / Work is required';
                        }

                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    DropdownButtonFormField<
                        String>(
                      initialValue:
                          _hazardCategory,
                      decoration:
                          _decoration(
                        'Hazard Category',
                        icon:
                            Icons
                                .category_outlined,
                      ),
                      items: widget
                          .hazardCategories
                          .map(
                        (
                          category,
                        ) =>
                            DropdownMenuItem<
                                String>(
                          value:
                              category,
                          child:
                              Text(
                            category,
                          ),
                        ),
                      ).toList(),
                      onChanged:
                          (value) {
                        if (value !=
                            null) {
                          setState(() {
                            _hazardCategory =
                                value;
                          });
                        }
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller:
                          _hazardController,
                      maxLines: 3,
                      decoration:
                          _decoration(
                        'Hazard / Risk',
                        hint:
                            'Describe the hazard or risk',
                        icon: Icons
                            .report_problem_outlined,
                      ),
                      validator:
                          (value) {
                        if (value ==
                                null ||
                            value
                                .trim()
                                .isEmpty) {
                          return 'Hazard / Risk is required';
                        }

                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller:
                          _consequenceController,
                      maxLines: 3,
                      decoration:
                          _decoration(
                        'Potential Consequence',
                        icon:
                            Icons
                                .health_and_safety_outlined,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller:
                          _existingControlsController,
                      maxLines: 4,
                      decoration:
                          _decoration(
                        'Existing Controls',
                        icon:
                            Icons
                                .security_outlined,
                      ),
                    ),
                    _sectionTitle(
                      'Initial Risk Assessment',
                      Icons
                          .assessment_outlined,
                    ),
                    _riskSelector(
                      title:
                          'Initial Risk',
                      likelihood:
                          _initialLikelihood,
                      severity:
                          _initialSeverity,
                      onLikelihoodChanged:
                          (value) {
                        setState(() {
                          _initialLikelihood =
                              value;
                        });
                      },
                      onSeverityChanged:
                          (value) {
                        setState(() {
                          _initialSeverity =
                              value;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Initial Score: '
                      '$initialScore • '
                      '${_level(initialScore)}',
                      style:
                          TextStyle(
                        color:
                            _riskColor(
                          _level(
                            initialScore,
                          ),
                        ),
                        fontWeight:
                            FontWeight
                                .bold,
                      ),
                    ),
                    _sectionTitle(
                      'Risk Controls & Ownership',
                      Icons
                          .shield_outlined,
                    ),
                    TextFormField(
                      controller:
                          _additionalControlsController,
                      maxLines: 5,
                      decoration:
                          _decoration(
                        'Additional Controls / Actions',
                        icon:
                            Icons
                                .rule_outlined,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller:
                          _riskOwnerController,
                      decoration:
                          _decoration(
                        'Risk Owner',
                        icon:
                            Icons
                                .person_outline,
                      ),
                      validator:
                          (value) {
                        if (value ==
                                null ||
                            value
                                .trim()
                                .isEmpty) {
                          return 'Risk Owner is required';
                        }

                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    _dateField(
                      label:
                          'Target Date',
                      value:
                          _targetDate,
                      onTap: () {
                        _selectDate(
                          target: true,
                        );
                      },
                      icon:
                          Icons
                              .event_outlined,
                    ),
                    _sectionTitle(
                      'Residual Risk',
                      Icons
                          .monitor_heart_outlined,
                    ),
                    _riskSelector(
                      title:
                          'Residual Risk',
                      likelihood:
                          _residualLikelihood,
                      severity:
                          _residualSeverity,
                      onLikelihoodChanged:
                          (value) {
                        setState(() {
                          _residualLikelihood =
                              value;
                        });
                      },
                      onSeverityChanged:
                          (value) {
                        setState(() {
                          _residualSeverity =
                              value;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Residual Score: '
                      '$residualScore • '
                      '${_level(residualScore)}',
                      style:
                          TextStyle(
                        color:
                            _riskColor(
                          _level(
                            residualScore,
                          ),
                        ),
                        fontWeight:
                            FontWeight
                                .bold,
                      ),
                    ),
                    _sectionTitle(
                      'Review & Monitoring',
                      Icons
                          .rate_review_outlined,
                    ),
                    _dateField(
                      label:
                          'Review Date',
                      value:
                          _reviewDate,
                      onTap: () {
                        _selectDate(
                          target: false,
                        );
                      },
                      icon: Icons
                          .calendar_month_outlined,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller:
                          _relatedReferenceController,
                      decoration:
                          _decoration(
                        'Related HIRA / JSA / RAMS / Reference',
                        icon:
                            Icons
                                .link_outlined,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    DropdownButtonFormField<
                        String>(
                      initialValue:
                          _status,
                      decoration:
                          _decoration(
                        'Risk Status',
                        icon:
                            Icons
                                .flag_outlined,
                      ),
                      items: widget
                          .statuses
                          .map(
                        (
                          status,
                        ) =>
                            DropdownMenuItem<
                                String>(
                          value:
                              status,
                          child:
                              Text(
                            status,
                          ),
                        ),
                      ).toList(),
                      onChanged:
                          (value) {
                        if (value !=
                            null) {
                          setState(() {
                            _status =
                                value;
                          });
                        }
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller:
                          _remarksController,
                      maxLines: 4,
                      decoration:
                          _decoration(
                        'Remarks / Monitoring Notes',
                        icon:
                            Icons
                                .notes_outlined,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding:
                          const EdgeInsets
                              .all(12),
                      decoration:
                          BoxDecoration(
                        color:
                            primaryGreen
                                .withValues(
                          alpha: 0.07,
                        ),
                        borderRadius:
                            BorderRadius
                                .circular(
                          12,
                        ),
                        border:
                            Border.all(
                          color:
                              primaryGreen
                                  .withValues(
                            alpha: 0.18,
                          ),
                        ),
                      ),
                      child:
                          const Row(
                        crossAxisAlignment:
                            CrossAxisAlignment
                                .start,
                        children: [
                          Icon(
                            Icons
                                .info_outline,
                            color:
                                darkGreen,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child:
                                Text(
                              'Risk should be reviewed whenever '
                              'there is a significant change in '
                              'activity, equipment, work method, '
                              'incident, legal requirement or '
                              'risk control effectiveness.',
                              style:
                                  TextStyle(
                                fontSize:
                                    12,
                                height:
                                    1.4,
                                color:
                                    Colors
                                        .black87,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    SizedBox(
                      height: 52,
                      child:
                          FilledButton.icon(
                        style:
                            FilledButton
                                .styleFrom(
                          backgroundColor:
                              primaryGreen,
                          foregroundColor:
                              Colors
                                  .white,
                          shape:
                              RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius
                                    .circular(
                              14,
                            ),
                          ),
                        ),
                        onPressed:
                            _submit,
                        icon:
                            const Icon(
                          Icons
                              .save_outlined,
                        ),
                        label: Text(
                          widget.existingRecord ==
                                  null
                              ? 'Save Risk Record'
                              : 'Update Risk Record',
                          style:
                              const TextStyle(
                            fontWeight:
                                FontWeight
                                    .bold,
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
}
