import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SafeNexusStep47ManagementReviewPage extends StatefulWidget {
  const SafeNexusStep47ManagementReviewPage({super.key});

  @override
  State<SafeNexusStep47ManagementReviewPage> createState() =>
      _SafeNexusStep47ManagementReviewPageState();
}

class _SafeNexusStep47ManagementReviewPageState
    extends State<SafeNexusStep47ManagementReviewPage> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);
  static const String storageKey =
      'safenexus_hse_step47_management_review';

  final List<Map<String, dynamic>> _records = <Map<String, dynamic>>[];
  String _search = '';
  String _statusFilter = 'All';
  String _reviewTypeFilter = 'All';

  final List<String> _statuses = <String>[
    'Planned',
    'In Progress',
    'Completed',
    'Follow-up',
    'Closed',
  ];

  final List<String> _reviewTypes = <String>[
    'Management Review',
    'Quarterly Review',
    'Annual Review',
    'Performance Review',
    'Governance Review',
    'Special Review',
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
          saved.map((String item) => <String, dynamic>{
                'id': DateTime.now().microsecondsSinceEpoch.toString(),
                'title': item,
                'reviewType': 'Management Review',
                'status': 'Planned',
                'date': '',
                'chairperson': '',
                'objectives': '',
                'kpiSummary': '',
                'decisions': '',
                'actions': '',
                'owner': '',
                'targetDate': '',
                'notes': '',
                'createdAt': DateTime.now().toIso8601String(),
              }),
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
      final String text = [
        item['title'],
        item['reviewType'],
        item['chairperson'],
        item['owner'],
        item['decisions'],
      ].join(' ').toLowerCase();
      final bool matchesSearch =
          _search.trim().isEmpty || text.contains(_search.toLowerCase());
      final bool matchesStatus =
          _statusFilter == 'All' || item['status'] == _statusFilter;
      final bool matchesType = _reviewTypeFilter == 'All' ||
          item['reviewType'] == _reviewTypeFilter;
      return matchesSearch && matchesStatus && matchesType;
    }).toList();
  }

  int _statusCount(String status) {
    return _records.where((Map<String, dynamic> e) => e['status'] == status).length;
  }

  int _closedCount() => _statusCount('Closed');
  int _openCount() => _records.length - _closedCount();

  Future<void> _addOrEdit({Map<String, dynamic>? existing}) async {
    final Map<String, dynamic>? result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (BuildContext context) =>
          _ReviewFormDialog(existing: existing),
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

  void _showDashboard() {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('47L — Governance Intelligence Dashboard'),
        content: SizedBox(
          width: 420,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _metricRow('Total Reviews', _records.length),
              _metricRow('Open / Active', _openCount()),
              _metricRow('Closed', _closedCount()),
              _metricRow('Planned', _statusCount('Planned')),
              _metricRow('In Progress', _statusCount('In Progress')),
              _metricRow('Follow-up', _statusCount('Follow-up')),
            ],
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
          style: const TextStyle(color: Colors.white, fontSize: 12),
        ),
      ),
    );
  }

  void _showGuide() {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Step 47 — Management Review Guide'),
        content: const SingleChildScrollView(
          child: Text(
            'Collect → Review → Evaluate → Decide → Assign → Act → Verify → Close → Improve → Analyze\n\n'
            '47A Management Review Master\n'
            '47B Review Planning & Agenda\n'
            '47C HSE KPI & Performance Review\n'
            '47D Risk / Incident / Audit / Compliance Review\n'
            '47E HSE Objectives & Targets\n'
            '47F Management Decisions & Actions\n'
            '47G Resource & Competency Review\n'
            '47H Improvement Opportunities\n'
            '47I Review Approval & Follow-up\n'
            '47J Management Action Tracking\n'
            '47K Review History / Governance Trail\n'
            '47L Governance Intelligence Dashboard\n\n'
            'UAE-wide HSE governance structure for management review, decisions, '
            'performance monitoring and continual improvement.',
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
        title: const Text('Step 47 • Management Review'),
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
        label: const Text('New Review'),
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
            'HSE Management Review, Governance & Performance Center',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: darkGreen,
            ),
          ),
          SizedBox(height: 5),
          Text(
            'മാനേജ്മെന്റ് റിവ്യൂ • Governance • Performance • Continual Improvement',
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
              hintText: 'Search reviews, chairperson, owner, decisions...',
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
                  initialValue: _reviewTypeFilter,
                  decoration: const InputDecoration(
                    labelText: 'Review Type',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                  ),
                  items: <String>['All', ..._reviewTypes]
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
                      setState(() => _reviewTypeFilter = value);
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
    final String status = item['status'] as String? ?? 'Planned';
    final String title = item['title'] as String? ?? 'Untitled Review';
    final String reviewType =
        item['reviewType'] as String? ?? 'Management Review';
    final String date = item['date'] as String? ?? '';
    final String owner = item['owner'] as String? ?? '';
    final String decisions = item['decisions'] as String? ?? '';

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 1,
      child: ExpansionTile(
        leading: CircleAvatar(
          backgroundColor: primaryGreen.withValues(alpha: 0.12),
          child: const Icon(Icons.gavel_outlined, color: darkGreen),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('$reviewType • $status${date.isEmpty ? '' : ' • $date'}'),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
        children: <Widget>[
          if (owner.isNotEmpty)
            _detailLine('Owner / Responsible', owner),
          if (decisions.isNotEmpty)
            _detailLine('Management Decisions', decisions),
          _detailLine(
            'Workflow',
            'Collect → Review → Evaluate → Decide → Act → Verify → Close',
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

  Future<void> _confirmDelete(Map<String, dynamic> item) async {
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Delete Review?'),
        content: const Text('This management review record will be deleted.'),
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

  Widget _emptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.assessment_outlined,
                size: 62, color: darkGreen.withValues(alpha: 0.45)),
            const SizedBox(height: 12),
            const Text(
              'No management reviews found',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            const Text(
              'Create the first HSE management review to start governance tracking.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _ReviewFormDialog extends StatefulWidget {
  const _ReviewFormDialog({this.existing});

  final Map<String, dynamic>? existing;

  @override
  State<_ReviewFormDialog> createState() => _ReviewFormDialogState();
}

class _ReviewFormDialogState extends State<_ReviewFormDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _title;
  late final TextEditingController _date;
  late final TextEditingController _chairperson;
  late final TextEditingController _objectives;
  late final TextEditingController _kpiSummary;
  late final TextEditingController _decisions;
  late final TextEditingController _actions;
  late final TextEditingController _owner;
  late final TextEditingController _targetDate;
  late final TextEditingController _notes;

  String _status = 'Planned';
  String _reviewType = 'Management Review';

  final List<String> _statuses = <String>[
    'Planned',
    'In Progress',
    'Completed',
    'Follow-up',
    'Closed',
  ];

  final List<String> _reviewTypes = <String>[
    'Management Review',
    'Quarterly Review',
    'Annual Review',
    'Performance Review',
    'Governance Review',
    'Special Review',
  ];

  @override
  void initState() {
    super.initState();
    final Map<String, dynamic> e = widget.existing ?? <String, dynamic>{};
    _title = TextEditingController(text: e['title'] as String? ?? '');
    _date = TextEditingController(text: e['date'] as String? ?? '');
    _chairperson =
        TextEditingController(text: e['chairperson'] as String? ?? '');
    _objectives =
        TextEditingController(text: e['objectives'] as String? ?? '');
    _kpiSummary =
        TextEditingController(text: e['kpiSummary'] as String? ?? '');
    _decisions =
        TextEditingController(text: e['decisions'] as String? ?? '');
    _actions = TextEditingController(text: e['actions'] as String? ?? '');
    _owner = TextEditingController(text: e['owner'] as String? ?? '');
    _targetDate =
        TextEditingController(text: e['targetDate'] as String? ?? '');
    _notes = TextEditingController(text: e['notes'] as String? ?? '');
    _status = e['status'] as String? ?? 'Planned';
    _reviewType = e['reviewType'] as String? ?? 'Management Review';
  }

  @override
  void dispose() {
    _title.dispose();
    _date.dispose();
    _chairperson.dispose();
    _objectives.dispose();
    _kpiSummary.dispose();
    _decisions.dispose();
    _actions.dispose();
    _owner.dispose();
    _targetDate.dispose();
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
        widget.existing == null ? 'New Management Review' : 'Edit Management Review',
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
                  decoration: _decoration('Review Title *', Icons.title),
                  validator: (String? value) =>
                      value == null || value.trim().isEmpty
                          ? 'Enter review title'
                          : null,
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  initialValue: _reviewType,
                  decoration:
                      _decoration('Review Type', Icons.category_outlined),
                  items: _reviewTypes
                      .map(
                        (String value) => DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        ),
                      )
                      .toList(),
                  onChanged: (String? value) {
                    if (value != null) setState(() => _reviewType = value);
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
                TextFormField(
                  controller: _date,
                  decoration:
                      _decoration('Review Date', Icons.calendar_today_outlined),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _chairperson,
                  decoration:
                      _decoration('Chairperson / Top Management', Icons.person_outline),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _objectives,
                  maxLines: 2,
                  decoration:
                      _decoration('47E Objectives & Targets', Icons.flag_circle_outlined),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _kpiSummary,
                  maxLines: 3,
                  decoration:
                      _decoration('47C KPI / Performance Review', Icons.analytics_outlined),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _decisions,
                  maxLines: 3,
                  decoration:
                      _decoration('47F Management Decisions', Icons.gavel_outlined),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _actions,
                  maxLines: 3,
                  decoration:
                      _decoration('47J Management Actions', Icons.task_alt_outlined),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _owner,
                  decoration:
                      _decoration('Action Owner / Responsible Person', Icons.person_pin_outlined),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _targetDate,
                  decoration:
                      _decoration('Target / Follow-up Date', Icons.event_available_outlined),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _notes,
                  maxLines: 3,
                  decoration:
                      _decoration('Notes / Improvement Opportunities', Icons.notes_outlined),
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
      'reviewType': _reviewType,
      'status': _status,
      'date': _date.text.trim(),
      'chairperson': _chairperson.text.trim(),
      'objectives': _objectives.text.trim(),
      'kpiSummary': _kpiSummary.text.trim(),
      'decisions': _decisions.text.trim(),
      'actions': _actions.text.trim(),
      'owner': _owner.text.trim(),
      'targetDate': _targetDate.text.trim(),
      'notes': _notes.text.trim(),
    });
  }
}
