import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// SafeNexus HSE - Step 41
/// HSE Inspection, Certification & Compliance Center
///
/// Workflow:
/// Plan → Schedule → Inspect → Record Findings → Certify → Correct
/// → Reinspect → Approve → Track Expiry → Close → Analyze
///
/// Integration:
/// Step 9 Daily HSE
/// Step 31 Smart Checklists
/// Step 32 Field Operations
/// Step 34 Documents & Records
/// Step 35 Action Center
/// Step 36 Risk & Control
/// Step 37 RAMS
/// Step 38 PTW
/// Step 39 Workforce & Competency
/// Step 40 Equipment & Assets
///
/// No new dependency beyond SharedPreferences.

class SafeNexusStep41InspectionCertificationPage extends StatefulWidget {
  const SafeNexusStep41InspectionCertificationPage({
    super.key,
    this.sourceOpener,
  });

  final void Function(String referenceType, String referenceId)? sourceOpener;

  @override
  State<SafeNexusStep41InspectionCertificationPage> createState() =>
      _SafeNexusStep41InspectionCertificationPageState();
}

class _SafeNexusStep41InspectionCertificationPageState
    extends State<SafeNexusStep41InspectionCertificationPage> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);

  static const String storageKey =
      'safenexus_hse_step41_inspection_certification';

  final TextEditingController _searchController = TextEditingController();

  final List<String> _inspectionTypes = const [
    'Daily HSE Inspection',
    'Weekly HSE Inspection',
    'Monthly HSE Inspection',
    'Equipment Inspection',
    'Lifting Equipment Inspection',
    'Vehicle / Plant Inspection',
    'Scaffold / Access Inspection',
    'Fire & Emergency Inspection',
    'Electrical Safety Inspection',
    'Confined Space Inspection',
    'Environmental Inspection',
    'Housekeeping Inspection',
    'PPE Inspection',
    'Third-Party Inspection',
    'Regulatory / Compliance Inspection',
    'Other',
  ];

  final List<String> _statuses = const [
    'Planned',
    'Scheduled',
    'In Progress',
    'Completed',
    'Failed',
    'Corrective Action Required',
    'Reinspection Required',
    'Approved',
    'Closed',
  ];

  final List<String> _resultOptions = const [
    'Compliant',
    'Partially Compliant',
    'Non-Compliant',
    'Not Applicable',
  ];

  final List<String> _severityOptions = const [
    'Low',
    'Medium',
    'High',
    'Critical',
  ];

  final List<String> _certificateOptions = const [
    'Not Required',
    'Pending',
    'Valid',
    'Expiring Soon',
    'Expired',
    'Suspended',
  ];

  final List<String> _verificationOptions = const [
    'Pending',
    'Verified',
    'Failed',
  ];

  List<Map<String, dynamic>> _records = [];
  List<Map<String, dynamic>> _history = [];

  String _statusFilter = 'All';
  String _typeFilter = 'All';
  String _resultFilter = 'All';
  String _certificateFilter = 'All';

  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_refreshView);
    _loadData();
  }

  @override
  void dispose() {
    _searchController
      ..removeListener(_refreshView)
      ..dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final rawRecords = prefs.getString(storageKey);
    final rawHistory = prefs.getString('${storageKey}_history');

    if (!mounted) return;

    setState(() {
      _records = _decodeList(rawRecords);
      _history = _decodeList(rawHistory);
      _loading = false;
    });
  }

  List<Map<String, dynamic>> _decodeList(String? raw) {
    if (raw == null || raw.isEmpty) return [];

    try {
      final decoded = jsonDecode(raw);
      if (decoded is List) {
        return decoded
            .whereType<Map>()
            .map((item) => Map<String, dynamic>.from(item))
            .toList();
      }
    } catch (_) {
      // Keep local storage resilient against invalid legacy data.
    }

    return [];
  }

  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(storageKey, jsonEncode(_records));
    await prefs.setString('${storageKey}_history', jsonEncode(_history));
  }

  void _refreshView() {
    if (mounted) setState(() {});
  }

  String _value(Map<String, dynamic> item, String key) {
    final value = item[key];
    if (value == null) return '';
    return '$value';
  }

  DateTime? _parseDate(dynamic value) {
    if (value == null) return null;
    return DateTime.tryParse('$value');
  }

  String _now() => DateTime.now().toIso8601String();

  String _newId() => 'INSP41-${DateTime.now().millisecondsSinceEpoch}';

  String _expiryState(Map<String, dynamic> record) {
    final status = _value(record, 'certificateStatus');

    if (status == 'Not Required') return status;
    if (status == 'Expired') return 'Expired';
    if (status == 'Suspended') return 'Suspended';

    final expiry = _parseDate(record['certificateExpiry']);
    if (expiry == null) {
      return status.isEmpty ? 'Pending' : status;
    }

    final now = DateTime.now();
    final expiryOnly = DateTime(expiry.year, expiry.month, expiry.day);
    final todayOnly = DateTime(now.year, now.month, now.day);
    final days = expiryOnly.difference(todayOnly).inDays;

    if (days < 0) return 'Expired';
    if (days <= 30) return 'Expiring Soon';
    return 'Valid';
  }

  String _inspectionDueState(Map<String, dynamic> record) {
    final due = _parseDate(record['nextInspection']);
    if (due == null) return 'Not Scheduled';

    final now = DateTime.now();
    final dueOnly = DateTime(due.year, due.month, due.day);
    final todayOnly = DateTime(now.year, now.month, now.day);
    final days = dueOnly.difference(todayOnly).inDays;

    if (days < 0) return 'Overdue';
    if (days <= 30) return 'Due Soon';
    return 'Scheduled';
  }

  List<Map<String, dynamic>> get _filteredRecords {
    final query = _searchController.text.trim().toLowerCase();

    return _records.where((record) {
      final searchable = [
        _value(record, 'inspectionId'),
        _value(record, 'title'),
        _value(record, 'inspectionType'),
        _value(record, 'site'),
        _value(record, 'inspector'),
        _value(record, 'assetId'),
        _value(record, 'certificateNo'),
      ].join(' ').toLowerCase();

      final matchesQuery =
          query.isEmpty || searchable.contains(query);

      final matchesStatus = _statusFilter == 'All' ||
          _value(record, 'status') == _statusFilter;

      final matchesType = _typeFilter == 'All' ||
          _value(record, 'inspectionType') == _typeFilter;

      final matchesResult = _resultFilter == 'All' ||
          _value(record, 'result') == _resultFilter;

      final matchesCertificate = _certificateFilter == 'All' ||
          _expiryState(record) == _certificateFilter;

      return matchesQuery &&
          matchesStatus &&
          matchesType &&
          matchesResult &&
          matchesCertificate;
    }).toList();
  }

  int _countWhere(bool Function(Map<String, dynamic>) test) {
    return _records.where(test).length;
  }

  int get _totalCount => _records.length;

  int get _completedCount =>
      _countWhere((item) => _value(item, 'status') == 'Completed');

  int get _failedCount =>
      _countWhere((item) => _value(item, 'status') == 'Failed');

  int get _actionRequiredCount => _countWhere(
      (item) => _value(item, 'status') == 'Corrective Action Required');

  int get _reinspectionCount => _countWhere(
      (item) => _value(item, 'status') == 'Reinspection Required');

  int get _inspectionOverdueCount =>
      _countWhere((item) => _inspectionDueState(item) == 'Overdue');

  int get _inspectionDueCount =>
      _countWhere((item) => _inspectionDueState(item) == 'Due Soon');

  int get _validCertificateCount =>
      _countWhere((item) => _expiryState(item) == 'Valid');

  int get _certificateExpiringCount =>
      _countWhere((item) => _expiryState(item) == 'Expiring Soon');

  int get _certificateExpiredCount =>
      _countWhere((item) => _expiryState(item) == 'Expired');

  int get _verificationPendingCount => _countWhere(
      (item) => _value(item, 'verificationStatus') == 'Pending');

  Future<void> _addRecord() async {
    final result = await _showRecordDialog();

    if (result == null) return;

    final record = <String, dynamic>{
      ...result,
      'inspectionId': _newId(),
      'createdAt': _now(),
      'updatedAt': _now(),
    };

    setState(() {
      _records.insert(0, record);
      _history.insert(0, {
        'action': 'Created',
        'inspectionId': record['inspectionId'],
        'title': record['title'],
        'timestamp': _now(),
        'details': 'Inspection / certification record created.',
      });
    });

    await _saveData();
  }

  Future<void> _editRecord(Map<String, dynamic> record) async {
    final result = await _showRecordDialog(existing: record);

    if (result == null) return;

    final index = _records.indexWhere(
      (item) =>
          _value(item, 'inspectionId') == _value(record, 'inspectionId'),
    );

    if (index < 0) return;

    final updated = <String, dynamic>{
      ...record,
      ...result,
      'updatedAt': _now(),
    };

    setState(() {
      _records[index] = updated;
      _history.insert(0, {
        'action': 'Updated',
        'inspectionId': updated['inspectionId'],
        'title': updated['title'],
        'timestamp': _now(),
        'details': 'Inspection / certification record updated.',
      });
    });

    await _saveData();
  }

  Future<void> _deleteRecord(Map<String, dynamic> record) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Inspection'),
        content: Text(
          'Delete ${_value(record, 'title')} '
          '(${_value(record, 'inspectionId')})?',
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

    setState(() {
      _records.removeWhere(
        (item) =>
            _value(item, 'inspectionId') ==
            _value(record, 'inspectionId'),
      );

      _history.insert(0, {
        'action': 'Deleted',
        'inspectionId': record['inspectionId'],
        'title': record['title'],
        'timestamp': _now(),
        'details': 'Inspection / certification record deleted.',
      });
    });

    await _saveData();
  }

  Future<Map<String, dynamic>?> _showRecordDialog({
    Map<String, dynamic>? existing,
  }) async {
    final titleController =
        TextEditingController(text: _value(existing ?? {}, 'title'));
    final siteController =
        TextEditingController(text: _value(existing ?? {}, 'site'));
    final inspectorController =
        TextEditingController(text: _value(existing ?? {}, 'inspector'));
    final assetIdController =
        TextEditingController(text: _value(existing ?? {}, 'assetId'));
    final plannedDateController = TextEditingController(
      text: _value(existing ?? {}, 'plannedDate'),
    );
    final nextInspectionController = TextEditingController(
      text: _value(existing ?? {}, 'nextInspection'),
    );
    final certificateNoController = TextEditingController(
      text: _value(existing ?? {}, 'certificateNo'),
    );
    final certificateExpiryController = TextEditingController(
      text: _value(existing ?? {}, 'certificateExpiry'),
    );
    final findingsController =
        TextEditingController(text: _value(existing ?? {}, 'findings'));
    final actionController =
        TextEditingController(text: _value(existing ?? {}, 'correctiveAction'));
    final verificationController = TextEditingController(
      text: _value(existing ?? {}, 'verificationRemarks'),
    );
    final notesController =
        TextEditingController(text: _value(existing ?? {}, 'notes'));

    String inspectionType =
        _value(existing ?? {}, 'inspectionType');
    String status = _value(existing ?? {}, 'status');
    String result = _value(existing ?? {}, 'result');
    String severity = _value(existing ?? {}, 'severity');
    String certificateStatus =
        _value(existing ?? {}, 'certificateStatus');
    String verificationStatus =
        _value(existing ?? {}, 'verificationStatus');

    if (!_inspectionTypes.contains(inspectionType)) {
      inspectionType = _inspectionTypes.first;
    }
    if (!_statuses.contains(status)) status = _statuses.first;
    if (!_resultOptions.contains(result)) result = 'Compliant';
    if (!_severityOptions.contains(severity)) severity = 'Low';
    if (!_certificateOptions.contains(certificateStatus)) {
      certificateStatus = 'Not Required';
    }
    if (!_verificationOptions.contains(verificationStatus)) {
      verificationStatus = 'Pending';
    }

    final response = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text(
                existing == null
                    ? 'Create Inspection / Certification'
                    : 'Edit Inspection / Certification',
              ),
              content: SizedBox(
                width: 650,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _dialogTextField(
                        titleController,
                        'Inspection Title',
                        Icons.fact_check_outlined,
                        required: true,
                      ),
                      const SizedBox(height: 10),
                      _dialogDropdown(
                        label: 'Inspection Type',
                        value: inspectionType,
                        items: _inspectionTypes,
                        onChanged: (value) =>
                            setDialogState(() => inspectionType = value!),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: _dialogTextField(
                              siteController,
                              'Site / Location',
                              Icons.location_on_outlined,
                              required: true,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _dialogTextField(
                              inspectorController,
                              'Inspector',
                              Icons.person_search_outlined,
                              required: true,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      _dialogTextField(
                        assetIdController,
                        'Linked Asset / Equipment ID',
                        Icons.precision_manufacturing_outlined,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: _dialogTextField(
                              plannedDateController,
                              'Planned Date (YYYY-MM-DD)',
                              Icons.event_outlined,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _dialogTextField(
                              nextInspectionController,
                              'Next Inspection (YYYY-MM-DD)',
                              Icons.event_available_outlined,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      _dialogDropdown(
                        label: 'Status',
                        value: status,
                        items: _statuses,
                        onChanged: (value) =>
                            setDialogState(() => status = value!),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: _dialogDropdown(
                              label: 'Inspection Result',
                              value: result,
                              items: _resultOptions,
                              onChanged: (value) =>
                                  setDialogState(() => result = value!),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _dialogDropdown(
                              label: 'Highest Finding Severity',
                              value: severity,
                              items: _severityOptions,
                              onChanged: (value) =>
                                  setDialogState(() => severity = value!),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      _dialogTextField(
                        findingsController,
                        'Findings / Observations',
                        Icons.search_outlined,
                        maxLines: 3,
                      ),
                      const SizedBox(height: 10),
                      _dialogTextField(
                        actionController,
                        'Corrective / Preventive Action',
                        Icons.build_circle_outlined,
                        maxLines: 3,
                      ),
                      const SizedBox(height: 10),
                      _dialogDropdown(
                        label: 'Certificate Status',
                        value: certificateStatus,
                        items: _certificateOptions,
                        onChanged: (value) =>
                            setDialogState(() => certificateStatus = value!),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: _dialogTextField(
                              certificateNoController,
                              'Certificate No.',
                              Icons.verified_outlined,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _dialogTextField(
                              certificateExpiryController,
                              'Certificate Expiry (YYYY-MM-DD)',
                              Icons.event_busy_outlined,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      _dialogDropdown(
                        label: 'Verification Status',
                        value: verificationStatus,
                        items: _verificationOptions,
                        onChanged: (value) => setDialogState(
                          () => verificationStatus = value!,
                        ),
                      ),
                      const SizedBox(height: 10),
                      _dialogTextField(
                        verificationController,
                        'Verification Remarks',
                        Icons.verified_user_outlined,
                        maxLines: 2,
                      ),
                      const SizedBox(height: 10),
                      _dialogTextField(
                        notesController,
                        'Notes / HSE Remarks',
                        Icons.notes_outlined,
                        maxLines: 3,
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
                FilledButton.icon(
                  onPressed: () {
                    if (titleController.text.trim().isEmpty ||
                        siteController.text.trim().isEmpty ||
                        inspectorController.text.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Inspection Title, Site and Inspector are required.',
                          ),
                        ),
                      );
                      return;
                    }

                    Navigator.pop(dialogContext, {
                      'title': titleController.text.trim(),
                      'inspectionType': inspectionType,
                      'site': siteController.text.trim(),
                      'inspector': inspectorController.text.trim(),
                      'assetId': assetIdController.text.trim(),
                      'plannedDate': plannedDateController.text.trim(),
                      'nextInspection': nextInspectionController.text.trim(),
                      'status': status,
                      'result': result,
                      'severity': severity,
                      'findings': findingsController.text.trim(),
                      'correctiveAction': actionController.text.trim(),
                      'certificateStatus': certificateStatus,
                      'certificateNo': certificateNoController.text.trim(),
                      'certificateExpiry':
                          certificateExpiryController.text.trim(),
                      'verificationStatus': verificationStatus,
                      'verificationRemarks':
                          verificationController.text.trim(),
                      'notes': notesController.text.trim(),
                    });
                  },
                  icon: const Icon(Icons.save_outlined),
                  label: Text(existing == null ? 'Create' : 'Save'),
                ),
              ],
            );
          },
        );
      },
    );

    titleController.dispose();
    siteController.dispose();
    inspectorController.dispose();
    assetIdController.dispose();
    plannedDateController.dispose();
    nextInspectionController.dispose();
    certificateNoController.dispose();
    certificateExpiryController.dispose();
    findingsController.dispose();
    actionController.dispose();
    verificationController.dispose();
    notesController.dispose();

    return response;
  }

  Widget _dialogTextField(
    TextEditingController controller,
    String label,
    IconData icon, {
    bool required = false,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: required ? '$label *' : label,
        prefixIcon: Icon(icon),
        border: const OutlineInputBorder(),
      ),
    );
  }

  Widget _dialogDropdown({
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      isExpanded: true,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      items: items
          .map(
            (item) => DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          )
          .toList(),
      onChanged: onChanged,
    );
  }

  Future<void> _showDetails(Map<String, dynamic> record) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) {
        final expiry = _expiryState(record);
        final inspectionDue = _inspectionDueState(record);

        return SafeArea(
          child: DraggableScrollableSheet(
            expand: false,
            initialChildSize: 0.84,
            minChildSize: 0.55,
            maxChildSize: 0.96,
            builder: (context, controller) {
              return ListView(
                controller: controller,
                padding: const EdgeInsets.fromLTRB(18, 4, 18, 24),
                children: [
                  Text(
                    _value(record, 'title'),
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: darkGreen,
                        ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    _value(record, 'inspectionId'),
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 14),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _statusChip(_value(record, 'status')),
                      _statusChip(_value(record, 'result')),
                      _statusChip(inspectionDue),
                      _statusChip(expiry),
                      _statusChip(_value(record, 'verificationStatus')),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _detailSection(
                    '41A–41L Inspection & Certification Control',
                    [
                      _detailRow(
                        'Inspection Type',
                        _value(record, 'inspectionType'),
                      ),
                      _detailRow('Site / Location', _value(record, 'site')),
                      _detailRow('Inspector', _value(record, 'inspector')),
                      _detailRow(
                        'Linked Asset',
                        _value(record, 'assetId'),
                      ),
                      _detailRow(
                        'Planned Date',
                        _formatDate(record['plannedDate']),
                      ),
                      _detailRow(
                        'Next Inspection',
                        _formatDate(record['nextInspection']),
                      ),
                      _detailRow(
                        'Inspection Result',
                        _value(record, 'result'),
                      ),
                      _detailRow(
                        'Highest Severity',
                        _value(record, 'severity'),
                      ),
                      _detailRow(
                        'Certificate No.',
                        _value(record, 'certificateNo'),
                      ),
                      _detailRow(
                        'Certificate Expiry',
                        _formatDate(record['certificateExpiry']),
                      ),
                      _detailRow(
                        'Certificate Status',
                        expiry,
                      ),
                      _detailRow(
                        'Verification',
                        _value(record, 'verificationStatus'),
                      ),
                    ],
                  ),
                  if (_value(record, 'findings').isNotEmpty) ...[
                    const SizedBox(height: 12),
                    _detailSection(
                      'Findings / Observations',
                      [Text(_value(record, 'findings'))],
                    ),
                  ],
                  if (_value(record, 'correctiveAction').isNotEmpty) ...[
                    const SizedBox(height: 12),
                    _detailSection(
                      'Corrective / Preventive Action',
                      [Text(_value(record, 'correctiveAction'))],
                    ),
                  ],
                  if (_value(record, 'verificationRemarks').isNotEmpty) ...[
                    const SizedBox(height: 12),
                    _detailSection(
                      'Verification Remarks',
                      [Text(_value(record, 'verificationRemarks'))],
                    ),
                  ],
                  if (_value(record, 'notes').isNotEmpty) ...[
                    const SizedBox(height: 12),
                    _detailSection(
                      'HSE Notes',
                      [Text(_value(record, 'notes'))],
                    ),
                  ],
                  const SizedBox(height: 16),
                  if (widget.sourceOpener != null)
                    OutlinedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                        widget.sourceOpener!(
                          'inspection_certification',
                          _value(record, 'inspectionId'),
                        );
                      },
                      icon: const Icon(Icons.open_in_new_outlined),
                      label: const Text('Open Integration Reference'),
                    ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  Widget _detailSection(String title, List<Widget> children) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                color: darkGreen,
              ),
            ),
            const SizedBox(height: 8),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
          Expanded(child: Text(value.isEmpty ? '-' : value)),
        ],
      ),
    );
  }

  String _formatDate(dynamic value) {
    final date = _parseDate(value);
    if (date == null) {
      final text = '$value';
      return value == null || text == 'null' || text.isEmpty ? '-' : text;
    }

    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }

  String _formatDateTime(dynamic value) {
    final date = _parseDate(value);
    if (date == null) return '-';

    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year} '
        '${date.hour.toString().padLeft(2, '0')}:'
        '${date.minute.toString().padLeft(2, '0')}';
  }

  Widget _statusChip(String text) {
    return Chip(
      label: Text(text.isEmpty ? '-' : text),
      visualDensity: VisualDensity.compact,
    );
  }

  Future<void> _showHistory() async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.78,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(18, 4, 18, 12),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Inspection & Certification History',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w800,
                        color: darkGreen,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: _history.isEmpty
                      ? const Center(
                          child: Text('No history records yet.'),
                        )
                      : ListView.separated(
                          padding: const EdgeInsets.all(14),
                          itemCount: _history.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 8),
                          itemBuilder: (context, index) {
                            final item = _history[index];

                            return Card(
                              elevation: 0,
                              child: ListTile(
                                leading: const CircleAvatar(
                                  child: Icon(Icons.history),
                                ),
                                title: Text(
                                  '${_value(item, 'action')} — '
                                  '${_value(item, 'title')}',
                                ),
                                subtitle: Text(
                                  '${_value(item, 'details')}\n'
                                  '${_formatDateTime(item['timestamp'])}',
                                ),
                                isThreeLine: true,
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _showModuleGuide() async {
    final modules = <String, String>{
      '41A — Inspection Master':
          'Central register for planned and completed HSE inspections.',
      '41B — Inspection Planning & Scheduling':
          'Track planned dates, next inspections and inspection ownership.',
      '41C — Inspection Scope & Checklist Link':
          'Connect inspections with Smart Checklists and defined inspection scope.',
      '41D — Findings & Compliance Result':
          'Record compliant, partially compliant and non-compliant results.',
      '41E — Certificate & Statutory Validity':
          'Track certificates, certificate numbers and expiry status.',
      '41F — Corrective Action Link':
          'Capture corrective or preventive actions from inspection findings.',
      '41G — Reinspection & Verification':
          'Track reinspection requirements and effectiveness verification.',
      '41H — Approval & Closure':
          'Support approval, closure and final inspection disposition.',
      '41I — Expiry & Renewal Control':
          'Surface certificates and inspections that are due or expired.',
      '41J — Compliance History':
          'Maintain a local inspection and certification audit trail.',
      '41K — Integration References':
          'Connect records with Daily HSE, Assets, PTW, RAMS, Risk and Actions.',
      '41L — Inspection Intelligence Dashboard':
          'Management view of inspections, findings, expiry and verification status.',
    };

    await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Step 41 — Module Guide'),
        content: SizedBox(
          width: 650,
          child: ListView(
            shrinkWrap: true,
            children: modules.entries
                .map(
                  (entry) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(
                        Icons.check_circle_outline,
                        color: primaryGreen,
                      ),
                      title: Text(
                        entry.key,
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                      subtitle: Text(entry.value),
                    ),
                  ),
                )
                .toList(),
          ),
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

  void _resetFilters() {
    setState(() {
      _statusFilter = 'All';
      _typeFilter = 'All';
      _resultFilter = 'All';
      _certificateFilter = 'All';
      _searchController.clear();
    });
  }

  Widget _filterDropdown({
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return SizedBox(
      width: 195,
      child: DropdownButtonFormField<String>(
        initialValue: value,
        isExpanded: true,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          border: const OutlineInputBorder(),
          isDense: true,
        ),
        items: items
            .map(
              (item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            )
            .toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _dashboardCard(
    String title,
    String value,
    IconData icon,
  ) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: primaryGreen.withOpacity(0.10),
              child: Icon(icon, color: darkGreen),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w800,
                      color: darkGreen,
                    ),
                  ),
                  Text(
                    title,
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboard() {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '41L — Inspection & Certification Intelligence',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w800,
                color: darkGreen,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Plan → Schedule → Inspect → Certify → Correct → Reinspect → Close',
            ),
            const SizedBox(height: 12),
            LayoutBuilder(
              builder: (context, constraints) {
                final columns = constraints.maxWidth > 850
                    ? 4
                    : constraints.maxWidth > 560
                        ? 3
                        : 2;
                final width =
                    (constraints.maxWidth - ((columns - 1) * 10)) / columns;

                return Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    SizedBox(
                      width: width,
                      child: _dashboardCard(
                        'Total Inspections',
                        '$_totalCount',
                        Icons.fact_check_outlined,
                      ),
                    ),
                    SizedBox(
                      width: width,
                      child: _dashboardCard(
                        'Completed',
                        '$_completedCount',
                        Icons.check_circle_outline,
                      ),
                    ),
                    SizedBox(
                      width: width,
                      child: _dashboardCard(
                        'Failed',
                        '$_failedCount',
                        Icons.cancel_outlined,
                      ),
                    ),
                    SizedBox(
                      width: width,
                      child: _dashboardCard(
                        'Action Required',
                        '$_actionRequiredCount',
                        Icons.assignment_late_outlined,
                      ),
                    ),
                    SizedBox(
                      width: width,
                      child: _dashboardCard(
                        'Reinspection',
                        '$_reinspectionCount',
                        Icons.replay_circle_filled_outlined,
                      ),
                    ),
                    SizedBox(
                      width: width,
                      child: _dashboardCard(
                        'Inspection Due',
                        '$_inspectionDueCount',
                        Icons.event_available_outlined,
                      ),
                    ),
                    SizedBox(
                      width: width,
                      child: _dashboardCard(
                        'Inspection Overdue',
                        '$_inspectionOverdueCount',
                        Icons.warning_amber_outlined,
                      ),
                    ),
                    SizedBox(
                      width: width,
                      child: _dashboardCard(
                        'Valid Certificates',
                        '$_validCertificateCount',
                        Icons.verified_outlined,
                      ),
                    ),
                    SizedBox(
                      width: width,
                      child: _dashboardCard(
                        'Cert. Expiring',
                        '$_certificateExpiringCount',
                        Icons.event_outlined,
                      ),
                    ),
                    SizedBox(
                      width: width,
                      child: _dashboardCard(
                        'Cert. Expired',
                        '$_certificateExpiredCount',
                        Icons.event_busy_outlined,
                      ),
                    ),
                    SizedBox(
                      width: width,
                      child: _dashboardCard(
                        'Verification Pending',
                        '$_verificationPendingCount',
                        Icons.fact_check_outlined,
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecordCard(Map<String, dynamic> record) {
    final expiry = _expiryState(record);
    final inspectionDue = _inspectionDueState(record);

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _showDetails(record),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    child: Icon(Icons.fact_check_outlined),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _value(record, 'title'),
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                            color: darkGreen,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${_value(record, 'inspectionId')} • '
                          '${_value(record, 'inspectionType')}',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'view') {
                        _showDetails(record);
                      } else if (value == 'edit') {
                        _editRecord(record);
                      } else if (value == 'delete') {
                        _deleteRecord(record);
                      }
                    },
                    itemBuilder: (context) => const [
                      PopupMenuItem(
                        value: 'view',
                        child: Text('View Details'),
                      ),
                      PopupMenuItem(
                        value: 'edit',
                        child: Text('Edit'),
                      ),
                      PopupMenuItem(
                        value: 'delete',
                        child: Text('Delete'),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  _statusChip(_value(record, 'status')),
                  _statusChip(_value(record, 'result')),
                  _statusChip(inspectionDue),
                  _statusChip(expiry),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.location_on_outlined, size: 17),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Text(_value(record, 'site')),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.person_outline, size: 17),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      _value(record, 'inspector').isEmpty
                          ? 'Unassigned'
                          : _value(record, 'inspector'),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
              if (_value(record, 'findings').isNotEmpty) ...[
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.search_outlined, size: 17),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        _value(record, 'findings'),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
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
          'Step 41 • Inspection & Certification',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            tooltip: 'Module Guide',
            onPressed: _showModuleGuide,
            icon: const Icon(Icons.menu_book_outlined),
          ),
          IconButton(
            tooltip: 'History',
            onPressed: _showHistory,
            icon: const Icon(Icons.history_outlined),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _loading ? null : _addRecord,
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('New Inspection'),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadData,
              child: ListView(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 100),
                children: [
                  _buildDashboard(),
                  const SizedBox(height: 12),
                  Card(
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        children: [
                          TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              labelText: 'Search inspection / certificate',
                              hintText:
                                  'ID, title, site, inspector, asset, certificate',
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
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              _filterDropdown(
                                label: 'Status',
                                value: _statusFilter,
                                items: ['All', ..._statuses],
                                onChanged: (value) => setState(
                                  () => _statusFilter = value!,
                                ),
                              ),
                              _filterDropdown(
                                label: 'Inspection Type',
                                value: _typeFilter,
                                items: ['All', ..._inspectionTypes],
                                onChanged: (value) => setState(
                                  () => _typeFilter = value!,
                                ),
                              ),
                              _filterDropdown(
                                label: 'Result',
                                value: _resultFilter,
                                items: ['All', ..._resultOptions],
                                onChanged: (value) => setState(
                                  () => _resultFilter = value!,
                                ),
                              ),
                              _filterDropdown(
                                label: 'Certificate',
                                value: _certificateFilter,
                                items: [
                                  'All',
                                  'Pending',
                                  'Valid',
                                  'Expiring Soon',
                                  'Expired',
                                  'Suspended',
                                  'Not Required',
                                ],
                                onChanged: (value) => setState(
                                  () => _certificateFilter = value!,
                                ),
                              ),
                              OutlinedButton.icon(
                                onPressed: _resetFilters,
                                icon: const Icon(Icons.filter_alt_off),
                                label: const Text('Reset'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${_filteredRecords.length} inspection(s) found',
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            color: darkGreen,
                          ),
                        ),
                      ),
                      TextButton.icon(
                        onPressed: _showModuleGuide,
                        icon: const Icon(Icons.info_outline),
                        label: const Text('41A–41L'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  if (_filteredRecords.isEmpty)
                    Card(
                      elevation: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(30),
                        child: Column(
                          children: [
                            const Icon(
                              Icons.fact_check_outlined,
                              size: 48,
                              color: darkGreen,
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'No inspection records found.',
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(height: 6),
                            const Text(
                              'Create an inspection to begin Step 41 compliance tracking.',
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 14),
                            FilledButton.icon(
                              onPressed: _addRecord,
                              icon: const Icon(Icons.add),
                              label: const Text('Create First Inspection'),
                            ),
                          ],
                        ),
                      ),
                    )
                  else
                    ..._filteredRecords.map(_buildRecordCard),
                ],
              ),
            ),
    );
  }
}
