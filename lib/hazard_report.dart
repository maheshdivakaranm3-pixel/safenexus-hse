import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HazardReportPage extends StatefulWidget {
  const HazardReportPage({super.key});

  @override
  State<HazardReportPage> createState() =>
      _HazardReportPageState();
}

class _HazardReportPageState
    extends State<HazardReportPage> {
  // IMPORTANT:
  // Hazard reports and Safety Observations use the same
  // storage key so that the History screen can display
  // both types of reports together.
  static const String _storageKey =
      'safenexus_observations';

  final _formKey =
      GlobalKey<FormState>();

  final _descriptionController =
      TextEditingController();

  final _locationController =
      TextEditingController();

  final _actionController =
      TextEditingController();

  final ImagePicker _picker =
      ImagePicker();

  // ============================================================
  // FORM VALUES
  // ============================================================

  String _severity = 'Medium';

  String _category =
      'General Safety';

  String _hazardType =
      'General Workplace Hazard';

  XFile? _photo;

  bool _submitting = false;

  // ============================================================
  // OPTIONS
  // ============================================================

  static const List<String>
      _severityOptions = [
    'Low',
    'Medium',
    'High',
    'Critical',
  ];

  static const List<String>
      _categoryOptions = [
    'General Safety',
    'Fire Safety',
    'Electrical Safety',
    'Work at Height',
    'Confined Space',
    'Lifting Operations',
    'PPE',
    'Housekeeping',
  ];

  static const List<String>
      _hazardOptions = [
    'General Workplace Hazard',
    'Slip Trip Fall',
    'Falling Objects',
    'Electrical Hazard',
    'Fire Hazard',
    'Chemical Hazard',
    'Mechanical Hazard',
    'Ergonomic Hazard',
    'Environmental Hazard',
  ];

  // ============================================================
  // DISPOSE
  // ============================================================

  @override
  void dispose() {
    _descriptionController.dispose();
    _locationController.dispose();
    _actionController.dispose();

    super.dispose();
  }

  // ============================================================
  // MESSAGE
  // ============================================================

  void _showMessage(
    String message, {
    bool error = false,
  }) {
    if (!mounted) return;

    ScaffoldMessenger.of(context)
        .hideCurrentSnackBar();

    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(
        behavior:
            SnackBarBehavior.floating,
        backgroundColor: error
            ? Colors.red.shade700
            : Colors.green.shade700,
        content: Text(message),
      ),
    );
  }

  // ============================================================
  // PHOTO SOURCE
  // ============================================================

  Future<void>
      _choosePhotoSource() async {
    await showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) {
        return SafeArea(
          child: Column(
            mainAxisSize:
                MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(
                  Icons.camera_alt_rounded,
                ),
                title:
                    const Text('Camera'),
                onTap: () {
                  Navigator.pop(
                    sheetContext,
                  );

                  _pickImage(
                    ImageSource.camera,
                  );
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.photo_library_rounded,
                ),
                title:
                    const Text('Gallery'),
                onTap: () {
                  Navigator.pop(
                    sheetContext,
                  );

                  _pickImage(
                    ImageSource.gallery,
                  );
                },
              ),
              const SizedBox(
                height: 8,
              ),
            ],
          ),
        );
      },
    );
  }

  // ============================================================
  // PICK IMAGE
  // ============================================================

  Future<void> _pickImage(
    ImageSource source,
  ) async {
    try {
      final image =
          await _picker.pickImage(
        source: source,
        imageQuality: 85,
        maxWidth: 1600,
      );

      if (image == null ||
          !mounted) {
        return;
      }

      setState(() {
        _photo = image;
      });
    } catch (error) {
      _showMessage(
        'Unable to select photo.',
        error: true,
      );
    }
  }

  // ============================================================
  // REMOVE PHOTO
  // ============================================================

  void _removePhoto() {
    if (_submitting) return;

    setState(() {
      _photo = null;
    });
  }

  // ============================================================
  // GENERATE ID
  // ============================================================

  String _generateHazardId() {
    final now =
        DateTime.now();

    final date =
        '${now.year}'
        '${now.month.toString().padLeft(2, '0')}'
        '${now.day.toString().padLeft(2, '0')}';

    final time =
        '${now.hour.toString().padLeft(2, '0')}'
        '${now.minute.toString().padLeft(2, '0')}'
        '${now.second.toString().padLeft(2, '0')}';

    return 'HZD-$date-$time';
  }

  // ============================================================
  // SAVE HAZARD REPORT
  // ============================================================

  Future<void>
      _submitHazardReport() async {
    if (_submitting) {
      return;
    }

    if (!_formKey.currentState!
        .validate()) {
      return;
    }

    FocusScope.of(context)
        .unfocus();

    setState(() {
      _submitting = true;
    });

    try {
      final id =
          _generateHazardId();

      final submittedAt =
          DateTime.now();

      String? savedPhotoPath;

      // --------------------------------------------------------
      // SAVE PHOTO
      // --------------------------------------------------------

      if (_photo != null) {
        final appDirectory =
            await getApplicationDocumentsDirectory();

        final observationsDirectory =
            Directory(
          '${appDirectory.path}/safenexus_observations',
        );

        if (!await observationsDirectory
            .exists()) {
          await observationsDirectory
              .create(
            recursive: true,
          );
        }

        String extension =
            'jpg';

        final originalPath =
            _photo!.path;

        if (originalPath.contains('.')) {
          final detectedExtension =
              originalPath
                  .split('.')
                  .last
                  .toLowerCase();

          if ([
            'jpg',
            'jpeg',
            'png',
            'webp',
          ].contains(
            detectedExtension,
          )) {
            extension =
                detectedExtension;
          }
        }

        final destination =
            File(
          '${observationsDirectory.path}/$id.$extension',
        );

        await File(originalPath)
            .copy(
          destination.path,
        );

        savedPhotoPath =
            destination.path;
      }

      // --------------------------------------------------------
      // CREATE UNIFIED REPORT RECORD
      // --------------------------------------------------------
      //
      // This record intentionally uses the same field names
      // understood by ObservationHistoryPage.
      //
      // The "reportType" field tells History that this is a
      // manually submitted Hazard Report rather than an AI
      // Safety Observation.
      // --------------------------------------------------------

      final report =
          <String, dynamic>{
        'id': id,

        'submittedAt':
            submittedAt
                .toIso8601String(),

        'dateTime':
            submittedAt
                .toIso8601String(),

        'reportType':
            'Hazard Report',

        'observationType':
            'Hazard Report',

        'type':
            'Hazard Report',

        'category':
            _category,

        'hazardType':
            _hazardType,

        'hazard':
            _hazardType,

        'severity':
            _severity,

        'riskLevel':
            _severity,

        'risk':
            _severity,

        'location':
            _locationController
                .text
                .trim(),

        'description':
            _descriptionController
                .text
                .trim(),

        'correctiveAction':
            _actionController
                .text
                .trim(),

        'action':
            _actionController
                .text
                .trim(),

        'photoPath':
            savedPhotoPath ?? '',

        'smartAnalysis':
            false,

        'aiAnalysis': {
          'completed': false,
          'source': 'manual',
        },

        'status':
            'Open',
      };

      // --------------------------------------------------------
      // READ EXISTING REPORTS
      // --------------------------------------------------------

      final prefs =
          await SharedPreferences
              .getInstance();

      final existing =
          prefs.getStringList(
                _storageKey,
              ) ??
              <String>[];

      // --------------------------------------------------------
      // PREPEND NEW REPORT
      // --------------------------------------------------------

      final updated =
          <String>[
        jsonEncode(report),
        ...existing,
      ];

      final saved =
          await prefs.setStringList(
        _storageKey,
        updated,
      );

      if (!saved) {
        throw Exception(
          'Unable to save hazard report.',
        );
      }

      if (!mounted) return;

      setState(() {
        _submitting = false;
      });

      await _showSuccessDialog(
        id,
        submittedAt,
      );
    } catch (error) {
      if (!mounted) return;

      setState(() {
        _submitting = false;
      });

      _showMessage(
        'Unable to save hazard report. Please try again.',
        error: true,
      );
    }
  }

  // ============================================================
  // SUCCESS DIALOG
  // ============================================================

  Future<void> _showSuccessDialog(
    String id,
    DateTime submittedAt,
  ) async {
    if (!mounted) return;

    final formatted =
        '${submittedAt.day.toString().padLeft(2, '0')}/'
        '${submittedAt.month.toString().padLeft(2, '0')}/'
        '${submittedAt.year} '
        '${submittedAt.hour.toString().padLeft(2, '0')}:'
        '${submittedAt.minute.toString().padLeft(2, '0')}';

    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          icon: Icon(
            Icons.check_circle_rounded,
            color:
                Colors.green.shade700,
            size: 52,
          ),
          title: const Text(
            'Hazard Report Submitted',
          ),
          content: Column(
            mainAxisSize:
                MainAxisSize.min,
            children: [
              const Text(
                'The hazard report has been saved successfully.',
                textAlign:
                    TextAlign.center,
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                'ID: $id',
                textAlign:
                    TextAlign.center,
                style:
                    const TextStyle(
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              Text(
                formatted,
                textAlign:
                    TextAlign.center,
              ),
            ],
          ),
          actions: [
            FilledButton(
              onPressed: () {
                Navigator.pop(
                  dialogContext,
                );

                _resetForm();
              },
              child: const Text(
                'Done',
              ),
            ),
          ],
        );
      },
    );
  }

  // ============================================================
  // RESET
  // ============================================================

  void _resetForm() {
    _formKey.currentState
        ?.reset();

    _descriptionController
        .clear();

    _locationController.clear();

    _actionController.clear();

    setState(() {
      _severity =
          'Medium';

      _category =
          'General Safety';

      _hazardType =
          'General Workplace Hazard';

      _photo = null;
    });
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Hazard Report',
          style: TextStyle(
            fontWeight:
                FontWeight.w800,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding:
                const EdgeInsets.all(
              16,
            ),
            children: [
              _buildHeaderCard(),

              const SizedBox(
                height: 16,
              ),

              _buildSeverityCard(),

              const SizedBox(
                height: 16,
              ),

              _buildClassificationCard(),

              const SizedBox(
                height: 16,
              ),

              _buildLocationCard(),

              const SizedBox(
                height: 16,
              ),

              _buildDescriptionCard(),

              const SizedBox(
                height: 16,
              ),

              _buildActionCard(),

              const SizedBox(
                height: 16,
              ),

              _buildPhotoCard(),

              const SizedBox(
                height: 24,
              ),

              _buildSubmitButton(),

              const SizedBox(
                height: 32,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // HEADER
  // ============================================================

  Widget _buildHeaderCard() {
    final scheme =
        Theme.of(context)
            .colorScheme;

    return Card(
      elevation: 0,
      child: Padding(
        padding:
            const EdgeInsets.all(18),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration:
                  BoxDecoration(
                color:
                    scheme.primaryContainer,
                borderRadius:
                    BorderRadius
                        .circular(16),
              ),
              child: Icon(
                Icons
                    .report_problem_rounded,
                color:
                    scheme.onPrimaryContainer,
                size: 28,
              ),
            ),
            const SizedBox(
              width: 14,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,
                children: [
                  const Text(
                    'Report a Hazard',
                    style:
                        TextStyle(
                      fontSize: 20,
                      fontWeight:
                          FontWeight.w800,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    'Record a workplace hazard for follow-up and corrective action.',
                    style:
                        Theme.of(
                      context,
                    )
                            .textTheme
                            .bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SEVERITY
  // ============================================================

  Widget _buildSeverityCard() {
    return Card(
      elevation: 0,
      child: Padding(
        padding:
            const EdgeInsets.all(16),
        child: DropdownButtonFormField<
            String>(
          initialValue:
              _severity,
          decoration:
              const InputDecoration(
            labelText:
                'Severity / Risk Level',
            prefixIcon: Icon(
              Icons
                  .warning_amber_rounded,
            ),
            border:
                OutlineInputBorder(),
          ),
          items:
              _severityOptions
                  .map(
            (value) =>
                DropdownMenuItem<
                    String>(
              value: value,
              child: Text(
                value,
              ),
            ),
          )
                  .toList(),
          onChanged:
              _submitting
                  ? null
                  : (value) {
                      if (value ==
                          null) {
                        return;
                      }

                      setState(() {
                        _severity =
                            value;
                      });
                    },
        ),
      ),
    );
  }

  // ============================================================
  // CLASSIFICATION
  // ============================================================

  Widget
      _buildClassificationCard() {
    return Card(
      elevation: 0,
      child: Padding(
        padding:
            const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment
                  .start,
          children: [
            Text(
              'Hazard Classification',
              style:
                  Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(
                        fontWeight:
                            FontWeight.bold,
                      ),
            ),

            const SizedBox(
              height: 14,
            ),

            DropdownButtonFormField<
                String>(
              initialValue:
                  _category,
              decoration:
                  const InputDecoration(
                labelText:
                    'Category',
                border:
                    OutlineInputBorder(),
              ),
              items:
                  _categoryOptions
                      .map(
                (value) =>
                    DropdownMenuItem<
                        String>(
                  value: value,
                  child: Text(
                    value,
                  ),
                ),
              )
                      .toList(),
              onChanged:
                  _submitting
                      ? null
                      : (value) {
                          if (value ==
                              null) {
                            return;
                          }

                          setState(() {
                            _category =
                                value;
                          });
                        },
            ),

            const SizedBox(
              height: 14,
            ),

            DropdownButtonFormField<
                String>(
              initialValue:
                  _hazardType,
              decoration:
                  const InputDecoration(
                labelText:
                    'Hazard Type',
                border:
                    OutlineInputBorder(),
              ),
              items:
                  _hazardOptions
                      .map(
                (value) =>
                    DropdownMenuItem<
                        String>(
                  value: value,
                  child: Text(
                    value,
                  ),
                ),
              )
                      .toList(),
              onChanged:
                  _submitting
                      ? null
                      : (value) {
                          if (value ==
                              null) {
                            return;
                          }

                          setState(() {
                            _hazardType =
                                value;
                          });
                        },
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // LOCATION
  // ============================================================

  Widget _buildLocationCard() {
    return Card(
      elevation: 0,
      child: Padding(
        padding:
            const EdgeInsets.all(16),
        child: TextFormField(
          controller:
              _locationController,
          textInputAction:
              TextInputAction.next,
          decoration:
              const InputDecoration(
            labelText:
                'Location',
            hintText:
                'Example: Workshop / Warehouse / Site Area',
            prefixIcon: Icon(
              Icons
                  .location_on_outlined,
            ),
            border:
                OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null ||
                value.trim().isEmpty) {
              return 'Please enter the location.';
            }

            return null;
          },
        ),
      ),
    );
  }

  // ============================================================
  // DESCRIPTION
  // ============================================================

  Widget
      _buildDescriptionCard() {
    return Card(
      elevation: 0,
      child: Padding(
        padding:
            const EdgeInsets.all(16),
        child: TextFormField(
          controller:
              _descriptionController,
          maxLines: 5,
          decoration:
              const InputDecoration(
            labelText:
                'Hazard Description',
            hintText:
                'Describe the hazard clearly...',
            alignLabelWithHint:
                true,
            border:
                OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null ||
                value.trim().isEmpty) {
              return 'Please enter the hazard description.';
            }

            if (value.trim().length <
                5) {
              return 'Please provide more details.';
            }

            return null;
          },
        ),
      ),
    );
  }

  // ============================================================
  // ACTION
  // ============================================================

  Widget _buildActionCard() {
    return Card(
      elevation: 0,
      child: Padding(
        padding:
            const EdgeInsets.all(16),
        child: TextFormField(
          controller:
              _actionController,
          maxLines: 5,
          decoration:
              const InputDecoration(
            labelText:
                'Corrective Action',
            hintText:
                'Describe action taken or recommended...',
            alignLabelWithHint:
                true,
            border:
                OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null ||
                value.trim().isEmpty) {
              return 'Please enter corrective action.';
            }

            return null;
          },
        ),
      ),
    );
  }

  // ============================================================
  // PHOTO
  // ============================================================

  Widget _buildPhotoCard() {
    final scheme =
        Theme.of(context)
            .colorScheme;

    return Card(
      elevation: 0,
      child: Padding(
        padding:
            const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment
                  .start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons
                      .photo_camera_back_rounded,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  'Photo Evidence',
                  style:
                      Theme.of(
                    context,
                  )
                          .textTheme
                          .titleMedium
                          ?.copyWith(
                            fontWeight:
                                FontWeight.bold,
                          ),
                ),
              ],
            ),

            const SizedBox(
              height: 14,
            ),

            if (_photo == null)
              Container(
                width:
                    double.infinity,
                padding:
                    const EdgeInsets.all(
                  20,
                ),
                decoration:
                    BoxDecoration(
                  borderRadius:
                      BorderRadius
                          .circular(16),
                  border:
                      Border.all(
                    color:
                        scheme.outlineVariant,
                  ),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons
                          .image_outlined,
                      size: 46,
                      color:
                          scheme.primary,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Add photo evidence',
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    OutlinedButton.icon(
                      onPressed:
                          _submitting
                              ? null
                              : _choosePhotoSource,
                      icon:
                          const Icon(
                        Icons
                            .add_a_photo_rounded,
                      ),
                      label:
                          const Text(
                        'Add Photo',
                      ),
                    ),
                  ],
                ),
              )
            else
              ClipRRect(
                borderRadius:
                    BorderRadius
                        .circular(16),
                child: Stack(
                  children: [
                    Image.file(
                      File(
                        _photo!.path,
                      ),
                      width:
                          double.infinity,
                      height: 230,
                      fit:
                          BoxFit.cover,
                    ),

                    Positioned(
                      top: 10,
                      right: 10,
                      child: Material(
                        color:
                            Colors.black54,
                        borderRadius:
                            BorderRadius
                                .circular(
                          30,
                        ),
                        child:
                            IconButton(
                          onPressed:
                              _submitting
                                  ? null
                                  : _removePhoto,
                          color:
                              Colors.white,
                          icon:
                              const Icon(
                            Icons
                                .delete_outline,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            if (_photo != null) ...[
              const SizedBox(
                height: 10,
              ),
              Text(
                'Photo attached to this hazard report.',
                style:
                    Theme.of(context)
                        .textTheme
                        .bodySmall,
              ),
            ],
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SUBMIT
  // ============================================================

  Widget _buildSubmitButton() {
    return SizedBox(
      width:
          double.infinity,
      height: 54,
      child: FilledButton.icon(
        onPressed:
            _submitting
                ? null
                : _submitHazardReport,
        icon: _submitting
            ? const SizedBox(
                width: 20,
                height: 20,
                child:
                    CircularProgressIndicator(
                  strokeWidth: 2,
                  color:
                      Colors.white,
                ),
              )
            : const Icon(
                Icons.send_rounded,
              ),
        label: Text(
          _submitting
              ? 'Saving...'
              : 'Submit Hazard Report',
          style:
              const TextStyle(
            fontWeight:
                FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
