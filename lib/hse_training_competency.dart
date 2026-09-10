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
                            existingRecord!['id']?.toString(),
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
