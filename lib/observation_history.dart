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
        // Ignore invalid saved records.
      }
    }

    loaded.sort((a, b) {
      final aDate =
          DateTime.tryParse(a['dateTime']?.toString() ?? '') ??
              DateTime.fromMillisecondsSinceEpoch(0);

      final bDate =
          DateTime.tryParse(b['dateTime']?.toString() ?? '') ??
              DateTime.fromMillisecondsSinceEpoch(0);

      return bDate.compareTo(aDate);
    });

    if (!mounted) return;

    setState(() {
      _observations = loaded;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Observation History'),
      ),
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _observations.isEmpty
              ? const Center(
                  child: Text(
                    'No observations found.',
                    style: TextStyle(fontSize: 16),
                  ),
                )
              : RefreshIndicator(
                  onRefresh: _loadObservations,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: _observations.length,
                    itemBuilder: (context, index) {
                      final observation =
                          _observations[index];

                      return _observationCard(
                        observation,
                      );
                    },
                  ),
                ),
    );
  }

  Widget _observationCard(
    Map<String, dynamic> observation,
  ) {
    final risk =
        observation['risk']?.toString() ?? 'Medium';

    final type =
        observation['type']?.toString() ?? 'Observation';

    final id =
        observation['id']?.toString() ?? '';

    final category =
        observation['category']?.toString() ?? '';

    final location =
        observation['location']?.toString() ?? '';

    final dateTime =
        DateTime.tryParse(
          observation['dateTime']?.toString() ?? '',
        );

    final dateText = dateTime == null
        ? ''
        : '${dateTime.day.toString().padLeft(2, '0')}/'
            '${dateTime.month.toString().padLeft(2, '0')}/'
            '${dateTime.year} '
            '${dateTime.hour.toString().padLeft(2, '0')}:'
            '${dateTime.minute.toString().padLeft(2, '0')}';

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.all(14),
        leading: CircleAvatar(
          child: Icon(
            risk == 'Critical' || risk == 'High'
                ? Icons.warning_amber
                : Icons.health_and_safety,
          ),
        ),
        title: Text(
          type,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
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
        trailing: _riskBadge(risk),
        onTap: () {
          _showDetails(observation);
        },
      ),
    );
  }

  Widget _riskBadge(String risk) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: _riskColor(risk).withValues(alpha: 0.15),
      ),
      child: Text(
        risk,
        style: TextStyle(
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

  void _showDetails(
    Map<String, dynamic> observation,
  ) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) {
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
                  'Observation
