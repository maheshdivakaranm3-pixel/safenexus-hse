import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SafeNexusSteps51To60AdvancedHSEPage extends StatefulWidget {
  const SafeNexusSteps51To60AdvancedHSEPage({super.key});

  @override
  State<SafeNexusSteps51To60AdvancedHSEPage> createState() =>
      _SafeNexusSteps51To60AdvancedHSEPageState();
}

class _SafeNexusSteps51To60AdvancedHSEPageState
    extends State<SafeNexusSteps51To60AdvancedHSEPage> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);
  static const String storageKey =
      'safenexus_hse_steps51_60_advanced_hse';

  final List<Map<String, dynamic>> _records =
      <Map<String, dynamic>>[];

  String _search = '';
  String _stepFilter = 'All';
  String _statusFilter = 'All';

  final List<String> _steps = <String>[
    '51 - HSE Management System',
    '52 - HSE Leadership & Governance',
    '53 - Integrated HSE Planning & Control',
    '54 - HSE Performance & KPI Management',
    '55 - HSE Risk Intelligence & Predictive Control',
    '56 - Operational HSE Excellence',
    '57 - HSE Assurance & Compliance Intelligence',
    '58 - Continual Improvement & Change Management',
    '59 - HSE Management Review & Strategic Decisions',
    '60 - Advanced HSE Command Center & Intelligence',
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
              'step': _steps.first,
              'status': 'Draft',
              'owner': '',
              'site': '',
              'scope': '',
              'objective': '',
              'risk': '',
              'control': '',
              'kpi': '',
              'assurance': '',
              'improvement': '',
              'decision': '',
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
        item['step'] as String? ?? '',
        item['status'] as String? ?? '',
        item['owner'] as String? ?? '',
        item['site'] as String? ?? '',
        item['scope'] as String? ?? '',
        item['objective'] as String? ?? '',
        item['risk'] as String? ?? '',
        item['control'] as String? ?? '',
        item['kpi'] as String? ?? '',
        item['assurance'] as String? ?? '',
        item['improvement'] as String? ?? '',
        item['decision'] as String? ?? '',
      ].join(' ').toLowerCase();

      final bool matchesSearch =
          query.isEmpty || searchable.contains(query);
      final bool matchesStep =
          _stepFilter == 'All' || item['step'] == _stepFilter;
      final bool matchesStatus =
          _statusFilter == 'All' || item['status'] == _statusFilter;

      return matchesSearch && matchesStep && matchesStatus;
    }).toList();
  }

  int _countStep(String step) {
    return _records
        .where((Map<String, dynamic> item) => item['step'] == step)
        .length;
  }

  int _countStatus(String status) {
    return _records
        .where((Map<String, dynamic> item) => item['status'] == status)
        .length;
  }

  Future<void> _addOrEdit({
    Map<String, dynamic>? existing,
  }) async {
    final Map<String, dynamic>? result =
        await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (BuildContext dialogContext) =>
          _AdvancedHSEFormDialog(existing: existing),
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
        title: const Text('Delete Advanced HSE Record?'),
        content: const Text(
          'This Advanced HSE Management record will be deleted.',
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
        title: const Text('51-60 Advanced HSE Dashboard'),
        content: SizedBox(
          width: 460,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _metricRow('Total Records', _records.length),
                _metricRow('Active', _countStatus('Active')),
                _metricRow(
                  'Under Review',
                  _countStatus('Under Review'),
                ),
                _metricRow(
                  'Needs Improvement',
                  _countStatus('Needs Improvement'),
                ),
                const Divider(),
                for (final String step in _steps)
                  _metricRow(
                    step.split(' - ').first,
                    _countStep(step),
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

  void _showGuide() {
    showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) => AlertDialog(
        title: const Text('Steps 51-60 - Advanced HSE Guide'),
        content: const SingleChildScrollView(
          child: Text(
            'Advanced HSE Management Framework\n\n'
            '51 - HSE Management System\n'
            'Leadership, policy, planning, operational control, monitoring and improvement.\n\n'
            '52 - HSE Leadership & Governance\n'
            'Leadership responsibilities, governance, accountability and decision ownership.\n\n'
            '53 - Integrated HSE Planning & Control\n'
            'Integrated objectives, plans, resources, risks and operational controls.\n\n'
            '54 - HSE Performance & KPI Management\n'
            'KPI, targets, leading indicators, lagging indicators and performance trends.\n\n'
            '55 - HSE Risk Intelligence & Predictive Control\n'
            'Risk trends, emerging hazards, control effectiveness and predictive indicators.\n\n'
            '56 - Operational HSE Excellence\n'
            'Field execution, critical controls, work assurance and operational discipline.\n\n'
            '57 - HSE Assurance & Compliance Intelligence\n'
            'Audit, inspection, legal compliance, findings and assurance status.\n\n'
            '58 - Continual Improvement & Change Management\n'
            'Improvement initiatives, lessons learned, change control and effectiveness.\n\n'
            '59 - HSE Management Review & Strategic Decisions\n'
            'Management review, performance evaluation, priorities, resources and decisions.\n\n'
            '60 - Advanced HSE Command Center & Intelligence\n'
            'Executive dashboard, integrated indicators, alerts, trends and decision support.\n\n'
            'UAE-wide architecture linked with Risk, RAMS, PTW, Workforce, Equipment, '
            'Inspection, Emergency, Environmental, Incident, Audit, Legal, Training, '
            'Contractor, Action and Objectives modules.',
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
        title: const Text('Steps 51-60 - Advanced HSE'),
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
        label: const Text('New HSE Record'),
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
            'Advanced HSE Management Center',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: darkGreen,
            ),
          ),
          SizedBox(height: 5),
          Text(
            'Steps 51-60 - Leadership - Planning - Risk - Performance - Assurance - Intelligence',
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
                  'Search HSE system, owner, site, risk, KPI...',
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
                  initialValue: _stepFilter,
                  decoration: const InputDecoration(
                    labelText: 'Step',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                  ),
                  items: <String>['All', ..._steps]
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
                        _stepFilter = value;
                      });
                    }
                  },
                ),
              ),
              const SizedBox(width: 8),
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
            ],
          ),
        ],
      ),
    );
  }

  Widget _recordCard(Map<String, dynamic> item) {
    final String name = item['name'] as String? ?? 'Unnamed';
    final String step =
        item['step'] as String? ?? _steps.first;
    final String status =
        item['status'] as String? ?? 'Draft';
    final String owner = item['owner'] as String? ?? '';
    final String site = item['site'] as String? ?? '';
    final String scope = item['scope'] as String? ?? '';
    final String kpi = item['kpi'] as String? ?? '';
    final String improvement =
        item['improvement'] as String? ?? '';

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 1,
      child: ExpansionTile(
        leading: CircleAvatar(
          backgroundColor: primaryGreen.withValues(alpha: 0.12),
          child: const Icon(
            Icons.hub_outlined,
            color: darkGreen,
          ),
        ),
        title: Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('$step - $status'),
        childrenPadding:
            const EdgeInsets.fromLTRB(16, 0, 16, 12),
        children: <Widget>[
          if (owner.isNotEmpty) _detailLine('Owner', owner),
          if (site.isNotEmpty) _detailLine('Site / Unit', site),
          if (scope.isNotEmpty) _detailLine('Scope', scope),
          if (kpi.isNotEmpty) _detailLine('KPI / Indicator', kpi),
          if (improvement.isNotEmpty)
            _detailLine('Improvement', improvement),
          _detailLine(
            'Workflow',
            'Leadership → Plan → Risk → Control → Operate → Monitor → Assure → Improve → Review → Intelligence',
          ),
          _detailLine(
            'Integration',
            'Steps 9, 31-50 → Advanced HSE 51-60',
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
              Icons.hub_outlined,
              size: 62,
              color: darkGreen.withValues(alpha: 0.45),
            ),
            const SizedBox(height: 12),
            const Text(
              'No Advanced HSE records found',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Create the first Steps 51-60 HSE record.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _AdvancedHSEFormDialog extends StatefulWidget {
  const _AdvancedHSEFormDialog({this.existing});

  final Map<String, dynamic>? existing;

  @override
  State<_AdvancedHSEFormDialog> createState() =>
      _AdvancedHSEFormDialogState();
}

class _AdvancedHSEFormDialogState
    extends State<_AdvancedHSEFormDialog> {
  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>();

  late final TextEditingController _name;
  late final TextEditingController _owner;
  late final TextEditingController _site;
  late final TextEditingController _scope;
  late final TextEditingController _objective;
  late final TextEditingController _risk;
  late final TextEditingController _control;
  late final TextEditingController _kpi;
  late final TextEditingController _assurance;
  late final TextEditingController _improvement;
  late final TextEditingController _decision;
  late final TextEditingController _reviewDate;
  late final TextEditingController _notes;

  String _step = '51 - HSE Management System';
  String _status = 'Draft';

  final List<String> _steps = <String>[
    '51 - HSE Management System',
    '52 - HSE Leadership & Governance',
    '53 - Integrated HSE Planning & Control',
    '54 - HSE Performance & KPI Management',
    '55 - HSE Risk Intelligence & Predictive Control',
    '56 - Operational HSE Excellence',
    '57 - HSE Assurance & Compliance Intelligence',
    '58 - Continual Improvement & Change Management',
    '59 - HSE Management Review & Strategic Decisions',
    '60 - Advanced HSE Command Center & Intelligence',
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
    _objective = TextEditingController(
      text: existing['objective'] as String? ?? '',
    );
    _risk = TextEditingController(
      text: existing['risk'] as String? ?? '',
    );
    _control = TextEditingController(
      text: existing['control'] as String? ?? '',
    );
    _kpi = TextEditingController(
      text: existing['kpi'] as String? ?? '',
    );
    _assurance = TextEditingController(
      text: existing['assurance'] as String? ?? '',
    );
    _improvement = TextEditingController(
      text: existing['improvement'] as String? ?? '',
    );
    _decision = TextEditingController(
      text: existing['decision'] as String? ?? '',
    );
    _reviewDate = TextEditingController(
      text: existing['reviewDate'] as String? ?? '',
    );
    _notes = TextEditingController(
      text: existing['notes'] as String? ?? '',
    );

    _step = existing['step'] as String? ?? _steps.first;
    _status = existing['status'] as String? ?? _statuses.first;
  }

  @override
  void dispose() {
    _name.dispose();
    _owner.dispose();
    _site.dispose();
    _scope.dispose();
    _objective.dispose();
    _risk.dispose();
    _control.dispose();
    _kpi.dispose();
    _assurance.dispose();
    _improvement.dispose();
    _decision.dispose();
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
            ? 'New Advanced HSE Record'
            : 'Edit Advanced HSE Record',
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
                    'HSE Framework / Record Name *',
                    Icons.hub_outlined,
                  ),
                  validator: (String? value) =>
                      value == null || value.trim().isEmpty
                          ? 'Enter record name'
                          : null,
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  initialValue: _step,
                  decoration: _decoration(
                    'Advanced HSE Step',
                    Icons.layers_outlined,
                  ),
                  items: _steps
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
                        _step = value;
                      });
                    }
                  },
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  initialValue: _status,
                  decoration: _decoration(
                    'Status',
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
                    'Owner / Responsible Person',
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
                    'Scope / Application',
                    Icons.work_outline,
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _objective,
                  maxLines: 3,
                  decoration: _decoration(
                    'Objective / Strategic Priority',
                    Icons.flag_outlined,
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _risk,
                  maxLines: 3,
                  decoration: _decoration(
                    'Risk / Emerging Hazard',
                    Icons.warning_amber_outlined,
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _control,
                  maxLines: 3,
                  decoration: _decoration(
                    'Critical Control / Operational Control',
                    Icons.security_outlined,
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _kpi,
                  maxLines: 2,
                  decoration: _decoration(
                    'KPI / Leading & Lagging Indicator',
                    Icons.analytics_outlined,
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _assurance,
                  maxLines: 3,
                  decoration: _decoration(
                    'Assurance / Compliance Status',
                    Icons.fact_check_outlined,
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _improvement,
                  maxLines: 3,
                  decoration: _decoration(
                    'Continual Improvement / Change',
                    Icons.trending_up_outlined,
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _decision,
                  maxLines: 3,
                  decoration: _decoration(
                    'Management Decision / Action',
                    Icons.gavel_outlined,
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _reviewDate,
                  decoration: _decoration(
                    'Review Date',
                    Icons.calendar_today_outlined,
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _notes,
                  maxLines: 3,
                  decoration: _decoration(
                    'Notes / Audit Trail',
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
      'step': _step,
      'status': _status,
      'owner': _owner.text.trim(),
      'site': _site.text.trim(),
      'scope': _scope.text.trim(),
      'objective': _objective.text.trim(),
      'risk': _risk.text.trim(),
      'control': _control.text.trim(),
      'kpi': _kpi.text.trim(),
      'assurance': _assurance.text.trim(),
      'improvement': _improvement.text.trim(),
      'decision': _decision.text.trim(),
      'reviewDate': _reviewDate.text.trim(),
      'notes': _notes.text.trim(),
    });
  }
}
