import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HseConsultationWorkerParticipationPage extends StatefulWidget {
  const HseConsultationWorkerParticipationPage({super.key});

  @override
  State<HseConsultationWorkerParticipationPage> createState() =>
      _HseConsultationWorkerParticipationPageState();
}

class _HseConsultationWorkerParticipationPageState
    extends State<HseConsultationWorkerParticipationPage> {
  static const String _storageKey =
      'safenexus_hse_consultation_worker_participation_records';

  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);

  final List<String> _consultationTypes = const [
    'Safety Committee Meeting',
    'Worker Consultation',
    'HSE Meeting',
    'Toolbox / Safety Briefing',
    'Worker Representative Meeting',
    'Safety Campaign',
    'Welfare Consultation',
    'Emergency Consultation',
    'Other',
  ];

  final List<String> _statuses = const [
    'Open',
    'In Progress',
    'Completed',
    'Cancelled',
  ];

  List<Map<String, dynamic>> _records = [];
  String _searchQuery = '';
  String _statusFilter = 'All';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadRecords();
  }

  Future<void> _loadRecords() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_storageKey);

    if (raw != null && raw.isNotEmpty) {
      try {
        final decoded = jsonDecode(raw);

        if (decoded is List) {
          _records = decoded
              .whereType<Map>()
              .map(
                (item) => Map<String, dynamic>.from(item),
              )
              .toList();
        }
      } catch (_) {
        _records = [];
      }
    }

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _saveRecords() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(
      _storageKey,
      jsonEncode(_records),
    );
  }

  List<Map<String, dynamic>> get _filteredRecords {
    final query = _searchQuery.trim().toLowerCase();

    return _records.where((record) {
      final status = record['status']?.toString() ?? '';

      if (_statusFilter != 'All' && status != _statusFilter) {
        return false;
      }

      if (query.isEmpty) {
        return true;
      }

      final searchable = [
        record['recordNo'],
        record['consultationType'],
        record['location'],
        record['committee'],
        record['chairperson'],
        record['conductedBy'],
        record['participants'],
        record['subject'],
        record['issues'],
        record['suggestions'],
        record['actions'],
        record['actionOwner'],
        record['remarks'],
      ].map(
        (value) => value?.toString().toLowerCase() ?? '',
      );

      return searchable.any(
        (value) => value.contains(query),
      );
    }).toList();
  }

  int get _totalCount => _records.length;

  int get _openCount =>
      _records.where((record) => record['status'] == 'Open').length;

  int get _inProgressCount => _records
      .where((record) => record['status'] == 'In Progress')
      .length;

  int get _completedCount =>
      _records.where((record) => record['status'] == 'Completed').length;

  int get _cancelledCount =>
      _records.where((record) => record['status'] == 'Cancelled').length;

  int get _overdueCount {
    final now = DateTime.now();

    return _records.where((record) {
      final status = record['status']?.toString() ?? '';
      final dueDate = DateTime.tryParse(
        record['dueDate']?.toString() ?? '',
      );

      if (dueDate == null) {
        return false;
      }

      return dueDate.isBefore(now) &&
          status != 'Completed' &&
          status != 'Cancelled';
    }).length;
  }

  Future<void> _showRecordForm({
    Map<String, dynamic>? existingRecord,
  }) async {
    final bool isEditing = existingRecord != null;

    final recordNoController = TextEditingController(
      text: existingRecord?['recordNo']?.toString() ?? '',
    );
    final locationController = TextEditingController(
      text: existingRecord?['location']?.toString() ?? '',
    );
    final committeeController = TextEditingController(
      text: existingRecord?['committee']?.toString() ?? '',
    );
    final chairpersonController = TextEditingController(
      text: existingRecord?['chairperson']?.toString() ?? '',
    );
    final conductedByController = TextEditingController(
      text: existingRecord?['conductedBy']?.toString() ?? '',
    );
    final participantsController = TextEditingController(
      text: existingRecord?['participants']?.toString() ?? '',
    );
    final subjectController = TextEditingController(
      text: existingRecord?['subject']?.toString() ?? '',
    );
    final issuesController = TextEditingController(
      text: existingRecord?['issues']?.toString() ?? '',
    );
    final suggestionsController = TextEditingController(
      text: existingRecord?['suggestions']?.toString() ?? '',
    );
    final actionsController = TextEditingController(
      text: existingRecord?['actions']?.toString() ?? '',
    );
    final actionOwnerController = TextEditingController(
      text: existingRecord?['actionOwner']?.toString() ?? '',
    );
    final remarksController = TextEditingController(
      text: existingRecord?['remarks']?.toString() ?? '',
    );

    String consultationType =
        existingRecord?['consultationType']?.toString() ??
            _consultationTypes.first;

    if (!_consultationTypes.contains(consultationType)) {
      consultationType = _consultationTypes.first;
    }

    String status =
        existingRecord?['status']?.toString() ?? 'Open';

    if (!_statuses.contains(status)) {
      status = 'Open';
    }

    DateTime meetingDate = DateTime.tryParse(
          existingRecord?['meetingDate']?.toString() ?? '',
        ) ??
        DateTime.now();

    TimeOfDay meetingTime = _parseTime(
      existingRecord?['meetingTime']?.toString(),
    );

    DateTime? dueDate = DateTime.tryParse(
      existingRecord?['dueDate']?.toString() ?? '',
    );

    String? validationMessage;

    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            Future<void> selectMeetingDate() async {
              final selected = await showDatePicker(
                context: context,
                initialDate: meetingDate,
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );

              if (selected != null) {
                setDialogState(() {
                  meetingDate = selected;
                });
              }
            }

            Future<void> selectMeetingTime() async {
              final selected = await showTimePicker(
                context: context,
                initialTime: meetingTime,
              );

              if (selected != null) {
                setDialogState(() {
                  meetingTime = selected;
                });
              }
            }

            Future<void> selectDueDate() async {
              final selected = await showDatePicker(
                context: context,
                initialDate: dueDate ?? meetingDate,
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );

              if (selected != null) {
                setDialogState(() {
                  dueDate = selected;
                });
              }
            }

            return AlertDialog(
              title: Text(
                isEditing
                    ? 'Edit HSE Consultation'
                    : 'Add HSE Consultation',
              ),
              content: SizedBox(
                width: 580,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (validationMessage != null)
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.red.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            validationMessage!,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                      TextField(
                        controller: recordNoController,
                        decoration: const InputDecoration(
                          labelText: 'Consultation / Meeting No. *',
                          prefixIcon: Icon(Icons.numbers_outlined),
                        ),
                      ),
                      const SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        initialValue: consultationType,
                        decoration: const InputDecoration(
                          labelText: 'Consultation / Meeting Type *',
                          prefixIcon: Icon(Icons.groups_outlined),
                        ),
                        items: _consultationTypes
                            .map(
                              (item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(item),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          if (value != null) {
                            setDialogState(() {
                              consultationType = value;
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: locationController,
                        decoration: const InputDecoration(
                          labelText: 'Location',
                          prefixIcon: Icon(Icons.location_on_outlined),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: committeeController,
                        decoration: const InputDecoration(
                          labelText: 'Safety Committee / Worker Representative',
                          prefixIcon: Icon(Icons.groups_2_outlined),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: chairpersonController,
                        decoration: const InputDecoration(
                          labelText: 'Chairperson',
                          prefixIcon: Icon(Icons.person_outline),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: conductedByController,
                        decoration: const InputDecoration(
                          labelText: 'Conducted By',
                          prefixIcon: Icon(Icons.badge_outlined),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: participantsController,
                        maxLines: 3,
                        decoration: const InputDecoration(
                          labelText: 'Participants / Attendees *',
                          alignLabelWithHint: true,
                          prefixIcon: Icon(Icons.people_outline),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: subjectController,
                        decoration: const InputDecoration(
                          labelText: 'Subject / Safety Topic *',
                          prefixIcon: Icon(Icons.topic_outlined),
                        ),
                      ),
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: selectMeetingDate,
                        child: InputDecorator(
                          decoration: const InputDecoration(
                            labelText: 'Date',
                            prefixIcon: Icon(Icons.calendar_today_outlined),
                          ),
                          child: Text(_formatDate(meetingDate)),
                        ),
                      ),
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: selectMeetingTime,
                        child: InputDecorator(
                          decoration: const InputDecoration(
                            labelText: 'Time',
                            prefixIcon: Icon(Icons.access_time_outlined),
                          ),
                          child: Text(meetingTime.format(context)),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: issuesController,
                        maxLines: 4,
                        decoration: const InputDecoration(
                          labelText: 'Issues / Concerns Raised',
                          alignLabelWithHint: true,
                          prefixIcon: Icon(Icons.warning_amber_outlined),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: suggestionsController,
                        maxLines: 4,
                        decoration: const InputDecoration(
                          labelText: 'Suggestions / Recommendations',
                          alignLabelWithHint: true,
                          prefixIcon: Icon(Icons.lightbulb_outline),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: actionsController,
                        maxLines: 4,
                        decoration: const InputDecoration(
                          labelText: 'Actions Agreed',
                          alignLabelWithHint: true,
                          prefixIcon: Icon(Icons.task_alt_outlined),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: actionOwnerController,
                        decoration: const InputDecoration(
                          labelText: 'Action Owner',
                          prefixIcon: Icon(Icons.person_pin_outlined),
                        ),
                      ),
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: selectDueDate,
                        child: InputDecorator(
                          decoration: const InputDecoration(
                            labelText: 'Action Due Date',
                            prefixIcon: Icon(Icons.event_outlined),
                          ),
                          child: Text(
                            dueDate == null
                                ? 'Not specified'
                                : _formatDate(dueDate!),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        initialValue: status,
                        decoration: const InputDecoration(
                          labelText: 'Status *',
                          prefixIcon: Icon(Icons.flag_outlined),
                        ),
                        items: _statuses
                            .map(
                              (item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(item),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          if (value != null) {
                            setDialogState(() {
                              status = value;
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: remarksController,
                        maxLines: 3,
                        decoration: const InputDecoration(
                          labelText: 'Remarks',
                          alignLabelWithHint: true,
                          prefixIcon: Icon(Icons.notes_outlined),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: const Text('Cancel'),
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.save_outlined),
                  label: Text(isEditing ? 'Update' : 'Save'),
                  onPressed: () async {
                    final recordNo =
                        recordNoController.text.trim();
                    final participants =
                        participantsController.text.trim();
                    final subject =
                        subjectController.text.trim();

                    if (recordNo.isEmpty ||
                        participants.isEmpty ||
                        subject.isEmpty) {
                      setDialogState(() {
                        validationMessage =
                            'Meeting No., Participants and Subject are required.';
                      });
                      return;
                    }

                    if (dueDate != null &&
                        dueDate!.isBefore(meetingDate)) {
                      setDialogState(() {
                        validationMessage =
                            'Action Due Date cannot be before the meeting date.';
                      });
                      return;
                    }

                    final now = DateTime.now();
                    final existingId =
                        existingRecord?['id']?.toString();

                    final record = <String, dynamic>{
                      'id': existingId ??
                          now.microsecondsSinceEpoch.toString(),
                      'recordNo': recordNo,
                      'consultationType': consultationType,
                      'location': locationController.text.trim(),
                      'committee': committeeController.text.trim(),
                      'chairperson':
                          chairpersonController.text.trim(),
                      'conductedBy':
                          conductedByController.text.trim(),
                      'participants': participants,
                      'subject': subject,
                      'meetingDate':
                          meetingDate.toIso8601String(),
                      'meetingTime':
                          _formatTime(meetingTime),
                      'issues': issuesController.text.trim(),
                      'suggestions':
                          suggestionsController.text.trim(),
                      'actions': actionsController.text.trim(),
                      'actionOwner':
                          actionOwnerController.text.trim(),
                      'dueDate':
                          dueDate?.toIso8601String() ?? '',
                      'status': status,
                      'remarks': remarksController.text.trim(),
                      'createdAt':
                          existingRecord?['createdAt']?.toString() ??
                              now.toIso8601String(),
                      'updatedAt':
                          now.toIso8601String(),
                    };

                    if (isEditing) {
                      final index = _records.indexWhere(
                        (item) =>
                            item['id']?.toString() == existingId,
                      );

                      if (index >= 0) {
                        _records[index] = record;
                      }
                    } else {
                      _records.insert(0, record);
                    }

                    await _saveRecords();

                    if (!mounted) {
                      return;
                    }

                    setState(() {});

                    Navigator.pop(dialogContext);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          isEditing
                              ? 'HSE consultation updated successfully.'
                              : 'HSE consultation saved successfully.',
                        ),
                      ),
                    );
                  },
                ),
              ],
            );
          },
        );
      },
    );

    recordNoController.dispose();
    locationController.dispose();
    committeeController.dispose();
    chairpersonController.dispose();
    conductedByController.dispose();
    participantsController.dispose();
    subjectController.dispose();
    issuesController.dispose();
    suggestionsController.dispose();
    actionsController.dispose();
    actionOwnerController.dispose();
    remarksController.dispose();
  }

  Future<void> _deleteRecord(Map<String, dynamic> record) async {
    final recordNo =
        record['recordNo']?.toString() ?? 'this record';

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Consultation?'),
          content: Text(
            'Delete consultation / meeting $recordNo?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirmed != true) {
      return;
    }

    final recordId = record['id']?.toString();

    _records.removeWhere(
      (item) => item['id']?.toString() == recordId,
    );

    await _saveRecords();

    if (!mounted) {
      return;
    }

    setState(() {});

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Consultation record deleted.'),
      ),
    );
  }

  Future<void> _showHistory(Map<String, dynamic> record) async {
    final createdAt = record['createdAt']?.toString() ?? '';
    final updatedAt = record['updatedAt']?.toString() ?? '';

    await showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Record History'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _historyRow(
                'Created',
                _formatDateTime(createdAt),
              ),
              const SizedBox(height: 8),
              _historyRow(
                'Last Updated',
                _formatDateTime(updatedAt),
              ),
              const SizedBox(height: 12),
              const Text(
                'The current consultation record is stored locally in SafeNexus HSE.',
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Widget _historyRow(String label, String value) {
    return Row(
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
    );
  }

  TimeOfDay _parseTime(String? value) {
    if (value == null || value.isEmpty) {
      return const TimeOfDay(hour: 9, minute: 0);
    }

    final parts = value.split(':');

    if (parts.length != 2) {
      return const TimeOfDay(hour: 9, minute: 0);
    }

    final hour = int.tryParse(parts[0]);
    final minute = int.tryParse(parts[1]);

    if (hour == null ||
        minute == null ||
        hour < 0 ||
        hour > 23 ||
        minute < 0 ||
        minute > 59) {
      return const TimeOfDay(hour: 9, minute: 0);
    }

    return TimeOfDay(hour: hour, minute: minute);
  }

  String _formatTime(TimeOfDay time) {
    return '${time.hour.toString().padLeft(2, '0')}:'
        '${time.minute.toString().padLeft(2, '0')}';
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }

  String _formatDateTime(String value) {
    final date = DateTime.tryParse(value);

    if (date == null) {
      return 'Not available';
    }

    return '${_formatDate(date)} '
        '${date.hour.toString().padLeft(2, '0')}:'
        '${date.minute.toString().padLeft(2, '0')}';
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'Open':
        return Colors.orange;
      case 'In Progress':
        return Colors.blue;
      case 'Completed':
        return primaryGreen;
      case 'Cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Widget _summaryCard(
    String title,
    int value,
    IconData icon,
  ) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.all(11),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.grey.withValues(alpha: 0.18),
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: primaryGreen,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              value.toString(),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: darkGreen,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }

  Widget _detailRow(
    IconData icon,
    String label,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 17,
            color: primaryGreen,
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecordCard(Map<String, dynamic> record) {
    final recordNo = record['recordNo']?.toString() ?? '';
    final consultationType =
        record['consultationType']?.toString() ?? '';
    final location = record['location']?.toString() ?? '';
    final committee = record['committee']?.toString() ?? '';
    final chairperson = record['chairperson']?.toString() ?? '';
    final participants = record['participants']?.toString() ?? '';
    final subject = record['subject']?.toString() ?? '';
    final actionOwner = record['actionOwner']?.toString() ?? '';
    final status = record['status']?.toString() ?? '';

    final meetingDate = DateTime.tryParse(
      record['meetingDate']?.toString() ?? '',
    );

    final dueDate = DateTime.tryParse(
      record['dueDate']?.toString() ?? '',
    );

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    '$recordNo 鈥� $consultationType',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: darkGreen,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 9,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: _statusColor(status)
                        .withValues(alpha: 0.10),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      color: _statusColor(status),
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            if (meetingDate != null)
              _detailRow(
                Icons.calendar_today_outlined,
                'Date',
                _formatDate(meetingDate),
              ),
            if ((record['meetingTime']?.toString() ?? '').isNotEmpty)
              _detailRow(
                Icons.access_time_outlined,
                'Time',
                record['meetingTime'].toString(),
              ),
            if (location.isNotEmpty)
              _detailRow(
                Icons.location_on_outlined,
                'Location',
                location,
              ),
            if (committee.isNotEmpty)
              _detailRow(
                Icons.groups_2_outlined,
                'Committee',
                committee,
              ),
            if (chairperson.isNotEmpty)
              _detailRow(
                Icons.person_outline,
                'Chairperson',
                chairperson,
              ),
            _detailRow(
              Icons.topic_outlined,
              'Subject',
              subject,
            ),
            _detailRow(
              Icons.people_outline,
              'Participants',
              participants,
            ),
            if (actionOwner.isNotEmpty)
              _detailRow(
                Icons.person_pin_outlined,
                'Action Owner',
                actionOwner,
              ),
            if (dueDate != null)
              _detailRow(
                Icons.event_outlined,
                'Due Date',
                _formatDate(dueDate),
              ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  tooltip: 'History',
                  onPressed: () => _showHistory(record),
                  icon: const Icon(Icons.history),
                ),
                IconButton(
                  tooltip: 'Edit',
                  onPressed: () => _showRecordForm(
                    existingRecord: record,
                  ),
                  icon: const Icon(Icons.edit_outlined),
                ),
                IconButton(
                  tooltip: 'Delete',
                  onPressed: () => _deleteRecord(record),
                  icon: const Icon(
                    Icons.delete_outline,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.groups_outlined,
              size: 64,
              color: primaryGreen.withValues(alpha: 0.45),
            ),
            const SizedBox(height: 12),
            const Text(
              'No consultation records',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: darkGreen,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Add your first worker consultation or safety committee record.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredRecords = _filteredRecords;

    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        title: const Text(
          'HSE Consultation & Worker Participation',
        ),
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        onPressed: () => _showRecordForm(),
        icon: const Icon(Icons.add),
        label: const Text('Add Consultation'),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      12,
                      12,
                      4,
                      4,
                    ),
                    child: Row(
                      children: [
                        _summaryCard(
                          'Total',
                          _totalCount,
                          Icons.list_alt_outlined,
                        ),
                        _summaryCard(
                          'Open',
                          _openCount,
                          Icons.folder_open_outlined,
                        ),
                        _summaryCard(
                          'Progress',
                          _inProgressCount,
                          Icons.pending_actions_outlined,
                        ),
                        _summaryCard(
                          'Done',
                          _completedCount,
                          Icons.check_circle_outline,
                        ),
                        _summaryCard(
                          'Overdue',
                          _overdueCount,
                          Icons.warning_amber_outlined,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      12,
                      8,
                      12,
                      4,
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText:
                            'Search meeting no., topic, committee, participants...',
                        prefixIcon: const Icon(Icons.search),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _searchQuery = value;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      12,
                      4,
                      12,
                      8,
                    ),
                    child: DropdownButtonFormField<String>(
                      initialValue: _statusFilter,
                      decoration: InputDecoration(
                        labelText: 'Status Filter',
                        prefixIcon: const Icon(Icons.filter_list),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      items: [
                        'All',
                        ..._statuses,
                      ]
                          .map(
                            (item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(item),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _statusFilter = value;
                          });
                        }
                      },
                    ),
                  ),
                  Expanded(
                    child: filteredRecords.isEmpty
                        ? _buildEmptyState()
                        : ListView.builder(
                            padding: const EdgeInsets.fromLTRB(
                              12,
                              4,
                              12,
                              90,
                            ),
                            itemCount: filteredRecords.length,
                            itemBuilder: (context, index) {
                              return _buildRecordCard(
                                filteredRecords[index],
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
    );
  }
}
