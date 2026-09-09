import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'services/ai_hse_service.dart';

class SafetyObservationPage extends StatefulWidget {
  const SafetyObservationPage({super.key});

  @override
  State<SafetyObservationPage> createState() =>
      _SafetyObservationPageState();
}

class _SafetyObservationPageState
    extends State<SafetyObservationPage> {
  // ============================================================
  // STORAGE
  // ============================================================

  static const String _storageKey =
      'safenexus_observations';

  // ============================================================
  // FORM
  // ============================================================

  final _formKey = GlobalKey<FormState>();

  final _descriptionController =
      TextEditingController();

  final _actionController =
      TextEditingController();

  final _locationController =
      TextEditingController();

  // ============================================================
  // SERVICES
  // ============================================================

  final ImagePicker _picker = ImagePicker();

  final AiHseService _aiService = AiHseService();

  // ============================================================
  // OPTIONS
  // ============================================================

  static const List<String> _observationTypes = [
    'Unsafe Condition',
    'Unsafe Act',
    'Positive Observation',
    'Near Miss',
  ];

  static const List<String> _categories = [
    'General Safety',
    'Fire Safety',
    'Electrical Safety',
    'Work at Height',
    'Confined Space',
    'Lifting Operations',
    'PPE',
    'Housekeeping',
  ];

  static const List<String> _hazardTypes = [
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

  static const List<String> _riskLevels = [
    'Low',
    'Medium',
    'High',
    'Critical',
  ];

  static const List<String> _consequences = [
    'Injury',
    'Serious Injury',
    'Fatality',
    'Property Damage',
    'Environmental Impact',
    'No Significant Consequence',
  ];

  // ============================================================
  // FORM STATE
  // ============================================================

  String _observationType = 'Unsafe Condition';

  String _category = 'General Safety';

  String _hazardType =
      'General Workplace Hazard';

  String _riskLevel = 'Medium';

  String _potentialConsequence = 'Injury';

  XFile? _photo;

  // ============================================================
  // AI STATE
  // ============================================================

  bool _submitting = false;

  bool _analyzing = false;

  bool _smartAnalysisDone = false;

  AiHseResult? _aiResult;

  String? _aiError;

  // ============================================================
  // DISPOSE
  // ============================================================

  @override
  void dispose() {
    _descriptionController.dispose();
    _actionController.dispose();
    _locationController.dispose();

    super.dispose();
  }

  // ============================================================
  // OBSERVATION ID
  // ============================================================

  String _generateObservationId() {
    final now = DateTime.now();

    final date = '${now.year}'
        '${now.month.toString().padLeft(2, '0')}'
        '${now.day.toString().padLeft(2, '0')}';

    final time = '${now.hour.toString().padLeft(2, '0')}'
        '${now.minute.toString().padLeft(2, '0')}'
        '${now.second.toString().padLeft(2, '0')}'
        '${now.millisecond.toString().padLeft(3, '0')}';

    return 'OBS-$date-$time';
  }

  // ============================================================
  // MESSAGE
  // ============================================================

  void _showMessage(
    String message, {
    bool error = false,
  }) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: error
            ? Colors.red.shade700
            : Colors.green.shade700,
        content: Text(message),
      ),
    );
  }

  // ============================================================
  // CAMERA
  // ============================================================

  Future<void> _pickImage() async {
    try {
      final image = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
        maxWidth: 1600,
      );

      if (image == null || !mounted) return;

      setState(() {
        _photo = image;

        _smartAnalysisDone = false;

        _aiResult = null;

        _aiError = null;
      });
    } catch (_) {
      _showMessage(
        'Unable to capture photo.',
        error: true,
      );
    }
  }

  // ============================================================
  // GALLERY
  // ============================================================

  Future<void> _pickFromGallery() async {
    try {
      final image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
        maxWidth: 1600,
      );

      if (image == null || !mounted) return;

      setState(() {
        _photo = image;

        _smartAnalysisDone = false;

        _aiResult = null;

        _aiError = null;
      });
    } catch (_) {
      _showMessage(
        'Unable to select photo from gallery.',
        error: true,
      );
    }
  }

  // ============================================================
  // PHOTO SOURCE
  // ============================================================

  Future<void> _choosePhotoSource() async {
    await showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(
                  Icons.camera_alt_rounded,
                ),
                title: const Text('Camera'),
                onTap: () {
                  Navigator.pop(sheetContext);

                  _pickImage();
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.photo_library_rounded,
                ),
                title: const Text('Gallery'),
                onTap: () {
                  Navigator.pop(sheetContext);

                  _pickFromGallery();
                },
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  // ============================================================
  // REMOVE PHOTO
  // ============================================================

  void _removePhoto() {
    if (_analyzing) return;

    setState(() {
      _photo = null;

      _smartAnalysisDone = false;

      _aiResult = null;

      _aiError = null;
    });
  }

  // ============================================================
  // AI SMART ANALYSIS
  // ============================================================

  Future<void> _runSmartAnalysis() async {
    if (_photo == null) {
      _showMessage(
        'Please add a photo first.',
        error: true,
      );

      return;
    }

    if (_analyzing || _submitting) {
      return;
    }

    setState(() {
      _analyzing = true;

      _smartAnalysisDone = false;

      _aiResult = null;

      _aiError = null;
    });

    try {
      final result = await _aiService.analyzePhoto(
        imageFile: File(_photo!.path),
        description:
            _descriptionController.text.trim(),
        location:
            _locationController.text.trim(),
        language: 'en',
      );

      if (!mounted) return;

      _applyAiResult(result);

      setState(() {
        _aiResult = result;

        _smartAnalysisDone = true;

        _analyzing = false;

        _aiError = null;
      });

      _showMessage(
        'AI Smart Analysis completed.',
      );
    } on AiHseException catch (error) {
      if (!mounted) return;

      setState(() {
        _analyzing = false;

        _smartAnalysisDone = false;

        _aiError = error.message;
      });

      _showMessage(
        'AI Analysis failed.',
        error: true,
      );
    } catch (error) {
      if (!mounted) return;

      setState(() {
        _analyzing = false;

        _smartAnalysisDone = false;

        _aiError = error.toString();
      });

      _showMessage(
        'An unexpected AI analysis error occurred.',
        error: true,
      );
    }
  }

  // ============================================================
  // APPLY AI RESULT
  // ============================================================

  void _applyAiResult(AiHseResult result) {
    final aiObservationType =
        _matchObservationType(
      result.observationType,
    );

    if (aiObservationType != null) {
      _observationType = aiObservationType;
    }

    final aiCategory =
        _matchCategory(result.category);

    if (aiCategory != null) {
      _category = aiCategory;
    }

    final aiHazard =
        _matchHazardType(result.hazard);

    if (aiHazard != null) {
      _hazardType = aiHazard;
    }

    final aiRisk =
        _matchRiskLevel(result.riskLevel);

    if (aiRisk != null) {
      _riskLevel = aiRisk;
    }

    final aiConsequence =
        _matchConsequence(
      result.potentialConsequence,
    );

    if (aiConsequence != null) {
      _potentialConsequence = aiConsequence;
    }

    if (_actionController.text.trim().isEmpty) {
      _actionController.text =
          result.correctiveAction;
    }

    if (_descriptionController.text.trim().isEmpty) {
      _descriptionController.text =
          result.explanation;
    }
  }

  // ============================================================
  // MATCH OBSERVATION TYPE
  // ============================================================

  String? _matchObservationType(
    String value,
  ) {
    final normalized =
        value.trim().toLowerCase();

    for (final item in _observationTypes) {
      if (item.toLowerCase() == normalized) {
        return item;
      }
    }

    if (normalized.contains('unsafe condition')) {
      return 'Unsafe Condition';
    }

    if (normalized.contains('unsafe act')) {
      return 'Unsafe Act';
    }

    if (normalized.contains('positive')) {
      return 'Positive Observation';
    }

    if (normalized.contains('near miss')) {
      return 'Near Miss';
    }

    return null;
  }

  // ============================================================
  // MATCH CATEGORY
  // ============================================================

  String? _matchCategory(String value) {
    final normalized =
        value.trim().toLowerCase();

    for (final item in _categories) {
      if (item.toLowerCase() == normalized) {
        return item;
      }
    }

    if (normalized.contains('electrical')) {
      return 'Electrical Safety';
    }

    if (normalized.contains('fire')) {
      return 'Fire Safety';
    }

    if (normalized.contains('height')) {
      return 'Work at Height';
    }

    if (normalized.contains('confined')) {
      return 'Confined Space';
    }

    if (normalized.contains('lifting') ||
        normalized.contains('rigging')) {
      return 'Lifting Operations';
    }

    if (normalized.contains('ppe') ||
        normalized.contains(
          'personal protective',
        )) {
      return 'PPE';
    }

    if (normalized.contains('housekeeping')) {
      return 'Housekeeping';
    }

    return null;
  }

  // ============================================================
  // MATCH HAZARD
  // ============================================================

  String? _matchHazardType(String value) {
    final normalized =
        value.trim().toLowerCase();

    for (final item in _hazardTypes) {
      if (item.toLowerCase() == normalized) {
        return item;
      }
    }

    if (normalized.contains('slip') ||
        normalized.contains('trip') ||
        normalized.contains('fall')) {
      return 'Slip Trip Fall';
    }

    if (normalized.contains('falling object')) {
      return 'Falling Objects';
    }

    if (normalized.contains('electrical')) {
      return 'Electrical Hazard';
    }

    if (normalized.contains('fire')) {
      return 'Fire Hazard';
    }

    if (normalized.contains('chemical')) {
      return 'Chemical Hazard';
    }

    if (normalized.contains('mechanical')) {
      return 'Mechanical Hazard';
    }

    if (normalized.contains('ergonomic')) {
      return 'Ergonomic Hazard';
    }

    if (normalized.contains('environment')) {
      return 'Environmental Hazard';
    }

    return null;
  }

  // ============================================================
  // MATCH RISK
  // ============================================================

  String? _matchRiskLevel(String value) {
    final normalized =
        value.trim().toLowerCase();

    for (final item in _riskLevels) {
      if (item.toLowerCase() == normalized) {
        return item;
      }
    }

    if (normalized.contains('critical')) {
      return 'Critical';
    }

    if (normalized.contains('high')) {
      return 'High';
    }

    if (normalized.contains('medium')) {
      return 'Medium';
    }

    if (normalized.contains('low')) {
      return 'Low';
    }

    return null;
  }

  // ============================================================
  // MATCH CONSEQUENCE
  // ============================================================

  String? _matchConsequence(String value) {
    final normalized =
        value.trim().toLowerCase();

    for (final item in _consequences) {
      if (item.toLowerCase() == normalized) {
        return item;
      }
    }

    if (normalized.contains('fatal')) {
      return 'Fatality';
    }

    if (normalized.contains('serious')) {
      return 'Serious Injury';
    }

    if (normalized.contains('property')) {
      return 'Property Damage';
    }

    if (normalized.contains('environment')) {
      return 'Environmental Impact';
    }

    if (normalized.contains('injury')) {
      return 'Injury';
    }

    if (normalized.contains('no significant') ||
        normalized.contains('none')) {
      return 'No Significant Consequence';
    }

    return null;
  }

  // ============================================================
  // SUBMIT OBSERVATION
  // ============================================================

  Future<void> _submitObservation() async {
    if (_submitting || _analyzing) {
      return;
    }

    if (!_formKey.currentState!.validate()) {
      return;
    }

    FocusScope.of(context).unfocus();

    setState(() {
      _submitting = true;
    });

    try {
      final id = _generateObservationId();

      final submittedAt = DateTime.now();

      String? savedPhotoPath;

      // ========================================================
      // SAVE PHOTO
      // ========================================================

      if (_photo != null) {
        final documentsDirectory =
            await getApplicationDocumentsDirectory();

        final observationsDirectory =
            Directory(
          '${documentsDirectory.path}/safenexus_observations',
        );

        if (!await observationsDirectory.exists()) {
          await observationsDirectory.create(
            recursive: true,
          );
        }

        String extension = 'jpg';

        final originalPath = _photo!.path;

        if (originalPath.contains('.')) {
          extension = originalPath
              .split('.')
              .last
              .toLowerCase();

          if (extension.length > 5 ||
              ![
                'jpg',
                'jpeg',
                'png',
                'webp',
              ].contains(extension)) {
            extension = 'jpg';
          }
        }

        final photoFile = File(
          '${observationsDirectory.path}/$id.$extension',
        );

        await File(originalPath).copy(
          photoFile.path,
        );

        savedPhotoPath = photoFile.path;
      }

      // ========================================================
      // AI DATA
      // ========================================================

      final Map<String, dynamic> aiData = {
        'completed': _smartAnalysisDone,
        'observationType':
            _aiResult?.observationType,
        'category':
            _aiResult?.category,
        'hazard':
            _aiResult?.hazard,
        'riskLevel':
            _aiResult?.riskLevel,
        'potentialConsequence':
            _aiResult?.potentialConsequence,
        'correctiveAction':
            _aiResult?.correctiveAction,
        'confidence':
            _aiResult?.confidence,
        'explanation':
            _aiResult?.explanation,
      };

      // ========================================================
      // UNIFIED OBSERVATION RECORD
      //
      // Compatible with observation_history.dart
      // ========================================================

      final observation =
          <String, dynamic>{
        // Core identity
        'id': id,

        // Unified report type
        'reportType': 'Safety Observation',

        // Dates
        'submittedAt':
            submittedAt.toIso8601String(),

        'dateTime':
            submittedAt.toIso8601String(),

        'createdAt':
            submittedAt.toIso8601String(),

        // Observation classification
        'observationType':
            _observationType,

        // Legacy-compatible field
        'type':
            _observationType,

        // Category
        'category':
            _category,

        // Hazard
        'hazardType':
            _hazardType,

        // Unified history field
        'hazard':
            _hazardType,

        // Risk
        'riskLevel':
            _riskLevel,

        // Legacy-compatible field
        'risk':
            _riskLevel,

        // Consequence
        'potentialConsequence':
            _potentialConsequence,

        // Legacy-compatible field
        'consequence':
            _potentialConsequence,

        // Location
        'location':
            _locationController.text.trim(),

        // Description
        'description':
            _descriptionController.text.trim(),

        // Corrective action
        'correctiveAction':
            _actionController.text.trim(),

        // Legacy-compatible field
        'action':
            _actionController.text.trim(),

        // Photo
        'photoPath':
            savedPhotoPath ?? '',

        // Report status
        'status':
            'Open',

        // AI
        'smartAnalysis':
            _smartAnalysisDone,

        'aiAnalysis':
            aiData,
      };

      // ========================================================
      // SHARED PREFERENCES
      // ========================================================

      final prefs =
          await SharedPreferences.getInstance();

      final stored =
          prefs.getStringList(
                _storageKey,
              ) ??
              <String>[];

      // Newest report first.
      final updated = <String>[
        jsonEncode(observation),
        ...stored,
      ];

      final saved =
          await prefs.setStringList(
        _storageKey,
        updated,
      );

      if (!saved) {
        throw Exception(
          'Unable to save observation.',
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
    } catch (_) {
      if (!mounted) return;

      setState(() {
        _submitting = false;
      });

      _showMessage(
        'Unable to save the observation. Please try again.',
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
            color: Colors.green.shade700,
            size: 52,
          ),
          title: const Text(
            'Observation Submitted',
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'The observation has been saved successfully.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'ID: $id',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                formatted,
                textAlign: TextAlign.center,
              ),
              if (_smartAnalysisDone) ...[
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.auto_awesome_rounded,
                      size: 18,
                      color: Colors.green.shade700,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'AI Analysis included',
                      style: TextStyle(
                        color:
                            Colors.green.shade700,
                        fontWeight:
                            FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
          actions: [
            FilledButton(
              onPressed: () {
                Navigator.pop(dialogContext);

                _resetForm();
              },
              child: const Text('Done'),
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
    _formKey.currentState?.reset();

    _descriptionController.clear();

    _actionController.clear();

    _locationController.clear();

    setState(() {
      _observationType =
          'Unsafe Condition';

      _category =
          'General Safety';

      _hazardType =
          'General Workplace Hazard';

      _riskLevel =
          'Medium';

      _potentialConsequence =
          'Injury';

      _photo = null;

      _smartAnalysisDone = false;

      _analyzing = false;

      _aiResult = null;

      _aiError = null;
    });
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 48,
        title: const Text(
          'Safety Observation',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 17,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding:
                const EdgeInsets.fromLTRB(
              16,
              8,
              16,
              32,
            ),
            children: [
              _buildHeaderCard(),

              const SizedBox(height: 12),

              _buildObservationTypeCard(),

              const SizedBox(height: 12),

              _buildClassificationCard(),

              const SizedBox(height: 12),

              _buildRiskCard(),

              const SizedBox(height: 12),

              _buildLocationCard(),

              const SizedBox(height: 12),

              _buildDescriptionCard(),

              const SizedBox(height: 12),

              _buildActionCard(),

              const SizedBox(height: 12),

              _buildPhotoCard(),

              if (_aiResult != null) ...[
                const SizedBox(height: 12),
                _buildAiResultCard(),
              ],

              const SizedBox(height: 20),

              _buildSubmitButton(),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // HEADER CARD
  // ============================================================

  Widget _buildHeaderCard() {
    final scheme =
        Theme.of(context).colorScheme;

    return Card(
      elevation: 0,
      child: Padding(
        padding:
            const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 12,
        ),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color:
                    scheme.primaryContainer,
                borderRadius:
                    BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.health_and_safety_rounded,
                color:
                    scheme.onPrimaryContainer,
                size: 23,
              ),
            ),
            const SizedBox(width: 11),
            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Safety Observation',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight:
                          FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Report an unsafe condition or workplace hazard.',
                    maxLines: 1,
                    overflow:
                        TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall,
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
  // OBSERVATION TYPE
  // ============================================================

  Widget _buildObservationTypeCard() {
    return Card(
      elevation: 0,
      child: Padding(
        padding:
            const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Text(
              'Observation Type',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(
                    fontWeight:
                        FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              initialValue:
                  _observationType,
              decoration:
                  const InputDecoration(
                labelText: 'Type',
                border:
                    OutlineInputBorder(),
              ),
              items:
                  _observationTypes.map(
                (value) =>
                    DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                ),
              ).toList(),
              onChanged: _analyzing
                  ? null
                  : (value) {
                      if (value == null) {
                        return;
                      }

                      setState(() {
                        _observationType =
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
  // CLASSIFICATION
  // ============================================================

  Widget _buildClassificationCard() {
    return Card(
      elevation: 0,
      child: Padding(
        padding:
            const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Text(
              'Hazard Classification',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(
                    fontWeight:
                        FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 14),
            DropdownButtonFormField<String>(
              initialValue: _category,
              decoration:
                  const InputDecoration(
                labelText: 'Category',
                border:
                    OutlineInputBorder(),
              ),
              items: _categories.map(
                (value) =>
                    DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                ),
              ).toList(),
              onChanged: _analyzing
                  ? null
                  : (value) {
                      if (value == null) {
                        return;
                      }

                      setState(() {
                        _category = value;
                      });
                    },
            ),
            const SizedBox(height: 14),
            DropdownButtonFormField<String>(
              initialValue: _hazardType,
              decoration:
                  const InputDecoration(
                labelText: 'Hazard Type',
                border:
                    OutlineInputBorder(),
              ),
              items: _hazardTypes.map(
                (value) =>
                    DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                ),
              ).toList(),
              onChanged: _analyzing
                  ? null
                  : (value) {
                      if (value == null) {
                        return;
                      }

                      setState(() {
                        _hazardType = value;
                      });
                    },
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // RISK
  // ============================================================

  Widget _buildRiskCard() {
    final riskColor =
        _getRiskColor(_riskLevel);

    return Card(
      elevation: 0,
      child: Padding(
        padding:
            const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.warning_amber_rounded,
                ),
                const SizedBox(width: 8),
                Text(
                  'Risk Assessment',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(
                        fontWeight:
                            FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            DropdownButtonFormField<String>(
              initialValue: _riskLevel,
              decoration:
                  const InputDecoration(
                labelText: 'Risk Level',
                border:
                    OutlineInputBorder(),
              ),
              items: _riskLevels.map(
                (value) =>
                    DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                ),
              ).toList(),
              onChanged: _analyzing
                  ? null
                  : (value) {
                      if (value == null) {
                        return;
                      }

                      setState(() {
                        _riskLevel = value;
                      });
                    },
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: riskColor.withValues(
                  alpha: 0.10,
                ),
                borderRadius:
                    BorderRadius.circular(14),
                border: Border.all(
                  color: riskColor.withValues(
                    alpha: 0.25,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.shield_rounded,
                    color: riskColor,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Selected Risk: $_riskLevel',
                      style: TextStyle(
                        color: riskColor,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            DropdownButtonFormField<String>(
              initialValue:
                  _potentialConsequence,
              decoration:
                  const InputDecoration(
                labelText:
                    'Potential Consequence',
                border:
                    OutlineInputBorder(),
              ),
              items: _consequences.map(
                (value) =>
                    DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                ),
              ).toList(),
              onChanged: _analyzing
                  ? null
                  : (value) {
                      if (value == null) {
                        return;
                      }

                      setState(() {
                        _potentialConsequence =
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
            labelText: 'Location',
            hintText:
                'Example: Workshop / Site Area / Warehouse',
            prefixIcon: Icon(
              Icons.location_on_outlined,
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

  Widget _buildDescriptionCard() {
    return Card(
      elevation: 0,
      child: Padding(
        padding:
            const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Text(
              'Observation Description',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(
                    fontWeight:
                        FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller:
                  _descriptionController,
              maxLines: 5,
              textInputAction:
                  TextInputAction.newline,
              decoration:
                  const InputDecoration(
                hintText:
                    'Describe what you observed...',
                border:
                    OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
              validator: (value) {
                if (value == null ||
                    value.trim().isEmpty) {
                  return 'Please enter an observation description.';
                }

                if (value.trim().length < 5) {
                  return 'Please provide more details.';
                }

                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // CORRECTIVE ACTION
  // ============================================================

  Widget _buildActionCard() {
    return Card(
      elevation: 0,
      child: Padding(
        padding:
            const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Text(
              'Corrective Action',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(
                    fontWeight:
                        FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller:
                  _actionController,
              maxLines: 5,
              textInputAction:
                  TextInputAction.newline,
              decoration:
                  const InputDecoration(
                hintText:
                    'Describe the corrective action taken or recommended...',
                border:
                    OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
              validator: (value) {
                if (value == null ||
                    value.trim().isEmpty) {
                  return 'Please enter corrective action.';
                }

                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // PHOTO CARD
  // ============================================================

  Widget _buildPhotoCard() {
    final scheme =
        Theme.of(context).colorScheme;

    return Card(
      elevation: 0,
      child: Padding(
        padding:
            const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.photo_camera_back_rounded,
                ),
                const SizedBox(width: 8),
                Text(
                  'Photo Evidence',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(
                        fontWeight:
                            FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            if (_photo == null)
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.all(20),
                decoration:
                    BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(16),
                  border: Border.all(
                    color:
                        scheme.outlineVariant,
                  ),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.image_outlined,
                      size: 46,
                      color: scheme.primary,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Add photo evidence',
                    ),
                    const SizedBox(height: 14),
                    OutlinedButton.icon(
                      onPressed:
                          _choosePhotoSource,
                      icon: const Icon(
                        Icons
                            .add_a_photo_rounded,
                      ),
                      label: const Text(
                        'Add Photo',
                      ),
                    ),
                  ],
                ),
              )
            else
              ClipRRect(
                borderRadius:
                    BorderRadius.circular(16),
                child: Stack(
                  children: [
                    Image.file(
                      File(_photo!.path),
                      width:
                          double.infinity,
                      height: 230,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: Material(
                        color:
                            Colors.black54,
                        borderRadius:
                            BorderRadius.circular(
                          30,
                        ),
                        child: IconButton(
                          onPressed:
                              _removePhoto,
                          color:
                              Colors.white,
                          icon: const Icon(
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
              const SizedBox(height: 14),
              SizedBox(
                width: double.infinity,
                child:
                    OutlinedButton.icon(
                  onPressed: _analyzing
                      ? null
                      : _runSmartAnalysis,
                  icon: _analyzing
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child:
                              CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        )
                      : Icon(
                          _smartAnalysisDone
                              ? Icons
                                  .check_circle_rounded
                              : Icons
                                  .auto_awesome_rounded,
                        ),
                  label: Text(
                    _analyzing
                        ? 'AI Analyzing...'
                        : _smartAnalysisDone
                            ? 'AI Analysis Completed'
                            : 'Smart Analysis',
                  ),
                ),
              ),
              if (_aiError != null) ...[
                const SizedBox(height: 10),
                _buildAiErrorCard(),
              ],
            ],
          ],
        ),
      ),
    );
  }

  // ============================================================
  // AI ERROR
  // ============================================================

  Widget _buildAiErrorCard() {
    return Container(
      width: double.infinity,
      padding:
          const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius:
            BorderRadius.circular(12),
        border: Border.all(
          color: Colors.red.shade200,
        ),
      ),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.error_outline_rounded,
            color: Colors.red.shade700,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              _aiError!,
              style: TextStyle(
                color: Colors.red.shade800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // AI RESULT
  // ============================================================

  Widget _buildAiResultCard() {
    final result = _aiResult;

    if (result == null) {
      return const SizedBox.shrink();
    }

    final confidence =
        (result.confidence * 100).round();

    final riskColor =
        _getRiskColor(result.riskLevel);

    return Card(
      elevation: 0,
      child: Padding(
        padding:
            const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.auto_awesome_rounded,
                  color:
                      Colors.green.shade700,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'AI Safety Analysis',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(
                          fontWeight:
                              FontWeight.bold,
                        ),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration:
                      BoxDecoration(
                    color:
                        riskColor.withValues(
                      alpha: 0.10,
                    ),
                    borderRadius:
                        BorderRadius.circular(
                      20,
                    ),
                  ),
                  child: Text(
                    result.riskLevel,
                    style: TextStyle(
                      color: riskColor,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildAiInfoRow(
              'Observation',
              result.observationType,
            ),
            _buildAiInfoRow(
              'Category',
              result.category,
            ),
            _buildAiInfoRow(
              'Hazard',
              result.hazard,
            ),
            _buildAiInfoRow(
              'Consequence',
              result.potentialConsequence,
            ),
            const SizedBox(height: 10),
            Text(
              'AI Explanation',
              style: Theme.of(context)
                  .textTheme
                  .labelLarge
                  ?.copyWith(
                    fontWeight:
                        FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 6),
            Text(
              result.explanation,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium,
            ),
            const SizedBox(height: 14),
            Text(
              'Recommended Corrective Action',
              style: Theme.of(context)
                  .textTheme
                  .labelLarge
                  ?.copyWith(
                    fontWeight:
                        FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 6),
            Text(
              result.correctiveAction,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium,
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                const Icon(
                  Icons.verified_outlined,
                  size: 18,
                ),
                const SizedBox(width: 6),
                Text(
                  'AI Confidence: $confidence%',
                  style: const TextStyle(
                    fontWeight:
                        FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.all(10),
              decoration:
                  BoxDecoration(
                color: Theme.of(context)
                    .colorScheme
                    .surfaceContainerHighest,
                borderRadius:
                    BorderRadius.circular(10),
              ),
              child: const Text(
                'Note: AI output should be reviewed by a competent HSE professional before final action.',
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // AI INFO ROW
  // ============================================================

  Widget _buildAiInfoRow(
    String label,
    String value,
  ) {
    return Padding(
      padding:
          const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 105,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight:
                    FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // RISK COLOR
  // ============================================================

  Color _getRiskColor(String risk) {
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

  // ============================================================
  // SUBMIT BUTTON
  // ============================================================

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: FilledButton.icon(
        onPressed:
            _submitting || _analyzing
                ? null
                : _submitObservation,
        icon: _submitting
            ? const SizedBox(
                width: 20,
                height: 20,
                child:
                    CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : const Icon(
                Icons.send_rounded,
              ),
        label: Text(
          _submitting
              ? 'Saving...'
              : _analyzing
                  ? 'AI Analyzing...'
                  : 'Submit Observation',
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
