import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// SafeNexus HSE - Step 2B
/// HSE Plan module.
///
/// Self-contained module for the HSE Management System.
/// It can be connected to WorkHub Phase 2 after this file is verified
/// with GitHub Actions.
class HsePlanPage extends StatefulWidget {
  const HsePlanPage({super.key});

  @override
  State<HsePlanPage> createState() => _HsePlanPageState();
}

class _HsePlanPageState extends State<HsePlanPage> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);

  final _formKey = GlobalKey<FormState>();

  final _planNoController = TextEditingController();
  final _revisionController = TextEditingController();
  final _companyController = TextEditingController();
  final _projectController = TextEditingController();
  final _locationController = TextEditingController();
  final _emirateController = TextEditingController();
  final _ownerController = TextEditingController();

  final _scopeController = TextEditingController();
  final _objectivesController = TextEditingController();
  final _organizationController = TextEditingController();
  final _riskController = TextEditingController();
  final _ptwController = TextEditingController();
  final _trainingController = TextEditingController();
  final _ppeController = TextEditingController();
  final _inspectionController = TextEditingController();
  final _emergencyController = TextEditingController();
  final _healthController = TextEditingController();
  final _environmentController = TextEditingController();
  final _chemicalWasteController = TextEditingController();
  final _incidentController = TextEditingController();
  final _reportingController = TextEditingController();
  final _legalController = TextEditingController();
  final _proceduresController = TextEditingController();

  final _preparedController = TextEditingController();
  final _reviewedController = TextEditingController();
  final _approvedController = TextEditingController();

  String _status = 'Draft';
  DateTime? _effectiveDate;
  DateTime? _reviewDate;
  bool _isSaving = false;
  bool _loaded = false;

  static const String _prefix = 'safenexus_hse_plan_';

  static const String _keyPlanNo = '${_prefix}plan_no';
  static const String _keyRevision = '${_prefix}revision';
  static const String _keyCompany = '${_prefix}company';
  static const String _keyProject = '${_prefix}project';
  static const String _keyLocation = '${_prefix}location';
  static const String _keyEmirate = '${_prefix}emirate';
  static const String _keyOwner = '${_prefix}owner';

  static const String _keyScope = '${_prefix}scope';
  static const String _keyObjectives = '${_prefix}objectives';
  static const String _keyOrganization = '${_prefix}organization';
  static const String _keyRisk = '${_prefix}risk';
  static const String _keyPtw = '${_prefix}ptw';
  static const String _keyTraining = '${_prefix}training';
  static const String _keyPpe = '${_prefix}ppe';
  static const String _keyInspection = '${_prefix}inspection';
  static const String _keyEmergency = '${_prefix}emergency';
  static const String _keyHealth = '${_prefix}health';
  static const String _keyEnvironment = '${_prefix}environment';
  static const String _keyChemicalWaste = '${_prefix}chemical_waste';
  static const String _keyIncident = '${_prefix}incident';
  static const String _keyReporting = '${_prefix}reporting';
  static const String _keyLegal = '${_prefix}legal';
  static const String _keyProcedures = '${_prefix}procedures';

  static const String _keyPrepared = '${_prefix}prepared';
  static const String _keyReviewed = '${_prefix}reviewed';
  static const String _keyApproved = '${_prefix}approved';

  static const String _keyStatus = '${_prefix}status';
  static const String _keyEffectiveDate = '${_prefix}effective_date';
  static const String _keyReviewDate = '${_prefix}review_date';

  List<TextEditingController> get _allControllers => [
        _planNoController,
        _revisionController,
        _companyController,
        _projectController,
        _locationController,
        _emirateController,
        _ownerController,
        _scopeController,
        _objectivesController,
        _organizationController,
        _riskController,
        _ptwController,
        _trainingController,
        _ppeController,
        _inspectionController,
        _emergencyController,
        _healthController,
        _environmentController,
        _chemicalWasteController,
        _incidentController,
        _reportingController,
        _legalController,
        _proceduresController,
        _preparedController,
        _reviewedController,
        _approvedController,
      ];

  @override
  void initState() {
    super.initState();
    _loadPlan();
  }

  @override
  void dispose() {
    for (final controller in _allControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _loadPlan() async {
    final prefs = await SharedPreferences.getInstance();

    if (!mounted) return;

    setState(() {
      _planNoController.text =
          prefs.getString(_keyPlanNo) ?? 'HSE-PLAN-001';
      _revisionController.text =
          prefs.getString(_keyRevision) ?? 'Rev. 00';
      _companyController.text = prefs.getString(_keyCompany) ?? '';
      _projectController.text = prefs.getString(_keyProject) ?? '';
      _locationController.text = prefs.getString(_keyLocation) ?? '';
      _emirateController.text = prefs.getString(_keyEmirate) ?? '';
      _ownerController.text = prefs.getString(_keyOwner) ?? '';

      _scopeController.text = prefs.getString(_keyScope) ?? '';
      _objectivesController.text = prefs.getString(_keyObjectives) ?? '';
      _organizationController.text =
          prefs.getString(_keyOrganization) ?? '';
      _riskController.text = prefs.getString(_keyRisk) ?? '';
      _ptwController.text = prefs.getString(_keyPtw) ?? '';
      _trainingController.text = prefs.getString(_keyTraining) ?? '';
      _ppeController.text = prefs.getString(_keyPpe) ?? '';
      _inspectionController.text = prefs.getString(_keyInspection) ?? '';
      _emergencyController.text = prefs.getString(_keyEmergency) ?? '';
      _healthController.text = prefs.getString(_keyHealth) ?? '';
      _environmentController.text =
          prefs.getString(_keyEnvironment) ?? '';
      _chemicalWasteController.text =
          prefs.getString(_keyChemicalWaste) ?? '';
      _incidentController.text = prefs.getString(_keyIncident) ?? '';
      _reportingController.text = prefs.getString(_keyReporting) ?? '';
      _legalController.text = prefs.getString(_keyLegal) ?? '';
      _proceduresController.text = prefs.getString(_keyProcedures) ?? '';

      _preparedController.text = prefs.getString(_keyPrepared) ?? '';
      _reviewedController.text = prefs.getString(_keyReviewed) ?? '';
      _approvedController.text = prefs.getString(_keyApproved) ?? '';

      _status = prefs.getString(_keyStatus) ?? 'Draft';

      final effective = prefs.getString(_keyEffectiveDate);
      final review = prefs.getString(_keyReviewDate);

      _effectiveDate =
          effective == null ? null : DateTime.tryParse(effective);
      _reviewDate = review == null ? null : DateTime.tryParse(review);

      _loaded = true;
    });
  }

  Future<void> _savePlan() async {
    if (!_formKey.currentState!.validate()) return;

    if (_effectiveDate == null) {
      _showMessage('Please select the HSE Plan effective date.');
      return;
    }

    if (_reviewDate != null && _reviewDate!.isBefore(_effectiveDate!)) {
      _showMessage('Review date cannot be before the effective date.');
      return;
    }

    if (_status == 'Approved' && _approvedController.text.trim().isEmpty) {
      _showMessage('Approved By is required for an Approved HSE Plan.');
      return;
    }

    setState(() => _isSaving = true);

    final prefs = await SharedPreferences.getInstance();

    final values = <String, String>{
      _keyPlanNo: _planNoController.text.trim(),
      _keyRevision: _revisionController.text.trim(),
      _keyCompany: _companyController.text.trim(),
      _keyProject: _projectController.text.trim(),
      _keyLocation: _locationController.text.trim(),
      _keyEmirate: _emirateController.text.trim(),
      _keyOwner: _ownerController.text.trim(),
      _keyScope: _scopeController.text.trim(),
      _keyObjectives: _objectivesController.text.trim(),
      _keyOrganization: _organizationController.text.trim(),
      _keyRisk: _riskController.text.trim(),
      _keyPtw: _ptwController.text.trim(),
      _keyTraining: _trainingController.text.trim(),
      _keyPpe: _ppeController.text.trim(),
      _keyInspection: _inspectionController.text.trim(),
      _keyEmergency: _emergencyController.text.trim(),
      _keyHealth: _healthController.text.trim(),
      _keyEnvironment: _environmentController.text.trim(),
      _keyChemicalWaste: _chemicalWasteController.text.trim(),
      _keyIncident: _incidentController.text.trim(),
      _keyReporting: _reportingController.text.trim(),
      _keyLegal: _legalController.text.trim(),
      _keyProcedures: _proceduresController.text.trim(),
      _keyPrepared: _preparedController.text.trim(),
      _keyReviewed: _reviewedController.text.trim(),
      _keyApproved: _approvedController.text.trim(),
      _keyStatus: _status,
    };

    for (final entry in values.entries) {
      await prefs.setString(entry.key, entry.value);
    }

    if (_effectiveDate != null) {
      await prefs.setString(
        _keyEffectiveDate,
        _effectiveDate!.toIso8601String(),
      );
    } else {
      await prefs.remove(_keyEffectiveDate);
    }

    if (_reviewDate != null) {
      await prefs.setString(
        _keyReviewDate,
        _reviewDate!.toIso8601String(),
      );
    } else {
      await prefs.remove(_keyReviewDate);
    }

    if (!mounted) return;

    setState(() => _isSaving = false);
    _showMessage('HSE Plan saved successfully.');
  }

  Future<void> _resetPlan() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Reset HSE Plan?'),
          content: const Text(
            'This will clear the saved Step 2B HSE Plan information.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              child: const Text('Reset'),
            ),
          ],
        );
      },
    );

    if (confirmed != true) return;

    final prefs = await SharedPreferences.getInstance();

    for (final key in [
      _keyPlanNo,
      _keyRevision,
      _keyCompany,
      _keyProject,
      _keyLocation,
      _keyEmirate,
      _keyOwner,
      _keyScope,
      _keyObjectives,
      _keyOrganization,
      _keyRisk,
      _keyPtw,
      _keyTraining,
      _keyPpe,
      _keyInspection,
      _keyEmergency,
      _keyHealth,
      _keyEnvironment,
      _keyChemicalWaste,
      _keyIncident,
      _keyReporting,
      _keyLegal,
      _keyProcedures,
      _keyPrepared,
      _keyReviewed,
      _keyApproved,
      _keyStatus,
      _keyEffectiveDate,
      _keyReviewDate,
    ]) {
      await prefs.remove(key);
    }

    if (!mounted) return;

    setState(() {
      _planNoController.text = 'HSE-PLAN-001';
      _revisionController.text = 'Rev. 00';
      _companyController.clear();
      _projectController.clear();
      _locationController.clear();
      _emirateController.clear();
      _ownerController.clear();

      _scopeController.clear();
      _objectivesController.clear();
      _organizationController.clear();
      _riskController.clear();
      _ptwController.clear();
      _trainingController.clear();
      _ppeController.clear();
      _inspectionController.clear();
      _emergencyController.clear();
      _healthController.clear();
      _environmentController.clear();
      _chemicalWasteController.clear();
      _incidentController.clear();
      _reportingController.clear();
      _legalController.clear();
      _proceduresController.clear();

      _preparedController.clear();
      _reviewedController.clear();
      _approvedController.clear();

      _status = 'Draft';
      _effectiveDate = null;
      _reviewDate = null;
    });

    _showMessage('HSE Plan reset.');
  }

  Future<void> _pickDate({required bool effective}) async {
    final initialDate = effective
        ? (_effectiveDate ?? DateTime.now())
        : (_reviewDate ?? _effectiveDate ?? DateTime.now());

    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (picked == null || !mounted) return;

    setState(() {
      if (effective) {
        _effectiveDate = picked;
        if (_reviewDate != null && _reviewDate!.isBefore(picked)) {
          _reviewDate = null;
        }
      } else {
        _reviewDate = picked;
      }
    });
  }

  void _showMessage(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  int get _completionPercent {
    final checks = <bool>[
      _planNoController.text.trim().isNotEmpty,
      _revisionController.text.trim().isNotEmpty,
      _companyController.text.trim().isNotEmpty,
      _projectController.text.trim().isNotEmpty,
      _locationController.text.trim().isNotEmpty,
      _emirateController.text.trim().isNotEmpty,
      _ownerController.text.trim().isNotEmpty,
      _effectiveDate != null,
      _scopeController.text.trim().isNotEmpty,
      _objectivesController.text.trim().isNotEmpty,
      _organizationController.text.trim().isNotEmpty,
      _riskController.text.trim().isNotEmpty,
      _ptwController.text.trim().isNotEmpty,
      _trainingController.text.trim().isNotEmpty,
      _ppeController.text.trim().isNotEmpty,
      _inspectionController.text.trim().isNotEmpty,
      _emergencyController.text.trim().isNotEmpty,
      _healthController.text.trim().isNotEmpty,
      _environmentController.text.trim().isNotEmpty,
      _chemicalWasteController.text.trim().isNotEmpty,
      _incidentController.text.trim().isNotEmpty,
      _reportingController.text.trim().isNotEmpty,
      _legalController.text.trim().isNotEmpty,
      _proceduresController.text.trim().isNotEmpty,
      _preparedController.text.trim().isNotEmpty,
      _reviewedController.text.trim().isNotEmpty,
    ];

    final completed = checks.where((value) => value).length;
    return ((completed / checks.length) * 100).round();
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'Approved':
        return Colors.green;
      case 'Under Review':
        return Colors.orange;
      case 'Superseded':
        return Colors.grey;
      default:
        return Colors.blueGrey;
    }
  }

  InputDecoration _decoration(String label, {String? hint}) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
    );
  }

  Widget _textField(
    TextEditingController controller,
    String label, {
    bool required = false,
    int maxLines = 1,
    String? hint,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        decoration: _decoration(label, hint: hint),
        validator: required
            ? (value) {
                if (value == null || value.trim().isEmpty) {
                  return '$label is required';
                }
                return null;
              }
            : null,
      ),
    );
  }

  Widget _dateField({
    required String label,
    required DateTime? date,
    required VoidCallback onTap,
    required bool required,
  }) {
    final text = date == null
        ? ''
        : '${date.day.toString().padLeft(2, '0')}/'
            '${date.month.toString().padLeft(2, '0')}/'
            '${date.year}';

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: InputDecorator(
          decoration: _decoration(label).copyWith(
            suffixIcon: const Icon(Icons.calendar_today_outlined),
          ),
          child: Text(
            text.isEmpty ? (required ? 'Select date' : 'Not set') : text,
            style: TextStyle(
              color: text.isEmpty ? Colors.grey.shade600 : Colors.black87,
            ),
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 10),
      child: Row(
        children: [
          Icon(icon, color: primaryGreen),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w800,
                color: darkGreen,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusCard() {
    final statusColor = _statusColor(_status);

    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: primaryGreen.withValues(alpha: 0.10),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.assignment_outlined,
                    color: primaryGreen,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    'HSE Plan Readiness',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      color: darkGreen,
                    ),
                  ),
                ),
                Text(
                  '$_completionPercent%',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: primaryGreen,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: LinearProgressIndicator(
                value: _completionPercent / 100,
                minHeight: 8,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Text(
                  'Status:',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    _status,
                    style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.w800,
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

  Widget _infoNote() {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Padding(
        padding: EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.info_outline,
              color: primaryGreen,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                'Use this plan to define the project HSE management arrangements. '
                'Keep the approved revision available to the project team and '
                'review it when project conditions or requirements change.',
                style: TextStyle(height: 1.4),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!_loaded) {
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
          'HSE Plan',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        actions: [
          IconButton(
            tooltip: 'Reset',
            onPressed: _resetPlan,
            icon: const Icon(Icons.restart_alt),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
          children: [
            _statusCard(),
            const SizedBox(height: 12),
            _infoNote(),
            const SizedBox(height: 16),

            _sectionTitle(
              'Plan Identification',
              Icons.badge_outlined,
            ),
            _textField(
              _planNoController,
              'HSE Plan Number',
              required: true,
              hint: 'Example: HSE-PLAN-001',
            ),
            _textField(
              _revisionController,
              'Revision',
              required: true,
              hint: 'Example: Rev. 00',
            ),
            _textField(
              _companyController,
              'Company / Organization',
              required: true,
            ),
            _textField(
              _projectController,
              'Project Name',
              required: true,
            ),
            _textField(
              _locationController,
              'Project Location',
              required: true,
            ),
            _textField(
              _emirateController,
              'Emirate / Jurisdiction',
              required: true,
              hint: 'Example: Abu Dhabi / Dubai / Sharjah',
            ),
            _textField(
              _ownerController,
              'HSE Plan Owner',
              required: true,
            ),

            _sectionTitle(
              'Effective Date & Status',
              Icons.event_note_outlined,
            ),
            _dateField(
              label: 'Effective Date',
              date: _effectiveDate,
              onTap: () => _pickDate(effective: true),
              required: true,
            ),
            _dateField(
              label: 'Review Date',
              date: _reviewDate,
              onTap: () => _pickDate(effective: false),
              required: false,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: DropdownButtonFormField<String>(
                initialValue: _status,
                decoration: _decoration('Plan Status'),
                items: const [
                  DropdownMenuItem(
                    value: 'Draft',
                    child: Text('Draft'),
                  ),
                  DropdownMenuItem(
                    value: 'Under Review',
                    child: Text('Under Review'),
                  ),
                  DropdownMenuItem(
                    value: 'Approved',
                    child: Text('Approved'),
                  ),
                  DropdownMenuItem(
                    value: 'Superseded',
                    child: Text('Superseded'),
                  ),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _status = value);
                  }
                },
              ),
            ),

            _sectionTitle(
              'Plan Scope & Objectives',
              Icons.flag_outlined,
            ),
            _textField(
              _scopeController,
              'Scope of HSE Plan',
              required: true,
              maxLines: 5,
            ),
            _textField(
              _objectivesController,
              'HSE Objectives & Targets',
              required: true,
              maxLines: 5,
            ),

            _sectionTitle(
              'HSE Organization & Risk Management',
              Icons.groups_outlined,
            ),
            _textField(
              _organizationController,
              'HSE Organization & Responsibilities',
              required: true,
              maxLines: 5,
            ),
            _textField(
              _riskController,
              'Risk Management / HIRA / JSA / RAMS',
              required: true,
              maxLines: 5,
            ),

            _sectionTitle(
              'Operational HSE Controls',
              Icons.construction_outlined,
            ),
            _textField(
              _ptwController,
              'Permit to Work',
              required: true,
              maxLines: 5,
            ),
            _textField(
              _trainingController,
              'Training & Competency',
              required: true,
              maxLines: 5,
            ),
            _textField(
              _ppeController,
              'PPE & Safety Controls',
              required: true,
              maxLines: 5,
            ),
            _textField(
              _inspectionController,
              'Inspection & Audit',
              required: true,
              maxLines: 5,
            ),

            _sectionTitle(
              'Emergency & Occupational Health',
              Icons.emergency_outlined,
            ),
            _textField(
              _emergencyController,
              'Emergency Preparedness & Response',
              required: true,
              maxLines: 5,
            ),
            _textField(
              _healthController,
              'Occupational Health, Welfare & Heat Stress',
              required: true,
              maxLines: 5,
            ),

            _sectionTitle(
              'Environment & Chemical Management',
              Icons.eco_outlined,
            ),
            _textField(
              _environmentController,
              'Environmental Management',
              required: true,
              maxLines: 5,
            ),
            _textField(
              _chemicalWasteController,
              'Chemical & Waste Management',
              required: true,
              maxLines: 5,
            ),

            _sectionTitle(
              'Incident & HSE Reporting',
              Icons.report_problem_outlined,
            ),
            _textField(
              _incidentController,
              'Incident Reporting & Investigation',
              required: true,
              maxLines: 5,
            ),
            _textField(
              _reportingController,
              'HSE Reporting & KPI',
              required: true,
              maxLines: 5,
            ),

            _sectionTitle(
              'Legal & Procedures',
              Icons.gavel_outlined,
            ),
            _textField(
              _legalController,
              'UAE Legal / Authority Compliance',
              required: true,
              maxLines: 5,
              hint:
                  'List applicable UAE and jurisdiction-specific requirements.',
            ),
            _textField(
              _proceduresController,
              'Applicable HSE Procedures',
              required: true,
              maxLines: 5,
            ),

            _sectionTitle(
              'Approval & Responsibility',
              Icons.approval_outlined,
            ),
            _textField(
              _preparedController,
              'Prepared By',
              required: true,
            ),
            _textField(
              _reviewedController,
              'Reviewed By',
              required: true,
            ),
            _textField(
              _approvedController,
              'Approved By',
              required: _status == 'Approved',
            ),

            const SizedBox(height: 8),
            SizedBox(
              height: 52,
              child: FilledButton.icon(
                onPressed: _isSaving ? null : _savePlan,
                icon: _isSaving
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      )
                    : const Icon(Icons.save_outlined),
                label: Text(
                  _isSaving ? 'Saving...' : 'Save HSE Plan',
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                style: FilledButton.styleFrom(
                  backgroundColor: primaryGreen,
                ),
              ),
            ),
            const SizedBox(height: 10),
            OutlinedButton.icon(
              onPressed: _resetPlan,
              icon: const Icon(Icons.restart_alt),
              label: const Text('Reset HSE Plan'),
            ),
          ],
        ),
      ),
    );
  }
}
