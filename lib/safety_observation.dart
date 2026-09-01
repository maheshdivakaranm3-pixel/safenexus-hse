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

  final ImagePicker _picker = ImagePicker();

  final TextEditingController _locationController =
      TextEditingController();
  final TextEditingController _descriptionController =
      TextEditingController();
  final TextEditingController _immediateActionController =
      TextEditingController();
  final TextEditingController _correctiveActionController =
      TextEditingController();
  final TextEditingController _responsibleController =
      TextEditingController();
  final TextEditingController _closureRemarksController =
      TextEditingController();

  File? _beforePhoto;
  File? _afterPhoto;

  DateTime _observationDateTime = DateTime.now();
  DateTime? _targetDate;

  String _category = 'Unsafe Act';
  String _riskLevel = 'Medium';
  String _status = 'Open';

  bool _isSaving = false;
  bool _isAnalyzing = false;

  @override
  void dispose() {
    _locationController.dispose();
    _descriptionController.dispose();
    _immediateActionController.dispose();
    _correctiveActionController.dispose();
    _responsibleController.dispose();
    _closureRemarksController.dispose();
    super.dispose();
  }

  // ------------------------------------------------------------
  // PHOTO PICKING
  // ------------------------------------------------------------

  Future<void> _pickBeforePhoto(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: 85,
        maxWidth: 1600,
      );

      if (pickedFile == null) return;

      setState(() {
        _beforePhoto = File(pickedFile.path);
      });

      // Prepare the observation form after photo selection.
      await _prepareObservationFromPhoto();
    } catch (e) {
      _showMessage('Unable to select photo.');
    }
  }

  Future<void> _pickAfterPhoto(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: 85,
        maxWidth: 1600,
      );

      if (pickedFile == null) return;

      setState(() {
        _afterPhoto = File(pickedFile.path);
      });
    } catch (e) {
      _showMessage('Unable to select after photo.');
    }
  }

  // ------------------------------------------------------------
  // PHOTO ANALYSIS PLACEHOLDER
  // ------------------------------------------------------------

  Future<void> _prepareObservationFromPhoto() async {
    if (_beforePhoto == null) return;

    setState(() {
      _isAnalyzing = true;
    });

    /*
      IMPORTANT:
      This is the AI integration point.

      A real AI Vision API can later analyze _beforePhoto and return:

      - Unsafe Act / Unsafe Condition
      - Observation description
      - Risk level
      - Immediate Action
      - Corrective Action

      No fake AI result is inserted here.
    */

    await Future.delayed(const Duration(milliseconds: 500));

    if (!mounted) return;

    setState(() {
      _isAnalyzing = false;

      if (_descriptionController.text.trim().isEmpty) {
        _descriptionController.text =
            'Photo selected. Review and enter the unsafe act or unsafe condition identified in the photo.';
      }

      if (_immediateActionController.text.trim().isEmpty) {
        _immediateActionController.text =
            'Control the immediate hazard and prevent exposure to workers.';
      }

      if (_correctiveActionController.text.trim().isEmpty) {
        _correctiveActionController.text =
            'Implement corrective measures and provide appropriate safety briefing or training where required.';
      }
    });
  }

  // ------------------------------------------------------------
  // DATE / TIME
  // ------------------------------------------------------------

  Future<void> _selectObservationDateTime() async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: _observationDateTime,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (date == null || !mounted) return;

    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_observationDateTime),
    );

    if (time == null) return;

    setState(() {
      _observationDateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }

  Future<void> _selectTargetDate() async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: _targetDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (date == null) return;

    setState(() {
      _targetDate = date;
    });
  }

  // ------------------------------------------------------------
  // SAVE
  // ------------------------------------------------------------

  Future<void> _saveObservation() async {
    if (_beforePhoto == null) {
      _showMessage('Please add a Before Photo.');
      return;
    }

    if (_locationController.text.trim().isEmpty) {
      _showMessage('Please enter the location.');
      return;
    }

    if (_descriptionController.text.trim().isEmpty) {
      _showMessage('Please enter the observation description.');
      return;
    }

    if (_responsibleController.text.trim().isEmpty) {
      _showMessage('Please assign a responsible person.');
      return;
    }

    if (_targetDate == null) {
      _showMessage('Please select a target date.');
      return;
    }

    setState(() {
      _isSaving = true;
    });

    try {
      final prefs = await SharedPreferences.getInstance();

      final List<String> existing =
          prefs.getStringList(_storageKey) ?? <String>[];

      final Map<String, dynamic> observation = {
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'location': _locationController.text.trim(),
        'dateTime': _observationDateTime.toIso8601String(),
        'description': _descriptionController.text.trim(),
        'category': _category,
        'riskLevel': _riskLevel,
        'beforePhoto': _beforePhoto?.path ?? '',
        'immediateAction': _immediateActionController.text.trim(),
        'correctiveAction': _correctiveActionController.text.trim(),
        'responsiblePerson': _responsibleController.text.trim(),
        'targetDate': _targetDate?.toIso8601String(),
        'afterPhoto': _afterPhoto?.path ?? '',
        'status': _status,
        'closureRemarks': _closureRemarksController.text.trim(),
        'createdAt': DateTime.now().toIso8601String(),
        'updatedAt': DateTime.now().toIso8601String(),
      };

      existing.insert(0, jsonEncode(observation));

      await prefs.setStringList(_storageKey, existing);

      if (!mounted) return;

      _showMessage('Safety observation saved successfully.');

      _clearForm();
    } catch (e) {
      _showMessage('Unable to save observation.');
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  // ------------------------------------------------------------
  // CLEAR FORM
  // ------------------------------------------------------------

  void _clearForm() {
    setState(() {
      _beforePhoto = null;
      _afterPhoto = null;

      _locationController.clear();
      _descriptionController.clear();
      _immediateActionController.clear();
      _correctiveActionController.clear();
      _responsibleController.clear();
      _closureRemarksController.clear();

      _observationDateTime = DateTime.now();
      _targetDate = null;

      _category = 'Unsafe Act';
      _riskLevel = 'Medium';
      _status = 'Open';
    });
  }

  // ------------------------------------------------------------
  // UI HELPERS
  // ------------------------------------------------------------

  void _showMessage(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'Select Target Date';

    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }

  String _formatDateTime(DateTime date) {
    final String hour = date.hour.toString().padLeft(2, '0');
    final String minute = date.minute.toString().padLeft(2, '0');

    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year} $hour:$minute';
  }

  // ------------------------------------------------------------
  // PHOTO SOURCE SHEET
  // ------------------------------------------------------------

  void _showBeforePhotoOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Take Photo'),
                onTap: () {
                  Navigator.pop(context);
                  _pickBeforePhoto(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Upload from Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _pickBeforePhoto(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showAfterPhotoOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Take After Photo'),
                onTap: () {
                  Navigator.pop(context);
                  _pickAfterPhoto(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Upload from Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _pickAfterPhoto(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // ------------------------------------------------------------
  // SECTION HEADER
  // ------------------------------------------------------------

  Widget _sectionHeader(
    String title,
    IconData icon, {
    Color? color,
  }) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 22,
        bottom: 12,
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 19,
            backgroundColor:
                (color ?? Theme.of(context).colorScheme.primary)
                    .withOpacity(0.12),
            child: Icon(
              icon,
              size: 21,
              color: color ?? Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ------------------------------------------------------------
  // TEXT FIELD
  // ------------------------------------------------------------

  Widget _textField({
    required TextEditingController controller,
    required String label,
    required String hint,
    IconData? icon,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          prefixIcon: icon == null
              ? null
              : Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
        ),
      ),
    );
  }

  // ------------------------------------------------------------
  // PHOTO CARD
  // ------------------------------------------------------------

  Widget _photoCard({
    required String title,
    required String subtitle,
    required File? file,
    required VoidCallback onTap,
    required IconData icon,
  }) {
    return Card(
      elevation: 1,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 220,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
          ),
          child: file == null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      icon,
                      size: 55,
                      color: Theme.of(context)
                          .colorScheme
                          .primary,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      subtitle,
                      textAlign: TextAlign.center,
                    ),
                  ],
                )
              : Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.file(
                      file,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      left: 10,
                      bottom: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.65),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'Photo selected',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
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
  // BUILD
  // ------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Safety Observation',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Form(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(
              16,
              8,
              16,
              30,
            ),
            children: [
              // ==================================================
              // BEFORE PHOTO
              // ==================================================

              _sectionHeader(
                'Before Photo',
                Icons.camera_alt,
                color: Colors.blue,
              ),

              _photoCard(
                title: 'Add Unsafe Work Photo',
                subtitle:
                    'Take a photo or upload an existing photo',
                file: _beforePhoto,
                onTap: _showBeforePhotoOptions,
                icon: Icons.add_a_photo,
              ),

              const SizedBox(height: 10),

              if (_beforePhoto != null)
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.blue.withOpacity(0.08),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.auto_awesome,
                        color: Colors.blue,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          _isAnalyzing
                              ? 'Preparing observation analysis...'
                              : 'Review the observation details generated from the photo.',
                        ),
                      ),
                    ],
                  ),
                ),

              // ==================================================
              // OBSERVATION DETAILS
              // ==================================================

              _sectionHeader(
                'Observation Details',
                Icons.visibility,
              ),

              _textField(
                controller: _locationController,
                label: 'Location',
                hint: 'Enter exact location',
                icon: Icons.location_on,
              ),

              InkWell(
                onTap: _selectObservationDateTime,
                borderRadius: BorderRadius.circular(12),
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'Date & Time',
                    prefixIcon: const Icon(
                      Icons.calendar_month,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                  ),
                  child: Text(
                    _formatDateTime(
                      _observationDateTime,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              _textField(
                controller: _descriptionController,
                label: 'Observation Description',
                hint:
                    'Describe the unsafe act or unsafe condition',
                icon: Icons.description,
                maxLines: 5,
              ),

              DropdownButtonFormField<String>(
                value: _category,
                decoration: InputDecoration(
                  labelText: 'Category',
                  prefixIcon: const Icon(
                    Icons.category,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'Unsafe Act',
                    child: Text('Unsafe Act'),
                  ),
                  DropdownMenuItem(
                    value: 'Unsafe Condition',
                    child: Text('Unsafe Condition'),
                  ),
                ],
                onChanged: (value) {
                  if (value == null) return;
                  setState(() {
                    _category = value;
                  });
                },
              ),

              // ==================================================
              // RISK ASSESSMENT
              // ==================================================

              _sectionHeader(
                'Risk Assessment',
                Icons.warning_amber_rounded,
                color: Colors.orange,
              ),

              DropdownButtonFormField<String>(
                value: _riskLevel,
                decoration: InputDecoration(
                  labelText: 'Risk Level',
                  prefixIcon: const Icon(
                    Icons.warning,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'High',
                    child: Text('🔴 High Risk'),
                  ),
                  DropdownMenuItem(
                    value: 'Medium',
                    child: Text('🟠 Medium Risk'),
                  ),
                  DropdownMenuItem(
                    value: 'Low',
                    child: Text('🟢 Low Risk'),
                  ),
                ],
                onChanged: (value) {
                  if (value == null) return;
                  setState(() {
                    _riskLevel = value;
                  });
                },
              ),

              const SizedBox(height: 8),

              _riskDescription(),

              // ==================================================
              // ACTION PLAN
              // ==================================================

              _sectionHeader(
                'Rectification & Action Plan',
                Icons.build_circle,
                color: Colors.green,
              ),

              _textField(
                controller: _immediateActionController,
                label: 'Immediate Action',
                hint:
                    'What was done immediately to control the hazard?',
                icon: Icons.flash_on,
                maxLines: 4,
              ),

              _textField(
                controller: _correctiveActionController,
                label: 'Corrective Action',
                hint:
                    'What should be done to prevent recurrence?',
                icon: Icons.check_circle,
                maxLines: 4,
              ),

              _textField(
                controller: _responsibleController,
                label: 'Assign Responsibility',
                hint:
                    'Supervisor / Engineer / Responsible Person',
                icon: Icons.person,
              ),

              InkWell(
                onTap: _selectTargetDate,
                borderRadius: BorderRadius.circular(12),
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'Target Date',
                    prefixIcon: const Icon(
                      Icons.event,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                  ),
                  child: Text(
                    _targetDate == null
                        ? 'Select Target Date'
                        : _formatDate(_targetDate),
                  ),
                ),
              ),

              // ==================================================
              // CLOSURE
              // ==================================================

              _sectionHeader(
                'Closure & Follow-up',
                Icons.lock_open,
                color: Colors.deepPurple,
              ),

              _photoCard(
                title: 'Add After Photo',
                subtitle:
                    'Take or upload photo after rectification',
                file: _afterPhoto,
                onTap: _showAfterPhotoOptions,
                icon: Icons.add_photo_alternate,
              ),

              const SizedBox(height: 12),

              DropdownButtonFormField<String>(
                value: _status,
                decoration: InputDecoration(
                  labelText: 'Status',
                  prefixIcon: const Icon(
                    Icons.track_changes,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'Open',
                    child: Text('🔴 Open'),
                  ),
                  DropdownMenuItem(
                    value: 'In Progress',
                    child: Text('🟠 In Progress'),
                  ),
                  DropdownMenuItem(
                    value: 'Closed',
                    child: Text('🟢 Closed'),
                  ),
                ],
                onChanged: (value) {
                  if (value == null) return;
                  setState(() {
                    _status = value;
                  });
                },
              ),

              const SizedBox(height: 12),

              _textField(
                controller: _closureRemarksController,
                label: 'Closure Remarks',
                hint:
                    'Enter verification / closure remarks',
                icon: Icons.notes,
                maxLines: 4,
              ),

              // ==================================================
              // SAVE BUTTON
              // ==================================================

              const SizedBox(height: 25),

              SizedBox(
                height: 55,
                child: FilledButton.icon(
                  onPressed:
                      _isSaving ? null : _saveObservation,
                  icon: _isSaving
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        )
                      : const Icon(
                          Icons.save,
                        ),
                  label: Text(
                    _isSaving
                        ? 'Saving...'
                        : 'Save Safety Observation',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              OutlinedButton.icon(
                onPressed: _isSaving
                    ? null
                    : () {
                        _clearForm();
                      },
                icon: const Icon(Icons.refresh),
                label: const Text('Clear Form'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ------------------------------------------------------------
  // RISK DESCRIPTION
  // ------------------------------------------------------------

  Widget _riskDescription() {
    String title;
    String description;
    IconData icon;

    if (_riskLevel == 'High') {
      title = 'High Risk';
      description =
          'Potential for fatality, serious injury or major incident. '
          'Immediate control and work stoppage may be required.';
      icon = Icons.dangerous;
    } else if (_riskLevel == 'Medium') {
      title = 'Medium Risk';
      description =
          'Potential for injury or property/environmental damage. '
          'Corrective action should be completed within the target date.';
      icon = Icons.warning_amber;
    } else {
      title = 'Low Risk';
      description =
          'Minor issue with limited potential consequences. '
          'Corrective action should still be recorded and followed up.';
      icon = Icons.info_outline;
    }

    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _riskLevel == 'High'
              ? Colors.red
              : _riskLevel == 'Medium'
                  ? Colors.orange
                  : Colors.green,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 4),
                Text(description),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
