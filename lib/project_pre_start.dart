import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProjectPreStartPage extends StatefulWidget {
  const ProjectPreStartPage({super.key});

  @override
  State<ProjectPreStartPage> createState() => _ProjectPreStartPageState();
}

class _ProjectPreStartPageState extends State<ProjectPreStartPage> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);

  final _formKey = GlobalKey<FormState>();
  final _projectNameController = TextEditingController();
  final _contractNumberController = TextEditingController();
  final _clientController = TextEditingController();
  final _contractorController = TextEditingController();
  final _consultantController = TextEditingController();
  final _subcontractorController = TextEditingController();
  final _projectManagerController = TextEditingController();
  final _hseManagerController = TextEditingController();
  final _hseOfficerController = TextEditingController();
  final _siteManagerController = TextEditingController();
  final _constructionManagerController = TextEditingController();
  final _hseSupervisorController = TextEditingController();
  final _hseCoordinatorController = TextEditingController();
  final _emergencyContactNameController = TextEditingController();
  final _emergencyContactPhoneController = TextEditingController();
  final _ambulanceController = TextEditingController();
  final _fireRescueController = TextEditingController();
  final _policeController = TextEditingController();
  final _nearestHospitalController = TextEditingController();
  final _assemblyPointController = TextEditingController();
  final _locationController = TextEditingController();
  final _cityController = TextEditingController();
  final _areaController = TextEditingController();
  final _scopeController = TextEditingController();
  final _mainActivitiesController = TextEditingController();

  String _emirate = 'Abu Dhabi';
  String _status = 'Pre-Start';
  DateTime? _plannedStartDate;
  DateTime? _plannedEndDate;
  bool _isLoading = true;
  bool _isSaving = false;
  bool _hasSavedProject = false;
  String _readinessApproval = 'Not Reviewed';
  final _readinessReviewerController = TextEditingController();
  final _readinessRemarksController = TextEditingController();
  DateTime? _readinessReviewDate;

  // Step 1H - Final Review & Handover
  String _finalReviewStatus = 'Not Completed';
  final _finalReviewerController = TextEditingController();
  final _handoverRemarksController = TextEditingController();
  DateTime? _finalReviewDate;

  final List<String> _documentNames = const [
    'Project HSE Plan',
    'HSE Policy',
    'Risk Assessment / HIRA',
    'JSA / JHA',
    'RAMS / Method Statement',
    'Emergency Response Plan',
    'Training / Competency Matrix',
    'HSE Organization Chart',
    'Inspection & Audit Plan',
    'Environmental Management Plan',
    'Traffic Management Plan',
    'Lifting Plan / Critical Lift Plan',
  ];

  late final Map<String, String> _documentStatus = {
    for (final name in _documentNames) name: 'Pending',
  };

  late final Map<String, TextEditingController> _documentReferenceControllers = {
    for (final name in _documentNames) name: TextEditingController(),
  };

  late final Map<String, DateTime?> _documentReviewDates = {
    for (final name in _documentNames) name: null,
  };

  final List<String> _preStartChecklistItems = const [
    'Project HSE Plan is approved and available at site',
    'HIRA / Risk Assessments are completed and approved',
    'JSA / JHA / RAMS are available for planned activities',
    'Emergency Response Plan and emergency contacts are established',
    'Required Permit to Work arrangements are identified',
    'Site welfare facilities are ready and inspected',
    'First aid facilities and trained first aiders are available',
    'Fire protection equipment and emergency access are ready',
    'Workforce induction and required competency checks are completed',
    'Plant, equipment and lifting certificates are verified',
    'Site access, barricading and safety signage are established',
    'Emergency assembly point is identified and communicated',
    'Environmental and waste controls are established',
    'Initial HSE inspection / pre-start inspection is completed',
    'Applicable legal and authority requirements are identified',
  ];

  late final Map<String, String> _checklistStatus = {
    for (final item in _preStartChecklistItems) item: 'Not Completed',
  };
  late final Map<String, TextEditingController> _checklistRemarksControllers = {
    for (final item in _preStartChecklistItems) item: TextEditingController(),
  };

  @override
  void initState() {
    super.initState();
    _loadProject();
  }

  @override
  void dispose() {
    _projectNameController.dispose();
    _contractNumberController.dispose();
    _clientController.dispose();
    _contractorController.dispose();
    _consultantController.dispose();
    _subcontractorController.dispose();
    _projectManagerController.dispose();
    _hseManagerController.dispose();
    _hseOfficerController.dispose();
    _siteManagerController.dispose();
    _constructionManagerController.dispose();
    _hseSupervisorController.dispose();
    _hseCoordinatorController.dispose();
    _emergencyContactNameController.dispose();
    _emergencyContactPhoneController.dispose();
    _ambulanceController.dispose();
    _fireRescueController.dispose();
    _policeController.dispose();
    _nearestHospitalController.dispose();
    _assemblyPointController.dispose();
    _locationController.dispose();
    _cityController.dispose();
    _areaController.dispose();
    _scopeController.dispose();
    _mainActivitiesController.dispose();
    _readinessReviewerController.dispose();
    _readinessRemarksController.dispose();
    _finalReviewerController.dispose();
    _handoverRemarksController.dispose();
    for (final controller in _documentReferenceControllers.values) {
      controller.dispose();
    }
    for (final controller in _checklistRemarksControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _loadProject() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;

    setState(() {
      _projectNameController.text = prefs.getString('prestart.projectName') ?? '';
      _contractNumberController.text =
          prefs.getString('prestart.contractNumber') ?? '';
      _clientController.text = prefs.getString('prestart.client') ?? '';
      _contractorController.text = prefs.getString('prestart.contractor') ?? '';
      _consultantController.text = prefs.getString('prestart.consultant') ?? '';
      _subcontractorController.text = prefs.getString('prestart.subcontractor') ?? '';
      _projectManagerController.text = prefs.getString('prestart.projectManager') ?? '';
      _hseManagerController.text = prefs.getString('prestart.hseManager') ?? '';
      _hseOfficerController.text = prefs.getString('prestart.hseOfficer') ?? '';
      _siteManagerController.text = prefs.getString('prestart.siteManager') ?? '';
      _constructionManagerController.text = prefs.getString('prestart.constructionManager') ?? '';
      _hseSupervisorController.text = prefs.getString('prestart.hseSupervisor') ?? '';
      _hseCoordinatorController.text = prefs.getString('prestart.hseCoordinator') ?? '';
      _emergencyContactNameController.text = prefs.getString('prestart.emergencyContactName') ?? '';
      _emergencyContactPhoneController.text = prefs.getString('prestart.emergencyContactPhone') ?? '';
      _ambulanceController.text = prefs.getString('prestart.ambulance') ?? '';
      _fireRescueController.text = prefs.getString('prestart.fireRescue') ?? '';
      _policeController.text = prefs.getString('prestart.police') ?? '';
      _nearestHospitalController.text = prefs.getString('prestart.nearestHospital') ?? '';
      _assemblyPointController.text = prefs.getString('prestart.assemblyPoint') ?? '';
      _locationController.text = prefs.getString('prestart.location') ?? '';
      _cityController.text = prefs.getString('prestart.city') ?? '';
      _areaController.text = prefs.getString('prestart.area') ?? '';
      _scopeController.text = prefs.getString('prestart.scope') ?? '';
      _mainActivitiesController.text =
          prefs.getString('prestart.mainActivities') ?? '';
      _emirate = prefs.getString('prestart.emirate') ?? 'Abu Dhabi';
      _status = prefs.getString('prestart.status') ?? 'Pre-Start';
      _plannedStartDate = _dateFromString(prefs.getString('prestart.startDate'));
      _plannedEndDate = _dateFromString(prefs.getString('prestart.endDate'));
      _hasSavedProject = prefs.getBool('prestart.hasSavedProject') ?? false;
      _readinessApproval = prefs.getString('prestart.readiness.approval') ?? 'Not Reviewed';
      _readinessReviewerController.text = prefs.getString('prestart.readiness.reviewer') ?? '';
      _readinessRemarksController.text = prefs.getString('prestart.readiness.remarks') ?? '';
      _readinessReviewDate = _dateFromString(prefs.getString('prestart.readiness.reviewDate'));
      _finalReviewStatus = prefs.getString('prestart.final.status') ?? 'Not Completed';
      _finalReviewerController.text = prefs.getString('prestart.final.reviewer') ?? '';
      _handoverRemarksController.text = prefs.getString('prestart.final.remarks') ?? '';
      _finalReviewDate = _dateFromString(prefs.getString('prestart.final.reviewDate'));
      for (final name in _documentNames) {
        _documentStatus[name] =
            prefs.getString('prestart.doc.status.$name') ?? 'Pending';
        _documentReferenceControllers[name]!.text =
            prefs.getString('prestart.doc.ref.$name') ?? '';
        _documentReviewDates[name] =
            _dateFromString(prefs.getString('prestart.doc.review.$name'));
      }

      for (final item in _preStartChecklistItems) {
        _checklistStatus[item] =
            prefs.getString('prestart.check.status.$item') ?? 'Not Completed';
        _checklistRemarksControllers[item]!.text =
            prefs.getString('prestart.check.remarks.$item') ?? '';
      }
      _isLoading = false;
    });
  }

  DateTime? _dateFromString(String? value) {
    if (value == null || value.isEmpty) return null;
    return DateTime.tryParse(value);
  }

  String _dateText(DateTime? date) {
    if (date == null) return 'Select date';
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    return '$day/$month/${date.year}';
  }

  Future<void> _pickStartDate() async {
    final now = DateTime.now();
    final selected = await showDatePicker(
      context: context,
      firstDate: DateTime(now.year - 5),
      lastDate: DateTime(now.year + 20),
      initialDate: _plannedStartDate ?? now,
    );
    if (selected != null) {
      if (_plannedEndDate != null && selected.isAfter(_plannedEndDate!)) {
        setState(() {
          _plannedStartDate = selected;
          _plannedEndDate = null;
        });
        _showMessage('End date was cleared because it is before the new start date.');
      } else {
        setState(() => _plannedStartDate = selected);
      }
    }
  }

  Future<void> _pickEndDate() async {
    final now = DateTime.now();
    final initial = _plannedEndDate ?? _plannedStartDate ?? now;
    final selected = await showDatePicker(
      context: context,
      firstDate: _plannedStartDate ?? DateTime(now.year - 5),
      lastDate: DateTime(now.year + 20),
      initialDate: initial,
    );
    if (selected != null) {
      setState(() => _plannedEndDate = selected);
    }
  }

  Future<void> _saveProject() async {
    if (!_formKey.currentState!.validate()) return;

    if (_plannedStartDate != null &&
        _plannedEndDate != null &&
        _plannedEndDate!.isBefore(_plannedStartDate!)) {
      _showMessage('Planned end date cannot be before the start date.');
      return;
    }

    setState(() => _isSaving = true);
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('prestart.projectName', _projectNameController.text.trim());
    await prefs.setString(
      'prestart.contractNumber',
      _contractNumberController.text.trim(),
    );
    await prefs.setString('prestart.client', _clientController.text.trim());
    await prefs.setString(
      'prestart.contractor',
      _contractorController.text.trim(),
    );
    await prefs.setString('prestart.consultant', _consultantController.text.trim());
    await prefs.setString('prestart.subcontractor', _subcontractorController.text.trim());
    await prefs.setString('prestart.projectManager', _projectManagerController.text.trim());
    await prefs.setString('prestart.hseManager', _hseManagerController.text.trim());
    await prefs.setString('prestart.hseOfficer', _hseOfficerController.text.trim());
    await prefs.setString('prestart.siteManager', _siteManagerController.text.trim());
    await prefs.setString('prestart.constructionManager', _constructionManagerController.text.trim());
    await prefs.setString('prestart.hseSupervisor', _hseSupervisorController.text.trim());
    await prefs.setString('prestart.hseCoordinator', _hseCoordinatorController.text.trim());
    await prefs.setString('prestart.emergencyContactName', _emergencyContactNameController.text.trim());
    await prefs.setString('prestart.emergencyContactPhone', _emergencyContactPhoneController.text.trim());
    await prefs.setString('prestart.ambulance', _ambulanceController.text.trim());
    await prefs.setString('prestart.fireRescue', _fireRescueController.text.trim());
    await prefs.setString('prestart.police', _policeController.text.trim());
    await prefs.setString('prestart.nearestHospital', _nearestHospitalController.text.trim());
    await prefs.setString('prestart.assemblyPoint', _assemblyPointController.text.trim());
    await prefs.setString('prestart.location', _locationController.text.trim());
    await prefs.setString('prestart.city', _cityController.text.trim());
    await prefs.setString('prestart.area', _areaController.text.trim());
    await prefs.setString('prestart.scope', _scopeController.text.trim());
    await prefs.setString(
      'prestart.mainActivities',
      _mainActivitiesController.text.trim(),
    );
    await prefs.setString('prestart.emirate', _emirate);
    await prefs.setString('prestart.status', _status);
    await prefs.setString(
      'prestart.startDate',
      _plannedStartDate?.toIso8601String() ?? '',
    );
    await prefs.setString(
      'prestart.endDate',
      _plannedEndDate?.toIso8601String() ?? '',
    );
    await prefs.setBool('prestart.hasSavedProject', true);
    await prefs.setString('prestart.readiness.approval', _readinessApproval);
    await prefs.setString('prestart.readiness.reviewer', _readinessReviewerController.text.trim());
    await prefs.setString('prestart.readiness.remarks', _readinessRemarksController.text.trim());
    await prefs.setString('prestart.readiness.reviewDate', _readinessReviewDate?.toIso8601String() ?? '');
    await prefs.setString('prestart.final.status', _finalReviewStatus);
    await prefs.setString('prestart.final.reviewer', _finalReviewerController.text.trim());
    await prefs.setString('prestart.final.remarks', _handoverRemarksController.text.trim());
    await prefs.setString('prestart.final.reviewDate', _finalReviewDate?.toIso8601String() ?? '');

    for (final name in _documentNames) {
      await prefs.setString(
        'prestart.doc.status.$name',
        _documentStatus[name]!,
      );
      await prefs.setString(
        'prestart.doc.ref.$name',
        _documentReferenceControllers[name]!.text.trim(),
      );
      await prefs.setString(
        'prestart.doc.review.$name',
        _documentReviewDates[name]?.toIso8601String() ?? '',
      );
    }

    for (final item in _preStartChecklistItems) {
      await prefs.setString(
        'prestart.check.status.$item',
        _checklistStatus[item]!,
      );
      await prefs.setString(
        'prestart.check.remarks.$item',
        _checklistRemarksControllers[item]!.text.trim(),
      );
    }

    if (!mounted) return;
    setState(() {
      _isSaving = false;
      _hasSavedProject = true;
    });
    _showMessage(_finalReviewStatus == 'Completed' ? 'Project Pre-Start saved and handover marked complete.' : 'Project Pre-Start saved successfully.');
  }

  Future<void> _resetProject() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset Project Profile?'),
        content: const Text(
          'This will clear the Project Profile saved on this device.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('CANCEL'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('RESET'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    final prefs = await SharedPreferences.getInstance();
    for (final key in [
      'projectName',
      'contractNumber',
      'client',
      'contractor',
      'consultant',
      'subcontractor',
      'projectManager',
      'hseManager',
      'hseOfficer',
      'siteManager',
      'constructionManager',
      'hseSupervisor',
      'hseCoordinator',
      'emergencyContactName',
      'emergencyContactPhone',
      'ambulance',
      'fireRescue',
      'police',
      'nearestHospital',
      'assemblyPoint',
      'location',
      'city',
      'area',
      'scope',
      'mainActivities',
      'emirate',
      'status',
      'startDate',
      'endDate',
      'hasSavedProject',
      'readiness.approval',
      'readiness.reviewer',
      'readiness.remarks',
      'readiness.reviewDate',
      'final.status',
      'final.reviewer',
      'final.remarks',
      'final.reviewDate',
    ]) {
      await prefs.remove('prestart.$key');
    }
    for (final name in _documentNames) {
      await prefs.remove('prestart.doc.status.$name');
      await prefs.remove('prestart.doc.ref.$name');
      await prefs.remove('prestart.doc.review.$name');
    }
    for (final item in _preStartChecklistItems) {
      await prefs.remove('prestart.check.status.$item');
      await prefs.remove('prestart.check.remarks.$item');
    }

    if (!mounted) return;
    setState(() {
      _projectNameController.clear();
      _contractNumberController.clear();
      _clientController.clear();
      _contractorController.clear();
      _consultantController.clear();
      _subcontractorController.clear();
      _projectManagerController.clear();
      _hseManagerController.clear();
      _hseOfficerController.clear();
      _siteManagerController.clear();
      _constructionManagerController.clear();
      _hseSupervisorController.clear();
      _hseCoordinatorController.clear();
      _emergencyContactNameController.clear();
      _emergencyContactPhoneController.clear();
      _ambulanceController.clear();
      _fireRescueController.clear();
      _policeController.clear();
      _nearestHospitalController.clear();
      _assemblyPointController.clear();
      _locationController.clear();
      _cityController.clear();
      _areaController.clear();
      _scopeController.clear();
      _mainActivitiesController.clear();
      _readinessApproval = 'Not Reviewed';
      _readinessReviewerController.clear();
      _readinessRemarksController.clear();
      _readinessReviewDate = null;
      _finalReviewStatus = 'Not Completed';
      _finalReviewerController.clear();
      _handoverRemarksController.clear();
      _finalReviewDate = null;
      _emirate = 'Abu Dhabi';
      _status = 'Pre-Start';
      _plannedStartDate = null;
      _plannedEndDate = null;
      _hasSavedProject = false;
      for (final name in _documentNames) {
        _documentStatus[name] = 'Pending';
        _documentReferenceControllers[name]!.clear();
        _documentReviewDates[name] = null;
      }
      for (final item in _preStartChecklistItems) {
        _checklistStatus[item] = 'Not Completed';
        _checklistRemarksControllers[item]!.clear();
      }
    });
    _showMessage('Project Profile reset.');
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  int get _completionPercent {
    final profileChecks = [
      _projectNameController.text.trim().isNotEmpty,
      _contractNumberController.text.trim().isNotEmpty,
      _clientController.text.trim().isNotEmpty,
      _contractorController.text.trim().isNotEmpty,
      _locationController.text.trim().isNotEmpty,
      _cityController.text.trim().isNotEmpty,
      _areaController.text.trim().isNotEmpty,
      _scopeController.text.trim().isNotEmpty,
      _mainActivitiesController.text.trim().isNotEmpty,
      _hseManagerController.text.trim().isNotEmpty,
      _hseOfficerController.text.trim().isNotEmpty,
      _emergencyContactNameController.text.trim().isNotEmpty,
      _emergencyContactPhoneController.text.trim().isNotEmpty,
      _assemblyPointController.text.trim().isNotEmpty,
      _plannedStartDate != null,
      _plannedEndDate != null,
    ];
    final documentChecks = _documentNames
        .map((name) => _documentStatus[name] == 'Approved')
        .toList();
    final applicableChecklistItems = _preStartChecklistItems
        .where((item) => _checklistStatus[item] != 'N/A')
        .toList();
    final checklistChecks = applicableChecklistItems
        .map((item) => _checklistStatus[item] == 'Completed')
        .toList();
    final checks = [...profileChecks, ...documentChecks, ...checklistChecks];
    if (checks.isEmpty) return 0;
    final completed = checks.where((value) => value).length;
    return ((completed / checks.length) * 100).round();
  }

  int get _checklistCompletedCount =>
      _checklistStatus.values.where((value) => value == 'Completed').length;

  int get _profileCompletedCount => [
        _projectNameController.text.trim().isNotEmpty,
        _contractNumberController.text.trim().isNotEmpty,
        _clientController.text.trim().isNotEmpty,
        _contractorController.text.trim().isNotEmpty,
        _locationController.text.trim().isNotEmpty,
        _cityController.text.trim().isNotEmpty,
        _areaController.text.trim().isNotEmpty,
        _scopeController.text.trim().isNotEmpty,
        _mainActivitiesController.text.trim().isNotEmpty,
        _hseManagerController.text.trim().isNotEmpty,
        _hseOfficerController.text.trim().isNotEmpty,
        _emergencyContactNameController.text.trim().isNotEmpty,
        _emergencyContactPhoneController.text.trim().isNotEmpty,
        _assemblyPointController.text.trim().isNotEmpty,
        _plannedStartDate != null,
        _plannedEndDate != null,
      ].where((value) => value).length;

  int get _approvedDocumentCount =>
      _documentStatus.values.where((value) => value == 'Approved').length;

  int get _applicableChecklistCount =>
      _preStartChecklistItems.where((item) => _checklistStatus[item] != 'N/A').length;

  int get _completedChecklistCount =>
      _preStartChecklistItems.where((item) => _checklistStatus[item] == 'Completed').length;

  String get _autoReadinessStatus {
    final percent = _completionPercent;
    if (percent == 100) return 'READY FOR MOBILIZATION';
    if (percent >= 80) return 'CONDITIONALLY READY';
    return 'NOT READY';
  }

  Color get _autoReadinessColor {
    switch (_autoReadinessStatus) {
      case 'READY FOR MOBILIZATION':
        return primaryGreen;
      case 'CONDITIONALLY READY':
        return Colors.orange.shade800;
      default:
        return Colors.red.shade700;
    }
  }


  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: darkGreen,
        title: const Text(
          'Project Pre-Start',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        actions: [
          IconButton(
            tooltip: 'Reset',
            onPressed: _hasSavedProject ? _resetProject : null,
            icon: const Icon(Icons.restart_alt_rounded),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
          children: [
            _ReadinessCard(
              percent: _completionPercent,
              profileCompleted: _profileCompletedCount,
              profileTotal: 16,
              documentsApproved: _approvedDocumentCount,
              documentsTotal: _documentNames.length,
              checklistCompleted: _completedChecklistCount,
              checklistTotal: _applicableChecklistCount,
              autoStatus: _autoReadinessStatus,
              autoStatusColor: _autoReadinessColor,
            ),
            const SizedBox(height: 14),
            _SectionCard(
              title: 'Readiness Review & Approval',
              icon: Icons.verified_user_outlined,
              children: [
                _ReadinessReviewBanner(
                  status: _autoReadinessStatus,
                  color: _autoReadinessColor,
                  approval: _readinessApproval,
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  initialValue: _readinessApproval,
                  decoration: _inputDecoration(
                    'HSE Readiness Approval',
                    Icons.approval_outlined,
                  ),
                  items: const [
                    DropdownMenuItem(value: 'Not Reviewed', child: Text('Not Reviewed')),
                    DropdownMenuItem(value: 'Pending Approval', child: Text('Pending Approval')),
                    DropdownMenuItem(value: 'Conditionally Approved', child: Text('Conditionally Approved')),
                    DropdownMenuItem(value: 'Approved for Mobilization', child: Text('Approved for Mobilization')),
                    DropdownMenuItem(value: 'Rejected / Action Required', child: Text('Rejected / Action Required')),
                  ],
                  onChanged: (value) {
                    if (value != null) setState(() => _readinessApproval = value);
                  },
                ),
                _textField(
                  controller: _readinessReviewerController,
                  label: 'Reviewed / Approved By',
                  hint: 'Enter HSE Manager / authorized reviewer',
                  icon: Icons.person_outline,
                ),
                _dateField(
                  label: 'Readiness Review Date',
                  date: _readinessReviewDate,
                  onTap: () async {
                    final now = DateTime.now();
                    final selected = await showDatePicker(
                      context: context,
                      firstDate: DateTime(now.year - 5),
                      lastDate: DateTime(now.year + 20),
                      initialDate: _readinessReviewDate ?? now,
                    );
                    if (selected != null) {
                      setState(() => _readinessReviewDate = selected);
                    }
                  },
                ),
                _textField(
                  controller: _readinessRemarksController,
                  label: 'Readiness Review Remarks',
                  hint: 'Record pending actions, conditions, approval notes or evidence',
                  icon: Icons.notes_outlined,
                  maxLines: 3,
                ),
              ],
            ),
            const SizedBox(height: 16),
            _SectionCard(
              title: 'Final Review & Handover',
              icon: Icons.assignment_turned_in_outlined,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: (_finalReviewStatus == 'Completed' ? primaryGreen : Colors.orange).withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: (_finalReviewStatus == 'Completed' ? primaryGreen : Colors.orange).withValues(alpha: 0.20),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        _finalReviewStatus == 'Completed' ? Icons.check_circle_outline : Icons.pending_actions_outlined,
                        color: _finalReviewStatus == 'Completed' ? primaryGreen : Colors.orange,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          _finalReviewStatus == 'Completed'
                              ? 'Project Pre-Start review completed. Ready for Phase 2 handover.'
                              : 'Complete the final review after checking all Step 1 requirements.',
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  initialValue: _finalReviewStatus,
                  decoration: _inputDecoration('Final Review Status', Icons.fact_check_outlined),
                  items: const [
                    DropdownMenuItem(value: 'Not Completed', child: Text('Not Completed')),
                    DropdownMenuItem(value: 'Reviewed - Actions Pending', child: Text('Reviewed - Actions Pending')),
                    DropdownMenuItem(value: 'Completed', child: Text('Completed')),
                  ],
                  onChanged: (value) {
                    if (value != null) setState(() => _finalReviewStatus = value);
                  },
                ),
                _textField(
                  controller: _finalReviewerController,
                  label: 'Final Reviewer / Handover By',
                  hint: 'Enter authorized HSE Manager / Project Manager',
                  icon: Icons.person_pin_outlined,
                ),
                _dateField(
                  label: 'Final Review Date',
                  date: _finalReviewDate,
                  onTap: () async {
                    final now = DateTime.now();
                    final selected = await showDatePicker(
                      context: context,
                      firstDate: DateTime(now.year - 5),
                      lastDate: DateTime(now.year + 20),
                      initialDate: _finalReviewDate ?? now,
                    );
                    if (selected != null) setState(() => _finalReviewDate = selected);
                  },
                ),
                _textField(
                  controller: _handoverRemarksController,
                  label: 'Final Review / Handover Remarks',
                  hint: 'Record final actions, conditions, handover notes or references',
                  icon: Icons.notes_outlined,
                  maxLines: 4,
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.all(11),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'Handover rule: mark Completed only after the Project Profile, HSE documents, emergency arrangements and pre-start checklist have been reviewed.',
                    style: TextStyle(fontSize: 11, color: Colors.black54, height: 1.35),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _SectionCard(
              title: 'Project Profile',
              icon: Icons.folder_copy_outlined,
              children: [
                _textField(
                  controller: _projectNameController,
                  label: 'Project Name',
                  hint: 'Enter project name',
                  icon: Icons.business_center_outlined,
                  requiredField: true,
                ),
                _textField(
                  controller: _contractNumberController,
                  label: 'Project / Contract No.',
                  hint: 'Enter contract or project number',
                  icon: Icons.numbers_outlined,
                  requiredField: true,
                ),
                _textField(
                  controller: _clientController,
                  label: 'Client / Principal',
                  hint: 'Enter client name',
                  icon: Icons.account_balance_outlined,
                  requiredField: true,
                ),
                _textField(
                  controller: _contractorController,
                  label: 'Main Contractor',
                  hint: 'Enter main contractor name',
                  icon: Icons.engineering_outlined,
                  requiredField: true,
                ),
              ],
            ),
            const SizedBox(height: 14),
            _SectionCard(
              title: 'Project Parties & Team',
              icon: Icons.groups_2_outlined,
              children: [
                _textField(
                  controller: _consultantController,
                  label: 'Consultant',
                  hint: 'Enter consultant / supervision consultant',
                  icon: Icons.account_balance_outlined,
                ),
                _textField(
                  controller: _subcontractorController,
                  label: 'Subcontractor',
                  hint: 'Enter principal subcontractor, if applicable',
                  icon: Icons.handyman_outlined,
                ),
                _textField(
                  controller: _projectManagerController,
                  label: 'Project Manager',
                  hint: 'Enter project manager name',
                  icon: Icons.manage_accounts_outlined,
                ),
                _textField(
                  controller: _siteManagerController,
                  label: 'Site Manager',
                  hint: 'Enter site manager name',
                  icon: Icons.engineering_outlined,
                ),
                _textField(
                  controller: _constructionManagerController,
                  label: 'Construction Manager',
                  hint: 'Enter construction manager name',
                  icon: Icons.construction_outlined,
                ),
              ],
            ),
            const SizedBox(height: 14),
            _SectionCard(
              title: 'HSE Team & Emergency Response',
              icon: Icons.health_and_safety_outlined,
              children: [
                _textField(
                  controller: _hseManagerController,
                  label: 'HSE Manager',
                  hint: 'Enter HSE manager name',
                  icon: Icons.health_and_safety_outlined,
                  requiredField: true,
                ),
                _textField(
                  controller: _hseOfficerController,
                  label: 'HSE Officer',
                  hint: 'Enter HSE officer name',
                  icon: Icons.verified_user_outlined,
                  requiredField: true,
                ),
                _textField(
                  controller: _hseSupervisorController,
                  label: 'HSE Supervisor',
                  hint: 'Enter HSE supervisor name, if applicable',
                  icon: Icons.supervisor_account_outlined,
                ),
                _textField(
                  controller: _hseCoordinatorController,
                  label: 'HSE Coordinator',
                  hint: 'Enter HSE coordinator name, if applicable',
                  icon: Icons.badge_outlined,
                ),
                _textField(
                  controller: _emergencyContactNameController,
                  label: 'Primary Emergency Contact',
                  hint: 'Enter primary project emergency contact',
                  icon: Icons.contact_emergency_outlined,
                  requiredField: true,
                ),
                _textField(
                  controller: _emergencyContactPhoneController,
                  label: 'Emergency Contact Phone',
                  hint: 'Enter project emergency contact phone number',
                  icon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                  requiredField: true,
                ),
                _textField(
                  controller: _ambulanceController,
                  label: 'Ambulance / Medical Emergency',
                  hint: 'Enter local ambulance / medical emergency contact',
                  icon: Icons.local_hospital_outlined,
                  keyboardType: TextInputType.phone,
                ),
                _textField(
                  controller: _fireRescueController,
                  label: 'Fire & Rescue',
                  hint: 'Enter fire and rescue emergency contact',
                  icon: Icons.local_fire_department_outlined,
                  keyboardType: TextInputType.phone,
                ),
                _textField(
                  controller: _policeController,
                  label: 'Police',
                  hint: 'Enter police emergency contact',
                  icon: Icons.local_police_outlined,
                  keyboardType: TextInputType.phone,
                ),
                _textField(
                  controller: _nearestHospitalController,
                  label: 'Nearest Hospital / Clinic',
                  hint: 'Enter nearest hospital or clinic name and contact',
                  icon: Icons.local_hospital_outlined,
                  maxLines: 2,
                ),
                _textField(
                  controller: _assemblyPointController,
                  label: 'Emergency Assembly Point',
                  hint: 'Enter muster / assembly point location',
                  icon: Icons.meeting_room_outlined,
                  requiredField: true,
                  maxLines: 2,
                ),
              ],
            ),
            const SizedBox(height: 14),
            _SectionCard(
              title: 'Project Location & Jurisdiction',
              icon: Icons.location_city_outlined,
              children: [
                _textField(
                  controller: _cityController,
                  label: 'City',
                  hint: 'Enter project city',
                  icon: Icons.location_city_outlined,
                  requiredField: true,
                ),
                _textField(
                  controller: _areaController,
                  label: 'Area / Site Location',
                  hint: 'Enter area, district or site name',
                  icon: Icons.place_outlined,
                  requiredField: true,
                ),
                _textField(
                  controller: _locationController,
                  label: 'Full Project Address / Location',
                  hint: 'Enter detailed project address or site location',
                  icon: Icons.location_on_outlined,
                  requiredField: true,
                  maxLines: 2,
                ),
                _dropdownField(),
              ],
            ),
            const SizedBox(height: 14),
            _SectionCard(
              title: 'Project Schedule & Scope',
              icon: Icons.event_note_outlined,
              children: [
                _dateField(
                  label: 'Planned Start Date',
                  date: _plannedStartDate,
                  onTap: _pickStartDate,
                  requiredField: true,
                ),
                _dateField(
                  label: 'Planned End Date',
                  date: _plannedEndDate,
                  onTap: _pickEndDate,
                  requiredField: true,
                ),
                if (_plannedStartDate != null && _plannedEndDate != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: primaryGreen.withValues(alpha: 0.07),
                        borderRadius: BorderRadius.circular(13),
                        border: Border.all(
                          color: primaryGreen.withValues(alpha: 0.12),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.timelapse_outlined,
                            color: darkGreen,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Planned Duration: ${_plannedEndDate!.difference(_plannedStartDate!).inDays + 1} days',
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                              color: darkGreen,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                _textField(
                  controller: _scopeController,
                  label: 'Scope of Work',
                  hint: 'Briefly describe the project scope',
                  icon: Icons.description_outlined,
                  maxLines: 5,
                  requiredField: true,
                ),
                _textField(
                  controller: _mainActivitiesController,
                  label: 'Main Activities / Work Categories',
                  hint: 'List major activities, e.g. civil, MEP, lifting, excavation',
                  icon: Icons.list_alt_outlined,
                  maxLines: 4,
                  requiredField: true,
                ),
                DropdownButtonFormField<String>(
                  initialValue: _status,
                  decoration: _inputDecoration(
                    'Project Status',
                    Icons.flag_outlined,
                  ),
                  items: const [
                    DropdownMenuItem(value: 'Pre-Start', child: Text('Pre-Start')),
                    DropdownMenuItem(value: 'Ready', child: Text('Ready')),
                    DropdownMenuItem(value: 'Active', child: Text('Active')),
                    DropdownMenuItem(value: 'On Hold', child: Text('On Hold')),
                    DropdownMenuItem(value: 'Closed', child: Text('Closed')),
                  ],
                  onChanged: (value) {
                    if (value != null) setState(() => _status = value);
                  },
                ),
              ],
            ),
            const SizedBox(height: 14),
            _SectionCard(
              title: 'Required HSE Documents',
              icon: Icons.folder_special_outlined,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                    'Track key pre-start HSE documents. Mark each document status and add a reference number or review date when available.',
                    style: TextStyle(fontSize: 12, color: Colors.black54, height: 1.4),
                  ),
                ),
                ..._documentNames.map(_documentRow),
              ],
            ),
            const SizedBox(height: 14),
            _SectionCard(
              title: 'Pre-Start HSE Checklist',
              icon: Icons.fact_check_outlined,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Complete the project readiness checks before site work starts.',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
                            height: 1.4,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: primaryGreen.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '$_checklistCompletedCount/${_preStartChecklistItems.length}',
                          style: const TextStyle(
                            color: darkGreen,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ..._preStartChecklistItems.map(_checklistRow),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 52,
              child: FilledButton.icon(
                onPressed: _isSaving ? null : _saveProject,
                icon: _isSaving
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.save_outlined),
                label: Text(
                  _isSaving ? 'SAVING...' : 'SAVE PROJECT PROFILE',
                  style: const TextStyle(fontWeight: FontWeight.w800),
                ),
                style: FilledButton.styleFrom(
                  backgroundColor: primaryGreen,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _checklistRow(String item) {
    final status = _checklistStatus[item] ?? 'Not Completed';
    final controller = _checklistRemarksControllers[item]!;
    const statuses = ['Not Completed', 'Completed', 'N/A'];

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFFF9FBFA),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                color: darkGreen,
                height: 1.35,
              ),
            ),
            const SizedBox(height: 9),
            DropdownButtonFormField<String>(
              initialValue: statuses.contains(status) ? status : 'Not Completed',
              decoration: _inputDecoration(
                'Checklist Status',
                Icons.fact_check_outlined,
              ),
              items: statuses
                  .map((value) => DropdownMenuItem(
                        value: value,
                        child: Text(value),
                      ))
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() => _checklistStatus[item] = value);
                }
              },
            ),
            const SizedBox(height: 9),
            TextFormField(
              controller: controller,
              decoration: _inputDecoration(
                'Remarks / Evidence',
                Icons.notes_outlined,
              ).copyWith(
                hintText: 'Add responsible person, reference, or observation',
              ),
              maxLines: 2,
              onChanged: (_) => setState(() {}),
            ),
          ],
        ),
      ),
    );
  }

  Widget _documentRow(String name) {
    final status = _documentStatus[name] ?? 'Pending';
    final controller = _documentReferenceControllers[name]!;
    final reviewDate = _documentReviewDates[name];
    const statuses = ['Pending', 'Available', 'Under Review', 'Approved', 'Not Available'];

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFFF9FBFA),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.description_outlined, color: darkGreen, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    name,
                    style: const TextStyle(fontWeight: FontWeight.w800, color: darkGreen),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 9),
            DropdownButtonFormField<String>(
              initialValue: statuses.contains(status) ? status : 'Pending',
              decoration: _inputDecoration('Document Status', Icons.fact_check_outlined),
              items: statuses
                  .map((item) => DropdownMenuItem(value: item, child: Text(item)))
                  .toList(),
              onChanged: (value) {
                if (value != null) setState(() => _documentStatus[name] = value);
              },
            ),
            const SizedBox(height: 9),
            TextFormField(
              controller: controller,
              decoration: _inputDecoration(
                'Document Reference / Revision',
                Icons.tag_outlined,
              ).copyWith(hintText: 'e.g. HSE-PLAN-001 Rev.02'),
              textCapitalization: TextCapitalization.characters,
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 9),
            InkWell(
              onTap: () async {
                final now = DateTime.now();
                final selected = await showDatePicker(
                  context: context,
                  firstDate: DateTime(now.year - 5),
                  lastDate: DateTime(now.year + 20),
                  initialDate: reviewDate ?? now,
                );
                if (selected != null) {
                  setState(() => _documentReviewDates[name] = selected);
                }
              },
              borderRadius: BorderRadius.circular(13),
              child: InputDecorator(
                decoration: _inputDecoration(
                  'Review / Approval Date',
                  Icons.event_available_outlined,
                ),
                child: Text(
                  _dateText(reviewDate),
                  style: TextStyle(
                    color: reviewDate == null ? Colors.grey.shade600 : Colors.black87,
                    fontWeight: reviewDate == null ? FontWeight.w400 : FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: darkGreen),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(13),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(13),
        borderSide: BorderSide(color: Colors.grey.shade200),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(13),
        borderSide: const BorderSide(color: primaryGreen, width: 1.4),
      ),
    );
  }

  Widget _textField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    bool requiredField = false,
    int maxLines = 1,
    TextInputType? keyboardType,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: keyboardType,
        textCapitalization: TextCapitalization.sentences,
        decoration: _inputDecoration(label, icon).copyWith(hintText: hint),
        validator: requiredField
            ? (value) {
                if (value == null || value.trim().isEmpty) {
                  return '$label is required';
                }
                return null;
              }
            : null,
        onChanged: (_) => setState(() {}),
      ),
    );
  }

  Widget _dropdownField() {
    const emirates = [
      'Abu Dhabi',
      'Dubai',
      'Sharjah',
      'Ajman',
      'Umm Al Quwain',
      'Ras Al Khaimah',
      'Fujairah',
    ];

    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: DropdownButtonFormField<String>(
        initialValue: _emirate,
        decoration: _inputDecoration(
          'Emirate / Jurisdiction',
          Icons.map_outlined,
        ),
        items: emirates
            .map((item) => DropdownMenuItem(value: item, child: Text(item)))
            .toList(),
        onChanged: (value) {
          if (value != null) setState(() => _emirate = value);
        },
      ),
    );
  }

  Widget _dateField({
    required String label,
    required DateTime? date,
    required VoidCallback onTap,
    bool requiredField = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(13),
        child: InputDecorator(
          decoration: _inputDecoration(label, Icons.calendar_month_outlined),
          child: Text(
            _dateText(date),
            style: TextStyle(
              color: date == null ? Colors.grey.shade600 : Colors.black87,
              fontWeight: date == null ? FontWeight.w400 : FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

class _ReadinessCard extends StatelessWidget {
  final int percent;
  final int profileCompleted;
  final int profileTotal;
  final int documentsApproved;
  final int documentsTotal;
  final int checklistCompleted;
  final int checklistTotal;
  final String autoStatus;
  final Color autoStatusColor;

  const _ReadinessCard({
    required this.percent,
    required this.profileCompleted,
    required this.profileTotal,
    required this.documentsApproved,
    required this.documentsTotal,
    required this.checklistCompleted,
    required this.checklistTotal,
    required this.autoStatus,
    required this.autoStatusColor,
  });

  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);

  @override
  Widget build(BuildContext context) {
    final ready = percent == 100;
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: primaryGreen.withValues(alpha: 0.12)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: primaryGreen.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: const Icon(Icons.verified_outlined, color: darkGreen),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Project Profile Readiness',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: darkGreen,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      'Complete the required project information.',
                      style: TextStyle(fontSize: 12, color: Colors.black54),
                    ),
                  ],
                ),
              ),
              Text(
                '$percent%',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: primaryGreen,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              minHeight: 9,
              value: percent / 100,
              backgroundColor: Colors.grey.shade200,
              valueColor: const AlwaysStoppedAnimation<Color>(primaryGreen),
            ),
          ),
          const SizedBox(height: 9),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            decoration: BoxDecoration(
              color: autoStatusColor.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              autoStatus,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w900,
                color: autoStatusColor,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _Metric(label: 'Profile', value: '$profileCompleted/$profileTotal')),
              Expanded(child: _Metric(label: 'Documents', value: '$documentsApproved/$documentsTotal')),
              Expanded(child: _Metric(label: 'Checklist', value: '$checklistCompleted/$checklistTotal')),
            ],
          ),
          const SizedBox(height: 9),
          Text(
            ready ? 'All tracked readiness requirements are complete.' : 'Review the pending items before mobilization.',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: ready ? primaryGreen : Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  final String label;
  final String value;

  const _Metric({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w900, color: _ReadinessCard.darkGreen)),
        const SizedBox(height: 2),
        Text(label, style: const TextStyle(fontSize: 10, color: Colors.black54)),
      ],
    );
  }
}

class _ReadinessReviewBanner extends StatelessWidget {
  final String status;
  final Color color;
  final String approval;

  const _ReadinessReviewBanner({
    required this.status,
    required this.color,
    required this.approval,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.20)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.fact_check_outlined, color: color),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(status, style: TextStyle(fontWeight: FontWeight.w900, color: color)),
                const SizedBox(height: 3),
                Text('Approval: $approval', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Widget> children;

  const _SectionCard({
    required this.title,
    required this.icon,
    required this.children,
  });

  static const Color darkGreen = Color(0xFF0B5D4B);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 15, 14, 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: darkGreen, size: 21),
              const SizedBox(width: 9),
              Text(
                title,
                style: const TextStyle(
                  color: darkGreen,
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ...children,
        ],
      ),
    );
  }
}
