import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// SafeNexus HSE - Step 2C
/// HSE Objectives & KPI Register
///
/// Self-contained module.
/// Stores KPI records locally using SharedPreferences.
class HseObjectivesKpiPage extends StatefulWidget {
  const HseObjectivesKpiPage({super.key});

  @override
  State<HseObjectivesKpiPage> createState() => _HseObjectivesKpiPageState();
}

class _HseObjectivesKpiPageState extends State<HseObjectivesKpiPage> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);

  static const String _storageKey =
      'safenexus_hse_objectives_kpi_records';

  final TextEditingController _searchController =
      TextEditingController();

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

    await prefs.setString(
      _storageKey,
      jsonEncode(_records),
    );
  }

  void _refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  List<Map<String, dynamic>> get _filteredRecords {
    final query = _searchController.text.trim().toLowerCase();

    return _records.where((record) {
      final status = (record['status'] ?? '').toString();

      final matchesFilter =
          _filter == 'All' || status == _filter;

      if (!matchesFilter) {
        return false;
      }

      if (query.isEmpty) {
        return true;
      }

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
      _records.where(
        (record) => record['status'] == 'On Target',
      ).length;

  int get _atRiskCount =>
      _records.where(
        (record) => record['status'] == 'At Risk',
      ).length;

  int get _offTargetCount =>
      _records.where(
        (record) => record['status'] == 'Off Target',
      ).length;

  double get _performancePercent {
    if (_records.isEmpty) {
      return 0;
    }

    final measured = _records.where((record) {
      final status = record['status'];

      return status == 'On Target' ||
          status == 'At Risk' ||
          status == 'Off Target';
    }).length;

    if (measured == 0) {
      return 0;
    }

    return (_onTargetCount / measured) * 100;
  }

  Future<void> _openRecordForm({
    Map<String, dynamic>? record,
  }) async {
    final isEditing = record != null;

    final result =
        await showModalBottomSheet<Map<String, dynamic>>(
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

    if (result == null) {
      return;
    }

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

    if (!mounted) {
      return;
    }

    _showMessage(
      isEditing
          ? 'KPI updated successfully.'
          : 'KPI saved successfully.',
    );
  }

  Future<void> _deleteRecord(
    Map<String, dynamic> record,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Delete KPI?'),
          content: Text(
            'Delete "${record['kpiName'] ?? 'this KPI'}" '
            'from the register?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, false);
              },
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(dialogContext, true);
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

    setState(() {
      _records.removeWhere(
        (item) =>
            item['id']?.toString() ==
            record['id']?.toString(),
      );
    });

    await _saveRecords();

    if (!mounted) {
      return;
    }

    _showMessage('KPI deleted.');
  }

  void _showMessage(String message) {
    if (!mounted) {
      return;
    }

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
    final number = double.tryParse(
      value?.toString() ?? '',
    );

    if (number == null) {
      return value?.toString() ?? '-';
    }

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
                    color: primaryGreen.withValues(
                      alpha: 0.10,
                    ),
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

  Widget _metric(
    String label,
    String value,
    IconData icon,
  ) {
    return Column(
      children: [
        Icon(
          icon,
          size: 20,
          color: primaryGreen,
        ),
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
                padding: const EdgeInsets.only(
                  right: 8,
                ),
                child: ChoiceChip(
                  label: Text(status),
                  selected: selected,
                  onSelected: (_) {
                    setState(() {
                      _filter = status;
                    });
                  },
                  selectedColor:
                      primaryGreen.withValues(
                    alpha: 0.18,
                  ),
                  labelStyle: TextStyle(
                    color: selected
                        ? darkGreen
                        : Colors.black87,
                    fontWeight: selected
                        ? FontWeight.w800
                        : FontWeight.w500,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _recordCard(
    Map<String, dynamic> record,
  ) {
    final status =
        (record['status'] ?? 'Not Measured').toString();

    final statusColor = _statusColor(status);

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () {
          _openRecordForm(record: record);
        },
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
                      (record['kpiName'] ??
                              'Untitled KPI')
                          .toString(),
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
                        _openRecordForm(
                          record: record,
                        );
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
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _tag(
                    (record['category'] ?? 'Other')
                        .toString(),
                    Icons.category_outlined,
                  ),
                  _tag(
                    (record['type'] ?? 'Leading')
                        .toString(),
                    Icons.insights_outlined,
                  ),
                  _statusTag(
                    status,
                    statusColor,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: _valueLine(
                      'Target',
                      _formatNumber(
                        record['target'],
                      ),
                    ),
                  ),
                  Expanded(
                    child: _valueLine(
                      'Actual',
                      _formatNumber(
                        record['actual'],
                      ),
                    ),
                  ),
                  Expanded(
                    child: _valueLine(
                      'Period',
                      (record['period'] ?? '-')
                          .toString(),
                    ),
                  ),
                ],
              ),
              if ((record['owner'] ?? '')
                  .toString()
                  .isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  'Owner: ${record['owner']}',
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 12,
                  ),
                ),
              ],
              if ((record['remarks'] ?? '')
                  .toString()
                  .isNotEmpty) ...[
                const SizedBox(height: 6),
                Text(
                  (record['remarks'] ?? '')
                      .toString(),
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

  Widget _tag(
    String text,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: Colors.grey.withValues(
          alpha: 0.10,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
          ),
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

  Widget _statusTag(
    String status,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 9,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: color.withValues(
          alpha: 0.12,
        ),
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

  Widget _valueLine(
    String label,
    String value,
  ) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
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
        body: Center(
          child: CircularProgressIndicator(),
        ),
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
          style: TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      floatingActionButton:
          FloatingActionButton.extended(
        onPressed: () {
          _openRecordForm();
        },
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text(
          'Add KPI',
          style: TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
          16,
          16,
          16,
          100,
        ),
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
              'Add your first objective and KPI to '
              'start tracking HSE performance.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: () {
                _openRecordForm();
              },
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
            const Icon(
              Icons.search_off,
              size: 42,
            ),
            const SizedBox(height: 10),
            const Text(
              'No matching KPI records',
              style: TextStyle(
                fontWeight: FontWeight.w800,
              ),
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
  State<_KpiFormSheet> createState() =>
      _KpiFormSheetState();
}

class _KpiFormSheetState
    extends State<_KpiFormSheet> {
  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>();

  late final TextEditingController
      _objectiveController;
  late final TextEditingController _kpiController;
  late final TextEditingController
      _targetController;
  late final TextEditingController
      _actualController;
  late final TextEditingController
      _periodController;
  late final TextEditingController
      _ownerController;
  late final TextEditingController
      _remarksController;

  late String _category;
  late String _type;
  late String _status;

  @override
  void initState() {
    super.initState();

    final record = widget.record;

    _objectiveController =
        TextEditingController(
      text:
          record?['objective']?.toString() ?? '',
    );

    _kpiController =
        TextEditingController(
      text:
          record?['kpiName']?.toString() ?? '',
    );

    _targetController =
        TextEditingController(
      text:
          record?['target']?.toString() ?? '',
    );

    _actualController =
        TextEditingController(
      text:
          record?['actual']?.toString() ?? '',
    );

    _periodController =
        TextEditingController(
      text:
          record?['period']?.toString() ?? '',
    );

    _ownerController =
        TextEditingController(
      text:
          record?['owner']?.toString() ?? '',
    );

    _remarksController =
        TextEditingController(
      text:
          record?['remarks']?.toString() ?? '',
    );

    _category =
        widget.categories.contains(
      record?['category'],
    )
            ? record!['category'].toString()
            : widget.categories.first;

    _type =
        widget.types.contains(
      record?['type'],
    )
            ? record!['type'].toString()
            : widget.types.first;

    _status =
        widget.statuses.contains(
      record?['status'],
    )
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

  InputDecoration _decoration(
    String label, {
    String? hint,
  }) {
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
        borderSide: BorderSide(
          color: Colors.grey.shade300,
        ),
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
      padding: const EdgeInsets.only(
        bottom: 12,
      ),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: keyboardType,
        decoration: _decoration(
          label,
          hint: hint,
        ),
        validator: required
            ? (value) {
                if (value == null ||
                    value.trim().isEmpty) {
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
      padding: const EdgeInsets.only(
        bottom: 12,
      ),
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
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final target = double.tryParse(
      _targetController.text.trim(),
    );

    final actualText =
        _actualController.text.trim();

    final actual = actualText.isEmpty
        ? null
        : double.tryParse(actualText);

    if (target == null || target < 0) {
      _message(
        'Enter a valid target value.',
      );
      return;
    }

    if (_status != 'Not Measured') {
      if (actual == null || actual < 0) {
        _message(
          'Enter a valid actual value.',
        );
        return;
      }
    }

    final existingId =
        widget.record?['id']?.toString();

    final id = existingId == null ||
            existingId.isEmpty
        ? DateTime.now()
            .microsecondsSinceEpoch
            .toString()
        : existingId;

    final record = <String, dynamic>{
      'id': id,
      'objective':
          _objectiveController.text.trim(),
      'kpiName':
          _kpiController.text.trim(),
      'category': _category,
      'type': _type,
      'target': target,
      'actual': actual,
      'period':
          _periodController.text.trim(),
      'owner':
          _ownerController.text.trim(),
      'status': _status,
      'remarks':
          _remarksController.text.trim(),
      'updatedAt':
          DateTime.now().toIso8601String(),
    };

    Navigator.pop(context, record);
  }

  void _message(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(
        content: Text(message),
        behavior:
            SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottom =
        MediaQuery.viewInsetsOf(context).bottom;

    return SafeArea(
      child: Container(
        height:
            MediaQuery.sizeOf(context).height *
                0.92,
        padding: EdgeInsets.fromLTRB(
          16,
          10,
          16,
          bottom + 16,
        ),
        decoration:
            const BoxDecoration(
          color: Color(0xFFF6F8F7),
          borderRadius:
              BorderRadius.vertical(
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
                  decoration:
                      BoxDecoration(
                    color: Colors.grey,
                    borderRadius:
                        BorderRadius.circular(
                      10,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Text(
                widget.record == null
                    ? 'Add HSE KPI'
                    : 'Edit HSE KPI',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight:
                      FontWeight.w900,
                  color: Color(0xFF0B5D4B),
                ),
              ),
              const SizedBox(height: 16),
              _field(
                _objectiveController,
                'HSE Objective',
                required: true,
                maxLines: 3,
                hint:
                    'Example: Improve site safety performance',
              ),
              _field(
                _kpiController,
                'KPI Name',
                required: true,
                hint:
                    'Example: Monthly Safety Inspection Completion',
              ),
              _dropdown(
                'KPI Category',
                _category,
                widget.categories,
                (value) {
                  if (value != null) {
                    setState(() {
                      _category = value;
                    });
                  }
                },
              ),
              _dropdown(
                'KPI Type',
                _type,
                widget.types,
                (value) {
                  if (value != null) {
                    setState(() {
                      _type = value;
                    });
                  }
                },
              ),
              _field(
                _targetController,
                'Target Value',
                required: true,
                keyboardType:
                    const TextInputType
                        .numberWithOptions(
                  decimal: true,
                ),
                hint: 'Example: 95',
              ),
              _field(
                _actualController,
                'Actual Value',
                required:
                    false,
                keyboardType:
                    const TextInputType
                        .numberWithOptions(
                  decimal: true,
                ),
                hint:
                    'Example: 92 (leave blank if Not Measured)',
              ),
              _dropdown(
                'Performance Status',
                _status,
                widget.statuses,
                (value) {
                  if (value != null) {
                    setState(() {
                      _status = value;
                    });
                  }
                },
              ),
              _field(
                _periodController,
                'Measurement Period',
                required: true,
                hint:
                    'Example: September 2026',
              ),
              _field(
                _ownerController,
                'KPI Owner',
                required: true,
              ),
              _field(
                _remarksController,
                'Remarks / Action',
                maxLines: 4,
                hint:
                    'Record explanation, action or follow-up.',
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 52,
                child: FilledButton.icon(
                  onPressed: _submit,
                  icon: const Icon(
                    Icons.save_outlined,
                  ),
                  label: Text(
                    widget.record == null
                        ? 'Save KPI'
                        : 'Update KPI',
                    style:
                        const TextStyle(
                      fontWeight:
                          FontWeight.w800,
                    ),
                  ),
                  style:
                      FilledButton.styleFrom(
                    backgroundColor:
                        const Color(
                      0xFF159447,
                    ),
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

// ===============================================================
// MERGED LEGACY MODULE
// Source: safenexus_step48_objectives_improvement.dart
// Purpose: preserve audited Step functionality inside the canonical module.
// ===============================================================
class Merged48ObjectivesimprovementSafeNexusStep48ObjectivesImprovementPage extends StatefulWidget {
  const Merged48ObjectivesimprovementSafeNexusStep48ObjectivesImprovementPage({super.key});

  @override
  State<Merged48ObjectivesimprovementSafeNexusStep48ObjectivesImprovementPage> createState() =>
      _Merged48ObjectivesimprovementSafeNexusStep48ObjectivesImprovementPageState();
}

class _Merged48ObjectivesimprovementSafeNexusStep48ObjectivesImprovementPageState
    extends State<Merged48ObjectivesimprovementSafeNexusStep48ObjectivesImprovementPage> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);
  static const String storageKey =
      'safenexus_hse_step48_objectives_improvement';

  final List<Map<String, dynamic>> _Merged48Objectivesimprovementrecords = <Map<String, dynamic>>[];

  String _Merged48Objectivesimprovementsearch = '';
  String _Merged48ObjectivesimprovementstatusFilter = 'All';
  String _Merged48ObjectivesimprovementcategoryFilter = 'All';

  final List<String> _Merged48Objectivesimprovementstatuses = <String>[
    'Planned',
    'In Progress',
    'At Risk',
    'Completed',
    'Closed',
  ];

  final List<String> _Merged48Objectivesimprovementcategories = <String>[
    'Objective',
    'Strategic Priority',
    'KPI Target',
    'Improvement Initiative',
    'Improvement Action',
    'Resource Plan',
  ];

  @override
  void initState() {
    super.initState();
    _Merged48ObjectivesimprovementloadRecords();
  }

  Future<void> _Merged48ObjectivesimprovementloadRecords() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> saved = prefs.getStringList(storageKey) ?? <String>[];

    if (!mounted) return;

    setState(() {
      _Merged48Objectivesimprovementrecords
        ..clear()
        ..addAll(
          saved.map(
            (String title) => <String, dynamic>{
              'id': DateTime.now().microsecondsSinceEpoch.toString(),
              'title': title,
              'category': 'Objective',
              'status': 'Planned',
              'priority': 'Medium',
              'owner': '',
              'target': '',
              'current': '',
              'dueDate': '',
              'strategy': '',
              'gap': '',
              'actions': '',
              'resources': '',
              'verification': '',
              'notes': '',
              'createdAt': DateTime.now().toIso8601String(),
            },
          ),
        );
    });
  }

  Future<void> _Merged48ObjectivesimprovementsaveRecords() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> titles =
        _Merged48Objectivesimprovementrecords.map((Map<String, dynamic> e) => e['title'] as String).toList();
    await prefs.setStringList(storageKey, titles);
  }

  List<Map<String, dynamic>> get _Merged48ObjectivesimprovementfilteredRecords {
    return _Merged48Objectivesimprovementrecords.where((Map<String, dynamic> item) {
      final String searchable = <String>[
        item['title'],
        item['category'],
        item['status'],
        item['owner'],
        item['strategy'],
        item['actions'],
      ].join(' ').toLowerCase();

      final bool matchesSearch =
          _Merged48Objectivesimprovementsearch.trim().isEmpty || searchable.contains(_Merged48Objectivesimprovementsearch.toLowerCase());
      final bool matchesStatus =
          _Merged48ObjectivesimprovementstatusFilter == 'All' || item['status'] == _Merged48ObjectivesimprovementstatusFilter;
      final bool matchesCategory =
          _Merged48ObjectivesimprovementcategoryFilter == 'All' || item['category'] == _Merged48ObjectivesimprovementcategoryFilter;

      return matchesSearch && matchesStatus && matchesCategory;
    }).toList();
  }

  int _Merged48ObjectivesimprovementcountStatus(String status) {
    return _Merged48Objectivesimprovementrecords
        .where((Map<String, dynamic> item) => item['status'] == status)
        .length;
  }

  int _Merged48ObjectivesimprovementcountCategory(String category) {
    return _Merged48Objectivesimprovementrecords
        .where((Map<String, dynamic> item) => item['category'] == category)
        .length;
  }

  Future<void> _Merged48ObjectivesimprovementaddOrEdit({Map<String, dynamic>? existing}) async {
    final Map<String, dynamic>? result =
        await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (BuildContext context) =>
          _Merged48ObjectivesimprovementObjectiveFormDialog(existing: existing),
    );

    if (result == null) return;

    setState(() {
      if (existing == null) {
        _Merged48Objectivesimprovementrecords.insert(0, <String, dynamic>{
          ...result,
          'id': DateTime.now().microsecondsSinceEpoch.toString(),
          'createdAt': DateTime.now().toIso8601String(),
        });
      } else {
        final int index = _Merged48Objectivesimprovementrecords.indexOf(existing);
        if (index >= 0) {
          _Merged48Objectivesimprovementrecords[index] = <String, dynamic>{
            ...existing,
            ...result,
          };
        }
      }
    });

    await _Merged48ObjectivesimprovementsaveRecords();
  }

  Future<void> _Merged48Objectivesimprovementdelete(Map<String, dynamic> item) async {
    setState(() => _Merged48Objectivesimprovementrecords.remove(item));
    await _Merged48ObjectivesimprovementsaveRecords();
  }

  Future<void> _Merged48ObjectivesimprovementconfirmDelete(Map<String, dynamic> item) async {
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Delete Record?'),
        content: const Text(
          'This objective or improvement record will be deleted.',
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
      await _Merged48Objectivesimprovementdelete(item);
    }
  }

  void _Merged48ObjectivesimprovementshowDashboard() {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('48L — Strategy & Improvement Dashboard'),
        content: SizedBox(
          width: 430,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _Merged48ObjectivesimprovementmetricRow('Total Records', _Merged48Objectivesimprovementrecords.length),
                _Merged48ObjectivesimprovementmetricRow('Planned', _Merged48ObjectivesimprovementcountStatus('Planned')),
                _Merged48ObjectivesimprovementmetricRow('In Progress', _Merged48ObjectivesimprovementcountStatus('In Progress')),
                _Merged48ObjectivesimprovementmetricRow('At Risk', _Merged48ObjectivesimprovementcountStatus('At Risk')),
                _Merged48ObjectivesimprovementmetricRow('Completed', _Merged48ObjectivesimprovementcountStatus('Completed')),
                _Merged48ObjectivesimprovementmetricRow('Closed', _Merged48ObjectivesimprovementcountStatus('Closed')),
                const Divider(),
                _Merged48ObjectivesimprovementmetricRow('Objectives', _Merged48ObjectivesimprovementcountCategory('Objective')),
                _Merged48ObjectivesimprovementmetricRow(
                  'Improvement Initiatives',
                  _Merged48ObjectivesimprovementcountCategory('Improvement Initiative'),
                ),
                _Merged48ObjectivesimprovementmetricRow(
                  'Improvement Actions',
                  _Merged48ObjectivesimprovementcountCategory('Improvement Action'),
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

  Widget _Merged48ObjectivesimprovementmetricRow(String label, int value) {
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

  void _Merged48ObjectivesimprovementshowGuide() {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Step 48 — Objectives & Improvement Guide'),
        content: const SingleChildScrollView(
          child: Text(
            'Set Objectives → Plan → Target → Measure → Identify Gap → '
            'Improve → Allocate Resources → Verify → Review → Close → Learn\n\n'
            '48A HSE Objectives Master\n'
            '48B HSE Strategy & Strategic Priorities\n'
            '48C Annual / Monthly HSE Targets\n'
            '48D KPI & Target Monitoring\n'
            '48E Improvement Initiative Management\n'
            '48F HSE Action / Improvement Plan\n'
            '48G Resource & Budget Planning\n'
            '48H Performance Gap & Opportunity Analysis\n'
            '48I Continual Improvement Verification\n'
            '48J Objective Review & Closure\n'
            '48K Improvement History / Audit Trail\n'
            '48L HSE Strategy & Improvement Intelligence Dashboard\n\n'
            'Designed for UAE-wide HSE objectives, measurable targets, '
            'continual improvement and management performance alignment.',
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
    final List<Map<String, dynamic>> records = _Merged48ObjectivesimprovementfilteredRecords;

    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
        title: const Text('Step 48 • Objectives & Improvement'),
        actions: <Widget>[
          IconButton(
            tooltip: 'Guide',
            onPressed: _Merged48ObjectivesimprovementshowGuide,
            icon: const Icon(Icons.help_outline),
          ),
          IconButton(
            tooltip: 'Dashboard',
            onPressed: _Merged48ObjectivesimprovementshowDashboard,
            icon: const Icon(Icons.dashboard_outlined),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        onPressed: () => _Merged48ObjectivesimprovementaddOrEdit(),
        icon: const Icon(Icons.add),
        label: const Text('New Objective'),
      ),
      body: Column(
        children: <Widget>[
          _Merged48Objectivesimprovementheader(),
          _Merged48Objectivesimprovementfilters(),
          Expanded(
            child: records.isEmpty
                ? _Merged48ObjectivesimprovementemptyState()
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(12, 4, 12, 90),
                    itemCount: records.length,
                    itemBuilder: (BuildContext context, int index) {
                      return _Merged48ObjectivesimprovementrecordCard(records[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _Merged48Objectivesimprovementheader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'HSE Objectives, Strategy & Continual Improvement Center',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: darkGreen,
            ),
          ),
          SizedBox(height: 5),
          Text(
            'ലക്ഷ്യങ്ങൾ • Strategy • KPI • Improvement • Continual Improvement',
            style: TextStyle(fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _Merged48Objectivesimprovementfilters() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: <Widget>[
          TextField(
            onChanged: (String value) => setState(() => _Merged48Objectivesimprovementsearch = value),
            decoration: InputDecoration(
              hintText: 'Search objectives, owners, strategy, actions...',
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
                  initialValue: _Merged48ObjectivesimprovementstatusFilter,
                  decoration: const InputDecoration(
                    labelText: 'Status',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                  ),
                  items: <String>['All', ..._Merged48Objectivesimprovementstatuses]
                      .map(
                        (String value) => DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        ),
                      )
                      .toList(),
                  onChanged: (String? value) {
                    if (value != null) {
                      setState(() => _Merged48ObjectivesimprovementstatusFilter = value);
                    }
                  },
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: DropdownButtonFormField<String>(
                  initialValue: _Merged48ObjectivesimprovementcategoryFilter,
                  decoration: const InputDecoration(
                    labelText: 'Category',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                  ),
                  items: <String>['All', ..._Merged48Objectivesimprovementcategories]
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
                      setState(() => _Merged48ObjectivesimprovementcategoryFilter = value);
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

  Widget _Merged48ObjectivesimprovementrecordCard(Map<String, dynamic> item) {
    final String title = item['title'] as String? ?? 'Untitled';
    final String category = item['category'] as String? ?? 'Objective';
    final String status = item['status'] as String? ?? 'Planned';
    final String owner = item['owner'] as String? ?? '';
    final String target = item['target'] as String? ?? '';
    final String dueDate = item['dueDate'] as String? ?? '';

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 1,
      child: ExpansionTile(
        leading: CircleAvatar(
          backgroundColor: primaryGreen.withValues(alpha: 0.12),
          child: const Icon(
            Icons.track_changes_outlined,
            color: darkGreen,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          '$category • $status${dueDate.isEmpty ? '' : ' • $dueDate'}',
        ),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
        children: <Widget>[
          if (owner.isNotEmpty) _Merged48ObjectivesimprovementdetailLine('Owner', owner),
          if (target.isNotEmpty) _Merged48ObjectivesimprovementdetailLine('Target', target),
          _Merged48ObjectivesimprovementdetailLine(
            'Workflow',
            'Set → Plan → Measure → Improve → Verify → Review → Close',
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              IconButton(
                tooltip: 'Edit',
                onPressed: () => _Merged48ObjectivesimprovementaddOrEdit(existing: item),
                icon: const Icon(Icons.edit_outlined),
              ),
              IconButton(
                tooltip: 'Delete',
                onPressed: () => _Merged48ObjectivesimprovementconfirmDelete(item),
                icon: const Icon(Icons.delete_outline),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _Merged48ObjectivesimprovementdetailLine(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 135,
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

  Widget _Merged48ObjectivesimprovementemptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.track_changes_outlined,
              size: 62,
              color: darkGreen.withValues(alpha: 0.45),
            ),
            const SizedBox(height: 12),
            const Text(
              'No objectives or improvement records found',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Create the first HSE objective or improvement initiative.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _Merged48ObjectivesimprovementObjectiveFormDialog extends StatefulWidget {
  const _Merged48ObjectivesimprovementObjectiveFormDialog({this.existing});

  final Map<String, dynamic>? existing;

  @override
  State<_Merged48ObjectivesimprovementObjectiveFormDialog> createState() => _Merged48ObjectivesimprovementObjectiveFormDialogState();
}

class _Merged48ObjectivesimprovementObjectiveFormDialogState extends State<_Merged48ObjectivesimprovementObjectiveFormDialog> {
  final GlobalKey<FormState> _Merged48ObjectivesimprovementformKey = GlobalKey<FormState>();

  late final TextEditingController _Merged48Objectivesimprovementtitle;
  late final TextEditingController _Merged48Objectivesimprovementowner;
  late final TextEditingController _Merged48Objectivesimprovementtarget;
  late final TextEditingController _Merged48Objectivesimprovementcurrent;
  late final TextEditingController _Merged48ObjectivesimprovementdueDate;
  late final TextEditingController _Merged48Objectivesimprovementstrategy;
  late final TextEditingController _Merged48Objectivesimprovementgap;
  late final TextEditingController _Merged48Objectivesimprovementactions;
  late final TextEditingController _Merged48Objectivesimprovementresources;
  late final TextEditingController _Merged48Objectivesimprovementverification;
  late final TextEditingController _Merged48Objectivesimprovementnotes;

  String _Merged48Objectivesimprovementcategory = 'Objective';
  String _Merged48Objectivesimprovementstatus = 'Planned';
  String _Merged48Objectivesimprovementpriority = 'Medium';

  final List<String> _Merged48Objectivesimprovementcategories = <String>[
    'Objective',
    'Strategic Priority',
    'KPI Target',
    'Improvement Initiative',
    'Improvement Action',
    'Resource Plan',
  ];

  final List<String> _Merged48Objectivesimprovementstatuses = <String>[
    'Planned',
    'In Progress',
    'At Risk',
    'Completed',
    'Closed',
  ];

  final List<String> _Merged48Objectivesimprovementpriorities = <String>[
    'Low',
    'Medium',
    'High',
    'Critical',
  ];

  @override
  void initState() {
    super.initState();

    final Map<String, dynamic> e = widget.existing ?? <String, dynamic>{};

    _Merged48Objectivesimprovementtitle = TextEditingController(text: e['title'] as String? ?? '');
    _Merged48Objectivesimprovementowner = TextEditingController(text: e['owner'] as String? ?? '');
    _Merged48Objectivesimprovementtarget = TextEditingController(text: e['target'] as String? ?? '');
    _Merged48Objectivesimprovementcurrent = TextEditingController(text: e['current'] as String? ?? '');
    _Merged48ObjectivesimprovementdueDate = TextEditingController(text: e['dueDate'] as String? ?? '');
    _Merged48Objectivesimprovementstrategy = TextEditingController(text: e['strategy'] as String? ?? '');
    _Merged48Objectivesimprovementgap = TextEditingController(text: e['gap'] as String? ?? '');
    _Merged48Objectivesimprovementactions = TextEditingController(text: e['actions'] as String? ?? '');
    _Merged48Objectivesimprovementresources = TextEditingController(text: e['resources'] as String? ?? '');
    _Merged48Objectivesimprovementverification =
        TextEditingController(text: e['verification'] as String? ?? '');
    _Merged48Objectivesimprovementnotes = TextEditingController(text: e['notes'] as String? ?? '');

    _Merged48Objectivesimprovementcategory = e['category'] as String? ?? 'Objective';
    _Merged48Objectivesimprovementstatus = e['status'] as String? ?? 'Planned';
    _Merged48Objectivesimprovementpriority = e['priority'] as String? ?? 'Medium';
  }

  @override
  void dispose() {
    _Merged48Objectivesimprovementtitle.dispose();
    _Merged48Objectivesimprovementowner.dispose();
    _Merged48Objectivesimprovementtarget.dispose();
    _Merged48Objectivesimprovementcurrent.dispose();
    _Merged48ObjectivesimprovementdueDate.dispose();
    _Merged48Objectivesimprovementstrategy.dispose();
    _Merged48Objectivesimprovementgap.dispose();
    _Merged48Objectivesimprovementactions.dispose();
    _Merged48Objectivesimprovementresources.dispose();
    _Merged48Objectivesimprovementverification.dispose();
    _Merged48Objectivesimprovementnotes.dispose();
    super.dispose();
  }

  InputDecoration _Merged48Objectivesimprovementdecoration(String label, IconData icon) {
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
            ? 'New HSE Objective / Improvement'
            : 'Edit HSE Objective / Improvement',
      ),
      content: SizedBox(
        width: 520,
        child: Form(
          key: _Merged48ObjectivesimprovementformKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: _Merged48Objectivesimprovementtitle,
                  decoration:
                      _Merged48Objectivesimprovementdecoration('Objective / Initiative Title *', Icons.title),
                  validator: (String? value) =>
                      value == null || value.trim().isEmpty
                          ? 'Enter a title'
                          : null,
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  initialValue: _Merged48Objectivesimprovementcategory,
                  decoration:
                      _Merged48Objectivesimprovementdecoration('Category', Icons.category_outlined),
                  items: _Merged48Objectivesimprovementcategories
                      .map(
                        (String value) => DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        ),
                      )
                      .toList(),
                  onChanged: (String? value) {
                    if (value != null) setState(() => _Merged48Objectivesimprovementcategory = value);
                  },
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  initialValue: _Merged48Objectivesimprovementstatus,
                  decoration:
                      _Merged48Objectivesimprovementdecoration('Status', Icons.flag_outlined),
                  items: _Merged48Objectivesimprovementstatuses
                      .map(
                        (String value) => DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        ),
                      )
                      .toList(),
                  onChanged: (String? value) {
                    if (value != null) setState(() => _Merged48Objectivesimprovementstatus = value);
                  },
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  initialValue: _Merged48Objectivesimprovementpriority,
                  decoration:
                      _Merged48Objectivesimprovementdecoration('Priority', Icons.priority_high_outlined),
                  items: _Merged48Objectivesimprovementpriorities
                      .map(
                        (String value) => DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        ),
                      )
                      .toList(),
                  onChanged: (String? value) {
                    if (value != null) setState(() => _Merged48Objectivesimprovementpriority = value);
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _Merged48Objectivesimprovementowner,
                  decoration:
                      _Merged48Objectivesimprovementdecoration('Owner / Responsible Person', Icons.person_outline),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _Merged48Objectivesimprovementstrategy,
                  maxLines: 2,
                  decoration:
                      _Merged48Objectivesimprovementdecoration('48B Strategy / Strategic Priority', Icons.explore_outlined),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _Merged48Objectivesimprovementtarget,
                  decoration:
                      _Merged48Objectivesimprovementdecoration('48C Target / KPI Target', Icons.flag_circle_outlined),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _Merged48Objectivesimprovementcurrent,
                  decoration:
                      _Merged48Objectivesimprovementdecoration('48D Current Performance / Measure', Icons.analytics_outlined),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _Merged48Objectivesimprovementgap,
                  maxLines: 2,
                  decoration:
                      _Merged48Objectivesimprovementdecoration('48H Performance Gap / Opportunity', Icons.compare_arrows_outlined),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _Merged48Objectivesimprovementactions,
                  maxLines: 3,
                  decoration:
                      _Merged48Objectivesimprovementdecoration('48F Improvement Action Plan', Icons.task_alt_outlined),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _Merged48Objectivesimprovementresources,
                  maxLines: 2,
                  decoration:
                      _Merged48Objectivesimprovementdecoration('48G Resources / Budget Requirement', Icons.account_balance_outlined),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _Merged48Objectivesimprovementverification,
                  maxLines: 2,
                  decoration:
                      _Merged48Objectivesimprovementdecoration('48I Verification / Effectiveness', Icons.verified_outlined),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _Merged48ObjectivesimprovementdueDate,
                  decoration:
                      _Merged48Objectivesimprovementdecoration('Target / Review Date', Icons.event_available_outlined),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _Merged48Objectivesimprovementnotes,
                  maxLines: 3,
                  decoration:
                      _Merged48Objectivesimprovementdecoration('48J / 48K Review Notes & History', Icons.notes_outlined),
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
          onPressed: _Merged48Objectivesimprovementsubmit,
          icon: const Icon(Icons.save_outlined),
          label: const Text('Save'),
        ),
      ],
    );
  }

  void _Merged48Objectivesimprovementsubmit() {
    if (!_Merged48ObjectivesimprovementformKey.currentState!.validate()) return;

    Navigator.pop(context, <String, dynamic>{
      'title': _Merged48Objectivesimprovementtitle.text.trim(),
      'category': _Merged48Objectivesimprovementcategory,
      'status': _Merged48Objectivesimprovementstatus,
      'priority': _Merged48Objectivesimprovementpriority,
      'owner': _Merged48Objectivesimprovementowner.text.trim(),
      'target': _Merged48Objectivesimprovementtarget.text.trim(),
      'current': _Merged48Objectivesimprovementcurrent.text.trim(),
      'dueDate': _Merged48ObjectivesimprovementdueDate.text.trim(),
      'strategy': _Merged48Objectivesimprovementstrategy.text.trim(),
      'gap': _Merged48Objectivesimprovementgap.text.trim(),
      'actions': _Merged48Objectivesimprovementactions.text.trim(),
      'resources': _Merged48Objectivesimprovementresources.text.trim(),
      'verification': _Merged48Objectivesimprovementverification.text.trim(),
      'notes': _Merged48Objectivesimprovementnotes.text.trim(),
    });
  }
}

