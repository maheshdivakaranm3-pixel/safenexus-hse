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
  static const String _storageKey = 'safety_observations';

  List<Map<String, dynamic>> _observations = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadObservations();
  }

  // ------------------------------------------------------------
  // LOAD OBSERVATIONS
  // ------------------------------------------------------------

  Future<void> _loadObservations() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final storedData = prefs.getString(_storageKey);

      if (storedData == null || storedData.isEmpty) {
        if (!mounted) return;

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

        if (!mounted) return;

        setState(() {
          _observations = loaded.reversed.toList();
          _isLoading = false;
        });
      } else {
        if (!mounted) return;

        setState(() {
          _observations = [];
          _isLoading = false;
        });
      }
    } catch (_) {
      if (!mounted) return;

      setState(() {
        _observations = [];
        _isLoading = false;
      });
    }
  }

  // ------------------------------------------------------------
  // PHOTO PATH
  // ------------------------------------------------------------

  String _getPhotoPath(
    Map<String, dynamic> observation,
  ) {
    final possibleKeys = [
      'photo_path',
      'photoPath',
      'photo',
      'image_path',
      'imagePath',
      'image',
    ];

    for (final key in possibleKeys) {
      final value = observation[key];

      if (value != null &&
          value.toString().trim().isNotEmpty) {
        return value.toString().trim();
      }
    }

    return '';
  }

  bool _hasPhoto(
    Map<String, dynamic> observation,
  ) {
    final path = _getPhotoPath(observation);

    if (path.isEmpty) {
      return false;
    }

    return File(path).existsSync();
  }

  // ------------------------------------------------------------
  // DELETE OBSERVATION
  // ------------------------------------------------------------

  Future<void> _confirmDeleteObservation(
    int index,
  ) async {
    if (index < 0 ||
        index >= _observations.length) {
      return;
    }

    final observation = _observations[index];

    final id = _getValue(
      observation,
      [
        'id',
        'observation_id',
        'observationId',
      ],
    );

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text(
            'Delete Observation?',
          ),
          content: Text(
            id.isNotEmpty
                ? 'Are you sure you want to delete observation $id?'
                : 'Are you sure you want to delete this observation?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(
                  dialogContext,
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
                  dialogContext,
                  true,
                );
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      await _deleteObservation(index);
    }
  }

  Future<void> _deleteObservation(
    int index,
  ) async {
    if (index < 0 ||
        index >= _observations.length) {
      return;
    }

    final observation = _observations[index];

    // Get photo path before removing observation.
    final photoPath = _getPhotoPath(observation);

    final prefs =
        await SharedPreferences.getInstance();

    final updated =
        List<Map<String, dynamic>>.from(
      _observations,
    );

    updated.removeAt(index);

    // Storage keeps oldest -> newest.
    final storageList =
        updated.reversed.toList();

    await prefs.setString(
      _storageKey,
      jsonEncode(storageList),
    );

    // Try deleting the local photo file.
    if (photoPath.isNotEmpty) {
      try {
        final photoFile = File(photoPath);

        if (await photoFile.exists()) {
          await photoFile.delete();
        }
      } catch (_) {
        // Ignore file deletion error.
      }
    }

    if (!mounted) return;

    setState(() {
      _observations = updated;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Observation deleted',
        ),
      ),
    );
  }

  // ------------------------------------------------------------
  // GET VALUE
  // ------------------------------------------------------------

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

  String _formatDateTime(
    String value,
  ) {
    if (value.trim().isEmpty) {
      return value;
    }

    try {
      final dateTime =
          DateTime.parse(value);

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
          dateTime.hour % 12 == 0
              ? 12
              : dateTime.hour % 12;

      final minute =
          dateTime.minute
              .toString()
              .padLeft(2, '0');

      final period =
          dateTime.hour >= 12
              ? 'PM'
              : 'AM';

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

  String _formatValue(
    String key,
    dynamic value,
  ) {
    final text = value.toString();

    if (_isDateKey(key)) {
      return _formatDateTime(text);
    }

    return text;
  }

  // ------------------------------------------------------------
  // FULL SCREEN PHOTO
  // ------------------------------------------------------------

  void _showFullScreenPhoto(
    String photoPath,
  ) {
    if (photoPath.isEmpty) {
      return;
    }

    final file = File(photoPath);

    if (!file.existsSync()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Photo file not found',
          ),
        ),
      );
      return;
    }

    showDialog<void>(
      context: context,
      barrierColor: Colors.black,
      builder: (dialogContext) {
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            title: const Text(
              'Photo Evidence',
            ),
          ),
          body: Center(
            child: InteractiveViewer(
              minScale: 0.8,
              maxScale: 4.0,
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

  // ------------------------------------------------------------
  // PHOTO PREVIEW
  // ------------------------------------------------------------

  Widget _photoPreview(
    String photoPath,
  ) {
    if (photoPath.isEmpty) {
      return const SizedBox.shrink();
    }

    final file = File(photoPath);

    if (!file.existsSync()) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(14),
          border: Border.all(
            color: Colors.grey.shade300,
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.broken_image_outlined,
              color: Colors.grey.shade600,
            ),
            const SizedBox(width: 10),
            const Expanded(
              child: Text(
                'Photo file not available',
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        const Text(
          'Photo Evidence',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 10),

        GestureDetector(
          onTap: () {
            _showFullScreenPhoto(
              photoPath,
            );
          },
          child: ClipRRect(
            borderRadius:
                BorderRadius.circular(14),
            child: Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 220,
                  child: Image.file(
                    file,
                    fit: BoxFit.cover,
                  ),
                ),

                Positioned(
                  right: 10,
                  bottom: 10,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius:
                          BorderRadius.circular(20),
                    ),
                    child: const Row(
                      mainAxisSize:
                          MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.zoom_in,
                          color: Colors.white,
                          size: 18,
                        ),
                        SizedBox(width: 5),
                        Text(
                          'View',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight:
                                FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 12),
      ],
    );
  }

  // ------------------------------------------------------------
  // SHARE OBSERVATION
  // ------------------------------------------------------------

  Future<void> _shareObservation(
    Map<String, dynamic> observation,
  ) async {
    final id = _getValue(
      observation,
      [
        'id',
        'observation_id',
        'observationId',
      ],
    );

    final type = _getValue(
      observation,
      [
        'observation_type',
        'type',
      ],
    );

    final category = _getValue(
      observation,
      [
        'category',
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

    final description = _getValue(
      observation,
      [
        'description',
        'observation',
        'finding',
        'title',
      ],
    );

    final action = _getValue(
      observation,
      [
        'immediate_action',
        'action',
        'action_taken',
      ],
    );

    final location = _getValue(
      observation,
      [
        'location',
        'location_area',
      ],
    );

    final rawDate = _getValue(
      observation,
      [
        'date',
        'created_at',
        'timestamp',
        'submitted_at',
      ],
    );

    final date = rawDate.isNotEmpty
        ? _formatDateTime(rawDate)
        : '';

    final photoPath =
        _getPhotoPath(observation);

    final buffer = StringBuffer();

    buffer.writeln(
      'SafeNexus HSE - Safety Observation',
    );
    buffer.writeln('');
    
    if (id.isNotEmpty) {
      buffer.writeln(
        'Observation ID: $id',
      );
    }

    if (type.isNotEmpty) {
      buffer.writeln(
        'Observation Type: $type',
      );
    }

    if (category.isNotEmpty) {
      buffer.writeln(
        'Category: $category',
      );
    }

    if (severity.isNotEmpty) {
      buffer.writeln(
        'Severity: $severity',
      );
    }

    if (description.isNotEmpty) {
      buffer.writeln(
        'Description: $description',
      );
    }

    if (action.isNotEmpty) {
      buffer.writeln(
        'Immediate Action: $action',
      );
    }

    if (location.isNotEmpty) {
      buffer.writeln(
        'Location: $location',
      );
    }

    if (date.isNotEmpty) {
      buffer.writeln(
        'Date: $date',
      );
    }

    buffer.writeln('');
    buffer.writeln(
      'Generated by SafeNexus HSE',
    );

    try {
      if (photoPath.isNotEmpty &&
          File(photoPath).existsSync()) {
        await Share.shareXFiles(
          [
            XFile(photoPath),
          ],
          text: buffer.toString(),
          subject:
              'Safety Observation ${id.isNotEmpty ? id : ''}',
        );
      } else {
        await Share.share(
          buffer.toString(),
          subject:
              'Safety Observation ${id.isNotEmpty ? id : ''}',
        );
      }
    } catch (_) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Unable to share observation',
          ),
        ),
      );
    }
  }

  // ------------------------------------------------------------
  // OBSERVATION DETAILS
  // ------------------------------------------------------------

  void _showObservationDetails(
    BuildContext context,
    Map<String, dynamic> observation,
    int index,
  ) {
    final entries =
        observation.entries.where((entry) {
      final value = entry.value;

      return value != null &&
          value.toString().trim().isNotEmpty;
    }).toList();

    final photoPath =
        _getPhotoPath(observation);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.fromLTRB(
              20,
              8,
              20,
              24,
            ),
            child: SizedBox(
              height:
                  MediaQuery.of(sheetContext)
                          .size
                          .height *
                      0.88,
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  // ------------------------------------------------
                  // TITLE
                  // ------------------------------------------------

                  const Text(
                    'Observation Details',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // ------------------------------------------------
                  // PHOTO
                  // ------------------------------------------------

                  if (_hasPhoto(observation))
                    _photoPreview(
                      photoPath,
                    ),

                  // ------------------------------------------------
                  // DETAILS
                  // ------------------------------------------------

                  Expanded(
                    child: ListView(
                      children: [
                        ...entries.map(
                          (entry) {
                            // Don't show the raw photo path.
                            final normalizedKey =
                                entry.key
                                    .toLowerCase()
                                    .replaceAll(
                                      '_',
                                      '',
                                    )
                                    .replaceAll(
                                      '-',
                                      '',
                                    )
                                    .replaceAll(
                                      ' ',
                                      '',
                                    );

                            final isPhotoKey =
                                normalizedKey ==
                                        'photopath' ||
                                    normalizedKey ==
                                        'photopath' ||
                                    normalizedKey ==
                                        'photo' ||
                                    normalizedKey ==
                                        'imagepath' ||
                                    normalizedKey ==
                                        'image';

                            if (isPhotoKey) {
                              return const SizedBox
                                  .shrink();
                            }

                            return Padding(
                              padding:
                                  const EdgeInsets
                                      .only(
                                bottom: 14,
                              ),
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,
                                children: [
                                  Text(
                                    _formatKey(
                                      entry.key,
                                    ),
                                    style:
                                        TextStyle(
                                      fontSize: 13,
                                      fontWeight:
                                          FontWeight
                                              .w600,
                                      color: Colors
                                          .grey
                                          .shade600,
                                    ),
                                  ),

                                  const SizedBox(
                                    height: 4,
                                  ),

                                  Text(
                                    _formatValue(
                                      entry.key,
                                      entry.value,
                                    ),
                                    style:
                                        const TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),

                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),

                  // ------------------------------------------------
                  // ACTION BUTTONS
                  // ------------------------------------------------

                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () async {
                            Navigator.pop(
                              sheetContext,
                            );

                            await _shareObservation(
                              observation,
                            );
                          },
                          icon: const Icon(
                            Icons.share_outlined,
                          ),
                          label: const Text(
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
                                Colors.red,
                          ),
                          onPressed: () async {
                            Navigator.pop(
                              sheetContext,
                            );

                            await _confirmDeleteObservation(
                              index,
                            );
                          },
                          icon: const Icon(
                            Icons.delete_outline,
                          ),
                          label: const Text(
                            'Delete',
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () {
                        Navigator.pop(
                          sheetContext,
                        );
                      },
                      child: const Text(
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

  String _formatKey(
    String key,
  ) {
    final formatted = key
        .replaceAll('_', ' ')
        .replaceAll('-', ' ');

    if (formatted.isEmpty) {
      return key;
    }

    return formatted[0].toUpperCase() +
        formatted.substring(1);
  }

  // ------------------------------------------------------------
  // BUILD
  // ------------------------------------------------------------

  @override
  Widget build(
    BuildContext context,
  ) {
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
            icon: const Icon(
              Icons.refresh,
            ),
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
        padding:
            const EdgeInsets.all(16),
        itemCount:
            _observations.length,
        itemBuilder:
            (context, index) {
          final observation =
              _observations[index];

          return _observationCard(
            context,
            observation,
            index,
          );
        },
      ),
    );
  }

  // ------------------------------------------------------------
  // EMPTY STATE
  // ------------------------------------------------------------

  Widget _emptyState() {
    return Center(
      child: Padding(
        padding:
            const EdgeInsets.all(32),
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
                fontWeight:
                    FontWeight.bold,
              ),
              textAlign:
                  TextAlign.center,
            ),

            const SizedBox(height: 8),

            Text(
              'Submitted safety observations will appear here.',
              style: TextStyle(
                color:
                    Colors.grey.shade600,
                fontSize: 14,
              ),
              textAlign:
                  TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  // ------------------------------------------------------------
  // OBSERVATION CARD
  // ------------------------------------------------------------

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

    final date =
        rawDate.isNotEmpty
            ? _formatDateTime(
                rawDate,
              )
            : '';

    final hasPhoto =
        _hasPhoto(observation);

    return Card(
      margin:
          const EdgeInsets.only(
        bottom: 12,
      ),
      child: InkWell(
        onTap: () {
          _showObservationDetails(
            context,
            observation,
            index,
          );
        },
        borderRadius:
            BorderRadius.circular(12),
        child: Padding(
          padding:
              const EdgeInsets.all(16),
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
                        const EdgeInsets.all(
                      10,
                    ),
                    decoration:
                        BoxDecoration(
                      color:
                          Colors.blue.withValues(
                        alpha: 0.10,
                      ),
                      borderRadius:
                          BorderRadius.circular(
                        10,
                      ),
                    ),
                    child:
                        const Icon(
                      Icons.visibility,
                      color: Colors.blue,
                    ),
                  ),

                  const SizedBox(
                    width: 12,
                  ),

                  Expanded(
                    child: Text(
                      title.isNotEmpty
                          ? title
                          : 'Safety Observation',
                      style:
                          const TextStyle(
                        fontSize: 16,
                        fontWeight:
                            FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow:
                          TextOverflow.ellipsis,
                    ),
                  ),

                  PopupMenuButton<String>(
                    onSelected:
                        (value) {
                      if (value ==
                          'share') {
                        _shareObservation(
                          observation,
                        );
                      }

                      if (value ==
                          'delete') {
                        _confirmDeleteObservation(
                          index,
                        );
                      }
                    },
                    itemBuilder:
                        (context) =>
                            const [
                      PopupMenuItem<
                          String>(
                        value:
                            'share',
                        child: Row(
                          children: [
                            Icon(
                              Icons
                                  .share_outlined,
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

                      PopupMenuItem<
                          String>(
                        value:
                            'delete',
                        child: Row(
                          children: [
                            Icon(
                              Icons
                                  .delete_outline,
                              color:
                                  Colors.red,
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
                height: 14,
              ),

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

              if (hasPhoto) ...[
                const SizedBox(
                  height: 6,
                ),
                Row(
                  children: [
                    Icon(
                      Icons
                          .photo_camera_outlined,
                      size: 18,
                      color:
                          Colors.grey.shade600,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      'Photo attached',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors
                            .grey
                            .shade600,
                        fontWeight:
                            FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],

              const SizedBox(
                height: 8,
              ),

              Align(
                alignment:
                    Alignment.centerRight,
                child: Text(
                  'Tap to view details',
                  style: TextStyle(
                    fontSize: 12,
                    color:
                        Colors.grey.shade600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ------------------------------------------------------------
  // INFO ROW
  // ------------------------------------------------------------

  Widget _infoRow(
    IconData icon,
    String label,
    String value,
  ) {
    return Padding(
      padding:
          const EdgeInsets.only(
        bottom: 8,
      ),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 18,
            color:
                Colors.grey.shade600,
          ),

          const SizedBox(
            width: 8,
          ),

          Text(
            '$label: ',
            style:
                const TextStyle(
              fontWeight:
                  FontWeight.w600,
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
