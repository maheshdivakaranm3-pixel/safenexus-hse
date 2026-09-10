import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// SafeNexus HSE - Step 2A
/// HSE Policy Register & Management
///
/// This module is intentionally self-contained so it can be connected to
/// WorkHub Phase 2 without changing the existing Step 1 implementation.
class HsePolicyPage extends StatefulWidget {
  const HsePolicyPage({super.key});

  @override
  State<HsePolicyPage> createState() => _HsePolicyPageState();
}

class _HsePolicyPageState extends State<HsePolicyPage> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);

  final _formKey = GlobalKey<FormState>();

  final _policyNoController = TextEditingController();
  final _revisionController = TextEditingController();
  final _companyController = TextEditingController();
  final _projectController = TextEditingController();
  final _titleController = TextEditingController();
  final _ownerController = TextEditingController();
  final _statementController = TextEditingController();
  final _commitmentsController = TextEditingController();
  final _legalController = TextEditingController();
  final _workerController = TextEditingController();
  final _environmentController = TextEditingController();
  final _improvementController = TextEditingController();
  final _preparedController = TextEditingController();
  final _reviewedController = TextEditingController();
  final _approvedController = TextEditingController();

  String _status = 'Draft';
  DateTime? _effectiveDate;
  DateTime? _reviewDate;
  bool _isSaving = false;
  bool _loaded = false;

  static const _keyPolicyNo = 'safenexus_hse_policy_no';
  static const _keyRevision = 'safenexus_hse_policy_revision';
  static const _keyCompany = 'safenexus_hse_policy_company';
  static const _keyProject = 'safenexus_hse_policy_project';
  static const _keyTitle = 'safenexus_hse_policy_title';
  static const _keyOwner = 'safenexus_hse_policy_owner';
  static const _keyStatement = 'safenexus_hse_policy_statement';
  static const _keyCommitments = 'safenexus_hse_policy_commitments';
  static const _keyLegal = 'safenexus_hse_policy_legal';
  static const _keyWorker = 'safenexus_hse_policy_worker';
  static const _keyEnvironment = 'safenexus_hse_policy_environment';
  static const _keyImprovement = 'safenexus_hse_policy_improvement';
  static const _keyPrepared = 'safenexus_hse_policy_prepared';
  static const _keyReviewed = 'safenexus_hse_policy_reviewed';
  static const _keyApproved = 'safenexus_hse_policy_approved';
  static const _keyStatus = 'safenexus_hse_policy_status';
  static const _keyEffectiveDate = 'safenexus_hse_policy_effective_date';
  static const _keyReviewDate = 'safenexus_hse_policy_review_date';

  @override
  void initState() {
    super.initState();
    _loadPolicy();
  }

  @override
  void dispose() {
    for (final controller in [
      _policyNoController,
      _revisionController,
      _companyController,
      _projectController,
      _titleController,
      _ownerController,
      _statementController,
      _commitmentsController,
      _legalController,
      _workerController,
      _environmentController,
      _improvementController,
      _preparedController,
      _reviewedController,
      _approvedController,
    ]) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _loadPolicy() async {
    final prefs = await SharedPreferences.getInstance();

    if (!mounted) return;

    setState(() {
      _policyNoController.text = prefs.getString(_keyPolicyNo) ?? 'HSE-POL-001';
      _revisionController.text = prefs.getString(_keyRevision) ?? 'Rev. 00';
      _companyController.text = prefs.getString(_keyCompany) ?? '';
      _projectController.text = prefs.getString(_keyProject) ?? '';
      _titleController.text =
          prefs.getString(_keyTitle) ?? 'Health, Safety & Environment Policy';
      _ownerController.text = prefs.getString(_keyOwner) ?? '';
      _statementController.text = prefs.getString(_keyStatement) ?? '';
      _commitmentsController.text = prefs.getString(_keyCommitments) ?? '';
      _legalController.text = prefs.getString(_keyLegal) ?? '';
      _workerController.text = prefs.getString(_keyWorker) ?? '';
      _environmentController.text = prefs.getString(_keyEnvironment) ?? '';
      _improvementController.text = prefs.getString(_keyImprovement) ?? '';
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

  Future<void> _savePolicy() async {
    if (!_formKey.currentState!.validate()) return;

    if (_effectiveDate == null) {
      _showMessage('Please select the policy effective date.');
      return;
    }

    if (_reviewDate != null && _reviewDate!.isBefore(_effectiveDate!)) {
      _showMessage('Review date cannot be before the effective date.');
      return;
    }

    if (_status == 'Approved' && _approvedController.text.trim().isEmpty) {
      _showMessage('Approved By is required for an Approved policy.');
      return;
    }

    setState(() => _isSaving = true);

    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(_keyPolicyNo, _policyNoController.text.trim());
    await prefs.setString(_keyRevision, _revisionController.text.trim());
    await prefs.setString(_keyCompany, _companyController.text.trim());
    await prefs.setString(_keyProject, _projectController.text.trim());
    await prefs.setString(_keyTitle, _titleController.text.trim());
    await prefs.setString(_keyOwner, _ownerController.text.trim());
    await prefs.setString(_keyStatement, _statementController.text.trim());
    await prefs.setString(_keyCommitments, _commitmentsController.text.trim());
    await prefs.setString(_keyLegal, _legalController.text.trim());
    await prefs.setString(_keyWorker, _workerController.text.trim());
    await prefs.setString(
      _keyEnvironment,
      _environmentController.text.trim(),
    );
    await prefs.setString(
      _keyImprovement,
      _improvementController.text.trim(),
    );
    await prefs.setString(_keyPrepared, _preparedController.text.trim());
    await prefs.setString(_keyReviewed, _reviewedController.text.trim());
    await prefs.setString(_keyApproved, _approvedController.text.trim());
    await prefs.setString(_keyStatus, _status);

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
    _showMessage('HSE Policy saved successfully.');
  }

  Future<void> _resetPolicy() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Reset HSE Policy?'),
          content: const Text(
            'This will clear the saved Step 2A policy information.',
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
      _keyPolicyNo,
      _keyRevision,
      _keyCompany,
      _keyProject,
      _keyTitle,
      _keyOwner,
      _keyStatement,
      _keyCommitments,
      _keyLegal,
      _keyWorker,
      _keyEnvironment,
      _keyImprovement,
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
      _policyNoController.text = 'HSE-POL-001';
      _revisionController.text = 'Rev. 00';
      _companyController.clear();
      _projectController.clear();
      _titleController.text = 'Health, Safety & Environment Policy';
      _ownerController.clear();
      _statementController.clear();
      _commitmentsController.clear();
      _legalController.clear();
      _workerController.clear();
      _environmentController.clear();
      _improvementController.clear();
      _preparedController.clear();
      _reviewedController.clear();
      _approvedController.clear();
      _status = 'Draft';
      _effectiveDate = null;
      _reviewDate = null;
    });

    _showMessage('HSE Policy reset.');
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
      _policyNoController.text.trim().isNotEmpty,
      _revisionController.text.trim().isNotEmpty,
      _companyController.text.trim().isNotEmpty,
      _titleController.text.trim().isNotEmpty,
      _ownerController.text.trim().isNotEmpty,
      _statementController.text.trim().isNotEmpty,
      _commitmentsController.text.trim().isNotEmpty,
      _legalController.text.trim().isNotEmpty,
      _workerController.text.trim().isNotEmpty,
      _environmentController.text.trim().isNotEmpty,
      _improvementController.text.trim().isNotEmpty,
      _preparedController.text.trim().isNotEmpty,
      _reviewedController.text.trim().isNotEmpty,
      _effectiveDate != null,
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
                    Icons.policy_outlined,
                    color: primaryGreen,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    'HSE Policy Readiness',
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
          'HSE Policy',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        actions: [
          IconButton(
            tooltip: 'Reset',
            onPressed: _resetPolicy,
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
            const SizedBox(height: 16),

            _sectionTitle('Policy Identification', Icons.badge_outlined),
            _textField(
              _policyNoController,
              'Policy Number',
              required: true,
              hint: 'Example: HSE-POL-001',
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
            ),
            _textField(
              _titleController,
              'Policy Title',
              required: true,
            ),
            _textField(
              _ownerController,
              'Policy Owner',
              required: true,
            ),

            _sectionTitle('Dates & Status', Icons.event_note_outlined),
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
                decoration: _decoration('Policy Status'),
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

            _sectionTitle('Policy Statement', Icons.description_outlined),
            _textField(
              _statementController,
              'HSE Policy Statement',
              required: true,
              maxLines: 6,
              hint: 'Describe the organization/project HSE policy.',
            ),

            _sectionTitle('HSE Commitments', Icons.verified_user_outlined),
            _textField(
              _commitmentsController,
              'Safety & Prevention Commitments',
              required: true,
              maxLines: 5,
            ),
            _textField(
              _workerController,
              'Worker Health, Welfare & Consultation',
              required: true,
              maxLines: 5,
            ),
            _textField(
              _environmentController,
              'Environmental Protection',
              required: true,
              maxLines: 5,
            ),
            _textField(
              _legalController,
              'UAE Legal & Authority Compliance',
              required: true,
              maxLines: 5,
              hint:
                  'Include applicable UAE and project jurisdiction requirements.',
            ),
            _textField(
              _improvementController,
              'Continual Improvement',
              required: true,
              maxLines: 5,
            ),

            _sectionTitle('Approval & Responsibility', Icons.approval_outlined),
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
                onPressed: _isSaving ? null : _savePolicy,
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
                  _isSaving ? 'Saving...' : 'Save HSE Policy',
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
              onPressed: _resetPolicy,
              icon: const Icon(Icons.restart_alt),
              label: const Text('Reset Policy'),
            ),
          ],
        ),
      ),
    );
  }
}
