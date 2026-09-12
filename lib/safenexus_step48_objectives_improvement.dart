import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SafeNexusStep48ObjectivesImprovementPage extends StatefulWidget {
  const SafeNexusStep48ObjectivesImprovementPage({super.key});

  @override
  State<SafeNexusStep48ObjectivesImprovementPage> createState() =>
      _SafeNexusStep48ObjectivesImprovementPageState();
}

class _SafeNexusStep48ObjectivesImprovementPageState
    extends State<SafeNexusStep48ObjectivesImprovementPage> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);
  static const String storageKey =
      'safenexus_hse_step48_objectives_improvement';

  final List<Map<String, dynamic>> _records = <Map<String, dynamic>>[];

  String _search = '';
  String _statusFilter = 'All';
  String _categoryFilter = 'All';

  final List<String> _statuses = <String>[
    'Planned',
    'In Progress',
    'At Risk',
    'Completed',
    'Closed',
  ];

  final List<String> _categories = <String>[
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

  Future<void> _saveRecords() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> titles =
        _records.map((Map<String, dynamic> e) => e['title'] as String).toList();
    await prefs.setStringList(storageKey, titles);
  }

  List<Map<String, dynamic>> get _filteredRecords {
    return _records.where((Map<String, dynamic> item) {
      final String searchable = <String>[
        item['title'],
        item['category'],
        item['status'],
        item['owner'],
        item['strategy'],
        item['actions'],
      ].join(' ').toLowerCase();

      final bool matchesSearch =
          _search.trim().isEmpty || searchable.contains(_search.toLowerCase());
      final bool matchesStatus =
          _statusFilter == 'All' || item['status'] == _statusFilter;
      final bool matchesCategory =
          _categoryFilter == 'All' || item['category'] == _categoryFilter;

      return matchesSearch && matchesStatus && matchesCategory;
    }).toList();
  }

  int _countStatus(String status) {
    return _records
        .where((Map<String, dynamic> item) => item['status'] == status)
        .length;
  }

  int _countCategory(String category) {
    return _records
        .where((Map<String, dynamic> item) => item['category'] == category)
        .length;
  }

  Future<void> _addOrEdit({Map<String, dynamic>? existing}) async {
    final Map<String, dynamic>? result =
        await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (BuildContext context) =>
          _ObjectiveFormDialog(existing: existing),
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
      await _delete(item);
    }
  }

  void _showDashboard() {
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
                _metricRow('Total Records', _records.length),
                _metricRow('Planned', _countStatus('Planned')),
                _metricRow('In Progress', _countStatus('In Progress')),
                _metricRow('At Risk', _countStatus('At Risk')),
                _metricRow('Completed', _countStatus('Completed')),
                _metricRow('Closed', _countStatus('Closed')),
                const Divider(),
                _metricRow('Objectives', _countCategory('Objective')),
                _metricRow(
                  'Improvement Initiatives',
                  _countCategory('Improvement Initiative'),
                ),
                _metricRow(
                  'Improvement Actions',
                  _countCategory('Improvement Action'),
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
    final List<Map<String, dynamic>> records = _filteredRecords;

    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
        title: const Text('Step 48 • Objectives & Improvement'),
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
        label: const Text('New Objective'),
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

  Widget _filters() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: <Widget>[
          TextField(
            onChanged: (String value) => setState(() => _search = value),
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
                  initialValue: _categoryFilter,
                  decoration: const InputDecoration(
                    labelText: 'Category',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                  ),
                  items: <String>['All', ..._categories]
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
                      setState(() => _categoryFilter = value);
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
          if (owner.isNotEmpty) _detailLine('Owner', owner),
          if (target.isNotEmpty) _detailLine('Target', target),
          _detailLine(
            'Workflow',
            'Set → Plan → Measure → Improve → Verify → Review → Close',
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

  Widget _emptyState() {
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

class _ObjectiveFormDialog extends StatefulWidget {
  const _ObjectiveFormDialog({this.existing});

  final Map<String, dynamic>? existing;

  @override
  State<_ObjectiveFormDialog> createState() => _ObjectiveFormDialogState();
}

class _ObjectiveFormDialogState extends State<_ObjectiveFormDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final TextEditingController _title;
  late final TextEditingController _owner;
  late final TextEditingController _target;
  late final TextEditingController _current;
  late final TextEditingController _dueDate;
  late final TextEditingController _strategy;
  late final TextEditingController _gap;
  late final TextEditingController _actions;
  late final TextEditingController _resources;
  late final TextEditingController _verification;
  late final TextEditingController _notes;

  String _category = 'Objective';
  String _status = 'Planned';
  String _priority = 'Medium';

  final List<String> _categories = <String>[
    'Objective',
    'Strategic Priority',
    'KPI Target',
    'Improvement Initiative',
    'Improvement Action',
    'Resource Plan',
  ];

  final List<String> _statuses = <String>[
    'Planned',
    'In Progress',
    'At Risk',
    'Completed',
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

    _title = TextEditingController(text: e['title'] as String? ?? '');
    _owner = TextEditingController(text: e['owner'] as String? ?? '');
    _target = TextEditingController(text: e['target'] as String? ?? '');
    _current = TextEditingController(text: e['current'] as String? ?? '');
    _dueDate = TextEditingController(text: e['dueDate'] as String? ?? '');
    _strategy = TextEditingController(text: e['strategy'] as String? ?? '');
    _gap = TextEditingController(text: e['gap'] as String? ?? '');
    _actions = TextEditingController(text: e['actions'] as String? ?? '');
    _resources = TextEditingController(text: e['resources'] as String? ?? '');
    _verification =
        TextEditingController(text: e['verification'] as String? ?? '');
    _notes = TextEditingController(text: e['notes'] as String? ?? '');

    _category = e['category'] as String? ?? 'Objective';
    _status = e['status'] as String? ?? 'Planned';
    _priority = e['priority'] as String? ?? 'Medium';
  }

  @override
  void dispose() {
    _title.dispose();
    _owner.dispose();
    _target.dispose();
    _current.dispose();
    _dueDate.dispose();
    _strategy.dispose();
    _gap.dispose();
    _actions.dispose();
    _resources.dispose();
    _verification.dispose();
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
            ? 'New HSE Objective / Improvement'
            : 'Edit HSE Objective / Improvement',
      ),
      content: SizedBox(
        width: 520,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: _title,
                  decoration:
                      _decoration('Objective / Initiative Title *', Icons.title),
                  validator: (String? value) =>
                      value == null || value.trim().isEmpty
                          ? 'Enter a title'
                          : null,
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  initialValue: _category,
                  decoration:
                      _decoration('Category', Icons.category_outlined),
                  items: _categories
                      .map(
                        (String value) => DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        ),
                      )
                      .toList(),
                  onChanged: (String? value) {
                    if (value != null) setState(() => _category = value);
                  },
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  initialValue: _status,
                  decoration:
                      _decoration('Status', Icons.flag_outlined),
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
                      _decoration('Priority', Icons.priority_high_outlined),
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
                  controller: _owner,
                  decoration:
                      _decoration('Owner / Responsible Person', Icons.person_outline),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _strategy,
                  maxLines: 2,
                  decoration:
                      _decoration('48B Strategy / Strategic Priority', Icons.explore_outlined),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _target,
                  decoration:
                      _decoration('48C Target / KPI Target', Icons.flag_circle_outlined),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _current,
                  decoration:
                      _decoration('48D Current Performance / Measure', Icons.analytics_outlined),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _gap,
                  maxLines: 2,
                  decoration:
                      _decoration('48H Performance Gap / Opportunity', Icons.compare_arrows_outlined),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _actions,
                  maxLines: 3,
                  decoration:
                      _decoration('48F Improvement Action Plan', Icons.task_alt_outlined),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _resources,
                  maxLines: 2,
                  decoration:
                      _decoration('48G Resources / Budget Requirement', Icons.account_balance_outlined),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _verification,
                  maxLines: 2,
                  decoration:
                      _decoration('48I Verification / Effectiveness', Icons.verified_outlined),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _dueDate,
                  decoration:
                      _decoration('Target / Review Date', Icons.event_available_outlined),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _notes,
                  maxLines: 3,
                  decoration:
                      _decoration('48J / 48K Review Notes & History', Icons.notes_outlined),
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
      'title': _title.text.trim(),
      'category': _category,
      'status': _status,
      'priority': _priority,
      'owner': _owner.text.trim(),
      'target': _target.text.trim(),
      'current': _current.text.trim(),
      'dueDate': _dueDate.text.trim(),
      'strategy': _strategy.text.trim(),
      'gap': _gap.text.trim(),
      'actions': _actions.text.trim(),
      'resources': _resources.text.trim(),
      'verification': _verification.text.trim(),
      'notes': _notes.text.trim(),
    });
  }
}
