import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SafeNexusStep49TrainingSafetyCulturePage extends StatefulWidget {
  const SafeNexusStep49TrainingSafetyCulturePage({super.key});

  @override
  State<SafeNexusStep49TrainingSafetyCulturePage> createState() =>
      _SafeNexusStep49TrainingSafetyCulturePageState();
}

class _SafeNexusStep49TrainingSafetyCulturePageState
    extends State<SafeNexusStep49TrainingSafetyCulturePage> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);
  static const String storageKey =
      'safenexus_hse_step49_training_safety_culture';

  final List<Map<String, dynamic>> _records = <Map<String, dynamic>>[];

  String _search = '';
  String _statusFilter = 'All';
  String _categoryFilter = 'All';

  final List<String> _statuses = <String>[
    'Planned',
    'Scheduled',
    'In Progress',
    'Completed',
    'Evaluation Due',
    'Closed',
  ];

  final List<String> _categories = <String>[
    'Training',
    'Training Needs Analysis',
    'Annual Training Plan',
    'Toolbox Talk',
    'Induction',
    'Refresher Training',
    'Competency Development',
    'Assessment',
    'Safety Campaign',
    'Safety Culture',
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
              'category': 'Training',
              'status': 'Planned',
              'priority': 'Medium',
              'audience': '',
              'trainer': '',
              'date': '',
              'dueDate': '',
              'location': '',
              'needs': '',
              'objective': '',
              'content': '',
              'attendance': '',
              'assessment': '',
              'effectiveness': '',
              'culture': '',
              'actions': '',
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
        item['priority'],
        item['audience'],
        item['trainer'],
        item['content'],
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
          _TrainingFormDialog(existing: existing),
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
        title: const Text('Delete Training Record?'),
        content: const Text(
          'This training, learning or safety culture record will be deleted.',
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
        title: const Text('49L — Learning & Safety Culture Dashboard'),
        content: SizedBox(
          width: 440,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _metricRow('Total Records', _records.length),
                _metricRow('Planned', _countStatus('Planned')),
                _metricRow('Scheduled', _countStatus('Scheduled')),
                _metricRow('In Progress', _countStatus('In Progress')),
                _metricRow('Completed', _countStatus('Completed')),
                _metricRow('Evaluation Due', _countStatus('Evaluation Due')),
                _metricRow('Closed', _countStatus('Closed')),
                const Divider(),
                _metricRow('Training', _countCategory('Training')),
                _metricRow(
                  'Toolbox Talks',
                  _countCategory('Toolbox Talk'),
                ),
                _metricRow(
                  'Induction',
                  _countCategory('Induction'),
                ),
                _metricRow(
                  'Safety Campaigns',
                  _countCategory('Safety Campaign'),
                ),
                _metricRow(
                  'Safety Culture',
                  _countCategory('Safety Culture'),
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
        title: const Text('Step 49 — Training & Safety Culture Guide'),
        content: const SingleChildScrollView(
          child: Text(
            'Identify Need → Plan → Train → Assess → Verify Competency → '
            'Engage → Evaluate Effectiveness → Improve → Close → Analyze\n\n'
            '49A HSE Training Master\n'
            '49B Training Needs Analysis (TNA)\n'
            '49C Annual Training Plan\n'
            '49D Toolbox Talk & Safety Learning\n'
            '49E Induction & Refresher Training\n'
            '49F Competency Development\n'
            '49G Training Attendance & Records\n'
            '49H Assessment & Effectiveness Evaluation\n'
            '49I Safety Awareness Campaigns\n'
            '49J Safety Culture & Workforce Engagement\n'
            '49K Training History / Audit Trail\n'
            '49L HSE Learning & Safety Culture Intelligence Dashboard\n\n'
            'UAE-wide HSE learning architecture for workforce development, '
            'competency, awareness and continual safety culture improvement.',
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
        title: const Text('Step 49 • Training & Safety Culture'),
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
        label: const Text('New Training'),
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
            'HSE Training, Learning & Safety Culture Center',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: darkGreen,
            ),
          ),
          SizedBox(height: 5),
          Text(
            'പരിശീലനം • Competency • Learning • Awareness • Safety Culture',
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
              hintText: 'Search training, trainer, audience, actions...',
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
    final String category = item['category'] as String? ?? 'Training';
    final String status = item['status'] as String? ?? 'Planned';
    final String priority = item['priority'] as String? ?? 'Medium';
    final String audience = item['audience'] as String? ?? '';
    final String trainer = item['trainer'] as String? ?? '';
    final String date = item['date'] as String? ?? '';

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 1,
      child: ExpansionTile(
        leading: CircleAvatar(
          backgroundColor: primaryGreen.withValues(alpha: 0.12),
          child: const Icon(
            Icons.school_outlined,
            color: darkGreen,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          '$category • $status • $priority${date.isEmpty ? '' : ' • $date'}',
        ),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
        children: <Widget>[
          if (audience.isNotEmpty) _detailLine('Audience', audience),
          if (trainer.isNotEmpty) _detailLine('Trainer / Facilitator', trainer),
          _detailLine(
            'Workflow',
            'Need → Plan → Train → Assess → Evaluate → Improve → Close',
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
              Icons.school_outlined,
              size: 62,
              color: darkGreen.withValues(alpha: 0.45),
            ),
            const SizedBox(height: 12),
            const Text(
              'No training or safety culture records found',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Create the first HSE training, learning or safety culture record.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _TrainingFormDialog extends StatefulWidget {
  const _TrainingFormDialog({this.existing});

  final Map<String, dynamic>? existing;

  @override
  State<_TrainingFormDialog> createState() => _TrainingFormDialogState();
}

class _TrainingFormDialogState extends State<_TrainingFormDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final TextEditingController _title;
  late final TextEditingController _audience;
  late final TextEditingController _trainer;
  late final TextEditingController _date;
  late final TextEditingController _dueDate;
  late final TextEditingController _location;
  late final TextEditingController _needs;
  late final TextEditingController _objective;
  late final TextEditingController _content;
  late final TextEditingController _attendance;
  late final TextEditingController _assessment;
  late final TextEditingController _effectiveness;
  late final TextEditingController _culture;
  late final TextEditingController _actions;
  late final TextEditingController _notes;

  String _category = 'Training';
  String _status = 'Planned';
  String _priority = 'Medium';

  final List<String> _categories = <String>[
    'Training',
    'Training Needs Analysis',
    'Annual Training Plan',
    'Toolbox Talk',
    'Induction',
    'Refresher Training',
    'Competency Development',
    'Assessment',
    'Safety Campaign',
    'Safety Culture',
  ];

  final List<String> _statuses = <String>[
    'Planned',
    'Scheduled',
    'In Progress',
    'Completed',
    'Evaluation Due',
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
    _audience = TextEditingController(text: e['audience'] as String? ?? '');
    _trainer = TextEditingController(text: e['trainer'] as String? ?? '');
    _date = TextEditingController(text: e['date'] as String? ?? '');
    _dueDate = TextEditingController(text: e['dueDate'] as String? ?? '');
    _location = TextEditingController(text: e['location'] as String? ?? '');
    _needs = TextEditingController(text: e['needs'] as String? ?? '');
    _objective = TextEditingController(text: e['objective'] as String? ?? '');
    _content = TextEditingController(text: e['content'] as String? ?? '');
    _attendance =
        TextEditingController(text: e['attendance'] as String? ?? '');
    _assessment =
        TextEditingController(text: e['assessment'] as String? ?? '');
    _effectiveness =
        TextEditingController(text: e['effectiveness'] as String? ?? '');
    _culture = TextEditingController(text: e['culture'] as String? ?? '');
    _actions = TextEditingController(text: e['actions'] as String? ?? '');
    _notes = TextEditingController(text: e['notes'] as String? ?? '');

    _category = e['category'] as String? ?? 'Training';
    _status = e['status'] as String? ?? 'Planned';
    _priority = e['priority'] as String? ?? 'Medium';
  }

  @override
  void dispose() {
    _title.dispose();
    _audience.dispose();
    _trainer.dispose();
    _date.dispose();
    _dueDate.dispose();
    _location.dispose();
    _needs.dispose();
    _objective.dispose();
    _content.dispose();
    _attendance.dispose();
    _assessment.dispose();
    _effectiveness.dispose();
    _culture.dispose();
    _actions.dispose();
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
            ? 'New HSE Training / Learning Record'
            : 'Edit HSE Training / Learning Record',
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
                  decoration: _decoration(
                    'Training / Initiative Title *',
                    Icons.title,
                  ),
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
                  controller: _audience,
                  decoration:
                      _decoration('49A / Target Workforce', Icons.groups_outlined),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _trainer,
                  decoration:
                      _decoration('Trainer / Facilitator', Icons.person_outline),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _date,
                  decoration:
                      _decoration('Training / Activity Date', Icons.calendar_today_outlined),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _dueDate,
                  decoration:
                      _decoration('49C / Evaluation Due Date', Icons.event_available_outlined),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _location,
                  decoration:
                      _decoration('Location / Site', Icons.location_on_outlined),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _needs,
                  maxLines: 2,
                  decoration:
                      _decoration('49B Training Need / TNA', Icons.find_in_page_outlined),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _objective,
                  maxLines: 2,
                  decoration:
                      _decoration('Learning Objective / Competency Goal', Icons.flag_circle_outlined),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _content,
                  maxLines: 3,
                  decoration:
                      _decoration('49D–49F Training / Learning Content', Icons.menu_book_outlined),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _attendance,
                  maxLines: 2,
                  decoration:
                      _decoration('49G Attendance / Participation Record', Icons.fact_check_outlined),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _assessment,
                  maxLines: 2,
                  decoration:
                      _decoration('49H Assessment / Competency Result', Icons.assignment_turned_in_outlined),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _effectiveness,
                  maxLines: 2,
                  decoration:
                      _decoration('49H Effectiveness Evaluation', Icons.assessment_outlined),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _culture,
                  maxLines: 2,
                  decoration:
                      _decoration('49I–49J Awareness / Safety Culture Impact', Icons.volunteer_activism_outlined),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _actions,
                  maxLines: 3,
                  decoration:
                      _decoration('Improvement / Follow-up Actions', Icons.task_alt_outlined),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _notes,
                  maxLines: 3,
                  decoration:
                      _decoration('49K History / Notes', Icons.notes_outlined),
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
      'audience': _audience.text.trim(),
      'trainer': _trainer.text.trim(),
      'date': _date.text.trim(),
      'dueDate': _dueDate.text.trim(),
      'location': _location.text.trim(),
      'needs': _needs.text.trim(),
      'objective': _objective.text.trim(),
      'content': _content.text.trim(),
      'attendance': _attendance.text.trim(),
      'assessment': _assessment.text.trim(),
      'effectiveness': _effectiveness.text.trim(),
      'culture': _culture.text.trim(),
      'actions': _actions.text.trim(),
      'notes': _notes.text.trim(),
    });
  }
}
