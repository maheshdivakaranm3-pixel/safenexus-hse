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
  static const String _storageKey = 'safenexus_observations';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _descriptionController =
      TextEditingController();

  final TextEditingController _actionController =
      TextEditingController();

  final TextEditingController _locationController =
      TextEditingController();

  final ImagePicker _picker = ImagePicker();

  String _observationType = 'Unsafe Condition';
  String _category = 'General Safety';
  String _hazardType = 'Slip, Trip & Fall';
  String _riskLevel = 'Medium';
  String _potentialConsequence = 'Injury';

  XFile? _photo;

  bool _submitting = false;
  bool _analyzing = false;
  bool _smartAnalysisDone = false;

  bool get _isMalayalam =>
      Localizations.localeOf(context).languageCode == 'ml';

  // ============================================================
  // OPTIONS
  // ============================================================

  List<String> get _observationTypes => const [
        'Unsafe Act',
        'Unsafe Condition',
        'Positive Observation',
      ];

  List<String> get _categories => const [
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

  List<String> get _riskLevels => const [
        'Low',
        'Medium',
        'High',
        'Critical',
      ];

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
  // PHOTO PICKER
  // ============================================================

  Future<void> _pickPhoto(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        imageQuality: 80,
        maxWidth: 1600,
      );

      if (image == null || !mounted) {
        return;
      }

      setState(() {
        _photo = image;
        _smartAnalysisDone = false;
      });

      if (_descriptionController.text.trim().isNotEmpty) {
        await _analyzeObservation();
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
      builder: (sheetContext) {
        return SafeArea(
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
                    _isMalayalam
                        ? 'Photo നീക്കം ചെയ്യുക'
                        : 'Remove Photo',
                  ),
                  onTap: () {
                    Navigator.pop(sheetContext);

                    setState(() {
                      _photo = null;
                      _smartAnalysisDone = false;
                    });
                  },
                ),
            ],
          ),
        );
      },
    );
  }

  // ============================================================
  // SMART ANALYSIS
  // ============================================================

  Future<void> _analyzeObservation() async {
    final String text =
        _descriptionController.text.trim().toLowerCase();

    if (text.isEmpty) {
      _showMessage(
        _isMalayalam
            ? 'ആദ്യം observation description നൽകുക.'
            : 'Enter an observation description first.',
      );
      return;
    }

    if (_analyzing) {
      return;
    }

    setState(() {
      _analyzing = true;
    });

    await Future<void>.delayed(
      const Duration(milliseconds: 350),
    );

    final _HazardResult result = _classifyHazard(text);

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
          ? 'Observation അനുസരിച്ച് HSE details update ചെയ്തു.'
          : 'HSE details updated from the observation.',
    );
  }

  // ============================================================
  // HAZARD CLASSIFICATION
  // ============================================================

  _HazardResult _classifyHazard(String text) {
    // ----------------------------------------------------------
    // WORK AT HEIGHT
    // ----------------------------------------------------------

    if (_containsAny(text, [
      'fall from height',
      'fell from height',
      'working at height',
      'work at height',
      'height',
      'roof',
      'ladder',
      'edge',
      'unguarded edge',
      'no harness',
      'without harness',
      'no fall protection',
      'without fall protection',
      'scaffold',
      'scaffolding',
    ])) {
      final bool critical = _containsAny(text, [
        'fell from height',
        'fall from height',
        'no fall protection',
        'without fall protection',
        'unguarded edge',
      ]);

      return _HazardResult(
        type: 'Unsafe Act',
        category: text.contains('scaffold') ||
                text.contains('scaffolding')
            ? 'Scaffolding'
            : 'Work at Height',
        hazard: text.contains('ladder')
            ? 'Unsafe Ladder Use'
            : 'Fall from Height',
        risk: critical ? 'Critical' : 'High',
        consequence: critical ? 'Fatality' : 'Serious injury',
        action:
            'Stop the unsafe work, barricade the area, provide suitable fall protection, and allow work to resume only after the control measures are verified.',
      );
    }

    // ----------------------------------------------------------
    // PPE
    // ----------------------------------------------------------

    if (_containsAny(text, [
      'no helmet',
      'without helmet',
      'helmet not worn',
      'no safety helmet',
      'no gloves',
      'without gloves',
      'no goggles',
      'without goggles',
      'no safety shoes',
      'without safety shoes',
      'ppe not worn',
      'ppe',
    ])) {
      return const _HazardResult(
        type: 'Unsafe Act',
        category: 'PPE',
        hazard: 'Inadequate / Missing PPE',
        risk: 'Medium',
        consequence: 'Injury',
        action:
            'Stop the task where necessary and ensure the worker wears the required PPE before continuing the work.',
      );
    }

    // ----------------------------------------------------------
    // ELECTRICAL
    // ----------------------------------------------------------

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
      'shock',
    ])) {
      final bool critical = _containsAny(text, [
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
            'Isolate the electrical source by an authorized competent person, barricade the area, and rectify the electrical defect before work resumes.',
      );
    }

    // ----------------------------------------------------------
    // FIRE
    // ----------------------------------------------------------

    if (_containsAny(text, [
      'fire',
      'flammable',
      'hot work',
      'gas cylinder',
      'oxygen cylinder',
      'fire extinguisher',
      'blocked extinguisher',
      'combustible',
      'ignition',
    ])) {
      return const _HazardResult(
        type: 'Unsafe Condition',
        category: 'Fire Safety',
        hazard: 'Fire / Ignition Hazard',
        risk: 'High',
        consequence: 'Serious injury',
        action:
            'Remove or control the ignition source, keep combustible materials away, maintain required fire protection, and verify the area before continuing work.',
      );
    }

    // ----------------------------------------------------------
    // LIFTING & RIGGING
    // ----------------------------------------------------------

    if (_containsAny(text, [
      'lifting',
      'crane',
      'rigging',
      'sling',
      'suspended load',
      'load suspended',
      'lifting gear',
      'shackle',
      'hoist',
    ])) {
      final bool critical = _containsAny(text, [
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
            'Stop the lifting operation, establish an exclusion zone, keep personnel clear of suspended loads, and verify lifting equipment and the lifting plan before restarting.',
      );
    }

    // ----------------------------------------------------------
    // VEHICLE & TRAFFIC
    // ----------------------------------------------------------

    if (_containsAny(text, [
      'vehicle',
      'forklift',
      'truck',
      'reversing',
      'reverse',
      'pedestrian',
      'traffic',
      'mobile equipment',
      'seat belt',
      'seatbelt',
      'banksman',
    ])) {
      return const _HazardResult(
        type: 'Unsafe Act',
        category: 'Vehicle & Traffic Safety',
        hazard: 'Vehicle / Pedestrian Interaction',
        risk: 'High',
        consequence: 'Serious injury',
        action:
            'Stop the unsafe movement, separate pedestrians and vehicles, use designated routes and a trained banksman where required, and verify traffic controls.',
      );
    }

    // ----------------------------------------------------------
    // CHEMICAL
    // ----------------------------------------------------------

    if (_containsAny(text, [
      'chemical',
      'acid',
      'solvent',
      'chemical spill',
      'spill',
      'toxic',
      'corrosive',
      'chemical exposure',
    ])) {
      return const _HazardResult(
        type: 'Unsafe Condition',
        category: 'Chemical Safety',
        hazard: 'Chemical Exposure / Spill',
        risk: 'High',
        consequence: 'Serious injury',
        action:
            'Isolate the affected area, prevent exposure, use the required PPE and spill controls, and clean up or contain the material using the approved procedure.',
      );
    }

    // ----------------------------------------------------------
    // CONFINED SPACE
    // ----------------------------------------------------------

    if (_containsAny(text, [
      'confined space',
      'tank entry',
      'manhole',
      'vessel entry',
      'confined',
      'entry into tank',
    ])) {
      return const _HazardResult(
        type: 'Unsafe Act',
        category: 'Confined Space',
        hazard: 'Confined Space Entry Hazard',
        risk: 'Critical',
        consequence: 'Fatality',
        action:
            'Stop entry, secure the space, verify the permit, atmospheric testing, isolation, ventilation, communication and rescue arrangements before entry.',
      );
    }

    // ----------------------------------------------------------
    // SLIP / TRIP / HOUSEKEEPING
    // ----------------------------------------------------------

    if (_containsAny(text, [
      'slip',
      'trip',
      'fallen',
      'fell',
      'lying on floor',
      'lying on the floor',
      'wet floor',
      'slippery',
      'obstruction',
      'blocked walkway',
      'poor housekeeping',
      'housekeeping',
      'debris',
      'loose material',
    ])) {
      final bool serious = _containsAny(text, [
        'fell',
        'fallen',
        'lying on floor',
        'lying on the floor',
        'person fell',
        'worker fell',
      ]);

      return _HazardResult(
        type: 'Unsafe Condition',
        category:
            serious ? 'Slip, Trip & Fall' : 'Housekeeping',
        hazard: 'Slip, Trip & Fall Hazard',
        risk: serious ? 'High' : 'Medium',
        consequence: serious ? 'Serious injury' : 'Injury',
        action:
            'Secure the area, remove the slip/trip hazard, provide warning or barricading where required, and inspect the area before allowing normal work to continue.',
      );
    }

    // ----------------------------------------------------------
    // MANUAL HANDLING
    // ----------------------------------------------------------

    if (_containsAny(text, [
      'manual handling',
      'lifting by hand',
      'heavy lifting',
      'heavy object',
      'awkward lifting',
      'manual lift',
      'back posture',
      'ergonomic',
    ])) {
      return const _HazardResult(
        type: 'Unsafe Act',
        category: 'Manual Handling',
        hazard: 'Manual Handling / Ergonomic Hazard',
        risk: 'Medium',
        consequence: 'Injury',
        action:
            'Use suitable mechanical assistance where practicable, apply correct lifting technique, and reduce the load or improve the handling method.',
      );
    }

    // ----------------------------------------------------------
    // MACHINERY
    // ----------------------------------------------------------

    if (_containsAny(text, [
      'machine',
      'machinery',
      'guard removed',
      'machine guard',
      'unguarded machine',
      'moving parts',
      'rotating',
      'conveyor',
      'machine guarding',
    ])) {
      return const _HazardResult(
        type: 'Unsafe Condition',
        category: 'Machinery Safety',
        hazard: 'Machine Guarding / Moving Parts',
        risk: 'High',
        consequence: 'Serious injury',
        action:
            'Stop the machine if there is immediate danger, isolate it as required, restore the guarding and verify the machine is safe before operation.',
      );
    }

    // ----------------------------------------------------------
    // HEAT STRESS
    // ----------------------------------------------------------

    if (_containsAny(text, [
      'heat stress',
      'hot weather',
      'dehydration',
      'heat',
      'working in sun',
      'working under sun',
      'sun exposure',
      'high temperature',
    ])) {
      return const _HazardResult(
        type: 'Unsafe Condition',
        category: 'Heat Stress',
        hazard: 'Heat Stress Exposure',
        risk: 'High',
        consequence: 'Serious injury',
        action:
            'Move the worker to a cool or shaded area, provide drinking water and rest, follow heat-stress controls, and assess the worker if symptoms are present.',
      );
    }

    // ----------------------------------------------------------
    // ENVIRONMENT
    // ----------------------------------------------------------

    if (_containsAny(text, [
      'environment',
      'dust',
      'air pollution',
      'noise',
      'waste',
      'environmental',
    ])) {
      return const _HazardResult(
        type: 'Unsafe Condition',
        category: 'Environmental Safety',
        hazard: 'Environmental Exposure',
        risk: 'Medium',
        consequence: 'Environmental impact',
        action:
            'Control the environmental hazard, prevent unnecessary exposure, maintain housekeeping and waste controls, and verify the area is compliant.',
      );
    }

    // ----------------------------------------------------------
    // PERMIT TO WORK
    // ----------------------------------------------------------

    if (_containsAny(text, [
      'permit',
      'ptw',
      'permit to work',
      'work permit',
      'expired permit',
    ])) {
      return const _HazardResult(
        type: 'Unsafe Condition',
        category: 'Permit to Work',
        hazard: 'Permit / Authorization Deficiency',
        risk: 'High',
        consequence: 'Serious injury',
        action:
            'Stop the affected work, verify the applicable permit and controls with the responsible authority, and resume only after authorization is confirmed.',
      );
    }

    // ----------------------------------------------------------
    // POSITIVE OBSERVATION
    // ----------------------------------------------------------

    if (_containsAny(text, [
      'safe work',
      'good practice',
      'good safety',
      'proper ppe',
      'wearing ppe',
      'safety compliance',
      'safe behavior',
      'safe behaviour',
      'excellent housekeeping',
    ])) {
      return const _HazardResult(
        type: 'Positive Observation',
        category: 'General Safety',
        hazard: 'Positive Safety Practice',
        risk: 'Low',
        consequence: 'Minor injury',
        action:
            'Recognize the positive behavior and encourage the team to maintain the same safe practice.',
      );
    }

    // ----------------------------------------------------------
    // DEFAULT
    // ----------------------------------------------------------

    return const _HazardResult(
      type: 'Unsafe Condition',
      category: 'General Safety',
      hazard: 'General Workplace Hazard',
      risk: 'Medium',
      consequence: 'Injury',
      action:
          'Make the area safe, control the identified hazard, communicate the corrective action to the responsible person, and verify closure.',
    );
  }

  bool _containsAny(
    String text,
    List<String> words,
  ) {
    return words.any(text.contains);
  }

  // ============================================================
  // RISK
  // ============================================================

  void _applyManualRisk(String value) {
    setState(() {
      _riskLevel = value;
      _potentialConsequence =
          _consequenceForRisk(value);
    });
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

  // ============================================================
  // OBSERVATION ID
  // ============================================================

  String _generateObservationId() {
    final DateTime now = DateTime.now();

    final String stamp =
        '${now.year}'
        '${now.month.toString().padLeft(2, '0')}'
        '${now.day.toString().padLeft(2, '0')}'
        '${now.hour.toString().padLeft(2, '0')}'
        '${now.minute.toString().padLeft(2, '0')}'
        '${now.second.toString().padLeft(2, '0')}';

    return 'OBS-$stamp';
  }

  // ============================================================
  // SAVE OBSERVATION
  // ============================================================

  Future<void> _saveObservation({
    required String id,
    required DateTime submittedAt,
  }) async {
    try {
      final SharedPreferences prefs =
          await SharedPreferences.getInstance();

      final List<String> existing =
          prefs.getStringList(_storageKey) ??
              <String>[];

      final Map<String, dynamic> observation = {
        'id': id,
        'dateTime': submittedAt.toIso8601String(),
        'type': _observationType,
        'category': _category,
        'hazard': _hazardType,
        'risk': _riskLevel,
        'consequence': _potentialConsequence,
        'description':
            _descriptionController.text.trim(),
        'action': _actionController.text.trim(),
        'location':
            _locationController.text.trim(),
        'photoPath': _photo?.path ?? '',
        'status': 'Open',
      };

      existing.insert(
        0,
        jsonEncode(observation),
      );

      await prefs.setStringList(
        _storageKey,
        existing,
      );
    } catch (_) {
      // Submission should not fail
      // because of local storage.
    }
  }

  // ============================================================
  // SUBMIT
  // ============================================================

  Future<void> _submitObservation() async {
    if (_submitting) {
      return;
    }

    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_descriptionController.text
        .trim()
        .isEmpty) {
      _showMessage(
        _isMalayalam
            ? 'Observation Description നൽകുക.'
            : 'Please enter an observation description.',
      );
      return;
    }

    FocusScope.of(context).unfocus();

    setState(() {
      _submitting = true;
    });

    final String observationId =
        _generateObservationId();

    final DateTime submittedAt =
        DateTime.now();

    await _saveObservation(
      id: observationId,
      submittedAt: submittedAt,
    );

    if (!mounted) {
      return;
    }

    setState(() {
      _submitting = false;
    });

    await _showSuccessDialog(
      observationId,
      submittedAt,
    );
  }

  // ============================================================
  // SUCCESS DIALOG
  // ============================================================

  Future<void> _showSuccessDialog(
    String id,
    DateTime submittedAt,
  ) async {
    final String date =
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
          icon: const Icon(
            Icons.check_circle,
            color: Colors.green,
            size: 58,
          ),
          title: Text(
            _isMalayalam
                ? 'Observation Submitted'
                : 'Observation Submitted',
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment:
                  CrossAxisAlignment.start,
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
                ),
                _infoRow(
                  'Type',
                  _observationType,
                ),
                _infoRow(
                  'Category',
                  _category,
                ),
                _infoRow(
                  'Hazard',
                  _hazardType,
                ),
                _infoRow(
                  'Risk',
                  _riskLevel,
                ),
                _infoRow(
                  'Consequence',
                  _potentialConsequence,
                ),
                _infoRow(
                  'Date & Time',
                  date,
                ),
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

  Widget _infoRow(
    String label,
    String value,
  ) {
    return Padding(
      padding:
          const EdgeInsets.only(bottom: 7),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,
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
            child: Text(value),
          ),
        ],
      ),
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
      _category = 'General Safety';
      _hazardType =
          'Slip, Trip & Fall';
      _riskLevel = 'Medium';
      _potentialConsequence = 'Injury';

      _photo = null;

      _smartAnalysisDone = false;
      _analyzing = false;
      _submitting = false;
    });
  }

  // ============================================================
  // MESSAGE
  // ============================================================

  void _showMessage(String message) {
    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(
        content: Text(message),
        behavior:
            SnackBarBehavior.floating,
      ),
    );
  }

  // ============================================================
  // INPUT DECORATION
  // ============================================================

  InputDecoration _decoration(
    String label, {
    String? hint,
    IconData? icon,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon:
          icon == null ? null : Icon(icon),
      border: OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(14),
      ),
      enabledBorder:
          OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(14),
      ),
      focusedBorder:
          OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(14),
        borderSide: BorderSide(
          color: Theme.of(context)
              .colorScheme
              .primary,
          width: 2,
        ),
      ),
      filled: true,
    );
  }

  // ============================================================
  // SECTION TITLE
  // ============================================================

  Widget _sectionTitle(
    String title,
    IconData icon, {
    bool warning = false,
  }) {
    return Row(
      children: [
        CircleAvatar(
          radius: 24,
          child: Icon(
            icon,
            color: warning
                ? Colors.orange.shade800
                : null,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 21,
              fontWeight:
                  FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // ANALYSIS STATUS
  // ============================================================

  Widget _analysisStatus() {
    if (!_smartAnalysisDone) {
      return const SizedBox.shrink();
    }

    return Card(
      elevation: 0,
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
        subtitle: Text(
          _isMalayalam
              ? 'Category, hazard, risk, consequence, corrective action എന്നിവ observation അനുസരിച്ച് update ചെയ്തു.'
              : 'Category, hazard, risk, consequence and corrective action were matched to the observation.',
        ),
      ),
    );
  }

  // ============================================================
  // HEADER CARD
  // ============================================================

  Widget _headerCard(bool ml) {
    return Card(
      elevation: 0,
      child: Container(
        padding:
            const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(16),
          color: Theme.of(context)
              .colorScheme
              .primaryContainer,
        ),
        child: Row(
          crossAxisAlignment:
              CrossAxisAlignment.start,
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
                    ? 'Unsafe act, unsafe condition, positive observation എന്നിവ രേഖപ്പെടുത്തി HSE details ശരിയായി classify ചെയ്യുക.'
                    : 'Record unsafe acts, unsafe conditions and positive safety observations. Smart analysis will match the HSE details.',
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

  // ============================================================
  // READ ONLY FIELD
  // ============================================================

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
          fontWeight:
              FontWeight.w600,
        ),
      ),
    );
  }

  // ============================================================
  // PHOTO SECTION
  // ============================================================

  Widget _photoSection(bool ml) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Text(
          'Photo Evidence (Optional)',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: _showPhotoOptions,
          borderRadius:
              BorderRadius.circular(14),
          child: Container(
            width: double.infinity,
            height: 170,
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(14),
              border: Border.all(
                color:
                    Colors.grey.shade400,
              ),
            ),
            clipBehavior:
                Clip.antiAlias,
            child: _photo == null
                ? Column(
                    mainAxisAlignment:
                        MainAxisAlignment
                            .center,
                    children: [
                      Icon(
                        Icons
                            .add_a_photo_outlined,
                        size: 42,
                        color:
                            Colors.grey.shade600,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        ml
                            ? 'Photo ചേർക്കാൻ tap ചെയ്യുക'
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
                        errorBuilder:
                            (
                          context,
                          error,
                          stackTrace,
                        ) {
                          return const Center(
                            child: Icon(
                              Icons
                                  .broken_image_outlined,
                              size: 48,
                            ),
                          );
                        },
                      ),
                      Positioned(
                        left: 10,
                        bottom: 10,
                        child: Container(
                          padding:
                              const EdgeInsets
                                  .symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),
                          decoration:
                              BoxDecoration(
                            color:
                                Colors.black87,
                            borderRadius:
                                BorderRadius
                                    .circular(
                              20,
                            ),
                          ),
                          child: const Text(
                            'Photo selected',
                            style: TextStyle(
                              color:
                                  Colors.white,
                              fontWeight:
                                  FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 8,
                        top: 8,
                        child: CircleAvatar(
                          backgroundColor:
                              Colors.black54,
                          child: IconButton(
                            color:
                                Colors.white,
                            icon: const Icon(
                              Icons.close,
                            ),
                            onPressed: () {
                              setState(() {
                                _photo = null;
                                _smartAnalysisDone =
                                    false;
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

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    final bool ml = _isMalayalam;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          ml
              ? 'Safety Observation'
              : 'Safety Observation',
        ),
        actions: [
          PopupMenuButton<Locale>(
            icon:
                const Icon(Icons.language),
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
          padding:
              const EdgeInsets.all(16),
          children: [
            // ==================================================
            // HEADER
            // ==================================================

            _headerCard(ml),

            const SizedBox(height: 18),

            // ==================================================
            // OBSERVATION DETAILS
            // ==================================================

            _sectionTitle(
              'Observation Details',
              Icons.visibility,
            ),

            const SizedBox(height: 14),

            DropdownButtonFormField<String>(
              key: ValueKey(
                'observation_$_observationType',
              ),
              initialValue:
                  _observationType,
              decoration: _decoration(
                'Observation Type',
                icon: Icons.visibility,
              ),
              items: _observationTypes
                  .map(
                    (String value) =>
                        DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    ),
                  )
                  .toList(),
              onChanged:
                  (String? value) {
                if (value == null) {
                  return;
                }

                setState(() {
                  _observationType =
                      value;
                });
              },
            ),

            const SizedBox(height: 14),

            // ==================================================
            // LOCATION
            // ==================================================

            TextFormField(
              controller:
                  _locationController,
              textInputAction:
                  TextInputAction.next,
              decoration: _decoration(
                'Location / Area',
                hint:
                    'e.g. Workshop / Block A',
                icon: Icons
                    .location_on_outlined,
              ),
            ),

            const SizedBox(height: 14),

            // ==================================================
            // DESCRIPTION
            // ==================================================

            TextFormField(
              controller:
                  _descriptionController,
              minLines: 4,
              maxLines: 7,
              textInputAction:
                  TextInputAction.newline,
              onChanged: (_) {
                if (_smartAnalysisDone) {
                  setState(() {
                    _smartAnalysisDone =
                        false;
                  });
                }
              },
              decoration: _decoration(
                'Observation Description',
                hint:
                    'Describe the unsafe act or unsafe condition',
                icon:
                    Icons.description,
              ),
              validator: (String? value) {
                if (value == null ||
                    value.trim().isEmpty) {
                  return 'Please enter a description';
                }

                return null;
              },
            ),

            const SizedBox(height: 10),

            // ==================================================
            // ANALYZE
            // ==================================================

            SizedBox(
              height: 48,
              child: OutlinedButton.icon(
                onPressed: _analyzing
                    ? null
                    : _analyzeObservation,
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
                        Icons.auto_awesome,
                      ),
                label: Text(
                  _analyzing
                      ? 'Analyzing...'
                      : 'Analyze & Auto-Fill HSE Details',
                ),
              ),
            ),

            const SizedBox(height: 14),

            _analysisStatus(),

            const SizedBox(height: 4),

            // ==================================================
            // CATEGORY
            // ==================================================

            DropdownButtonFormField<String>(
              key: ValueKey(
                'category_$_category',
              ),
              initialValue: _category,
              decoration: _decoration(
                'Category',
                icon: Icons.category,
              ),
              items: _categories
                  .map(
                    (String value) =>
                        DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    ),
                  )
                  .toList(),
              onChanged:
                  (String? value) {
                if (value == null) {
                  return;
                }

                setState(() {
                  _category = value;
                });
              },
            ),

            const SizedBox(height: 14),

            // ==================================================
            // HAZARD
            // ==================================================

            _readOnlyField(
              label:
                  'Hazard / Unsafe Work',
              value: _hazardType,
              icon: Icons
                  .report_problem_outlined,
            ),

            const SizedBox(height: 18),

            // ==================================================
            // RISK ASSESSMENT
            // ==================================================

            _sectionTitle(
              'Risk Assessment',
              Icons.warning_amber,
              warning: true,
            ),

            const SizedBox(height: 14),

            DropdownButtonFormField<String>(
              key: ValueKey(
                'risk_$_riskLevel',
              ),
              initialValue: _riskLevel,
              decoration: _decoration(
                'Risk Level',
                icon:
                    Icons.warning_amber,
              ),
              items: _riskLevels
                  .map(
                    (String value) =>
                        DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    ),
                  )
                  .toList(),
              onChanged:
                  (String? value) {
                if (value == null) {
                  return;
                }

                _applyManualRisk(value);
              },
            ),

            const SizedBox(height: 14),

            // ==================================================
            // CONSEQUENCE
            // ==================================================

            _readOnlyField(
              label:
                  'Potential Consequence',
              value:
                  _potentialConsequence,
              icon: Icons
                  .health_and_safety_outlined,
            ),

            const SizedBox(height: 14),

            // ==================================================
            // CORRECTIVE ACTION
            // ==================================================

            TextFormField(
              controller:
                  _actionController,
              minLines: 3,
              maxLines: 6,
              decoration: _decoration(
                'Corrective / Immediate Action',
                hint:
                    'Recommended action will be generated automatically.',
                icon: Icons
                    .build_circle_outlined,
              ),
            ),

            const SizedBox(height: 18),

            // ==================================================
            // PHOTO
            // ==================================================

            _photoSection(ml),

            const SizedBox(height: 24),

            // ==================================================
            // SUBMIT
            // ==================================================

            SizedBox(
              height: 54,
              child: FilledButton.icon(
                onPressed: _submitting
                    ? null
                    : _submitObservation,
                icon: _submitting
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child:
                            CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      )
                    : const Icon(
                        Icons.send,
                      ),
                label: Text(
                  _submitting
                      ? 'Submitting...'
                      : 'Submit Observation',
                ),
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

// ================================================================
// HAZARD RESULT MODEL
// ================================================================

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
