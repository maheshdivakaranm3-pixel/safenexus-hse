import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// SafeNexus HSE — Step 108
/// Cross-Module Workflow Integration
///
/// Purpose:
/// - Provide a controlled cross-module workflow registry.
/// - Connect existing SafeNexus modules without duplicating their business logic.
/// - Track workflow stage, source, target, priority and verification.
/// - Prepare clean integration with Steps 103, 104, 105, 106 and 107.
/// - UAE-wide scalable architecture.
/// - English + Malayalam ready.
///
/// Architecture:
/// Existing Module → Workflow Trigger → Cross-Module Link → Action →
/// Verification → Escalation → Closure → Intelligence
///
/// Safety principle:
/// This layer coordinates references and workflow state only. It does not
/// replace competent HSE review, permit authorization, risk acceptance,
/// investigation approval or source-module closure.

class SafeNexusStep108CrossModuleWorkflowPage extends StatefulWidget {
  const SafeNexusStep108CrossModuleWorkflowPage({super.key});

  @override
  State<SafeNexusStep108CrossModuleWorkflowPage> createState() =>
      _SafeNexusStep108CrossModuleWorkflowPageState();
}

class _SafeNexusStep108CrossModuleWorkflowPageState
    extends State<SafeNexusStep108CrossModuleWorkflowPage> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);

  static const String _storageKey =
      'safenexus_hse_step108_cross_module_workflow_integration';

  final List<String> _stages = <String>[
    'Triggered',
    'Linked',
    'In Progress',
    'Verification',
    'Escalated',
    'Closed',
  ];

  final List<String> _workflowTypes = <String>[
    'Risk Control',
    'Corrective Action',
    'Permit Workflow',
    'Incident Response',
    'Inspection Follow-up',
    'Compliance',
    'Emergency',
    'Evidence Review',
    'Management',
  ];

  final List<String> _priorities = <String>[
    'Low',
    'Medium',
    'High',
    'Critical',
  ];

  final List<String> _verificationStates = <String>[
    'Not Required',
    'Pending',
    'Verified',
    'Rejected',
  ];

  final List<Map<String, String>> _modules =
      <Map<String, String>>[
    {'step': 'Step 9', 'name': 'Daily HSE'},
    {'step': 'Step 31', 'name': 'Smart Checklists'},
    {'step': 'Step 32', 'name': 'Field Operations'},
    {'step': 'Step 34', 'name': 'Documents & Records'},
    {'step': 'Step 35', 'name': 'Action Center'},
    {'step': 'Step 36', 'name': 'Risk & Control'},
    {'step': 'Step 37', 'name': 'RAMS'},
    {'step': 'Step 38', 'name': 'PTW'},
    {'step': 'Step 39', 'name': 'Workforce & Competency'},
    {'step': 'Step 40', 'name': 'Equipment & Asset'},
    {'step': 'Step 41', 'name': 'Inspection & Certification'},
    {'step': 'Step 42', 'name': 'Emergency Response'},
    {'step': 'Step 43', 'name': 'Environmental'},
    {'step': 'Step 44', 'name': 'Incident & Investigation'},
    {'step': 'Step 45', 'name': 'Audit & Assurance'},
    {'step': 'Step 46', 'name': 'Legal & Compliance'},
    {'step': 'Step 47', 'name': 'Management Review'},
    {'step': 'Step 48', 'name': 'Objectives & Improvement'},
    {'step': 'Step 49', 'name': 'Training & Safety Culture'},
    {'step': 'Step 50', 'name': 'Contractor & Supplier'},
    {'step': 'Step 103', 'name': 'Workflow Orchestration'},
    {'step': 'Step 104', 'name': 'Evidence Intelligence'},
    {'step': 'Step 105', 'name': 'Risk Intelligence'},
    {'step': 'Step 106', 'name': 'WorkHub Integration'},
    {'step': 'Step 107', 'name': 'Unified Record Linking'},
  ];

  final List<Map<String, String>> _templates =
      <Map<String, String>>[
    {
      'title': 'Observation → Risk → Action',
      'source': 'Step 32',
      'target': 'Step 36',
      'type': 'Risk Control',
      'stage': 'Verification',
      'priority': 'High',
      'verification': 'Pending',
    },
    {
      'title': 'Risk → RAMS → PTW',
      'source': 'Step 36',
      'target': 'Step 38',
      'type': 'Permit Workflow',
      'stage': 'In Progress',
      'priority': 'Critical',
      'verification': 'Pending',
    },
    {
      'title': 'Incident → Investigation → Action',
      'source': 'Step 44',
      'target': 'Step 35',
      'type': 'Corrective Action',
      'stage': 'Verification',
      'priority': 'Critical',
      'verification': 'Pending',
    },
    {
      'title': 'Inspection → Finding → Action',
      'source': 'Step 41',
      'target': 'Step 35',
      'type': 'Inspection Follow-up',
      'stage': 'In Progress',
      'priority': 'High',
      'verification': 'Pending',
    },
    {
      'title': 'Emergency → Recovery → Review',
      'source': 'Step 42',
      'target': 'Step 47',
      'type': 'Emergency',
      'stage': 'Linked',
      'priority': 'Critical',
      'verification': 'Not Required',
    },
    {
      'title': 'Audit → Compliance → Action',
      'source': 'Step 45',
      'target': 'Step 46',
      'type': 'Compliance',
      'stage': 'Escalated',
      'priority': 'High',
      'verification': 'Pending',
    },
    {
      'title': 'Evidence → Risk Verification',
      'source': 'Step 104',
      'target': 'Step 105',
      'type': 'Evidence Review',
      'stage': 'Verification',
      'priority': 'High',
      'verification': 'Verified',
    },
    {
      'title': 'WorkHub → Record Workflow',
      'source': 'Step 106',
      'target': 'Step 107',
      'type': 'Management',
      'stage': 'Linked',
      'priority': 'Medium',
      'verification': 'Not Required',
    },
  ];

  List<Map<String, String>> _workflows = <Map<String, String>>[];
  String _search = '';
  String _stageFilter = 'All';
  String _typeFilter = 'All';
  String _priorityFilter = 'All';
  int _selectedSection = 0;

  @override
  void initState() {
    super.initState();
    _loadWorkflows();
  }

  Future<void> _loadWorkflows() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> saved =
        prefs.getStringList(_storageKey) ?? <String>[];

    if (saved.isEmpty) {
      _workflows = _templates
          .map((Map<String, String> item) => Map<String, String>.from(item))
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
    if (parts.length != 7) {
      return null;
    }

    return <String, String>{
      'title': parts[0],
      'source': parts[1],
      'target': parts[2],
      'type': parts[3],
      'stage': parts[4],
      'priority': parts[5],
      'verification': parts[6],
    };
  }

  String _encodeWorkflow(Map<String, String> item) {
    return <String>[
      item['title'] ?? '',
      item['source'] ?? '',
      item['target'] ?? '',
      item['type'] ?? 'Risk Control',
      item['stage'] ?? 'Triggered',
      item['priority'] ?? 'Medium',
      item['verification'] ?? 'Not Required',
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
    final String query = _search.trim().toLowerCase();

    return _workflows.where((Map<String, String> item) {
      final String haystack = <String>[
        item['title'] ?? '',
        item['source'] ?? '',
        item['target'] ?? '',
        item['type'] ?? '',
        item['stage'] ?? '',
        item['priority'] ?? '',
        item['verification'] ?? '',
      ].join(' ').toLowerCase();

      final bool searchMatch =
          query.isEmpty || haystack.contains(query);
      final bool stageMatch =
          _stageFilter == 'All' || item['stage'] == _stageFilter;
      final bool typeMatch =
          _typeFilter == 'All' || item['type'] == _typeFilter;
      final bool priorityMatch =
          _priorityFilter == 'All' || item['priority'] == _priorityFilter;

      return searchMatch && stageMatch && typeMatch && priorityMatch;
    }).toList();
  }

  int _countByStage(String stage) {
    return _workflows
        .where((Map<String, String> item) => item['stage'] == stage)
        .length;
  }

  int _countByType(String type) {
    return _workflows
        .where((Map<String, String> item) => item['type'] == type)
        .length;
  }

  int _countByPriority(String priority) {
    return _workflows
        .where((Map<String, String> item) => item['priority'] == priority)
        .length;
  }

  int _countByVerification(String state) {
    return _workflows
        .where(
          (Map<String, String> item) =>
              item['verification'] == state,
        )
        .length;
  }

  int _countByModule(String module) {
    return _workflows
        .where(
          (Map<String, String> item) =>
              item['source'] == module || item['target'] == module,
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

    final TextEditingController titleController =
        TextEditingController(text: existing?['title'] ?? '');

    String source = existing?['source'] ?? _modules.first['step']!;
    String target = existing?['target'] ?? _modules[1]['step']!;
    String type = existing?['type'] ?? 'Risk Control';
    String stage = existing?['stage'] ?? 'Triggered';
    String priority = existing?['priority'] ?? 'Medium';
    String verification =
        existing?['verification'] ?? 'Not Required';

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
                    ? 'Add Cross-Module Workflow'
                    : 'Edit Cross-Module Workflow',
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        labelText: 'Workflow title',
                        prefixIcon: Icon(Icons.account_tree_outlined),
                      ),
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      initialValue: source,
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
                          dialogSetState(() => source = value);
                        }
                      },
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      initialValue: target,
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
                          dialogSetState(() => target = value);
                        }
                      },
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      initialValue: type,
                      decoration: const InputDecoration(
                        labelText: 'Workflow type',
                      ),
                      items: _workflowTypes
                          .map(
                            (String item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(item),
                            ),
                          )
                          .toList(),
                      onChanged: (String? value) {
                        if (value != null) {
                          dialogSetState(() => type = value);
                        }
                      },
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      initialValue: stage,
                      decoration: const InputDecoration(
                        labelText: 'Workflow stage',
                      ),
                      items: _stages
                          .map(
                            (String item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(item),
                            ),
                          )
                          .toList(),
                      onChanged: (String? value) {
                        if (value != null) {
                          dialogSetState(() => stage = value);
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
                    DropdownButtonFormField<String>(
                      initialValue: verification,
                      decoration: const InputDecoration(
                        labelText: 'Verification',
                      ),
                      items: _verificationStates
                          .map(
                            (String item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(item),
                            ),
                          )
                          .toList(),
                      onChanged: (String? value) {
                        if (value != null) {
                          dialogSetState(
                            () => verification = value,
                          );
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
                    final String title = titleController.text.trim();

                    if (title.isEmpty || source == target) {
                      return;
                    }

                    Navigator.pop(
                      context,
                      <String, String>{
                        'title': title,
                        'source': source,
                        'target': target,
                        'type': type,
                        'stage': stage,
                        'priority': priority,
                        'verification': verification,
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
                  item['title'] ?? 'Workflow',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: darkGreen,
                  ),
                ),
                const SizedBox(height: 10),
                ListTile(
                  dense: true,
                  leading: const Icon(Icons.source_outlined),
                  title: const Text('Source'),
                  subtitle: Text(item['source'] ?? ''),
                ),
                ListTile(
                  dense: true,
                  leading: const Icon(Icons.flag_outlined),
                  title: const Text('Target'),
                  subtitle: Text(item['target'] ?? ''),
                ),
                ListTile(
                  dense: true,
                  leading: const Icon(Icons.category_outlined),
                  title: const Text('Workflow type'),
                  subtitle: Text(item['type'] ?? ''),
                ),
                ListTile(
                  dense: true,
                  leading: const Icon(Icons.sync_alt_outlined),
                  title: const Text('Stage'),
                  subtitle: Text(item['stage'] ?? ''),
                ),
                ListTile(
                  dense: true,
                  leading: const Icon(Icons.priority_high),
                  title: const Text('Priority'),
                  subtitle: Text(item['priority'] ?? ''),
                ),
                ListTile(
                  dense: true,
                  leading: const Icon(Icons.verified_outlined),
                  title: const Text('Verification'),
                  subtitle: Text(item['verification'] ?? ''),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Control note: this workflow coordinates modules. '
                  'Source-module authorization, competent HSE review and '
                  'final closure remain authoritative.',
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDashboard() {
    final int inProgress = _countByStage('In Progress');
    final int verification = _countByStage('Verification');
    final int escalated = _countByStage('Escalated');
    final int critical = _countByPriority('Critical');

    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        const Text(
          'Step 108 — Cross-Module Workflow Integration',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: darkGreen,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Coordinate existing HSE modules through controlled workflow references.',
        ),
        const SizedBox(height: 16),
        _metricCard(
          'Total Workflows',
          _workflows.length,
          Icons.account_tree_outlined,
        ),
        _metricCard(
          'In Progress',
          inProgress,
          Icons.play_circle_outline,
        ),
        _metricCard(
          'Verification',
          verification,
          Icons.verified_outlined,
        ),
        _metricCard(
          'Escalated',
          escalated,
          Icons.priority_high,
        ),
        _metricCard(
          'Critical',
          critical,
          Icons.warning_amber_outlined,
        ),
        const SizedBox(height: 12),
        Card(
          elevation: 0,
          child: Column(
            children: <Widget>[
              const ListTile(
                title: Text(
                  'Workflow lifecycle',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              _metricRow('Triggered', _countByStage('Triggered')),
              _metricRow('Linked', _countByStage('Linked')),
              _metricRow('In Progress', inProgress),
              _metricRow('Verification', verification),
              _metricRow('Escalated', escalated),
              _metricRow('Closed', _countByStage('Closed')),
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
                  'Verification status',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              _metricRow(
                'Pending',
                _countByVerification('Pending'),
              ),
              _metricRow(
                'Verified',
                _countByVerification('Verified'),
              ),
              _metricRow(
                'Rejected',
                _countByVerification('Rejected'),
              ),
              _metricRow(
                'Not Required',
                _countByVerification('Not Required'),
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
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
          child: Row(
            children: <Widget>[
              Expanded(
                child: DropdownButtonFormField<String>(
                  initialValue: _stageFilter,
                  decoration: const InputDecoration(
                    labelText: 'Stage',
                  ),
                  items: <String>['All', ..._stages]
                      .map(
                        (String item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(item),
                        ),
                      )
                      .toList(),
                  onChanged: (String? value) {
                    if (value != null) {
                      setState(() => _stageFilter = value);
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
                  ),
                  items: <String>['All', ..._workflowTypes]
                      .map(
                        (String item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(item),
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
                    'No workflows match the current filters.',
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
                            Icons.account_tree_outlined,
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
                          '${item['source']} → ${item['target']}\n'
                          '${item['type']} • ${item['stage']} • '
                          '${item['priority']}',
                        ),
                        isThreeLine: true,
                        trailing: PopupMenuButton<String>(
                          onSelected: (String action) {
                            if (action == 'edit') {
                              _showWorkflowDialog(
                                editIndex: actualIndex,
                              );
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

  Widget _buildModuleIntelligence() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        const Text(
          'Cross-Module Workflow Intelligence',
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.bold,
            color: darkGreen,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Shows workflow references touching each existing module.',
        ),
        const SizedBox(height: 14),
        ..._modules.map(
          (Map<String, String> module) => Card(
            elevation: 0,
            child: ListTile(
              leading: const Icon(
                Icons.hub_outlined,
                color: primaryGreen,
              ),
              title: Text(module['step']!),
              subtitle: Text(module['name']!),
              trailing: Text(
                '${_countByModule(module['step']!)} workflows',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: darkGreen,
                ),
              ),
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
          'Step 108 Architecture Guide',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: darkGreen,
          ),
        ),
        SizedBox(height: 14),
        _GuideCard(
          number: '108A',
          title: 'Workflow Master',
          text: 'Register controlled workflows that cross existing HSE modules.',
        ),
        _GuideCard(
          number: '108B',
          title: 'Trigger & Source',
          text: 'Identify the module and event that initiates a workflow.',
        ),
        _GuideCard(
          number: '108C',
          title: 'Cross-Module Routing',
          text: 'Connect the workflow to the correct target module without duplicating business logic.',
        ),
        _GuideCard(
          number: '108D',
          title: 'Execution & Verification',
          text: 'Track workflow progress and verification before closure.',
        ),
        _GuideCard(
          number: '108E–108H',
          title: 'Operational Integration',
          text: 'Support risk, action, PTW, incident, inspection, emergency, evidence and compliance workflows.',
        ),
        _GuideCard(
          number: '108I',
          title: 'Escalation Control',
          text: 'Identify workflows requiring additional review or escalation.',
        ),
        _GuideCard(
          number: '108J',
          title: 'Closure Control',
          text: 'Close the orchestration record only after required verification.',
        ),
        _GuideCard(
          number: '108K–108L',
          title: 'Workflow Intelligence',
          text: 'Prepare cross-module workflow signals for dashboards, audit trails and decision support.',
        ),
        SizedBox(height: 10),
        Text(
          'Integration chain',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: darkGreen,
          ),
        ),
        SizedBox(height: 5),
        Text(
          'Existing Module → Trigger → Step 107 Record Link → Workflow → Verification → Escalation → Closure → Intelligence',
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
          'Workflow orchestration does not grant authorization or approve safety-critical work. Competent HSE personnel and the authoritative source modules retain control.',
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> sections = <Widget>[
      _buildDashboard(),
      _buildWorkflowList(),
      _buildModuleIntelligence(),
      _buildGuide(),
    ];

    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        title: const Text('Step 108 • Workflow Integration'),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
      ),
      body: sections[_selectedSection],
      floatingActionButton: _selectedSection == 1
          ? FloatingActionButton.extended(
              onPressed: _showWorkflowDialog,
              backgroundColor: primaryGreen,
              foregroundColor: Colors.white,
              icon: const Icon(Icons.add_link),
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
            Icons.account_tree_outlined,
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
