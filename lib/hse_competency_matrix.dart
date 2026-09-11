import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HseCompetencyMatrixPage extends StatefulWidget {
  const HseCompetencyMatrixPage({super.key});

  @override
  State<HseCompetencyMatrixPage> createState() =>
      _HseCompetencyMatrixPageState();
}

class _HseCompetencyMatrixPageState
    extends State<HseCompetencyMatrixPage> {
  static const String _storageKey =
      'safenexus_hse_competency_matrix_records';

  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);

  List<Map<String, dynamic>> _records = [];
  String _searchQuery = '';
  String _statusFilter = 'All';
  bool _isLoading = true;

  final List<String> _requiredLevels = const [
    'Basic',
    'Intermediate',
    'Advanced',
    'Expert',
  ];

  final List<String> _achievedLevels = const [
    'Not Assessed',
    'Basic',
    'Intermediate',
    'Advanced',
    'Expert',
  ];

  final List<String> _statuses = const [
    'Authorized',
    'Conditionally Authorized',
    'Assessment Required',
    'Training Required',
    'Expired',
    'Not Authorized',
    'Suspended',
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
        record['competency'],
        record['requiredLevel'],
        record['achievedLevel'],
        record['assessor'],
        record['authorizationNo'],
        record['gapAction'],
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

  int get _authorizedCount =>
      _records.where(
        (record) => record['status'] == 'Authorized',
      ).length;

  int get _conditionalCount =>
      _records.where(
        (record) => record['status'] == 'Conditionally Authorized',
      ).length;

  int get _assessmentRequiredCount =>
      _records.where(
        (record) => record['status'] == 'Assessment Required',
      ).length;

  int get _trainingRequiredCount =>
      _records.where(
        (record) => record['status'] == 'Training Required',
      ).length;

  Future<void> _showRecordForm({
    Map<String, dynamic>? existingRecord,
  }) async {
    final bool isEditing = existingRecord != null;

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

    final competencyController = TextEditingController(
      text: existingRecord?['competency']?.toString() ?? '',
    );

    final assessorController = TextEditingController(
      text: existingRecord?['assessor']?.toString() ?? '',
    );

    final authorizationNoController = TextEditingController(
      text: existingRecord?['authorizationNo']?.toString() ?? '',
    );

    final gapActionController = TextEditingController(
      text: existingRecord?['gapAction']?.toString() ?? '',
    );

    final remarksController = TextEditingController(
      text: existingRecord?['remarks']?.toString() ?? '',
    );

    String requiredLevel =
        existingRecord?['requiredLevel']?.toString() ??
            _requiredLevels.first;

    String achievedLevel =
        existingRecord?['achievedLevel']?.toString() ??
            _achievedLevels.first;

    String status =
        existingRecord?['status']?.toString() ??
            'Assessment Required';

    DateTime assessmentDate =
        DateTime.tryParse(
              existingRecord?['assessmentDate']?.toString() ?? '',
            ) ??
            DateTime.now();

    DateTime? validUntil = DateTime.tryParse(
      existingRecord?['validUntil']?.toString() ?? '',
    );

    String? validationMessage;

    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            Future<void> selectAssessmentDate() async {
              final selected = await showDatePicker(
                context: context,
                initialDate: assessmentDate,
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );

              if (selected != null) {
                setDialogState(() {
                  assessmentDate = selected;
                });
              }
            }

            Future<void> selectValidUntil() async {
              final selected = await showDatePicker(
                context: context,
                initialDate: validUntil ?? assessmentDate,
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );

              if (selected != null) {
                setDialogState(() {
                  validUntil = selected;
                });
              }
            }

            return AlertDialog(
              title: Text(
                isEditing
                    ? 'Edit Competency Record'
                    : 'Add Competency Record',
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
                          margin: const EdgeInsets.only(
                            bottom: 12,
                          ),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.red.withValues(
                              alpha: 0.08,
                            ),
                            borderRadius:
                                BorderRadius.circular(8),
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
                          labelText:
                              'Employee / Worker Name *',
                          prefixIcon:
                              Icon(Icons.person_outline),
                        ),
                      ),

                      const SizedBox(height: 10),

                      TextField(
                        controller: employeeIdController,
                        decoration: const InputDecoration(
                          labelText: 'Employee ID',
                          prefixIcon:
                              Icon(Icons.badge_outlined),
                        ),
                      ),

                      const SizedBox(height: 10),

                      TextField(
                        controller: jobRoleController,
                        decoration: const InputDecoration(
                          labelText:
                              'Job Role / Designation',
                          prefixIcon:
                              Icon(Icons.work_outline),
                        ),
                      ),

                      const SizedBox(height: 10),

                      TextField(
                        controller: departmentController,
                        decoration: const InputDecoration(
                          labelText:
                              'Department / Work Group',
                          prefixIcon:
                              Icon(Icons.groups_outlined),
                        ),
                      ),

                      const SizedBox(height: 10),

                      TextField(
                        controller: competencyController,
                        decoration: const InputDecoration(
                          labelText:
                              'Competency / Skill *',
                          prefixIcon:
                              Icon(Icons.engineering_outlined),
                        ),
                      ),

                      const SizedBox(height: 10),

                      DropdownButtonFormField<String>(
                        initialValue: requiredLevel,
                        decoration: const InputDecoration(
                          labelText: 'Required Level',
                          prefixIcon:
                              Icon(Icons.flag_outlined),
                        ),
                        items: _requiredLevels
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
                              requiredLevel = value;
                            });
                          }
                        },
                      ),

                      const SizedBox(height: 10),

                      DropdownButtonFormField<String>(
                        initialValue: achievedLevel,
                        decoration: const InputDecoration(
                          labelText: 'Achieved Level',
                          prefixIcon: Icon(
                            Icons.workspace_premium_outlined,
                          ),
                        ),
                        items: _achievedLevels
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
                              achievedLevel = value;
                            });
                          }
                        },
                      ),

                      const SizedBox(height: 10),

                      InkWell(
                        onTap: selectAssessmentDate,
                        child: InputDecorator(
                          decoration:
                              const InputDecoration(
                            labelText: 'Assessment Date',
                            prefixIcon: Icon(
                              Icons.calendar_today_outlined,
                            ),
                          ),
                          child: Text(
                            _formatDate(assessmentDate),
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      InkWell(
                        onTap: selectValidUntil,
                        child: InputDecorator(
                          decoration:
                              const InputDecoration(
                            labelText: 'Valid Until',
                            prefixIcon:
                                Icon(Icons.event_outlined),
                          ),
                          child: Text(
                            validUntil == null
                                ? 'Not specified'
                                : _formatDate(validUntil!),
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      TextField(
                        controller: assessorController,
                        decoration: const InputDecoration(
                          labelText: 'Assessor',
                          prefixIcon:
                              Icon(Icons.person_search_outlined),
                        ),
                      ),

                      const SizedBox(height: 10),

                      TextField(
                        controller: authorizationNoController,
                        decoration: const InputDecoration(
                          labelText: 'Authorization No.',
                          prefixIcon:
                              Icon(Icons.verified_outlined),
                        ),
                      ),

                      const SizedBox(height: 10),

                      DropdownButtonFormField<String>(
                        initialValue: status,
                        decoration: const InputDecoration(
                          labelText: 'Authorization Status',
                          prefixIcon:
                              Icon(Icons.security_outlined),
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
                        controller: gapActionController,
                        maxLines: 3,
                        decoration: const InputDecoration(
                          labelText:
                              'Competency Gap / Action Required',
                          alignLabelWithHint: true,
                          prefixIcon:
                              Icon(Icons.rule_outlined),
                        ),
                      ),

                      const SizedBox(height: 10),

                      TextField(
                        controller: remarksController,
                        maxLines: 3,
                        decoration: const InputDecoration(
                          labelText: 'Remarks',
                          alignLabelWithHint: true,
                          prefixIcon:
                              Icon(Icons.notes_outlined),
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
                  label: Text(
                    isEditing ? 'Update' : 'Save',
                  ),
                  onPressed: () async {
                    final employeeName =
                        employeeNameController.text.trim();

                    final competency =
                        competencyController.text.trim();

                    if (employeeName.isEmpty ||
                        competency.isEmpty) {
                      setDialogState(() {
                        validationMessage =
                            'Employee / Worker Name and Competency / Skill are required.';
                      });
                      return;
                    }

                    if (validUntil != null &&
                        validUntil!.isBefore(
                          assessmentDate,
                        )) {
                      setDialogState(() {
                        validationMessage =
                            'Valid Until date cannot be before the Assessment Date.';
                      });
                      return;
                    }

                    final now = DateTime.now();

                    final record = <String, dynamic>{
                      'id':
                          existingRecord?['id']?.toString() ??
                              now.microsecondsSinceEpoch
                                  .toString(),
                      'employeeName': employeeName,
                      'employeeId':
                          employeeIdController.text.trim(),
                      'jobRole':
                          jobRoleController.text.trim(),
                      'department':
                          departmentController.text.trim(),
                      'competency': competency,
                      'requiredLevel': requiredLevel,
                      'achievedLevel': achievedLevel,
                      'assessmentDate':
                          assessmentDate.toIso8601String(),
                      'validUntil':
                          validUntil?.toIso8601String() ?? '',
                      'assessor':
                          assessorController.text.trim(),
                      'authorizationNo':
                          authorizationNoController.text.trim(),
                      'status': status,
                      'gapAction':
                          gapActionController.text.trim(),
                      'remarks':
                          remarksController.text.trim(),
                      'createdAt':
                          existingRecord?['createdAt']
                                  ?.toString() ??
                              now.toIso8601String(),
                      'updatedAt':
                          now.toIso8601String(),
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

                    if (!mounted) {
                      return;
                    }

                    setState(() {});

                    Navigator.pop(dialogContext);

                    ScaffoldMessenger.of(context)
                        .showSnackBar(
                      SnackBar(
                        content: Text(
                          isEditing
                              ? 'Competency record updated successfully.'
                              : 'Competency record saved successfully.',
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
    competencyController.dispose();
    assessorController.dispose();
    authorizationNoController.dispose();
    gapActionController.dispose();
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
            'Delete the competency record for $employeeName?',
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

    if (confirmed != true) {
      return;
    }

    _records.removeWhere(
      (item) =>
          item['id']?.toString() ==
          record['id']?.toString(),
    );

    await _saveRecords();

    if (!mounted) {
      return;
    }

    setState(() {});

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Competency record deleted.',
        ),
      ),
    );
  }

  Future<void> _showHistory(
    Map<String, dynamic> record,
  ) async {
    final createdAt =
        record['createdAt']?.toString() ?? '';

    final updatedAt =
        record['updatedAt']?.toString() ?? '';

    await showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Record History'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment:
                CrossAxisAlignment.start,
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
                'The current competency record is stored locally in SafeNexus HSE.',
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
      crossAxisAlignment:
          CrossAxisAlignment.start,
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
      case 'Authorized':
        return primaryGreen;
      case 'Conditionally Authorized':
        return Colors.orange;
      case 'Assessment Required':
        return Colors.blue;
      case 'Training Required':
        return Colors.deepPurple;
      case 'Expired':
      case 'Not Authorized':
      case 'Suspended':
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
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.circular(12),
          border: Border.all(
            color: Colors.grey.withValues(
              alpha: 0.18,
            ),
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

  Widget _detailRow(
    IconData icon,
    String label,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 17,
            color: primaryGreen,
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 88,
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

    final competency =
        record['competency']?.toString() ?? '';

    final requiredLevel =
        record['requiredLevel']?.toString() ?? '';

    final achievedLevel =
        record['achievedLevel']?.toString() ?? '';

    final assessor =
        record['assessor']?.toString() ?? '';

    final authorizationNo =
        record['authorizationNo']?.toString() ?? '';

    final status =
        record['status']?.toString() ?? '';

    final validUntil =
        DateTime.tryParse(
      record['validUntil']?.toString() ?? '',
    );

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(14),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
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
                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 9,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: _statusColor(status)
                        .withValues(alpha: 0.10),
                    borderRadius:
                        BorderRadius.circular(20),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      color:
                          _statusColor(status),
                      fontWeight:
                          FontWeight.w600,
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
              Icons.engineering_outlined,
              'Competency',
              competency,
            ),
            _detailRow(
              Icons.flag_outlined,
              'Required',
              requiredLevel,
            ),
            _detailRow(
              Icons.workspace_premium_outlined,
              'Achieved',
              achievedLevel,
            ),
            if (assessor.isNotEmpty)
              _detailRow(
                Icons.person_search_outlined,
                'Assessor',
                assessor,
              ),
            if (authorizationNo.isNotEmpty)
              _detailRow(
                Icons.verified_outlined,
                'Authorization',
                authorizationNo,
              ),
            if (validUntil != null)
              _detailRow(
                Icons.event_outlined,
                'Valid Until',
                _formatDate(validUntil),
              ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.end,
              children: [
                IconButton(
                  tooltip: 'History',
                  onPressed: () =>
                      _showHistory(record),
                  icon: const Icon(
                    Icons.history,
                  ),
                ),
                IconButton(
                  tooltip: 'Edit',
                  onPressed: () =>
                      _showRecordForm(
                    existingRecord: record,
                  ),
                  icon: const Icon(
                    Icons.edit_outlined,
                  ),
                ),
                IconButton(
                  tooltip: 'Delete',
                  onPressed: () =>
                      _deleteRecord(record),
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
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            Icon(
              Icons.engineering_outlined,
              size: 64,
              color: primaryGreen.withValues(
                alpha: 0.45,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'No competency records',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: darkGreen,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Add your first competency or authorization record.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        title: const Text(
          'HSE Competency Matrix',
        ),
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
      ),
      floatingActionButton:
          FloatingActionButton.extended(
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
                    padding:
                        const EdgeInsets.fromLTRB(
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
                          'Authorized',
                          _authorizedCount,
                          Icons.verified_user_outlined,
                        ),
                        _summaryCard(
                          'Conditional',
                          _conditionalCount,
                          Icons.warning_amber_outlined,
                        ),
                        _summaryCard(
                          'Assessment',
                          _assessmentRequiredCount,
                          Icons.fact_check_outlined,
                        ),
                        _summaryCard(
                          'Training',
                          _trainingRequiredCount,
                          Icons.school_outlined,
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding:
                        const EdgeInsets.fromLTRB(
                      12,
                      8,
                      12,
                      4,
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText:
                            'Search employee, competency, role, authorization...',
                        prefixIcon:
                            const Icon(Icons.search),
                        filled: true,
                        fillColor: Colors.white,
                        border:
                            OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(
                            12,
                          ),
                          borderSide:
                              BorderSide.none,
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
                    padding:
                        const EdgeInsets.fromLTRB(
                      12,
                      4,
                      12,
                      8,
                    ),
                    child:
                        DropdownButtonFormField<
                            String>(
                      initialValue: _statusFilter,
                      decoration:
                          InputDecoration(
                        labelText: 'Status Filter',
                        prefixIcon:
                            const Icon(
                          Icons.filter_list,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        border:
                            OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(
                            12,
                          ),
                          borderSide:
                              BorderSide.none,
                        ),
                      ),
                      items: [
                        'All',
                        ..._statuses,
                      ]
                          .map(
                            (item) =>
                                DropdownMenuItem(
                              value: item,
                              child: Text(item),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _statusFilter =
                                value;
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
                                const EdgeInsets
                                    .fromLTRB(
                              12,
                              4,
                              12,
                              90,
                            ),
                            itemCount:
                                _filteredRecords
                                    .length,
                            itemBuilder:
                                (context, index) {
                              return _buildRecordCard(
                                _filteredRecords[
                                    index],
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
