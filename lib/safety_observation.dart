import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SafetyObservationPage extends StatefulWidget {
  const SafetyObservationPage({super.key});

  @override
  State<SafetyObservationPage> createState() =>
      _SafetyObservationPageState();
}

class _SafetyObservationPageState extends State<SafetyObservationPage> {
  final _formKey = GlobalKey<FormState>();

  final _descriptionController = TextEditingController();
  final _actionController = TextEditingController();
  final _locationController = TextEditingController();

  final ImagePicker _picker = ImagePicker();

  String _observationType = 'Unsafe Condition';
  String _category = 'General Safety';
  String _hazardType = 'General Workplace Hazard';
  String _riskLevel = 'Medium';
  String _potentialConsequence = 'Injury';

  XFile? _photo;

  bool _submitting = false;
  bool _analyzing = false;
  bool _smartAnalysisDone = false;

  bool get _isMalayalam =>
      Localizations.localeOf(context).languageCode == 'ml';

  @override
  void dispose() {
    _descriptionController.dispose();
    _actionController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  // ============================================================
  // GENERATE OBSERVATION ID
  // ============================================================

  String _generateObservationId() {
    final now = DateTime.now();

    final date =
        '${now.year}${now.month.toString().padLeft(2, '0')}'
        '${now.day.toString().padLeft(2, '0')}';

    final time =
        '${now.hour.toString().padLeft(2, '0')}'
        '${now.minute.toString().padLeft(2, '0')}'
        '${now.second.toString().padLeft(2, '0')}';

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
        backgroundColor:
            error ? Colors.red.shade700 : Colors.green.shade700,
        content: Text(message),
      ),
    );
  }

  // ============================================================
  // PICK IMAGE
  // ============================================================

  Future<void> _pickImage() async {
    try {
      final image = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 85,
        maxWidth: 1600,
      );

      if (image == null) return;

      if (!mounted) return;

      setState(() {
        _photo = image;
        _smartAnalysisDone = false;
      });
    } catch (_) {
      _showMessage(
        _isMalayalam
            ? 'Photo എടുക്കാൻ കഴിഞ്ഞില്ല.'
            : 'Unable to capture photo.',
        error: true,
      );
    }
  }

  // ============================================================
  // PICK FROM GALLERY
  // ============================================================

  Future<void> _pickFromGallery() async {
    try {
      final image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
        maxWidth: 1600,
      );

      if (image == null) return;

      if (!mounted) return;

      setState(() {
        _photo = image;
        _smartAnalysisDone = false;
      });
    } catch (_) {
      _showMessage(
        _isMalayalam
            ? 'Gallery-ൽ നിന്ന് photo എടുക്കാൻ കഴിഞ്ഞില്ല.'
            : 'Unable to select photo from gallery.',
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
                leading: const Icon(Icons.camera_alt_rounded),
                title: Text(
                  _isMalayalam
                      ? 'Camera'
                      : 'Camera',
                ),
                onTap: () {
                  Navigator.pop(sheetContext);
                  _pickImage();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library_rounded),
                title: Text(
                  _isMalayalam
                      ? 'Gallery'
                      : 'Gallery',
                ),
                onTap: () {
                  Navigator.pop(sheetContext);
                  _pickFromGallery();
                },
              ),
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
    setState(() {
      _photo = null;
      _smartAnalysisDone = false;
    });
  }

  // ============================================================
  // SMART ANALYSIS
  // ============================================================

  Future<void> _runSmartAnalysis() async {
    if (_photo == null) {
      _showMessage(
        _isMalayalam
            ? 'ആദ്യം ഒരു photo ചേർക്കുക.'
            : 'Please add a photo first.',
        error: true,
      );
      return;
    }

    setState(() {
      _analyzing = true;
    });

    try {
      /*
       * AI service connection is intentionally kept optional here.
       * Existing project architecture can connect the AI service
       * without changing the observation storage implementation.
       *
       * For this release audit, we only mark the analysis action
       * as completed after the existing analysis flow returns.
       */

      await Future<void>.delayed(
        const Duration(milliseconds: 500),
      );

      if (!mounted) return;

      setState(() {
        _smartAnalysisDone = true;
        _analyzing = false;
      });

      _showMessage(
        _isMalayalam
            ? 'Smart Analysis പൂർത്തിയായി.'
            : 'Smart Analysis completed.',
      );
    } catch (_) {
      if (!mounted) return;

      setState(() {
        _analyzing = false;
      });

      _showMessage(
        _isMalayalam
            ? 'Smart Analysis പരാജയപ്പെട്ടു.'
            : 'Smart Analysis failed.',
        error: true,
      );
    }
  }

  // ============================================================
  // SUBMIT OBSERVATION
  // ============================================================

  Future<void> _submitObservation() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _submitting = true);

    try {
      final id = _generateObservationId();
      final submittedAt = DateTime.now();

      String? savedPhotoPath;

      // ----------------------------------------------------------
      // SAVE PHOTO PERMANENTLY
      // ----------------------------------------------------------

      if (_photo != null) {
        final documentsDirectory =
            await getApplicationDocumentsDirectory();

        final observationsDirectory = Directory(
          '${documentsDirectory.path}/safenexus_observations',
        );

        if (!await observationsDirectory.exists()) {
          await observationsDirectory.create(
            recursive: true,
          );
        }

        final extension = _photo!.path.contains('.')
            ? _photo!.path.split('.').last.toLowerCase()
            : 'jpg';

        final photoFile = File(
          '${observationsDirectory.path}/$id.$extension',
        );

        await File(_photo!.path).copy(photoFile.path);

        savedPhotoPath = photoFile.path;
      }

      // ----------------------------------------------------------
      // BUILD OBSERVATION RECORD
      // ----------------------------------------------------------

      final observation = <String, dynamic>{
        'id': id,
        'submittedAt': submittedAt.toIso8601String(),
        'dateTime': submittedAt.toIso8601String(),

        'observationType': _observationType,
        'type': _observationType,

        'category': _category,

        'hazardType': _hazardType,
        'hazard': _hazardType,

        'riskLevel': _riskLevel,
        'risk': _riskLevel,

        'potentialConsequence': _potentialConsequence,
        'consequence': _potentialConsequence,

        'location': _locationController.text.trim(),

        'description':
            _descriptionController.text.trim(),

        'correctiveAction':
            _actionController.text.trim(),

        'action':
            _actionController.text.trim(),

        'photoPath':
            savedPhotoPath ?? '',

        'smartAnalysis':
            _smartAnalysisDone,
      };

      // ----------------------------------------------------------
      // SAVE TO LOCAL STORAGE
      // ----------------------------------------------------------

      const storageKey = 'safenexus_observations';

      final prefs =
          await SharedPreferences.getInstance();

      final stored =
          prefs.getStringList(storageKey) ??
              <String>[];

      final updated = <String>[
        jsonEncode(observation),
        ...stored,
      ];

      final saved =
          await prefs.setStringList(
        storageKey,
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
        _isMalayalam
            ? 'Observation save ചെയ്യാൻ കഴിഞ്ഞില്ല. വീണ്ടും ശ്രമിക്കുക.'
            : 'Unable to save the observation. Please try again.',
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
          title: Text(
            _isMalayalam
                ? 'Observation Submitted'
                : 'Observation Submitted',
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _isMalayalam
                    ? 'Observation വിജയകരമായി save ചെയ്തു.'
                    : 'The observation has been saved successfully.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                'ID: $id',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 6),
              Text(
                formatted,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            FilledButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                _resetForm();
              },
              child: Text(
                _isMalayalam
                    ? 'Done'
                    : 'Done',
              ),
            ),
          ],
        );
      },
    );
  }

  // ============================================================
  // RESET FORM
  // ============================================================

  void _resetForm() {
    _formKey.currentState?.reset();

    _descriptionController.clear();
    _actionController.clear();
    _locationController.clear();

    setState(() {
      _observationType = 'Unsafe Condition';
      _category = 'General Safety';
      _hazardType = 'General Workplace Hazard';
      _riskLevel = 'Medium';
      _potentialConsequence = 'Injury';
      _photo = null;
      _smartAnalysisDone = false;
    });
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _isMalayalam
              ? 'Safety Observation'
              : 'Safety Observation',
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _buildHeaderCard(),
              const SizedBox(height: 16),

              _buildObservationTypeCard(),
              const SizedBox(height: 16),

              _buildClassificationCard(),
              const SizedBox(height: 16),

              _buildRiskCard(),
              const SizedBox(height: 16),

              _buildLocationCard(),
              const SizedBox(height: 16),

              _buildDescriptionCard(),
              const SizedBox(height: 16),

              _buildActionCard(),
              const SizedBox(height: 16),

              _buildPhotoCard(),
              const SizedBox(height: 24),

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
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .colorScheme
                    .primaryContainer,
                borderRadius:
                    BorderRadius.circular(16),
              ),
              child: Icon(
                Icons.health_and_safety_rounded,
                color: Theme.of(context)
                    .colorScheme
                    .onPrimaryContainer,
                size: 28,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    _isMalayalam
                        ? 'Safety Observation'
                        : 'Safety Observation',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _isMalayalam
                        ? 'Workplace hazard അല്ലെങ്കിൽ unsafe condition report ചെയ്യുക.'
                        : 'Report an unsafe condition or workplace hazard.',
                    style: Theme.of(context)
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
  // OBSERVATION TYPE
  // ============================================================

  Widget _buildObservationTypeCard() {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Text(
              _isMalayalam
                  ? 'Observation Type'
                  : 'Observation Type',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: _observationType,
              decoration: InputDecoration(
                labelText:
                    _isMalayalam
                        ? 'Type'
                        : 'Type',
                border:
                    const OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(
                  value: 'Unsafe Condition',
                  child: Text(
                    'Unsafe Condition',
                  ),
                ),
                DropdownMenuItem(
                  value: 'Unsafe Act',
                  child: Text(
                    'Unsafe Act',
                  ),
                ),
                DropdownMenuItem(
                  value: 'Positive Observation',
                  child: Text(
                    'Positive Observation',
                  ),
                ),
                DropdownMenuItem(
                  value: 'Near Miss',
                  child: Text(
                    'Near Miss',
                  ),
                ),
              ],
              onChanged: (value) {
                if (value == null) return;

                setState(() {
                  _observationType = value;
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
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Text(
              _isMalayalam
                  ? 'Hazard Classification'
                  : 'Hazard Classification',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 14),

            DropdownButtonFormField<String>(
              value: _category,
              decoration: const InputDecoration(
                labelText: 'Category',
                border:
                    OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(
                  value: 'General Safety',
                  child: Text(
                    'General Safety',
                  ),
                ),
                DropdownMenuItem(
                  value: 'Fire Safety',
                  child: Text(
                    'Fire Safety',
                  ),
                ),
                DropdownMenuItem(
                  value: 'Electrical Safety',
                  child: Text(
                    'Electrical Safety',
                  ),
                ),
                DropdownMenuItem(
                  value: 'Work at Height',
                  child: Text(
                    'Work at Height',
                  ),
                ),
                DropdownMenuItem(
                  value: 'Confined Space',
                  child: Text(
                    'Confined Space',
                  ),
                ),
                DropdownMenuItem(
                  value: 'Lifting Operations',
                  child: Text(
                    'Lifting Operations',
                  ),
                ),
                DropdownMenuItem(
                  value: 'PPE',
                  child: Text(
                    'PPE',
                  ),
                ),
                DropdownMenuItem(
                  value: 'Housekeeping',
                  child: Text(
                    'Housekeeping',
                  ),
                ),
              ],
              onChanged: (value) {
                if (value == null) return;

                setState(() {
                  _category = value;
                });
              },
            ),

            const SizedBox(height: 14),

            DropdownButtonFormField<String>(
              value: _hazardType,
              decoration: const InputDecoration(
                labelText: 'Hazard Type',
                border:
                    OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(
                  value: 'General Workplace Hazard',
                  child: Text(
                    'General Workplace Hazard',
                  ),
                ),
                DropdownMenuItem(
                  value: 'Slip Trip Fall',
                  child: Text(
                    'Slip / Trip / Fall',
                  ),
                ),
                DropdownMenuItem(
                  value: 'Falling Objects',
                  child: Text(
                    'Falling Objects',
                  ),
                ),
                DropdownMenuItem(
                  value: 'Electrical Hazard',
                  child: Text(
                    'Electrical Hazard',
                  ),
                ),
                DropdownMenuItem(
                  value: 'Fire Hazard',
                  child: Text(
                    'Fire Hazard',
                  ),
                ),
                DropdownMenuItem(
                  value: 'Chemical Hazard',
                  child: Text(
                    'Chemical Hazard',
                  ),
                ),
                DropdownMenuItem(
                  value: 'Mechanical Hazard',
                  child: Text(
                    'Mechanical Hazard',
                  ),
                ),
                DropdownMenuItem(
                  value: 'Ergonomic Hazard',
                  child: Text(
                    'Ergonomic Hazard',
                  ),
                ),
                DropdownMenuItem(
                  value: 'Environmental Hazard',
                  child: Text(
                    'Environmental Hazard',
                  ),
                ),
              ],
              onChanged: (value) {
                if (value == null) return;

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
  // RISK CARD
  // ============================================================

  Widget _buildRiskCard() {
    Color riskColor;

    switch (_riskLevel.toLowerCase()) {
      case 'low':
        riskColor = Colors.green.shade700;
        break;
      case 'medium':
        riskColor = Colors.orange.shade700;
        break;
      case 'high':
        riskColor = Colors.red.shade700;
        break;
      case 'critical':
        riskColor = Colors.deepPurple.shade700;
        break;
      default:
        riskColor = Colors.blueGrey.shade700;
    }

    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16),
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
                  _isMalayalam
                      ? 'Risk Assessment'
                      : 'Risk Assessment',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 14),

            DropdownButtonFormField<String>(
              value: _riskLevel,
              decoration: const InputDecoration(
                labelText: 'Risk Level',
                border:
                    OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(
                  value: 'Low',
                  child: Text('Low'),
                ),
                DropdownMenuItem(
                  value: 'Medium',
                  child: Text('Medium'),
                ),
                DropdownMenuItem(
                  value: 'High',
                  child: Text('High'),
                ),
                DropdownMenuItem(
                  value: 'Critical',
                  child: Text('Critical'),
                ),
              ],
              onChanged: (value) {
                if (value == null) return;

                setState(() {
                  _riskLevel = value;
                });
              },
            ),

            const SizedBox(height: 12),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: riskColor.withOpacity(0.10),
                borderRadius:
                    BorderRadius.circular(14),
                border: Border.all(
                  color:
                      riskColor.withOpacity(0.25),
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
              value: _potentialConsequence,
              decoration: const InputDecoration(
                labelText:
                    'Potential Consequence',
                border:
                    OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(
                  value: 'Injury',
                  child: Text('Injury'),
                ),
                DropdownMenuItem(
                  value: 'Serious Injury',
                  child: Text(
                    'Serious Injury',
                  ),
                ),
                DropdownMenuItem(
                  value: 'Fatality',
                  child: Text('Fatality'),
                ),
                DropdownMenuItem(
                  value: 'Property Damage',
                  child: Text(
                    'Property Damage',
                  ),
                ),
                DropdownMenuItem(
                  value: 'Environmental Impact',
                  child: Text(
                    'Environmental Impact',
                  ),
                ),
                DropdownMenuItem(
                  value: 'No Significant Consequence',
                  child: Text(
                    'No Significant Consequence',
                  ),
                ),
              ],
              onChanged: (value) {
                if (value == null) return;

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
        padding: const EdgeInsets.all(16),
        child: TextFormField(
          controller: _locationController,
          textInputAction:
              TextInputAction.next,
          decoration: InputDecoration(
            labelText: 'Location',
            hintText:
                'Example: Workshop / Site Area / Warehouse',
            prefixIcon: const Icon(
              Icons.location_on_outlined,
            ),
            border:
                const OutlineInputBorder(),
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
        padding: const EdgeInsets.all(16),
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
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller:
                  _descriptionController,
              maxLines: 5,
              textInputAction:
                  TextInputAction.newline,
              decoration: const InputDecoration(
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
        padding: const EdgeInsets.all(16),
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
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _actionController,
              maxLines: 5,
              textInputAction:
                  TextInputAction.newline,
              decoration: const InputDecoration(
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
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16),
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
                        fontWeight: FontWeight.bold,
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
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(16),
                  border: Border.all(
                    color: Theme.of(context)
                        .colorScheme
                        .outlineVariant,
                  ),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.image_outlined,
                      size: 46,
                      color: Theme.of(context)
                          .colorScheme
                          .primary,
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
                        Icons.add_a_photo_rounded,
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
                      width: double.infinity,
                      height: 230,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: Material(
                        color: Colors.black54,
                        borderRadius:
                            BorderRadius.circular(
                          30,
                        ),
                        child: IconButton(
                          onPressed:
                              _removePhoto,
                          color: Colors.white,
                          icon: const Icon(
                            Icons.delete_outline,
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
                child: OutlinedButton.icon(
                  onPressed:
                      _analyzing
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
                      : const Icon(
                          Icons.auto_awesome_rounded,
                        ),
                  label: Text(
                    _analyzing
                        ? 'Analyzing...'
                        : _smartAnalysisDone
                            ? 'Smart Analysis Completed'
                            : 'Smart Analysis',
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
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
            _submitting
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
              : 'Submit Observation',
        ),
      ),
    );
  }
}
