import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HseRolesResponsibilitiesPage extends StatefulWidget {
  const HseRolesResponsibilitiesPage({super.key});

  @override
  State<HseRolesResponsibilitiesPage> createState() =>
      _HseRolesResponsibilitiesPageState();
}

class _HseRolesResponsibilitiesPageState
    extends State<HseRolesResponsibilitiesPage> {
  static const String _storageKey =
      'safenexus_hse_roles_responsibilities_records';

  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);

  List<Map<String, dynamic>> _records = [];
  String _searchQuery = '';
  String _statusFilter = 'All';
  bool _isLoading = true;

  final List<String> _roles = const [
    'HSE Manager',
    'HSE Engineer',
    'HSE Officer',
    'HSE Supervisor',
    'Safety Officer',
    'Safety Supervisor',
    'Environmental Officer',
    'Occupational Health Officer',
    'First Aider',
    'Fire Warden',
    'Emergency Coordinator',
    'Permit Receiver',
    'Permit Issuer',
    'Lifting Supervisor',
    'Banksman / Slinger',
    'Scaffolding Inspector',
    'Competent Person',
    'Other',
  ];

  final List<String> _statuses = const [
    'Active',
    'Pending Approval',
    'Under Review',
    'Expired',
    'Suspended',
    'Revoked',
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
              .map((item) => Map<String, dynamic>.from(item))
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
    await prefs.setString(_storageKey, jsonEncode(_records));
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
        record['personName'],
        record['employeeId'],
        record['jobTitle'],
        record['hseRole'],
        record['department'],
        record['responsibilities'],
        record['authority'],
        record['appointedBy'],
        record['approvedBy'],
        record['remarks'],
      ].map(
        (value) => value?.toString().toLowerCase() ?? '',
      );

      return searchable.any((value) => value.contains(query));
    }).toList();
  }

  int get _totalCount => _records.length;

  int get _activeCount => _records
      .where((record) => record['status'] == 'Active')
      .length;

  int get _pendingCount => _records
      .where((record) => record['status'] == 'Pending Approval')
      .length;

  int get _reviewCount => _records
      .where((record) => record['status'] == 'Under Review')
      .length;

  int get _expiredCount => _records
      .where((record) => record['status'] == 'Expired')
      .length;

  Future<void> _showRecordForm({
    Map<String, dynamic>? existingRecord,
  }) async {
    final bool isEditing = existingRecord != null;

    final personNameController = TextEditingController(
      text: existingRecord?['personName']?.toString() ?? '',
    );
    final employeeIdController = TextEditingController(
      text: existingRecord?['employeeId']?.toString() ?? '',
    );
    final jobTitleController = TextEditingController(
      text: existingRecord?['jobTitle']?.toString() ?? '',
    );
    final departmentController = TextEditingController(
      text: existingRecord?['department']?.toString() ?? '',
    );
    final responsibilitiesController = TextEditingController(
      text: existingRecord?['responsibilities']?.toString() ?? '',
    );
    final authorityController = TextEditingController(
      text: existingRecord?['authority']?.toString() ?? '',
    );
    final appointedByController = TextEditingController(
      text: existingRecord?['appointedBy']?.toString() ?? '',
    );
    final approvedByController = TextEditingController(
      text: existingRecord?['approvedBy']?.toString() ?? '',
    );
    final remarksController = TextEditingController(
      text: existingRecord?['remarks']?.toString() ?? '',
    );

    String hseRole =
        existingRecord?['hseRole']?.toString() ?? _roles.first;

    if (!_roles.contains(hseRole)) {
      hseRole = _roles.first;
    }

    String status =
        existingRecord?['status']?.toString() ?? 'Pending Approval';

    if (!_statuses.contains(status)) {
      status = 'Pending Approval';
    }

    DateTime appointmentDate = DateTime.tryParse(
          existingRecord?['appointmentDate']?.toString() ?? '',
        ) ??
        DateTime.now();

    DateTime effectiveFrom = DateTime.tryParse(
          existingRecord?['effectiveFrom']?.toString() ?? '',
        ) ??
        DateTime.now();

    DateTime? expiryDate = DateTime.tryParse(
      existingRecord?['expiryDate']?.toString() ?? '',
    );

    String? validationMessage;

    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            Future<void> selectAppointmentDate() async {
              final selected = await showDatePicker(
                context: context,
                initialDate: appointmentDate,
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );

              if (selected != null) {
                setDialogState(() {
                  appointmentDate = selected;
                });
              }
            }

            Future<void> selectEffectiveDate() async {
              final selected = await showDatePicker(
                context: context,
                initialDate: effectiveFrom,
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );

              if (selected != null) {
                setDialogState(() {
                  effectiveFrom = selected;
                });
              }
            }

            Future<void> selectExpiryDate() async {
              final selected = await showDatePicker(
                context: context,
                initialDate: expiryDate ?? effectiveFrom,
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
                    ? 'Edit HSE Appointment'
                    : 'Add HSE Appointment',
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
                            color: Colors.red.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            validationMessage!,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                      TextField(
                        controller: personNameController,
                        decoration: const InputDecoration(
                          labelText: 'Employee / Person Name *',
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
                        controller: jobTitleController,
                        decoration: const InputDecoration(
                          labelText: 'Job Title / Designation',
                          prefixIcon: Icon(Icons.work_outline),
                        ),
                      ),
                      const SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        initialValue: hseRole,
                        decoration: const InputDecoration(
                          labelText: 'HSE Role / Appointment *',
                          prefixIcon: Icon(Icons.security_outlined),
                        ),
                        items: _roles
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
                              hseRole = value;
                            });
                          }
                        },
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
                      TextField(
                        controller: responsibilitiesController,
                        maxLines: 4,
                        decoration: const InputDecoration(
                          labelText: 'Responsibilities *',
                          alignLabelWithHint: true,
                          prefixIcon: Icon(Icons.assignment_outlined),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: authorityController,
                        maxLines: 3,
                        decoration: const InputDecoration(
                          labelText: 'Authority / Authorization',
                          alignLabelWithHint: true,
                          prefixIcon:
                              Icon(Icons.admin_panel_settings_outlined),
                        ),
                      ),
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: selectAppointmentDate,
                        child: InputDecorator(
                          decoration: const InputDecoration(
                            labelText: 'Appointment Date',
                            prefixIcon:
                                Icon(Icons.calendar_today_outlined),
                          ),
                          child: Text(_formatDate(appointmentDate)),
                        ),
                      ),
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: selectEffectiveDate,
                        child: InputDecorator(
                          decoration: const InputDecoration(
                            labelText: 'Effective From',
                            prefixIcon:
                                Icon(Icons.event_available_outlined),
                          ),
                          child: Text(_formatDate(effectiveFrom)),
                        ),
                      ),
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: selectExpiryDate,
                        child: InputDecorator(
                          decoration: const InputDecoration(
                            labelText: 'Expiry / Review Date',
                            prefixIcon: Icon(Icons.event_outlined),
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
                        controller: appointedByController,
                        decoration: const InputDecoration(
                          labelText: 'Appointed By',
                          prefixIcon:
                              Icon(Icons.person_add_alt_outlined),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: approvedByController,
                        decoration: const InputDecoration(
                          labelText: 'Approved By',
                          prefixIcon:
                              Icon(Icons.verified_user_outlined),
                        ),
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
                    final personName = personNameController.text.trim();
                    final responsibilities =
                        responsibilitiesController.text.trim();

                    if (personName.isEmpty ||
                        responsibilities.isEmpty) {
                      setDialogState(() {
                        validationMessage =
                            'Person Name and Responsibilities are required.';
                      });
                      return;
                    }

                    if (expiryDate != null &&
                        expiryDate!.isBefore(effectiveFrom)) {
                      setDialogState(() {
                        validationMessage =
                            'Expiry / Review Date cannot be before Effective From.';
                      });
                      return;
                    }

                    final now = DateTime.now();
                    final existingId =
                        existingRecord?['id']?.toString();

                    final record = <String, dynamic>{
                      'id': existingId ??
                          now.microsecondsSinceEpoch.toString(),
                      'personName': personName,
                      'employeeId': employeeIdController.text.trim(),
                      'jobTitle': jobTitleController.text.trim(),
                      'hseRole': hseRole,
                      'department': departmentController.text.trim(),
                      'responsibilities': responsibilities,
                      'authority': authorityController.text.trim(),
                      'appointmentDate':
                          appointmentDate.toIso8601String(),
                      'effectiveFrom':
                          effectiveFrom.toIso8601String(),
                      'expiryDate':
                          expiryDate?.toIso8601String() ?? '',
                      'appointedBy': appointedByController.text.trim(),
                      'approvedBy': approvedByController.text.trim(),
                      'status': status,
                      'remarks': remarksController.text.trim(),
                      'createdAt':
                          existingRecord?['createdAt']?.toString() ??
                              now.toIso8601String(),
                      'updatedAt': now.toIso8601String(),
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
                              ? 'HSE appointment updated successfully.'
                              : 'HSE appointment saved successfully.',
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

    personNameController.dispose();
    employeeIdController.dispose();
    jobTitleController.dispose();
    departmentController.dispose();
    responsibilitiesController.dispose();
    authorityController.dispose();
    appointedByController.dispose();
    approvedByController.dispose();
    remarksController.dispose();
  }

  Future<void> _deleteRecord(Map<String, dynamic> record) async {
    final personName =
        record['personName']?.toString() ?? 'this record';

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Appointment?'),
          content: Text(
            'Delete the HSE appointment for $personName?',
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
        content: Text('HSE appointment deleted.'),
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
              _historyRow('Created', _formatDateTime(createdAt)),
              const SizedBox(height: 8),
              _historyRow(
                'Last Updated',
                _formatDateTime(updatedAt),
              ),
              const SizedBox(height: 12),
              const Text(
                'The current appointment record is stored locally in SafeNexus HSE.',
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
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        Expanded(child: Text(value)),
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
      case 'Active':
        return primaryGreen;
      case 'Pending Approval':
        return Colors.orange;
      case 'Under Review':
        return Colors.blue;
      case 'Expired':
      case 'Suspended':
      case 'Revoked':
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
              style: const TextStyle(fontSize: 11),
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
            width: 92,
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
    final personName = record['personName']?.toString() ?? '';
    final employeeId = record['employeeId']?.toString() ?? '';
    final jobTitle = record['jobTitle']?.toString() ?? '';
    final hseRole = record['hseRole']?.toString() ?? '';
    final department = record['department']?.toString() ?? '';
    final authority = record['authority']?.toString() ?? '';
    final approvedBy = record['approvedBy']?.toString() ?? '';
    final status = record['status']?.toString() ?? '';

    final expiryDate = DateTime.tryParse(
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
                    personName,
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
            if (jobTitle.isNotEmpty)
              _detailRow(
                Icons.work_outline,
                'Job Title',
                jobTitle,
              ),
            _detailRow(
              Icons.security_outlined,
              'HSE Role',
              hseRole,
            ),
            if (department.isNotEmpty)
              _detailRow(
                Icons.groups_outlined,
                'Department',
                department,
              ),
            if (authority.isNotEmpty)
              _detailRow(
                Icons.admin_panel_settings_outlined,
                'Authority',
                authority,
              ),
            if (approvedBy.isNotEmpty)
              _detailRow(
                Icons.verified_user_outlined,
                'Approved By',
                approvedBy,
              ),
            if (expiryDate != null)
              _detailRow(
                Icons.event_outlined,
                'Review / Expiry',
                _formatDate(expiryDate),
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
              Icons.security_outlined,
              size: 64,
              color: primaryGreen.withValues(alpha: 0.45),
            ),
            const SizedBox(height: 12),
            const Text(
              'No HSE appointment records',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: darkGreen,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Add your first HSE role or appointment record.',
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
        title: const Text('HSE Roles & Responsibilities'),
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        onPressed: () => _showRecordForm(),
        icon: const Icon(Icons.add),
        label: const Text('Add Appointment'),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 12, 4, 4),
                    child: Row(
                      children: [
                        _summaryCard(
                          'Total',
                          _totalCount,
                          Icons.list_alt_outlined,
                        ),
                        _summaryCard(
                          'Active',
                          _activeCount,
                          Icons.check_circle_outline,
                        ),
                        _summaryCard(
                          'Pending',
                          _pendingCount,
                          Icons.pending_actions_outlined,
                        ),
                        _summaryCard(
                          'Review',
                          _reviewCount,
                          Icons.fact_check_outlined,
                        ),
                        _summaryCard(
                          'Expired',
                          _expiredCount,
                          Icons.warning_amber_outlined,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText:
                            'Search person, role, department, authority...',
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
                    padding: const EdgeInsets.fromLTRB(12, 4, 12, 8),
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
