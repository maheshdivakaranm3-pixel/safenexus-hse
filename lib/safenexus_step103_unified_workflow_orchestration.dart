import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// SafeNexus HSE — Step 103
/// Unified Workflow & Cross-Module Orchestration Hub
///
/// Purpose:
/// - Connect existing HSE modules without duplicating business logic.
/// - Provide a controlled workflow registry, trigger/dependency view,
///   cross-module references, verification tracking and intelligence.
/// - English + Malayalam ready.
/// - UAE-wide scalable architecture.
///
/// Safety principle:
/// This layer is an orchestration and decision-support layer. It must not
/// bypass competent HSE review, authorization, permit controls or verification.

class SafeNexusStep103UnifiedWorkflowPage extends StatefulWidget {
  const SafeNexusStep103UnifiedWorkflowPage({super.key});

  @override
  State<SafeNexusStep103UnifiedWorkflowPage> createState() =>
      _SafeNexusStep103UnifiedWorkflowPageState();
}

class _SafeNexusStep103UnifiedWorkflowPageState
    extends State<SafeNexusStep103UnifiedWorkflowPage> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);
  static const String _storageKey =
      'safenexus_hse_step103_unified_workflow_orchestration';

  final List<String> _statuses = <String>[
    'Planned',
    'Active',
    'Blocked',
    'Verification',
    'Closed',
  ];

  final List<String> _priorities = <String>[
    'Low',
    'Medium',
    'High',
    'Critical',
  ];

  final List<Map<String, String>> _modules = <Map<String, String>>[
    {'step': 'Step 9', 'name': 'Daily HSE'},
    {'step': 'Step 31', 'name': 'Smart Checklists'},
    {'step': 'Step 32', 'name': 'Field Operations'},
    {'step': 'Step 35', 'name': 'Action Center'},
    {'step': 'Step 36', 'name': 'Risk & Control'},
    {'step': 'Step 37', 'name': 'RAMS'},
    {'step': 'Step 38', 'name': 'PTW'},
    {'step': 'Step 39', 'name': 'Workforce & Competency'},
    {'step': 'Step 40', 'name': 'Equipment & Asset'},
    {'step': 'Step 41', 'name': 'Inspection & Certification'},
    {'step': 'Step 44', 'name': 'Incident & Investigation'},
    {'step': 'Step 45', 'name': 'Audit & Assurance'},
    {'step': 'Step 46', 'name': 'Legal & Compliance'},
    {'step': 'Step 47', 'name': 'Management Review'},
    {'step': 'Step 48', 'name': 'Objectives & Improvement'},
    {'step': 'Step 50', 'name': 'Contractor & Supplier'},
    {'step': 'Step 81–90', 'name': 'AI Intelligence'},
    {'step': 'Step 91–100', 'name': 'Ultimate Enterprise'},
  ];

  final List<Map<String, String>> _workflowTemplates =
      <Map<String, String>>[
    {
      'name': 'Daily Field Safety Workflow',
      'from': 'Step 9 Daily HSE',
      'to': 'Step 32 Field Operations',
      'status': 'Active',
      'priority': 'High',
    },
    {
      'name': 'Risk to Permit Workflow',
      'from': 'Step 36 Risk & Control',
      'to': 'Step 38 PTW',
      'status': 'Active',
      'priority': 'Critical',
    },
    {
      'name': 'RAMS Verification Workflow',
      'from': 'Step 37 RAMS',
      'to': 'Step 32 Field Operations',
      'status': 'Verification',
      'priority': 'High',
    },
    {
      'name': 'Incident CAPA Workflow',
      'from': 'Step 44 Incident',
      'to': 'Step 35 Action Center',
      'status': 'Active',
      'priority': 'Critical',
    },
    {
      'name': 'Competency Authorization Workflow',
      'from': 'Step 39 Workforce',
      'to': 'Step 38 PTW',
      'status': 'Planned',
      'priority': 'High',
    },
    {
      'name': 'Equipment Certification Workflow',
      'from': 'Step 40 Equipment',
      'to': 'Step 41 Inspection',
      'status': 'Active',
      'priority': 'High',
    },
    {
      'name': 'Audit Compliance Workflow',
      'from': 'Step 45 Audit',
      'to': 'Step 46 Compliance',
      'status': 'Verification',
      'priority': 'High',
    },
    {
      'name': 'Management Improvement Workflow',
      'from': 'Step 47 Management Review',
      'to': 'Step 48 Improvement',
      'status': 'Planned',
      'priority': 'Medium',
    },
  ];

  List<Map<String, String>> _workflows = <Map<String, String>>[];
  String _search = '';
  String _statusFilter = 'All';
  String _priorityFilter = 'All';
  int _selectedSection = 0;

  @override
  void initState() {
    super.initState();
    _loadWorkflows();
  }

  Future<void> _loadWorkflows() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> saved = prefs.getStringList(_storageKey) ?? <String>[];

    if (saved.isEmpty) {
      _workflows = _workflowTemplates
          .map((Map<String, String> item) =>
              Map<String, String>.from(item))
          .toList();
    } else {
      _workflows = saved
          .map(_decodeWorkflow)
          .whereType<Map<String, String>>()
          .toList();
    }

    if (mounted) {
      setState(() {});
    }
  }

  Map<String, String>? _decodeWorkflow(String value) {
    final List<String> parts = value.split('¦');
    if (parts.length != 5) {
      return null;
    }
    return <String, String>{
      'name': parts[0],
      'from': parts[1],
      'to': parts[2],
      'status': parts[3],
      'priority': parts[4],
    };
  }

  String _encodeWorkflow(Map<String, String> item) {
    return <String>[
      item['name'] ?? '',
      item['from'] ?? '',
      item['to'] ?? '',
      item['status'] ?? 'Planned',
      item['priority'] ?? 'Medium',
    ].join('¦');
  }

  Future<void> _saveWorkflows() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      _storageKey,
      _workflows.map(_encodeWorkflow).toList(),
    );
  }

  List<Map<String, String>> get _filteredWorkflows {
    return _workflows.where((Map<String, String> item) {
      final String haystack = <String>[
        item['name'] ?? '',
        item['from'] ?? '',
        item['to'] ?? '',
      ].join(' ').toLowerCase();

      final bool searchMatch =
          _search.trim().isEmpty || haystack.contains(_search.toLowerCase());
      final bool statusMatch =
          _statusFilter == 'All' || item['status'] == _statusFilter;
      final bool priorityMatch =
          _priorityFilter == 'All' || item['priority'] == _priorityFilter;

      return searchMatch && statusMatch && priorityMatch;
    }).toList();
  }

  int _countByStatus(String status) {
    return _workflows
        .where((Map<String, String> item) => item['status'] == status)
        .length;
  }

  int _countByPriority(String priority) {
    return _workflows
        .where((Map<String, String> item) => item['priority'] == priority)
        .length;
  }

  int _countByModule(String moduleName) {
    return _workflows
        .where(
          (Map<String, String> item) =>
              item['from']?.contains(moduleName) == true ||
              item['to']?.contains(moduleName) == true,
        )
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

  Future<void> _showWorkflowDialog({int? editIndex}) async {
    final Map<String, String>? existing =
        editIndex == null ? null : _workflows[editIndex];

    final TextEditingController nameController =
        TextEditingController(text: existing?['name'] ?? '');
    String from = existing?['from'] ?? _modules.first['step']!;
    String to = existing?['to'] ?? _modules[1]['step']!;
    String status = existing?['status'] ?? 'Planned';
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
                editIndex == null ? 'Add Workflow' : 'Edit Workflow',
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: 'Workflow name',
                        prefixIcon: Icon(Icons.account_tree_outlined),
                      ),
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      initialValue: from,
                      decoration: const InputDecoration(
                        labelText: 'Source module',
                      ),
                      items: _modules
                          .map(
                            (Map<String, String> item) =>
                                DropdownMenuItem<String>(
                              value: item['step'],
                              child: Text(
                                '${item['step']} — ${item['name']}',
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (String? value) {
                        if (value != null) {
                          dialogSetState(() => from = value);
                        }
                      },
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      initialValue: to,
                      decoration: const InputDecoration(
                        labelText: 'Target module',
                      ),
                      items: _modules
                          .map(
                            (Map<String, String> item) =>
                                DropdownMenuItem<String>(
                              value: item['step'],
                              child: Text(
                                '${item['step']} — ${item['name']}',
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (String? value) {
                        if (value != null) {
                          dialogSetState(() => to = value);
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
                    final String name = nameController.text.trim();
                    if (name.isEmpty || from == to) {
                      return;
                    }
                    Navigator.pop(
                      context,
                      <String, String>{
                        'name': name,
                        'from': from,
                        'to': to,
                        'status': status,
                        'priority': priority,
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

    nameController.dispose();

    if (result == null || !mounted) {
      return;
    }

    setState(() {
      if (editIndex == null) {
        _workflows.add(result);
      } else {
        _workflows[editIndex] = result;
      }
    });
    await _saveWorkflows();
  }

  Future<void> _deleteWorkflow(int index) async {
    setState(() {
      _workflows.removeAt(index);
    });
    await _saveWorkflows();
  }

  void _showWorkflowDetails(Map<String, String> item) {
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
                  item['name'] ?? 'Workflow',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: darkGreen,
                  ),
                ),
                const SizedBox(height: 14),
                _metricRow('Source', 1),
                ListTile(
                  dense: true,
                  title: const Text('Source module'),
                  subtitle: Text(item['from'] ?? ''),
                ),
                ListTile(
                  dense: true,
                  title: const Text('Target module'),
                  subtitle: Text(item['to'] ?? ''),
                ),
                ListTile(
                  dense: true,
                  title: const Text('Status'),
                  subtitle: Text(item['status'] ?? ''),
                ),
                ListTile(
                  dense: true,
                  title: const Text('Priority'),
                  subtitle: Text(item['priority'] ?? ''),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Control note: cross-module transitions must respect '
                  'the originating module controls and competent HSE '
                  'authorization requirements.',
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDashboard() {
    final int active = _countByStatus('Active');
    final int blocked = _countByStatus('Blocked');
    final int verification = _countByStatus('Verification');
    final int critical = _countByPriority('Critical');

    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        const Text(
          'Step 103 — Unified Workflow & Orchestration',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: darkGreen,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Cross-module workflow control for the SafeNexus HSE ecosystem.',
        ),
        const SizedBox(height: 16),
        _metricCard('Total Workflows', _workflows.length, Icons.account_tree),
        _metricCard('Active', active, Icons.play_circle_outline),
        _metricCard('Verification', verification, Icons.verified_outlined),
        _metricCard('Blocked', blocked, Icons.block_outlined),
        _metricCard('Critical Priority', critical, Icons.warning_amber_outlined),
        const SizedBox(height: 12),
        Card(
          elevation: 0,
          child: Column(
            children: <Widget>[
              const ListTile(
                title: Text(
                  'Core orchestration chain',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              _metricRow('Sense & Trigger', _countByStatus('Planned')),
              _metricRow('Execute', active),
              _metricRow('Verify', verification),
              _metricRow('Escalate', blocked),
              _metricRow('Learn & Improve', _countByStatus('Closed')),
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
                  'Key integrations',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              ..._modules
                  .take(8)
                  .map(
                    (Map<String, String> module) => ListTile(
                      dense: true,
                      leading: const Icon(
                        Icons.link,
                        color: primaryGreen,
                      ),
                      title: Text(module['step']!),
                      subtitle: Text(module['name']!),
                      trailing: Text(
                        '${_countByModule(module['step']!)} links',
                      ),
                    ),
                  ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildWorkflowList() {
    final List<Map<String, String>> items = _filteredWorkflows;

    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
          child: TextField(
            decoration: const InputDecoration(
              hintText: 'Search workflow, source or target',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
            onChanged: (String value) {
              setState(() => _search = value);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: <Widget>[
              Expanded(
                child: DropdownButtonFormField<String>(
                  initialValue: _statusFilter,
                  decoration: const InputDecoration(labelText: 'Status'),
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
              const SizedBox(width: 10),
              Expanded(
                child: DropdownButtonFormField<String>(
                  initialValue: _priorityFilter,
                  decoration: const InputDecoration(labelText: 'Priority'),
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
            ],
          ),
        ),
        Expanded(
          child: items.isEmpty
              ? const Center(
                  child: Text('No workflows match the current filters.'),
                )
              : ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 90),
                  itemCount: items.length,
                  itemBuilder: (BuildContext context, int visibleIndex) {
                    final Map<String, String> item = items[visibleIndex];
                    final int actualIndex = _workflows.indexOf(item);

                    return Card(
                      elevation: 0,
                      margin: const EdgeInsets.only(bottom: 10),
                      child: ListTile(
                        onTap: () => _showWorkflowDetails(item),
                        leading: CircleAvatar(
                          backgroundColor:
                              primaryGreen.withValues(alpha: 0.10),
                          child: const Icon(
                            Icons.alt_route,
                            color: primaryGreen,
                          ),
                        ),
                        title: Text(
                          item['name'] ?? '',
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                        subtitle: Text(
                          '${item['from']}  →  ${item['to']}\n'
                          'Status: ${item['status']} • '
                          'Priority: ${item['priority']}',
                        ),
                        isThreeLine: true,
                        trailing: PopupMenuButton<String>(
                          onSelected: (String action) {
                            if (action == 'edit') {
                              _showWorkflowDialog(editIndex: actualIndex);
                            } else if (action == 'delete') {
                              _deleteWorkflow(actualIndex);
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

  Widget _buildIntegrationMap() {
    final List<Map<String, String>> links = <Map<String, String>>[
      {'a': 'Step 9', 'b': 'Step 32', 'label': 'Daily HSE → Field Work'},
      {'a': 'Step 36', 'b': 'Step 37', 'label': 'Risk → RAMS'},
      {'a': 'Step 37', 'b': 'Step 38', 'label': 'RAMS → PTW'},
      {'a': 'Step 39', 'b': 'Step 38', 'label': 'Competency → PTW'},
      {'a': 'Step 40', 'b': 'Step 41', 'label': 'Equipment → Inspection'},
      {'a': 'Step 44', 'b': 'Step 35', 'label': 'Incident → Action'},
      {'a': 'Step 45', 'b': 'Step 46', 'label': 'Audit → Compliance'},
      {'a': 'Step 47', 'b': 'Step 48', 'label': 'Review → Improvement'},
      {'a': 'Step 81–90', 'b': 'Step 91–100', 'label': 'AI → Enterprise Intelligence'},
    ];

    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        const Text(
          'Cross-Module Integration Map',
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.bold,
            color: darkGreen,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Step 103 stores the relationship between existing modules; '
          'it does not duplicate their underlying records.',
        ),
        const SizedBox(height: 16),
        ...links.map(
          (Map<String, String> link) => Card(
            elevation: 0,
            child: ListTile(
              leading: const Icon(
                Icons.compare_arrows,
                color: primaryGreen,
              ),
              title: Text(link['label']!),
              subtitle: Text('${link['a']}  →  ${link['b']}'),
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
          'Step 103 Architecture Guide',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: darkGreen,
          ),
        ),
        SizedBox(height: 14),
        _GuideCard(
          number: '103A',
          title: 'Workflow Master',
          text: 'Create and maintain controlled cross-module workflows.',
        ),
        _GuideCard(
          number: '103B',
          title: 'Cross-Module Links',
          text: 'Connect an originating HSE module to a target module.',
        ),
        _GuideCard(
          number: '103C',
          title: 'Triggers & Dependencies',
          text: 'Identify what must exist or be verified before a transition.',
        ),
        _GuideCard(
          number: '103D',
          title: 'Status Control',
          text: 'Track planned, active, blocked, verification and closed states.',
        ),
        _GuideCard(
          number: '103E–103J',
          title: 'Integrated HSE Workflows',
          text: 'Connect risk, RAMS, PTW, field, incident, workforce, '
              'equipment, audit and management processes.',
        ),
        _GuideCard(
          number: '103K',
          title: 'History & Audit Trail',
          text: 'Retain local workflow configuration for traceability.',
        ),
        _GuideCard(
          number: '103L',
          title: 'Workflow Intelligence',
          text: 'Use workflow status and priority signals for management '
              'visibility and decision support.',
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
          'Automation must never bypass permit authorization, risk controls, '
          'competency requirements, emergency controls or competent HSE review.',
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> sections = <Widget>[
      _buildDashboard(),
      _buildWorkflowList(),
      _buildIntegrationMap(),
      _buildGuide(),
    ];

    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        title: const Text('Step 103 • Workflow Hub'),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
      ),
      body: sections[_selectedSection],
      floatingActionButton: _selectedSection == 1
          ? FloatingActionButton.extended(
              onPressed: _showWorkflowDialog,
              backgroundColor: primaryGreen,
              foregroundColor: Colors.white,
              icon: const Icon(Icons.add),
              label: const Text('Add Workflow'),
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
            icon: Icon(Icons.account_tree_outlined),
            selectedIcon: Icon(Icons.account_tree),
            label: 'Workflows',
          ),
          NavigationDestination(
            icon: Icon(Icons.hub_outlined),
            selectedIcon: Icon(Icons.hub),
            label: 'Map',
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
        leading: CircleAvatar(
          backgroundColor: const Color(0xFF159447),
          child: Text(
            number,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        subtitle: Text(text),
      ),
    );
  }
}
