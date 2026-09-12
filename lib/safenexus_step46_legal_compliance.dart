import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// SafeNexus HSE
/// Step 46 — Legal, Compliance & Regulatory Management Center
///
/// Workflow:
/// Identify → Register → Assess Applicability → Evaluate → Find Gap
/// → Act → Verify → Renew → Close → Analyze
///
/// UAE-wide architecture. English + Malayalam UI.
/// Local persistence: SharedPreferences.

class SafeNexusStep46LegalCompliancePage extends StatefulWidget {
  const SafeNexusStep46LegalCompliancePage({super.key});

  @override
  State<SafeNexusStep46LegalCompliancePage> createState() =>
      _SafeNexusStep46LegalCompliancePageState();
}

class _SafeNexusStep46LegalCompliancePageState
    extends State<SafeNexusStep46LegalCompliancePage> {
  static const String _storageKey =
      'safenexus_hse_step46_legal_compliance';

  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);

  static const List<String> _requirementTypes = [
    'Law / Federal Requirement',
    'Emirate Regulation',
    'Regulatory Requirement',
    'Authority Circular / Guidance',
    'Code of Practice',
    'Permit / Licence',
    'Client Requirement',
    'Contractual Requirement',
    'Internal Standard',
    'Other',
  ];

  static const List<String> _authorities = [
    'UAE Federal Authority',
    'Abu Dhabi Authority',
    'Dubai Authority',
    'Sharjah Authority',
    'Ajman Authority',
    'Umm Al Quwain Authority',
    'Ras Al Khaimah Authority',
    'Fujairah Authority',
    'Municipality',
    'Civil Defence',
    'OSH / HSE Authority',
    'Environmental Authority',
    'Other',
  ];

  static const List<String> _statuses = [
    'Registered',
    'Applicable Review',
    'Applicable',
    'Not Applicable',
    'Compliance Review',
    'Gap Identified',
    'Action Required',
    'Verification Required',
    'Compliant',
    'Expired',
    'Renewal Required',
    'Closed',
  ];

  static const List<String> _priorities = [
    'Low',
    'Medium',
    'High',
    'Critical',
  ];

  static const List<String> _complianceStatuses = [
    'Not Assessed',
    'Compliant',
    'Partially Compliant',
    'Non-Compliant',
    'Not Applicable',
    'Pending Evidence',
  ];

  static const List<String> _actionStatuses = [
    'Not Required',
    'Open',
    'In Progress',
    'Verification Required',
    'Closed',
  ];

  static const List<String> _reviewFrequencies = [
    'Monthly',
    'Quarterly',
    'Six Monthly',
    'Annual',
    'Biennial',
    'As Required',
  ];

  final List<Map<String, dynamic>> _records = [];
  String _search = '';
  String _statusFilter = 'All';
  String _typeFilter = 'All';
  String _complianceFilter = 'All';
  bool _loading = true;

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
          _records
            ..clear()
            ..addAll(
              decoded
                  .whereType<Map>()
                  .map((item) => Map<String, dynamic>.from(item)),
            );
        }
      } catch (_) {
        // Keep local storage usable if old data is malformed.
      }
    }

    if (!mounted) return;
    setState(() {
      _loading = false;
    });
  }

  Future<void> _saveRecords() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_storageKey, jsonEncode(_records));
  }

  List<Map<String, dynamic>> get _filteredRecords {
    final query = _search.trim().toLowerCase();

    return _records.where((record) {
      final status = record['status']?.toString() ?? '';
      final type = record['requirementType']?.toString() ?? '';
      final compliance = record['complianceStatus']?.toString() ?? '';

      final matchesStatus =
          _statusFilter == 'All' || status == _statusFilter;
      final matchesType = _typeFilter == 'All' || type == _typeFilter;
      final matchesCompliance =
          _complianceFilter == 'All' || compliance == _complianceFilter;

      if (!matchesStatus || !matchesType || !matchesCompliance) {
        return false;
      }

      if (query.isEmpty) return true;

      final searchable = [
        record['title'],
        record['legalNo'],
        record['authority'],
        record['emirate'],
        record['site'],
        record['responsiblePerson'],
        record['reference'],
        record['obligation'],
        record['gapSummary'],
      ].join(' ').toLowerCase();

      return searchable.contains(query);
    }).toList();
  }

  int _countByStatus(String status) {
    return _records.where((item) => item['status'] == status).length;
  }

  int _countByCompliance(String status) {
    return _records
        .where((item) => item['complianceStatus'] == status)
        .length;
  }

  int get _applicableCount {
    return _records
        .where((item) => item['status'] == 'Applicable')
        .length;
  }

  int get _gapCount {
    return _records.where((item) {
      final compliance = item['complianceStatus']?.toString() ?? '';
      return compliance == 'Non-Compliant' ||
          compliance == 'Partially Compliant' ||
          item['status'] == 'Gap Identified' ||
          item['status'] == 'Action Required';
    }).length;
  }

  int get _openActions {
    return _records.fold<int>(
      0,
      (sum, item) => sum + ((item['openActions'] as num?)?.toInt() ?? 0),
    );
  }

  int get _expiryAttention {
    final now = DateTime.now();
    final limit = now.add(const Duration(days: 90));

    return _records.where((item) {
      final value = item['expiryDate']?.toString() ?? '';
      if (value.isEmpty) return false;
      final date = DateTime.tryParse(value);
      if (date == null) return false;
      final status = item['status']?.toString() ?? '';
      return date.isBefore(limit) &&
          status != 'Closed' &&
          status != 'Not Applicable';
    }).length;
  }

  int get _overdue {
    final now = DateTime.now();

    return _records.where((item) {
      final value = item['targetDate']?.toString() ?? '';
      if (value.isEmpty) return false;
      final date = DateTime.tryParse(value);
      if (date == null) return false;
      final actionStatus = item['actionStatus']?.toString() ?? '';
      return date.isBefore(now) &&
          actionStatus != 'Closed' &&
          actionStatus != 'Not Required';
    }).length;
  }

  String _formatDate(String? value) {
    if (value == null || value.isEmpty) return '-';
    final date = DateTime.tryParse(value);
    if (date == null) return value;
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  String _formatDateTime(String? value) {
    if (value == null || value.isEmpty) return '-';
    final date = DateTime.tryParse(value);
    if (date == null) return value;
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/${date.year} '
        '${date.hour.toString().padLeft(2, '0')}:'
        '${date.minute.toString().padLeft(2, '0')}';
  }

  void _snack(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Future<void> _deleteRecord(Map<String, dynamic> record) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete Compliance Record'),
        content: const Text(
          'Are you sure you want to delete this legal/compliance record?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    setState(() {
      _records.removeWhere((item) => item['id'] == record['id']);
    });
    await _saveRecords();
    _snack('Compliance record deleted.');
  }

  Future<void> _showForm({Map<String, dynamic>? existing}) async {
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (_) => _LegalComplianceForm(
        existing: existing,
        requirementTypes: _requirementTypes,
        authorities: _authorities,
        statuses: _statuses,
        priorities: _priorities,
        complianceStatuses: _complianceStatuses,
        actionStatuses: _actionStatuses,
        reviewFrequencies: _reviewFrequencies,
      ),
    );

    if (result == null) return;

    final now = DateTime.now().toIso8601String();
    final isEdit = existing != null;

    if (isEdit) {
      final index = _records.indexWhere(
        (item) => item['id'] == existing['id'],
      );

      if (index >= 0) {
        final history = List<Map<String, dynamic>>.from(
          (existing['history'] as List? ?? const [])
              .whereType<Map>()
              .map((item) => Map<String, dynamic>.from(item)),
        );

        history.add({
          'timestamp': now,
          'event': 'Legal/compliance record updated',
        });

        result['id'] = existing['id'];
        result['createdAt'] = existing['createdAt'] ?? now;
        result['updatedAt'] = now;
        result['history'] = history;
        _records[index] = result;
      }
    } else {
      result['id'] = 'LEG-${DateTime.now().microsecondsSinceEpoch}';
      result['createdAt'] = now;
      result['updatedAt'] = now;
      result['history'] = [
        {
          'timestamp': now,
          'event': 'Legal/compliance record created',
        },
      ];
      _records.insert(0, result);
    }

    await _saveRecords();

    if (!mounted) return;
    setState(() {});
    _snack(
      isEdit
          ? 'Compliance record updated.'
          : 'Compliance record added.',
    );
  }

  Future<void> _updateStatus(Map<String, dynamic> record) async {
    final current = record['status']?.toString() ?? _statuses.first;

    final selected = await showDialog<String>(
      context: context,
      builder: (dialogContext) => SimpleDialog(
        title: const Text('Update Compliance Status'),
        children: _statuses.map((status) {
          return SimpleDialogOption(
            onPressed: () => Navigator.pop(dialogContext, status),
            child: Row(
              children: [
                Icon(
                  status == current
                      ? Icons.radio_button_checked
                      : Icons.radio_button_unchecked,
                  color: status == current ? primaryGreen : Colors.grey,
                ),
                const SizedBox(width: 10),
                Text(status),
              ],
            ),
          );
        }).toList(),
      ),
    );

    if (selected == null || selected == current) return;

    _appendHistory(record, 'Status changed to $selected');

    setState(() {
      record['status'] = selected;
      record['updatedAt'] = DateTime.now().toIso8601String();
    });

    await _saveRecords();
    _snack('Status updated.');
  }

  Future<void> _updateCompliance(Map<String, dynamic> record) async {
    final current =
        record['complianceStatus']?.toString() ?? _complianceStatuses.first;

    final selected = await showDialog<String>(
      context: context,
      builder: (dialogContext) => SimpleDialog(
        title: const Text('Compliance Evaluation'),
        children: _complianceStatuses.map((status) {
          return SimpleDialogOption(
            onPressed: () => Navigator.pop(dialogContext, status),
            child: Row(
              children: [
                Icon(
                  status == current
                      ? Icons.radio_button_checked
                      : Icons.radio_button_unchecked,
                  color: status == current ? primaryGreen : Colors.grey,
                ),
                const SizedBox(width: 10),
                Text(status),
              ],
            ),
          );
        }).toList(),
      ),
    );

    if (selected == null || selected == current) return;

    _appendHistory(record, 'Compliance evaluated as $selected');

    setState(() {
      record['complianceStatus'] = selected;
      record['updatedAt'] = DateTime.now().toIso8601String();

      if (selected == 'Compliant') {
        record['status'] = 'Compliant';
      } else if (selected == 'Non-Compliant' ||
          selected == 'Partially Compliant') {
        record['status'] = 'Gap Identified';
      }
    });

    await _saveRecords();
    _snack('Compliance evaluation updated.');
  }

  Future<void> _updateActions(Map<String, dynamic> record) async {
    final controller = TextEditingController(
      text: '${record['openActions'] ?? 0}',
    );

    final value = await showDialog<int>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Open Regulatory Actions'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Open actions',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(
                context,
                int.tryParse(controller.text.trim()) ?? 0,
              );
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );

    controller.dispose();

    if (value == null) return;

    _appendHistory(record, 'Open action count updated');

    setState(() {
      record['openActions'] = value;
      record['updatedAt'] = DateTime.now().toIso8601String();
    });

    await _saveRecords();
    _snack('Action count updated.');
  }

  void _appendHistory(Map<String, dynamic> record, String event) {
    final history = List<Map<String, dynamic>>.from(
      (record['history'] as List? ?? const [])
          .whereType<Map>()
          .map((item) => Map<String, dynamic>.from(item)),
    );

    history.add({
      'timestamp': DateTime.now().toIso8601String(),
      'event': event,
    });

    record['history'] = history;
  }

  void _showHistory(Map<String, dynamic> record) {
    final history = (record['history'] as List? ?? const [])
        .whereType<Map>()
        .map((item) => Map<String, dynamic>.from(item))
        .toList()
        .reversed
        .toList();

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: pageBackground,
      builder: (_) => SafeArea(
        child: SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.72,
          child: Column(
            children: [
              const SizedBox(height: 12),
              Container(
                width: 42,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18),
                child: Text(
                  'Compliance History — ${record['legalNo'] ?? '-'}',
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                    color: darkGreen,
                  ),
                ),
              ),
              Expanded(
                child: history.isEmpty
                    ? const Center(
                        child: Text('No history available.'),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: history.length,
                        itemBuilder: (_, index) {
                          final item = history[index];
                          return Card(
                            child: ListTile(
                              leading: const CircleAvatar(
                                child: Icon(Icons.history),
                              ),
                              title: Text(
                                item['event']?.toString() ?? '-',
                              ),
                              subtitle: Text(
                                _formatDateTime(
                                  item['timestamp']?.toString(),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDetails(Map<String, dynamic> record) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: pageBackground,
      builder: (_) => _LegalDetailsSheet(
        record: record,
        formatDate: _formatDate,
        formatDateTime: _formatDateTime,
        onHistory: () {
          Navigator.pop(context);
          _showHistory(record);
        },
      ),
    );
  }

  void _showDashboard() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: pageBackground,
      builder: (_) => _ComplianceDashboard(
        total: _records.length,
        applicable: _applicableCount,
        compliant: _countByCompliance('Compliant'),
        partial: _countByCompliance('Partially Compliant'),
        nonCompliant: _countByCompliance('Non-Compliant'),
        gaps: _gapCount,
        actions: _openActions,
        expiryAttention: _expiryAttention,
        overdue: _overdue,
      ),
    );
  }

  void _showGuide() {
    showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('46 — Legal & Compliance'),
        content: const SingleChildScrollView(
          child: Text(
            'SafeNexus HSE legal and regulatory workflow:\n\n'
            '1. Identify applicable requirements.\n'
            '2. Register the requirement and authority.\n'
            '3. Assess applicability to site/activity.\n'
            '4. Record compliance obligations and evidence.\n'
            '5. Evaluate compliance and identify gaps.\n'
            '6. Link gaps to corrective/regulatory actions.\n'
            '7. Verify implementation and effectiveness.\n'
            '8. Track licences, permits and expiry dates.\n'
            '9. Review and renew requirements.\n'
            '10. Maintain history and management intelligence.\n\n'
            'Use this center as a controlled HSE register. '
            'Legal applicability should be verified against the '
            'current competent authority requirements for the relevant '
            'UAE emirate, activity and site.',
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
      _search = '';
      _statusFilter = 'All';
      _typeFilter = 'All';
      _complianceFilter = 'All';
    });
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredRecords;

    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
        title: const Text(
          'HSE Legal & Compliance',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        actions: [
          IconButton(
            tooltip: 'Guide',
            onPressed: _showGuide,
            icon: const Icon(Icons.help_outline),
          ),
          IconButton(
            tooltip: 'Dashboard',
            onPressed: _showDashboard,
            icon: const Icon(Icons.dashboard_outlined),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        onPressed: () => _showForm(),
        icon: const Icon(Icons.add),
        label: const Text('New Requirement'),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadRecords,
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
                children: [
                  _buildHeader(),
                  const SizedBox(height: 14),
                  _buildKpiGrid(),
                  const SizedBox(height: 16),
                  _buildFilters(),
                  const SizedBox(height: 14),
                  if (filtered.isEmpty)
                    _buildEmptyState()
                  else
                    ...filtered.map(_buildRecordCard),
                ],
              ),
            ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [darkGreen, primaryGreen],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Step 46 • Legal & Compliance',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'Control legal registers, obligations, compliance and renewals.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Identify → Register → Evaluate → Act → Verify → Renew → Analyze',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKpiGrid() {
    final cards = [
      _KpiData(
        'Legal Records',
        '${_records.length}',
        Icons.gavel_outlined,
      ),
      _KpiData(
        'Applicable',
        '$_applicableCount',
        Icons.rule_folder_outlined,
      ),
      _KpiData(
        'Compliant',
        '${_countByCompliance('Compliant')}',
        Icons.verified_outlined,
      ),
      _KpiData(
        'Compliance Gaps',
        '$_gapCount',
        Icons.warning_amber_outlined,
      ),
      _KpiData(
        'Open Actions',
        '$_openActions',
        Icons.task_alt_outlined,
      ),
      _KpiData(
        'Expiry Attention',
        '$_expiryAttention',
        Icons.event_busy_outlined,
      ),
      _KpiData(
        'Overdue',
        '$_overdue',
        Icons.priority_high_outlined,
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth > 700 ? 3 : 2;
        final width =
            (constraints.maxWidth - ((columns - 1) * 10)) / columns;

        return Wrap(
          spacing: 10,
          runSpacing: 10,
          children: cards.map((item) {
            return SizedBox(
              width: width,
              child: _KpiCard(data: item),
            );
          }).toList(),
        );
      },
    );
  }

  Widget _buildFilters() {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  _search = value;
                });
              },
              decoration: InputDecoration(
                hintText:
                    'Search legal no., authority, site, obligation...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _search.isEmpty
                    ? null
                    : IconButton(
                        onPressed: () {
                          setState(() {
                            _search = '';
                          });
                        },
                        icon: const Icon(Icons.clear),
                      ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    initialValue: _statusFilter,
                    isExpanded: true,
                    decoration: const InputDecoration(
                      labelText: 'Status',
                      border: OutlineInputBorder(),
                    ),
                    items: [
                      const DropdownMenuItem(
                        value: 'All',
                        child: Text('All Statuses'),
                      ),
                      ..._statuses.map(
                        (item) => DropdownMenuItem(
                          value: item,
                          child: Text(item),
                        ),
                      ),
                    ],
                    onChanged: (value) {
                      if (value == null) return;
                      setState(() {
                        _statusFilter = value;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    initialValue: _typeFilter,
                    isExpanded: true,
                    decoration: const InputDecoration(
                      labelText: 'Type',
                      border: OutlineInputBorder(),
                    ),
                    items: [
                      const DropdownMenuItem(
                        value: 'All',
                        child: Text('All Types'),
                      ),
                      ..._requirementTypes.map(
                        (item) => DropdownMenuItem(
                          value: item,
                          child: Text(item),
                        ),
                      ),
                    ],
                    onChanged: (value) {
                      if (value == null) return;
                      setState(() {
                        _typeFilter = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    initialValue: _complianceFilter,
                    isExpanded: true,
                    decoration: const InputDecoration(
                      labelText: 'Compliance',
                      border: OutlineInputBorder(),
                    ),
                    items: [
                      const DropdownMenuItem(
                        value: 'All',
                        child: Text('All Results'),
                      ),
                      ..._complianceStatuses.map(
                        (item) => DropdownMenuItem(
                          value: item,
                          child: Text(item),
                        ),
                      ),
                    ],
                    onChanged: (value) {
                      if (value == null) return;
                      setState(() {
                        _complianceFilter = value;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  tooltip: 'Reset filters',
                  onPressed: _resetFilters,
                  icon: const Icon(Icons.filter_alt_off_outlined),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            Icon(
              Icons.gavel_outlined,
              size: 56,
              color: primaryGreen,
            ),
            const SizedBox(height: 12),
            const Text(
              'No legal or compliance records found',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),
            const Text(
              'Create a requirement or change the filters to view records.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: () => _showForm(),
              icon: const Icon(Icons.add),
              label: const Text('Create Requirement'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecordCard(Map<String, dynamic> record) {
    final status = record['status']?.toString() ?? '-';
    final compliance =
        record['complianceStatus']?.toString() ?? '-';
    final expiry = record['expiryDate']?.toString() ?? '';
    final expiryDate = DateTime.tryParse(expiry);
    final now = DateTime.now();
    final expiryAttention = expiryDate != null &&
        expiryDate.isBefore(now.add(const Duration(days: 90))) &&
        status != 'Closed' &&
        status != 'Not Applicable';

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
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
                  CircleAvatar(
                    backgroundColor:
                        primaryGreen.withValues(alpha: 0.10),
                    foregroundColor: primaryGreen,
                    child: const Icon(Icons.gavel_outlined),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          record['title']?.toString() ??
                              'Untitled Requirement',
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                            color: darkGreen,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          '${record['legalNo'] ?? '-'} • '
                          '${record['requirementType'] ?? '-'}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _StatusChip(label: status),
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      switch (value) {
                        case 'edit':
                          _showForm(existing: record);
                        case 'status':
                          _updateStatus(record);
                        case 'compliance':
                          _updateCompliance(record);
                        case 'actions':
                          _updateActions(record);
                        case 'history':
                          _showHistory(record);
                        case 'delete':
                          _deleteRecord(record);
                      }
                    },
                    itemBuilder: (_) => const [
                      PopupMenuItem(
                        value: 'edit',
                        child: Text('Edit Record'),
                      ),
                      PopupMenuItem(
                        value: 'status',
                        child: Text('Update Status'),
                      ),
                      PopupMenuItem(
                        value: 'compliance',
                        child: Text('Evaluate Compliance'),
                      ),
                      PopupMenuItem(
                        value: 'actions',
                        child: Text('Update Actions'),
                      ),
                      PopupMenuItem(
                        value: 'history',
                        child: Text('View History'),
                      ),
                      PopupMenuItem(
                        value: 'delete',
                        child: Text('Delete'),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _InfoPill(
                    icon: Icons.account_balance_outlined,
                    text: record['authority']?.toString() ?? '-',
                  ),
                  _InfoPill(
                    icon: Icons.location_on_outlined,
                    text: record['emirate']?.toString() ?? '-',
                  ),
                  _InfoPill(
                    icon: Icons.flag_outlined,
                    text: record['priority']?.toString() ?? '-',
                  ),
                  _InfoPill(
                    icon: Icons.verified_user_outlined,
                    text: compliance,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: _MiniMetric(
                      label: 'Open Actions',
                      value: '${record['openActions'] ?? 0}',
                    ),
                  ),
                  Expanded(
                    child: _MiniMetric(
                      label: 'Review',
                      value: _formatDate(
                        record['reviewDate']?.toString(),
                      ),
                    ),
                  ),
                  Expanded(
                    child: _MiniMetric(
                      label: 'Expiry',
                      value: _formatDate(expiry),
                    ),
                  ),
                ],
              ),
              if (expiryAttention) ...[
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.orange.withValues(alpha: 0.10),
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.event_busy_outlined,
                        size: 18,
                        color: Colors.orange,
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Expiry / renewal requires attention.',
                          style: TextStyle(
                            color: Colors.orange,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _LegalComplianceForm extends StatefulWidget {
  const _LegalComplianceForm({
    required this.existing,
    required this.requirementTypes,
    required this.authorities,
    required this.statuses,
    required this.priorities,
    required this.complianceStatuses,
    required this.actionStatuses,
    required this.reviewFrequencies,
  });

  final Map<String, dynamic>? existing;
  final List<String> requirementTypes;
  final List<String> authorities;
  final List<String> statuses;
  final List<String> priorities;
  final List<String> complianceStatuses;
  final List<String> actionStatuses;
  final List<String> reviewFrequencies;

  @override
  State<_LegalComplianceForm> createState() => _LegalComplianceFormState();
}

class _LegalComplianceFormState extends State<_LegalComplianceForm> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _title;
  late final TextEditingController _legalNo;
  late final TextEditingController _reference;
  late final TextEditingController _version;
  late final TextEditingController _emirate;
  late final TextEditingController _site;
  late final TextEditingController _department;
  late final TextEditingController _responsiblePerson;
  late final TextEditingController _obligation;
  late final TextEditingController _evidence;
  late final TextEditingController _gapSummary;
  late final TextEditingController _actions;
  late final TextEditingController _licenceNo;
  late final TextEditingController _notes;

  String? _requirementType;
  String? _authority;
  String? _status;
  String? _priority;
  String? _complianceStatus;
  String? _actionStatus;
  String? _reviewFrequency;

  DateTime? _effectiveDate;
  DateTime? _reviewDate;
  DateTime? _expiryDate;
  DateTime? _targetDate;

  @override
  void initState() {
    super.initState();
    final item = widget.existing ?? <String, dynamic>{};

    _title = TextEditingController(
      text: item['title']?.toString() ?? '',
    );
    _legalNo = TextEditingController(
      text: item['legalNo']?.toString() ?? '',
    );
    _reference = TextEditingController(
      text: item['reference']?.toString() ?? '',
    );
    _version = TextEditingController(
      text: item['version']?.toString() ?? '',
    );
    _emirate = TextEditingController(
      text: item['emirate']?.toString() ?? '',
    );
    _site = TextEditingController(
      text: item['site']?.toString() ?? '',
    );
    _department = TextEditingController(
      text: item['department']?.toString() ?? '',
    );
    _responsiblePerson = TextEditingController(
      text: item['responsiblePerson']?.toString() ?? '',
    );
    _obligation = TextEditingController(
      text: item['obligation']?.toString() ?? '',
    );
    _evidence = TextEditingController(
      text: item['evidence']?.toString() ?? '',
    );
    _gapSummary = TextEditingController(
      text: item['gapSummary']?.toString() ?? '',
    );
    _actions = TextEditingController(
      text: item['actions']?.toString() ?? '',
    );
    _licenceNo = TextEditingController(
      text: item['licenceNo']?.toString() ?? '',
    );
    _notes = TextEditingController(
      text: item['notes']?.toString() ?? '',
    );

    _requirementType =
        item['requirementType']?.toString() ??
        widget.requirementTypes.first;
    _authority =
        item['authority']?.toString() ?? widget.authorities.first;
    _status =
        item['status']?.toString() ?? widget.statuses.first;
    _priority =
        item['priority']?.toString() ?? widget.priorities[1];
    _complianceStatus =
        item['complianceStatus']?.toString() ??
        widget.complianceStatuses.first;
    _actionStatus =
        item['actionStatus']?.toString() ??
        widget.actionStatuses.first;
    _reviewFrequency =
        item['reviewFrequency']?.toString() ??
        widget.reviewFrequencies[3];

    _effectiveDate = DateTime.tryParse(
      item['effectiveDate']?.toString() ?? '',
    );
    _reviewDate = DateTime.tryParse(
      item['reviewDate']?.toString() ?? '',
    );
    _expiryDate = DateTime.tryParse(
      item['expiryDate']?.toString() ?? '',
    );
    _targetDate = DateTime.tryParse(
      item['targetDate']?.toString() ?? '',
    );
  }

  @override
  void dispose() {
    _title.dispose();
    _legalNo.dispose();
    _reference.dispose();
    _version.dispose();
    _emirate.dispose();
    _site.dispose();
    _department.dispose();
    _responsiblePerson.dispose();
    _obligation.dispose();
    _evidence.dispose();
    _gapSummary.dispose();
    _actions.dispose();
    _licenceNo.dispose();
    _notes.dispose();
    super.dispose();
  }

  Future<void> _pickDate({
    required DateTime? current,
    required void Function(DateTime value) onSelected,
  }) async {
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      initialDate: current ?? DateTime.now(),
    );

    if (picked != null) {
      onSelected(picked);
    }
  }

  String _dateText(DateTime? value) {
    if (value == null) return 'Select date';
    return '${value.day.toString().padLeft(2, '0')}/'
        '${value.month.toString().padLeft(2, '0')}/${value.year}';
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final now = DateTime.now().toIso8601String();

    final result = <String, dynamic>{
      'id': widget.existing?['id'],
      'title': _title.text.trim(),
      'legalNo': _legalNo.text.trim(),
      'reference': _reference.text.trim(),
      'version': _version.text.trim(),
      'requirementType': _requirementType,
      'authority': _authority,
      'status': _status,
      'priority': _priority,
      'complianceStatus': _complianceStatus,
      'emirate': _emirate.text.trim(),
      'site': _site.text.trim(),
      'department': _department.text.trim(),
      'responsiblePerson': _responsiblePerson.text.trim(),
      'obligation': _obligation.text.trim(),
      'evidence': _evidence.text.trim(),
      'gapSummary': _gapSummary.text.trim(),
      'actions': _actions.text.trim(),
      'licenceNo': _licenceNo.text.trim(),
      'actionStatus': _actionStatus,
      'openActions':
          widget.existing?['openActions'] as int? ?? 0,
      'reviewFrequency': _reviewFrequency,
      'effectiveDate': _effectiveDate?.toIso8601String(),
      'reviewDate': _reviewDate?.toIso8601String(),
      'expiryDate': _expiryDate?.toIso8601String(),
      'targetDate': _targetDate?.toIso8601String(),
      'notes': _notes.text.trim(),
      'updatedAt': now,
    };

    Navigator.pop(context, result);
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.existing != null;

    return AlertDialog(
      title: Text(
        isEdit ? 'Edit Legal / Compliance' : 'New Legal Requirement',
      ),
      content: SizedBox(
        width: 650,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _sectionTitle('46A–46C • Legal & Regulatory Master'),
                _text(
                  _title,
                  'Requirement title',
                  requiredField: true,
                ),
                _text(_legalNo, 'Legal / reference number'),
                _text(_reference, 'Reference / source'),
                _text(_version, 'Version / revision'),
                _dropdown(
                  label: 'Requirement type',
                  value: _requirementType,
                  items: widget.requirementTypes,
                  onChanged: (value) {
                    setState(() {
                      _requirementType = value;
                    });
                  },
                ),
                _dropdown(
                  label: 'Authority',
                  value: _authority,
                  items: widget.authorities,
                  onChanged: (value) {
                    setState(() {
                      _authority = value;
                    });
                  },
                ),
                _text(_emirate, 'Emirate / jurisdiction'),
                _text(_site, 'Applicable site / project'),
                _text(_department, 'Department / activity'),
                _dropdown(
                  label: 'Status',
                  value: _status,
                  items: widget.statuses,
                  onChanged: (value) {
                    setState(() {
                      _status = value;
                    });
                  },
                ),
                _sectionTitle('46D • Compliance Obligation'),
                _text(
                  _obligation,
                  'Compliance obligation',
                  maxLines: 4,
                ),
                _text(
                  _responsiblePerson,
                  'Responsible person / owner',
                ),
                _dropdown(
                  label: 'Priority',
                  value: _priority,
                  items: widget.priorities,
                  onChanged: (value) {
                    setState(() {
                      _priority = value;
                    });
                  },
                ),
                _dropdown(
                  label: 'Compliance status',
                  value: _complianceStatus,
                  items: widget.complianceStatuses,
                  onChanged: (value) {
                    setState(() {
                      _complianceStatus = value;
                    });
                  },
                ),
                _text(
                  _evidence,
                  'Evidence / records / proof',
                  maxLines: 4,
                ),
                _sectionTitle('46E • Licence / Permit / Certificate'),
                _text(_licenceNo, 'Licence / permit / certificate no.'),
                _dateButton(
                  label: 'Effective date',
                  value: _dateText(_effectiveDate),
                  onPressed: () => _pickDate(
                    current: _effectiveDate,
                    onSelected: (value) {
                      setState(() {
                        _effectiveDate = value;
                      });
                    },
                  ),
                ),
                _dateButton(
                  label: 'Expiry / validity date',
                  value: _dateText(_expiryDate),
                  onPressed: () => _pickDate(
                    current: _expiryDate,
                    onSelected: (value) {
                      setState(() {
                        _expiryDate = value;
                      });
                    },
                  ),
                ),
                _sectionTitle('46F–46H • Evaluation & Regulatory Action'),
                _text(
                  _gapSummary,
                  'Compliance gap / non-compliance summary',
                  maxLines: 4,
                ),
                _text(
                  _actions,
                  'Corrective / regulatory actions',
                  maxLines: 4,
                ),
                _dropdown(
                  label: 'Action status',
                  value: _actionStatus,
                  items: widget.actionStatuses,
                  onChanged: (value) {
                    setState(() {
                      _actionStatus = value;
                    });
                  },
                ),
                _dateButton(
                  label: 'Target action date',
                  value: _dateText(_targetDate),
                  onPressed: () => _pickDate(
                    current: _targetDate,
                    onSelected: (value) {
                      setState(() {
                        _targetDate = value;
                      });
                    },
                  ),
                ),
                _sectionTitle('46I–46J • Review & Renewal'),
                _dropdown(
                  label: 'Review frequency',
                  value: _reviewFrequency,
                  items: widget.reviewFrequencies,
                  onChanged: (value) {
                    setState(() {
                      _reviewFrequency = value;
                    });
                  },
                ),
                _dateButton(
                  label: 'Next review date',
                  value: _dateText(_reviewDate),
                  onPressed: () => _pickDate(
                    current: _reviewDate,
                    onSelected: (value) {
                      setState(() {
                        _reviewDate = value;
                      });
                    },
                  ),
                ),
                _text(_notes, 'Notes', maxLines: 4),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton.icon(
          onPressed: _submit,
          icon: const Icon(Icons.save_outlined),
          label: Text(isEdit ? 'Update' : 'Save Requirement'),
        ),
      ],
    );
  }

  Widget _sectionTitle(String title) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 14, bottom: 10),
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 9,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF5EF),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        title,
        style: const TextStyle(
          color: _SafeNexusStep46LegalCompliancePageState.darkGreen,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  Widget _text(
    TextEditingController controller,
    String label, {
    bool requiredField = false,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        validator: requiredField
            ? (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Required';
                }
                return null;
              }
            : null,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _dropdown({
    required String label,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    final validValue = items.contains(value) ? value : null;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: DropdownButtonFormField<String>(
        initialValue: validValue,
        isExpanded: true,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        items: items.map((item) {
          return DropdownMenuItem(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _dateButton({
    required String label,
    required String value,
    required VoidCallback onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(4),
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: label,
            border: const OutlineInputBorder(),
          ),
          child: Row(
            children: [
              const Icon(Icons.calendar_today_outlined, size: 18),
              const SizedBox(width: 10),
              Text(value),
            ],
          ),
        ),
      ),
    );
  }
}

class _ComplianceDashboard extends StatelessWidget {
  const _ComplianceDashboard({
    required this.total,
    required this.applicable,
    required this.compliant,
    required this.partial,
    required this.nonCompliant,
    required this.gaps,
    required this.actions,
    required this.expiryAttention,
    required this.overdue,
  });

  final int total;
  final int applicable;
  final int compliant;
  final int partial;
  final int nonCompliant;
  final int gaps;
  final int actions;
  final int expiryAttention;
  final int overdue;

  @override
  Widget build(BuildContext context) {
    final cards = [
      _KpiData('Total Records', '$total', Icons.gavel_outlined),
      _KpiData('Applicable', '$applicable', Icons.rule_folder_outlined),
      _KpiData('Compliant', '$compliant', Icons.verified_outlined),
      _KpiData('Partial', '$partial', Icons.warning_amber_outlined),
      _KpiData('Non-Compliant', '$nonCompliant', Icons.error_outline),
      _KpiData('Gaps', '$gaps', Icons.report_problem_outlined),
      _KpiData('Open Actions', '$actions', Icons.task_alt_outlined),
      _KpiData(
        'Expiry Attention',
        '$expiryAttention',
        Icons.event_busy_outlined,
      ),
      _KpiData(
        'Overdue',
        '$overdue',
        Icons.priority_high_outlined,
      ),
    ];

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 42,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(height: 16),
            const Row(
              children: [
                Icon(
                  Icons.analytics_outlined,
                  color: _SafeNexusStep46LegalCompliancePageState.darkGreen,
                ),
                SizedBox(width: 8),
                Text(
                  'Regulatory Compliance Intelligence',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                    color:
                        _SafeNexusStep46LegalCompliancePageState.darkGreen,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: cards.map((item) {
                return SizedBox(
                  width: 145,
                  child: _KpiCard(data: item),
                );
              }).toList(),
            ),
            const SizedBox(height: 14),
            const Text(
              'Prioritize compliance gaps, renewals and overdue actions '
              'for management review.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _LegalDetailsSheet extends StatelessWidget {
  const _LegalDetailsSheet({
    required this.record,
    required this.formatDate,
    required this.formatDateTime,
    required this.onHistory,
  });

  final Map<String, dynamic> record;
  final String Function(String?) formatDate;
  final String Function(String?) formatDateTime;
  final VoidCallback onHistory;

  @override
  Widget build(BuildContext context) {
    final sections = <String, List<List<String>>>{
      'Legal / Regulatory Master': [
        ['Requirement', '${record['title'] ?? '-'}'],
        ['Legal No.', '${record['legalNo'] ?? '-'}'],
        ['Reference', '${record['reference'] ?? '-'}'],
        ['Version', '${record['version'] ?? '-'}'],
        ['Type', '${record['requirementType'] ?? '-'}'],
        ['Authority', '${record['authority'] ?? '-'}'],
        ['Status', '${record['status'] ?? '-'}'],
      ],
      'Applicability & Ownership': [
        ['Emirate', '${record['emirate'] ?? '-'}'],
        ['Site', '${record['site'] ?? '-'}'],
        ['Department', '${record['department'] ?? '-'}'],
        ['Responsible', '${record['responsiblePerson'] ?? '-'}'],
        ['Priority', '${record['priority'] ?? '-'}'],
      ],
      'Compliance Evaluation': [
        ['Compliance', '${record['complianceStatus'] ?? '-'}'],
        ['Obligation', '${record['obligation'] ?? '-'}'],
        ['Evidence', '${record['evidence'] ?? '-'}'],
        ['Gap Summary', '${record['gapSummary'] ?? '-'}'],
      ],
      'Licence / Renewal': [
        ['Licence / Permit', '${record['licenceNo'] ?? '-'}'],
        [
          'Effective',
          formatDate(record['effectiveDate']?.toString()),
        ],
        ['Expiry', formatDate(record['expiryDate']?.toString())],
        [
          'Review',
          formatDate(record['reviewDate']?.toString()),
        ],
        ['Frequency', '${record['reviewFrequency'] ?? '-'}'],
      ],
      'Regulatory Actions': [
        ['Actions', '${record['actions'] ?? '-'}'],
        ['Action Status', '${record['actionStatus'] ?? '-'}'],
        ['Open Actions', '${record['openActions'] ?? 0}'],
        ['Target Date', formatDate(record['targetDate']?.toString())],
      ],
      'Notes': [
        ['Notes', '${record['notes'] ?? '-'}'],
        [
          'Last Updated',
          formatDateTime(record['updatedAt']?.toString()),
        ],
      ],
    };

    return SafeArea(
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.86,
        child: Column(
          children: [
            const SizedBox(height: 12),
            Container(
              width: 42,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const CircleAvatar(
                    child: Icon(Icons.gavel_outlined),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      record['title']?.toString() ??
                          'Compliance Details',
                      style: const TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w800,
                        color:
                            _SafeNexusStep46LegalCompliancePageState
                                .darkGreen,
                      ),
                    ),
                  ),
                  IconButton(
                    tooltip: 'History',
                    onPressed: onHistory,
                    icon: const Icon(Icons.history),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: sections.entries.map((entry) {
                  return _DetailsSection(
                    title: entry.key,
                    rows: entry.value,
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailsSection extends StatelessWidget {
  const _DetailsSection({
    required this.title,
    required this.rows,
  });

  final String title;
  final List<List<String>> rows;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: _SafeNexusStep46LegalCompliancePageState.darkGreen,
                fontWeight: FontWeight.w800,
                fontSize: 16,
              ),
            ),
            const Divider(),
            ...rows.map(
              (row) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 118,
                      child: Text(
                        row[0],
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(row[1]),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _KpiData {
  const _KpiData(this.label, this.value, this.icon);

  final String label;
  final String value;
  final IconData icon;
}

class _KpiCard extends StatelessWidget {
  const _KpiCard({required this.data});

  final _KpiData data;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(13),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor:
                  _SafeNexusStep46LegalCompliancePageState.primaryGreen
                      .withValues(alpha: 0.10),
              foregroundColor:
                  _SafeNexusStep46LegalCompliancePageState.primaryGreen,
              child: Icon(data.icon, size: 20),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.value,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color:
                          _SafeNexusStep46LegalCompliancePageState
                              .darkGreen,
                    ),
                  ),
                  Text(
                    data.label,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: _background(label),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w800,
          color: _foreground(label),
        ),
      ),
    );
  }

  Color _background(String value) {
    switch (value) {
      case 'Compliant':
      case 'Closed':
        return Colors.green.withValues(alpha: 0.12);
      case 'Non-Compliant':
      case 'Expired':
      case 'Gap Identified':
        return Colors.red.withValues(alpha: 0.10);
      case 'Action Required':
      case 'Renewal Required':
      case 'Verification Required':
        return Colors.orange.withValues(alpha: 0.14);
      case 'Not Applicable':
        return Colors.grey.withValues(alpha: 0.16);
      default:
        return _SafeNexusStep46LegalCompliancePageState.primaryGreen
            .withValues(alpha: 0.10);
    }
  }

  Color _foreground(String value) {
    switch (value) {
      case 'Compliant':
      case 'Closed':
        return Colors.green.shade800;
      case 'Non-Compliant':
      case 'Expired':
      case 'Gap Identified':
        return Colors.red.shade800;
      case 'Action Required':
      case 'Renewal Required':
      case 'Verification Required':
        return Colors.orange.shade900;
      case 'Not Applicable':
        return Colors.grey.shade800;
      default:
        return _SafeNexusStep46LegalCompliancePageState.darkGreen;
    }
  }
}

class _InfoPill extends StatelessWidget {
  const _InfoPill({
    required this.icon,
    required this.text,
  });

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 235),
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: Colors.grey.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(9),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 15, color: Colors.black54),
          const SizedBox(width: 5),
          Flexible(
            child: Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 11,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniMetric extends StatelessWidget {
  const _MiniMetric({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontWeight: FontWeight.w800,
            color: _SafeNexusStep46LegalCompliancePageState.darkGreen,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }
}
