import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// SafeNexus HSE - Step 2C
/// HSE Objectives & KPI Register
///
/// Self-contained module. Stores KPI records locally using SharedPreferences.
class HseObjectivesKpiPage extends StatefulWidget {
  const HseObjectivesKpiPage({super.key});

  @override
  State<HseObjectivesKpiPage> createState() => _HseObjectivesKpiPageState();
}

class _HseObjectivesKpiPageState extends State<HseObjectivesKpiPage> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);

  static const String _storageKey = 'safenexus_hse_objectives_kpi_records';

  final _searchController = TextEditingController();

  List<Map<String, dynamic>> _records = [];
  String _filter = 'All';
  bool _loaded = false;

  final List<String> _categories = const [
    'Safety',
    'Health',
    'Training',
    'Inspection',
    'Incident',
    'Environment',
    'Emergency',
    'Welfare',
    'Compliance',
    'Other',
  ];

  final List<String> _types = const [
    'Leading',
    'Lagging',
  ];

  final List<String> _statuses = const [
    'On Target',
    'At Risk',
    'Off Target',
    'Not Measured',
  ];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_refresh);
    _loadRecords();
  }

  @override
  void dispose() {
    _searchController
      ..removeListener(_refresh)
      ..dispose();
    super.dispose();
  }

  Future<void> _loadRecords() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_storageKey);

    List<Map<String, dynamic>> loaded = [];

    if (raw != null && raw.isNotEmpty) {
      try {
        final decoded = jsonDecode(raw);
        if (decoded is List) {
          loaded = decoded
              .whereType<Map>()
              .map(
                (item) => Map<String, dynamic>.from(item),
              )
              .toList();
        }
      } catch (_) {
        loaded = [];
      }
    }

    if (!mounted) return;

    setState(() {
      _records = loaded;
      _loaded = true;
    });
  }

  Future<void> _saveRecords() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_storageKey, jsonEncode(_records));
  }

  void _refresh() {
    if (mounted) setState(() {});
  }

  List<Map<String, dynamic>> get _filteredRecords {
    final query = _searchController.text.trim().toLowerCase();

    return _records.where((record) {
      final status = (record['status'] ?? '').toString();
      final matchesFilter = _filter == 'All' || status == _filter;

      if (!matchesFilter) return false;
      if (query.isEmpty) return true;

      final searchable = [
        record['objective'],
        record['kpiName'],
        record['category'],
        record['type'],
        record['owner'],
        record['period'],
        record['remarks'],
      ].join(' ').toLowerCase();

      return searchable.contains(query);
    }).toList();
  }

  int get _onTargetCount =>
      _records.where((r) => r['status'] == 'On Target').length;

  int get _atRiskCount =>
      _records.where((r) => r['status'] == 'At Risk').length;

  int get _offTargetCount =>
      _records.where((r) => r['status'] == 'Off Target').length;

  flutter analyze
No issues found!
  double get _performancePercent {
    if (_records.isEmpty) return 0;

    final measured = _records.where((r) {
      final status = r['status'];
      return status == 'On Target' ||
          status == 'At Risk' ||
          status == 'Off Target';
    }).length;

    if (measured == 0) return 0;

    return (_onTargetCount / measured) * 100;
  }

  Future<void> _openRecordForm({Map<String, dynamic>? record}) async {
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return _KpiFormSheet(
          record: record,
          categories: _categories,
          types: _types,
          statuses: _statuses,
        );
      },
    );

    if (result == null) return;

    final existingId = result['id']?.toString();

    setState(() {
      final index = _records.indexWhere(
        (item) => item['id']?.toString() == existingId,
      );

      if (index >= 0) {
        _records[index] = result;
      } else {
        _records.insert(0, result);
      }
    });

    await _saveRecords();

    if (!mounted) return;

    _showMessage(
      indexWasUpdated(existingId) ? 'KPI updated successfully.' : 'KPI saved successfully.',
    );
  }

  bool indexWasUpdated(String? id) {
    if (id == null || id.isEmpty) return false;
    return _records.where((item) => item['id']?.toString() == id).length == 1 &&
        _records.any((item) => item['id']?.toString() == id);
  }

  Future<void> _deleteRecord(Map<String, dynamic> record) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Delete KPI?'),
          content: Text(
            'Delete "${record['kpiName'] ?? 'this KPI'}" from the register?',
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
        );
      },
    );

    if (confirmed != true) return;

    setState(() {
      _records.removeWhere(
        (item) => item['id']?.toString() == record['id']?.toString(),
      );
    });

    await _saveRecords();
    _showMessage('KPI deleted.');
  }

  void _showMessage(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Color _statusColor(String status) {
    switch (status) {
      case 'On Target':
        return Colors.green;
      case 'At Risk':
        return Colors.orange;
      case 'Off Target':
        return Colors.red;
      default:
        return Colors.blueGrey;
    }
  }

  String _formatNumber(dynamic value) {
    final number = double.tryParse(value?.toString() ?? '');
    if (number == null) return value?.toString() ?? '-';
    if (number == number.roundToDouble()) {
      return number.toInt().toString();
    }
    return number.toStringAsFixed(2);
  }

  Widget _summaryCard() {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: primaryGreen.withValues(alpha: 0.10),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.track_changes_outlined,
                    color: primaryGreen,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    'HSE Objectives & KPI',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: darkGreen,
                    ),
                  ),
                ),
                Text(
                  '${_performancePercent.round()}%',
                  style: const TextStyle(
                    fontSize: 22,
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
                value: _performancePercent / 100,
                minHeight: 8,
              ),
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: _metric(
                    'Total',
                    _records.length.toString(),
                    Icons.list_alt_outlined,
                  ),
                ),
                Expanded(
                  child: _metric(
                    'On Target',
                    _onTargetCount.toString(),
                    Icons.check_circle_outline,
                  ),
                ),
                Expanded(
                  child: _metric(
                    'At Risk',
                    _atRiskCount.toString(),
                    Icons.warning_amber_outlined,
                  ),
                ),
                Expanded(
                  child: _metric(
                    'Off Target',
                    _offTargetCount.toString(),
                    Icons.error_outline,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _metric(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, size: 20, color: primaryGreen),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w900,
          ),
        ),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey.shade700,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _filters() {
    return Column(
      children: [
        TextField(
          controller: _searchController,
          decoration: InputDecoration(
            labelText: 'Search objectives / KPIs',
            prefixIcon: const Icon(Icons.search),
            suffixIcon: _searchController.text.isEmpty
                ? null
                : IconButton(
                    onPressed: _searchController.clear,
                    icon: const Icon(Icons.clear),
                  ),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        const SizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              'All',
              ..._statuses,
            ].map((status) {
              final selected = _filter == status;

              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ChoiceChip(
                  label: Text(status),
                  selected: selected,
                  onSelected: (_) {
                    setState(() => _filter = status);
                  },
                  selectedColor: primaryGreen.withValues(alpha: 0.18),
                  labelStyle: TextStyle(
                    color: selected ? darkGreen : Colors.black87,
                    fontWeight:
                        selected ? FontWeight.w800 : FontWeight.w500,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _recordCard(Map<String, dynamic> record) {
    final status = (record['status'] ?? 'Not Measured').toString();
    final statusColor = _statusColor(status);

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () => _openRecordForm(record: record),
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
                      (record['kpiName'] ?? 'Untitled KPI').toString(),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: darkGreen,
                      ),
                    ),
                  ),
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'edit') {
                        _openRecordForm(record: record);
                      } else if (value == 'delete') {
                        _deleteRecord(record);
                      }
                    },
                    itemBuilder: (context) => const [
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
              const SizedBox(height: 4),
              Text(
                (record['objective'] ?? '').toString(),
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _tag(
                    (record['category'] ?? 'Other').toString(),
                    Icons.category_outlined,
                  ),
                  _tag(
                    (record['type'] ?? 'Leading').toString(),
                    Icons.insights_outlined,
                  ),
                  _statusTag(status, statusColor),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: _valueLine(
                      'Target',
                      _formatNumber(record['target']),
                    ),
                  ),
                  Expanded(
                    child: _valueLine(
                      'Actual',
                      _formatNumber(record['actual']),
                    ),
                  ),
                  Expanded(
                    child: _valueLine(
                      'Period',
                      (record['period'] ?? '-').toString(),
                    ),
                  ),
                ],
              ),
              if ((record['owner'] ?? '').toString().isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  'Owner: ${record['owner']}',
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 12,
                  ),
                ),
              ],
              if ((record['remarks'] ?? '').toString().isNotEmpty) ...[
                const SizedBox(height: 6),
                Text(
                  (record['remarks'] ?? '').toString(),
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 12,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _tag(String text, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14),
          const SizedBox(width: 4),
          Text(
            text,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusTag(String status, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  Widget _valueLine(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 11,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 13,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!_loaded) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final records = _filteredRecords;

    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: darkGreen,
        elevation: 0,
        title: const Text(
          'HSE Objectives & KPI',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openRecordForm(),
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text(
          'Add KPI',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
        children: [
          _summaryCard(),
          const SizedBox(height: 16),
          _filters(),
          const SizedBox(height: 16),
          if (_records.isEmpty)
            _emptyState()
          else if (records.isEmpty)
            _noResults()
          else
            ...records.map(_recordCard),
        ],
      ),
    );
  }

  Widget _emptyState() {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          children: [
            const Icon(
              Icons.track_changes_outlined,
              size: 48,
              color: primaryGreen,
            ),
            const SizedBox(height: 12),
            const Text(
              'No HSE KPI records yet',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w800,
                color: darkGreen,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Add your first objective and KPI to start tracking HSE performance.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: () => _openRecordForm(),
              icon: const Icon(Icons.add),
              label: const Text('Add First KPI'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _noResults() {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Icon(Icons.search_off, size: 42),
            const SizedBox(height: 10),
            const Text(
              'No matching KPI records',
              style: TextStyle(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 6),
            const Text(
              'Try another search term or status filter.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _KpiFormSheet extends StatefulWidget {
  final Map<String, dynamic>? record;
  final List<String> categories;
  final List<String> types;
  final List<String> statuses;

  const _KpiFormSheet({
    required this.record,
    required this.categories,
    required this.types,
    required this.statuses,
  });

  @override
  State<_KpiFormSheet> createState() => _KpiFormSheetState();
}

class _KpiFormSheetState extends State<_KpiFormSheet> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _objectiveController;
  late final TextEditingController _kpiController;
  late final TextEditingController _targetController;
  late final TextEditingController _actualController;
  late final TextEditingController _periodController;
  late final TextEditingController _ownerController;
  late final TextEditingController _remarksController;

  late String _category;
  late String _type;
  late String _status;

  @override
  void initState() {
    super.initState();

    final record = widget.record;

    _objectiveController = TextEditingController(
      text: record?['objective']?.toString() ?? '',
    );
    _kpiController = TextEditingController(
      text: record?['kpiName']?.toString() ?? '',
    );
    _targetController = TextEditingController(
      text: record?['target']?.toString() ?? '',
    );
    _actualController = TextEditingController(
      text: record?['actual']?.toString() ?? '',
    );
    _periodController = TextEditingController(
      text: record?['period']?.toString() ?? '',
    );
    _ownerController = TextEditingController(
      text: record?['owner']?.toString() ?? '',
    );
    _remarksController = TextEditingController(
      text: record?['remarks']?.toString() ?? '',
    );

    _category = widget.categories.contains(record?['category'])
        ? record!['category'].toString()
        : widget.categories.first;

    _type = widget.types.contains(record?['type'])
        ? record!['type'].toString()
        : widget.types.first;

    _status = widget.statuses.contains(record?['status'])
        ? record!['status'].toString()
        : widget.statuses.last;
  }

  @override
  void dispose() {
    _objectiveController.dispose();
    _kpiController.dispose();
    _targetController.dispose();
    _actualController.dispose();
    _periodController.dispose();
    _ownerController.dispose();
    _remarksController.dispose();
    super.dispose();
  }

  InputDecoration _decoration(String label, {String? hint}) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
    );
  }

  Widget _field(
    TextEditingController controller,
    String label, {
    bool required = false,
    String? hint,
    int maxLines = 1,
    TextInputType? keyboardType,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: keyboardType,
        decoration: _decoration(label, hint: hint),
        validator: required
            ? (value) {
                if (value == null || value.trim().isEmpty) {
                  return '$label is required';
                }
                return null;
              }
            : null,
      ),
    );
  }

  Widget _dropdown(
    String label,
    String value,
    List<String> items,
    ValueChanged<String?> onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: DropdownButtonFormField<String>(
        initialValue: value,
        decoration: _decoration(label),
        items: items
            .map(
              (item) => DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              ),
            )
            .toList(),
        onChanged: onChanged,
      ),
    );
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final target = double.tryParse(_targetController.text.trim());
    final actual = double.tryParse(_actualController.text.trim());

    if (target == null || target < 0) {
      _message('Enter a valid target value.');
      return;
    }

    if (actual == null || actual < 0) {
      _message('Enter a valid actual value.');
      return;
    }

    final existingId = widget.record?['id']?.toString();
    final id = existingId == null || existingId.isEmpty
        ? DateTime.now().microsecondsSinceEpoch.toString()
        : existingId;

    final record = <String, dynamic>{
      'id': id,
      'objective': _objectiveController.text.trim(),
      'kpiName': _kpiController.text.trim(),
      'category': _category,
      'type': _type,
      'target': target,
      'actual': actual,
      'period': _periodController.text.trim(),
      'owner': _ownerController.text.trim(),
      'status': _status,
      'remarks': _remarksController.text.trim(),
      'updatedAt': DateTime.now().toIso8601String(),
    };

    Navigator.pop(context, record);
  }

  void _message(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.viewInsetsOf(context).bottom;

    return SafeArea(
      child: Container(
        height: MediaQuery.sizeOf(context).height * 0.92,
        padding: EdgeInsets.fromLTRB(16, 10, 16, bottom + 16),
        decoration: const BoxDecoration(
          color: Color(0xFFF6F8F7),
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(22),
          ),
        ),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Center(
                child: Container(
                  width: 42,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Text(
                widget.record == null ? 'Add HSE KPI' : 'Edit HSE KPI',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF0B5D4B),
                ),
              ),
              const SizedBox(height: 16),
              _field(
                _objectiveController,
                'HSE Objective',
                required: true,
                maxLines: 3,
                hint: 'Example: Improve site safety performance',
              ),
              _field(
                _kpiController,
                'KPI Name',
                required: true,
                hint: 'Example: Monthly Safety Inspection Completion',
              ),
              _dropdown(
                'KPI Category',
                _category,
                widget.categories,
                (value) {
                  if (value != null) setState(() => _category = value);
                },
              ),
              _dropdown(
                'KPI Type',
                _type,
                widget.types,
                (value) {
                  if (value != null) setState(() => _type = value);
                },
              ),
              _field(
                _targetController,
                'Target Value',
                required: true,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                hint: 'Example: 95',
              ),
              _field(
                _actualController,
                'Actual Value',
                required: true,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                hint: 'Example: 92',
              ),
              _field(
                _periodController,
                'Measurement Period',
                required: true,
                hint: 'Example: September 2026',
              ),
              _field(
                _ownerController,
                'KPI Owner',
                required: true,
              ),
              _dropdown(
                'Performance Status',
                _status,
                widget.statuses,
                (value) {
                  if (value != null) setState(() => _status = value);
                },
              ),
              _field(
                _remarksController,
                'Remarks / Action',
                maxLines: 4,
                hint: 'Record explanation, action or follow-up.',
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 52,
                child: FilledButton.icon(
                  onPressed: _submit,
                  icon: const Icon(Icons.save_outlined),
                  label: Text(
                    widget.record == null ? 'Save KPI' : 'Update KPI',
                    style: const TextStyle(fontWeight: FontWeight.w800),
                  ),
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFF159447),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
