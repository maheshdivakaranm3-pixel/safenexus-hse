import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SafetyObservationPage extends StatefulWidget {
  const SafetyObservationPage({super.key});

  @override
  State<SafetyObservationPage> createState() =>
      _SafetyObservationPageState();
}

class _SafetyObservationPageState extends State<SafetyObservationPage> {
  static const String _storageKey = 'safety_observations';

  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  final _actionController = TextEditingController();
  final _locationController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  String _observationType = 'Unsafe Condition';
  String _category = 'General Safety';
  String _riskLevel = 'Medium';
  XFile? _photo;
  bool _submitting = false;

  bool get _isMalayalam =>
      Localizations.localeOf(context).languageCode == 'ml';

  List<String> get _observationTypes => [
        'Unsafe Act',
        'Unsafe Condition',
        'Positive Observation',
      ];

  List<String> get _categories => [
        'General Safety',
        'PPE',
        'Work at Height',
        'Scaffolding',
        'Lifting & Rigging',
        'Electrical Safety',
        'Fire Safety',
        'Housekeeping',
        'Permit to Work',
        'Environmental Safety',
        'Heat Stress',
        'Vehicle & Traffic Safety',
      ];

  List<String> get _riskLevels => [
        'Low',
        'Medium',
        'High',
        'Critical',
      ];

  @override
  void dispose() {
    _descriptionController.dispose();
    _actionController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  Future<void> _pickPhoto(ImageSource source) async {
    try {
      final image = await _picker.pickImage(
        source: source,
        imageQuality: 80,
        maxWidth: 1600,
      );

      if (image != null && mounted) {
        setState(() {
          _photo = image;
        });
      }
    } catch (_) {
      if (!mounted) return;

      _showMessage(
        _isMalayalam
            ? 'Photo എടുക്കാൻ കഴിഞ്ഞില്ല.'
            : 'Unable to select photo.',
      );
    }
  }

  Future<void> _showPhotoOptions() async {
    await showModalBottomSheet<void>(
      context: context,
      builder: (sheetContext) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () {
                Navigator.pop(sheetContext);
                _pickPhoto(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Gallery'),
              onTap: () {
                Navigator.pop(sheetContext);
                _pickPhoto(ImageSource.gallery);
              },
            ),
            if (_photo != null)
              ListTile(
                leading: const Icon(Icons.delete_outline),
                title: Text(
                  _isMalayalam ? 'Remove Photo' : 'Remove Photo',
                ),
                onTap: () {
                  Navigator.pop(sheetContext);

                  setState(() {
                    _photo = null;
                  });
                },
              ),
          ],
        ),
      ),
    );
  }

  String _generateObservationId() {
    final now = DateTime.now();

    final stamp =
        '${now.year}'
        '${now.month.toString().padLeft(2, '0')}'
        '${now.day.toString().padLeft(2, '0')}'
        '${now.hour.toString().padLeft(2, '0')}'
        '${now.minute.toString().padLeft(2, '0')}'
        '${now.second.toString().padLeft(2, '0')}';

    return 'OBS-$stamp';
  }

  // ------------------------------------------------------------
  // SAVE OBSERVATION LOCALLY
  // ------------------------------------------------------------

  Future<void> _saveObservation({
    required String observationId,
    required DateTime submittedAt,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    final existingData =
        prefs.getStringList(_storageKey) ?? <String>[];

    final observation = <String, dynamic>{
      'id': observationId,
      'type': _observationType,
      'category': _category,
      'risk': _riskLevel,
      'description': _descriptionController.text.trim(),
      'action': _actionController.text.trim(),
      'location': _locationController.text.trim(),
      'dateTime': submittedAt.toIso8601String(),
      'photoPath': _photo?.path ?? '',
    };

    existingData.add(jsonEncode(observation));

    await prefs.setStringList(
      _storageKey,
      existingData,
    );
  }

  Future<void> _submitObservation() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _submitting = true;
    });

    final observationId = _generateObservationId();
    final submittedAt = DateTime.now();

    try {
      // Save observation before showing success message.
      await _saveObservation(
        observationId: observationId,
        submittedAt: submittedAt,
      );

      if (!mounted) return;

      setState(() {
        _submitting = false;
      });

      await _showSuccessDialog(
        observationId,
        submittedAt,
      );
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _submitting = false;
      });

      _showMessage(
        _isMalayalam
            ? 'Observation save ചെയ്യാൻ കഴിഞ്ഞില്ല.'
            : 'Unable to save observation.',
      );
    }
  }

  Future<void> _showSuccessDialog(
    String id,
    DateTime submittedAt,
  ) async {
    final date =
        '${submittedAt.day.toString().padLeft(2, '0')}/'
        '${submittedAt.month.toString().padLeft(2, '0')}/'
        '${submittedAt.year} '
        '${submittedAt.hour.toString().padLeft(2, '0')}:'
        '${submittedAt.minute.toString().padLeft(2, '0')}';

    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        icon: const Icon(
          Icons.check_circle,
          color: Colors.green,
          size: 56,
        ),
        title: const Text('Observation Submitted'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _isMalayalam
                  ? 'Safety observation വിജയകരമായി രേഖപ്പെടുത്തി.'
                  : 'The safety observation has been recorded successfully.',
            ),
            const SizedBox(height: 16),
            _infoRow(
              'Observation ID',
              id,
              compactValue: true,
            ),
            _infoRow(
              'Type',
              _observationType,
            ),
            _infoRow(
              'Risk',
              _riskLevel,
            ),
            _infoRow(
              'Date & Time',
              date,
            ),
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
      ),
    );
  }

  Widget _infoRow(
    String label,
    String value, {
    bool compactValue = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 105,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: compactValue
                ? FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      value,
                      maxLines: 1,
                      softWrap: false,
                    ),
                  )
                : Text(value),
          ),
        ],
      ),
    );
  }

  void _resetForm() {
    _formKey.currentState?.reset();

    _descriptionController.clear();
    _actionController.clear();
    _locationController.clear();

    setState(() {
      _observationType = 'Unsafe Condition';
      _category = 'General Safety';
      _riskLevel = 'Medium';
      _photo = null;
    });
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  InputDecoration _decoration(
    String label, {
    String? hint,
    IconData? icon,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: icon == null ? null : Icon(icon),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      filled: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final ml = _isMalayalam;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Safety Observation'),
        actions: [
          PopupMenuButton<Locale>(
            icon: const Icon(Icons.language),
            onSelected: (_) {},
            itemBuilder: (_) => const [
              PopupMenuItem(
                value: Locale('en', 'US'),
                child: Text('English'),
              ),
              PopupMenuItem(
                value: Locale('ml', 'IN'),
                child: Text('മലയാളം'),
              ),
            ],
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _headerCard(ml),
            const SizedBox(height: 18),

            DropdownButtonFormField<String>(
              initialValue: _observationType,
              decoration: _decoration(
                'Observation Type',
                icon: Icons.visibility,
              ),
              items: _observationTypes
                  .map(
                    (value) => DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                if (value == null) return;

                setState(() {
                  _observationType = value;
                });
              },
            ),

            const SizedBox(height: 14),

            DropdownButtonFormField<String>(
              initialValue: _category,
              decoration: _decoration(
                'Category',
                icon: Icons.category,
              ),
              items: _categories
                  .map(
                    (value) => DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                if (value == null) return;

                setState(() {
                  _category = value;
                });
              },
            ),

            const SizedBox(height: 14),

            DropdownButtonFormField<String>(
              initialValue: _riskLevel,
              decoration: _decoration(
                'Risk Level',
                icon: Icons.warning_amber,
              ),
              items: _riskLevels
                  .map(
                    (value) => DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                if (value == null) return;

                setState(() {
                  _riskLevel = value;
                });
              },
            ),

            const SizedBox(height: 14),

            TextFormField(
              controller: _descriptionController,
              minLines: 4,
              maxLines: 6,
              decoration: _decoration(
                'Observation Description',
                hint: ml
                    ? 'എന്താണ് കണ്ടത് എന്ന് വിശദീകരിക്കുക'
                    : 'Describe what you observed',
                icon: Icons.description,
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return ml
                      ? 'Description നൽകുക'
                      : 'Please enter a description';
                }

                return null;
              },
            ),

            const SizedBox(height: 14),

            TextFormField(
              controller: _actionController,
              minLines: 2,
              maxLines: 4,
              decoration: _decoration(
                'Immediate Action',
                hint: ml
                    ? 'എടുത്ത ഉടൻ നടപടികൾ'
                    : 'Action taken immediately',
                icon: Icons.build_circle_outlined,
              ),
            ),

            const SizedBox(height: 14),

            TextFormField(
              controller: _locationController,
              decoration: _decoration(
                'Location / Area',
                hint: ml
                    ? 'ഉദാ: Workshop / Block A'
                    : 'e.g. Workshop / Block A',
                icon: Icons.location_on_outlined,
              ),
            ),

            const SizedBox(height: 18),

            _photoSection(ml),

            const SizedBox(height: 24),

            SizedBox(
              height: 52,
              child: FilledButton.icon(
                onPressed:
                    _submitting ? null : _submitObservation,
                icon: _submitting
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      )
                    : const Icon(Icons.send),
                label: Text(
                  _submitting
                      ? 'Submitting...'
                      : 'Submit Observation',
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _headerCard(bool ml) {
    return Card(
      elevation: 0,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Theme.of(context)
              .colorScheme
              .primaryContainer,
        ),
        child: Row(
          children: [
            Icon(
              Icons.health_and_safety,
              size: 42,
              color: Theme.of(context)
                  .colorScheme
                  .primary,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                ml
                    ? 'സുരക്ഷിതമായ പ്രവൃത്തികൾ പ്രോത്സാഹിപ്പിക്കുകയും അപകടസാധ്യതകൾ ഉടൻ റിപ്പോർട്ട് ചെയ്യുകയും ചെയ്യുക.'
                    : 'Record unsafe acts, unsafe conditions and positive safety observations.',
                style: const TextStyle(
                  fontSize: 14,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _photoSection(bool ml) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Photo Evidence (Optional)',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),

        InkWell(
          onTap: _showPhotoOptions,
          borderRadius: BorderRadius.circular(14),
          child: Container(
            width: double.infinity,
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: Colors.grey.shade400,
              ),
            ),
            clipBehavior: Clip.antiAlias,
            child: _photo == null
                ? Column(
                    mainAxisAlignment:
                        MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_a_photo_outlined,
                        size: 40,
                        color: Colors.grey.shade600,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        ml
                            ? 'Tap to add photo'
                            : 'Tap to add photo',
                      ),
                    ],
                  )
                : Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.file(
                        File(_photo!.path),
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        right: 8,
                        top: 8,
                        child: CircleAvatar(
                          backgroundColor: Colors.black54,
                          child: IconButton(
                            color: Colors.white,
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              setState(() {
                                _photo = null;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ],
    );
  }
}
