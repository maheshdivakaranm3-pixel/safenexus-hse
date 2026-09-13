import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// SafeNexus HSE — Step 109
/// Global HSE Dashboard & Intelligence
///
/// Purpose:
/// - Provide a unified executive HSE intelligence dashboard.
/// - Aggregate controlled metrics from existing SafeNexus modules.
/// - Track risk, action, workflow, evidence, incident, audit and compliance
///   signals without duplicating source records.
/// - Prepare the platform for Step 110 final system integration and release
///   readiness.
/// - UAE-wide scalable architecture.
/// - English + Malayalam ready.
///
/// Architecture:
/// Existing Modules → Unified Data → Workflow → Intelligence → Dashboard
///
/// Important:
/// The dashboard is a decision-support layer. It does not replace competent
/// HSE review, authorization, risk acceptance, investigation approval or
/// source-module closure.

class SafeNexusStep109GlobalHseDashboardPage extends StatefulWidget {
  const SafeNexusStep109GlobalHseDashboardPage({super.key});

  @override
  State<SafeNexusStep109GlobalHseDashboardPage> createState() =>
      _SafeNexusStep109GlobalHseDashboardPageState();
}

class _SafeNexusStep109GlobalHseDashboardPageState
    extends State<SafeNexusStep109GlobalHseDashboardPage> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);

  static const String _storageKey =
      'safenexus_hse_step109_global_hse_dashboard_intelligence';

  final List<String> _domains = <String>[
    'Safety',
    'Risk',
    'Actions',
    'Incidents',
    'Audit',
    'Compliance',
    'Workforce',
    'Equipment',
    'Emergency',
    'Environment',
    'Workflow',
    'Evidence',
  ];

  final List<String> _statuses = <String>[
    'Healthy',
    'Watch',
    'Attention',
    'Critical',
    'Closed',
  ];

  final List<String> _priorities = <String>[
    'Low',
    'Medium',
    'High',
    'Critical',
  ];

  final List<Map<String, String>> _moduleRegistry =
      <Map<String, String>>[
    {'step': 'Step 9', 'name': 'Daily HSE', 'domain': 'Safety'},
    {'step': 'Step 31', 'name': 'Smart Checklists', 'domain': 'Safety'},
    {'step': 'Step 32', 'name': 'Field Operations', 'domain': 'Safety'},
    {'step': 'Step 34', 'name': 'Documents & Records', 'domain': 'Evidence'},
    {'step': 'Step 35', 'name': 'Action Center', 'domain': 'Actions'},
    {'step': 'Step 36', 'name': 'Risk & Control', 'domain': 'Risk'},
    {'step': 'Step 37', 'name': 'RAMS', 'domain': 'Risk'},
    {'step': 'Step 38', 'name': 'PTW', 'domain': 'Safety'},
    {
      'step': 'Step 39',
      'name': 'Workforce & Competency',
      'domain': 'Workforce',
    },
    {
      'step': 'Step 40',
      'name': 'Equipment & Asset',
      'domain': 'Equipment',
    },
    {
      'step': 'Step 41',
      'name': 'Inspection & Certification',
      'domain': 'Audit',
    },
    {
      'step': 'Step 42',
      'name': 'Emergency Response',
      'domain': 'Emergency',
    },
    {
      'step': 'Step 43',
      'name': 'Environmental',
      'domain': 'Environment',
    },
    {
      'step': 'Step 44',
      'name': 'Incident & Investigation',
      'domain': 'Incidents',
    },
    {
      'step': 'Step 45',
      'name': 'Audit & Assurance',
      'domain': 'Audit',
    },
    {
      'step': 'Step 46',
      'name': 'Legal & Compliance',
      'domain': 'Compliance',
    },
    {
      'step': 'Step 47',
      'name': 'Management Review',
      'domain': 'Safety',
    },
    {
      'step': 'Step 48',
      'name': 'Objectives & Improvement',
      'domain': 'Safety',
    },
    {
      'step': 'Step 49',
      'name': 'Training & Safety Culture',
      'domain': 'Workforce',
    },
    {
      'step': 'Step 50',
      'name': 'Contractor & Supplier',
      'domain': 'Workforce',
    },
    {
      'step': 'Step 103',
      'name': 'Workflow Orchestration',
      'domain': 'Workflow',
    },
    {
      'step': 'Step 104',
      'name': 'Evidence Intelligence',
      'domain': 'Evidence',
    },
    {
      'step': 'Step 105',
      'name': 'Risk Intelligence',
      'domain': 'Risk',
    },
    {
      'step': 'Step 106',
      'name': 'WorkHub Integration',
      'domain': 'Safety',
    },
    {
      'step': 'Step 107',
      'name': 'Unified Record Linking',
      'domain': 'Evidence',
    },
    {
      'step': 'Step 108',
      'name': 'Workflow Integration',
      'domain': 'Workflow',
    },
  ];

  final List<Map<String, String>> _templates =
      <Map<String, String>>[
    {
      'title': 'Critical Risk Exposure',
      'domain': 'Risk',
      'status': 'Critical',
      'priority': 'Critical',
      'value': '3',
      'trend': 'Review required',
    },
    {
      'title': 'Open Corrective Actions',
      'domain': 'Actions',
      'status': 'Attention',
      'priority': 'High',
      'value': '12',
      'trend': 'Monitor overdue items',
    },
    {
      'title': 'Incident Investigation Queue',
      'domain': 'Incidents',
      'status': 'Watch',
      'priority': 'High',
      'value': '4',
      'trend': 'Investigation follow-up',
    },
    {
      'title': 'Audit Findings',
      'domain': 'Audit',
      'status': 'Attention',
      'priority': 'High',
      'value': '7',
      'trend': 'Closure verification',
    },
    {
      'title': 'Compliance Review',
      'domain': 'Compliance',
      'status': 'Healthy',
      'priority': 'Medium',
      'value': '18',
      'trend': 'Routine monitoring',
    },
    {
      'title': 'Workforce Competency',
      'domain': 'Workforce',
      'status': 'Healthy',
      'priority': 'Medium',
      'value': '94',
      'trend': 'Validity monitoring',
    },
    {
      'title': 'Emergency Readiness',
      'domain': 'Emergency',
      'status': 'Healthy',
      'priority': 'High',
      'value': '91',
      'trend': 'Drill readiness',
    },
    {
      'title': 'Environmental Controls',
      'domain': 'Environment',
      'status': 'Watch',
      'priority': 'Medium',
      'value': '86',
      'trend': 'Monitor controls',
    },
    {
      'title': 'Workflow Verification',
      'domain': 'Workflow',
      'status': 'Attention',
      'priority': 'High',
      'value': '9',
      'trend': 'Verification pending',
    },
    {
      'title': 'Evidence Quality',
      'domain': 'Evidence',
      'status': 'Healthy',
      'priority': 'Medium',
      'value': '96',
      'trend': 'Traceability strong',
    },
    {
      'title': 'Safety Observation Coverage',
      'domain': 'Safety',
      'status': 'Healthy',
      'priority': 'Medium',
      'value': '89',
      'trend': 'Leading indicator',
    },
    {
      'title': 'Equipment HSE Readiness',
      'domain': 'Equipment',
      'status': 'Watch',
      'priority': 'High',
      'value': '88',
      'trend': 'Certification review',
    },
  ];

  List<Map<String, String>> _signals = <Map<String, String>>[];
  String _search = '';
  String _domainFilter = 'All';
  String _statusFilter = 'All';
  String _priorityFilter = 'All';
  int _selectedSection = 0;

  @override
  void initState() {
    super.initState();
    _loadSignals();
  }

  Future<void> _loadSignals() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> saved =
        prefs.getStringList(_storageKey) ?? <String>[];

    if (saved.isEmpty) {
      _signals = _templates
          .map((Map<String, String> item) => Map<String, String>.from(item))
          .toList();
    } else {
      _signals = saved
          .map(_decodeSignal)
          .whereType<Map<String, String>>()
          .toList();
    }

    if (mounted) {
      setState(() {});
    }
  }

  Map<String, String>? _decodeSignal(String value) {
    final List<String> parts = value.split('¦');
    if (parts.length != 6) {
      return null;
    }

    return <String, String>{
      'title': parts[0],
      'domain': parts[1],
      'status': parts[2],
      'priority': parts[3],
      'value': parts[4],
      'trend': parts[5],
    };
  }

  String _encodeSignal(Map<String, String> item) {
    return <String>[
      item['title'] ?? '',
      item['domain'] ?? 'Safety',
      item['status'] ?? 'Healthy',
      item['priority'] ?? 'Medium',
      item['value'] ?? '0',
      item['trend'] ?? '',
    ].join('¦');
  }

  Future<void> _saveSignals() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      _storageKey,
      _signals.map(_encodeSignal).toList(),
    );
  }

  List<Map<String, String>> get _filteredSignals {
    final String query = _search.trim().toLowerCase();

    return _signals.where((Map<String, String> item) {
      final String haystack = <String>[
        item['title'] ?? '',
        item['domain'] ?? '',
        item['status'] ?? '',
        item['priority'] ?? '',
        item['value'] ?? '',
        item['trend'] ?? '',
      ].join(' ').toLowerCase();

      final bool searchMatch =
          query.isEmpty || haystack.contains(query);
      final bool domainMatch =
          _domainFilter == 'All' || item['domain'] == _domainFilter;
      final bool statusMatch =
          _statusFilter == 'All' || item['status'] == _statusFilter;
      final bool priorityMatch =
          _priorityFilter == 'All' || item['priority'] == _priorityFilter;

      return searchMatch && domainMatch && statusMatch && priorityMatch;
    }).toList();
  }

  int _countByStatus(String status) {
    return _signals
        .where((Map<String, String> item) => item['status'] == status)
        .length;
  }

  int _countByDomain(String domain) {
    return _signals
        .where((Map<String, String> item) => item['domain'] == domain)
        .length;
  }

  int _countByPriority(String priority) {
    return _signals
        .where((Map<String, String> item) => item['priority'] == priority)
        .length;
  }

  int _criticalCount() {
    return _signals
        .where((Map<String, String> item) =>
            item['priority'] == 'Critical' ||
            item['status'] == 'Critical')
        .length;
  }

  int _attentionCount() {
    return _signals
        .where((Map<String, String> item) =>
            item['status'] == 'Attention' ||
            item['status'] == 'Watch')
        .length;
  }

  Widget _metricCard(String title, int value, IconData icon) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: <Widget>[
            CircleAvatar(
              backgroundColor: primaryGreen.withValues(alpha: 0.10),
              child: Icon(icon, color: primaryGreen),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            Text(
              '$value',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: darkGreen,
              ),
            ),
          ],
        ),
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

  Future<void> _showSignalDialog({int? editIndex}) async {
    final Map<String, String>? existing =
        editIndex == null ? null : _signals[editIndex];

    final TextEditingController titleController =
        TextEditingController(text: existing?['title'] ?? '');
    final TextEditingController valueController =
        TextEditingController(text: existing?['value'] ?? '0');
    final TextEditingController trendController =
        TextEditingController(text: existing?['trend'] ?? '');

    String domain = existing?['domain'] ?? 'Safety';
    String status = existing?['status'] ?? 'Healthy';
    String priority = existing?['priority'] ?? 'Medium';

    final Map<String, String>? result =
        await showDialog<Map<String, String>>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (
            BuildContext context,
            void Function(void Function()) dialogSetState,
          ) {
            return AlertDialog(
              title: Text(
                editIndex == null
                    ? 'Add HSE Intelligence Signal'
                    : 'Edit HSE Intelligence Signal',
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        labelText: 'Signal title',
                        prefixIcon: Icon(Icons.insights_outlined),
                      ),
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      initialValue: domain,
                      decoration: const InputDecoration(
                        labelText: 'Domain',
                      ),
                      items: _domains
                          .map(
                            (String item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(item),
                            ),
                          )
                          .toList(),
                      onChanged: (String? value) {
                        if (value != null) {
                          dialogSetState(() => domain = value);
                        }
                      },
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      initialValue: status,
                      decoration: const InputDecoration(
                        labelText: 'Status',
                      ),
                      items: _statuses
                          .map(
                            (String item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(item),
                            ),
                          )
                          .toList(),
                      onChanged: (String? value) {
                        if (value != null) {
                          dialogSetState(() => status = value);
                        }
                      },
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      initialValue: priority,
                      decoration: const InputDecoration(
                        labelText: 'Priority',
                      ),
                      items: _priorities
                          .map(
                            (String item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(item),
                            ),
                          )
                          .toList(),
                      onChanged: (String? value) {
                        if (value != null) {
                          dialogSetState(() => priority = value);
                        }
                      },
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: valueController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Metric value',
                        prefixIcon: Icon(Icons.numbers),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: trendController,
                      decoration: const InputDecoration(
                        labelText: 'Trend / intelligence note',
                        prefixIcon: Icon(Icons.trending_up),
                      ),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                FilledButton(
                  onPressed: () {
                    final String title = titleController.text.trim();
                    final String value = valueController.text.trim();
                    final String trend = trendController.text.trim();

                    if (title.isEmpty || value.isEmpty) {
                      return;
                    }

                    Navigator.pop(
                      context,
                      <String, String>{
                        'title': title,
                        'domain': domain,
                        'status': status,
                        'priority': priority,
                        'value': value,
                        'trend': trend,
                      },
                    );
                  },
                  child: const Text('Save'),
                ),
              ],
            );
          },
        );
      },
    );

    titleController.dispose();
    valueController.dispose();
    trendController.dispose();

    if (result == null || !mounted) {
      return;
    }

    setState(() {
      if (editIndex == null) {
        _signals.add(result);
      } else {
        _signals[editIndex] = result;
      }
    });

    await _saveSignals();
  }

  Future<void> _deleteSignal(int index) async {
    setState(() {
      _signals.removeAt(index);
    });
    await _saveSignals();
  }

  void _showSignalDetails(Map<String, String> item) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  item['title'] ?? 'HSE Signal',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: darkGreen,
                  ),
                ),
                const SizedBox(height: 10),
                ListTile(
                  dense: true,
                  leading: const Icon(Icons.category_outlined),
                  title: const Text('Domain'),
                  subtitle: Text(item['domain'] ?? ''),
                ),
                ListTile(
                  dense: true,
                  leading: const Icon(Icons.monitor_heart_outlined),
                  title: const Text('Status'),
                  subtitle: Text(item['status'] ?? ''),
                ),
                ListTile(
                  dense: true,
                  leading: const Icon(Icons.priority_high),
                  title: const Text('Priority'),
                  subtitle: Text(item['priority'] ?? ''),
                ),
                ListTile(
                  dense: true,
                  leading: const Icon(Icons.numbers),
                  title: const Text('Metric value'),
                  subtitle: Text(item['value'] ?? ''),
                ),
                ListTile(
                  dense: true,
                  leading: const Icon(Icons.trending_up),
                  title: const Text('Intelligence note'),
                  subtitle: Text(item['trend'] ?? ''),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Control note: this dashboard signal supports HSE '
                  'decision-making. Source records remain authoritative.',
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDashboard() {
    final int critical = _criticalCount();
    final int attention = _attentionCount();
    final int healthy = _countByStatus('Healthy');
    final int closed = _countByStatus('Closed');

    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        const Text(
          'Step 109 — Global HSE Dashboard & Intelligence',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: darkGreen,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Unified executive view across the SafeNexus HSE ecosystem.',
        ),
        const SizedBox(height: 16),
        _metricCard(
          'Total Signals',
          _signals.length,
          Icons.insights_outlined,
        ),
        _metricCard(
          'Healthy',
          healthy,
          Icons.check_circle_outline,
        ),
        _metricCard(
          'Watch / Attention',
          attention,
          Icons.visibility_outlined,
        ),
        _metricCard(
          'Critical',
          critical,
          Icons.warning_amber_outlined,
        ),
        _metricCard(
          'Closed',
          closed,
          Icons.task_alt,
        ),
        const SizedBox(height: 12),
        Card(
          elevation: 0,
          child: Column(
            children: <Widget>[
              const ListTile(
                title: Text(
                  'Executive health view',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              _metricRow('Healthy', healthy),
              _metricRow('Watch', _countByStatus('Watch')),
              _metricRow('Attention', _countByStatus('Attention')),
              _metricRow('Critical', _countByStatus('Critical')),
              _metricRow('Closed', closed),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Card(
          elevation: 0,
          child: Column(
            children: <Widget>[
              const ListTile(
                title: Text(
                  'Priority exposure',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              _metricRow(
                'Low',
                _countByPriority('Low'),
              ),
              _metricRow(
                'Medium',
                _countByPriority('Medium'),
              ),
              _metricRow(
                'High',
                _countByPriority('High'),
              ),
              _metricRow(
                'Critical',
                _countByPriority('Critical'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSignalList() {
    final List<Map<String, String>> items = _filteredSignals;

    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
          child: TextField(
            decoration: const InputDecoration(
              hintText: 'Search HSE intelligence signal',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
            onChanged: (String value) {
              setState(() => _search = value);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
          child: Row(
            children: <Widget>[
              Expanded(
                child: DropdownButtonFormField<String>(
                  initialValue: _domainFilter,
                  decoration: const InputDecoration(
                    labelText: 'Domain',
                  ),
                  items: <String>['All', ..._domains]
                      .map(
                        (String item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(item),
                        ),
                      )
                      .toList(),
                  onChanged: (String? value) {
                    if (value != null) {
                      setState(() => _domainFilter = value);
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
                  ),
                  items: <String>['All', ..._statuses]
                      .map(
                        (String item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(item),
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
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
          child: DropdownButtonFormField<String>(
            initialValue: _priorityFilter,
            decoration: const InputDecoration(
              labelText: 'Priority',
            ),
            items: <String>['All', ..._priorities]
                .map(
                  (String item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(item),
                  ),
                )
                .toList(),
            onChanged: (String? value) {
              if (value != null) {
                setState(() => _priorityFilter = value);
              }
            },
          ),
        ),
        Expanded(
          child: items.isEmpty
              ? const Center(
                  child: Text(
                    'No HSE intelligence signals match the filters.',
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 90),
                  itemCount: items.length,
                  itemBuilder: (
                    BuildContext context,
                    int visibleIndex,
                  ) {
                    final Map<String, String> item =
                        items[visibleIndex];
                    final int actualIndex = _signals.indexOf(item);

                    return Card(
                      elevation: 0,
                      margin: const EdgeInsets.only(bottom: 10),
                      child: ListTile(
                        onTap: () => _showSignalDetails(item),
                        leading: CircleAvatar(
                          backgroundColor:
                              primaryGreen.withValues(alpha: 0.10),
                          child: const Icon(
                            Icons.insights_outlined,
                            color: primaryGreen,
                          ),
                        ),
                        title: Text(
                          item['title'] ?? '',
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        subtitle: Text(
                          '${item['domain']} • ${item['status']} • '
                          '${item['priority']}\n'
                          'Value: ${item['value']} • ${item['trend']}',
                        ),
                        isThreeLine: true,
                        trailing: PopupMenuButton<String>(
                          onSelected: (String action) {
                            if (action == 'edit') {
                              _showSignalDialog(
                                editIndex: actualIndex,
                              );
                            } else if (action == 'delete') {
                              _deleteSignal(actualIndex);
                            }
                          },
                          itemBuilder: (BuildContext context) =>
                              const <PopupMenuEntry<String>>[
                            PopupMenuItem<String>(
                              value: 'edit',
                              child: Text('Edit'),
                            ),
                            PopupMenuItem<String>(
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
    );
  }

  Widget _buildDomainIntelligence() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        const Text(
          'HSE Domain Intelligence',
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.bold,
            color: darkGreen,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Unified signals by HSE management domain.',
        ),
        const SizedBox(height: 14),
        ..._domains.map(
          (String domain) => Card(
            elevation: 0,
            child: ListTile(
              leading: const Icon(
                Icons.hub_outlined,
                color: primaryGreen,
              ),
              title: Text(domain),
              subtitle: Text(
                '${_countByDomain(domain)} intelligence signals',
              ),
              trailing: Text(
                '${_countByPriority('Critical')} critical overall',
                style: const TextStyle(
                  fontSize: 11,
                  color: darkGreen,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildModuleRegistry() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        const Text(
          'Integrated Module Coverage',
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.bold,
            color: darkGreen,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Modules represented in the Step 109 intelligence layer.',
        ),
        const SizedBox(height: 14),
        ..._moduleRegistry.map(
          (Map<String, String> module) => Card(
            elevation: 0,
            child: ListTile(
              leading: const Icon(
                Icons.integration_instructions_outlined,
                color: primaryGreen,
              ),
              title: Text(
                '${module['step']} — ${module['name']}',
              ),
              subtitle: Text('Domain: ${module['domain']}'),
              trailing: const Icon(Icons.check_circle_outline),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGuide() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const <Widget>[
        Text(
          'Step 109 Architecture Guide',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: darkGreen,
          ),
        ),
        SizedBox(height: 14),
        _GuideCard(
          number: '109A',
          title: 'Global HSE Dashboard',
          text: 'Provide one controlled executive view across the SafeNexus HSE ecosystem.',
        ),
        _GuideCard(
          number: '109B',
          title: 'Safety Performance Intelligence',
          text: 'Combine leading and lagging signals from existing modules.',
        ),
        _GuideCard(
          number: '109C',
          title: 'Risk Intelligence',
          text: 'Surface critical and emerging risk signals for competent review.',
        ),
        _GuideCard(
          number: '109D',
          title: 'Action & Incident Intelligence',
          text: 'Present action, incident and investigation signals without duplicating source records.',
        ),
        _GuideCard(
          number: '109E–109F',
          title: 'Assurance & Compliance',
          text: 'Bring audit, inspection, legal and compliance signals into the executive view.',
        ),
        _GuideCard(
          number: '109G–109H',
          title: 'Workforce, Equipment & Emergency',
          text: 'Expose readiness signals from people, assets and emergency systems.',
        ),
        _GuideCard(
          number: '109I',
          title: 'Workflow Intelligence',
          text: 'Monitor cross-module workflow progress, verification and escalation.',
        ),
        _GuideCard(
          number: '109J',
          title: 'Evidence & Traceability',
          text: 'Maintain decision-support traceability back to controlled source records.',
        ),
        _GuideCard(
          number: '109K',
          title: 'Executive Decision Support',
          text: 'Highlight critical exposure and priority areas for management review.',
        ),
        _GuideCard(
          number: '109L',
          title: 'Release Integration Readiness',
          text: 'Prepare the unified intelligence layer for Step 110 final integration and release checks.',
        ),
        SizedBox(height: 10),
        Text(
          'Final architecture',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: darkGreen,
          ),
        ),
        SizedBox(height: 5),
        Text(
          'Existing Modules → Step 107 Record Linking → Step 108 Workflow → Step 109 Intelligence → Step 110 Final Integration',
        ),
        SizedBox(height: 10),
        Text(
          'Safety rule',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: darkGreen,
          ),
        ),
        SizedBox(height: 5),
        Text(
          'Dashboard indicators are decision-support signals only. Competent HSE personnel and authoritative source modules retain responsibility for safety-critical decisions and approvals.',
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> sections = <Widget>[
      _buildDashboard(),
      _buildSignalList(),
      _buildDomainIntelligence(),
      _buildModuleRegistry(),
      _buildGuide(),
    ];

    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        title: const Text('Step 109 • HSE Intelligence'),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
      ),
      body: sections[_selectedSection],
      floatingActionButton: _selectedSection == 1
          ? FloatingActionButton.extended(
              onPressed: _showSignalDialog,
              backgroundColor: primaryGreen,
              foregroundColor: Colors.white,
              icon: const Icon(Icons.add_chart),
              label: const Text('Add Signal'),
            )
          : null,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedSection,
        onDestinationSelected: (int index) {
          setState(() => _selectedSection = index);
        },
        destinations: const <NavigationDestination>[
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          NavigationDestination(
            icon: Icon(Icons.insights_outlined),
            selectedIcon: Icon(Icons.insights),
            label: 'Signals',
          ),
          NavigationDestination(
            icon: Icon(Icons.hub_outlined),
            selectedIcon: Icon(Icons.hub),
            label: 'Domains',
          ),
          NavigationDestination(
            icon: Icon(Icons.integration_instructions_outlined),
            selectedIcon: Icon(Icons.integration_instructions),
            label: 'Modules',
          ),
          NavigationDestination(
            icon: Icon(Icons.menu_book_outlined),
            selectedIcon: Icon(Icons.menu_book),
            label: 'Guide',
          ),
        ],
      ),
    );
  }
}

class _GuideCard extends StatelessWidget {
  final String number;
  final String title;
  final String text;

  const _GuideCard({
    required this.number,
    required this.title,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: Color(0xFF159447),
          child: Icon(
            Icons.insights_outlined,
            color: Colors.white,
            size: 18,
          ),
        ),
        title: Text(
          '$number — $title',
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        subtitle: Text(text),
      ),
    );
  }
}
