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
  final _locationController = TextEditingController();
  final _scopeController = TextEditingController();

  String _emirate = 'Abu Dhabi';
  String _status = 'Pre-Start';
  DateTime? _plannedStartDate;
  DateTime? _plannedEndDate;
  bool _isLoading = true;
  bool _isSaving = false;
  bool _hasSavedProject = false;

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
    _locationController.dispose();
    _scopeController.dispose();
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
      _locationController.text = prefs.getString('prestart.location') ?? '';
      _scopeController.text = prefs.getString('prestart.scope') ?? '';
      _emirate = prefs.getString('prestart.emirate') ?? 'Abu Dhabi';
      _status = prefs.getString('prestart.status') ?? 'Pre-Start';
      _plannedStartDate = _dateFromString(prefs.getString('prestart.startDate'));
      _plannedEndDate = _dateFromString(prefs.getString('prestart.endDate'));
      _hasSavedProject = prefs.getBool('prestart.hasSavedProject') ?? false;
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
      setState(() => _plannedStartDate = selected);
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
    await prefs.setString('prestart.location', _locationController.text.trim());
    await prefs.setString('prestart.scope', _scopeController.text.trim());
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

    if (!mounted) return;
    setState(() {
      _isSaving = false;
      _hasSavedProject = true;
    });
    _showMessage('Project Profile saved successfully.');
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
      'location',
      'scope',
      'emirate',
      'status',
      'startDate',
      'endDate',
      'hasSavedProject',
    ]) {
      await prefs.remove('prestart.$key');
    }

    if (!mounted) return;
    setState(() {
      _projectNameController.clear();
      _contractNumberController.clear();
      _clientController.clear();
      _contractorController.clear();
      _locationController.clear();
      _scopeController.clear();
      _emirate = 'Abu Dhabi';
      _status = 'Pre-Start';
      _plannedStartDate = null;
      _plannedEndDate = null;
      _hasSavedProject = false;
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
    final checks = [
      _projectNameController.text.trim().isNotEmpty,
      _contractNumberController.text.trim().isNotEmpty,
      _clientController.text.trim().isNotEmpty,
      _contractorController.text.trim().isNotEmpty,
      _locationController.text.trim().isNotEmpty,
      _scopeController.text.trim().isNotEmpty,
      _plannedStartDate != null,
      _plannedEndDate != null,
    ];
    final completed = checks.where((value) => value).length;
    return ((completed / checks.length) * 100).round();
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
            _ReadinessCard(percent: _completionPercent),
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
                _textField(
                  controller: _locationController,
                  label: 'Project Location',
                  hint: 'Enter project/site location',
                  icon: Icons.location_on_outlined,
                  requiredField: true,
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
                _textField(
                  controller: _scopeController,
                  label: 'Scope of Work',
                  hint: 'Briefly describe the project scope',
                  icon: Icons.description_outlined,
                  maxLines: 5,
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
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
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

  const _ReadinessCard({required this.percent});

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
          Text(
            ready ? 'Project Profile complete.' : 'Required information is still pending.',
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
