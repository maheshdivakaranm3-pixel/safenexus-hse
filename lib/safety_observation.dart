import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:share_plus/share_plus.dart';

class ObservationHistoryPage extends StatefulWidget {
  const ObservationHistoryPage({super.key});

  @override
  State<ObservationHistoryPage> createState() =>
      _ObservationHistoryPageState();
}

class _ObservationHistoryPageState
    extends State<ObservationHistoryPage> {
  static const String _storageKey = 'safenexus_observations';

  List<Map<String, dynamic>> _observations = [];
  bool _isLoading = true;


  @override
  void initState() {
    super.initState();
    _loadObservations();
  }

  // ============================================================
  // LOAD
  // ============================================================

  Future<void> _loadObservations() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final List<String> stored =
          prefs.getStringList(_storageKey) ?? <String>[];

      final List<Map<String, dynamic>> loaded = [];

      for (final item in stored) {
        try {
          final decoded = jsonDecode(item);

          if (decoded is Map) {
            loaded.add(
              Map<String, dynamic>.from(decoded),
            );
          }
        } catch (_) {
          // Ignore one corrupted record.
        }
      }

      if (!mounted) return;

      setState(() {
        _observations = loaded;
        _isLoading = false;
      });
    } catch (_) {
      if (!mounted) return;

      setState(() {
        _observations = [];
        _isLoading = false;
      });
    }
  }

  // ============================================================
  // VALUE HELPERS
  // ============================================================

  String _value(
    Map<String, dynamic> item,
    List<String> keys,
  ) {
    for (final key in keys) {
      final value = item[key];

      if (value != null &&
          value.toString().trim().isNotEmpty) {
        return value.toString().trim();
      }
    }

    return '';
  }

  String _photoPath(Map<String, dynamic> item) {
    return _value(
      item,
      [
        'photoPath',
        'photo_path',
        'imagePath',
        'image_path',
        'photo',
        'image',
      ],
    );
  }

  bool _hasPhoto(Map<String, dynamic> item) {
    final path = _photoPath(item);

    if (path.isEmpty) return false;

    return File(path).existsSync();
  }

  // ============================================================
  // RISK
  // ============================================================

  Color _riskColor(String risk) {
    switch (risk.toLowerCase()) {
      case 'critical':
        return Colors.deepPurple.shade700;
      case 'high':
        return Colors.red.shade700;
      case 'medium':
        return Colors.orange.shade700;
      case 'low':
        return Colors.green.shade700;
      default:
        return Colors.blueGrey.shade700;
    }
  }

  IconData _riskIcon(String risk) {
    switch (risk.toLowerCase()) {
      case 'critical':
        return Icons.dangerous_rounded;
      case 'high':
        return Icons.warning_rounded;
      case 'medium':
        return Icons.warning_amber_rounded;
      case 'low':
        return Icons.check_circle_rounded;
      default:
        return Icons.help_outline_rounded;
    }
  }

  // ============================================================
  // DATE
  // ============================================================

  String _formatDate(String value) {
    if (value.trim().isEmpty) {
      return '';
    }

    try {
      final date = DateTime.parse(value).toLocal();

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

      final hour =
          date.hour % 12 == 0 ? 12 : date.hour % 12;

      final minute =
          date.minute.toString().padLeft(2, '0');

      final period = date.hour >= 12 ? 'PM' : 'AM';

      return '${date.day.toString().padLeft(2, '0')} '
          '${months[date.month - 1]} '
          '${date.year} • '
          '$hour:$minute $period';
    } catch (_) {
      return value;
    }
  }

  // ============================================================
  // DELETE
  // ============================================================

  Future<void> _deleteObservation(int index) async {
    if (index < 0 || index >= _observations.length) {
      return;
    }

    final observation = _observations[index];
    final photo = _photoPath(observation);

    try {
      final prefs = await SharedPreferences.getInstance();

      final updated =
          List<Map<String, dynamic>>.from(_observations);

      updated.removeAt(index);

      final storage = updated
          .map(jsonEncode)
          .toList();

      await prefs.setStringList(
        _storageKey,
        storage,
      );

      if (photo.isNotEmpty) {
        try {
          final file = File(photo);

          if (await file.exists()) {
            await file.delete();
          }
        } catch (_) {}
      }

      if (!mounted) return;

      setState(() {
        _observations = updated;
      });

      _message(
        'Observation deleted.',
      );
    } catch (_) {
      if (!mounted) return;

      _message(
        'Unable to delete observation.',
        error: true,
      );
    }
  }

  Future<void> _confirmDelete(int index) async {
    if (index < 0 || index >= _observations.length) {
      return;
    }

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(
            'Delete Observation?',
          ),
          content: Text(
            'This observation will be permanently removed from this device.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, false);
              },
              child: Text(
                'Cancel',
              ),
            ),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: Colors.red.shade700,
              ),
              onPressed: () {
                Navigator.pop(dialogContext, true);
              },
              child: Text(
                'Delete',
              ),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      await _deleteObservation(index);
    }
  }

  // ============================================================
  // SHARE
  // ============================================================

  Future<void> _shareObservation(
    Map<String, dynamic> item,
  ) async {
    final id = _value(
      item,
      ['id', 'observation_id', 'observationId'],
    );

    final type = _value(
      item,
      ['type', 'observation_type'],
    );

    final category = _value(
      item,
      ['category'],
    );

    final hazard = _value(
      item,
      ['hazard'],
    );

    final risk = _value(
      item,
      ['risk', 'risk_level', 'severity'],
    );

    final consequence = _value(
      item,
      ['consequence', 'potential_consequence'],
    );

    final description = _value(
      item,
      ['description', 'observation', 'finding'],
    );

    final action = _value(
      item,
      ['action', 'corrective_action'],
    );

    final location = _value(
      item,
      ['location'],
    );

    final dateTime = _value(
      item,
      ['dateTime', 'date', 'created_at'],
    );

    final buffer = StringBuffer();

    buffer.writeln(
      'SafeNexus HSE - Safety Observation',
    );
    buffer.writeln('');

    if (id.isNotEmpty) {
      buffer.writeln('Observation ID: $id');
    }

    if (type.isNotEmpty) {
      buffer.writeln('Observation Type: $type');
    }

    if (category.isNotEmpty) {
      buffer.writeln('Category: $category');
    }

    if (hazard.isNotEmpty) {
      buffer.writeln('Hazard: $hazard');
    }

    if (risk.isNotEmpty) {
      buffer.writeln('Risk Level: $risk');
    }

    if (consequence.isNotEmpty) {
      buffer.writeln(
        'Potential Consequence: $consequence',
      );
    }

    if (description.isNotEmpty) {
      buffer.writeln('Description: $description');
    }

    if (action.isNotEmpty) {
      buffer.writeln('Corrective Action: $action');
    }

    if (location.isNotEmpty) {
      buffer.writeln('Location: $location');
    }

    if (dateTime.isNotEmpty) {
      buffer.writeln(
        'Date: ${_formatDate(dateTime)}',
      );
    }

    buffer.writeln('');
    buffer.writeln('Generated by SafeNexus HSE');

    try {
      final photo = _photoPath(item);

      if (photo.isNotEmpty &&
          File(photo).existsSync()) {
        await Share.shareXFiles(
          [XFile(photo)],
          text: buffer.toString(),
          subject: id.isNotEmpty
              ? 'Safety Observation $id'
              : 'Safety Observation',
        );
      } else {
        await Share.share(
          buffer.toString(),
          subject: id.isNotEmpty
              ? 'Safety Observation $id'
              : 'Safety Observation',
        );
      }
    } catch (_) {
      if (!mounted) return;

      _message(
        'Unable to share observation.',
        error: true,
      );
    }
  }

  // ============================================================
  // MESSAGE
  // ============================================================

  void _message(
    String message, {
    bool error = false,
  }) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor:
            error ? Colors.red.shade700 : Colors.green.shade700,
        behavior: SnackBarBehavior.floating,
        content: Text(message),
      ),
    );
  }

  // ============================================================
  // PHOTO
  // ============================================================

  void _showPhoto(String path) {
    final file = File(path);

    if (!file.existsSync()) {
      _message(
        'Photo file not found.',
        error: true,
      );
      return;
    }

    showDialog<void>(
      context: context,
      barrierColor: Colors.black,
      builder: (_) {
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            title: Text(
              'Photo Evidence',
            ),
          ),
          body: Center(
            child: InteractiveViewer(
              minScale: 0.8,
              maxScale: 4,
              child: Image.file(
                file,
                fit: BoxFit.contain,
              ),
            ),
          ),
        );
      },
    );
  }

  // ============================================================
  // DETAILS
  // ============================================================

  void _showDetails(
    Map<String, dynamic> item,
    int index,
  ) {
    final id = _value(
      item,
      ['id'],
    );

    final type = _value(
      item,
      ['type', 'observation_type'],
    );

    final category = _value(
      item,
      ['category'],
    );

    final hazard = _value(
      item,
      ['hazard'],
    );

    final risk = _value(
      item,
      ['risk', 'risk_level', 'severity'],
    );

    final consequence = _value(
      item,
      ['consequence', 'potential_consequence'],
    );

    final description = _value(
      item,
      ['description', 'observation', 'finding'],
    );

    final action = _value(
      item,
      ['action', 'corrective_action'],
    );

    final location = _value(
      item,
      ['location'],
    );

    final date = _value(
      item,
      ['dateTime', 'date', 'created_at'],
    );

    final aiExplanation = _value(
      item,
      ['aiExplanation', 'explanation'],
    );

    final aiConfidence = item['aiConfidence'];

    final photo = _photoPath(item);

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      backgroundColor: Colors.white,
      builder: (sheetContext) {
        return SafeArea(
          child: SizedBox(
            height:
                MediaQuery.of(sheetContext).size.height * 0.90,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                18,
                4,
                18,
                18,
              ),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Observation Details',
                          style: const TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      if (risk.isNotEmpty)
                        Container(
                          padding:
                              const EdgeInsets.symmetric(
                            horizontal: 11,
                            vertical: 7,
                          ),
                          decoration: BoxDecoration(
                            color: _riskColor(risk),
                            borderRadius:
                                BorderRadius.circular(30),
                          ),
                          child: Text(
                            risk.toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                    ],
                  ),

                  const SizedBox(height: 15),

                  Expanded(
                    child: ListView(
                      children: [
                        if (_hasPhoto(item))
                          GestureDetector(
                            onTap: () {
                              _showPhoto(photo);
                            },
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(18),
                              child: Image.file(
                                File(photo),
                                height: 190,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),

                        if (_hasPhoto(item))
                          const SizedBox(height: 16),

                        if (id.isNotEmpty)
                          _detailTile(
                            Icons.tag_rounded,
                            'Observation ID',
                            id,
                          ),

                        if (type.isNotEmpty)
                          _detailTile(
                            Icons.visibility_outlined,
                            'Observation Type',
                            type,
                          ),

                        if (category.isNotEmpty)
                          _detailTile(
                            Icons.category_outlined,
                            'Category',
                            category,
                          ),

                        if (hazard.isNotEmpty)
                          _detailTile(
                            Icons.warning_amber_rounded,
                            'Hazard',
                            hazard,
                            iconColor:
                                Colors.orange.shade700,
                          ),

                        if (risk.isNotEmpty)
                          _detailTile(
                            _riskIcon(risk),
                            'Risk Level',
                            risk,
                            iconColor:
                                _riskColor(risk),
                          ),

                        if (consequence.isNotEmpty)
                          _detailTile(
                            Icons.report_problem_outlined,
                            'Potential Consequence',
                            consequence,
                            iconColor:
                                Colors.red.shade700,
                          ),

                        if (description.isNotEmpty)
                          _detailTile(
                            Icons.description_outlined,
                            'Description',
                            description,
                          ),

                        if (action.isNotEmpty)
                          _detailTile(
                            Icons.build_circle_outlined,
                            'Corrective Action',
                            action,
                            iconColor:
                                Colors.green.shade700,
                          ),

                        if (location.isNotEmpty)
                          _detailTile(
                            Icons.location_on_outlined,
                            'Location',
                            location,
                          ),

                        if (date.isNotEmpty)
                          _detailTile(
                            Icons.calendar_today_outlined,
                            'Date',
                            _formatDate(date),
                          ),

                        if (aiExplanation.isNotEmpty)
                          _detailTile(
                            Icons.auto_awesome_rounded,
                            'AI Explanation',
                            aiExplanation,
                            iconColor:
                                Colors.purple.shade700,
                          ),

                        if (aiConfidence != null)
                          _detailTile(
                            Icons.analytics_outlined,
                            'AI Confidence',
                            '${(_confidence(aiConfidence) * 100).toStringAsFixed(0)}%',
                          ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),

                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () async {
                            Navigator.pop(sheetContext);
                            await _shareObservation(item);
                          },
                          icon: const Icon(
                            Icons.share_outlined,
                          ),
                          label: Text(
                            'Share',
                          ),
                        ),
                      ),

                      const SizedBox(width: 10),

                      Expanded(
                        child: OutlinedButton.icon(
                          style:
                              OutlinedButton.styleFrom(
                            foregroundColor:
                                Colors.red.shade700,
                          ),
                          onPressed: () async {
                            Navigator.pop(sheetContext);
                            await _confirmDelete(index);
                          },
                          icon: const Icon(
                            Icons.delete_outline,
                          ),
                          label: Text(
                            'Delete',
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () {
                        Navigator.pop(sheetContext);
                      },
                      child: Text(
                        'Close',
                      ),
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

  double _confidence(dynamic value) {
    double result = 0;

    if (value is num) {
      result = value.toDouble();
    } else {
      result =
          double.tryParse(value.toString()) ?? 0;
    }

    if (result > 1 && result <= 100) {
      result /= 100;
    }

    return result.clamp(0, 1).toDouble();
  }

  Widget _detailTile(
    IconData icon,
    String title,
    String value, {
    Color? iconColor,
  }) {
    final color = iconColor ?? Colors.green.shade700;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: color,
            size: 20,
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 13.5,
                    height: 1.4,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // EMPTY
  // ============================================================

  Widget _emptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                color:
                    Colors.green.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.history_rounded,
                size: 45,
                color: Colors.green.shade700,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              'No Safety Observations',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              'Your submitted safety observations will appear here.\nCreate an observation to start building your HSE record.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 13,
                height: 1.45,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // CARD
  // ============================================================

  Widget _observationCard(
    Map<String, dynamic> item,
    int index,
  ) {
    final id = _value(
      item,
      ['id'],
    );

    final type = _value(
      item,
      ['type', 'observation_type'],
    );

    final category = _value(
      item,
      ['category'],
    );

    final hazard = _value(
      item,
      ['hazard'],
    );

    final risk = _value(
      item,
      ['risk', 'risk_level', 'severity'],
    );

    final description = _value(
      item,
      ['description', 'observation', 'finding'],
    );

    final date = _value(
      item,
      ['dateTime', 'date', 'created_at'],
    );

    final riskColor = _riskColor(risk);

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(21),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.035),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          _showDetails(item, index);
        },
        borderRadius: BorderRadius.circular(21),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color:
                          Colors.green.withValues(alpha: 0.08),
                      borderRadius:
                          BorderRadius.circular(14),
                    ),
                    child: Icon(
                      Icons.health_and_safety_rounded,
                      color: Colors.green.shade700,
                    ),
                  ),

                  const SizedBox(width: 11),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          id.isNotEmpty
                              ? id
                              : 'Safety Observation',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w900,
                          ),
                        ),

                        if (date.isNotEmpty) ...[
                          const SizedBox(height: 4),
                          Text(
                            _formatDate(date),
                            style: TextStyle(
                              color:
                                  Colors.grey.shade600,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),

                  if (risk.isNotEmpty)
                    Container(
                      padding:
                          const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        color: riskColor,
                        borderRadius:
                            BorderRadius.circular(30),
                      ),
                      child: Text(
                        risk.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 9.5,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),

                  PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'share') {
                        _shareObservation(item);
                      }

                      if (value == 'delete') {
                        _confirmDelete(index);
                      }
                    },
                    itemBuilder: (_) => [
                      PopupMenuItem(
                        value: 'share',
                        child: Row(
                          children: [
                            const Icon(
                              Icons.share_outlined,
                            ),
                            const SizedBox(width: 9),
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
                              Icons.delete_outline,
                              color:
                                  Colors.red.shade700,
                            ),
                            const SizedBox(width: 9),
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

              const SizedBox(height: 13),

              if (description.isNotEmpty)
                Align(
                  alignment:
                      Alignment.centerLeft,
                  child: Text(
                    description,
                    maxLines: 3,
                    overflow:
                        TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13,
                      height: 1.4,
                    ),
                  ),
                ),

              if (description.isNotEmpty)
                const SizedBox(height: 11),

              Wrap(
                spacing: 7,
                runSpacing: 7,
                children: [
                  if (type.isNotEmpty)
                    _chip(
                      Icons.visibility_outlined,
                      type,
                    ),
                  if (category.isNotEmpty)
                    _chip(
                      Icons.category_outlined,
                      category,
                    ),
                  if (hazard.isNotEmpty)
                    _chip(
                      Icons.warning_amber_rounded,
                      hazard,
                    ),
                  if (_hasPhoto(item))
                    _chip(
                      Icons.photo_camera_outlined,
                      'Photo',
                    ),
                ],
              ),

              const SizedBox(height: 12),

              Row(
                mainAxisAlignment:
                    MainAxisAlignment.end,
                children: [
                  Text(
                    'Tap to view details',
                    style: TextStyle(
                      color:
                          Colors.grey.shade500,
                      fontSize: 10.5,
                      fontWeight:
                          FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 11,
                    color:
                        Colors.grey.shade500,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _chip(
    IconData icon,
    String text,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
            color: Colors.grey.shade700,
          ),
          const SizedBox(width: 5),
          ConstrainedBox(
            constraints:
                const BoxConstraints(maxWidth: 150),
            child: Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 10.5,
                color: Colors.grey.shade700,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // BODY
  // ============================================================

  Widget _historySummary() {
    final total = _observations.length;
    final critical = _observations.where((item) => _value(item, ['risk', 'risk_level', 'severity']).toLowerCase() == 'critical').length;
    final high = _observations.where((item) => _value(item, ['risk', 'risk_level', 'severity']).toLowerCase() == 'high').length;

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 4),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Expanded(child: _summaryMetric(Icons.assignment_rounded, 'Total', '$total')),
          _summaryDivider(),
          Expanded(child: _summaryMetric(Icons.warning_amber_rounded, 'High', '$high')),
          _summaryDivider(),
          Expanded(child: _summaryMetric(Icons.dangerous_rounded, 'Critical', '$critical')),
        ],
      ),
    );
  }

  Widget _summaryMetric(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(icon, size: 20, color: Colors.green.shade700),
        const SizedBox(height: 6),
        Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
        const SizedBox(height: 2),
        Text(label, style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.w600, color: Colors.grey.shade600)),
      ],
    );
  }

  Widget _summaryDivider() => Container(width: 1, height: 48, color: Colors.grey.shade200);

  Widget _body() {
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
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 30),
        itemCount: _observations.length + 1,
        itemBuilder: (_, index) {
          if (index == 0) return _historySummary();
          final observationIndex = index - 1;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _observationCard(_observations[observationIndex], observationIndex),
          );
        },
      ),
    );
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFF5F8F6),

      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,

        title: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Text(
              'Reports & History',
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w900,
              ),
            ),
            Text(
              '${_observations.length} observation(s)',
              style: TextStyle(
                fontSize: 10,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),

        actions: [
          IconButton(
            tooltip: 'Refresh',
            onPressed: _loadObservations,
            icon: const Icon(
              Icons.refresh_rounded,
            ),
          ),
        ],
      ),

      body: _body(),
    );
  }
}
