import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// SafeNexus HSE — Step 107
/// Unified Data & Record Linking
///
/// Purpose:
/// - Link references between existing SafeNexus records without duplicating
///   source records.
/// - Provide a controlled record-link registry for WorkHub, workflow, risk
///   and evidence intelligence.
/// - Keep the original source module as the system of record.
/// - UAE-wide scalable architecture.
/// - English + Malayalam ready.
///
/// Architecture:
/// Source Record → Link Registry → Related Record → Evidence / Risk / Workflow
///
/// Safety principle:
/// A record link is a reference, not an approval or safety decision.
/// Source modules remain authoritative for validation, authorization and
/// closure.

class SafeNexusStep107UnifiedRecordLinkingPage extends StatefulWidget {
  const SafeNexusStep107UnifiedRecordLinkingPage({super.key});

  @override
  State<SafeNexusStep107UnifiedRecordLinkingPage> createState() =>
      _SafeNexusStep107UnifiedRecordLinkingPageState();
}

class _SafeNexusStep107UnifiedRecordLinkingPageState
    extends State<SafeNexusStep107UnifiedRecordLinkingPage> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);
  static const String _storageKey =
      'safenexus_hse_step107_unified_data_record_linking';

  final List<String> _linkTypes = <String>[
    'Related',
    'Evidence',
    'Risk',
    'Action',
    'Workflow',
    'Compliance',
    'Follow-up',
  ];

  final List<String> _statuses = <String>[
    'Draft',
    'Linked',
    'Verified',
    'Needs Review',
    'Closed',
  ];

  final List<String> _priorities = <String>[
    'Low',
    'Medium',
    'High',
    'Critical',
  ];

  final List<Map<String, String>> _sourceModules =
      <Map<String, String>>[
    {'step': 'Step 9', 'name': 'Daily HSE'},
    {'step': 'Step 31', 'name': 'Smart Checklists'},
    {'step': 'Step 32', 'name': 'Field Operations'},
    {'step': 'Step 33', 'name': 'Communication & Engagement'},
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
  ];

  final List<Map<String, String>> _templates =
      <Map<String, String>>[
    {
      'title': 'Field Observation → Risk',
      'source': 'Step 32',
      'target': 'Step 36',
      'type': 'Risk',
      'status': 'Verified',
      'priority': 'High',
    },
    {
      'title': 'Risk → RAMS',
      'source': 'Step 36',
      'target': 'Step 37',
      'type': 'Workflow',
      'status': 'Linked',
      'priority': 'Critical',
    },
    {
      'title': 'RAMS → PTW',
      'source': 'Step 37',
      'target': 'Step 38',
      'type': 'Workflow',
      'status': 'Linked',
      'priority': 'Critical',
    },
    {
      'title': 'Incident → Corrective Action',
      'source': 'Step 44',
      'target': 'Step 35',
      'type': 'Action',
      'status': 'Verified',
      'priority': 'Critical',
    },
    {
      'title': 'Inspection → Evidence',
      'source': 'Step 41',
      'target': 'Step 104',
      'type': 'Evidence',
      'status': 'Linked',
      'priority': 'High',
    },
    {
      'title': 'Audit → Compliance',
      'source': 'Step 45',
      'target': 'Step 46',
      'type': 'Compliance',
      'status': 'Needs Review',
      'priority': 'High',
    },
    {
      'title': 'WorkHub → Source Record',
      'source': 'Step 106',
      'target': 'Step 34',
      'type': 'Related',
      'status': 'Linked',
      'priority': 'Medium',
    },
    {
      'title': 'Evidence → Risk Verification',
      'source': 'Step 104',
      'target': 'Step 105',
      'type': 'Evidence',
      'status': 'Verified',
      'priority': 'High',
    },
  ];

  List<Map<String, String>> _links = <Map<String, String>>[];
  String _search = '';
  String _typeFilter = 'All';
  String _statusFilter = 'All';
  String _priorityFilter = 'All';
  int _selectedSection = 0;

  @override
  void initState() {
    super.initState();
    _loadLinks();
  }

  Future<void> _loadLinks() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> saved =
        prefs.getStringList(_storageKey) ?? <String>[];

    if (saved.isEmpty) {
      _links = _templates
          .map((Map<String, String> item) => Map<String, String>.from(item))
          .toList();
    } else {
      _links = saved
          .map(_decodeLink)
          .whereType<Map<String, String>>()
          .toList();
    }

    if (mounted) {
      setState(() {});
    }
  }

  Map<String, String>? _decodeLink(String value) {
    final List<String> parts = value.split('¦');
    if (parts.length != 6) {
      return null;
    }
    return <String, String>{
      'title': parts[0],
      'source': parts[1],
      'target': parts[2],
      'type': parts[3],
      'status': parts[4],
      'priority': parts[5],
    };
  }

  String _encodeLink(Map<String, String> item) {
    return <String>[
      item['title'] ?? '',
      item['source'] ?? '',
      item['target'] ?? '',
      item['type'] ?? 'Related',
      item['status'] ?? 'Draft',
      item['priority'] ?? 'Medium',
    ].join('¦');
  }

  Future<void> _saveLinks() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      _storageKey,
      _links.map(_encodeLink).toList(),
    );
  }

  List<Map<String, String>> get _filteredLinks {
    return _links.where((Map<String, String> item) {
      final String query = _search.trim().toLowerCase();
      final String haystack = <String>[
        item['title'] ?? '',
        item['source'] ?? '',
        item['target'] ?? '',
        item['type'] ?? '',
        item['status'] ?? '',
        item['priority'] ?? '',
      ].join(' ').toLowerCase();

      final bool searchMatch =
          query.isEmpty || haystack.contains(query);
      final bool typeMatch =
          _typeFilter == 'All' || item['type'] == _typeFilter;
      final bool statusMatch =
          _statusFilter == 'All' || item['status'] == _statusFilter;
      final bool priorityMatch =
          _priorityFilter == 'All' || item['priority'] == _priorityFilter;

      return searchMatch && typeMatch && statusMatch && priorityMatch;
    }).toList();
  }

  int _countByStatus(String status) {
    return _links
        .where((Map<String, String> item) => item['status'] == status)
        .length;
  }

  int _countByType(String type) {
    return _links
        .where((Map<String, String> item) => item['type'] == type)
        .length;
  }

  int _countByPriority(String priority) {
    return _links
        .where((Map<String, String> item) => item['priority'] == priority)
        .length;
  }

  int _countByModule(String module) {
    return _links
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

  Future<void> _showLinkDialog({int? editIndex}) async {
    final Map<String, String>? existing =
        editIndex == null ? null : _links[editIndex];

    final TextEditingController titleController =
        TextEditingController(text: existing?['title'] ?? '');

    String source = existing?['source'] ?? _sourceModules.first['step']!;
    String target = existing?['target'] ?? _sourceModules[1]['step']!;
    String type = existing?['type'] ?? 'Related';
    String status = existing?['status'] ?? 'Draft';
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
                editIndex == null ? 'Add Record Link' : 'Edit Record Link',
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        labelText: 'Link title',
                        prefixIcon: Icon(Icons.link_outlined),
                      ),
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      initialValue: source,
                      decoration: const InputDecoration(
                        labelText: 'Source module',
                      ),
                      items: _sourceModules
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
                      items: _sourceModules
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
                        labelText: 'Link type',
                      ),
                      items: _linkTypes
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

    titleController.dispose();

    if (result == null || !mounted) {
      return;
    }

    setState(() {
      if (editIndex == null) {
        _links.add(result);
      } else {
        _links[editIndex] = result;
      }
    });

    await _saveLinks();
  }

  Future<void> _deleteLink(int index) async {
    setState(() {
      _links.removeAt(index);
    });
    await _saveLinks();
  }

  void _showLinkDetails(Map<String, String> item) {
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
                  item['title'] ?? 'Record Link',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: darkGreen,
                  ),
                ),
                const SizedBox(height: 12),
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
                  leading: const Icon(Icons.merge_type_outlined),
                  title: const Text('Link type'),
                  subtitle: Text(item['type'] ?? ''),
                ),
                ListTile(
                  dense: true,
                  leading: const Icon(Icons.verified_outlined),
                  title: const Text('Status'),
                  subtitle: Text(item['status'] ?? ''),
                ),
                ListTile(
                  dense: true,
                  leading: const Icon(Icons.priority_high),
                  title: const Text('Priority'),
                  subtitle: Text(item['priority'] ?? ''),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Control note: this link is a reference between records. '
                  'The source modules remain responsible for their own '
                  'validation, authorization and closure.',
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDashboard() {
    final int linked = _countByStatus('Linked');
    final int verified = _countByStatus('Verified');
    final int review = _countByStatus('Needs Review');
    final int critical = _countByPriority('Critical');

    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        const Text(
          'Step 107 — Unified Data & Record Linking',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: darkGreen,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Controlled references between existing SafeNexus records.',
        ),
        const SizedBox(height: 16),
        _metricCard(
          'Total Links',
          _links.length,
          Icons.link_outlined,
        ),
        _metricCard(
          'Linked',
          linked,
          Icons.link,
        ),
        _metricCard(
          'Verified',
          verified,
          Icons.verified_outlined,
        ),
        _metricCard(
          'Needs Review',
          review,
          Icons.rate_review_outlined,
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
                  'Link lifecycle',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              _metricRow('Draft', _countByStatus('Draft')),
              _metricRow('Linked', linked),
              _metricRow('Verified', verified),
              _metricRow('Needs Review', review),
              _metricRow('Closed', _countByStatus('Closed')),
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
                  'Link types',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              _metricRow('Evidence', _countByType('Evidence')),
              _metricRow('Risk', _countByType('Risk')),
              _metricRow('Action', _countByType('Action')),
              _metricRow('Workflow', _countByType('Workflow')),
              _metricRow('Compliance', _countByType('Compliance')),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLinkList() {
    final List<Map<String, String>> items = _filteredLinks;

    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
          child: TextField(
            decoration: const InputDecoration(
              hintText: 'Search record link or module',
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
                  initialValue: _typeFilter,
                  decoration: const InputDecoration(labelText: 'Type'),
                  items: <String>['All', ..._linkTypes]
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
              const SizedBox(width: 8),
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
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
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
        Expanded(
          child: items.isEmpty
              ? const Center(
                  child: Text('No record links match the current filters.'),
                )
              : ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 90),
                  itemCount: items.length,
                  itemBuilder: (BuildContext context, int visibleIndex) {
                    final Map<String, String> item = items[visibleIndex];
                    final int actualIndex = _links.indexOf(item);

                    return Card(
                      elevation: 0,
                      margin: const EdgeInsets.only(bottom: 10),
                      child: ListTile(
                        onTap: () => _showLinkDetails(item),
                        leading: CircleAvatar(
                          backgroundColor:
                              primaryGreen.withValues(alpha: 0.10),
                          child: const Icon(
                            Icons.link_outlined,
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
                          '${item['type']} • ${item['status']} • '
                          '${item['priority']}',
                        ),
                        isThreeLine: true,
                        trailing: PopupMenuButton<String>(
                          onSelected: (String action) {
                            if (action == 'edit') {
                              _showLinkDialog(editIndex: actualIndex);
                            } else if (action == 'delete') {
                              _deleteLink(actualIndex);
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
          'Record Linking by Module',
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.bold,
            color: darkGreen,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Shows how many unified references touch each existing module.',
        ),
        const SizedBox(height: 14),
        ..._sourceModules.map(
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
                '${_countByModule(module['step']!)} links',
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
          'Step 107 Architecture Guide',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: darkGreen,
          ),
        ),
        SizedBox(height: 14),
        _GuideCard(
          number: '107A',
          title: 'Record Link Master',
          text: 'Register controlled relationships between existing records.',
        ),
        _GuideCard(
          number: '107B',
          title: 'Source & Target',
          text: 'Identify the originating and related SafeNexus modules.',
        ),
        _GuideCard(
          number: '107C',
          title: 'Link Classification',
          text: 'Classify references as risk, evidence, action, workflow or compliance.',
        ),
        _GuideCard(
          number: '107D',
          title: 'Verification',
          text: 'Distinguish a simple link from a link that has been verified.',
        ),
        _GuideCard(
          number: '107E–107H',
          title: 'Cross-Module Records',
          text: 'Connect field, risk, RAMS, PTW, workforce, equipment, incident, audit and management records.',
        ),
        _GuideCard(
          number: '107I',
          title: 'Traceability',
          text: 'Maintain clear relationships for investigation and audit review.',
        ),
        _GuideCard(
          number: '107J–107L',
          title: 'Unified Intelligence',
          text: 'Prepare linked record signals for workflow, evidence, risk and enterprise intelligence layers.',
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
          'Record linking never changes the source record authority. Approvals, risk acceptance, permits, investigations and closures remain with their competent source modules.',
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> sections = <Widget>[
      _buildDashboard(),
      _buildLinkList(),
      _buildModuleIntelligence(),
      _buildGuide(),
    ];

    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        title: const Text('Step 107 • Record Linking'),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
      ),
      body: sections[_selectedSection],
      floatingActionButton: _selectedSection == 1
          ? FloatingActionButton.extended(
              onPressed: _showLinkDialog,
              backgroundColor: primaryGreen,
              foregroundColor: Colors.white,
              icon: const Icon(Icons.add_link),
              label: const Text('Add Link'),
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
            icon: Icon(Icons.link_outlined),
            selectedIcon: Icon(Icons.link),
            label: 'Links',
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
            Icons.shield_outlined,
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
