import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HseTrainingCompetencyPage extends StatefulWidget {
  const HseTrainingCompetencyPage({super.key});

  @override
  State<HseTrainingCompetencyPage> createState() =>
      _HseTrainingCompetencyPageState();
}

class _HseTrainingCompetencyPageState
    extends State<HseTrainingCompetencyPage> {
  static const String _storageKey =
      'safenexus_hse_training_competency_records';

  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);

  List<Map<String, dynamic>> _records = [];
  String _searchQuery = '';
  String _statusFilter = 'All';
  bool _isLoading = true;

  final List<String> _trainingTypes = const [
    'Induction',
    'Toolbox Talk',
    'HSE Training',
    'Fire Safety',
    'First Aid',
    'Work at Height',
    'Confined Space',
    'Lifting & Rigging',
    'Scaffolding',
    'Electrical Safety',
    'Permit to Work',
    'Defensive Driving',
    'Equipment Operation',
    'Chemical Safety',
    'Emergency Response',
    'Environmental Training',
    'Other',
  ];

  final List<String> _competencyLevels = const [
    'Beginner',
    'Intermediate',
    'Advanced',
    'Competent',
    'Highly Competent',
  ];

  final List<String> _statuses = const [
    'Valid',
    'Expiring Soon',
    'Expired',
    'Planned',
    'In Progress',
    'Not Competent',
    'Competent',
  ];

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

      final matchesStatus =
          _statusFilter == 'All' || status == _statusFilter;

      if (!matchesStatus) {
        return false;
      }

      if (query.isEmpty) {
        return true;
      }

      final searchable = [
        record['employeeName'],
        record['employeeId'],
        record['jobRole'],
        record['department'],
        record['trainingType'],
        record['courseTitle'],
        record['trainingProvider'],
        record['certificateNo'],
        record['trainerAssessor'],
        record['competencyLevel'],
        record['remarks'],
      ].map((value) => value?.toString().toLowerCase() ?? '');

      return searchable.any(
        (value) => value.contains(query),
      );
    }).toList();
  }

  int get _totalCount => _records.length;

  int get _validCount =>
      _records.where((r) => r['status'] == 'Valid').length;

  int get _expiringSoonCount =>
      _records.where((r) => r['status'] == 'Expiring Soon').length;

  int get _expiredCount =>
      _records.where((r) => r['status'] == 'Expired').length;

  int get _competentCount =>
      _records.where((r) => r['status'] == 'Competent').length;

  Future<void> _showRecordForm({
    Map<String, dynamic>? existingRecord,
  }) async {
    final isEditing = existingRecord != null;

    final employeeNameController = TextEditingController(
      text: existingRecord?['employeeName']?.toString() ?? '',
    );
    final employeeIdController = TextEditingController(
      text: existingRecord?['employeeId']?.toString() ?? '',
    );
    final jobRoleController = TextEditingController(
      text: existingRecord?['jobRole']?.toString() ?? '',
    );
    final departmentController = TextEditingController(
      text: existingRecord?['department']?.toString() ?? '',
    );
    final courseTitleController = TextEditingController(
      text: existingRecord?['courseTitle']?.toString() ?? '',
    );
    final providerController = TextEditingController(
      text: existingRecord?['trainingProvider']?.toString() ?? '',
    );
    final certificateController = TextEditingController(
      text: existingRecord?['certificateNo']?.toString() ?? '',
    );
    final trainerController = TextEditingController(
      text: existingRecord?['trainerAssessor']?.toString() ?? '',
    );
    final remarksController = TextEditingController(
      text: existingRecord?['remarks']?.toString() ?? '',
    );

    String trainingType =
        existingRecord?['trainingType']?.toString() ??
            _trainingTypes.first;

    String competencyLevel =
        existingRecord?['competencyLevel']?.toString() ??
            _competencyLevels.first;

    String status =
        existingRecord?['status']?.toString() ?? 'Planned';

    DateTime trainingDate =
        DateTime.tryParse(
              existingRecord?['trainingDate']?.toString() ?? '',
            ) ??
            DateTime.now();

    DateTime? expiryDate =
        DateTime.tryParse(
          existingRecord?['expiryDate']?.toString() ?? '',
        );

    String? validationMessage;

    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            Future<void> selectTrainingDate() async {
              final selected = await showDatePicker(
                context: context,
                initialDate: trainingDate,
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );

              if (selected != null) {
                setDialogState(() {
                  trainingDate = selected;
                });
              }
            }

            Future<void> selectExpiryDate() async {
              final selected = await showDatePicker(
                context: context,
                initialDate: expiryDate ?? trainingDate,
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );

              if (selected != null) {
                setDialogState(() {
                  expiryDate = selected;
                });
              }
            }

            return AlertDialog(
              title: Text(
                isEditing
                    ? 'Edit Training / Competency'
                    : 'Add Training / Competency',
              ),
              content: SizedBox(
                width: 560,
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
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.red.withValues(alpha: 0.08),
                          ),
                          child: Text(
                            validationMessage!,
                            style: const TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      TextField(
                        controller: employeeNameController,
                        decoration: const InputDecoration(
                          labelText: 'Employee / Worker Name *',
                          prefixIcon: Icon(Icons.person_outline),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: employeeIdController,
                        decoration: const InputDecoration(
                          labelText: 'Employee ID',
                          prefixIcon: Icon(Icons.badge_outlined),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: jobRoleController,
                        decoration: const InputDecoration(
                          labelText: 'Job Role / Designation',
                          prefixIcon: Icon(Icons.work_outline),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: departmentController,
                        decoration: const InputDecoration(
                          labelText: 'Department / Work Group',
                          prefixIcon: Icon(Icons.groups_outlined),
                        ),
                      ),
                      const SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        initialValue: trainingType,
                        decoration: const InputDecoration(
                          labelText: 'Training / Competency Type',
                          prefixIcon: Icon(Icons.school_outlined),
                        ),
                        items: _trainingTypes
                            .map(
                              (item) => DropdownMenuItem(
                                value: item,
                                child: Text(item),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          if (value != null) {
                            setDialogState(() {
                              trainingType = value;
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: courseTitleController,
                        decoration: const InputDecoration(
                          labelText: 'Course / Training Title *',
                          prefixIcon: Icon(Icons.menu_book_outlined),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: providerController,
                        decoration: const InputDecoration(
                          labelText: 'Training Provider',
                          prefixIcon: Icon(Icons.business_outlined),
                        ),
                      ),
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: selectTrainingDate,
                        child: InputDecorator(
                          decoration: const InputDecoration(
                            labelText: 'Training Date',
                            prefixIcon:
                                Icon(Icons.calendar_today_outlined),
                          ),
                          child: Text(
                            _formatDate(trainingDate),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: selectExpiryDate,
                        child: InputDecorator(
                          decoration: const InputDecoration(
                            labelText: 'Expiry / Valid Until',
                            prefixIcon:
                                Icon(Icons.event_outlined),
                          ),
                          child: Text(
                            expiryDate == null
                                ? 'Not specified'
                                : _formatDate(expiryDate!),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: certificateController,
                        decoration: const InputDecoration(
                          labelText: 'Certificate No.',
                          prefixIcon: Icon(Icons.verified_outlined),
                        ),
                      ),
                      const SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        initialValue: competencyLevel,
                        decoration: const InputDecoration(
                          labelText: 'Competency Level',
                          prefixIcon:
                              Icon(Icons.workspace_premium_outlined),
                        ),
                        items: _competencyLevels
                            .map(
                              (item) => DropdownMenuItem(
                                value: item,
                                child: Text(item),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          if (value != null) {
                            setDialogState(() {
                              competencyLevel = value;
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        initialValue: status,
                        decoration: const InputDecoration(
                          labelText: 'Status',
                          prefixIcon: Icon(Icons.flag_outlined),
                        ),
                        items: _statuses
                            .map(
                              (item) => DropdownMenuItem(
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
                        controller: trainerController,
                        decoration: const InputDecoration(
                          labelText: 'Trainer / Assessor',
                          prefixIcon:
                              Icon(Icons.person_search_outlined),
                        ),
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
                  onPressed: () {
                    Navigator.pop(dialogContext);
                  },
                  child: const Text('Cancel'),
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.save_outlined),
                  label: Text(isEditing ? 'Update' : 'Save'),
                  onPressed: () async {
                    final employeeName =
                        employeeNameController.text.trim();

                    final courseTitle =
                        courseTitleController.text.trim();

                    if (employeeName.isEmpty ||
                        courseTitle.isEmpty) {
                      setDialogState(() {
                        validationMessage =
                            'Employee / Worker Name and Course / Training Title are required.';
                      });
                      return;
                    }

                    if (expiryDate != null &&
                        expiryDate!.isBefore(trainingDate)) {
                      setDialogState(() {
                        validationMessage =
                            'Expiry date cannot be before the training date.';
                      });
                      return;
                    }

                    final now = DateTime.now();

                    final record = <String, dynamic>{
                      'id': existingRecord?['id']?.toString() ??
                          now.microsecondsSinceEpoch.toString(),
                      'employeeName': employeeName,
                      'employeeId':
                          employeeIdController.text.trim(),
                      'jobRole': jobRoleController.text.trim(),
                      'department':
                          departmentController.text.trim(),
                      'trainingType': trainingType,
                      'courseTitle': courseTitle,
                      'trainingProvider':
                          providerController.text.trim(),
                      'trainingDate':
                          trainingDate.toIso8601String(),
                      'expiryDate':
                          expiryDate?.toIso8601String() ?? '',
                      'certificateNo':
                          certificateController.text.trim(),
                      'competencyLevel': competencyLevel,
                      'status': status,
                      'trainerAssessor':
                          trainerController.text.trim(),
                      'remarks': remarksController.text.trim(),
                      'createdAt':
                          existingRecord?['createdAt']?.toString() ??
                              now.toIso8601String(),
                      'updatedAt': now.toIso8601String(),
                    };

                    if (isEditing) {
                      final index = _records.indexWhere(
                        (item) =>
                            item['id']?.toString() ==
                            existingRecord['id']?.toString(),
                      );

                      if (index >= 0) {
                        _records[index] = record;
                      }
                    } else {
                      _records.insert(0, record);
                    }

                    await _saveRecords();

                    if (!mounted) return;

                    setState(() {});

                    Navigator.pop(dialogContext);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          isEditing
                              ? 'Training record updated successfully.'
                              : 'Training record saved successfully.',
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

    employeeNameController.dispose();
    employeeIdController.dispose();
    jobRoleController.dispose();
    departmentController.dispose();
    courseTitleController.dispose();
    providerController.dispose();
    certificateController.dispose();
    trainerController.dispose();
    remarksController.dispose();
  }

  Future<void> _deleteRecord(
    Map<String, dynamic> record,
  ) async {
    final employeeName =
        record['employeeName']?.toString() ?? 'this record';

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Record?'),
          content: Text(
            'Are you sure you want to delete the training record for $employeeName?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirmed != true) return;

    _records.removeWhere(
      (item) =>
          item['id']?.toString() ==
          record['id']?.toString(),
    );

    await _saveRecords();

    if (!mounted) return;

    setState(() {});

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Training record deleted.'),
      ),
    );
  }

  Future<void> _showHistory(
    Map<String, dynamic> record,
  ) async {
    final updatedAt =
        record['updatedAt']?.toString() ?? '';

    final createdAt =
        record['createdAt']?.toString() ?? '';

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
                'Current record is stored locally in SafeNexus HSE.',
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Widget _historyRow(
    String label,
    String value,
  ) {
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
        Expanded(
          child: Text(value),
        ),
      ],
    );
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
      case 'Valid':
      case 'Competent':
        return primaryGreen;
      case 'Expiring Soon':
        return Colors.orange;
      case 'Expired':
      case 'Not Competent':
        return Colors.red;
      case 'In Progress':
        return Colors.blue;
      case 'Planned':
        return Colors.deepPurple;
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
        padding: const EdgeInsets.all(12),
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
              size: 25,
            ),
            const SizedBox(height: 5),
            Text(
              value.toString(),
              style: const TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                color: darkGreen,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecordCard(
    Map<String, dynamic> record,
  ) {
    final employeeName =
        record['employeeName']?.toString() ?? '';

    final employeeId =
        record['employeeId']?.toString() ?? '';

    final jobRole =
        record['jobRole']?.toString() ?? '';

    final department =
        record['department']?.toString() ?? '';

    final trainingType =
        record['trainingType']?.toString() ?? '';

    final courseTitle =
        record['courseTitle']?.toString() ?? '';

    final provider =
        record['trainingProvider']?.toString() ?? '';

    final certificate =
        record['certificateNo']?.toString() ?? '';

    final competency =
        record['competencyLevel']?.toString() ?? '';

    final status =
        record['status']?.toString() ?? '';

    final expiryDate =
        DateTime.tryParse(
      record['expiryDate']?.toString() ?? '',
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
                    employeeName,
                    style: const TextStyle(
                      fontSize: 17,
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
            if (employeeId.isNotEmpty)
              _detailRow(
                Icons.badge_outlined,
                'Employee ID',
                employeeId,
              ),
            if (jobRole.isNotEmpty)
              _detailRow(
                Icons.work_outline,
                'Role',
                jobRole,
              ),
            if (department.isNotEmpty)
              _detailRow(
                Icons.groups_outlined,
                'Department',
                department,
              ),
            _detailRow(
              Icons.school_outlined,
              'Training',
              courseTitle,
            ),
            _detailRow(
              Icons.category_outlined,
              'Type',
              trainingType,
            ),
            if (provider.isNotEmpty)
              _detailRow(
                Icons.business_outlined,
                'Provider',
                provider,
              ),
            _detailRow(
              Icons.workspace_premium_outlined,
              'Competency',
              competency,
            ),
            if (certificate.isNotEmpty)
              _detailRow(
                Icons.verified_outlined,
                'Certificate',
                certificate,
              ),
            if (expiryDate != null)
              _detailRow(
                Icons.event_outlined,
                'Valid Until',
                _formatDate(expiryDate),
              ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  tooltip: 'History',
                  onPressed: () => _showHistory(record),
                  icon: const Icon(
                    Icons.history,
                  ),
                ),
                IconButton(
                  tooltip: 'Edit',
                  onPressed: () => _showRecordForm(
                    existingRecord: record,
                  ),
                  icon: const Icon(
                    Icons.edit_outlined,
                  ),
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
            width: 82,
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
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        title: const Text(
          'HSE Training & Competency',
        ),
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        onPressed: () => _showRecordForm(),
        icon: const Icon(Icons.add),
        label: const Text('Add Record'),
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
                          'Valid',
                          _validCount,
                          Icons.check_circle_outline,
                        ),
                        _summaryCard(
                          'Expiring',
                          _expiringSoonCount,
                          Icons.warning_amber_outlined,
                        ),
                        _summaryCard(
                          'Expired',
                          _expiredCount,
                          Icons.error_outline,
                        ),
                        _summaryCard(
                          'Competent',
                          _competentCount,
                          Icons.verified_user_outlined,
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
                            'Search employee, training, role, certificate...',
                        prefixIcon:
                            const Icon(Icons.search),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(12),
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
                        prefixIcon:
                            const Icon(Icons.filter_list),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
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
                          setState(() {
                            _statusFilter = value;
                          });
                        }
                      },
                    ),
                  ),
                  Expanded(
                    child: _filteredRecords.isEmpty
                        ? _buildEmptyState()
                        : ListView.builder(
                            padding:
                                const EdgeInsets.fromLTRB(
                              12,
                              4,
                              12,
                              90,
                            ),
                            itemCount:
                                _filteredRecords.length,
                            itemBuilder:
                                (context, index) {
                              return _buildRecordCard(
                                _filteredRecords[index],
                              );
                            },
                          ),
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
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            Icon(
              Icons.school_outlined,
              size: 64,
              color: primaryGreen
                  .withValues(alpha: 0.45),
            ),
            const SizedBox(height: 12),
            const Text(
              'No training / competency records',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: darkGreen,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Add your first training or competency record.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// ===============================================================
// MERGED LEGACY MODULE
// Source: safenexus_step49_training_safety_culture.dart
// Purpose: preserve audited Step functionality inside the canonical module.
// ===============================================================
class Merged49TrainingsafetycultureSafeNexusStep49TrainingSafetyCulturePage extends StatefulWidget {
  const Merged49TrainingsafetycultureSafeNexusStep49TrainingSafetyCulturePage({super.key});

  @override
  State<Merged49TrainingsafetycultureSafeNexusStep49TrainingSafetyCulturePage> createState() =>
      _Merged49TrainingsafetycultureSafeNexusStep49TrainingSafetyCulturePageState();
}

class _Merged49TrainingsafetycultureSafeNexusStep49TrainingSafetyCulturePageState
    extends State<Merged49TrainingsafetycultureSafeNexusStep49TrainingSafetyCulturePage> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);
  static const String storageKey =
      'safenexus_hse_step49_training_safety_culture';

  final List<Map<String, dynamic>> _Merged49Trainingsafetyculturerecords = <Map<String, dynamic>>[];

  String _Merged49Trainingsafetyculturesearch = '';
  String _Merged49TrainingsafetyculturestatusFilter = 'All';
  String _Merged49TrainingsafetyculturecategoryFilter = 'All';

  final List<String> _Merged49Trainingsafetyculturestatuses = <String>[
    'Planned',
    'Scheduled',
    'In Progress',
    'Completed',
    'Evaluation Due',
    'Closed',
  ];

  final List<String> _Merged49Trainingsafetyculturecategories = <String>[
    'Training',
    'Training Needs Analysis',
    'Annual Training Plan',
    'Toolbox Talk',
    'Induction',
    'Refresher Training',
    'Competency Development',
    'Assessment',
    'Safety Campaign',
    'Safety Culture',
  ];

  @override
  void initState() {
    super.initState();
    _Merged49TrainingsafetycultureloadRecords();
  }

  Future<void> _Merged49TrainingsafetycultureloadRecords() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> saved = prefs.getStringList(storageKey) ?? <String>[];

    if (!mounted) return;

    setState(() {
      _Merged49Trainingsafetyculturerecords
        ..clear()
        ..addAll(
          saved.map(
            (String title) => <String, dynamic>{
              'id': DateTime.now().microsecondsSinceEpoch.toString(),
              'title': title,
              'category': 'Training',
              'status': 'Planned',
              'priority': 'Medium',
              'audience': '',
              'trainer': '',
              'date': '',
              'dueDate': '',
              'location': '',
              'needs': '',
              'objective': '',
              'content': '',
              'attendance': '',
              'assessment': '',
              'effectiveness': '',
              'culture': '',
              'actions': '',
              'notes': '',
              'createdAt': DateTime.now().toIso8601String(),
            },
          ),
        );
    });
  }

  Future<void> _Merged49TrainingsafetyculturesaveRecords() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> titles =
        _Merged49Trainingsafetyculturerecords.map((Map<String, dynamic> e) => e['title'] as String).toList();
    await prefs.setStringList(storageKey, titles);
  }

  List<Map<String, dynamic>> get _Merged49TrainingsafetyculturefilteredRecords {
    return _Merged49Trainingsafetyculturerecords.where((Map<String, dynamic> item) {
      final String searchable = <String>[
        item['title'],
        item['category'],
        item['status'],
        item['priority'],
        item['audience'],
        item['trainer'],
        item['content'],
        item['actions'],
      ].join(' ').toLowerCase();

      final bool matchesSearch =
          _Merged49Trainingsafetyculturesearch.trim().isEmpty || searchable.contains(_Merged49Trainingsafetyculturesearch.toLowerCase());
      final bool matchesStatus =
          _Merged49TrainingsafetyculturestatusFilter == 'All' || item['status'] == _Merged49TrainingsafetyculturestatusFilter;
      final bool matchesCategory =
          _Merged49TrainingsafetyculturecategoryFilter == 'All' || item['category'] == _Merged49TrainingsafetyculturecategoryFilter;

      return matchesSearch && matchesStatus && matchesCategory;
    }).toList();
  }

  int _Merged49TrainingsafetyculturecountStatus(String status) {
    return _Merged49Trainingsafetyculturerecords
        .where((Map<String, dynamic> item) => item['status'] == status)
        .length;
  }

  int _Merged49TrainingsafetyculturecountCategory(String category) {
    return _Merged49Trainingsafetyculturerecords
        .where((Map<String, dynamic> item) => item['category'] == category)
        .length;
  }

  Future<void> _Merged49TrainingsafetycultureaddOrEdit({Map<String, dynamic>? existing}) async {
    final Map<String, dynamic>? result =
        await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (BuildContext context) =>
          _Merged49TrainingsafetycultureTrainingFormDialog(existing: existing),
    );

    if (result == null) return;

    setState(() {
      if (existing == null) {
        _Merged49Trainingsafetyculturerecords.insert(0, <String, dynamic>{
          ...result,
          'id': DateTime.now().microsecondsSinceEpoch.toString(),
          'createdAt': DateTime.now().toIso8601String(),
        });
      } else {
        final int index = _Merged49Trainingsafetyculturerecords.indexOf(existing);
        if (index >= 0) {
          _Merged49Trainingsafetyculturerecords[index] = <String, dynamic>{
            ...existing,
            ...result,
          };
        }
      }
    });

    await _Merged49TrainingsafetyculturesaveRecords();
  }

  Future<void> _Merged49Trainingsafetyculturedelete(Map<String, dynamic> item) async {
    setState(() => _Merged49Trainingsafetyculturerecords.remove(item));
    await _Merged49TrainingsafetyculturesaveRecords();
  }

  Future<void> _Merged49TrainingsafetycultureconfirmDelete(Map<String, dynamic> item) async {
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Delete Training Record?'),
        content: const Text(
          'This training, learning or safety culture record will be deleted.',
        ),
        actions: <Widget>[
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

    if (confirmed == true) {
      await _Merged49Trainingsafetyculturedelete(item);
    }
  }

  void _Merged49TrainingsafetycultureshowDashboard() {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('49L — Learning & Safety Culture Dashboard'),
        content: SizedBox(
          width: 440,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _Merged49TrainingsafetyculturemetricRow('Total Records', _Merged49Trainingsafetyculturerecords.length),
                _Merged49TrainingsafetyculturemetricRow('Planned', _Merged49TrainingsafetyculturecountStatus('Planned')),
                _Merged49TrainingsafetyculturemetricRow('Scheduled', _Merged49TrainingsafetyculturecountStatus('Scheduled')),
                _Merged49TrainingsafetyculturemetricRow('In Progress', _Merged49TrainingsafetyculturecountStatus('In Progress')),
                _Merged49TrainingsafetyculturemetricRow('Completed', _Merged49TrainingsafetyculturecountStatus('Completed')),
                _Merged49TrainingsafetyculturemetricRow('Evaluation Due', _Merged49TrainingsafetyculturecountStatus('Evaluation Due')),
                _Merged49TrainingsafetyculturemetricRow('Closed', _Merged49TrainingsafetyculturecountStatus('Closed')),
                const Divider(),
                _Merged49TrainingsafetyculturemetricRow('Training', _Merged49TrainingsafetyculturecountCategory('Training')),
                _Merged49TrainingsafetyculturemetricRow(
                  'Toolbox Talks',
                  _Merged49TrainingsafetyculturecountCategory('Toolbox Talk'),
                ),
                _Merged49TrainingsafetyculturemetricRow(
                  'Induction',
                  _Merged49TrainingsafetyculturecountCategory('Induction'),
                ),
                _Merged49TrainingsafetyculturemetricRow(
                  'Safety Campaigns',
                  _Merged49TrainingsafetyculturecountCategory('Safety Campaign'),
                ),
                _Merged49TrainingsafetyculturemetricRow(
                  'Safety Culture',
                  _Merged49TrainingsafetyculturecountCategory('Safety Culture'),
                ),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _Merged49TrainingsafetyculturemetricRow(String label, int value) {
    return ListTile(
      dense: true,
      title: Text(label),
      trailing: CircleAvatar(
        radius: 16,
        backgroundColor: primaryGreen,
        child: Text(
          '$value',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void _Merged49TrainingsafetycultureshowGuide() {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Step 49 — Training & Safety Culture Guide'),
        content: const SingleChildScrollView(
          child: Text(
            'Identify Need → Plan → Train → Assess → Verify Competency → '
            'Engage → Evaluate Effectiveness → Improve → Close → Analyze\n\n'
            '49A HSE Training Master\n'
            '49B Training Needs Analysis (TNA)\n'
            '49C Annual Training Plan\n'
            '49D Toolbox Talk & Safety Learning\n'
            '49E Induction & Refresher Training\n'
            '49F Competency Development\n'
            '49G Training Attendance & Records\n'
            '49H Assessment & Effectiveness Evaluation\n'
            '49I Safety Awareness Campaigns\n'
            '49J Safety Culture & Workforce Engagement\n'
            '49K Training History / Audit Trail\n'
            '49L HSE Learning & Safety Culture Intelligence Dashboard\n\n'
            'UAE-wide HSE learning architecture for workforce development, '
            'competency, awareness and continual safety culture improvement.',
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> records = _Merged49TrainingsafetyculturefilteredRecords;

    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
        title: const Text('Step 49 • Training & Safety Culture'),
        actions: <Widget>[
          IconButton(
            tooltip: 'Guide',
            onPressed: _Merged49TrainingsafetycultureshowGuide,
            icon: const Icon(Icons.help_outline),
          ),
          IconButton(
            tooltip: 'Dashboard',
            onPressed: _Merged49TrainingsafetycultureshowDashboard,
            icon: const Icon(Icons.dashboard_outlined),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        onPressed: () => _Merged49TrainingsafetycultureaddOrEdit(),
        icon: const Icon(Icons.add),
        label: const Text('New Training'),
      ),
      body: Column(
        children: <Widget>[
          _Merged49Trainingsafetycultureheader(),
          _Merged49Trainingsafetyculturefilters(),
          Expanded(
            child: records.isEmpty
                ? _Merged49TrainingsafetycultureemptyState()
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(12, 4, 12, 90),
                    itemCount: records.length,
                    itemBuilder: (BuildContext context, int index) {
                      return _Merged49TrainingsafetyculturerecordCard(records[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _Merged49Trainingsafetycultureheader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'HSE Training, Learning & Safety Culture Center',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: darkGreen,
            ),
          ),
          SizedBox(height: 5),
          Text(
            'പരിശീലനം • Competency • Learning • Awareness • Safety Culture',
            style: TextStyle(fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _Merged49Trainingsafetyculturefilters() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: <Widget>[
          TextField(
            onChanged: (String value) => setState(() => _Merged49Trainingsafetyculturesearch = value),
            decoration: InputDecoration(
              hintText: 'Search training, trainer, audience, actions...',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: <Widget>[
              Expanded(
                child: DropdownButtonFormField<String>(
                  initialValue: _Merged49TrainingsafetyculturestatusFilter,
                  decoration: const InputDecoration(
                    labelText: 'Status',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                  ),
                  items: <String>['All', ..._Merged49Trainingsafetyculturestatuses]
                      .map(
                        (String value) => DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        ),
                      )
                      .toList(),
                  onChanged: (String? value) {
                    if (value != null) {
                      setState(() => _Merged49TrainingsafetyculturestatusFilter = value);
                    }
                  },
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: DropdownButtonFormField<String>(
                  initialValue: _Merged49TrainingsafetyculturecategoryFilter,
                  decoration: const InputDecoration(
                    labelText: 'Category',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                  ),
                  items: <String>['All', ..._Merged49Trainingsafetyculturecategories]
                      .map(
                        (String value) => DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (String? value) {
                    if (value != null) {
                      setState(() => _Merged49TrainingsafetyculturecategoryFilter = value);
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _Merged49TrainingsafetyculturerecordCard(Map<String, dynamic> item) {
    final String title = item['title'] as String? ?? 'Untitled';
    final String category = item['category'] as String? ?? 'Training';
    final String status = item['status'] as String? ?? 'Planned';
    final String priority = item['priority'] as String? ?? 'Medium';
    final String audience = item['audience'] as String? ?? '';
    final String trainer = item['trainer'] as String? ?? '';
    final String date = item['date'] as String? ?? '';

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 1,
      child: ExpansionTile(
        leading: CircleAvatar(
          backgroundColor: primaryGreen.withValues(alpha: 0.12),
          child: const Icon(
            Icons.school_outlined,
            color: darkGreen,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          '$category • $status • $priority${date.isEmpty ? '' : ' • $date'}',
        ),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
        children: <Widget>[
          if (audience.isNotEmpty) _Merged49TrainingsafetyculturedetailLine('Audience', audience),
          if (trainer.isNotEmpty) _Merged49TrainingsafetyculturedetailLine('Trainer / Facilitator', trainer),
          _Merged49TrainingsafetyculturedetailLine(
            'Workflow',
            'Need → Plan → Train → Assess → Evaluate → Improve → Close',
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              IconButton(
                tooltip: 'Edit',
                onPressed: () => _Merged49TrainingsafetycultureaddOrEdit(existing: item),
                icon: const Icon(Icons.edit_outlined),
              ),
              IconButton(
                tooltip: 'Delete',
                onPressed: () => _Merged49TrainingsafetycultureconfirmDelete(item),
                icon: const Icon(Icons.delete_outline),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _Merged49TrainingsafetyculturedetailLine(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 145,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  Widget _Merged49TrainingsafetycultureemptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.school_outlined,
              size: 62,
              color: darkGreen.withValues(alpha: 0.45),
            ),
            const SizedBox(height: 12),
            const Text(
              'No training or safety culture records found',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Create the first HSE training, learning or safety culture record.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _Merged49TrainingsafetycultureTrainingFormDialog extends StatefulWidget {
  const _Merged49TrainingsafetycultureTrainingFormDialog({this.existing});

  final Map<String, dynamic>? existing;

  @override
  State<_Merged49TrainingsafetycultureTrainingFormDialog> createState() => _Merged49TrainingsafetycultureTrainingFormDialogState();
}

class _Merged49TrainingsafetycultureTrainingFormDialogState extends State<_Merged49TrainingsafetycultureTrainingFormDialog> {
  final GlobalKey<FormState> _Merged49TrainingsafetycultureformKey = GlobalKey<FormState>();

  late final TextEditingController _Merged49Trainingsafetyculturetitle;
  late final TextEditingController _Merged49Trainingsafetycultureaudience;
  late final TextEditingController _Merged49Trainingsafetyculturetrainer;
  late final TextEditingController _Merged49Trainingsafetyculturedate;
  late final TextEditingController _Merged49TrainingsafetyculturedueDate;
  late final TextEditingController _Merged49Trainingsafetyculturelocation;
  late final TextEditingController _Merged49Trainingsafetycultureneeds;
  late final TextEditingController _Merged49Trainingsafetycultureobjective;
  late final TextEditingController _Merged49Trainingsafetyculturecontent;
  late final TextEditingController _Merged49Trainingsafetycultureattendance;
  late final TextEditingController _Merged49Trainingsafetycultureassessment;
  late final TextEditingController _Merged49Trainingsafetycultureeffectiveness;
  late final TextEditingController _Merged49Trainingsafetycultureculture;
  late final TextEditingController _Merged49Trainingsafetycultureactions;
  late final TextEditingController _Merged49Trainingsafetyculturenotes;

  String _Merged49Trainingsafetyculturecategory = 'Training';
  String _Merged49Trainingsafetyculturestatus = 'Planned';
  String _Merged49Trainingsafetyculturepriority = 'Medium';

  final List<String> _Merged49Trainingsafetyculturecategories = <String>[
    'Training',
    'Training Needs Analysis',
    'Annual Training Plan',
    'Toolbox Talk',
    'Induction',
    'Refresher Training',
    'Competency Development',
    'Assessment',
    'Safety Campaign',
    'Safety Culture',
  ];

  final List<String> _Merged49Trainingsafetyculturestatuses = <String>[
    'Planned',
    'Scheduled',
    'In Progress',
    'Completed',
    'Evaluation Due',
    'Closed',
  ];

  final List<String> _Merged49Trainingsafetyculturepriorities = <String>[
    'Low',
    'Medium',
    'High',
    'Critical',
  ];

  @override
  void initState() {
    super.initState();

    final Map<String, dynamic> e = widget.existing ?? <String, dynamic>{};

    _Merged49Trainingsafetyculturetitle = TextEditingController(text: e['title'] as String? ?? '');
    _Merged49Trainingsafetycultureaudience = TextEditingController(text: e['audience'] as String? ?? '');
    _Merged49Trainingsafetyculturetrainer = TextEditingController(text: e['trainer'] as String? ?? '');
    _Merged49Trainingsafetyculturedate = TextEditingController(text: e['date'] as String? ?? '');
    _Merged49TrainingsafetyculturedueDate = TextEditingController(text: e['dueDate'] as String? ?? '');
    _Merged49Trainingsafetyculturelocation = TextEditingController(text: e['location'] as String? ?? '');
    _Merged49Trainingsafetycultureneeds = TextEditingController(text: e['needs'] as String? ?? '');
    _Merged49Trainingsafetycultureobjective = TextEditingController(text: e['objective'] as String? ?? '');
    _Merged49Trainingsafetyculturecontent = TextEditingController(text: e['content'] as String? ?? '');
    _Merged49Trainingsafetycultureattendance =
        TextEditingController(text: e['attendance'] as String? ?? '');
    _Merged49Trainingsafetycultureassessment =
        TextEditingController(text: e['assessment'] as String? ?? '');
    _Merged49Trainingsafetycultureeffectiveness =
        TextEditingController(text: e['effectiveness'] as String? ?? '');
    _Merged49Trainingsafetycultureculture = TextEditingController(text: e['culture'] as String? ?? '');
    _Merged49Trainingsafetycultureactions = TextEditingController(text: e['actions'] as String? ?? '');
    _Merged49Trainingsafetyculturenotes = TextEditingController(text: e['notes'] as String? ?? '');

    _Merged49Trainingsafetyculturecategory = e['category'] as String? ?? 'Training';
    _Merged49Trainingsafetyculturestatus = e['status'] as String? ?? 'Planned';
    _Merged49Trainingsafetyculturepriority = e['priority'] as String? ?? 'Medium';
  }

  @override
  void dispose() {
    _Merged49Trainingsafetyculturetitle.dispose();
    _Merged49Trainingsafetycultureaudience.dispose();
    _Merged49Trainingsafetyculturetrainer.dispose();
    _Merged49Trainingsafetyculturedate.dispose();
    _Merged49TrainingsafetyculturedueDate.dispose();
    _Merged49Trainingsafetyculturelocation.dispose();
    _Merged49Trainingsafetycultureneeds.dispose();
    _Merged49Trainingsafetycultureobjective.dispose();
    _Merged49Trainingsafetyculturecontent.dispose();
    _Merged49Trainingsafetycultureattendance.dispose();
    _Merged49Trainingsafetycultureassessment.dispose();
    _Merged49Trainingsafetycultureeffectiveness.dispose();
    _Merged49Trainingsafetycultureculture.dispose();
    _Merged49Trainingsafetycultureactions.dispose();
    _Merged49Trainingsafetyculturenotes.dispose();
    super.dispose();
  }

  InputDecoration _Merged49Trainingsafetyculturedecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      border: const OutlineInputBorder(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.existing == null
            ? 'New HSE Training / Learning Record'
            : 'Edit HSE Training / Learning Record',
      ),
      content: SizedBox(
        width: 520,
        child: Form(
          key: _Merged49TrainingsafetycultureformKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: _Merged49Trainingsafetyculturetitle,
                  decoration: _Merged49Trainingsafetyculturedecoration(
                    'Training / Initiative Title *',
                    Icons.title,
                  ),
                  validator: (String? value) =>
                      value == null || value.trim().isEmpty
                          ? 'Enter a title'
                          : null,
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  initialValue: _Merged49Trainingsafetyculturecategory,
                  decoration:
                      _Merged49Trainingsafetyculturedecoration('Category', Icons.category_outlined),
                  items: _Merged49Trainingsafetyculturecategories
                      .map(
                        (String value) => DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        ),
                      )
                      .toList(),
                  onChanged: (String? value) {
                    if (value != null) setState(() => _Merged49Trainingsafetyculturecategory = value);
                  },
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  initialValue: _Merged49Trainingsafetyculturestatus,
                  decoration:
                      _Merged49Trainingsafetyculturedecoration('Status', Icons.flag_outlined),
                  items: _Merged49Trainingsafetyculturestatuses
                      .map(
                        (String value) => DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        ),
                      )
                      .toList(),
                  onChanged: (String? value) {
                    if (value != null) setState(() => _Merged49Trainingsafetyculturestatus = value);
                  },
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  initialValue: _Merged49Trainingsafetyculturepriority,
                  decoration:
                      _Merged49Trainingsafetyculturedecoration('Priority', Icons.priority_high_outlined),
                  items: _Merged49Trainingsafetyculturepriorities
                      .map(
                        (String value) => DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        ),
                      )
                      .toList(),
                  onChanged: (String? value) {
                    if (value != null) setState(() => _Merged49Trainingsafetyculturepriority = value);
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _Merged49Trainingsafetycultureaudience,
                  decoration:
                      _Merged49Trainingsafetyculturedecoration('49A / Target Workforce', Icons.groups_outlined),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _Merged49Trainingsafetyculturetrainer,
                  decoration:
                      _Merged49Trainingsafetyculturedecoration('Trainer / Facilitator', Icons.person_outline),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _Merged49Trainingsafetyculturedate,
                  decoration:
                      _Merged49Trainingsafetyculturedecoration('Training / Activity Date', Icons.calendar_today_outlined),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _Merged49TrainingsafetyculturedueDate,
                  decoration:
                      _Merged49Trainingsafetyculturedecoration('49C / Evaluation Due Date', Icons.event_available_outlined),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _Merged49Trainingsafetyculturelocation,
                  decoration:
                      _Merged49Trainingsafetyculturedecoration('Location / Site', Icons.location_on_outlined),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _Merged49Trainingsafetycultureneeds,
                  maxLines: 2,
                  decoration:
                      _Merged49Trainingsafetyculturedecoration('49B Training Need / TNA', Icons.find_in_page_outlined),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _Merged49Trainingsafetycultureobjective,
                  maxLines: 2,
                  decoration:
                      _Merged49Trainingsafetyculturedecoration('Learning Objective / Competency Goal', Icons.flag_circle_outlined),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _Merged49Trainingsafetyculturecontent,
                  maxLines: 3,
                  decoration:
                      _Merged49Trainingsafetyculturedecoration('49D–49F Training / Learning Content', Icons.menu_book_outlined),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _Merged49Trainingsafetycultureattendance,
                  maxLines: 2,
                  decoration:
                      _Merged49Trainingsafetyculturedecoration('49G Attendance / Participation Record', Icons.fact_check_outlined),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _Merged49Trainingsafetycultureassessment,
                  maxLines: 2,
                  decoration:
                      _Merged49Trainingsafetyculturedecoration('49H Assessment / Competency Result', Icons.assignment_turned_in_outlined),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _Merged49Trainingsafetycultureeffectiveness,
                  maxLines: 2,
                  decoration:
                      _Merged49Trainingsafetyculturedecoration('49H Effectiveness Evaluation', Icons.assessment_outlined),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _Merged49Trainingsafetycultureculture,
                  maxLines: 2,
                  decoration:
                      _Merged49Trainingsafetyculturedecoration('49I–49J Awareness / Safety Culture Impact', Icons.volunteer_activism_outlined),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _Merged49Trainingsafetycultureactions,
                  maxLines: 3,
                  decoration:
                      _Merged49Trainingsafetyculturedecoration('Improvement / Follow-up Actions', Icons.task_alt_outlined),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _Merged49Trainingsafetyculturenotes,
                  maxLines: 3,
                  decoration:
                      _Merged49Trainingsafetyculturedecoration('49K History / Notes', Icons.notes_outlined),
                ),
              ],
            ),
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton.icon(
          onPressed: _Merged49Trainingsafetyculturesubmit,
          icon: const Icon(Icons.save_outlined),
          label: const Text('Save'),
        ),
      ],
    );
  }

  void _Merged49Trainingsafetyculturesubmit() {
    if (!_Merged49TrainingsafetycultureformKey.currentState!.validate()) return;

    Navigator.pop(context, <String, dynamic>{
      'title': _Merged49Trainingsafetyculturetitle.text.trim(),
      'category': _Merged49Trainingsafetyculturecategory,
      'status': _Merged49Trainingsafetyculturestatus,
      'priority': _Merged49Trainingsafetyculturepriority,
      'audience': _Merged49Trainingsafetycultureaudience.text.trim(),
      'trainer': _Merged49Trainingsafetyculturetrainer.text.trim(),
      'date': _Merged49Trainingsafetyculturedate.text.trim(),
      'dueDate': _Merged49TrainingsafetyculturedueDate.text.trim(),
      'location': _Merged49Trainingsafetyculturelocation.text.trim(),
      'needs': _Merged49Trainingsafetycultureneeds.text.trim(),
      'objective': _Merged49Trainingsafetycultureobjective.text.trim(),
      'content': _Merged49Trainingsafetyculturecontent.text.trim(),
      'attendance': _Merged49Trainingsafetycultureattendance.text.trim(),
      'assessment': _Merged49Trainingsafetycultureassessment.text.trim(),
      'effectiveness': _Merged49Trainingsafetycultureeffectiveness.text.trim(),
      'culture': _Merged49Trainingsafetycultureculture.text.trim(),
      'actions': _Merged49Trainingsafetycultureactions.text.trim(),
      'notes': _Merged49Trainingsafetyculturenotes.text.trim(),
    });
  }
}

