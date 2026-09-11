import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HseLegalComplianceRegisterPage extends StatefulWidget {
  const HseLegalComplianceRegisterPage({super.key});

  @override
  State<HseLegalComplianceRegisterPage> createState() =>
      _HseLegalComplianceRegisterPageState();
}

class _HseLegalComplianceRegisterPageState
    extends State<HseLegalComplianceRegisterPage> {
  static const String _storageKey =
      'safenexus_hse_legal_compliance_register_records';

  final List<Map<String, dynamic>> _records = [];
  final TextEditingController _searchController = TextEditingController();

  String _statusFilter = 'All';
  String _jurisdictionFilter = 'All';
  String _categoryFilter = 'All';
  bool _loading = true;

  static const List<String> _jurisdictions = [
    'UAE - Federal',
    'Abu Dhabi',
    'Dubai',
    'Sharjah',
    'Ajman',
    'Umm Al Quwain',
    'Ras Al Khaimah',
    'Fujairah',
    'Other',
  ];

  static const List<String> _categories = [
    'HSE General',
    'Occupational Safety',
    'Occupational Health',
    'Fire & Life Safety',
    'Environmental',
    'Waste Management',
    'Construction',
    'Industrial Safety',
    'Electrical Safety',
    'Lifting & Rigging',
    'Work at Height',
    'Confined Space',
    'Chemical Safety',
    'Emergency Management',
    'Training & Competency',
    'Permit to Work',
    'Worker Welfare',
    'Traffic & Transport',
    'Legal / Regulatory',
    'Other',
  ];

  static const List<String> _statuses = [
    'Compliant',
    'Partially Compliant',
    'Non-Compliant',
    'Under Review',
    'Not Applicable',
  ];

  static const List<String> _applicability = [
    'Applicable',
    'Not Applicable',
    'To Be Determined',
  ];

  static const List<String> _requirementTypes = [
    'Mandatory Legal Requirement',
    'Regulation',
    'Law',
    'Ministerial Decision',
    'Authority Requirement',
    'Code of Practice',
    'Technical Standard',
    'Permit / License Condition',
    'Client Requirement',
    'Best Practice',
    'Other',
  ];

  @override
  void initState() {
    super.initState();
    _loadRecords();
    _searchController.addListener(_refresh);
  }

  void _refresh() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _searchController.removeListener(_refresh);
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadRecords() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_storageKey);

    if (raw != null && raw.isNotEmpty) {
      try {
        final decoded = jsonDecode(raw);
        if (decoded is List) {
          _records
            ..clear()
            ..addAll(
              decoded
                  .whereType<Map>()
                  .map((item) => Map<String, dynamic>.from(item)),
            );
        }
      } catch (_) {}
    }

    if (mounted) {
      setState(() => _loading = false);
    }
  }

  Future<void> _saveRecords() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_storageKey, jsonEncode(_records));
  }

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    return '$day/$month/${date.year}';
  }

  String _formatDateTime(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');
    return '$day/$month/${date.year} $hour:$minute';
  }

  DateTime? _parseDate(dynamic value) {
    if (value == null) return null;
    return DateTime.tryParse(value.toString());
  }

  List<Map<String, dynamic>> get _filteredRecords {
    final query = _searchController.text.trim().toLowerCase();

    return _records.where((record) {
      final status = record['complianceStatus']?.toString() ?? '';
      final jurisdiction = record['jurisdiction']?.toString() ?? '';
      final category = record['category']?.toString() ?? '';

      if (_statusFilter != 'All' && status != _statusFilter) {
        return false;
      }
      if (_jurisdictionFilter != 'All' &&
          jurisdiction != _jurisdictionFilter) {
        return false;
      }
      if (_categoryFilter != 'All' && category != _categoryFilter) {
        return false;
      }

      if (query.isEmpty) return true;

      final searchable = [
        record['registerNo'],
        record['requirementTitle'],
        record['jurisdiction'],
        record['authority'],
        record['lawRegulationNo'],
        record['requirementType'],
        record['category'],
        record['activityDepartment'],
        record['requirementDetails'],
        record['complianceOwner'],
        record['complianceStatus'],
        record['evidenceReference'],
        record['gapNonCompliance'],
        record['correctiveAction'],
        record['actionOwner'],
        record['remarks'],
      ].map((value) => value?.toString().toLowerCase() ?? '').join(' ');

      return searchable.contains(query);
    }).toList();
  }

  int get _compliantCount =>
      _records.where((r) => r['complianceStatus'] == 'Compliant').length;

  int get _partialCount =>
      _records.where((r) => r['complianceStatus'] == 'Partially Compliant').length;

  int get _nonCompliantCount =>
      _records.where((r) => r['complianceStatus'] == 'Non-Compliant').length;

  int get _underReviewCount =>
      _records.where((r) => r['complianceStatus'] == 'Under Review').length;

  int get _overdueCount {
    final today = DateTime.now();
    final todayOnly = DateTime(today.year, today.month, today.day);

    return _records.where((record) {
      final status = record['complianceStatus']?.toString() ?? '';
      if (status == 'Not Applicable' || status == 'Compliant') return false;

      final dueDate = _parseDate(record['nextReviewDate']);
      if (dueDate == null) return false;

      final dueOnly = DateTime(dueDate.year, dueDate.month, dueDate.day);
      return dueOnly.isBefore(todayOnly);
    }).length;
  }

  Future<DateTime?> _pickDate(
    BuildContext context, {
    DateTime? initialDate,
  }) {
    return showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
  }

  Future<void> _showRecordForm({Map<String, dynamic>? existingRecord}) async {
    final formKey = GlobalKey<FormState>();

    final registerNo = TextEditingController(
      text: existingRecord?['registerNo']?.toString() ?? '',
    );
    final requirementTitle = TextEditingController(
      text: existingRecord?['requirementTitle']?.toString() ?? '',
    );
    final authority = TextEditingController(
      text: existingRecord?['authority']?.toString() ?? '',
    );
    final lawRegulationNo = TextEditingController(
      text: existingRecord?['lawRegulationNo']?.toString() ?? '',
    );
    final activityDepartment = TextEditingController(
      text: existingRecord?['activityDepartment']?.toString() ?? '',
    );
    final requirementDetails = TextEditingController(
      text: existingRecord?['requirementDetails']?.toString() ?? '',
    );
    final complianceOwner = TextEditingController(
      text: existingRecord?['complianceOwner']?.toString() ?? '',
    );
    final evidenceReference = TextEditingController(
      text: existingRecord?['evidenceReference']?.toString() ?? '',
    );
    final gapNonCompliance = TextEditingController(
      text: existingRecord?['gapNonCompliance']?.toString() ?? '',
    );
    final correctiveAction = TextEditingController(
      text: existingRecord?['correctiveAction']?.toString() ?? '',
    );
    final actionOwner = TextEditingController(
      text: existingRecord?['actionOwner']?.toString() ?? '',
    );
    final remarks = TextEditingController(
      text: existingRecord?['remarks']?.toString() ?? '',
    );

    String jurisdiction =
        existingRecord?['jurisdiction']?.toString() ?? _jurisdictions.first;
    if (!_jurisdictions.contains(jurisdiction)) {
      jurisdiction = _jurisdictions.first;
    }

    String category =
        existingRecord?['category']?.toString() ?? _categories.first;
    if (!_categories.contains(category)) {
      category = _categories.first;
    }

    String requirementType =
        existingRecord?['requirementType']?.toString() ??
            _requirementTypes.first;
    if (!_requirementTypes.contains(requirementType)) {
      requirementType = _requirementTypes.first;
    }

    String applicability =
        existingRecord?['applicability']?.toString() ?? _applicability.first;
    if (!_applicability.contains(applicability)) {
      applicability = _applicability.first;
    }

    String complianceStatus =
        existingRecord?['complianceStatus']?.toString() ?? 'Under Review';
    if (!_statuses.contains(complianceStatus)) {
      complianceStatus = 'Under Review';
    }

    DateTime? lastReviewDate =
        _parseDate(existingRecord?['lastReviewDate']);
    DateTime? nextReviewDate =
        _parseDate(existingRecord?['nextReviewDate']);
    DateTime? actionDueDate = _parseDate(existingRecord?['actionDueDate']);

    bool saving = false;

    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            Future<void> save() async {
              if (!(formKey.currentState?.validate() ?? false)) return;

              setDialogState(() => saving = true);

              final now = DateTime.now();
              final id = existingRecord?['id']?.toString() ??
                  now.microsecondsSinceEpoch.toString();
              final createdAt =
                  existingRecord?['createdAt']?.toString() ??
                      now.toIso8601String();

              final record = <String, dynamic>{
                'id': id,
                'registerNo': registerNo.text.trim(),
                'requirementTitle': requirementTitle.text.trim(),
                'jurisdiction': jurisdiction,
                'authority': authority.text.trim(),
                'lawRegulationNo': lawRegulationNo.text.trim(),
                'requirementType': requirementType,
                'category': category,
                'activityDepartment': activityDepartment.text.trim(),
                'applicability': applicability,
                'requirementDetails': requirementDetails.text.trim(),
                'complianceOwner': complianceOwner.text.trim(),
                'evidenceReference': evidenceReference.text.trim(),
                'lastReviewDate': lastReviewDate?.toIso8601String(),
                'nextReviewDate': nextReviewDate?.toIso8601String(),
                'complianceStatus': complianceStatus,
                'gapNonCompliance': gapNonCompliance.text.trim(),
                'correctiveAction': correctiveAction.text.trim(),
                'actionOwner': actionOwner.text.trim(),
                'actionDueDate': actionDueDate?.toIso8601String(),
                'remarks': remarks.text.trim(),
                'createdAt': createdAt,
                'updatedAt': now.toIso8601String(),
              };

              final index = _records.indexWhere(
                (item) => item['id']?.toString() == id,
              );

              if (index >= 0) {
                _records[index] = record;
              } else {
                _records.insert(0, record);
              }

              await _saveRecords();

              if (mounted) setState(() {});

              if (dialogContext.mounted) {
                Navigator.of(dialogContext).pop();
              }
            }

            return AlertDialog(
              title: Text(
                existingRecord == null
                    ? 'Add Legal / Compliance Record'
                    : 'Edit Legal / Compliance Record',
              ),
              content: SizedBox(
                width: 650,
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _sectionTitle('Legal / Regulatory Information'),
                        _textField(
                          registerNo,
                          'Compliance Register No.',
                          required: true,
                        ),
                        const SizedBox(height: 10),
                        _textField(
                          requirementTitle,
                          'Requirement / Regulation Title',
                          required: true,
                        ),
                        const SizedBox(height: 10),
                        _dropdown(
                          label: 'Jurisdiction / Emirate',
                          value: jurisdiction,
                          items: _jurisdictions,
                          enabled: !saving,
                          onChanged: (value) {
                            if (value != null) {
                              setDialogState(() => jurisdiction = value);
                            }
                          },
                        ),
                        const SizedBox(height: 10),
                        _textField(
                          authority,
                          'Authority / Regulator',
                        ),
                        const SizedBox(height: 10),
                        _textField(
                          lawRegulationNo,
                          'Law / Regulation / Standard No.',
                        ),
                        const SizedBox(height: 10),
                        _dropdown(
                          label: 'Requirement Type',
                          value: requirementType,
                          items: _requirementTypes,
                          enabled: !saving,
                          onChanged: (value) {
                            if (value != null) {
                              setDialogState(
                                () => requirementType = value,
                              );
                            }
                          },
                        ),
                        const SizedBox(height: 10),
                        _dropdown(
                          label: 'Requirement Category',
                          value: category,
                          items: _categories,
                          enabled: !saving,
                          onChanged: (value) {
                            if (value != null) {
                              setDialogState(() => category = value);
                            }
                          },
                        ),
                        const SizedBox(height: 10),
                        _textField(
                          activityDepartment,
                          'Applicable Activity / Department',
                        ),
                        const SizedBox(height: 10),
                        _dropdown(
                          label: 'Applicability',
                          value: applicability,
                          items: _applicability,
                          enabled: !saving,
                          onChanged: (value) {
                            if (value != null) {
                              setDialogState(
                                () => applicability = value,
                              );
                            }
                          },
                        ),
                        const SizedBox(height: 10),
                        _textField(
                          requirementDetails,
                          'Requirement Details',
                          maxLines: 5,
                        ),
                        _sectionTitle('Compliance Monitoring'),
                        _textField(
                          complianceOwner,
                          'Compliance Owner',
                        ),
                        const SizedBox(height: 10),
                        _textField(
                          evidenceReference,
                          'Evidence / Reference',
                          maxLines: 3,
                        ),
                        const SizedBox(height: 10),
                        _dateTile(
                          context,
                          label: 'Last Compliance Review',
                          date: lastReviewDate,
                          onDate: () async {
                            final selected = await _pickDate(
                              context,
                              initialDate:
                                  lastReviewDate ?? DateTime.now(),
                            );
                            if (selected != null) {
                              setDialogState(
                                () => lastReviewDate = selected,
                              );
                            }
                          },
                          onClear: lastReviewDate == null
                              ? null
                              : () {
                                  setDialogState(
                                    () => lastReviewDate = null,
                                  );
                                },
                        ),
                        const SizedBox(height: 10),
                        _dateTile(
                          context,
                          label: 'Next Review / Due Date',
                          date: nextReviewDate,
                          onDate: () async {
                            final selected = await _pickDate(
                              context,
                              initialDate:
                                  nextReviewDate ?? DateTime.now(),
                            );
                            if (selected != null) {
                              setDialogState(
                                () => nextReviewDate = selected,
                              );
                            }
                          },
                          onClear: nextReviewDate == null
                              ? null
                              : () {
                                  setDialogState(
                                    () => nextReviewDate = null,
                                  );
                                },
                        ),
                        const SizedBox(height: 10),
                        _dropdown(
                          label: 'Compliance Status',
                          value: complianceStatus,
                          items: _statuses,
                          enabled: !saving,
                          onChanged: (value) {
                            if (value != null) {
                              setDialogState(
                                () => complianceStatus = value,
                              );
                            }
                          },
                        ),
                        const SizedBox(height: 10),
                        _textField(
                          gapNonCompliance,
                          'Gap / Non-Compliance',
                          maxLines: 4,
                        ),
                        const SizedBox(height: 10),
                        _textField(
                          correctiveAction,
                          'Corrective Action',
                          maxLines: 4,
                        ),
                        const SizedBox(height: 10),
                        _textField(
                          actionOwner,
                          'Action Owner',
                        ),
                        const SizedBox(height: 10),
                        _dateTile(
                          context,
                          label: 'Corrective Action Due Date',
                          date: actionDueDate,
                          onDate: () async {
                            final selected = await _pickDate(
                              context,
                              initialDate:
                                  actionDueDate ?? DateTime.now(),
                            );
                            if (selected != null) {
                              setDialogState(
                                () => actionDueDate = selected,
                              );
                            }
                          },
                          onClear: actionDueDate == null
                              ? null
                              : () {
                                  setDialogState(
                                    () => actionDueDate = null,
                                  );
                                },
                        ),
                        const SizedBox(height: 10),
                        _textField(
                          remarks,
                          'Remarks',
                          maxLines: 4,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: saving
                      ? null
                      : () => Navigator.of(dialogContext).pop(),
                  child: const Text('Cancel'),
                ),
                FilledButton.icon(
                  onPressed: saving ? null : save,
                  icon: saving
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        )
                      : const Icon(Icons.save),
                  label: Text(saving ? 'Saving...' : 'Save'),
                ),
              ],
            );
          },
        );
      },
    );

    for (final controller in [
      registerNo,
      requirementTitle,
      authority,
      lawRegulationNo,
      activityDepartment,
      requirementDetails,
      complianceOwner,
      evidenceReference,
      gapNonCompliance,
      correctiveAction,
      actionOwner,
      remarks,
    ]) {
      controller.dispose();
    }
  }

  Widget _dropdown({
    required String label,
    required String value,
    required List<String> items,
    required bool enabled,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      items: items
          .map(
            (item) => DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            ),
          )
          .toList(),
      onChanged: enabled ? onChanged : null,
    );
  }

  Widget _textField(
    TextEditingController controller,
    String label, {
    bool required = false,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      textInputAction:
          maxLines > 1 ? TextInputAction.newline : TextInputAction.next,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      validator: required
          ? (value) {
              if (value == null || value.trim().isEmpty) {
                return '$label is required';
              }
              return null;
            }
          : null,
    );
  }

  Widget _dateTile(
    BuildContext context, {
    required String label,
    required DateTime? date,
    required VoidCallback onDate,
    VoidCallback? onClear,
  }) {
    return InputDecorator(
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              date == null ? 'Not selected' : _formatDate(date),
            ),
          ),
          IconButton(
            onPressed: onDate,
            icon: const Icon(Icons.calendar_month),
            tooltip: 'Select date',
          ),
          if (onClear != null)
            IconButton(
              onPressed: onClear,
              icon: const Icon(Icons.clear),
              tooltip: 'Clear',
            ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 10),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'Compliant':
        return Colors.green;
      case 'Partially Compliant':
        return Colors.orange;
      case 'Non-Compliant':
        return Colors.red;
      case 'Not Applicable':
        return Colors.grey;
      default:
        return Colors.blue;
    }
  }

  Future<void> _deleteRecord(Map<String, dynamic> record) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Compliance Record?'),
        content: Text(
          'Delete ${record['registerNo'] ?? 'this record'} permanently?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    _records.removeWhere(
      (item) =>
          item['id']?.toString() == record['id']?.toString(),
    );
    await _saveRecords();

    if (mounted) setState(() {});
  }

  void _showHistory(Map<String, dynamic> record) {
    final created = _parseDate(record['createdAt']);
    final updated = _parseDate(record['updatedAt']);

    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Record History'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Register No.: ${record['registerNo'] ?? '-'}'),
            const SizedBox(height: 14),
            Text(
              'Created: ${created == null ? '-' : _formatDateTime(created)}',
            ),
            const SizedBox(height: 8),
            Text(
              'Last Updated: ${updated == null ? '-' : _formatDateTime(updated)}',
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showDetails(Map<String, dynamic> record) {
    final lastReview = _parseDate(record['lastReviewDate']);
    final nextReview = _parseDate(record['nextReviewDate']);
    final actionDue = _parseDate(record['actionDueDate']);

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.9,
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(18, 4, 18, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    record['registerNo']?.toString() ?? '-',
                    style: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _detail('Requirement / Regulation', record['requirementTitle']),
                  _detail('Jurisdiction', record['jurisdiction']),
                  _detail('Authority / Regulator', record['authority']),
                  _detail('Law / Regulation No.', record['lawRegulationNo']),
                  _detail('Requirement Type', record['requirementType']),
                  _detail('Category', record['category']),
                  _detail(
                    'Applicable Activity / Department',
                    record['activityDepartment'],
                  ),
                  _detail('Applicability', record['applicability']),
                  _detail(
                    'Requirement Details',
                    record['requirementDetails'],
                  ),
                  _detail('Compliance Owner', record['complianceOwner']),
                  _detail('Evidence / Reference', record['evidenceReference']),
                  _detail(
                    'Last Compliance Review',
                    lastReview == null ? '-' : _formatDate(lastReview),
                  ),
                  _detail(
                    'Next Review / Due Date',
                    nextReview == null ? '-' : _formatDate(nextReview),
                  ),
                  _detail(
                    'Compliance Status',
                    record['complianceStatus'],
                  ),
                  _detail(
                    'Gap / Non-Compliance',
                    record['gapNonCompliance'],
                  ),
                  _detail('Corrective Action', record['correctiveAction']),
                  _detail('Action Owner', record['actionOwner']),
                  _detail(
                    'Corrective Action Due Date',
                    actionDue == null ? '-' : _formatDate(actionDue),
                  ),
                  _detail('Remarks', record['remarks']),
                  const SizedBox(height: 12),
                  FilledButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      _showRecordForm(existingRecord: record);
                    },
                    icon: const Icon(Icons.edit),
                    label: const Text('Edit Record'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _detail(String label, dynamic value) {
    final text = value?.toString().trim() ?? '';
    if (text.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 3),
          Text(text),
        ],
      ),
    );
  }

  Widget _statCard(String title, int value, IconData icon) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(13),
          child: Column(
            children: [
              Icon(icon, size: 27),
              const SizedBox(height: 6),
              Text(
                '$value',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _recordCard(Map<String, dynamic> record) {
    final status = record['complianceStatus']?.toString() ?? 'Under Review';
    final nextReview = _parseDate(record['nextReviewDate']);
    final actionDue = _parseDate(record['actionDueDate']);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    final reviewOverdue = nextReview != null &&
        status != 'Compliant' &&
        status != 'Not Applicable' &&
        DateTime(
          nextReview.year,
          nextReview.month,
          nextReview.day,
        ).isBefore(today);

    final actionOverdue = actionDue != null &&
        status != 'Compliant' &&
        status != 'Not Applicable' &&
        DateTime(
          actionDue.year,
          actionDue.month,
          actionDue.day,
        ).isBefore(today);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => _showDetails(record),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.gavel, size: 27),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      record['registerNo']?.toString() ?? '-',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Chip(
                    label: Text(status),
                    visualDensity: VisualDensity.compact,
                    backgroundColor:
                        _statusColor(status).withValues(alpha: 0.12),
                    labelStyle: TextStyle(
                      color: _statusColor(status),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                record['requirementTitle']?.toString() ?? '-',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 4),
              Text(
                '${record['jurisdiction'] ?? '-'} 鈥� ${record['category'] ?? '-'}',
              ),
              if ((record['authority']?.toString() ?? '').isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text('Authority: ${record['authority']}'),
                ),
              if (nextReview != null)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    'Next Review: ${_formatDate(nextReview)}'
                    '${reviewOverdue ? ' 鈥� OVERDUE' : ''}',
                    style: TextStyle(
                      color: reviewOverdue ? Colors.red : null,
                      fontWeight: reviewOverdue ? FontWeight.bold : null,
                    ),
                  ),
                ),
              if (actionDue != null)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    'Action Due: ${_formatDate(actionDue)}'
                    '${actionOverdue ? ' 鈥� OVERDUE' : ''}',
                    style: TextStyle(
                      color: actionOverdue ? Colors.red : null,
                      fontWeight: actionOverdue ? FontWeight.bold : null,
                    ),
                  ),
                ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () => _showHistory(record),
                    icon: const Icon(Icons.history),
                    tooltip: 'History',
                  ),
                  IconButton(
                    onPressed: () =>
                        _showRecordForm(existingRecord: record),
                    icon: const Icon(Icons.edit),
                    tooltip: 'Edit',
                  ),
                  IconButton(
                    onPressed: () => _deleteRecord(record),
                    icon: const Icon(Icons.delete_outline),
                    tooltip: 'Delete',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final records = _filteredRecords;

    return Scaffold(
      appBar: AppBar(
        title: const Text('HSE Legal & Compliance Register'),
        actions: [
          IconButton(
            onPressed: () => _showRecordForm(),
            icon: const Icon(Icons.add),
            tooltip: 'Add Compliance Record',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showRecordForm(),
        icon: const Icon(Icons.add),
        label: const Text('Add Record'),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadRecords,
              child: ListView(
                padding: const EdgeInsets.all(14),
                children: [
                  Text(
                    'HSE Legal, Compliance & Regulatory Register',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Track applicable UAE legal and regulatory requirements, compliance status, evidence, gaps and corrective actions.',
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      _statCard(
                        'Total',
                        _records.length,
                        Icons.dashboard_outlined,
                      ),
                      const SizedBox(width: 8),
                      _statCard(
                        'Compliant',
                        _compliantCount,
                        Icons.verified_outlined,
                      ),
                      const SizedBox(width: 8),
                      _statCard(
                        'Partial',
                        _partialCount,
                        Icons.warning_amber_outlined,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _statCard(
                        'Non-Compliant',
                        _nonCompliantCount,
                        Icons.error_outline,
                      ),
                      const SizedBox(width: 8),
                      _statCard(
                        'Review',
                        _underReviewCount,
                        Icons.rate_review_outlined,
                      ),
                      const SizedBox(width: 8),
                      _statCard(
                        'Overdue',
                        _overdueCount,
                        Icons.schedule,
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      labelText: 'Search compliance register',
                      hintText: 'No., regulation, authority, category...',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: _searchController.text.isEmpty
                          ? null
                          : IconButton(
                              onPressed: _searchController.clear,
                              icon: const Icon(Icons.clear),
                            ),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  _filterDropdown(
                    label: 'Compliance Status',
                    value: _statusFilter,
                    items: ['All', ..._statuses],
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => _statusFilter = value);
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                  _filterDropdown(
                    label: 'Jurisdiction / Emirate',
                    value: _jurisdictionFilter,
                    items: ['All', ..._jurisdictions],
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => _jurisdictionFilter = value);
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                  _filterDropdown(
                    label: 'Category',
                    value: _categoryFilter,
                    items: ['All', ..._categories],
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => _categoryFilter = value);
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  if (records.isEmpty)
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(28),
                        child: Column(
                          children: [
                            const Icon(
                              Icons.gavel_outlined,
                              size: 52,
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'No legal or compliance records found.',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 8),
                            FilledButton.icon(
                              onPressed: () => _showRecordForm(),
                              icon: const Icon(Icons.add),
                              label: const Text('Add First Record'),
                            ),
                          ],
                        ),
                      ),
                    )
                  else
                    ...records.map(_recordCard),
                  const SizedBox(height: 90),
                ],
              ),
            ),
    );
  }

  Widget _filterDropdown({
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      items: items
          .map(
            (item) => DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            ),
          )
          .toList(),
      onChanged: onChanged,
    );
  }
}
