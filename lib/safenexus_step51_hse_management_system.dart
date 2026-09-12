import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SafeNexusStep51HSEManagementSystemPage extends StatefulWidget {
  const SafeNexusStep51HSEManagementSystemPage({super.key});

  @override
  State<SafeNexusStep51HSEManagementSystemPage> createState() =>
      _SafeNexusStep51HSEManagementSystemPageState();
}

class _SafeNexusStep51HSEManagementSystemPageState
    extends State<SafeNexusStep51HSEManagementSystemPage> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);
  static const String storageKey =
      'safenexus_hse_step51_management_system';

  final List<Map<String, dynamic>> _records =
      <Map<String, dynamic>>[];

  String _search = '';
  String _statusFilter = 'All';
  String _elementFilter = 'All';

  final List<String> _statuses = <String>[
    'Draft',
    'Under Review',
    'Approved',
    'Active',
    'Needs Improvement',
    'Closed',
  ];

  final List<String> _elements = <String>[
    'Leadership',
    'Policy',
    'Planning',
    'Risk Management',
    'Operational Control',
    'Competency',
    'Monitoring',
    'Improvement',
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
              'element': 'Leadership',
              'status': 'Draft',
              'owner': '',
              'site': '',
              'scope': '',
              'policy': '',
              'objectives': '',
              'risks': '',
              'controls': '',
              'resources': '',
              'competency': '',
              'monitoring': '',
              'audit': '',
              'improvement': '',
              'reviewDate': '',
              'notes': '',
              'createdAt': DateTime.now().toIso8601String(),
            },
          ),
        );
    });
  }

  Future<void> _saveRecords() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> names = _records
        .map((Map<String, dynamic> item) => item['name'] as String)
        .toList();
    await prefs.setStringList(storageKey, names);
  }

  List<Map<String, dynamic>> get _filteredRecords {
    final String query = _search.trim().toLowerCase();

    return _records.where((Map<String, dynamic> item) {
      final String searchable = <String>[
        item['name'] as String? ?? '',
        item['element'] as String? ?? '',
        item['status'] as String? ?? '',
        item['owner'] as String? ?? '',
        item['site'] as String? ?? '',
        item['scope'] as String? ?? '',
        item['objectives'] as String? ?? '',
        item['risks'] as String? ?? '',
        item['controls'] as String? ?? '',
        item['improvement'] as String? ?? '',
      ].join(' ').toLowerCase();

      final bool matchesSearch =
          query.isEmpty || searchable.contains(query);
      final bool matchesStatus =
          _statusFilter == 'All' ||
          item['status'] == _statusFilter;
      final bool matchesElement =
          _elementFilter == 'All' ||
          item['element'] == _elementFilter;

      return matchesSearch && matchesStatus && matchesElement;
    }).toList();
  }

  int _countStatus(String status) {
    return _records
        .where(
          (Map<String, dynamic> item) => item['status'] == status,
        )
        .length;
  }

  int _countElement(String element) {
    return _records
        .where(
          (Map<String, dynamic> item) => item['element'] == element,
        )
        .length;
  }

  Future<void> _addOrEdit({
    Map<String, dynamic>? existing,
  }) async {
    final Map<String, dynamic>? result =
        await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (BuildContext dialogContext) =>
          _ManagementSystemFormDialog(existing: existing),
    );

    if (result == null || !mounted) return;

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
    setState(() {
      _records.remove(item);
    });
    await _saveRecords();
  }

  Future<void> _confirmDelete(Map<String, dynamic> item) async {
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext dialogContext) => AlertDialog(
        title: const Text('Delete HSE Management System Record?'),
        content: const Text(
          'This HSE management system record will be deleted.',
        ),
        actions: <Widget>[
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

    if (confirmed == true && mounted) {
      await _delete(item);
    }
  }

  void _showDashboard() {
    showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) => AlertDialog(
        title: const Text('51L - HSE Management System Dashboard'),
        content: SizedBox(
          width: 440,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _metricRow('Total Records', _records.length),
                _metricRow('Draft', _countStatus('Draft')),
                _metricRow('Under Review', _countStatus('Under Review')),
                _metricRow('Approved', _countStatus('Approved')),
                _metricRow('Active', _countStatus('Active')),
                _metricRow(
                  'Needs Improvement',
                  _countStatus('Needs Improvement'),
                ),
                _metricRow('Closed', _countStatus('Closed')),
                const Divider(),
                _metricRow(
                  'Leadership',
                  _countElement('Leadership'),
                ),
                _metricRow(
                  'Planning',
                  _countElement('Planning'),
                ),
                _metricRow(
                  'Risk Management',
                  _countElement('Risk Management'),
                ),
                _metricRow(
                  'Operational Control',
                  _countElement('Operational Control'),
                ),
                _metricRow(
                  'Monitoring',
                  _countElement('Monitoring'),
                ),
                _metricRow(
                  'Improvement',
                  _countElement('Improvement'),
                ),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
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
      builder: (BuildContext dialogContext) => AlertDialog(
        title: const Text('Step 51 - HSE Management System Guide'),
        content: const SingleChildScrollView(
          child: Text(
            'Establish → Plan → Implement → Monitor → Audit → Improve → Review\n\n'
            '51A HSE Management System Master\n'
            '51B Leadership & HSE Policy Framework\n'
            '51C HSE Planning & Objectives Alignment\n'
            '51D Risk-Based Management System Controls\n'
            '51E Operational HSE Control Framework\n'
            '51F Resources, Roles & Competency Alignment\n'
            '51G Monitoring, Measurement & Evaluation\n'
            '51H Internal Audit & Management Assurance Link\n'
            '51I Corrective Action & Continual Improvement Link\n'
            '51J Management System Review & Approval\n'
            '51K HSE Management System History / Audit Trail\n'
            '51L HSE Management System Intelligence Dashboard\n\n'
            'UAE-wide HSE management system architecture designed '
            'to connect leadership, policy, objectives, risk, operations, '
            'competency, monitoring, audit, corrective action and continual improvement.',
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
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
        title: const Text('Step 51 - HSE Management System'),
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
        label: const Text('New HSE System'),
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
                    itemBuilder: (BuildContext itemContext, int index) {
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
            'HSE Management System Center',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: darkGreen,
            ),
          ),
          SizedBox(height: 5),
          Text(
            'Leadership - Policy - Planning - Risk - Operations - Assurance - Improvement',
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
            onChanged: (String value) {
              setState(() {
                _search = value;
              });
            },
            decoration: InputDecoration(
              hintText:
                  'Search system, owner, site, risk, controls...',
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
                      setState(() {
                        _statusFilter = value;
                      });
                    }
                  },
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: DropdownButtonFormField<String>(
                  initialValue: _elementFilter,
                  decoration: const InputDecoration(
                    labelText: 'System Element',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                  ),
                  items: <String>['All', ..._elements]
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
                      setState(() {
                        _elementFilter = value;
                      });
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
    final String element =
        item['element'] as String? ?? 'Leadership';
    final String status =
        item['status'] as String? ?? 'Draft';
    final String owner = item['owner'] as String? ?? '';
    final String site = item['site'] as String? ?? '';
    final String scope = item['scope'] as String? ?? '';

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 1,
      child: ExpansionTile(
        leading: CircleAvatar(
          backgroundColor: primaryGreen.withValues(alpha: 0.12),
          child: const Icon(
            Icons.account_tree_outlined,
            color: darkGreen,
          ),
        ),
        title: Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('$element - $status'),
        childrenPadding:
            const EdgeInsets.fromLTRB(16, 0, 16, 12),
        children: <Widget>[
          if (owner.isNotEmpty) _detailLine('System Owner', owner),
          if (site.isNotEmpty) _detailLine('Site / Location', site),
          if (scope.isNotEmpty) _detailLine('System Scope', scope),
          _detailLine(
            'Workflow',
            'Establish → Plan → Implement → Monitor → Audit → Improve → Review',
          ),
          _detailLine(
            'Integration',
            'Policy → Objectives → Risk → RAMS → PTW → Workforce → Training → Inspection → Incident → Action',
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
              Icons.account_tree_outlined,
              size: 62,
              color: darkGreen.withValues(alpha: 0.45),
            ),
            const SizedBox(height: 12),
            const Text(
              'No HSE management system records found',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Create the first HSE management system record.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _ManagementSystemFormDialog extends StatefulWidget {
  const _ManagementSystemFormDialog({this.existing});

  final Map<String, dynamic>? existing;

  @override
  State<_ManagementSystemFormDialog> createState() =>
      _ManagementSystemFormDialogState();
}

class _ManagementSystemFormDialogState
    extends State<_ManagementSystemFormDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final TextEditingController _name;
  late final TextEditingController _owner;
  late final TextEditingController _site;
  late final TextEditingController _scope;
  late final TextEditingController _policy;
  late final TextEditingController _objectives;
  late final TextEditingController _risks;
  late final TextEditingController _controls;
  late final TextEditingController _resources;
  late final TextEditingController _competency;
  late final TextEditingController _monitoring;
  late final TextEditingController _audit;
  late final TextEditingController _improvement;
  late final TextEditingController _reviewDate;
  late final TextEditingController _notes;

  String _element = 'Leadership';
  String _status = 'Draft';

  final List<String> _elements = <String>[
    'Leadership',
    'Policy',
    'Planning',
    'Risk Management',
    'Operational Control',
    'Competency',
    'Monitoring',
    'Improvement',
  ];

  final List<String> _statuses = <String>[
    'Draft',
    'Under Review',
    'Approved',
    'Active',
    'Needs Improvement',
    'Closed',
  ];

  @override
  void initState() {
    super.initState();

    final Map<String, dynamic> existing =
        widget.existing ?? <String, dynamic>{};

    _name = TextEditingController(
      text: existing['name'] as String? ?? '',
    );
    _owner = TextEditingController(
      text: existing['owner'] as String? ?? '',
    );
    _site = TextEditingController(
      text: existing['site'] as String? ?? '',
    );
    _scope = TextEditingController(
      text: existing['scope'] as String? ?? '',
    );
    _policy = TextEditingController(
      text: existing['policy'] as String? ?? '',
    );
    _objectives = TextEditingController(
      text: existing['objectives'] as String? ?? '',
    );
    _risks = TextEditingController(
      text: existing['risks'] as String? ?? '',
    );
    _controls = TextEditingController(
      text: existing['controls'] as String? ?? '',
    );
    _resources = TextEditingController(
      text: existing['resources'] as String? ?? '',
    );
    _competency = TextEditingController(
      text: existing['competency'] as String? ?? '',
    );
    _monitoring = TextEditingController(
      text: existing['monitoring'] as String? ?? '',
    );
    _audit = TextEditingController(
      text: existing['audit'] as String? ?? '',
    );
    _improvement = TextEditingController(
      text: existing['improvement'] as String? ?? '',
    );
    _reviewDate = TextEditingController(
      text: existing['reviewDate'] as String? ?? '',
    );
    _notes = TextEditingController(
      text: existing['notes'] as String? ?? '',
    );

    _element =
        existing['element'] as String? ?? 'Leadership';
    _status = existing['status'] as String? ?? 'Draft';
  }

  @override
  void dispose() {
    _name.dispose();
    _owner.dispose();
    _site.dispose();
    _scope.dispose();
    _policy.dispose();
    _objectives.dispose();
    _risks.dispose();
    _controls.dispose();
    _resources.dispose();
    _competency.dispose();
    _monitoring.dispose();
    _audit.dispose();
    _improvement.dispose();
    _reviewDate.dispose();
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
            ? 'New HSE Management System'
            : 'Edit HSE Management System',
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
                    'System / Framework Name *',
                    Icons.account_tree_outlined,
                  ),
                  validator: (String? value) =>
                      value == null || value.trim().isEmpty
                          ? 'Enter system name'
                          : null,
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  initialValue: _element,
                  decoration: _decoration(
                    'Primary System Element',
                    Icons.layers_outlined,
                  ),
                  items: _elements
                      .map(
                        (String value) => DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        ),
                      )
                      .toList(),
                  onChanged: (String? value) {
                    if (value != null) {
                      setState(() {
                        _element = value;
                      });
                    }
                  },
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  initialValue: _status,
                  decoration: _decoration(
                    'System Status',
                    Icons.verified_outlined,
                  ),
                  items: _statuses
                      .map(
                        (String value) => DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        ),
                      )
                      .toList(),
                  onChanged: (String? value) {
                    if (value != null) {
                      setState(() {
                        _status = value;
                      });
                    }
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _owner,
                  decoration: _decoration(
                    'System Owner / Responsible Person',
                    Icons.person_outline,
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _site,
                  decoration: _decoration(
                    'Site / Business Unit',
                    Icons.location_on_outlined,
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _scope,
                  maxLines: 2,
                  decoration: _decoration(
                    '51A System Scope',
                    Icons.work_outline,
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _policy,
                  maxLines: 3,
                  decoration: _decoration(
                    '51B HSE Policy / Leadership Framework',
                    Icons.policy_outlined,
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _objectives,
                  maxLines: 3,
                  decoration: _decoration(
                    '51C Objectives / Planning Alignment',
                    Icons.flag_outlined,
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _risks,
                  maxLines: 3,
                  decoration: _decoration(
                    '51D Risk-Based Management Controls',
                    Icons.warning_amber_outlined,
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _controls,
                  maxLines: 3,
                  decoration: _decoration(
                    '51E Operational HSE Controls',
                    Icons.security_outlined,
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _resources,
                  maxLines: 2,
                  decoration: _decoration(
                    '51F Resources / Roles',
                    Icons.inventory_2_outlined,
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _competency,
                  maxLines: 2,
                  decoration: _decoration(
                    '51F Competency / Authorization',
                    Icons.school_outlined,
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _monitoring,
                  maxLines: 3,
                  decoration: _decoration(
                    '51G Monitoring / Measurement',
                    Icons.monitor_heart_outlined,
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _audit,
                  maxLines: 3,
                  decoration: _decoration(
                    '51H Audit / Assurance',
                    Icons.fact_check_outlined,
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _improvement,
                  maxLines: 3,
                  decoration: _decoration(
                    '51I Corrective Action / Continual Improvement',
                    Icons.trending_up_outlined,
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _reviewDate,
                  decoration: _decoration(
                    '51J Management System Review Date',
                    Icons.calendar_today_outlined,
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _notes,
                  maxLines: 3,
                  decoration: _decoration(
                    '51K History / Audit Notes',
                    Icons.notes_outlined,
                  ),
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
      'element': _element,
      'status': _status,
      'owner': _owner.text.trim(),
      'site': _site.text.trim(),
      'scope': _scope.text.trim(),
      'policy': _policy.text.trim(),
      'objectives': _objectives.text.trim(),
      'risks': _risks.text.trim(),
      'controls': _controls.text.trim(),
      'resources': _resources.text.trim(),
      'competency': _competency.text.trim(),
      'monitoring': _monitoring.text.trim(),
      'audit': _audit.text.trim(),
      'improvement': _improvement.text.trim(),
      'reviewDate': _reviewDate.text.trim(),
      'notes': _notes.text.trim(),
    });
  }
}
