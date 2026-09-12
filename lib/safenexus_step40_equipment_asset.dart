import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// SafeNexus HSE - Step 40
/// HSE Equipment & Asset Management Center
///
/// Workflow:
/// Register → Inspect → Certify → Maintain → Verify → Deploy → Monitor
/// → Repair/Calibrate → Renew → Close → Analyze
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
///
/// No new dependency beyond SharedPreferences.

class SafeNexusStep40EquipmentAssetPage extends StatefulWidget {
  const SafeNexusStep40EquipmentAssetPage({
    super.key,
    this.sourceOpener,
  });

  final void Function(String referenceType, String referenceId)? sourceOpener;

  @override
  State<SafeNexusStep40EquipmentAssetPage> createState() =>
      _SafeNexusStep40EquipmentAssetPageState();
}

class _SafeNexusStep40EquipmentAssetPageState
    extends State<SafeNexusStep40EquipmentAssetPage> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);
  static const String storageKey =
      'safenexus_hse_step40_equipment_asset';

  final TextEditingController _searchController = TextEditingController();

  final List<String> _assetTypes = const [
    'Lifting Equipment',
    'Mobile Plant',
    'Vehicle',
    'Power Tool',
    'Hand Tool',
    'Electrical Equipment',
    'Fire & Emergency Equipment',
    'Gas Detection Equipment',
    'PPE / Safety Equipment',
    'Scaffold / Access Equipment',
    'Calibration Equipment',
    'Other',
  ];

  final List<String> _statuses = const [
    'Active',
    'Under Inspection',
    'Under Maintenance',
    'Repair Required',
    'Quarantined',
    'Expired',
    'Retired',
  ];

  final List<String> _conditionOptions = const [
    'Good',
    'Fair',
    'Poor',
    'Critical',
  ];

  final List<String> _inspectionOptions = const [
    'Valid',
    'Due Soon',
    'Overdue',
    'Not Required',
  ];

  final List<String> _maintenanceOptions = const [
    'Up to Date',
    'Due Soon',
    'Overdue',
    'Not Required',
  ];

  final List<String> _verificationOptions = const [
    'Verified',
    'Pending',
    'Failed',
  ];

  List<Map<String, dynamic>> _assets = [];
  List<Map<String, dynamic>> _history = [];

  String _statusFilter = 'All';
  String _typeFilter = 'All';
  String _conditionFilter = 'All';
  String _inspectionFilter = 'All';

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
    final assetRaw = prefs.getString(storageKey);
    final historyRaw = prefs.getString('${storageKey}_history');

    if (!mounted) return;

    setState(() {
      _assets = _decodeList(assetRaw);
      _history = _decodeList(historyRaw);
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
      // Keep local storage resilient if an older/corrupt record exists.
    }
    return [];
  }

  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(storageKey, jsonEncode(_assets));
    await prefs.setString('${storageKey}_history', jsonEncode(_history));
  }

  void _refreshView() {
    if (mounted) setState(() {});
  }

  String _newId() {
    return 'EQ40-${DateTime.now().millisecondsSinceEpoch}';
  }

  String _now() => DateTime.now().toIso8601String();

  List<Map<String, dynamic>> get _filteredAssets {
    final query = _searchController.text.trim().toLowerCase();

    return _assets.where((asset) {
      final matchesQuery = query.isEmpty ||
          _value(asset, 'assetId').toLowerCase().contains(query) ||
          _value(asset, 'assetName').toLowerCase().contains(query) ||
          _value(asset, 'location').toLowerCase().contains(query) ||
          _value(asset, 'owner').toLowerCase().contains(query) ||
          _value(asset, 'manufacturer').toLowerCase().contains(query);

      final matchesStatus =
          _statusFilter == 'All' || _value(asset, 'status') == _statusFilter;
      final matchesType =
          _typeFilter == 'All' || _value(asset, 'assetType') == _typeFilter;
      final matchesCondition = _conditionFilter == 'All' ||
          _value(asset, 'condition') == _conditionFilter;
      final matchesInspection = _inspectionFilter == 'All' ||
          _inspectionState(asset) == _inspectionFilter;

      return matchesQuery &&
          matchesStatus &&
          matchesType &&
          matchesCondition &&
          matchesInspection;
    }).toList();
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

  String _inspectionState(Map<String, dynamic> asset) {
    final status = _value(asset, 'inspectionStatus');
    if (status == 'Not Required') return status;

    final date = _parseDate(asset['nextInspection']);
    if (date == null) return status.isEmpty ? 'Due Soon' : status;

    final today = DateTime.now();
    final dateOnly = DateTime(date.year, date.month, date.day);
    final todayOnly = DateTime(today.year, today.month, today.day);
    final days = dateOnly.difference(todayOnly).inDays;

    if (days < 0) return 'Overdue';
    if (days <= 30) return 'Due Soon';
    return 'Valid';
  }

  bool _isDateAttention(dynamic value) {
    final date = _parseDate(value);
    if (date == null) return false;
    return date.difference(DateTime.now()).inDays <= 30;
  }

  int _countWhere(bool Function(Map<String, dynamic>) test) {
    return _assets.where(test).length;
  }

  int get _activeCount =>
      _countWhere((asset) => _value(asset, 'status') == 'Active');

  int get _maintenanceCount => _countWhere(
      (asset) => _value(asset, 'status') == 'Under Maintenance');

  int get _repairCount => _countWhere(
      (asset) => _value(asset, 'status') == 'Repair Required');

  int get _quarantineCount =>
      _countWhere((asset) => _value(asset, 'status') == 'Quarantined');

  int get _inspectionDueCount => _countWhere(
      (asset) => _inspectionState(asset) == 'Due Soon');

  int get _inspectionOverdueCount => _countWhere(
      (asset) => _inspectionState(asset) == 'Overdue');

  int get _expiredCount =>
      _countWhere((asset) => _value(asset, 'status') == 'Expired');

  int get _verificationPendingCount => _countWhere(
      (asset) => _value(asset, 'verificationStatus') == 'Pending');

  int get _totalCost {
    return _assets.fold<int>(0, (sum, asset) {
      final value = num.tryParse(_value(asset, 'maintenanceCost')) ?? 0;
      return sum + value.round();
    });
  }

  Future<void> _addAsset() async {
    final result = await _showAssetDialog();
    if (result == null) return;

    final asset = <String, dynamic>{
      ...result,
      'assetId': _newId(),
      'createdAt': _now(),
      'updatedAt': _now(),
    };

    setState(() {
      _assets.insert(0, asset);
      _history.insert(0, {
        'action': 'Created',
        'assetId': asset['assetId'],
        'assetName': asset['assetName'],
        'timestamp': _now(),
        'details': 'Equipment / asset registered.',
      });
    });

    await _saveData();
  }

  Future<void> _editAsset(Map<String, dynamic> asset) async {
    final result = await _showAssetDialog(existing: asset);
    if (result == null) return;

    final index = _assets.indexWhere(
      (item) => _value(item, 'assetId') == _value(asset, 'assetId'),
    );
    if (index < 0) return;

    final updated = <String, dynamic>{
      ...asset,
      ...result,
      'updatedAt': _now(),
    };

    setState(() {
      _assets[index] = updated;
      _history.insert(0, {
        'action': 'Updated',
        'assetId': updated['assetId'],
        'assetName': updated['assetName'],
        'timestamp': _now(),
        'details': 'Equipment / asset record updated.',
      });
    });

    await _saveData();
  }

  Future<void> _deleteAsset(Map<String, dynamic> asset) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Asset'),
        content: Text(
          'Delete ${_value(asset, 'assetName')} (${_value(asset, 'assetId')})?',
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
      _assets.removeWhere(
        (item) => _value(item, 'assetId') == _value(asset, 'assetId'),
      );
      _history.insert(0, {
        'action': 'Deleted',
        'assetId': asset['assetId'],
        'assetName': asset['assetName'],
        'timestamp': _now(),
        'details': 'Equipment / asset record deleted.',
      });
    });

    await _saveData();
  }

  Future<Map<String, dynamic>?> _showAssetDialog({
    Map<String, dynamic>? existing,
  }) async {
    final nameController =
        TextEditingController(text: _value(existing ?? {}, 'assetName'));
    final manufacturerController =
        TextEditingController(text: _value(existing ?? {}, 'manufacturer'));
    final modelController =
        TextEditingController(text: _value(existing ?? {}, 'model'));
    final serialController =
        TextEditingController(text: _value(existing ?? {}, 'serialNumber'));
    final locationController =
        TextEditingController(text: _value(existing ?? {}, 'location'));
    final ownerController =
        TextEditingController(text: _value(existing ?? {}, 'owner'));
    final certificateController =
        TextEditingController(text: _value(existing ?? {}, 'certificateNo'));
    final inspectionController =
        TextEditingController(text: _value(existing ?? {}, 'nextInspection'));
    final maintenanceController =
        TextEditingController(text: _value(existing ?? {}, 'nextMaintenance'));
    final costController =
        TextEditingController(text: _value(existing ?? {}, 'maintenanceCost'));
    final notesController =
        TextEditingController(text: _value(existing ?? {}, 'notes'));

    String type = _value(existing ?? {}, 'assetType');
    String status = _value(existing ?? {}, 'status');
    String condition = _value(existing ?? {}, 'condition');
    String inspectionStatus = _value(existing ?? {}, 'inspectionStatus');
    String maintenanceStatus = _value(existing ?? {}, 'maintenanceStatus');
    String verificationStatus =
        _value(existing ?? {}, 'verificationStatus');

    if (!_assetTypes.contains(type)) type = _assetTypes.first;
    if (!_statuses.contains(status)) status = _statuses.first;
    if (!_conditionOptions.contains(condition)) condition = 'Good';
    if (!_inspectionOptions.contains(inspectionStatus)) {
      inspectionStatus = 'Valid';
    }
    if (!_maintenanceOptions.contains(maintenanceStatus)) {
      maintenanceStatus = 'Up to Date';
    }
    if (!_verificationOptions.contains(verificationStatus)) {
      verificationStatus = 'Pending';
    }

    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text(
                existing == null ? 'Register Equipment / Asset' : 'Edit Asset',
              ),
              content: SizedBox(
                width: 620,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _dialogTextField(
                        nameController,
                        'Asset Name',
                        Icons.inventory_2_outlined,
                        required: true,
                      ),
                      const SizedBox(height: 10),
                      _dialogDropdown(
                        label: 'Asset Type',
                        value: type,
                        items: _assetTypes,
                        onChanged: (value) =>
                            setDialogState(() => type = value!),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: _dialogTextField(
                              manufacturerController,
                              'Manufacturer',
                              Icons.factory_outlined,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _dialogTextField(
                              modelController,
                              'Model',
                              Icons.category_outlined,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      _dialogTextField(
                        serialController,
                        'Serial / Registration No.',
                        Icons.confirmation_number_outlined,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: _dialogTextField(
                              locationController,
                              'Location / Site',
                              Icons.location_on_outlined,
                              required: true,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _dialogTextField(
                              ownerController,
                              'Owner / Responsible Person',
                              Icons.person_outline,
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
                              label: 'Condition',
                              value: condition,
                              items: _conditionOptions,
                              onChanged: (value) =>
                                  setDialogState(() => condition = value!),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _dialogDropdown(
                              label: 'Verification',
                              value: verificationStatus,
                              items: _verificationOptions,
                              onChanged: (value) => setDialogState(
                                () => verificationStatus = value!,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      _dialogTextField(
                        certificateController,
                        'Certificate / Inspection No.',
                        Icons.verified_outlined,
                      ),
                      const SizedBox(height: 10),
                      _dialogDropdown(
                        label: 'Inspection Status',
                        value: inspectionStatus,
                        items: _inspectionOptions,
                        onChanged: (value) =>
                            setDialogState(() => inspectionStatus = value!),
                      ),
                      const SizedBox(height: 10),
                      _dialogTextField(
                        inspectionController,
                        'Next Inspection (YYYY-MM-DD)',
                        Icons.event_outlined,
                      ),
                      const SizedBox(height: 10),
                      _dialogDropdown(
                        label: 'Maintenance Status',
                        value: maintenanceStatus,
                        items: _maintenanceOptions,
                        onChanged: (value) =>
                            setDialogState(() => maintenanceStatus = value!),
                      ),
                      const SizedBox(height: 10),
                      _dialogTextField(
                        maintenanceController,
                        'Next Maintenance (YYYY-MM-DD)',
                        Icons.build_outlined,
                      ),
                      const SizedBox(height: 10),
                      _dialogTextField(
                        costController,
                        'Maintenance Cost',
                        Icons.payments_outlined,
                        keyboardType: TextInputType.number,
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
                    if (nameController.text.trim().isEmpty ||
                        locationController.text.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Asset Name and Location / Site are required.',
                          ),
                        ),
                      );
                      return;
                    }

                    Navigator.pop(dialogContext, {
                      'assetName': nameController.text.trim(),
                      'assetType': type,
                      'manufacturer': manufacturerController.text.trim(),
                      'model': modelController.text.trim(),
                      'serialNumber': serialController.text.trim(),
                      'location': locationController.text.trim(),
                      'owner': ownerController.text.trim(),
                      'status': status,
                      'condition': condition,
                      'certificateNo': certificateController.text.trim(),
                      'inspectionStatus': inspectionStatus,
                      'nextInspection': inspectionController.text.trim(),
                      'maintenanceStatus': maintenanceStatus,
                      'nextMaintenance': maintenanceController.text.trim(),
                      'maintenanceCost': costController.text.trim(),
                      'verificationStatus': verificationStatus,
                      'notes': notesController.text.trim(),
                    });
                  },
                  icon: const Icon(Icons.save_outlined),
                  label: Text(existing == null ? 'Register' : 'Save'),
                ),
              ],
            );
          },
        );
      },
    );

    nameController.dispose();
    manufacturerController.dispose();
    modelController.dispose();
    serialController.dispose();
    locationController.dispose();
    ownerController.dispose();
    certificateController.dispose();
    inspectionController.dispose();
    maintenanceController.dispose();
    costController.dispose();
    notesController.dispose();

    return result;
  }

  Widget _dialogTextField(
    TextEditingController controller,
    String label,
    IconData icon, {
    bool required = false,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
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
              child: Text(item),
            ),
          )
          .toList(),
      onChanged: onChanged,
    );
  }

  Future<void> _showDetails(Map<String, dynamic> asset) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (context) {
        final inspectionState = _inspectionState(asset);
        return SafeArea(
          child: DraggableScrollableSheet(
            expand: false,
            initialChildSize: 0.82,
            minChildSize: 0.55,
            maxChildSize: 0.95,
            builder: (context, controller) {
              return ListView(
                controller: controller,
                padding: const EdgeInsets.fromLTRB(18, 4, 18, 24),
                children: [
                  Text(
                    _value(asset, 'assetName'),
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: darkGreen,
                        ),
                  ),
                  Text(
                    _value(asset, 'assetId'),
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 14),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _statusChip(_value(asset, 'status')),
                      _statusChip(_value(asset, 'condition')),
                      _statusChip(inspectionState),
                      _statusChip(_value(asset, 'verificationStatus')),
                    ],
                  ),
                  const SizedBox(height: 18),
                  _detailSection(
                    '40A–40L Equipment & Asset Control',
                    [
                      _detailRow('Asset Type', _value(asset, 'assetType')),
                      _detailRow('Manufacturer', _value(asset, 'manufacturer')),
                      _detailRow('Model', _value(asset, 'model')),
                      _detailRow(
                        'Serial / Registration',
                        _value(asset, 'serialNumber'),
                      ),
                      _detailRow('Location / Site', _value(asset, 'location')),
                      _detailRow('Responsible Person', _value(asset, 'owner')),
                      _detailRow(
                        'Certificate / Inspection No.',
                        _value(asset, 'certificateNo'),
                      ),
                      _detailRow(
                        'Next Inspection',
                        _formatDate(asset['nextInspection']),
                      ),
                      _detailRow(
                        'Next Maintenance',
                        _formatDate(asset['nextMaintenance']),
                      ),
                      _detailRow(
                        'Maintenance Cost',
                        _value(asset, 'maintenanceCost').isEmpty
                            ? '-'
                            : _value(asset, 'maintenanceCost'),
                      ),
                      _detailRow(
                        'Maintenance Status',
                        _value(asset, 'maintenanceStatus'),
                      ),
                      _detailRow(
                        'Verification',
                        _value(asset, 'verificationStatus'),
                      ),
                    ],
                  ),
                  if (_value(asset, 'notes').isNotEmpty) ...[
                    const SizedBox(height: 12),
                    _detailSection(
                      'HSE Remarks',
                      [
                        Text(_value(asset, 'notes')),
                      ],
                    ),
                  ],
                  const SizedBox(height: 16),
                  if (widget.sourceOpener != null)
                    OutlinedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                        widget.sourceOpener!(
                          'equipment_asset',
                          _value(asset, 'assetId'),
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
            width: 145,
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
                      'Equipment Asset History / Audit Trail',
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
                                  '${_value(item, 'assetName')}',
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

  String _formatDateTime(dynamic value) {
    final date = _parseDate(value);
    if (date == null) return '-';
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year} '
        '${date.hour.toString().padLeft(2, '0')}:'
        '${date.minute.toString().padLeft(2, '0')}';
  }

  Future<void> _showModuleGuide() async {
    final modules = <String, String>{
      '40A — Equipment / Asset Master':
          'Central register for HSE-critical equipment, tools, vehicles and plant.',
      '40B — Asset Identification & Ownership':
          'Track asset ID, serial/registration, location and responsible person.',
      '40C — Inspection & Certification':
          'Track statutory, third-party and internal inspection validity.',
      '40D — Condition & HSE Verification':
          'Record condition, verification result and quarantine status.',
      '40E — Preventive Maintenance':
          'Track planned maintenance and upcoming service dates.',
      '40F — Repair & Breakdown':
          'Capture repair-required status and return-to-service readiness.',
      '40G — Calibration Control':
          'Support calibration-controlled instruments and measurement equipment.',
      '40H — Deployment / Site Allocation':
          'Keep asset location and responsible ownership visible for field teams.',
      '40I — PPE / Safety Equipment':
          'Support controlled safety equipment and readiness checks.',
      '40J — Expiry & Renewal':
          'Surface inspection, certification and maintenance attention dates.',
      '40K — History / Audit Trail':
          'Maintain a local record of create, update and delete events.',
      '40L — Equipment Intelligence Dashboard':
          'Provide management visibility of active, overdue, repair and verification status.',
    };

    await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Step 40 — Module Guide'),
        content: SizedBox(
          width: 620,
          child: ListView(
            shrinkWrap: true,
            children: modules.entries
                .map(
                  (entry) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
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
      _conditionFilter = 'All';
      _inspectionFilter = 'All';
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
      width: 190,
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
              '40L — Equipment Intelligence Dashboard',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w800,
                color: darkGreen,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Register → Inspect → Certify → Maintain → Verify → Deploy → Monitor',
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
                        'Total Assets',
                        '${_assets.length}',
                        Icons.inventory_2_outlined,
                      ),
                    ),
                    SizedBox(
                      width: width,
                      child: _dashboardCard(
                        'Active',
                        '$_activeCount',
                        Icons.check_circle_outline,
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
                        'Maintenance',
                        '$_maintenanceCount',
                        Icons.build_outlined,
                      ),
                    ),
                    SizedBox(
                      width: width,
                      child: _dashboardCard(
                        'Repair Required',
                        '$_repairCount',
                        Icons.handyman_outlined,
                      ),
                    ),
                    SizedBox(
                      width: width,
                      child: _dashboardCard(
                        'Quarantined',
                        '$_quarantineCount',
                        Icons.block_outlined,
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
                    SizedBox(
                      width: width,
                      child: _dashboardCard(
                        'Expired',
                        '$_expiredCount',
                        Icons.event_busy_outlined,
                      ),
                    ),
                    SizedBox(
                      width: width,
                      child: _dashboardCard(
                        'Maintenance Cost',
                        '$_totalCost',
                        Icons.payments_outlined,
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

  Widget _buildAssetCard(Map<String, dynamic> asset) {
    final inspectionState = _inspectionState(asset);
    final maintenanceDate = _parseDate(asset['nextMaintenance']);
    final maintenanceAttention =
        maintenanceDate != null && _isDateAttention(asset['nextMaintenance']);

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _showDetails(asset),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    child: Icon(Icons.precision_manufacturing_outlined),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _value(asset, 'assetName'),
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                            color: darkGreen,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${_value(asset, 'assetId')} • '
                          '${_value(asset, 'assetType')}',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'edit') {
                        _editAsset(asset);
                      } else if (value == 'delete') {
                        _deleteAsset(asset);
                      } else if (value == 'open') {
                        _showDetails(asset);
                      }
                    },
                    itemBuilder: (context) => const [
                      PopupMenuItem(
                        value: 'open',
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
                  _statusChip(_value(asset, 'status')),
                  _statusChip(inspectionState),
                  _statusChip(_value(asset, 'condition')),
                  if (_value(asset, 'verificationStatus').isNotEmpty)
                    _statusChip(_value(asset, 'verificationStatus')),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(Icons.location_on_outlined, size: 17),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Text(_value(asset, 'location')),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.person_outline, size: 17),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      _value(asset, 'owner').isEmpty
                          ? 'Unassigned'
                          : _value(asset, 'owner'),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
              if (maintenanceAttention) ...[
                const SizedBox(height: 8),
                const Row(
                  children: [
                    Icon(
                      Icons.build_circle_outlined,
                      size: 17,
                    ),
                    SizedBox(width: 5),
                    Text(
                      'Maintenance attention within 30 days',
                      style: TextStyle(fontWeight: FontWeight.w700),
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
          'Step 40 • Equipment & Assets',
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
        onPressed: _loading ? null : _addAsset,
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Add Asset'),
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
                              labelText: 'Search equipment / asset',
                              hintText:
                                  'Asset ID, name, location, owner, manufacturer',
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
                                label: 'Asset Type',
                                value: _typeFilter,
                                items: ['All', ..._assetTypes],
                                onChanged: (value) => setState(
                                  () => _typeFilter = value!,
                                ),
                              ),
                              _filterDropdown(
                                label: 'Condition',
                                value: _conditionFilter,
                                items: ['All', ..._conditionOptions],
                                onChanged: (value) => setState(
                                  () => _conditionFilter = value!,
                                ),
                              ),
                              _filterDropdown(
                                label: 'Inspection',
                                value: _inspectionFilter,
                                items: [
                                  'All',
                                  ..._inspectionOptions.where(
                                    (item) => item != 'Not Required',
                                  ),
                                ],
                                onChanged: (value) => setState(
                                  () => _inspectionFilter = value!,
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
                          '${_filteredAssets.length} asset(s) found',
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            color: darkGreen,
                          ),
                        ),
                      ),
                      TextButton.icon(
                        onPressed: _showModuleGuide,
                        icon: const Icon(Icons.info_outline),
                        label: const Text('40A–40L'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  if (_filteredAssets.isEmpty)
                    Card(
                      elevation: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(30),
                        child: Column(
                          children: [
                            const Icon(
                              Icons.inventory_2_outlined,
                              size: 48,
                              color: darkGreen,
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'No equipment / asset records found.',
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(height: 6),
                            const Text(
                              'Register HSE-critical equipment to begin Step 40.',
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 14),
                            FilledButton.icon(
                              onPressed: _addAsset,
                              icon: const Icon(Icons.add),
                              label: const Text('Register First Asset'),
                            ),
                          ],
                        ),
                      ),
                    )
                  else
                    ..._filteredAssets.map(_buildAssetCard),
                ],
              ),
            ),
    );
  }
}
