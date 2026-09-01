import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ObservationHistoryPage extends StatefulWidget {
  const ObservationHistoryPage({super.key});

  @override
  State<ObservationHistoryPage> createState() =>
      _ObservationHistoryPageState();
}

class _ObservationHistoryPageState
    extends State<ObservationHistoryPage> {
  static const String _storageKey = 'safety_observations';

  List<Map<String, dynamic>> _observations = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadObservations();
  }

  Future<void> _loadObservations() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final storedData = prefs.getString(_storageKey);

      if (storedData == null || storedData.isEmpty) {
        setState(() {
          _observations = [];
          _isLoading = false;
        });
        return;
      }

      final decoded = jsonDecode(storedData);

      if (decoded is List) {
        final loaded = decoded
            .whereType<Map>()
            .map(
              (item) => Map<String, dynamic>.from(item),
            )
            .toList();

        setState(() {
          _observations = loaded.reversed.toList();
          _isLoading = false;
        });
      } else {
        setState(() {
          _observations = [];
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _observations = [];
        _isLoading = false;
      });
    }
  }

  Future<void> _deleteObservation(int index) async {
    if (index < 0 || index >= _observations.length) {
      return;
    }

    final prefs = await SharedPreferences.getInstance();

    final updated = List<Map<String, dynamic>>.from(
      _observations,
    );

    updated.removeAt(index);

    final storageList = updated.reversed.toList();

    await prefs.setString(
      _storageKey,
      jsonEncode(storageList),
    );

    setState(() {
      _observations = updated;
    });

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Observation deleted'),
      ),
    );
  }

  String _getValue(
    Map<String, dynamic> observation,
    List<String> keys,
  ) {
    for (final key in keys) {
      final value = observation[key];

      if (value != null &&
          value.toString().trim().isNotEmpty) {
        return value.toString();
      }
    }

    return '';
  }

  // ------------------------------------------------------------
  // DATE / TIME FORMATTER
  // ------------------------------------------------------------

  String _formatDateTime(String value) {
    if (value.trim().isEmpty) {
      return value;
    }

    try {
      final dateTime = DateTime.parse(value);

      const months = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec',
      ];

      final hour = dateTime.hour % 12 == 0
          ? 12
          : dateTime.hour % 12;

      final minute =
          dateTime.minute.toString().padLeft(2, '0');

      final period =
          dateTime.hour >= 12 ? 'PM' : 'AM';

      return '${dateTime.day.toString().padLeft(2, '0')} '
          '${months[dateTime.month - 1]} '
          '${dateTime.year} • '
          '$hour:$minute $period';
    } catch (_) {
      return value;
    }
  }

  bool _isDateKey(String key) {
    final normalized = key
        .toLowerCase()
        .replaceAll('_', '')
        .replaceAll('-', '')
        .replaceAll(' ', '');

    return normalized == 'date' ||
        normalized == 'createdat' ||
        normalized == 'timestamp' ||
        normalized == 'submittedat';
  }

  String _formatValue(String key, dynamic value) {
    final text = value.toString();

    if (_isDateKey(key)) {
      return _formatDateTime(text);
    }

    return text;
  }

  // ------------------------------------------------------------
  // OBSERVATION DETAILS
  // ------------------------------------------------------------

  void _showObservationDetails(
    BuildContext context,
    Map<String, dynamic> observation,
  ) {
    final entries = observation.entries.where((entry) {
      final value = entry.value;

      return value != null &&
          value.toString().trim().isNotEmpty;
    }).toList();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              20,
              8,
              20,
              24,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Observation Details',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 20),

                  ...entries.map(
                    (entry) => Padding(
                      padding: const EdgeInsets.only(
                        bottom: 14,
                      ),
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(
                            _formatKey(entry.key),
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade600,
                            ),
                          ),

                          const SizedBox(height: 4),

                          Text(
                            _formatValue(
                              entry.key,
                              entry.value,
                            ),
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Close'),
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

  String _formatKey(String key) {
    final formatted = key
        .replaceAll('_', ' ')
        .replaceAll('-', ' ');

    if (formatted.isEmpty) {
      return key;
    }

    return formatted[0].toUpperCase() +
        formatted.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Reports & History',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadObservations,
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_observations.isEmpty) {
      return _emptyState();
    }

    return RefreshIndicator(
      onRefresh: _loadObservations,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _observations.length,
        itemBuilder: (context, index) {
          final observation = _observations[index];

          return _observationCard(
            context,
            observation,
            index,
          );
        },
      ),
    );
  }

  Widget _emptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            Icon(
              Icons.history,
              size: 72,
              color: Colors.grey.shade400,
            ),

            const SizedBox(height: 20),

            const Text(
              'No Safety Observations',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 8),

            Text(
              'Submitted safety observations will appear here.',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _observationCard(
    BuildContext context,
    Map<String, dynamic> observation,
    int index,
  ) {
    final title = _getValue(
      observation,
      [
        'title',
        'observation',
        'description',
        'finding',
      ],
    );

    final category = _getValue(
      observation,
      [
        'category',
        'type',
        'observation_type',
      ],
    );

    final severity = _getValue(
      observation,
      [
        'severity',
        'risk_level',
        'risk',
      ],
    );

    final dateKey = [
      'date',
      'created_at',
      'timestamp',
      'submitted_at',
    ];

    final rawDate = _getValue(
      observation,
      dateKey,
    );

    final date = rawDate.isNotEmpty
        ? _formatDateTime(rawDate)
        : '';

    return Card(
      margin: const EdgeInsets.only(
        bottom: 12,
      ),
      child: InkWell(
        onTap: () {
          _showObservationDetails(
            context,
            observation,
          );
        },
        borderRadius:
            BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
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
                    decoration: BoxDecoration(
                      color: Colors.blue.withValues(
                        alpha: 0.10,
                      ),
                      borderRadius:
                          BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.visibility,
                      color: Colors.blue,
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Text(
                      title.isNotEmpty
                          ? title
                          : 'Safety Observation',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow:
                          TextOverflow.ellipsis,
                    ),
                  ),

                  PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'delete') {
                        _deleteObservation(index);
                      }
                    },
                    itemBuilder: (context) =>
                        const [
                      PopupMenuItem<String>(
                        value: 'delete',
                        child: Row(
                          children: [
                            Icon(
                              Icons.delete_outline,
                              color: Colors.red,
                            ),
                            SizedBox(width: 8),
                            Text('Delete'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 14),

              if (category.isNotEmpty)
                _infoRow(
                  Icons.category_outlined,
                  'Category',
                  category,
                ),

              if (severity.isNotEmpty)
                _infoRow(
                  Icons.warning_amber_outlined,
                  'Severity',
                  severity,
                ),

              if (date.isNotEmpty)
                _infoRow(
                  Icons.calendar_today_outlined,
                  'Date',
                  date,
                ),

              const SizedBox(height: 8),

              Align(
                alignment:
                    Alignment.centerRight,
                child: Text(
                  'Tap to view details',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoRow(
    IconData icon,
    String label,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 8,
      ),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 18,
            color: Colors.grey.shade600,
          ),

          const SizedBox(width: 8),

          Text(
            '$label: ',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),

          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}
