import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HseManagementReviewLeadershipPage extends StatefulWidget {
  const HseManagementReviewLeadershipPage({super.key});

  @override
  State<HseManagementReviewLeadershipPage> createState() =>
      _HseManagementReviewLeadershipPageState();
}

class _HseManagementReviewLeadershipPageState
    extends State<HseManagementReviewLeadershipPage> {
  static const String _storageKey =
      'safenexus_hse_management_review_leadership_records';

  final List<Map<String, dynamic>> _records = [];
  final TextEditingController _searchController = TextEditingController();

  String _statusFilter = 'All';
  bool _loading = true;

  static const List<String> _reviewTypes = [
    'Monthly HSE Management Review',
    'Quarterly HSE Management Review',
    'Annual HSE Management Review',
    'Project Management Review',
    'Leadership Review',
    'Pre-Start Management Review',
    'Special / Ad-Hoc Review',
    'Other',
  ];

  static const List<String> _statuses = [
    'Open',
    'In Progress',
    'Completed',
    'Cancelled',
  ];

  @override
  void initState() {
    super.initState();
    _loadRecords();
    _searchController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
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
                  .map((e) => Map<String, dynamic>.from(e)),
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
    final d = date.day.toString().padLeft(2, '0');
    final m = date.month.toString().padLeft(2, '0');
    return '$d/$m/${date.year}';
  }

  String _formatDateTime(DateTime date) {
    final d = date.day.toString().padLeft(2, '0');
    final m = date.month.toString().padLeft(2, '0');
    final h = date.hour.toString().padLeft(2, '0');
    final min = date.minute.toString().padLeft(2, '0');
    return '$d/$m/${date.year} $h:$min';
  }

  DateTime? _parseDate(dynamic value) {
    if (value == null) return null;
    final parsed = DateTime.tryParse(value.toString());
    return parsed;
  }

  List<Map<String, dynamic>> get _filteredRecords {
    final query = _searchController.text.trim().toLowerCase();

    return _records.where((record) {
      final status = record['status']?.toString() ?? '';
      if (_statusFilter != 'All' && status != _statusFilter) {
        return false;
      }

      if (query.isEmpty) return true;

      final searchable = [
        record['reviewNo'],
        record['reviewType'],
        record['projectDepartment'],
        record['chairperson'],
        record['conductedBy'],
        record['reviewPeriod'],
        record['participants'],
        record['hsePerformanceSummary'],
        record['keyDecisions'],
        record['actionOwner'],
        record['managementComments'],
        record['status'],
      ].map((e) => e?.toString().toLowerCase() ?? '').join(' ');

      return searchable.contains(query);
    }).toList();
  }

  int get _openCount =>
      _records.where((r) => r['status'] == 'Open').length;

  int get _inProgressCount =>
      _records.where((r) => r['status'] == 'In Progress').length;

  int get _completedCount =>
      _records.where((r) => r['status'] == 'Completed').length;

  int get _overdueCount {
    final now = DateTime.now();
    return _records.where((record) {
      final status = record['status']?.toString() ?? '';
      if (status == 'Completed' || status == 'Cancelled') return false;

      final due = _parseDate(record['actionDueDate']);
      if (due == null) return false;

      final day = DateTime(due.year, due.month, due.day);
      final today = DateTime(now.year, now.month, now.day);
      return day.isBefore(today);
    }).length;
  }

  Future<DateTime?> _pickDate(
    BuildContext context, {
    DateTime? initialDate,
  }) async {
    return showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
  }

  Future<TimeOfDay?> _pickTime(
    BuildContext context, {
    TimeOfDay? initialTime,
  }) async {
    return showTimePicker(
      context: context,
      initialTime: initialTime ?? TimeOfDay.now(),
    );
  }

  Future<void> _showRecordForm({Map<String, dynamic>? existingRecord}) async {
    final formKey = GlobalKey<FormState>();

    final reviewNo = TextEditingController(
      text: existingRecord?['reviewNo']?.toString() ?? '',
    );
    final projectDepartment = TextEditingController(
      text: existingRecord?['projectDepartment']?.toString() ?? '',
    );
    final chairperson = TextEditingController(
      text: existingRecord?['chairperson']?.toString() ?? '',
    );
    final conductedBy = TextEditingController(
      text: existingRecord?['conductedBy']?.toString() ?? '',
    );
    final participants = TextEditingController(
      text: existingRecord?['participants']?.toString() ?? '',
    );
    final reviewPeriod = TextEditingController(
      text: existingRecord?['reviewPeriod']?.toString() ?? '',
    );
    final hsePerformanceSummary = TextEditingController(
      text: existingRecord?['hsePerformanceSummary']?.toString() ?? '',
    );
    final kpiPerformance = TextEditingController(
      text: existingRecord?['kpiPerformance']?.toString() ?? '',
    );
    final incidentReview = TextEditingController(
      text: existingRecord?['incidentReview']?.toString() ?? '',
    );
    final auditInspectionFindings = TextEditingController(
      text: existingRecord?['auditInspectionFindings']?.toString() ?? '',
    );
    final riskReview = TextEditingController(
      text: existingRecord?['riskReview']?.toString() ?? '',
    );
    final legalCompliance = TextEditingController(
      text: existingRecord?['legalCompliance']?.toString() ?? '',
    );
    final trainingCompetency = TextEditingController(
      text: existingRecord?['trainingCompetency']?.toString() ?? '',
    );
    final workerConsultation = TextEditingController(
      text: existingRecord?['workerConsultation']?.toString() ?? '',
    );
    final emergencyPreparedness = TextEditingController(
      text: existingRecord?['emergencyPreparedness']?.toString() ?? '',
    );
    final environmentalHealth = TextEditingController(
      text: existingRecord?['environmentalHealth']?.toString() ?? '',
    );
    final keyDecisions = TextEditingController(
      text: existingRecord?['keyDecisions']?.toString() ?? '',
    );
    final actionsAgreed = TextEditingController(
      text: existingRecord?['actionsAgreed']?.toString() ?? '',
    );
    final actionOwner = TextEditingController(
      text: existingRecord?['actionOwner']?.toString() ?? '',
    );
    final managementComments = TextEditingController(
      text: existingRecord?['managementComments']?.toString() ?? '',
    );

    DateTime reviewDate =
        _parseDate(existingRecord?['reviewDate']) ?? DateTime.now();
    TimeOfDay reviewTime = TimeOfDay(
      hour: int.tryParse(
            existingRecord?['reviewHour']?.toString() ?? '',
          ) ??
          DateTime.now().hour,
      minute: int.tryParse(
            existingRecord?['reviewMinute']?.toString() ?? '',
          ) ??
          DateTime.now().minute,
    );

    DateTime? actionDueDate = _parseDate(existingRecord?['actionDueDate']);

    String reviewType =
        existingRecord?['reviewType']?.toString() ?? _reviewTypes.first;
    if (!_reviewTypes.contains(reviewType)) {
      reviewType = _reviewTypes.first;
    }

    String status = existingRecord?['status']?.toString() ?? 'Open';
    if (!_statuses.contains(status)) status = 'Open';

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
                  existingRecord?['createdAt']?.toString() ?? now.toIso8601String();

              final record = <String, dynamic>{
                'id': id,
                'reviewNo': reviewNo.text.trim(),
                'reviewType': reviewType,
                'reviewDate': reviewDate.toIso8601String(),
                'reviewHour': reviewTime.hour,
                'reviewMinute': reviewTime.minute,
                'projectDepartment': projectDepartment.text.trim(),
                'chairperson': chairperson.text.trim(),
                'conductedBy': conductedBy.text.trim(),
                'participants': participants.text.trim(),
                'reviewPeriod': reviewPeriod.text.trim(),
                'hsePerformanceSummary': hsePerformanceSummary.text.trim(),
                'kpiPerformance': kpiPerformance.text.trim(),
                'incidentReview': incidentReview.text.trim(),
                'auditInspectionFindings':
                    auditInspectionFindings.text.trim(),
                'riskReview': riskReview.text.trim(),
                'legalCompliance': legalCompliance.text.trim(),
                'trainingCompetency': trainingCompetency.text.trim(),
                'workerConsultation': workerConsultation.text.trim(),
                'emergencyPreparedness':
                    emergencyPreparedness.text.trim(),
                'environmentalHealth': environmentalHealth.text.trim(),
                'keyDecisions': keyDecisions.text.trim(),
                'actionsAgreed': actionsAgreed.text.trim(),
                'actionOwner': actionOwner.text.trim(),
                'actionDueDate': actionDueDate?.toIso8601String(),
                'status': status,
                'managementComments': managementComments.text.trim(),
                'createdAt': createdAt,
                'updatedAt': now.toIso8601String(),
              };

              final index = _records.indexWhere(
                (r) => r['id']?.toString() == id,
              );

              if (index >= 0) {
                _records[index] = record;
              } else {
                _records.insert(0, record);
              }

              await _saveRecords();

              if (mounted) {
                setState(() {});
              }

              if (dialogContext.mounted) {
                Navigator.of(dialogContext).pop();
              }
            }

            return AlertDialog(
              title: Text(
                existingRecord == null
                    ? 'Add Management Review'
                    : 'Edit Management Review',
              ),
              content: SizedBox(
                width: 650,
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _sectionTitle('Review Information'),
                        _textField(
                          reviewNo,
                          'Management Review No.',
                          required: true,
                        ),
                        const SizedBox(height: 10),
                        DropdownButtonFormField<String>(
                          initialValue: reviewType,
                          decoration: const InputDecoration(
                            labelText: 'Review Type',
                            border: OutlineInputBorder(),
                          ),
                          items: _reviewTypes
                              .map(
                                (item) => DropdownMenuItem(
                                  value: item,
                                  child: Text(item),
                                ),
                              )
                              .toList(),
                          onChanged: saving
                              ? null
                              : (value) {
                                  if (value != null) {
                                    setDialogState(() => reviewType = value);
                                  }
                                },
                        ),
                        const SizedBox(height: 10),
                        _dateTimeTile(
                          context,
                          label: 'Review Date & Time',
                          date: reviewDate,
                          time: reviewTime,
                          onDate: () async {
                            final value = await _pickDate(
                              context,
                              initialDate: reviewDate,
                            );
                            if (value != null) {
                              setDialogState(() => reviewDate = value);
                            }
                          },
                          onTime: () async {
                            final value = await _pickTime(
                              context,
                              initialTime: reviewTime,
                            );
                            if (value != null) {
                              setDialogState(() => reviewTime = value);
                            }
                          },
                        ),
                        const SizedBox(height: 10),
                        _textField(
                          projectDepartment,
                          'Project / Department',
                        ),
                        const SizedBox(height: 10),
                        _textField(chairperson, 'Chairperson / Management Representative'),
                        const SizedBox(height: 10),
                        _textField(conductedBy, 'Conducted By'),
                        const SizedBox(height: 10),
                        _textField(
                          participants,
                          'Participants / Attendees',
                          maxLines: 2,
                        ),
                        const SizedBox(height: 10),
                        _textField(reviewPeriod, 'Review Period'),

                        _sectionTitle('HSE Performance Review'),
                        _textField(
                          hsePerformanceSummary,
                          'HSE Performance Summary',
                          maxLines: 4,
                        ),
                        const SizedBox(height: 10),
                        _textField(
                          kpiPerformance,
                          'KPI Performance',
                          maxLines: 3,
                        ),
                        const SizedBox(height: 10),
                        _textField(
                          incidentReview,
                          'Incident / Near Miss Review',
                          maxLines: 3,
                        ),
                        const SizedBox(height: 10),
                        _textField(
                          auditInspectionFindings,
                          'Audit & Inspection Findings',
                          maxLines: 3,
                        ),
                        const SizedBox(height: 10),
                        _textField(
                          riskReview,
                          'Risk / Critical Activity Review',
                          maxLines: 3,
                        ),
                        const SizedBox(height: 10),
                        _textField(
                          legalCompliance,
                          'Legal & Compliance Status',
                          maxLines: 3,
                        ),
                        const SizedBox(height: 10),
                        _textField(
                          trainingCompetency,
                          'Training & Competency Status',
                          maxLines: 3,
                        ),
                        const SizedBox(height: 10),
                        _textField(
                          workerConsultation,
                          'Worker Consultation / Feedback',
                          maxLines: 3,
                        ),
                        const SizedBox(height: 10),
                        _textField(
                          emergencyPreparedness,
                          'Emergency Preparedness / Drill Status',
                          maxLines: 3,
                        ),
                        const SizedBox(height: 10),
                        _textField(
                          environmentalHealth,
                          'Environmental & Occupational Health Review',
                          maxLines: 3,
                        ),

                        _sectionTitle('Decisions & Actions'),
                        _textField(
                          keyDecisions,
                          'Key Decisions',
                          maxLines: 4,
                        ),
                        const SizedBox(height: 10),
                        _textField(
                          actionsAgreed,
                          'Actions Agreed',
                          maxLines: 4,
                        ),
                        const SizedBox(height: 10),
                        _textField(actionOwner, 'Action Owner'),
                        const SizedBox(height: 10),
                        _dateTile(
                          context,
                          label: 'Action Due Date',
                          date: actionDueDate,
                          onDate: () async {
                            final value = await _pickDate(
                              context,
                              initialDate: actionDueDate ?? DateTime.now(),
                            );
                            if (value != null) {
                              setDialogState(() => actionDueDate = value);
                            }
                          },
                          onClear: actionDueDate == null
                              ? null
                              : () {
                                  setDialogState(() => actionDueDate = null);
                                },
                        ),
                        const SizedBox(height: 10),
                        DropdownButtonFormField<String>(
                          initialValue: status,
                          decoration: const InputDecoration(
                            labelText: 'Status',
                            border: OutlineInputBorder(),
                          ),
                          items: _statuses
                              .map(
                                (item) => DropdownMenuItem(
                                  value: item,
                                  child: Text(item),
                                ),
                              )
                              .toList(),
                          onChanged: saving
                              ? null
                              : (value) {
                                  if (value != null) {
                                    setDialogState(() => status = value);
                                  }
                                },
                        ),
                        const SizedBox(height: 10),
                        _textField(
                          managementComments,
                          'Management Comments',
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
                          child: CircularProgressIndicator(strokeWidth: 2),
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
      reviewNo,
      projectDepartment,
      chairperson,
      conductedBy,
      participants,
      reviewPeriod,
      hsePerformanceSummary,
      kpiPerformance,
      incidentReview,
      auditInspectionFindings,
      riskReview,
      legalCompliance,
      trainingCompetency,
      workerConsultation,
      emergencyPreparedness,
      environmentalHealth,
      keyDecisions,
      actionsAgreed,
      actionOwner,
      managementComments,
    ]) {
      controller.dispose();
    }
  }

  Future<void> _deleteRecord(Map<String, dynamic> record) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Management Review?'),
        content: Text(
          'Delete ${record['reviewNo'] ?? 'this record'} permanently?',
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
      (r) => r['id']?.toString() == record['id']?.toString(),
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
            Text('Review No.: ${record['reviewNo'] ?? '-'}'),
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

  Widget _dateTimeTile(
    BuildContext context, {
    required String label,
    required DateTime date,
    required TimeOfDay time,
    required VoidCallback onDate,
    required VoidCallback onTime,
  }) {
    return InputDecorator(
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(_formatDate(date)),
          ),
          IconButton(
            onPressed: onDate,
            icon: const Icon(Icons.calendar_month),
            tooltip: 'Select date',
          ),
          Text(
            time.format(context),
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          IconButton(
            onPressed: onTime,
            icon: const Icon(Icons.access_time),
            tooltip: 'Select time',
          ),
        ],
      ),
    );
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'Completed':
        return Colors.green;
      case 'In Progress':
        return Colors.orange;
      case 'Cancelled':
        return Colors.red;
      default:
        return Colors.blue;
    }
  }

  Widget _statCard(String title, int value, IconData icon) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            children: [
              Icon(icon, size: 28),
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
    final status = record['status']?.toString() ?? 'Open';
    final dueDate = _parseDate(record['actionDueDate']);
    final now = DateTime.now();

    final overdue = dueDate != null &&
        status != 'Completed' &&
        status != 'Cancelled' &&
        DateTime(dueDate.year, dueDate.month, dueDate.day).isBefore(
          DateTime(now.year, now.month, now.day),
        );

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => _showRecordDetails(record),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.fact_check, size: 26),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      record['reviewNo']?.toString() ?? '-',
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
              Text(record['reviewType']?.toString() ?? '-'),
              if ((record['projectDepartment']?.toString() ?? '').isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    'Project / Department: ${record['projectDepartment']}',
                  ),
                ),
              if (dueDate != null)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    'Action Due: ${_formatDate(dueDate)}${overdue ? ' 鈥� OVERDUE' : ''}',
                    style: TextStyle(
                      color: overdue ? Colors.red : null,
                      fontWeight: overdue ? FontWeight.bold : null,
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

  void _showRecordDetails(Map<String, dynamic> record) {
    final due = _parseDate(record['actionDueDate']);
    final reviewDate = _parseDate(record['reviewDate']);

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.88,
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(18, 4, 18, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    record['reviewNo']?.toString() ?? '-',
                    style: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _detail('Review Type', record['reviewType']),
                  _detail(
                    'Review Date',
                    reviewDate == null ? '-' : _formatDate(reviewDate),
                  ),
                  _detail('Project / Department', record['projectDepartment']),
                  _detail('Chairperson', record['chairperson']),
                  _detail('Conducted By', record['conductedBy']),
                  _detail('Participants', record['participants']),
                  _detail('Review Period', record['reviewPeriod']),
                  _detail(
                    'HSE Performance Summary',
                    record['hsePerformanceSummary'],
                  ),
                  _detail('KPI Performance', record['kpiPerformance']),
                  _detail('Incident / Near Miss Review', record['incidentReview']),
                  _detail(
                    'Audit & Inspection Findings',
                    record['auditInspectionFindings'],
                  ),
                  _detail('Risk / Critical Activity Review', record['riskReview']),
                  _detail('Legal & Compliance', record['legalCompliance']),
                  _detail(
                    'Training & Competency',
                    record['trainingCompetency'],
                  ),
                  _detail(
                    'Worker Consultation',
                    record['workerConsultation'],
                  ),
                  _detail(
                    'Emergency Preparedness',
                    record['emergencyPreparedness'],
                  ),
                  _detail(
                    'Environmental & Occupational Health',
                    record['environmentalHealth'],
                  ),
                  _detail('Key Decisions', record['keyDecisions']),
                  _detail('Actions Agreed', record['actionsAgreed']),
                  _detail('Action Owner', record['actionOwner']),
                  _detail(
                    'Action Due Date',
                    due == null ? '-' : _formatDate(due),
                  ),
                  _detail('Status', record['status']),
                  _detail(
                    'Management Comments',
                    record['managementComments'],
                  ),
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
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 3),
          Text(text),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final records = _filteredRecords;

    return Scaffold(
      appBar: AppBar(
        title: const Text('HSE Management Review & Leadership'),
        actions: [
          IconButton(
            onPressed: () => _showRecordForm(),
            icon: const Icon(Icons.add),
            tooltip: 'Add Review',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showRecordForm(),
        icon: const Icon(Icons.add),
        label: const Text('Add Review'),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadRecords,
              child: ListView(
                padding: const EdgeInsets.all(14),
                children: [
                  Text(
                    'Management Review & Leadership Register',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Record management leadership reviews, HSE performance, decisions and follow-up actions.',
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
                        'Open',
                        _openCount,
                        Icons.pending_actions,
                      ),
                      const SizedBox(width: 8),
                      _statCard(
                        'Progress',
                        _inProgressCount,
                        Icons.timelapse,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _statCard(
                        'Completed',
                        _completedCount,
                        Icons.task_alt,
                      ),
                      const SizedBox(width: 8),
                      _statCard(
                        'Overdue',
                        _overdueCount,
                        Icons.warning_amber_rounded,
                      ),
                      const SizedBox(width: 8),
                      _statCard(
                        'Shown',
                        records.length,
                        Icons.list_alt,
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      labelText: 'Search management reviews',
                      hintText: 'No., type, project, owner, status...',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: _searchController.text.isEmpty
                          ? null
                          : IconButton(
                              onPressed: () => _searchController.clear(),
                              icon: const Icon(Icons.clear),
                            ),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    initialValue: _statusFilter,
                    decoration: const InputDecoration(
                      labelText: 'Status Filter',
                      border: OutlineInputBorder(),
                    ),
                    items: [
                      'All',
                      ..._statuses,
                    ]
                        .map(
                          (item) => DropdownMenuItem(
                            value: item,
                            child: Text(item),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => _statusFilter = value);
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
                              Icons.fact_check_outlined,
                              size: 52,
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'No management review records found.',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 8),
                            FilledButton.icon(
                              onPressed: () => _showRecordForm(),
                              icon: const Icon(Icons.add),
                              label: const Text('Add First Review'),
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
}
