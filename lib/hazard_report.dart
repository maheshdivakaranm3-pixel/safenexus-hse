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
  String _hazardType = 'Slip, Trip & Fall';
  String _riskLevel = 'Medium';
  String _potentialConsequence = 'Injury';
  String _correctiveAction = '';

  XFile? _photo;

  bool _submitting = false;
  bool _analyzing = false;
  bool _smartAnalysisDone = false;

  bool get _isMalayalam =>
      Localizations.localeOf(context).languageCode == 'ml';

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

  List<String> get _consequences => const [
        'Minor injury',
        'Injury',
        'Serious injury',
        'Fatality',
        'Property damage',
        'Environmental impact',
        'Multiple serious injuries',
      ];

  Color _riskColor(String risk) {
    switch (risk) {
      case 'Low':
        return Colors.green;
      case 'Medium':
        return Colors.orange;
      case 'High':
        return Colors.red;
      case 'Critical':
        return Colors.red.shade900;
      default:
        return Theme.of(context).colorScheme.primary;
    }
  }

  Color _riskBackgroundColor(String risk) {
    switch (risk) {
      case 'Low':
        return Colors.green.withOpacity(0.08);
      case 'Medium':
        return Colors.orange.withOpacity(0.10);
      case 'High':
        return Colors.red.withOpacity(0.08);
      case 'Critical':
        return Colors.red.withOpacity(0.14);
      default:
        return Theme.of(context).colorScheme.surfaceVariant;
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
        return Icons.warning_amber_outlined;
    }
  }

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
          _smartAnalysisDone = false;
        });

        if (_descriptionController.text.trim().isNotEmpty) {
          await _analyzeObservation();
        }
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
                title: const Text('Remove Photo'),
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
      ),
    );
  }

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
      _correctiveAction = result.action;
      _smartAnalysisDone = true;
      _analyzing = false;

      if (_actionController.text.trim().isEmpty) {
        _actionController.text = result.action;
      }
    });

    _showMessage(
      _isMalayalam
          ? 'Observation അനുസരിച്ച് Category, Risk, Action update ചെയ്തു.'
          : 'Category, Risk and Corrective Action updated from the observation.',
    );
  }

  _HazardResult _classifyHazard(String text) {
    if (_containsAny(text, [
      'fall from height',
      'fell from height',
      'working at height',
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
      return _HazardResult(
        type: 'Unsafe Act',
        category: 'PPE',
        hazard: 'Inadequate / Missing PPE',
        risk: 'Medium',
        consequence: 'Injury',
        action:
            'Stop the task where necessary and ensure the worker wears the required PPE before continuing the work.',
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

    if (_containsAny(text, [
      'fire',
      'flammable',
      'hot work',
      'gas cylinder',
      'oxygen cylinder',
      'fire extinguisher',
      'blocked extinguisher',
      'combustible',
    ])) {
      return _HazardResult(
        type: 'Unsafe Condition',
        category: 'Fire Safety',
        hazard: 'Fire / Ignition Hazard',
        risk: 'High',
        consequence: 'Serious injury',
        action:
            'Remove or control the ignition source, keep combustible materials away, maintain required fire protection, and verify the area before continuing work.',
      );
    }

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
    ])) {
      return _HazardResult(
        type: 'Unsafe Act',
        category: 'Vehicle & Traffic Safety',
        hazard: 'Vehicle / Pedestrian Interaction',
        risk: 'High',
        consequence: 'Serious injury',
        action:
            'Stop the unsafe movement, separate pedestrians and vehicles, use designated routes and a trained banksman where required, and verify traffic controls.',
      );
    }

    if (_containsAny(text, [
      'chemical',
      'acid',
      'solvent',
      'chemical spill',
      'spill',
      'toxic',
      'corrosive',
    ])) {
      return _HazardResult(
        type: 'Unsafe Condition',
        category: 'Chemical Safety',
        hazard: 'Chemical Exposure / Spill',
        risk: 'High',
        consequence: 'Serious injury',
        action:
            'Isolate the affected area, prevent exposure, use the required PPE and spill controls, and clean up or contain the material using the approved procedure.',
      );
    }

    if (_containsAny(text, [
      'confined space',
      'tank entry',
      'manhole',
      'vessel entry',
      'confined',
    ])) {
      return _HazardResult(
        type: 'Unsafe Act',
        category: 'Confined Space',
        hazard: 'Confined Space Entry Hazard',
        risk: 'Critical',
        consequence: 'Fatality',
        action:
            'Stop entry, secure the space, verify the permit, atmospheric testing, isolation, ventilation, communication and rescue arrangements before entry.',
      );
    }

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
        category: serious
            ? 'Slip, Trip & Fall'
            : 'Housekeeping',
        hazard: 'Slip, Trip & Fall Hazard',
        risk: serious ? 'High' : 'Medium',
        consequence:
            serious ? 'Serious injury' : 'Injury',
        action:
            'Secure the area, remove the slip/trip hazard, provide warning or barricading where required, and inspect the area before allowing normal work to continue.',
      );
    }

    if (_containsAny(text, [
      'manual handling',
      'lifting by hand',
      'heavy lifting',
      'heavy object',
      'awkward lifting',
      'manual lift',
      'back posture',
    ])) {
      return _HazardResult(
        type: 'Unsafe Act',
        category: 'Manual Handling',
        hazard: 'Manual Handling / Ergonomic Hazard',
        risk: 'Medium',
        consequence: 'Injury',
        action:
            'Use suitable mechanical assistance where practicable, apply correct lifting technique, and reduce the load or improve the handling method.',
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
      return _HazardResult(
        type: 'Unsafe Condition',
        category: 'Machinery Safety',
        hazard: 'Machine Guarding / Moving Parts',
        risk: 'High',
        consequence: 'Serious injury',
        action:
            'Stop the machine if there is immediate danger, isolate it as required, restore the guarding and verify the machine is safe before operation.',
      );
    }

    if (_containsAny(text, [
      'heat stress',
      'hot weather',
      'dehydration',
      'heat',
      'working in sun',
      'working under sun',
    ])) {
      return _HazardResult(
        type: 'Unsafe Condition',
        category: 'Heat Stress',
        hazard: 'Heat Stress Exposure',
        risk: 'High',
        consequence: 'Serious injury',
        action:
            'Move the worker to a cool or shaded area, provide drinking water and rest, follow heat-stress controls, and assess the worker if symptoms are present.',
      );
    }

    return _HazardResult(
      type: 'Unsafe Condition',
      category: 'General Safety',
      hazard: 'General Workplace Hazard',
      risk: 'Medium',
      consequence: 'Injury',
      action:
          'Make the area safe, control the identified hazard, communicate the corrective action to the responsible person, and verify closure.',
    );
  }

  bool _containsAny(String text, List<String> words) {
    return words.any(text.contains);
  }

  void _applyManualRisk(String value) {
    setState(() {
      _riskLevel = value;
      _potentialConsequence = _consequenceForRisk(value);
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
