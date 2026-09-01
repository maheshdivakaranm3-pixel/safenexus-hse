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

  String _category = 'Unsafe Condition';
  String _hazardType = 'General Workplace Hazard';
  String _riskLevel = 'Medium';
  String _potentialConsequence = 'Injury';
  String _status = 'Open';

  bool _isSaving = false;
  bool _isAnalyzing = false;
  bool _smartAnalysisDone = false;

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

  // ============================================================
  // PHOTO PICKING
  // ============================================================

  Future<void> _pickBeforePhoto(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: 85,
        maxWidth: 1600,
      );

      if (pickedFile == null) return;

      if (!mounted) return;

      setState(() {
        _beforePhoto = File(pickedFile.path);
        _smartAnalysisDone = false;
      });

      /*
       * Phase 1:
       * Photo is selected and the user can enter/review the
       * observation description.
       *
       * Phase 2:
       * Real Vision AI will analyse this photo.
       */
    } catch (_) {
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

      if (!mounted) return;

      setState(() {
        _afterPhoto = File(pickedFile.path);
      });
    } catch (_) {
      _showMessage('Unable to select after photo.');
    }
  }

  // ============================================================
  // SMART HSE ANALYSIS
  // ============================================================

  Future<void> _analyzeObservation() async {
    final String text =
        _descriptionController.text.trim().toLowerCase();

    if (text.isEmpty) {
      _showMessage(
        'First enter the unsafe act or unsafe condition.',
      );
      return;
    }

    setState(() {
      _isAnalyzing = true;
    });

    await Future<void>.delayed(
      const Duration(milliseconds: 350),
    );

    final _HseAnalysis result = _classifyObservation(text);

    if (!mounted) return;

    setState(() {
      _category = result.category;
      _hazardType = result.hazard;
      _riskLevel = result.risk;
      _potentialConsequence = result.consequence;

      _immediateActionController.text =
          result.immediateAction;

      _correctiveActionController.text =
          result.correctiveAction;

      _smartAnalysisDone = true;
      _isAnalyzing = false;
    });

    _showMessage(
      'HSE details automatically updated.',
    );
  }

  _HseAnalysis _classifyObservation(String text) {
    // ----------------------------------------------------------
    // WORK AT HEIGHT
    // ----------------------------------------------------------

    if (_containsAny(text, [
      'working at height',
      'work at height',
      'fall from height',
      'fell from height',
      'falling from height',
      'height',
      'roof',
      'roof edge',
      'open edge',
      'unguarded edge',
      'ladder',
      'unsafe ladder',
      'no harness',
      'without harness',
      'no fall protection',
      'without fall protection',
      'fall protection',
    ])) {
      final bool critical = _containsAny(text, [
        'fall from height',
        'fell from height',
        'falling from height',
        'no fall protection',
        'without fall protection',
        'unguarded edge',
        'open edge',
      ]);

      return _HseAnalysis(
        category: 'Work at Height',
        hazard: 'Fall from Height',
        risk: critical ? 'Critical' : 'High',
        consequence:
            critical ? 'Fatality' : 'Serious injury',
        immediateAction:
            'Stop the unsafe work and secure the area. Prevent workers from approaching the exposed edge or height hazard.',
        correctiveAction:
            'Provide suitable fall protection, safe access, edge protection and required PPE. Verify controls before work resumes.',
      );
    }

    // ----------------------------------------------------------
    // SCAFFOLDING
    // ----------------------------------------------------------

    if (_containsAny(text, [
      'scaffold',
      'scaffolding',
      'unsafe scaffold',
      'scaffold missing guardrail',
      'missing guardrail',
      'scaffold platform',
    ])) {
      return _HseAnalysis(
        category: 'Scaffolding',
        hazard: 'Unsafe Scaffolding',
        risk: 'High',
        consequence: 'Serious injury',
        immediateAction:
            'Stop use of the scaffold and restrict access until it is inspected by a competent person.',
        correctiveAction:
            'Provide proper guardrails, toe boards, access and stable working platforms. Ensure scaffold inspection and tagging are completed.',
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
      'no ppe',
      'without ppe',
      'ppe not worn',
      'ppe missing',
      'ppe violation',
    ])) {
      return _HseAnalysis(
        category: 'PPE',
        hazard: 'Inadequate / Missing PPE',
        risk: 'Medium',
        consequence: 'Injury',
        immediateAction:
            'Stop the task where necessary and provide the required PPE before continuing the work.',
        correctiveAction:
            'Ensure workers use task-specific PPE and conduct PPE awareness and compliance checks.',
      );
    }

    // ----------------------------------------------------------
    // ELECTRICAL
    // ----------------------------------------------------------

    if (_containsAny(text, [
      'electrical',
      'electric',
      'exposed wire',
      'exposed cable',
      'live wire',
      'damaged cable',
      'open electrical panel',
      'electrical panel open',
      'electric shock',
      'electrical shock',
      'temporary cable',
    ])) {
      final bool critical = _containsAny(text, [
        'live wire',
        'exposed wire',
        'electric shock',
        'electrical shock',
      ]);

      return _HseAnalysis(
        category: 'Electrical Safety',
        hazard: 'Electrical Exposure',
        risk: critical ? 'Critical' : 'High',
        consequence:
            critical ? 'Fatality' : 'Serious injury',
        immediateAction:
            'Isolate the affected electrical source by an authorized competent person and keep workers away from the area.',
        correctiveAction:
            'Repair or replace damaged electrical equipment and cables. Provide proper insulation, guarding and authorized electrical controls.',
      );
    }

    // ----------------------------------------------------------
    // FIRE
    // ----------------------------------------------------------

    if (_containsAny(text, [
      'fire',
      'fire hazard',
      'flammable',
      'flammable material',
      'hot work',
      'gas cylinder',
      'oxygen cylinder',
      'fire extinguisher',
      'blocked fire extinguisher',
      'blocked extinguisher',
      'combustible material',
      'combustible',
    ])) {
      return _HseAnalysis(
        category: 'Fire Safety',
        hazard: 'Fire / Ignition Hazard',
        risk: 'High',
        consequence: 'Serious injury',
        immediateAction:
            'Control the ignition source and remove combustible or flammable material from the affected area.',
        correctiveAction:
            'Maintain suitable fire protection, clear access to extinguishers and follow hot-work and fire-prevention requirements.',
      );
    }

    // ----------------------------------------------------------
    // LIFTING & RIGGING
    // ----------------------------------------------------------

    if (_containsAny(text, [
      'lifting',
      'crane',
      'rigging',
      'lifting gear',
      'sling',
      'shackle',
      'hoist',
      'suspended load',
      'suspended',
      'load',
      'person under load',
      'standing under load',
    ])) {
      final bool critical = _containsAny(text, [
        'person under load',
        'standing under load',
        'worker under load',
        'people under load',
      ]);

      return _HseAnalysis(
        category: 'Lifting & Rigging',
        hazard: 'Suspended Load / Lifting Hazard',
        risk: critical ? 'Critical' : 'High',
        consequence:
            critical ? 'Fatality' : 'Serious injury',
        immediateAction:
            'Stop the lifting activity and establish an exclusion zone. Keep all personnel away from the suspended load.',
        correctiveAction:
            'Verify lifting plan, certified lifting equipment, competent personnel and exclusion-zone controls before restarting.',
      );
    }

    // ----------------------------------------------------------
    // VEHICLE / TRAFFIC
    // ----------------------------------------------------------

    if (_containsAny(text, [
      'vehicle',
      'forklift',
      'fork lift',
      'truck',
      'reversing',
      'reverse',
      'pedestrian',
      'traffic',
      'mobile equipment',
      'seat belt',
      'vehicle movement',
    ])) {
      return _HseAnalysis(
        category: 'Vehicle & Traffic Safety',
        hazard: 'Vehicle / Pedestrian Interaction',
        risk: 'High',
        consequence: 'Serious injury',
        immediateAction:
            'Stop unsafe vehicle movement and separate pedestrians from moving vehicles or equipment.',
        correctiveAction:
            'Use designated traffic routes, pedestrian segregation, reversing controls, speed limits and a trained banksman where required.',
      );
    }

    // ----------------------------------------------------------
    // CHEMICAL
    // ----------------------------------------------------------

    if (_containsAny(text, [
      'chemical',
      'chemical spill',
      'spill',
      'acid',
      'solvent',
      'toxic',
      'corrosive',
      'chemical exposure',
      'chemical leak',
    ])) {
      return _HseAnalysis(
        category: 'Chemical Safety',
        hazard: 'Chemical Exposure / Spill',
        risk: 'High',
        consequence: 'Serious injury',
        immediateAction:
            'Isolate the affected area and prevent workers from contacting or inhaling the chemical.',
        correctiveAction:
            'Use the approved spill response procedure, suitable PPE and containment measures. Review SDS requirements before handling.',
      );
    }

    // ----------------------------------------------------------
    // CONFINED SPACE
    // ----------------------------------------------------------

    if (_containsAny(text, [
      'confined space',
      'confined-space',
      'tank entry',
      'tank',
      'manhole',
      'vessel entry',
      'confined',
    ])) {
      return _HseAnalysis(
        category: 'Confined Space',
        hazard: 'Confined Space Entry Hazard',
        risk: 'Critical',
        consequence: 'Fatality',
        immediateAction:
            'Stop entry and secure the confined space. Do not allow unauthorized entry.',
        correctiveAction:
            'Verify permit, isolation, atmospheric testing, ventilation, communication, standby person and rescue arrangements before entry.',
      );
    }

    // ----------------------------------------------------------
    // SLIP / TRIP / FALL
    // ----------------------------------------------------------

    if (_containsAny(text, [
      'slip',
      'trip',
      'fallen',
      'fell',
      'person fell',
      'worker fell',
      'lying on floor',
      'lying on the floor',
      'wet floor',
      'wet surface',
      'slippery',
      'slippery floor',
    ])) {
      final bool serious = _containsAny(text, [
        'fell',
        'fallen',
        'person fell',
        'worker fell',
        'lying on floor',
        'lying on the floor',
      ]);

      return _HseAnalysis(
        category: 'Slip, Trip & Fall',
        hazard: 'Slip, Trip & Fall Hazard',
        risk: serious ? 'High' : 'Medium',
        consequence:
            serious ? 'Serious injury' : 'Injury',
        immediateAction:
            'Secure the affected area and prevent further exposure to the slip, trip or fall hazard.',
        correctiveAction:
            'Remove the hazard, clean or repair the affected area, provide warning signage or barricading and verify the area is safe.',
      );
    }

    // ----------------------------------------------------------
    // HOUSEKEEPING
    // ----------------------------------------------------------

    if (_containsAny(text, [
      'housekeeping',
      'poor housekeeping',
      'poor house keeping',
      'debris',
      'obstruction',
      'blocked walkway',
      'blocked access',
      'loose material',
      'material on floor',
      'waste on floor',
      'untidy',
    ])) {
      return _HseAnalysis(
        category: 'Housekeeping',
        hazard: 'Poor Housekeeping / Obstruction',
        risk: 'Medium',
        consequence: 'Injury',
        immediateAction:
            'Remove loose materials and clear the affected access or walkway.',
        correctiveAction:
            'Maintain good housekeeping, provide suitable storage and conduct routine housekeeping inspections.',
      );
    }

    // ----------------------------------------------------------
    // MANUAL HANDLING
    // ----------------------------------------------------------

    if (_containsAny(text, [
      'manual handling',
      'manual lifting',
      'lifting by hand',
      'heavy lifting',
      'heavy object',
      'awkward lifting',
      'poor lifting technique',
      'back posture',
      'ergonomic',
    ])) {
      return _HseAnalysis(
        category: 'Manual Handling',
        hazard: 'Manual Handling / Ergonomic Hazard',
        risk: 'Medium',
        consequence: 'Injury',
        immediateAction:
            'Stop the unsafe lifting method and reduce the immediate manual-handling risk.',
        correctiveAction:
            'Use mechanical assistance where practicable and provide correct manual-handling technique and ergonomic controls.',
      );
    }

    // ----------------------------------------------------------
    // MACHINERY
    // ----------------------------------------------------------

    if (_containsAny(text, [
      'machine',
      'machinery',
      'machine guard',
      'guard removed',
      'unguarded machine',
      'moving parts',
      'rotating parts',
      'conveyor',
      'machine safety',
    ])) {
      return _HseAnalysis(
        category: 'Machinery Safety',
        hazard: 'Machine Guarding / Moving Parts',
        risk: 'High',
        consequence: 'Serious injury',
        immediateAction:
            'Stop the machine if there is immediate danger and keep personnel away from moving parts.',
        correctiveAction:
            'Restore required machine guarding, isolation and interlocks. Verify the machine is safe before operation.',
      );
    }

    // ----------------------------------------------------------
    // HEAT STRESS
    // ----------------------------------------------------------

    if (_containsAny(text, [
      'heat stress',
      'heat',
      'hot weather',
      'working in sun',
      'working under sun',
      'dehydration',
      'heat exhaustion',
      'heat exposure',
    ])) {
      return _HseAnalysis(
        category: 'Heat Stress',
        hazard: 'Heat Stress Exposure',
        risk: 'High',
        consequence: 'Serious injury',
        immediateAction:
            'Move the worker to a cool or shaded area and provide water and rest as required.',
        correctiveAction:
            'Implement heat-stress controls including hydration, rest breaks, shaded areas and worker awareness.',
      );
    }

    // ----------------------------------------------------------
    // GENERAL
    // ----------------------------------------------------------

    return _HseAnalysis(
      category: 'General Safety',
      hazard: 'General Workplace Hazard',
      risk: 'Medium',
      consequence: 'Injury',
      immediateAction:
          'Make the area safe and control the identified hazard to prevent further exposure.',
      correctiveAction:
          'Implement suitable corrective measures, communicate the action to the responsible person and verify closure.',
    );
  }

  bool _containsAny(
    String text,
    List<String> words,
  ) {
    for (final String word in words) {
      if (text.contains(word)) {
        return true;
      }
    }

    return false;
  }

  // ============================================================
  // DATE / TIME
  // ============================================================

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
      initialTime:
          TimeOfDay.fromDateTime(_observationDateTime),
    );

    if (time == null || !mounted) return;

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

    if (date == null || !mounted) return;

    setState(() {
      _targetDate = date;
    });
  }

  // ============================================================
  // SAVE OBSERVATION
  // ============================================================

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
      _showMessage(
        'Please enter the observation description.',
      );
      return;
    }

    if (_responsibleController.text.trim().isEmpty) {
      _showMessage(
        'Please assign a responsible person.',
      );
      return;
    }

    if (_targetDate == null) {
      _showMessage('Please select a target date.');
      return;
    }

    if (!mounted) return;

    setState(() {
      _isSaving = true;
    });

    try {
      final SharedPreferences prefs =
          await SharedPreferences.getInstance();

      final List<String> existing =
          prefs.getStringList(_storageKey) ??
              <String>[];

      final Map<String, dynamic> observation = {
        'id': DateTime.now()
            .millisecondsSinceEpoch
            .toString(),

        'location':
            _locationController.text.trim(),

        'dateTime':
            _observationDateTime.toIso8601String(),

        'description':
            _descriptionController.text.trim(),

        'category': _category,

        'hazardType': _hazardType,

        'riskLevel': _riskLevel,

        'potentialConsequence':
            _potentialConsequence,

        'beforePhoto':
            _beforePhoto?.path ?? '',

        'immediateAction':
            _immediateActionController
                .text
                .trim(),

        'correctiveAction':
            _correctiveActionController
                .text
                .trim(),

        'responsiblePerson':
            _responsibleController
                .text
                .trim(),

        'targetDate':
            _targetDate?.toIso8601String(),

        'afterPhoto':
            _afterPhoto?.path ?? '',

        'status': _status,

        'closureRemarks':
            _closureRemarksController
                .text
                .trim(),

        'createdAt':
            DateTime.now().toIso8601String(),

        'updatedAt':
            DateTime.now().toIso8601String(),
      };

      existing.insert(
        0,
        jsonEncode(observation),
      );

      await prefs.setStringList(
        _storageKey,
        existing,
      );

      if (!mounted) return;

      _showMessage(
        'Safety observation saved successfully.',
      );

      _clearForm();
    } catch (_) {
      _showMessage(
        'Unable to save observation.',
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  // ============================================================
  // CLEAR FORM
  // ============================================================

  void _clearForm() {
    if (!mounted) return;

    setState(() {
      _beforePhoto = null;
      _afterPhoto = null;

      _locationController.clear();
      _descriptionController.clear();
      _immediateActionController.clear();
      _correctiveActionController.clear();
      _responsibleController.clear();
      _closureRemarksController.clear();

      _observationDateTime =
          DateTime.now();

      _targetDate = null;

      _category = 'Unsafe Condition';

      _hazardType =
          'General Workplace Hazard';

      _riskLevel = 'Medium';

      _potentialConsequence = 'Injury';

      _status = 'Open';

      _isAnalyzing = false;

      _smartAnalysisDone = false;
    });
  }

  // ============================================================
  // MESSAGE
  // ============================================================

  void _showMessage(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          behavior:
              SnackBarBehavior.floating,
        ),
      );
  }

  // ============================================================
  // DATE FORMAT
  // ============================================================

  String _formatDate(DateTime? date) {
    if (date == null) {
      return 'Select Target Date';
    }

    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }

  String _formatDateTime(DateTime date) {
    final String hour =
        date.hour.toString().padLeft(2, '0');

    final String minute =
        date.minute.toString().padLeft(2, '0');

    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year} '
        '$hour:$minute';
  }

  // ============================================================
  // PHOTO OPTIONS
  // ============================================================

  void _showBeforePhotoOptions() {
    showModalBottomSheet<void>(
      context: context,
      builder: (sheetContext) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading:
                    const Icon(Icons.camera_alt),
                title:
                    const Text('Take Photo'),
                onTap: () {
                  Navigator.pop(sheetContext);

                  _pickBeforePhoto(
                    ImageSource.camera,
                  );
                },
              ),
              ListTile(
                leading:
                    const Icon(Icons.photo_library),
                title:
                    const Text(
                        'Upload from Gallery'),
                onTap: () {
                  Navigator.pop(sheetContext);

                  _pickBeforePhoto(
                    ImageSource.gallery,
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showAfterPhotoOptions() {
    showModalBottomSheet<void>(
      context: context,
      builder: (sheetContext) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading:
                    const Icon(Icons.camera_alt),
                title:
                    const Text(
                        'Take After Photo'),
                onTap: () {
                  Navigator.pop(sheetContext);

                  _pickAfterPhoto(
                    ImageSource.camera,
                  );
                },
              ),
              ListTile(
                leading:
                    const Icon(Icons.photo_library),
                title:
                    const Text(
                        'Upload from Gallery'),
                onTap: () {
                  Navigator.pop(sheetContext);

                  _pickAfterPhoto(
                    ImageSource.gallery,
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // ============================================================
  // SECTION HEADER
  // ============================================================

  Widget _sectionHeader(
    String title,
    IconData icon, {
    Color? color,
  }) {
    final Color primaryColor =
        color ??
            Theme.of(context)
                .colorScheme
                .primary;

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
                primaryColor.withValues(
              alpha: 0.12,
            ),
            child: Icon(
              icon,
              size: 21,
              color: primaryColor,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight:
                    FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // TEXT FIELD
  // ============================================================

  Widget _textField({
    required TextEditingController controller,
    required String label,
    required String hint,
    IconData? icon,
    int maxLines = 1,
  }) {
    return Padding(
      padding:
          const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          prefixIcon: icon == null
              ? null
              : Icon(icon),
          border:
              OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(12),
          ),
          filled: true,
        ),
      ),
    );
  }

  // ============================================================
  // PHOTO CARD
  // ============================================================

  Widget _photoCard({
    required String title,
    required String subtitle,
    required File? file,
    required VoidCallback onTap,
    required IconData icon,
  }) {
    return Card(
      elevation: 1,
      clipBehavior:
          Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 220,
          width: double.infinity,
          decoration:
              BoxDecoration(
            borderRadius:
                BorderRadius.circular(14),
          ),
          child: file == null
              ? Column(
                  mainAxisAlignment:
                      MainAxisAlignment
                          .center,
                  children: [
                    Icon(
                      icon,
                      size: 55,
                      color:
                          Theme.of(context)
                              .colorScheme
                              .primary,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      title,
                      style:
                          const TextStyle(
                        fontSize: 17,
                        fontWeight:
                            FontWeight
                                .bold,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      subtitle,
                      textAlign:
                          TextAlign.center,
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
                        padding:
                            const EdgeInsets
                                .symmetric(
                          horizontal: 12,
                          vertical: 7,
                        ),
                        decoration:
                            BoxDecoration(
                          color: Colors.black
                              .withValues(
                            alpha: 0.65,
                          ),
                          borderRadius:
                              BorderRadius
                                  .circular(
                            20,
                          ),
                        ),
                        child:
                            const Text(
                          'Photo selected',
                          style:
                              TextStyle(
                            color:
                                Colors.white,
                            fontWeight:
                                FontWeight
                                    .w600,
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

  // ============================================================
  // CATEGORY
  // ============================================================

  Widget _categoryDropdown() {
    const List<String> categories = [
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

    return DropdownButtonFormField<String>(
      initialValue: _category,
      decoration:
          InputDecoration(
        labelText: 'Category',
        prefixIcon:
            const Icon(Icons.category),
        border:
            OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(12),
        ),
        filled: true,
      ),
      items: categories
          .map(
            (String value) =>
                DropdownMenuItem<String>(
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
    );
  }

  // ============================================================
  // RISK LEVEL
  // ============================================================

  Widget _riskLevelDropdown() {
    return DropdownButtonFormField<String>(
      initialValue: _riskLevel,
      decoration:
          InputDecoration(
        labelText: 'Risk Level',
        prefixIcon:
            const Icon(Icons.warning),
        border:
            OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(12),
        ),
        filled: true,
      ),
      items: const [
        DropdownMenuItem(
          value: 'Critical',
          child:
              Text('🔴 Critical Risk'),
        ),
        DropdownMenuItem(
          value: 'High',
          child:
              Text('🔴 High Risk'),
        ),
        DropdownMenuItem(
          value: 'Medium',
          child:
              Text('🟠 Medium Risk'),
        ),
        DropdownMenuItem(
          value: 'Low',
          child:
              Text('🟢 Low Risk'),
        ),
      ],
      onChanged: (value) {
        if (value == null) return;

        setState(() {
          _riskLevel = value;

          if (value == 'Critical') {
            _potentialConsequence =
                'Fatality';
          } else if (value == 'High') {
            _potentialConsequence =
                'Serious injury';
          } else if (value == 'Medium') {
            _potentialConsequence =
                'Injury';
          } else {
            _potentialConsequence =
                'Minor injury';
          }
        });
      },
    );
  }

  // ============================================================
  // STATUS
  // ============================================================

  Widget _statusDropdown() {
    return DropdownButtonFormField<String>(
      initialValue: _status,
      decoration:
          InputDecoration(
        labelText: 'Status',
        prefixIcon:
            const Icon(
          Icons.track_changes,
        ),
        border:
            OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(12),
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
          child:
              Text('🟠 In Progress'),
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
    );
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Safety Observation',
          style: TextStyle(
            fontWeight:
                FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          padding:
              const EdgeInsets.fromLTRB(
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
              title:
                  'Add Unsafe Work Photo',
              subtitle:
                  'Take a photo or upload an existing photo',
              file: _beforePhoto,
              onTap:
                  _showBeforePhotoOptions,
              icon:
                  Icons.add_a_photo,
            ),

            const SizedBox(
              height: 10,
            ),

            if (_beforePhoto != null)
              Container(
                padding:
                    const EdgeInsets.all(
                  12,
                ),
                decoration:
                    BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(
                    12,
                  ),
                  color: Colors.blue
                      .withValues(
                    alpha: 0.08,
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.auto_awesome,
                      color: Colors.blue,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        _isAnalyzing
                            ? 'Analyzing observation...'
                            : _smartAnalysisDone
                                ? 'Smart HSE analysis applied.'
                                : 'Enter the observation description and tap Analyze.',
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
              controller:
                  _locationController,
              label: 'Location',
              hint:
                  'Enter exact location',
              icon:
                  Icons.location_on,
            ),

            InkWell(
              onTap:
                  _selectObservationDateTime,
              borderRadius:
                  BorderRadius.circular(
                12,
              ),
              child: InputDecorator(
                decoration:
                    InputDecoration(
                  labelText:
                      'Date & Time',
                  prefixIcon:
                      const Icon(
                    Icons.calendar_month,
                  ),
                  border:
                      OutlineInputBorder(
                    borderRadius:
                        BorderRadius
                            .circular(
                      12,
                    ),
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

            const SizedBox(
              height: 12,
            ),

            _textField(
              controller:
                  _descriptionController,
              label:
                  'Observation Description',
              hint:
                  'Example: Worker fell and is lying on the floor.',
              icon:
                  Icons.description,
              maxLines: 5,
            ),

            const SizedBox(
              height: 2,
            ),

            SizedBox(
              height: 50,
              child:
                  OutlinedButton.icon(
                onPressed:
                    _isAnalyzing
                        ? null
                        : _analyzeObservation,
                icon: _isAnalyzing
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
                  _isAnalyzing
                      ? 'Analyzing...'
                      : 'Analyze & Auto-Fill HSE Details',
                ),
              ),
            ),

            const SizedBox(
              height: 14,
            ),

            _categoryDropdown(),

            const SizedBox(
              height: 12,
            ),

            _readOnlyField(
              label:
                  'Hazard / Unsafe Work',
              value: _hazardType,
              icon:
                  Icons.report_problem_outlined,
            ),

            // ==================================================
            // RISK
            // ==================================================

            _sectionHeader(
              'Risk Assessment',
              Icons.warning_amber_rounded,
              color:
                  Colors.orange,
            ),

            _riskLevelDropdown(),

            const SizedBox(
              height: 12,
            ),

            _readOnlyField(
              label:
                  'Potential Consequence',
              value:
                  _potentialConsequence,
              icon:
                  Icons.health_and_safety,
            ),

            const SizedBox(
              height: 12,
            ),

            _riskDescription(),

            // ==================================================
            // ACTION PLAN
            // ==================================================

            _sectionHeader(
              'Rectification & Action Plan',
              Icons.build_circle,
              color:
                  Colors.green,
            ),

            _textField(
              controller:
                  _immediateActionController,
              label:
                  'Immediate Action',
              hint:
                  'Action taken immediately.',
              icon:
                  Icons.flash_on,
              maxLines: 4,
            ),

            _textField(
              controller:
                  _correctiveActionController,
              label:
                  'Corrective Action',
              hint:
                  'Action required to prevent recurrence.',
              icon:
                  Icons.check_circle,
              maxLines: 4,
            ),

            _textField(
              controller:
                  _responsibleController,
              label:
                  'Assign Responsibility',
              hint:
                  'Supervisor / Engineer / Responsible Person',
              icon:
                  Icons.person,
            ),

            InkWell(
              onTap:
                  _selectTargetDate,
              borderRadius:
                  BorderRadius.circular(
                12,
              ),
              child: InputDecorator(
                decoration:
                    InputDecoration(
                  labelText:
                      'Target Date',
                  prefixIcon:
                      const Icon(
                    Icons.event,
                  ),
                  border:
                      OutlineInputBorder(
                    borderRadius:
                        BorderRadius
                            .circular(
                      12,
                    ),
                  ),
                  filled: true,
                ),
                child: Text(
                  _formatDate(
                    _targetDate,
                  ),
                ),
              ),
            ),

            // ==================================================
            // CLOSURE
            // ==================================================

            _sectionHeader(
              'Closure & Follow-up',
              Icons.lock_open,
              color:
                  Colors.deepPurple,
            ),

            _photoCard(
              title:
                  'Add After Photo',
              subtitle:
                  'Take or upload photo after rectification',
              file: _afterPhoto,
              onTap:
                  _showAfterPhotoOptions,
              icon:
                  Icons.add_photo_alternate,
            ),

            const SizedBox(
              height: 12,
            ),

            _statusDropdown(),

            const SizedBox(
              height: 12,
            ),

            _textField(
              controller:
                  _closureRemarksController,
              label:
                  'Closure Remarks',
              hint:
                  'Enter verification / closure remarks',
              icon:
                  Icons.notes,
              maxLines: 4,
            ),

            // ==================================================
            // SAVE
            // ==================================================

            const SizedBox(
              height: 25,
            ),

            SizedBox(
              height: 55,
              child:
                  FilledButton.icon(
                onPressed:
                    _isSaving
                        ? null
                        : _saveObservation,
                icon: _isSaving
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child:
                            CircularProgressIndicator(
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
                  style:
                      const TextStyle(
                    fontSize: 16,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            OutlinedButton.icon(
              onPressed:
                  _isSaving
                      ? null
                      : _clearForm,
              icon:
                  const Icon(Icons.refresh),
              label:
                  const Text(
                'Clear Form',
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
      decoration:
          InputDecoration(
        labelText: label,
        prefixIcon:
            Icon(icon),
        border:
            OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(
            12,
          ),
        ),
        filled: true,
      ),
      child: Text(
        value,
        style:
            const TextStyle(
          fontSize: 16,
          fontWeight:
              FontWeight.w600,
        ),
      ),
    );
  }

  // ============================================================
  // RISK DESCRIPTION
  // ============================================================

  Widget _riskDescription() {
    String title;
    String description;
    IconData icon;

    if (_riskLevel == 'Critical') {
      title = 'Critical Risk';
      description =
          'Potential for fatality or multiple serious injuries. Immediate intervention and strict control are required.';
      icon = Icons.dangerous;
    } else if (_riskLevel == 'High') {
      title = 'High Risk';
      description =
          'Potential for serious injury or major incident. Immediate control is required.';
      icon = Icons.warning;
    } else if (_riskLevel == 'Medium') {
      title = 'Medium Risk';
      description =
          'Potential for injury or damage. Corrective action should be completed within the target date.';
      icon =
          Icons.warning_amber;
    } else {
      title = 'Low Risk';
      description =
          'Limited potential consequence, but the issue should still be corrected and monitored.';
      icon =
          Icons.info_outline;
    }

    final Color borderColor =
        _riskLevel == 'Critical'
            ? Colors.red.shade900
            : _riskLevel == 'High'
                ? Colors.red
                : _riskLevel == 'Medium'
                    ? Colors.orange
                    : Colors.green;

    return Container(
      margin:
          const EdgeInsets.only(
        top: 8,
      ),
      padding:
          const EdgeInsets.all(
        14,
      ),
      decoration:
          BoxDecoration(
        borderRadius:
            BorderRadius.circular(
          12,
        ),
        border:
            Border.all(
          color:
              borderColor,
        ),
      ),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Icon(icon),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style:
                      const TextStyle(
                    fontWeight:
                        FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  description,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ================================================================
// HSE ANALYSIS RESULT
// ================================================================

class _HseAnalysis {
  final String category;
  final String hazard;
  final String risk;
  final String consequence;
  final String immediateAction;
  final String correctiveAction;

  const _HseAnalysis({
    required this.category,
    required this.hazard,
    required this.risk,
    required this.consequence,
    required this.immediateAction,
    required this.correctiveAction,
  });
}
