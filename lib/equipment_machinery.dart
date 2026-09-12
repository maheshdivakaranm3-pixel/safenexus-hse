import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EquipmentMachineryPage extends StatefulWidget {
  const EquipmentMachineryPage({super.key});

  @override
  State<EquipmentMachineryPage> createState() =>
      _EquipmentMachineryPageState();
}

class _EquipmentMachineryPageState extends State<EquipmentMachineryPage> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const String storageKey = 'safenexus_hse_equipment_machinery';

  List<Map<String, dynamic>> records = [];
  String searchText = '';
  String statusFilter = 'All';
  String categoryFilter = 'All';
  String readinessFilter = 'All';

  final List<String> categories = const [
    'All',
    'Construction Equipment',
    'Mobile Plant',
    'Vehicle',
    'Lifting Equipment',
    'Lifting Accessories',
    'Power Tools',
    'Electrical Equipment',
    'Earthmoving Equipment',
    'Scaffolding Equipment',
    'Access Equipment',
    'Calibration / Measuring Equipment',
    'Other',
  ];

  final List<String> statuses = const [
    'Draft',
    'Active',
    'Under Inspection',
    'Certification Due',
    'Maintenance Due',
    'Defective',
    'Quarantined',
    'Released',
    'Suspended',
    'Expired',
    'Closed',
  ];

  final List<String> readinessOptions = const [
    'Ready for Use',
    'Conditionally Ready',
    'Not Ready',
    'Pending Verification',
  ];

  final List<String> inspectionOptions = const [
    'Passed',
    'Passed with Remarks',
    'Failed',
    'Pending',
    'Not Applicable',
  ];

  final List<String> certificationOptions = const [
    'Valid',
    'Expiring Soon',
    'Expired',
    'Pending',
    'Not Applicable',
  ];

  final List<String> operatorOptions = const [
    'Verified',
    'Not Verified',
    'Not Applicable',
    'Pending',
  ];

  @override
  void initState() {
    super.initState();
    _loadRecords();
  }

  Future<void> _loadRecords() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(storageKey) ?? [];
    final loaded = raw.map(_decode).toList();

    if (!mounted) return;
    setState(() => records = loaded);
  }

  Map<String, dynamic> _decode(String item) {
    final p = item.split('|');
    String v(int i) => i < p.length ? p[i] : '';

    return {
      'id': v(0),
      'equipmentNo': v(1),
      'equipmentName': v(2),
      'category': v(3),
      'manufacturer': v(4),
      'model': v(5),
      'serialNo': v(6),
      'assetNo': v(7),
      'ownerCompany': v(8),
      'project': v(9),
      'site': v(10),
      'location': v(11),
      'department': v(12),
      'responsiblePerson': v(13),
      'operatorName': v(14),
      'operatorId': v(15),
      'operatorVerification': v(16),
      'capacityRating': v(17),
      'safeWorkingLoad': v(18),
      'inspectionDate': v(19),
      'inspectionExpiry': v(20),
      'inspectionStatus': v(21),
      'certificateNo': v(22),
      'certificateType': v(23),
      'certificateExpiry': v(24),
      'thirdPartyInspector': v(25),
      'maintenanceDate': v(26),
      'nextMaintenanceDate': v(27),
      'maintenanceStatus': v(28),
      'calibrationDate': v(29),
      'calibrationExpiry': v(30),
      'defectDescription': v(31),
      'quarantineReason': v(32),
      'releaseDate': v(33),
      'releaseBy': v(34),
      'preUseInspection': v(35),
      'readiness': v(36).isEmpty ? 'Pending Verification' : v(36),
      'deploymentClearance': v(37),
      'clearanceBy': v(38),
      'clearanceDate': v(39),
      'status': v(40).isEmpty ? 'Draft' : v(40),
      'nextReviewDate': v(41),
      'remarks': v(42),
      'createdAt': v(43),
      'updatedAt': v(44),
    };
  }

  String _safe(Object? value) =>
      (value?.toString() ?? '').replaceAll('|', '/').trim();

  Future<void> _saveRecords() async {
    final prefs = await SharedPreferences.getInstance();

    const keys = [
      'id',
      'equipmentNo',
      'equipmentName',
      'category',
      'manufacturer',
      'model',
      'serialNo',
      'assetNo',
      'ownerCompany',
      'project',
      'site',
      'location',
      'department',
      'responsiblePerson',
      'operatorName',
      'operatorId',
      'operatorVerification',
      'capacityRating',
      'safeWorkingLoad',
      'inspectionDate',
      'inspectionExpiry',
      'inspectionStatus',
      'certificateNo',
      'certificateType',
      'certificateExpiry',
      'thirdPartyInspector',
      'maintenanceDate',
      'nextMaintenanceDate',
      'maintenanceStatus',
      'calibrationDate',
      'calibrationExpiry',
      'defectDescription',
      'quarantineReason',
      'releaseDate',
      'releaseBy',
      'preUseInspection',
      'readiness',
      'deploymentClearance',
      'clearanceBy',
      'clearanceDate',
      'status',
      'nextReviewDate',
      'remarks',
      'createdAt',
      'updatedAt',
    ];

    final raw = records
        .map((record) => keys.map((key) => _safe(record[key])).join('|'))
        .toList();

    await prefs.setStringList(storageKey, raw);
  }

  List<Map<String, dynamic>> get filteredRecords {
    final query = searchText.trim().toLowerCase();

    return records.where((record) {
      final searchable = record.values.join(' ').toLowerCase();

      return (query.isEmpty || searchable.contains(query)) &&
          (statusFilter == 'All' || record['status'] == statusFilter) &&
          (categoryFilter == 'All' || record['category'] == categoryFilter) &&
          (readinessFilter == 'All' ||
              record['readiness'] == readinessFilter);
    }).toList();
  }

  int _countStatus(String value) =>
      records.where((r) => r['status'] == value).length;

  int _countField(String field, String value) =>
      records.where((r) => r[field] == value).length;

  int get _activeCount => _countStatus('Active');
  int get _quarantineCount => _countStatus('Quarantined');
  int get _defectiveCount => _countStatus('Defective');
  int get _expiredCount => _countStatus('Expired');

  int get _expiringCount =>
      records.where((record) => _isExpiring(record)).length;

  int get _overdueCount =>
      records.where((record) => _isOverdue(record)).length;

  int get _readyCount =>
      _countField('readiness', 'Ready for Use');

  bool _isOverdue(Map<String, dynamic> record) {
    final dates = [
      record['inspectionExpiry']?.toString(),
      record['certificateExpiry']?.toString(),
      record['nextMaintenanceDate']?.toString(),
      record['calibrationExpiry']?.toString(),
      record['nextReviewDate']?.toString(),
    ];

    for (final value in dates) {
      final date = DateTime.tryParse(value ?? '');
      if (date != null &&
          date.isBefore(DateTime.now()) &&
          record['status'] != 'Closed' &&
          record['status'] != 'Quarantined') {
        return true;
      }
    }
    return false;
  }

  bool _isExpiring(Map<String, dynamic> record) {
    final dates = [
      record['inspectionExpiry']?.toString(),
      record['certificateExpiry']?.toString(),
      record['nextMaintenanceDate']?.toString(),
      record['calibrationExpiry']?.toString(),
    ];

    for (final value in dates) {
      final date = DateTime.tryParse(value ?? '');
      if (date == null) continue;

      final days = date.difference(DateTime.now()).inDays;
      if (days >= 0 && days <= 30) return true;
    }
    return false;
  }

  Future<void> _openForm({Map<String, dynamic>? existing}) async {
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _EquipmentFormSheet(
        existing: existing,
        categories: categories.where((v) => v != 'All').toList(),
        statuses: statuses,
        readinessOptions: readinessOptions,
        inspectionOptions: inspectionOptions,
        certificationOptions: certificationOptions,
        operatorOptions: operatorOptions,
      ),
    );

    if (result == null) return;

    final now = DateTime.now().toIso8601String();

    if (existing == null) {
      result['id'] = 'EQ-${DateTime.now().millisecondsSinceEpoch}';
      result['createdAt'] = now;
      result['updatedAt'] = now;
      records.add(result);
    } else {
      result['id'] = existing['id'];
      result['createdAt'] = existing['createdAt'];
      result['updatedAt'] = now;

      final index = records.indexOf(existing);
      if (index >= 0) records[index] = result;
    }

    await _saveRecords();
    if (mounted) setState(() {});
  }

  Future<void> _deleteRecord(Map<String, dynamic> record) async {
    records.remove(record);
    await _saveRecords();
    if (mounted) setState(() {});
  }

  void _showDetails(Map<String, dynamic> record) {
    showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
          record['equipmentName']?.toString().isNotEmpty == true
              ? record['equipmentName'].toString()
              : 'Equipment Details',
        ),
        content: SizedBox(
          width: 560,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: record.entries
                  .where((e) =>
                      e.key != 'id' &&
                      e.key != 'createdAt' &&
                      e.key != 'updatedAt')
                  .map(
                    (e) => Padding(
                      padding: const EdgeInsets.only(bottom: 7),
                      child: Text(
                        '${_label(e.key)}: ${e.value}',
                        style: const TextStyle(fontSize: 13),
                      ),
                    ),
                  )
                  .toList(),
            ),
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

  String _label(String key) {
    final spaced = key.replaceAllMapped(
      RegExp(r'([A-Z])'),
      (m) => ' ${m.group(1)}',
    );
    return spaced.isEmpty
        ? key
        : '${spaced[0].toUpperCase()}${spaced.substring(1)}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Equipment & Machinery'),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () => _openForm(),
            icon: const Icon(Icons.add),
            tooltip: 'Add Equipment',
          ),
        ],
      ),
      body: Column(
        children: [
          _dashboard(),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 2, 12, 8),
            child: Column(
              children: [
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Search equipment, asset, serial, site...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) =>
                      setState(() => searchText = value),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        initialValue: statusFilter,
                        decoration: const InputDecoration(
                          labelText: 'Status',
                          border: OutlineInputBorder(),
                        ),
                        items: ['All', ...statuses]
                            .map(
                              (v) => DropdownMenuItem(
                                value: v,
                                child: Text(v),
                              ),
                            )
                            .toList(),
                        onChanged: (v) =>
                            setState(() => statusFilter = v ?? 'All'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        initialValue: categoryFilter,
                        decoration: const InputDecoration(
                          labelText: 'Category',
                          border: OutlineInputBorder(),
                        ),
                        items: categories
                            .map(
                              (v) => DropdownMenuItem(
                                value: v,
                                child: Text(v),
                              ),
                            )
                            .toList(),
                        onChanged: (v) =>
                            setState(() => categoryFilter = v ?? 'All'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  initialValue: readinessFilter,
                  decoration: const InputDecoration(
                    labelText: 'HSE Readiness',
                    border: OutlineInputBorder(),
                  ),
                  items: ['All', ...readinessOptions]
                      .map(
                        (v) => DropdownMenuItem(
                          value: v,
                          child: Text(v),
                        ),
                      )
                      .toList(),
                  onChanged: (v) =>
                      setState(() => readinessFilter = v ?? 'All'),
                ),
              ],
            ),
          ),
          Expanded(
            child: filteredRecords.isEmpty
                ? const Center(
                    child: Text('No equipment records found.'),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: filteredRecords.length,
                    itemBuilder: (_, index) {
                      final record = filteredRecords[index];
                      final overdue = _isOverdue(record);
                      final expiring = _isExpiring(record);

                      return Card(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor:
                                record['status'] == 'Quarantined'
                                    ? Colors.red
                                    : primaryGreen,
                            child: const Icon(
                              Icons.precision_manufacturing,
                              color: Colors.white,
                            ),
                          ),
                          title: Text(
                            record['equipmentName']?.toString() ?? '',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            '${record['equipmentNo']} • '
                            '${record['category']}\n'
                            '${record['readiness']} • '
                            '${record['status']}'
                            '${overdue ? ' • OVERDUE' : ''}'
                            '${expiring ? ' • EXPIRING ≤30 DAYS' : ''}',
                          ),
                          isThreeLine: true,
                          onTap: () => _showDetails(record),
                          trailing: PopupMenuButton<String>(
                            onSelected: (value) {
                              if (value == 'edit') {
                                _openForm(existing: record);
                              } else if (value == 'delete') {
                                _deleteRecord(record);
                              }
                            },
                            itemBuilder: (_) => const [
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
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        onPressed: () => _openForm(),
        icon: const Icon(Icons.add),
        label: const Text('Add Equipment'),
      ),
    );
  }

  Widget _dashboard() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          _stat('TOTAL', records.length, Icons.inventory_2),
          _stat('ACTIVE', _activeCount, Icons.check_circle),
          _stat('READY', _readyCount, Icons.verified),
          _stat('DEFECTIVE', _defectiveCount, Icons.build),
          _stat('QUARANTINE', _quarantineCount, Icons.block),
          _stat('EXPIRED', _expiredCount, Icons.event_busy),
          _stat('EXPIRING', _expiringCount, Icons.schedule),
          _stat('OVERDUE', _overdueCount, Icons.warning),
        ],
      ),
    );
  }

  Widget _stat(String title, int value, IconData icon) {
    return SizedBox(
      width: 92,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 9,
            horizontal: 4,
          ),
          child: Column(
            children: [
              Icon(icon, color: primaryGreen, size: 20),
              const SizedBox(height: 3),
              Text(
                '$value',
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 9),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EquipmentFormSheet extends StatefulWidget {
  final Map<String, dynamic>? existing;
  final List<String> categories;
  final List<String> statuses;
  final List<String> readinessOptions;
  final List<String> inspectionOptions;
  final List<String> certificationOptions;
  final List<String> operatorOptions;

  const _EquipmentFormSheet({
    required this.existing,
    required this.categories,
    required this.statuses,
    required this.readinessOptions,
    required this.inspectionOptions,
    required this.certificationOptions,
    required this.operatorOptions,
  });

  @override
  State<_EquipmentFormSheet> createState() => _EquipmentFormSheetState();
}

class _EquipmentFormSheetState extends State<_EquipmentFormSheet> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);

  final formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> controllers = {};

  String category = 'Construction Equipment';
  String operatorVerification = 'Pending';
  String inspectionStatus = 'Pending';
  String certificationStatus = 'Pending';
  String maintenanceStatus = 'Pending';
  String preUseInspection = 'Pending';
  String readiness = 'Pending Verification';
  String deploymentClearance = 'Pending';
  String status = 'Draft';

  @override
  void initState() {
    super.initState();

    const fields = [
      'equipmentNo',
      'equipmentName',
      'manufacturer',
      'model',
      'serialNo',
      'assetNo',
      'ownerCompany',
      'project',
      'site',
      'location',
      'department',
      'responsiblePerson',
      'operatorName',
      'operatorId',
      'capacityRating',
      'safeWorkingLoad',
      'inspectionDate',
      'inspectionExpiry',
      'certificateNo',
      'certificateType',
      'certificateExpiry',
      'thirdPartyInspector',
      'maintenanceDate',
      'nextMaintenanceDate',
      'calibrationDate',
      'calibrationExpiry',
      'defectDescription',
      'quarantineReason',
      'releaseDate',
      'releaseBy',
      'clearanceBy',
      'clearanceDate',
      'nextReviewDate',
      'remarks',
    ];

    for (final field in fields) {
      controllers[field] = TextEditingController(
        text: widget.existing?[field]?.toString() ?? '',
      );
    }

    _setExisting();
  }

  void _setExisting() {
    final e = widget.existing;
    if (e == null) return;

    final values = <String, String>{
      'category': e['category']?.toString() ?? category,
      'operatorVerification':
          e['operatorVerification']?.toString() ?? operatorVerification,
      'inspectionStatus':
          e['inspectionStatus']?.toString() ?? inspectionStatus,
      'certificationStatus':
          e['certificationStatus']?.toString() ?? certificationStatus,
      'maintenanceStatus':
          e['maintenanceStatus']?.toString() ?? maintenanceStatus,
      'preUseInspection':
          e['preUseInspection']?.toString() ?? preUseInspection,
      'readiness': e['readiness']?.toString() ?? readiness,
      'deploymentClearance':
          e['deploymentClearance']?.toString() ?? deploymentClearance,
      'status': e['status']?.toString() ?? status,
    };

    if (widget.categories.contains(values['category'])) {
      category = values['category']!;
    }
    if (widget.operatorOptions.contains(values['operatorVerification'])) {
      operatorVerification = values['operatorVerification']!;
    }
    if (widget.inspectionOptions.contains(values['inspectionStatus'])) {
      inspectionStatus = values['inspectionStatus']!;
    }
    if (widget.certificationOptions.contains(values['certificationStatus'])) {
      certificationStatus = values['certificationStatus']!;
    }
    if (widget.readinessOptions.contains(values['readiness'])) {
      readiness = values['readiness']!;
    }
    if (widget.statuses.contains(values['status'])) {
      status = values['status']!;
    }

    maintenanceStatus = values['maintenanceStatus'] ?? maintenanceStatus;
    preUseInspection = values['preUseInspection'] ?? preUseInspection;
    deploymentClearance =
        values['deploymentClearance'] ?? deploymentClearance;
  }

  @override
  void dispose() {
    for (final c in controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  TextEditingController _c(String key) => controllers[key]!;

  String? _required(String? value) {
    if (value == null || value.trim().isEmpty) return 'Required';
    return null;
  }

  Widget _field(
    String key,
    String label, {
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: _c(key),
        maxLines: maxLines,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _section(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 10),
      child: Text(
        title,
        style: const TextStyle(
          color: darkGreen,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _dropdown(
    String label,
    String value,
    List<String> options,
    ValueChanged<String?> onChanged,
  ) {
    final safeValue = options.contains(value) ? value : options.first;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: DropdownButtonFormField<String>(
        initialValue: safeValue,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        items: options
            .map(
              (v) => DropdownMenuItem(
                value: v,
                child: Text(v),
              ),
            )
            .toList(),
        onChanged: onChanged,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.95,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(22),
          ),
        ),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                color: darkGreen,
                child: const Row(
                  children: [
                    Icon(
                      Icons.precision_manufacturing,
                      color: Colors.white,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Equipment & Machinery Register',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    _section('7A • EQUIPMENT MASTER REGISTER'),
                    _field(
                      'equipmentNo',
                      'Equipment Number',
                      validator: _required,
                    ),
                    _field(
                      'equipmentName',
                      'Equipment / Machinery Name',
                      validator: _required,
                    ),
                    _dropdown(
                      'Category',
                      category,
                      widget.categories,
                      (v) => setState(
                        () => category = v ?? category,
                      ),
                    ),
                    _field('manufacturer', 'Manufacturer'),
                    _field('model', 'Model'),
                    _field('serialNo', 'Serial Number'),
                    _field('assetNo', 'Asset / Fleet Number'),
                    _field('ownerCompany', 'Owner / Contractor Company'),
                    _field('project', 'Project'),
                    _field('site', 'Site'),
                    _field('location', 'Current Location'),
                    _field('department', 'Department'),
                    _field('responsiblePerson', 'Responsible Person'),

                    _section('7F • OPERATOR COMPETENCY'),
                    _field('operatorName', 'Operator Name'),
                    _field('operatorId', 'Operator ID'),
                    _dropdown(
                      'Operator Verification',
                      operatorVerification,
                      widget.operatorOptions,
                      (v) => setState(
                        () => operatorVerification =
                            v ?? operatorVerification,
                      ),
                    ),

                    _section('7D • CAPACITY / LIFTING INFORMATION'),
                    _field('capacityRating', 'Rated Capacity'),
                    _field('safeWorkingLoad', 'Safe Working Load (SWL)'),

                    _section('7B • INSPECTION & PRE-USE'),
                    _field(
                      'inspectionDate',
                      'Inspection Date (YYYY-MM-DD)',
                    ),
                    _field(
                      'inspectionExpiry',
                      'Inspection Valid Until (YYYY-MM-DD)',
                    ),
                    _dropdown(
                      'Inspection Status',
                      inspectionStatus,
                      widget.inspectionOptions,
                      (v) => setState(
                        () => inspectionStatus =
                            v ?? inspectionStatus,
                      ),
                    ),
                    _dropdown(
                      'Pre-Use Inspection',
                      preUseInspection,
                      widget.inspectionOptions,
                      (v) => setState(
                        () => preUseInspection =
                            v ?? preUseInspection,
                      ),
                    ),

                    _section('7C • CERTIFICATION'),
                    _field('certificateNo', 'Certificate Number'),
                    _field('certificateType', 'Certificate / Inspection Type'),
                    _field(
                      'certificateExpiry',
                      'Certificate Expiry (YYYY-MM-DD)',
                    ),
                    _field(
                      'thirdPartyInspector',
                      'Third-Party Inspector / Agency',
                    ),
                    _dropdown(
                      'Certification Status',
                      certificationStatus,
                      widget.certificationOptions,
                      (v) => setState(
                        () => certificationStatus =
                            v ?? certificationStatus,
                      ),
                    ),

                    _section('7G • MAINTENANCE'),
                    _field(
                      'maintenanceDate',
                      'Last Maintenance (YYYY-MM-DD)',
                    ),
                    _field(
                      'nextMaintenanceDate',
                      'Next Maintenance (YYYY-MM-DD)',
                    ),
                    _dropdown(
                      'Maintenance Status',
                      maintenanceStatus,
                      const [
                        'Completed',
                        'Due',
                        'Overdue',
                        'In Progress',
                        'Not Applicable',
                        'Pending',
                      ],
                      (v) => setState(
                        () => maintenanceStatus =
                            v ?? maintenanceStatus,
                      ),
                    ),

                    _section('7I • CALIBRATION'),
                    _field(
                      'calibrationDate',
                      'Calibration Date (YYYY-MM-DD)',
                    ),
                    _field(
                      'calibrationExpiry',
                      'Calibration Expiry (YYYY-MM-DD)',
                    ),

                    _section('7H • DEFECT / QUARANTINE / RELEASE'),
                    _field(
                      'defectDescription',
                      'Defect / Failure Description',
                      maxLines: 3,
                    ),
                    _field(
                      'quarantineReason',
                      'Quarantine Reason',
                      maxLines: 3,
                    ),
                    _field(
                      'releaseDate',
                      'Release Date (YYYY-MM-DD)',
                    ),
                    _field('releaseBy', 'Released By'),

                    _section('7J • HSE READINESS & DEPLOYMENT'),
                    _dropdown(
                      'HSE Readiness',
                      readiness,
                      widget.readinessOptions,
                      (v) => setState(
                        () => readiness = v ?? readiness,
                      ),
                    ),
                    _dropdown(
                      'Deployment Clearance',
                      deploymentClearance,
                      const [
                        'Cleared',
                        'Cleared with Conditions',
                        'Not Cleared',
                        'Pending',
                      ],
                      (v) => setState(
                        () => deploymentClearance =
                            v ?? deploymentClearance,
                      ),
                    ),
                    _field('clearanceBy', 'Clearance By'),
                    _field(
                      'clearanceDate',
                      'Clearance Date (YYYY-MM-DD)',
                    ),

                    _section('CONTROL & REVIEW'),
                    _dropdown(
                      'Record Status',
                      status,
                      widget.statuses,
                      (v) => setState(
                        () => status = v ?? status,
                      ),
                    ),
                    _field(
                      'nextReviewDate',
                      'Next HSE Review Date (YYYY-MM-DD)',
                    ),
                    _field(
                      'remarks',
                      'Remarks',
                      maxLines: 3,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(14),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryGreen,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: _save,
                        icon: const Icon(Icons.save),
                        label: const Text('Save Equipment'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _save() {
    if (!formKey.currentState!.validate()) return;

    final data = <String, dynamic>{};

    for (final entry in controllers.entries) {
      data[entry.key] = entry.value.text.trim();
    }

    data['category'] = category;
    data['operatorVerification'] = operatorVerification;
    data['inspectionStatus'] = inspectionStatus;
    data['certificationStatus'] = certificationStatus;
    data['maintenanceStatus'] = maintenanceStatus;
    data['preUseInspection'] = preUseInspection;
    data['readiness'] = readiness;
    data['deploymentClearance'] = deploymentClearance;
    data['status'] = status;

    Navigator.pop(context, data);
  }
}
