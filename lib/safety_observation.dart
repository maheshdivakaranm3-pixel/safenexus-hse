import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SafetyObservationPage extends StatefulWidget {
  const SafetyObservationPage({super.key});

  @override
  State<SafetyObservationPage> createState() => _SafetyObservationPageState();
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

  final List<String> _observationTypes = const [
    'Unsafe Act',
    'Unsafe Condition',
    'Positive Observation',
  ];

  final List<String> _categories = const [
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
    'Slip, Trip & Fall',
    'Chemical Safety',
    'Confined Space',
    'Manual Handling',
    'Machinery Safety',
  ];

  final List<String> _riskLevels = const [
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

  // ---------------------------------------------------------------------------
  // RISK UI
  // ---------------------------------------------------------------------------

  Color _riskColor(String risk) {
    switch (risk) {
      case 'Low':
        return Colors.green.shade700;
      case 'Medium':
        return Colors.orange.shade800;
      case 'High':
        return Colors.red.shade700;
      case 'Critical':
        return Colors.red.shade900;
      default:
        return Theme.of(context).colorScheme.primary;
    }
  }

  Color _riskBackground(String risk) {
    switch (risk) {
      case 'Low':
        return Colors.green.withOpacity(0.10);
      case 'Medium':
        return Colors.orange.withOpacity(0.12);
      case 'High':
        return Colors.red.withOpacity(0.10);
      case 'Critical':
        return Colors.red.withOpacity(0.16);
      default:
        return Theme.of(context).colorScheme.surfaceContainerHighest;
    }
  }

  IconData _riskIcon(String risk) {
    switch (risk) {
      case 'Low':
        return Icons.check_circle_outline;
      case 'Medium':
        return Icons.warning_amber_rounded;
      case 'High':
        return Icons.error_outline;
      case 'Critical':
        return Icons.dangerous_outlined;
      default:
        return Icons.warning_amber_rounded;
    }
  }

  String _consequenceForRisk(String risk) {
    switch (risk) {
      case 'Low':
        return 'Minor injury';
      case 'Medium':
        return 'Injury';
      case 'High':
        return 'Serious injury';
      case 'Critical':
        return 'Fatality';
      default:
        return 'Injury';
    }
  }

  void _applyManualRisk(String value) {
    setState(() {
      _riskLevel = value;
      _potentialConsequence = _consequenceForRisk(value);
    });
  }

  // ---------------------------------------------------------------------------
  // PHOTO
  // ---------------------------------------------------------------------------

  Future<void> _pickPhoto(ImageSource source) async {
    try {
      final image = await _picker.pickImage(
        source: source,
        imageQuality: 80,
        maxWidth: 1600,
      );

      if (image == null || !mounted) return;

      setState(() {
        _photo = image;
        _smartAnalysisDone = false;
      });
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
      showDragHandle: true,
      builder: (sheetContext) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt_outlined),
                title: const Text('Camera'),
                onTap: () {
                  Navigator.pop(sheetContext);
                  _pickPhoto(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library_outlined),
                title: const Text('Gallery'),
                onTap: () {
                  Navigator.pop(sheetContext);
                  _pickPhoto(ImageSource.gallery);
                },
              ),
              if (_photo != null)
                ListTile(
                  leading: const Icon(
                    Icons.delete_outline,
                    color: Colors.red,
                  ),
                  title: const Text('Remove Photo'),
                  onTap: () {
                    Navigator.pop(sheetContext);
                    _removePhoto();
                  },
                ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  void _removePhoto() {
    setState(() {
      _photo = null;
      _smartAnalysisDone = false;
    });
  }

  // ---------------------------------------------------------------------------
  // LOCAL SMART HSE ANALYSIS
  // ---------------------------------------------------------------------------

  Future<void> _analyzeObservation() async {
    final text = _descriptionController.text.trim().toLowerCase();

    if (text.isEmpty) {
      _showMessage(
        _isMalayalam
            ? 'ആദ്യം observation description നൽകുക.'
            : 'Enter an observation description first.',
      );
      return;
    }

    setState(() => _analyzing = true);

    await Future<void>.delayed(
      const Duration(milliseconds: 350),
    );

    final result = _classifyHazard(text);

    if (!mounted) return;

    setState(() {
      _observationType = result.type;
      _category = result.category;
      _hazardType = result.hazard;
      _riskLevel = result.risk;
      _potentialConsequence = result.consequence;
      _smartAnalysisDone = true;
      _analyzing = false;

      if (_actionController.text.trim().isEmpty) {
        _actionController.text = result.action;
      }
    });

    _showMessage(
      _isMalayalam
          ? 'Category, Risk, Hazard & Action update ചെയ്തു.'
          : 'Category, Risk, Hazard and Action updated.',
    );
  }

  _HazardResult _classifyHazard(String text) {
    if (_containsAny(text, [
      'fall from height',
      'fell from height',
      'working at height',
      'height',
      'ladder',
      'roof',
      'unguarded edge',
      'no harness',
      'without harness',
      'scaffold',
      'scaffolding',
    ])) {
      final critical = _containsAny(text, [
        'fell from height',
        'fall from height',
        'unguarded edge',
        'no fall protection',
      ]);

      return _HazardResult(
        type: 'Unsafe Act',
        category:
            text.contains('scaffold') ? 'Scaffolding' : 'Work at Height',
        hazard: 'Fall from Height',
        risk: critical ? 'Critical' : 'High',
        consequence: critical ? 'Fatality' : 'Serious injury',
        action:
            'Stop the unsafe work, barricade the area, provide suitable fall protection and verify controls before restarting.',
      );
    }

    if (_containsAny(text, [
      'no helmet',
      'without helmet',
      'no gloves',
      'without gloves',
      'no goggles',
      'without goggles',
      'no safety shoes',
      'without safety shoes',
      'ppe',
    ])) {
      return const _HazardResult(
        type: 'Unsafe Act',
        category: 'PPE',
        hazard: 'Inadequate / Missing PPE',
        risk: 'Medium',
        consequence: 'Injury',
        action:
            'Ensure the required PPE is worn correctly before continuing the task.',
      );
    }

    if (_containsAny(text, [
      'electric',
      'electrical',
      'exposed wire',
      'exposed cable',
      'live wire',
      'damaged cable',
      'electrical panel',
      'open panel',
      'electric shock',
    ])) {
      final critical = _containsAny(text, [
        'live wire',
        'exposed wire',
        'electric shock',
      ]);

      return _HazardResult(
        type: 'Unsafe Condition',
        category: 'Electrical Safety',
        hazard: 'Electrical Exposure',
        risk: critical ? 'Critical' : 'High',
        consequence: critical ? 'Fatality' : 'Serious injury',
        action:
            'Isolate the electrical source by an authorized competent person and rectify the defect before work resumes.',
      );
    }

    if (_containsAny(text, [
      'fire',
      'flammable',
      'hot work',
      'gas cylinder',
      'combustible',
      'fire extinguisher',
    ])) {
      return const _HazardResult(
        type: 'Unsafe Condition',
        category: 'Fire Safety',
        hazard: 'Fire / Ignition Hazard',
        risk: 'High',
        consequence: 'Serious injury',
        action:
            'Control the ignition source, remove combustible materials and verify required fire protection.',
      );
    }

    if (_containsAny(text, [
      'lifting',
      'crane',
      'rigging',
      'sling',
      'suspended load',
      'lifting gear',
      'shackle',
      'hoist',
    ])) {
      final critical = _containsAny(text, [
        'person under load',
        'standing under load',
        'suspended load over person',
      ]);

      return _HazardResult(
        type: 'Unsafe Act',
        category: 'Lifting & Rigging',
        hazard: 'Lifting / Suspended Load Hazard',
        risk: critical ? 'Critical' : 'High',
        consequence: critical ? 'Fatality' : 'Serious injury',
        action:
            'Stop the lifting operation, establish an exclusion zone and keep personnel clear of suspended loads.',
      );
    }

    if (_containsAny(text, [
      'vehicle',
      'forklift',
      'truck',
      'reversing',
      'reverse',
      'pedestrian',
      'traffic',
      'mobile equipment',
    ])) {
      return const _HazardResult(
        type: 'Unsafe Act',
        category: 'Vehicle & Traffic Safety',
        hazard: 'Vehicle / Pedestrian Interaction',
        risk: 'High',
        consequence: 'Serious injury',
        action:
            'Separate pedestrians and vehicles and verify traffic controls before continuing.',
      );
    }

    if (_containsAny(text, [
      'chemical',
      'acid',
      'solvent',
      'chemical spill',
      'toxic',
      'corrosive',
    ])) {
      return const _HazardResult(
        type: 'Unsafe Condition',
        category: 'Chemical Safety',
        hazard: 'Chemical Exposure / Spill',
        risk: 'High',
        consequence: 'Serious injury',
        action:
            'Isolate the affected area, prevent exposure and control the spill using the approved procedure.',
      );
    }

    if (_containsAny(text, [
      'confined space',
      'tank entry',
      'manhole',
      'vessel entry',
      'confined',
    ])) {
      return const _HazardResult(
        type: 'Unsafe Act',
        category: 'Confined Space',
        hazard: 'Confined Space Entry Hazard',
        risk: 'Critical',
        consequence: 'Fatality',
        action:
            'Stop entry and verify permit, atmospheric testing, isolation, ventilation and rescue arrangements.',
      );
    }

    if (_containsAny(text, [
      'slip',
      'trip',
      'wet floor',
      'slippery',
      'obstruction',
      'blocked walkway',
      'poor housekeeping',
      'housekeeping',
      'debris',
    ])) {
      return const _HazardResult(
        type: 'Unsafe Condition',
        category: 'Housekeeping',
        hazard: 'Slip, Trip & Fall Hazard',
        risk: 'Medium',
        consequence: 'Injury',
        action:
            'Secure the area, remove the hazard and verify the walkway is safe.',
      );
    }

    if (_containsAny(text, [
      'manual handling',
      'heavy lifting',
      'heavy object',
      'awkward lifting',
      'lifting by hand',
    ])) {
      return const _HazardResult(
        type: 'Unsafe Act',
        category: 'Manual Handling',
        hazard: 'Manual Handling / Ergonomic Hazard',
        risk: 'Medium',
        consequence: 'Injury',
        action:
            'Use mechanical assistance where practicable and apply correct lifting technique.',
      );
    }

    if (_containsAny(text, [
      'machine',
      'machinery',
      'guard removed',
      'machine guard',
      'unguarded machine',
      'moving parts',
      'rotating',
      'conveyor',
    ])) {
      return const _HazardResult(
        type: 'Unsafe Condition',
        category: 'Machinery Safety',
        hazard: 'Machine Guarding / Moving Parts',
        risk: 'High',
        consequence: 'Serious injury',
        action:
            'Stop the machine where necessary, isolate it and restore the required guarding.',
      );
    }

    if (_containsAny(text, [
      'heat stress',
      'hot weather',
      'dehydration',
      'working in sun',
      'working under sun',
    ])) {
      return const _HazardResult(
        type: 'Unsafe Condition',
        category: 'Heat Stress',
        hazard: 'Heat Stress Exposure',
        risk: 'High',
        consequence: 'Serious injury',
        action:
            'Move the worker to a cool area, provide water and rest and follow heat-stress controls.',
      );
    }

    return const _HazardResult(
      type: 'Unsafe Condition',
      category: 'General Safety',
      hazard: 'General Workplace Hazard',
      risk: 'Medium',
      consequence: 'Injury',
      action:
          'Make the area safe, control the hazard and verify the corrective action.',
    );
  }

  bool _containsAny(String text, List<String> words) {
    return words.any(text.contains);
  }

  // ---------------------------------------------------------------------------
  // SUBMIT
  // ---------------------------------------------------------------------------

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

  void _submitObservation() {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _submitting = true);

    final id = _generateObservationId();
    final submittedAt = DateTime.now();

    Future<void>.delayed(
      const Duration(milliseconds: 500),
      () {
        if (!mounted) return;

        setState(() => _submitting = false);

        _showSuccessDialog(id, submittedAt);
      },
    );
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
      builder: (dialogContext) {
        return AlertDialog(
          icon: Icon(
            Icons.check_circle,
            color: Colors.green.shade700,
            size: 56,
          ),
          title: Text(
            _isMalayalam
                ? 'Observation Submitted'
                : 'Observation Submitted',
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _isMalayalam
                      ? 'Safety observation വിജയകരമായി രേഖപ്പെടുത്തി.'
                      : 'The safety observation has been recorded successfully.',
                ),
                const SizedBox(height: 18),
                _infoRow('Observation ID', id),
                _infoRow('Type', _observationType),
                _infoRow('Category', _category),
                _infoRow('Hazard', _hazardType),
                _infoRow('Risk', _riskLevel),
                _infoRow('Consequence', _potentialConsequence),
                _infoRow('Date & Time', date),
              ],
            ),
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

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 7),
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
          Expanded(child: Text(value)),
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
      _hazardType = 'General Workplace Hazard';
      _riskLevel = 'Medium';
      _potentialConsequence = 'Injury';
      _photo = null;
      _smartAnalysisDone = false;
    });
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // UI HELPERS
  // ---------------------------------------------------------------------------

  InputDecoration _decoration(
    String label, {
    String? hint,
    IconData? icon,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: icon == null ? null : Icon(icon),
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.primary,
          width: 2,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 15,
      ),
    );
  }

  Widget _sectionTitle(
    String title,
    IconData icon, {
    bool warning = false,
  }) {
    final color = warning
        ? _riskColor(_riskLevel)
        : Theme.of(context).colorScheme.primary;

    final background = warning
        ? _riskBackground(_riskLevel)
        : Theme.of(context).colorScheme.primaryContainer;

    return Row(
      children: [
        Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: background,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: color,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _readOnlyField({
    required String label,
    required String value,
    required IconData icon,
  }) {
    return InputDecorator(
      decoration: _decoration(
        label,
        icon: icon,
      ),
      child: Text(
        value,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _headerCard() {
    final ml = _isMalayalam;

    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          color: Theme.of(context).colorScheme.primaryContainer,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.health_and_safety,
              size: 42,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                ml
                    ? 'കണ്ട unsafe act / unsafe condition രേഖപ്പെടുത്തി HSE details ശരിയായി classify ചെയ്യുക.'
                    : 'Record the unsafe act or unsafe condition and match the HSE category, hazard, risk and corrective action.',
                style: const TextStyle(
                  fontSize: 14,
                  height: 1.45,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _analysisStatus() {
    if (!_smartAnalysisDone) {
      return const SizedBox.shrink();
    }

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: const Icon(
          Icons.auto_awesome,
          color: Colors.green,
        ),
        title: const Text(
          'Smart HSE Analysis Applied',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: const Text(
          'Category, hazard, risk and corrective action are linked to the observation.',
        ),
      ),
    );
  }

  Widget _riskCard() {
    final color = _riskColor(_riskLevel);

    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      color: _riskBackground(_riskLevel),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: color.withOpacity(0.35),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Icon(
              _riskIcon(_riskLevel),
              color: color,
              size: 30,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Current Risk Level',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _riskLevel,
                    style: TextStyle(
                      color: color,
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              _potentialConsequence,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _photoSection() {
    final ml = _isMalayalam;

    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.photo_camera_outlined),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    ml
                        ? 'Photo Evidence (Optional)'
                        : 'Photo Evidence (Optional)',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (_photo == null)
              InkWell(
                onTap: _showPhotoOptions,
                borderRadius: BorderRadius.circular(14),
                child: Container(
                  width: double.infinity,
                  height: 160,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: Theme.of(context)
                          .colorScheme
                          .outline
                          .withOpacity(0.5),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_a_photo_outlined,
                        size: 42,
                        color: Theme.of(context)
                            .colorScheme
                            .primary,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        ml
                            ? 'Photo ചേർക്കാൻ tap ചെയ്യുക'
                            : 'Tap to add photo',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Camera or Gallery',
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              )
            else
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Image.file(
                      File(_photo!.path),
                      width: double.infinity,
                      height: 190,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Material(
                      color: Colors.black87,
                      shape: const CircleBorder(),
                      child: IconButton(
                        tooltip: 'Remove Photo',
                        onPressed: _removePhoto,
                        icon: const Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                      ),
                    ),
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
                        color: Colors.black87,
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
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // BUILD
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Safety Observation'),
        centerTitle: false,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _headerCard(),
            const SizedBox(height: 22),

            _sectionTitle(
              'Observation Details',
              Icons.visibility_outlined,
            ),
            const SizedBox(height: 14),

            DropdownButtonFormField<String>(
              value: _observationType,
              decoration: _decoration(
                'Observation Type',
                icon: Icons.visibility_outlined,
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
                setState(() => _observationType = value);
              },
            ),

            const SizedBox(height: 14),

            TextFormField(
              controller: _locationController,
              decoration: _decoration(
                'Location / Area',
                hint: 'e.g. Workshop / Block A',
                icon: Icons.location_on_outlined,
              ),
            ),

            const SizedBox(height: 14),

            TextFormField(
              controller: _descriptionController,
              minLines: 4,
              maxLines: 7,
              onChanged: (_) {
                if (_smartAnalysisDone) {
                  setState(() => _smartAnalysisDone = false);
                }
              },
              decoration: _decoration(
                'Observation Description',
                hint: _isMalayalam
                    ? 'എന്താണ് കണ്ടത് എന്ന് വിശദീകരിക്കുക'
                    : 'Describe what you observed',
                icon: Icons.description_outlined,
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return _isMalayalam
                      ? 'Description നൽകുക'
                      : 'Please enter a description';
                }
                return null;
              },
            ),

            const SizedBox(height: 12),

            SizedBox(
              height: 48,
              child: OutlinedButton.icon(
                onPressed: _analyzing ? null : _analyzeObservation,
                icon: _analyzing
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      )
                    : const Icon(Icons.auto_awesome),
                label: Text(
                  _analyzing
                      ? 'Analyzing...'
                      : 'Analyze & Auto-Fill HSE Details',
                ),
              ),
            ),

            const SizedBox(height: 14),

            _analysisStatus(),

            DropdownButtonFormField<String>(
              value: _category,
              decoration: _decoration(
                'Category',
                icon: Icons.category_outlined,
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
                setState(() => _category = value);
              },
            ),

            const SizedBox(height: 14),

            _readOnlyField(
              label: 'Hazard / Unsafe Work',
              value: _hazardType,
              icon: Icons.report_problem_outlined,
            ),

            const SizedBox(height: 22),

            _sectionTitle(
              'Risk Assessment',
              _riskIcon(_riskLevel),
              warning: true,
            ),

            const SizedBox(height: 14),

            DropdownButtonFormField<String>(
              value: _riskLevel,
              decoration: _decoration(
                'Risk Level',
                icon: _riskIcon(_riskLevel),
              ).copyWith(
                filled: true,
                fillColor: _riskBackground(_riskLevel),
                prefixIconColor: _riskColor(_riskLevel),
              ),
              selectedItemBuilder: (context) {
                return _riskLevels.map(
                  (value) {
                    return Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        value,
                        style: TextStyle(
                          color: _riskColor(value),
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    );
                  },
                ).toList();
              },
              items: _riskLevels.map(
                (value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Row(
                      children: [
                        Icon(
                          _riskIcon(value),
                          size: 20,
                          color: _riskColor(value),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          value,
                          style: TextStyle(
                            color: _riskColor(value),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ).toList(),
              onChanged: (value) {
                if (value == null) return;
                _applyManualRisk(value);
              },
            ),

            const SizedBox(height: 10),

            _riskCard(),

            const SizedBox(height: 14),

            _readOnlyField(
              label: 'Potential Consequence',
              value: _potentialConsequence,
              icon: Icons.health_and_safety_outlined,
            ),

            const SizedBox(height: 14),

            TextFormField(
              controller: _actionController,
              minLines: 3,
              maxLines: 6,
              decoration: _decoration(
                'Corrective / Immediate Action',
                hint: 'Recommended action will appear here.',
                icon: Icons.build_circle_outlined,
              ),
            ),

            const SizedBox(height: 18),

            _photoSection(),

            const SizedBox(height: 24),

            SizedBox(
              height: 54,
              child: FilledButton.icon(
                onPressed: _submitting ? null : _submitObservation,
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

            const SizedBox(height: 28),
          ],
        ),
      ),
    );
  }
}

class _HazardResult {
  final String type;
  final String category;
  final String hazard;
  final String risk;
  final String consequence;
  final String action;

  const _HazardResult({
    required this.type,
    required this.category,
    required this.hazard,
    required this.risk,
    required this.consequence,
    required this.action,
  });
}
