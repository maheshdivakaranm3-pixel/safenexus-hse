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
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadObservations();
  }

  Future<void> _loadObservations() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final savedData =
          prefs.getStringList(_storageKey) ?? <String>[];

      final loaded = <Map<String, dynamic>>[];

      for (final item in savedData) {
        try {
          final decoded = jsonDecode(item);

          if (decoded is Map) {
            loaded.add(
              Map<String, dynamic>.from(decoded),
            );
          }
        } catch (_) {
          // Ignore invalid records.
        }
      }

      loaded.sort((a, b) {
        final aDate = DateTime.tryParse(
              a['dateTime']?.toString() ?? '',
            ) ??
            DateTime.fromMillisecondsSinceEpoch(0);

        final bDate = DateTime.tryParse(
              b['dateTime']?.toString() ?? '',
            ) ??
            DateTime.fromMillisecondsSinceEpoch(0);

        return bDate.compareTo(aDate);
      });

      if (!mounted) return;

      setState(() {
        _observations = loaded;
        _loading = false;
      });
    } catch (_) {
      if (!mounted) return;

      setState(() {
        _observations = [];
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Observation History'),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_observations.isEmpty) {
      return RefreshIndicator(
        onRefresh: _loadObservations,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: const [
            SizedBox(height: 220),
            Center(
              child: Text(
                'No observations found.',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadObservations,
      child: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: _observations.length,
        itemBuilder: (context, index) {
          return _observationCard(
            _observations[index],
          );
        },
      ),
    );
  }

  Widget _observationCard(
    Map<String, dynamic> observation,
  ) {
    final id =
        observation['id']?.toString() ?? '';

    final type =
        observation['type']?.toString() ?? 'Observation';

    final category =
        observation['category']?.toString() ?? '';

    final risk =
        observation['risk']?.toString() ?? 'Medium';

    final location =
        observation['location']?.toString() ?? '';

    final dateTime =
        DateTime.tryParse(
      observation['dateTime']?.toString() ?? '',
    );

    final dateText = dateTime == null
        ? ''
        : _formatDateTime(dateTime);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          _showDetails(observation);
        },
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 24,
                child: Icon(
                  _riskIcon(risk),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      type,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text('ID: $id'),
                    if (category.isNotEmpty)
                      Text('Category: $category'),
                    if (location.isNotEmpty)
                      Text('Location: $location'),
                    if (dateText.isNotEmpty)
                      Text('Date: $dateText'),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              _riskBadge(risk),
            ],
          ),
        ),
      ),
    );
  }

  Widget _riskBadge(String risk) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: _riskColor(risk).withOpacity(0.15),
      ),
      child: Text(
        risk,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: _riskColor(risk),
        ),
      ),
    );
  }

  Color _riskColor(String risk) {
    switch (risk) {
      case 'Critical':
        return Colors.red;
      case 'High':
        return Colors.deepOrange;
      case 'Medium':
        return Colors.orange;
      case 'Low':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  IconData _riskIcon(String risk) {
    switch (risk) {
      case 'Critical':
      case 'High':
        return Icons.warning_amber;
      case 'Medium':
        return Icons.health_and_safety;
      case 'Low':
        return Icons.check_circle_outline;
      default:
        return Icons.health_and_safety;
    }
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day.toString().padLeft(2, '0')}/'
        '${dateTime.month.toString().padLeft(2, '0')}/'
        '${dateTime.year} '
        '${dateTime.hour.toString().padLeft(2, '0')}:'
        '${dateTime.minute.toString().padLeft(2, '0')}';
  }

  void _showDetails(
    Map<String, dynamic> observation,
  ) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (sheetContext) {
        return SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(
              20,
              8,
              20,
              30,
            ),
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

                _detailRow(
                  'Observation ID',
                  observation['id'],
                ),

                _detailRow(
                  'Observation Type',
                  observation['type'],
                ),

                _detailRow(
                  'Category',
                  observation['category'],
                ),

                _detailRow(
                  'Risk Level',
                  observation['risk'],
                ),

                _detailRow(
                  'Location / Area',
                  observation['location'],
                ),

                _detailRow(
                  'Description',
                  observation['description'],
                ),

                _detailRow(
                  'Immediate Action',
                  observation['action'],
                ),

                _detailRow(
                  'Date & Time',
                  _formatSavedDate(
                    observation['dateTime'],
                  ),
                ),
              ],
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
        value?.toString().trim() ?? '';

    if (text.isEmpty) {
      return
