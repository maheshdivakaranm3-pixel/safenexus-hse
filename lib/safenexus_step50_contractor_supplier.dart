import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SafeNexusStep50ContractorSupplierPage extends StatefulWidget {
  const SafeNexusStep50ContractorSupplierPage({super.key});

  @override
  State<SafeNexusStep50ContractorSupplierPage> createState() =>
      _SafeNexusStep50ContractorSupplierPageState();
}

class _SafeNexusStep50ContractorSupplierPageState
    extends State<SafeNexusStep50ContractorSupplierPage> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);
  static const String storageKey =
      'safenexus_hse_step50_contractor_supplier';

  final List<Map<String, dynamic>> _records = <Map<String, dynamic>>[];

  String _search = '';
  String _statusFilter = 'All';
  String _typeFilter = 'All';

  final List<String> _statuses = <String>[
    'Prequalification',
    'Under Review',
    'Approved',
    'Conditionally Approved',
    'Active',
    'Suspended',
    'Expired',
    'Closed',
  ];

  final List<String> _types = <String>[
    'Contractor',
    'Supplier',
    'Subcontractor',
    'Service Provider',
  ];

  final List<String> _priorities = <String>[
    'Low',
    'Medium',
    'High',
    'Critical',
  ];

  @override
  void initState() {
    super.initState();
    _loadRecords();
  }

  Future<void> _loadRecords() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> saved = prefs.getStringList(storageKey) ?? <String>[];

    if (!mounted) return;

    setState(() {
      _records
        ..clear()
        ..addAll(
          saved.map(
            (String name) => <String, dynamic>{
              'id': DateTime.now().microsecondsSinceEpoch.toString(),
              'name': name,
              'type': 'Contractor',
              'status': 'Prequalification',
              'priority': 'Medium',
              'companyId': '',
              'contact': '',
              'scope': '',
              'site': '',
              'contractNo': '',
              'startDate': '',
              'expiryDate': '',
              'screening': '',
              'documents': '',
              'risk': '',
              'rams': '',
              'ptw': '',
              'workforce': '',
              'training': '',
              'inspection': '',
              'incident': '',
              'actions': '',
              'performance': '',
              'notes': '',
              'createdAt': DateTime.now().toIso8601String(),
            },
          ),
        );
    });
  }

  Future<void> _saveRecords() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> names =
        _records.map((Map<String, dynamic> e) => e['name'] as String).toList();
    await prefs.setStringList(storageKey, names);
  }

  List<Map<String, dynamic>> get _filteredRecords {
    return _records.where((Map<String, dynamic> item) {
      final String searchable = <String>[
        item['name'],
        item['type'],
        item['status'],
        item['priority'],
        item['scope'],
        item['site'],
        item['contractNo'],
        item['contact'],
        item['performance'],
        item['actions'],
      ].join(' ').toLowerCase();

      final bool matchesSearch =
          _search.trim().isEmpty || searchable.contains(_search.toLowerCase());
      final bool matchesStatus =
          _statusFilter == 'All' || item['status'] == _statusFilter;
      final bool matchesType =
          _typeFilter == 'All' || item['type'] == _typeFilter;

      return matchesSearch && matchesStatus && matchesType;
    }).toList();
  }

  int _countStatus(String status) {
    return _records
        .where((Map<String, dynamic> item) => item['status'] == status)
        .length;
  }

  int _countType(String type) {
    return _records
        .where((Map<String, dynamic> item) => item['type'] == type)
        .length;
  }

  Future<void> _addOrEdit({Map<String, dynamic>? existing}) async {
    final Map<String, dynamic>? result =
        await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (BuildContext context) =>
          _ContractorFormDialog(existing: existing),
    );

    if (result == null) return;

    setState(() {
      if (existing == null) {
        _records.insert(0, <String, dynamic>{
          ...result,
          'id': DateTime.now().microsecondsSinceEpoch.toString(),
          'createdAt': DateTime.now().toIso8601String(),
        });
      } else {
        final int index = _records.indexOf(existing);
        if (index >= 0) {
          _records[index] = <String, dynamic>{
            ...existing,
            ...result,
          };
        }
      }
    });

    await _saveRecords();
  }

  Future<void> _delete(Map<String, dynamic> item) async {
    setState(() => _records.remove(item));
    await _saveRecords();
  }

  Future<void> _confirmDelete(Map<String, dynamic> item) async {
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Delete Contractor / Supplier?'),
        content: const Text(
          'This contractor or supplier record will be deleted.',
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
      await _delete(item);
    }
  }

  void _showDashboard() {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('50L — Contractor HSE Dashboard'),
        content: SizedBox(
          width: 440,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _metricRow('Total Records', _records.length),
                _metricRow('Prequalification', _countStatus('Prequalification')),
                _metricRow('Under Review', _countStatus('Under Review')),
                _metricRow('Approved', _countStatus('Approved')),
                _metricRow(
                  'Conditionally Approved',
                  _countStatus('Conditionally Approved'),
                ),
                _metricRow('Active', _countStatus('Active')),
                _metricRow('Suspended', _countStatus('Suspended')),
                _metricRow('Expired', _countStatus('Expired')),
                const Divider(),
                _metricRow('Contractors', _countType('Contractor')),
                _metricRow('Suppliers', _countType('Supplier')),
                _metricRow(
                  'Subcontractors',
                  _countType('Subcontractor'),
                ),
                _metricRow(
                  'Service Providers',
                  _countType('Service Provider'),
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

  Widget _metricRow(String label, int value) {
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

  void _showGuide() {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Step 50 — Contractor & Supplier Guide'),
        content: const SingleChildScrollView(
          child: Text(
            'Prequalify → Verify → Approve → Induct → Authorize → Monitor → '
            'Inspect → Evaluate → Correct → Reassess → Close → Analyze\n\n'
            '50A Contractor / Supplier Master\n'
            '50B Prequalification & HSE Screening\n'
            '50C Contractor HSE Documents & Compliance\n'
            '50D Contractor Risk Assessment & RAMS\n'
            '50E Contractor PTW & Work Authorization\n'
            '50F Contractor Workforce Competency\n'
            '50G Contractor HSE Induction & Training\n'
            '50H Contractor Inspection & Performance\n'
            '50I Contractor Incidents & Corrective Actions\n'
            '50J Contractor Performance Evaluation\n'
            '50K Contractor History / Audit Trail\n'
            '50L Contractor HSE Performance Intelligence Dashboard\n\n'
            'UAE-wide contractor and supplier HSE management architecture '
            'linked to risk, RAMS, PTW, workforce, training, inspections, '
            'incidents and corrective actions.',
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
    final List<Map<String, dynamic>> records = _filteredRecords;

    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
        title: const Text('Step 50 • Contractor & Supplier HSE'),
        actions: <Widget>[
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
        onPressed: () => _addOrEdit(),
        icon: const Icon(Icons.add),
        label: const Text('New Contractor'),
      ),
      body: Column(
        children: <Widget>[
          _header(),
          _filters(),
          Expanded(
            child: records.isEmpty
                ? _emptyState()
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(12, 4, 12, 90),
                    itemCount: records.length,
                    itemBuilder: (BuildContext context, int index) {
                      return _recordCard(records[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _header() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'HSE Contractor & Supplier Safety Management Center',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: darkGreen,
            ),
          ),
          SizedBox(height: 5),
          Text(
            'Contractor • Supplier • Prequalification • Compliance • Performance',
            style: TextStyle(fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _filters() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: <Widget>[
          TextField(
            onChanged: (String value) => setState(() => _search = value),
            decoration: InputDecoration(
              hintText: 'Search company, scope, site, contact, actions...',
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
                  initialValue: _statusFilter,
                  decoration: const InputDecoration(
                    labelText: 'Status',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                  ),
                  items: <String>['All', ..._statuses]
                      .map(
                        (String value) => DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        ),
                      )
                      .toList(),
                  onChanged: (String? value) {
                    if (value != null) {
                      setState(() => _statusFilter = value);
                    }
                  },
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: DropdownButtonFormField<String>(
                  initialValue: _typeFilter,
                  decoration: const InputDecoration(
                    labelText: 'Type',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                  ),
                  items: <String>['All', ..._types]
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
                      setState(() => _typeFilter = value);
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

  Widget _recordCard(Map<String, dynamic> item) {
    final String name = item['name'] as String? ?? 'Unnamed';
    final String type = item['type'] as String? ?? 'Contractor';
    final String status = item['status'] as String? ?? 'Prequalification';
    final String priority = item['priority'] as String? ?? 'Medium';
    final String scope = item['scope'] as String? ?? '';
    final String site = item['site'] as String? ?? '';

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 1,
      child: ExpansionTile(
        leading: CircleAvatar(
          backgroundColor: primaryGreen.withValues(alpha: 0.12),
          child: const Icon(
            Icons.business_outlined,
            color: darkGreen,
          ),
        ),
        title: Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('$type • $status • $priority'),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
        children: <Widget>[
          if (scope.isNotEmpty) _detailLine('Scope of Work', scope),
          if (site.isNotEmpty) _detailLine('Site / Location', site),
          _detailLine(
            'Workflow',
            'Prequalify → Verify → Approve → Induct → Monitor → Evaluate',
          ),
          _detailLine(
            'Integration',
            'Risk → RAMS → PTW → Workforce → Training → Inspection → Incident → Action',
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              IconButton(
                tooltip: 'Edit',
                onPressed: () => _addOrEdit(existing: item),
                icon: const Icon(Icons.edit_outlined),
              ),
              IconButton(
                tooltip: 'Delete',
                onPressed: () => _confirmDelete(item),
                icon: const Icon(Icons.delete_outline),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _detailLine(String label, String value) {
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

  Widget _emptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.business_outlined,
              size: 62,
              color: darkGreen.withValues(alpha: 0.45),
            ),
            const SizedBox(height: 12),
            const Text(
              'No contractor or supplier records found',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Create the first contractor or supplier HSE record.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _ContractorFormDialog extends StatefulWidget {
  const _ContractorFormDialog({this.existing});

  final Map<String, dynamic>? existing;

  @override
  State<_ContractorFormDialog> createState() => _ContractorFormDialogState();
}

class _ContractorFormDialogState extends State<_ContractorFormDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final TextEditingController _name;
  late final TextEditingController _companyId;
  late final TextEditingController _contact;
  late final TextEditingController _scope;
  late final TextEditingController _site;
  late final TextEditingController _contractNo;
  late final TextEditingController _startDate;
  late final TextEditingController _expiryDate;
  late final TextEditingController _screening;
  late final TextEditingController _documents;
  late final TextEditingController _risk;
  late final TextEditingController _rams;
  late final TextEditingController _ptw;
  late final TextEditingController _workforce;
  late final TextEditingController _training;
  late final TextEditingController _inspection;
  late final TextEditingController _incident;
  late final TextEditingController _actions;
  late final TextEditingController _performance;
  late final TextEditingController _notes;

  String _type = 'Contractor';
  String _status = 'Prequalification';
  String _priority = 'Medium';

  final List<String> _types = <String>[
    'Contractor',
    'Supplier',
    'Subcontractor',
    'Service Provider',
  ];

  final List<String> _statuses = <String>[
    'Prequalification',
    'Under Review',
    'Approved',
    'Conditionally Approved',
    'Active',
    'Suspended',
    'Expired',
    'Closed',
  ];

  final List<String> _priorities = <String>[
    'Low',
    'Medium',
    'High',
    'Critical',
  ];

  @override
  void initState() {
    super.initState();

    final Map<String, dynamic> e = widget.existing ?? <String, dynamic>{};

    _name = TextEditingController(text: e['name'] as String? ?? '');
    _companyId =
        TextEditingController(text: e['companyId'] as String? ?? '');
    _contact = TextEditingController(text: e['contact'] as String? ?? '');
    _scope = TextEditingController(text: e['scope'] as String? ?? '');
    _site = TextEditingController(text: e['site'] as String? ?? '');
    _contractNo =
        TextEditingController(text: e['contractNo'] as String? ?? '');
    _startDate =
        TextEditingController(text: e['startDate'] as String? ?? '');
    _expiryDate =
        TextEditingController(text: e['expiryDate'] as String? ?? '');
    _screening =
        TextEditingController(text: e['screening'] as String? ?? '');
    _documents =
        TextEditingController(text: e['documents'] as String? ?? '');
    _risk = TextEditingController(text: e['risk'] as String? ?? '');
    _rams = TextEditingController(text: e['rams'] as String? ?? '');
    _ptw = TextEditingController(text: e['ptw'] as String? ?? '');
    _workforce =
        TextEditingController(text: e['workforce'] as String? ?? '');
    _training =
        TextEditingController(text: e['training'] as String? ?? '');
    _inspection =
        TextEditingController(text: e['inspection'] as String? ?? '');
    _incident =
        TextEditingController(text: e['incident'] as String? ?? '');
    _actions = TextEditingController(text: e['actions'] as String? ?? '');
    _performance =
        TextEditingController(text: e['performance'] as String? ?? '');
    _notes = TextEditingController(text: e['notes'] as String? ?? '');

    _type = e['type'] as String? ?? 'Contractor';
    _status = e['status'] as String? ?? 'Prequalification';
    _priority = e['priority'] as String? ?? 'Medium';
  }

  @override
  void dispose() {
    _name.dispose();
    _companyId.dispose();
    _contact.dispose();
    _scope.dispose();
    _site.dispose();
    _contractNo.dispose();
    _startDate.dispose();
    _expiryDate.dispose();
    _screening.dispose();
    _documents.dispose();
    _risk.dispose();
    _rams.dispose();
    _ptw.dispose();
    _workforce.dispose();
    _training.dispose();
    _inspection.dispose();
    _incident.dispose();
    _actions.dispose();
    _performance.dispose();
    _notes.dispose();
    super.dispose();
  }

  InputDecoration _decoration(String label, IconData icon) {
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
            ? 'New Contractor / Supplier'
            : 'Edit Contractor / Supplier',
      ),
      content: SizedBox(
        width: 540,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: _name,
                  decoration: _decoration(
                    'Company / Contractor Name *',
                    Icons.business_outlined,
                  ),
                  validator: (String? value) =>
                      value == null || value.trim().isEmpty
                          ? 'Enter company name'
                          : null,
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  initialValue: _type,
                  decoration:
                      _decoration('Type', Icons.category_outlined),
                  items: _types
                      .map(
                        (String value) => DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        ),
                      )
                      .toList(),
                  onChanged: (String? value) {
                    if (value != null) setState(() => _type = value);
                  },
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  initialValue: _status,
                  decoration:
                      _decoration('HSE Status', Icons.verified_outlined),
                  items: _statuses
                      .map(
                        (String value) => DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        ),
                      )
                      .toList(),
                  onChanged: (String? value) {
                    if (value != null) setState(() => _status = value);
                  },
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  initialValue: _priority,
                  decoration:
                      _decoration('Risk Priority', Icons.priority_high_outlined),
                  items: _priorities
                      .map(
                        (String value) => DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        ),
                      )
                      .toList(),
                  onChanged: (String? value) {
                    if (value != null) setState(() => _priority = value);
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _companyId,
                  decoration:
                      _decoration('Company / Vendor ID', Icons.badge_outlined),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _contact,
                  decoration:
                      _decoration('Contact / HSE Representative', Icons.person_outline),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _scope,
                  maxLines: 2,
                  decoration:
                      _decoration('50A Scope of Work / Supply', Icons.work_outline),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _site,
                  decoration:
                      _decoration('Site / Project Location', Icons.location_on_outlined),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _contractNo,
                  decoration:
                      _decoration('Contract / PO Reference', Icons.description_outlined),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _startDate,
                  decoration:
                      _decoration('Contract Start Date', Icons.calendar_today_outlined),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _expiryDate,
                  decoration:
                      _decoration('Contract / Approval Expiry', Icons.event_available_outlined),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _screening,
                  maxLines: 3,
                  decoration:
                      _decoration('50B HSE Prequalification / Screening', Icons.fact_check_outlined),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _documents,
                  maxLines: 3,
                  decoration:
                      _decoration('50C HSE Documents / Compliance', Icons.folder_outlined),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _risk,
                  maxLines: 2,
                  decoration:
                      _decoration('50D Risk Assessment / Hazard Controls', Icons.warning_amber_outlined),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _rams,
                  maxLines: 2,
                  decoration:
                      _decoration('50D RAMS Verification', Icons.menu_book_outlined),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _ptw,
                  maxLines: 2,
                  decoration:
                      _decoration('50E PTW / Work Authorization', Icons.assignment_outlined),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _workforce,
                  maxLines: 2,
                  decoration:
                      _decoration('50F Workforce Competency', Icons.groups_outlined),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _training,
                  maxLines: 2,
                  decoration:
                      _decoration('50G Induction / Training', Icons.school_outlined),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _inspection,
                  maxLines: 2,
                  decoration:
                      _decoration('50H Inspection / HSE Performance', Icons.search_outlined),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _incident,
                  maxLines: 2,
                  decoration:
                      _decoration('50I Incidents / Events', Icons.report_problem_outlined),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _actions,
                  maxLines: 3,
                  decoration:
                      _decoration('50I Corrective / Preventive Actions', Icons.task_alt_outlined),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _performance,
                  maxLines: 3,
                  decoration:
                      _decoration('50J Performance Evaluation', Icons.analytics_outlined),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _notes,
                  maxLines: 3,
                  decoration:
                      _decoration('50K History / Audit Notes', Icons.notes_outlined),
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
          onPressed: _submit,
          icon: const Icon(Icons.save_outlined),
          label: const Text('Save'),
        ),
      ],
    );
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    Navigator.pop(context, <String, dynamic>{
      'name': _name.text.trim(),
      'type': _type,
      'status': _status,
      'priority': _priority,
      'companyId': _companyId.text.trim(),
      'contact': _contact.text.trim(),
      'scope': _scope.text.trim(),
      'site': _site.text.trim(),
      'contractNo': _contractNo.text.trim(),
      'startDate': _startDate.text.trim(),
      'expiryDate': _expiryDate.text.trim(),
      'screening': _screening.text.trim(),
      'documents': _documents.text.trim(),
      'risk': _risk.text.trim(),
      'rams': _rams.text.trim(),
      'ptw': _ptw.text.trim(),
      'workforce': _workforce.text.trim(),
      'training': _training.text.trim(),
      'inspection': _inspection.text.trim(),
      'incident': _incident.text.trim(),
      'actions': _actions.text.trim(),
      'performance': _performance.text.trim(),
      'notes': _notes.text.trim(),
    });
  }
}
