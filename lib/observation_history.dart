import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ObservationHistoryPage extends StatefulWidget {
  const ObservationHistoryPage({
    super.key,
  });

  @override
  State<ObservationHistoryPage> createState() =>
      _ObservationHistoryPageState();
}

class _ObservationHistoryPageState
    extends State<ObservationHistoryPage> {
  static const String _storageKey = 'safenexus_observations';

  List<Map<String, dynamic>> _reports = <Map<String, dynamic>>[];

  bool _loading = true;

  String _filter = 'All';

  static const List<String> _filters = [
    'All',
    'Safety Observation',
    'Hazard Report',
  ];

  @override
  void initState() {
    super.initState();
    _loadReports();
  }

  Future<void> _loadReports() async {
    if (mounted) {
      setState(() {
        _loading = true;
      });
    }

    try {
      final prefs = await SharedPreferences.getInstance();

      final stored =
          prefs.getStringList(_storageKey) ?? <String>[];

      final List<Map<String, dynamic>> loadedReports =
          <Map<String, dynamic>>[];

      bool storageChanged = false;

      for (final raw in stored) {
        try {
          final decoded = jsonDecode(raw);

          if (decoded is! Map) {
            continue;
          }

          final report = Map<String, dynamic>.from(decoded);

          final id = _stringValue(report['id']);

          if (id.isEmpty) {
            continue;
          }

          final before = jsonEncode(report);

          _normalizeReport(report);

          final after = jsonEncode(report);

          if (before != after) {
            storageChanged = true;
          }

          loadedReports.add(report);
        } catch (_) {
          // Ignore corrupted individual records.
        }
      }

      if (storageChanged) {
        try {
          await prefs.setStringList(
            _storageKey,
            loadedReports.map(jsonEncode).toList(),
          );
        } catch (_) {
          // Keep normalized in-memory records.
        }
      }

      loadedReports.sort(
        (a, b) {
          final dateA = _dateFromReport(a);
          final dateB = _dateFromReport(b);

          return dateB.compareTo(dateA);
        },
      );

      if (!mounted) return;

      setState(() {
        _reports = loadedReports;
        _loading = false;
      });
    } catch (_) {
      if (!mounted) return;

      setState(() {
        _reports = <Map<String, dynamic>>[];
        _loading = false;
      });

      _showMessage(
        'Unable to load report history.',
        error: true,
      );
    }
  }

  void _normalizeReport(
    Map<String, dynamic> report,
  ) {
    final existingType = _stringValue(report['reportType']);

    if (existingType.isNotEmpty) {
      report['reportType'] = _normalizeReportType(existingType);
    } else {
      final observationType =
          _stringValue(report['observationType']);

      final legacyType = _stringValue(report['type']);

      final fallbackType = observationType.isNotEmpty
          ? observationType
          : legacyType;

      if (fallbackType.toLowerCase().contains('hazard')) {
        report['reportType'] = 'Hazard Report';
      } else {
        report['reportType'] = 'Safety Observation';
      }
    }

    final date = _dateFromReport(report);

    if (date.millisecondsSinceEpoch != 0) {
      report['submittedAt'] = date.toIso8601String();
    }

    if (_stringValue(report['riskLevel']).isEmpty) {
      report['riskLevel'] = _stringValue(
        report['severity'],
        fallback: 'Medium',
      );
    }

    if (_stringValue(report['hazard']).isEmpty) {
      report['hazard'] = _stringValue(
        report['hazardType'],
        fallback: 'General Workplace Hazard',
      );
    }

    if (_stringValue(report['correctiveAction']).isEmpty) {
      report['correctiveAction'] = _stringValue(
        report['action'],
      );
    }

    report['description'] = _stringValue(
      report['description'],
    );

    report['location'] = _stringValue(
      report['location'],
    );

    report['photoPath'] = _stringValue(
      report['photoPath'],
    );

    report['status'] = _stringValue(
      report['status'],
      fallback: 'Open',
    );
  }

  String _normalizeReportType(
    String value,
  ) {
    final normalized = value.trim().toLowerCase();

    if (normalized.contains('hazard')) {
      return 'Hazard Report';
    }

    return 'Safety Observation';
  }

  DateTime _dateFromReport(
    Map<String, dynamic> report,
  ) {
    final candidates = [
      report['submittedAt'],
      report['dateTime'],
      report['createdAt'],
    ];

    for (final candidate in candidates) {
      final text = _stringValue(candidate);

      if (text.isEmpty) {
        continue;
      }

      final parsed = DateTime.tryParse(text);

      if (parsed != null) {
        return parsed;
      }
    }

    return DateTime.fromMillisecondsSinceEpoch(0);
  }

  String _stringValue(
    dynamic value, {
    String fallback = '',
  }) {
    if (value == null) {
      return fallback;
    }

    final text = value.toString().trim();

    return text.isEmpty ? fallback : text;
  }

  List<Map<String, dynamic>> get _filteredReports {
    if (_filter == 'All') {
      return _reports;
    }

    return _reports.where(
      (report) {
        return _stringValue(report['reportType']) == _filter;
      },
    ).toList();
  }

  int get _totalCount => _reports.length;

  int get _observationCount {
    return _reports.where(
      (report) {
        return _stringValue(report['reportType']) ==
            'Safety Observation';
      },
    ).length;
  }

  int get _hazardCount {
    return _reports.where(
      (report) {
        return _stringValue(report['reportType']) ==
            'Hazard Report';
      },
    ).length;
  }

  void _showMessage(
    String message, {
    bool error = false,
  }) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor:
            error ? Colors.red.shade700 : Colors.green.shade700,
        content: Text(message),
      ),
    );
  }

  Future<void> _deleteReport(
    Map<String, dynamic> report,
  ) async {
    final id = _stringValue(report['id']);

    if (id.isEmpty) {
      return;
    }

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text(
            'Delete Report?',
          ),
          content: const Text(
            'This report will be permanently removed from local history.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(
                  dialogContext,
                  false,
                );
              },
              child: const Text(
                'Cancel',
              ),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(
                  dialogContext,
                  true,
                );
              },
              child: const Text(
                'Delete',
              ),
            ),
          ],
        );
      },
    );

    if (confirmed != true) {
      return;
    }

    try {
      final prefs = await SharedPreferences.getInstance();

      final stored =
          prefs.getStringList(_storageKey) ?? <String>[];

      final updated = <String>[];

      bool removed = false;

      for (final raw in stored) {
        try {
          final decoded = jsonDecode(raw);

          if (decoded is! Map) {
            updated.add(raw);
            continue;
          }

          final item = Map<String, dynamic>.from(decoded);

          final itemId = _stringValue(item['id']);

          // IMPORTANT:
          // Remove only the FIRST matching record.
          // This protects against legacy duplicate IDs.
          if (!removed && itemId == id) {
            removed = true;
            continue;
          }

          updated.add(raw);
        } catch (_) {
          updated.add(raw);
        }
      }

      await prefs.setStringList(
        _storageKey,
        updated,
      );

      final photoPath = _stringValue(
        report['photoPath'],
      );

      if (photoPath.isNotEmpty) {
        try {
          final file = File(photoPath);

          if (await file.exists()) {
            await file.delete();
          }
        } catch (_) {
          // Ignore photo deletion errors.
        }
      }

      if (!mounted) return;

      setState(() {
        final index = _reports.indexWhere(
          (item) {
            return identical(item, report);
          },
        );

        if (index >= 0) {
          _reports.removeAt(index);
        } else {
          final fallbackIndex = _reports.indexWhere(
            (item) {
              return _stringValue(item['id']) == id;
            },
          );

          if (fallbackIndex >= 0) {
            _reports.removeAt(fallbackIndex);
          }
        }
      });

      _showMessage(
        'Report deleted.',
      );
    } catch (_) {
      _showMessage(
        'Unable to delete report.',
        error: true,
      );
    }
  }

  Future<void> _shareReport(
    Map<String, dynamic> report,
  ) async {
    final text = _buildShareText(report);

    try {
      await Share.share(
        text,
        subject:
            '${_stringValue(report['reportType'])} - ${_stringValue(report['id'])}',
      );
    } catch (_) {
      _showMessage(
        'Unable to share report.',
        error: true,
      );
    }
  }

  String _buildShareText(
    Map<String, dynamic> report,
  ) {
    final type = _stringValue(
      report['reportType'],
      fallback: 'Safety Report',
    );

    final id = _stringValue(
      report['id'],
      fallback: 'N/A',
    );

    final date = _formatDate(
      _dateFromReport(report),
    );

    final category = _stringValue(
      report['category'],
      fallback: 'General Safety',
    );

    final hazard = _stringValue(
      report['hazard'],
      fallback: 'General Workplace Hazard',
    );

    final risk = _stringValue(
      report['riskLevel'],
      fallback: 'Medium',
    );

    final location = _stringValue(
      report['location'],
      fallback: 'Not specified',
    );

    final description = _stringValue(
      report['description'],
      fallback: 'No description provided.',
    );

    final action = _stringValue(
      report['correctiveAction'],
      fallback: 'No corrective action provided.',
    );

    final status = _stringValue(
      report['status'],
      fallback: 'Open',
    );

    String aiSummary = '';

    final rawAi = report['aiAnalysis'];

    if (rawAi is Map) {
      final ai = Map<String, dynamic>.from(rawAi);

      final completed = ai['completed'] == true;

      final explanation = _stringValue(
        ai['explanation'],
      );

      if (completed && explanation.isNotEmpty) {
        aiSummary =
            '\nAI Analysis:\n'
            '$explanation\n';
      }
    }

    return '''
SafeNexus HSE

Report Type: $type

Report ID: $id
Date: $date
Status: $status

Category: $category
Hazard: $hazard
Risk Level: $risk
Location: $location

Description:
$description

Corrective Action:
$action
$aiSummary
Generated by SafeNexus HSE.
''';
  }

  String _formatDate(
    DateTime date,
  ) {
    if (date.millisecondsSinceEpoch == 0) {
      return 'Unknown';
    }

    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year} '
        '${date.hour.toString().padLeft(2, '0')}:'
        '${date.minute.toString().padLeft(2, '0')}';
  }

  bool _hasPhoto(
    Map<String, dynamic> report,
  ) {
    final path = _stringValue(
      report['photoPath'],
    );

    return path.isNotEmpty && File(path).existsSync();
  }

  Color _riskColor(
    String risk,
  ) {
    switch (risk.toLowerCase()) {
      case 'low':
        return Colors.green.shade700;

      case 'medium':
        return Colors.orange.shade700;

      case 'high':
        return Colors.red.shade700;

      case 'critical':
        return Colors.deepPurple.shade700;

      default:
        return Colors.blueGrey.shade700;
    }
  }

  Color _typeColor(
    String type,
  ) {
    if (type == 'Hazard Report') {
      return Colors.red.shade700;
    }

    return Colors.green.shade700;
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Reports & History',
          style: TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: 'Refresh',
            onPressed: _loadReports,
            icon: const Icon(
              Icons.refresh_rounded,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: _loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : RefreshIndicator(
                onRefresh: _loadReports,
                child: _buildContent(),
              ),
      ),
    );
  }

  Widget _buildContent() {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(
        16,
        16,
        16,
        32,
      ),
      children: [
        _buildSummaryCard(),

        const SizedBox(
          height: 16,
        ),

        _buildFilterBar(),

        const SizedBox(
          height: 16,
        ),

        if (_filteredReports.isEmpty)
          _buildEmptyState()
        else
          ..._filteredReports.map(
            _buildReportCard,
          ),
      ],
    );
  }

  Widget _buildSummaryCard() {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Safety Report Summary',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w800,
              ),
            ),

            const SizedBox(
              height: 14,
            ),

            Row(
              children: [
                Expanded(
                  child: _buildCountBox(
                    'Total',
                    _totalCount,
                    Icons.description_outlined,
                    Colors.blueGrey,
                  ),
                ),

                const SizedBox(
                  width: 10,
                ),

                Expanded(
                  child: _buildCountBox(
                    'Observations',
                    _observationCount,
                    Icons.visibility_outlined,
                    Colors.green,
                  ),
                ),

                const SizedBox(
                  width: 10,
                ),

                Expanded(
                  child: _buildCountBox(
                    'Hazards',
                    _hazardCount,
                    Icons.warning_amber_rounded,
                    Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCountBox(
    String label,
    int count,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(
          alpha: 0.08,
        ),
        borderRadius: BorderRadius.circular(
          14,
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 24,
          ),

          const SizedBox(
            height: 6,
          ),

          Text(
            '$count',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: color,
            ),
          ),

          const SizedBox(
            height: 3,
          ),

          Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterBar() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _filters.map(
          (filter) {
            final selected = _filter == filter;

            return Padding(
              padding: const EdgeInsets.only(
                right: 8,
              ),
              child: ChoiceChip(
                label: Text(filter),
                selected: selected,
                onSelected: (value) {
                  if (!value) {
                    return;
                  }

                  setState(() {
                    _filter = filter;
                  });
                },
              ),
            );
          },
        ).toList(),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 42,
        ),
        child: Column(
          children: [
            Icon(
              Icons.inventory_2_outlined,
              size: 58,
              color: Colors.blueGrey.shade300,
            ),

            const SizedBox(
              height: 14,
            ),

            const Text(
              'No reports found',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w800,
              ),
            ),

            const SizedBox(
              height: 8,
            ),

            Text(
              _filter == 'All'
                  ? 'Submitted safety observations and hazard reports will appear here.'
                  : 'No $_filter records are available.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey.shade700,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReportCard(
    Map<String, dynamic> report,
  ) {
    final type = _stringValue(
      report['reportType'],
      fallback: 'Safety Observation',
    );

    final risk = _stringValue(
      report['riskLevel'],
      fallback: 'Medium',
    );

    final category = _stringValue(
      report['category'],
      fallback: 'General Safety',
    );

    final hazard = _stringValue(
      report['hazard'],
      fallback: 'General Workplace Hazard',
    );

    final location = _stringValue(
      report['location'],
      fallback: 'Not specified',
    );

    final description = _stringValue(
      report['description'],
      fallback: 'No description provided.',
    );

    final typeColor = _typeColor(type);
    final riskColor = _riskColor(risk);

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(
        bottom: 14,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(
          16,
        ),
        onTap: () {
          _showReportDetails(report);
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: typeColor.withValues(
                        alpha: 0.10,
                      ),
                      borderRadius:
                          BorderRadius.circular(
                        13,
                      ),
                    ),
                    child: Icon(
                      type == 'Hazard Report'
                          ? Icons.warning_rounded
                          : Icons.visibility_rounded,
                      color: typeColor,
                    ),
                  ),

                  const SizedBox(
                    width: 11,
                  ),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          type,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight:
                                FontWeight.w800,
                          ),
                        ),

                        const SizedBox(
                          height: 3,
                        ),

                        Text(
                          _stringValue(
                            report['id'],
                          ),
                          style:
                              Theme.of(context)
                                  .textTheme
                                  .bodySmall,
                        ),
                      ],
                    ),
                  ),

                  PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'share') {
                        _shareReport(report);
                      }

                      if (value == 'delete') {
                        _deleteReport(report);
                      }
                    },
                    itemBuilder: (context) => const [
                      PopupMenuItem(
                        value: 'share',
                        child: Row(
                          children: [
                            Icon(
                              Icons.share_rounded,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              'Share',
                            ),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: 'delete',
                        child: Row(
                          children: [
                            Icon(
                              Icons.delete_outline_rounded,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              'Delete',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(
                height: 12,
              ),

              Wrap(
                spacing: 7,
                runSpacing: 7,
                children: [
                  _buildBadge(
                    type,
                    type == 'Hazard Report'
                        ? Icons.warning_amber_rounded
                        : Icons.visibility_outlined,
                    color: typeColor,
                  ),

                  _buildBadge(
                    risk,
                    Icons.speed_rounded,
                    color: riskColor,
                  ),

                  _buildBadge(
                    category,
                    Icons.category_outlined,
                  ),
                ],
              ),

              const SizedBox(
                height: 13,
              ),

              Text(
                hazard,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(
                height: 7,
              ),

              Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    size: 18,
                  ),

                  const SizedBox(
                    width: 6,
                  ),

                  Expanded(
                    child: Text(
                      location,
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 8,
              ),

              Text(
                description,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  height: 1.4,
                ),
              ),

              if (_hasPhoto(report)) ...[
                const SizedBox(
                  height: 12,
                ),
                ClipRRect(
                  borderRadius:
                      BorderRadius.circular(
                    12,
                  ),
                  child: Image.file(
                    File(
                      _stringValue(
                        report['photoPath'],
                      ),
                    ),
                    width: double.infinity,
                    height: 160,
                    fit: BoxFit.cover,
                  ),
                ),
              ],

              const SizedBox(
                height: 10,
              ),

              Row(
                children: [
                  const Icon(
                    Icons.schedule_outlined,
                    size: 17,
                  ),

                  const SizedBox(
                    width: 6,
                  ),

                  Text(
                    _formatDate(
                      _dateFromReport(report),
                    ),
                    style:
                        Theme.of(context)
                            .textTheme
                            .bodySmall,
                  ),

                  const Spacer(),

                  const Icon(
                    Icons.chevron_right_rounded,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBadge(
    String text,
    IconData icon, {
    Color? color,
  }) {
    final badgeColor = color ??
        Theme.of(context)
            .colorScheme
            .primary;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: badgeColor.withValues(
          alpha: 0.10,
        ),
        borderRadius: BorderRadius.circular(
          20,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 15,
            color: badgeColor,
          ),

          const SizedBox(
            width: 5,
          ),

          Text(
            text,
            style: TextStyle(
              color: badgeColor,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showReportDetails(
    Map<String, dynamic> report,
  ) async {
    if (!mounted) return;

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (sheetContext) {
        return SafeArea(
          child: DraggableScrollableSheet(
            expand: false,
            initialChildSize: 0.78,
            minChildSize: 0.45,
            maxChildSize: 0.95,
            builder: (
              context,
              controller,
            ) {
              return ListView(
                controller: controller,
                padding: const EdgeInsets.fromLTRB(
                  20,
                  8,
                  20,
                  32,
                ),
                children: [
                  _buildDetailsHeader(report),

                  const SizedBox(
                    height: 18,
                  ),

                  if (_hasPhoto(report)) ...[
                    ClipRRect(
                      borderRadius:
                          BorderRadius.circular(
                        16,
                      ),
                      child: Image.file(
                        File(
                          _stringValue(
                            report['photoPath'],
                          ),
                        ),
                        width: double.infinity,
                        height: 230,
                        fit: BoxFit.cover,
                      ),
                    ),

                    const SizedBox(
                      height: 18,
                    ),
                  ],

                  _buildDetailSection(
                    'Classification',
                    [
                      _buildDetailRow(
                        'Report Type',
                        _stringValue(
                          report['reportType'],
                        ),
                      ),
                      _buildDetailRow(
                        'Category',
                        _stringValue(
                          report['category'],
                          fallback:
                              'General Safety',
                        ),
                      ),
                      _buildDetailRow(
                        'Hazard',
                        _stringValue(
                          report['hazard'],
                          fallback:
                              'General Workplace Hazard',
                        ),
                      ),
                      _buildDetailRow(
                        'Risk Level',
                        _stringValue(
                          report['riskLevel'],
                          fallback: 'Medium',
                        ),
                      ),
                    ],
                  ),

                  _buildDetailSection(
                    'Site Details',
                    [
                      _buildDetailRow(
                        'Location',
                        _stringValue(
                          report['location'],
                          fallback:
                              'Not specified',
                        ),
                      ),
                      _buildDetailRow(
                        'Date',
                        _formatDate(
                          _dateFromReport(
                            report,
                          ),
                        ),
                      ),
                      _buildDetailRow(
                        'Status',
                        _stringValue(
                          report['status'],
                          fallback: 'Open',
                        ),
                      ),
                    ],
                  ),

                  _buildTextSection(
                    'Description',
                    _stringValue(
                      report['description'],
                      fallback:
                          'No description provided.',
                    ),
                  ),

                  _buildTextSection(
                    'Corrective Action',
                    _stringValue(
                      report['correctiveAction'],
                      fallback:
                          'No corrective action provided.',
                    ),
                  ),

                  _buildAiDetails(report),

                  const SizedBox(
                    height: 16,
                  ),

                  Row(
                    children: [
                      Expanded(
                        child:
                            OutlinedButton.icon(
                          onPressed: () {
                            Navigator.pop(
                              sheetContext,
                            );

                            _shareReport(
                              report,
                            );
                          },
                          icon: const Icon(
                            Icons.share_rounded,
                          ),
                          label: const Text(
                            'Share',
                          ),
                        ),
                      ),

                      const SizedBox(
                        width: 10,
                      ),

                      Expanded(
                        child:
                            FilledButton.icon(
                          onPressed: () {
                            Navigator.pop(
                              sheetContext,
                            );

                            _deleteReport(
                              report,
                            );
                          },
                          icon: const Icon(
                            Icons
                                .delete_outline_rounded,
                          ),
                          label: const Text(
                            'Delete',
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildDetailsHeader(
    Map<String, dynamic> report,
  ) {
    final type = _stringValue(
      report['reportType'],
      fallback: 'Safety Observation',
    );

    final color = _typeColor(type);

    return Row(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: color.withValues(
              alpha: 0.10,
            ),
            borderRadius:
                BorderRadius.circular(
              15,
            ),
          ),
          child: Icon(
            type == 'Hazard Report'
                ? Icons.warning_rounded
                : Icons.visibility_rounded,
            color: color,
          ),
        ),

        const SizedBox(
          width: 12,
        ),

        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                type,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),

              const SizedBox(
                height: 4,
              ),

              Text(
                _stringValue(
                  report['id'],
                  fallback: 'Unknown ID',
                ),
                style:
                    Theme.of(context)
                        .textTheme
                        .bodySmall,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDetailSection(
    String title,
    List<Widget> children,
  ) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 18,
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),

          const SizedBox(
            height: 10,
          ),

          Card(
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                children: children,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(
    String label,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 10,
      ),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 115,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          const SizedBox(
            width: 8,
          ),

          Expanded(
            child: Text(
              value.isEmpty
                  ? 'Not specified'
                  : value,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextSection(
    String title,
    String text,
  ) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 18,
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),

          const SizedBox(
            height: 10,
          ),

          Card(
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Text(text),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAiDetails(
    Map<String, dynamic> report,
  ) {
    final rawAi = report['aiAnalysis'];

    if (rawAi is! Map) {
      return const SizedBox.shrink();
    }

    final ai = Map<String, dynamic>.from(rawAi);

    if (ai['completed'] != true) {
      return const SizedBox.shrink();
    }

    final explanation = _stringValue(
      ai['explanation'],
    );

    final confidence = ai['confidence'];

    final risk = _stringValue(
      ai['riskLevel'],
    );

    final children = <Widget>[];

    if (risk.isNotEmpty) {
      children.add(
        _buildDetailRow(
          'AI Risk',
          risk,
        ),
      );
    }

    if (confidence != null) {
      children.add(
        _buildDetailRow(
          'Confidence',
          _formatConfidence(confidence),
        ),
      );
    }

    if (explanation.isNotEmpty) {
      children.add(
        Padding(
          padding: const EdgeInsets.only(
            top: 4,
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              explanation,
            ),
          ),
        ),
      );
    }

    if (children.isEmpty) {
      return const SizedBox.shrink();
    }

    return _buildDetailSection(
      'AI Safety Analysis',
      children,
    );
  }

  String _formatConfidence(
    dynamic value,
  ) {
    double confidence = 0.0;

    if (value is num) {
      confidence = value.toDouble();
    } else {
      confidence =
          double.tryParse(value.toString()) ?? 0.0;
    }

    if (confidence <= 1) {
      confidence *= 100;
    }

    confidence = confidence.clamp(
      0,
      100,
    );

    return '${confidence.round()}%';
  }
}
