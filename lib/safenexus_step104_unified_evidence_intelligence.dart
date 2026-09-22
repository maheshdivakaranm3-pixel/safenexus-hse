import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// SafeNexus HSE — Step 104
/// HSE Data Integration & Unified Evidence Intelligence
///
/// Purpose:
/// - Provide one controlled evidence/data registry across existing HSE modules.
/// - Avoid duplicating the source records owned by Steps 1–103.
/// - Track evidence quality, verification, source module, priority and status.
/// - Support UAE-wide HSE operations.
/// - English + Malayalam ready.
///
/// Safety principle:
/// This layer is an evidence and decision-support layer. It must not replace
/// competent HSE review, authorization, inspection, investigation or approval.

class SafeNexusStep104UnifiedEvidencePage extends StatefulWidget {
  const SafeNexusStep104UnifiedEvidencePage({super.key});

  @override
  State<SafeNexusStep104UnifiedEvidencePage> createState() =>
      _SafeNexusStep104UnifiedEvidencePageState();
}

class _SafeNexusStep104UnifiedEvidencePageState
    extends State<SafeNexusStep104UnifiedEvidencePage> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);
  static const String _storageKey =
      'safenexus_hse_step104_unified_evidence_intelligence';

  final List<String> _statuses = <String>[
    'Captured',
    'Under Review',
    'Verified',
    'Rejected',
    'Archived',
  ];

  final List<String> _priorities = <String>[
    'Low',
    'Medium',
    'High',
    'Critical',
  ];

  final List<String> _evidenceTypes = <String>[
    'Photo',
    'Document',
    'Inspection Record',
    'Permit Record',
    'Risk Assessment',
    'RAMS Record',
    'Incident Record',
    'Training Record',
    'Audit Finding',
    'Other',
  ];

  final List<Map<String, String>> _sourceModules =
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
    {'step': 'Step 81–90', 'name': 'AI Intelligence'},
    {'step': 'Step 91–100', 'name': 'Enterprise Intelligence'},
    {'step': 'Step 103', 'name': 'Workflow Orchestration'},
  ];

  final List<Map<String, String>> _templates =
      <Map<String, String>>[
    {
      'title': 'Field Safety Photo Evidence',
      'type': 'Photo',
      'source': 'Step 32',
      'status': 'Captured',
      'priority': 'High',
      'quality': 'Good',
    },
    {
      'title': 'Critical Risk Control Evidence',
      'type': 'Risk Assessment',
      'source': 'Step 36',
      'status': 'Under Review',
      'priority': 'Critical',
      'quality': 'Good',
    },
    {
      'title': 'RAMS Approval Evidence',
      'type': 'RAMS Record',
      'source': 'Step 37',
      'status': 'Verified',
      'priority': 'High',
      'quality': 'Excellent',
    },
    {
      'title': 'Permit Authorization Evidence',
      'type': 'Permit Record',
      'source': 'Step 38',
      'status': 'Verified',
      'priority': 'Critical',
      'quality': 'Excellent',
    },
    {
      'title': 'Incident Investigation Evidence',
      'type': 'Incident Record',
      'source': 'Step 44',
      'status': 'Under Review',
      'priority': 'Critical',
      'quality': 'Good',
    },
    {
      'title': 'Audit Compliance Evidence',
      'type': 'Audit Finding',
      'source': 'Step 45',
      'status': 'Captured',
      'priority': 'High',
      'quality': 'Fair',
    },
    {
      'title': 'Worker Competency Evidence',
      'type': 'Training Record',
      'source': 'Step 39',
      'status': 'Verified',
      'priority': 'Medium',
      'quality': 'Excellent',
    },
  ];

  List<Map<String, String>> _evidence = <Map<String, String>>[];
  String _search = '';
  String _statusFilter = 'All';
  String _priorityFilter = 'All';
  String _typeFilter = 'All';
  int _selectedSection = 0;

  @override
  void initState() {
    super.initState();
    _loadEvidence();
  }

  Future<void> _loadEvidence() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> saved = prefs.getStringList(_storageKey) ?? <String>[];

    if (saved.isEmpty) {
      _evidence = _templates
          .map(
            (Map<String, String> item) => Map<String, String>.from(item),
          )
          .toList();
    } else {
      _evidence = saved
          .map(_decodeEvidence)
          .whereType<Map<String, String>>()
          .toList();
    }

    if (mounted) {
      setState(() {});
    }
  }

  Map<String, String>? _decodeEvidence(String value) {
    final List<String> parts = value.split('¦');
    if (parts.length != 6) {
      return null;
    }

    return <String, String>{
      'title': parts[0],
      'type': parts[1],
      'source': parts[2],
      'status': parts[3],
      'priority': parts[4],
      'quality': parts[5],
    };
  }

  String _encodeEvidence(Map<String, String> item) {
    return <String>[
      item['title'] ?? '',
      item['type'] ?? 'Other',
      item['source'] ?? '',
      item['status'] ?? 'Captured',
      item['priority'] ?? 'Medium',
      item['quality'] ?? 'Fair',
    ].join('¦');
  }

  Future<void> _saveEvidence() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      _storageKey,
      _evidence.map(_encodeEvidence).toList(),
    );
  }

  List<Map<String, String>> get _filteredEvidence {
    return _evidence.where((Map<String, String> item) {
      final String haystack = <String>[
        item['title'] ?? '',
        item['type'] ?? '',
        item['source'] ?? '',
        item['quality'] ?? '',
      ].join(' ').toLowerCase();

      final bool searchMatch =
          _search.trim().isEmpty || haystack.contains(_search.toLowerCase());
      final bool statusMatch =
          _statusFilter == 'All' || item['status'] == _statusFilter;
      final bool priorityMatch =
          _priorityFilter == 'All' || item['priority'] == _priorityFilter;
      final bool typeMatch =
          _typeFilter == 'All' || item['type'] == _typeFilter;

      return searchMatch && statusMatch && priorityMatch && typeMatch;
    }).toList();
  }

  int _countByStatus(String status) {
    return _evidence
        .where((Map<String, String> item) => item['status'] == status)
        .length;
  }

  int _countByPriority(String priority) {
    return _evidence
        .where((Map<String, String> item) => item['priority'] == priority)
        .length;
  }

  int _countByQuality(String quality) {
    return _evidence
        .where((Map<String, String> item) => item['quality'] == quality)
        .length;
  }

  int _countBySource(String source) {
    return _evidence
        .where((Map<String, String> item) => item['source'] == source)
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

  Future<void> _showEvidenceDialog({int? editIndex}) async {
    final Map<String, String>? existing =
        editIndex == null ? null : _evidence[editIndex];

    final TextEditingController titleController =
        TextEditingController(text: existing?['title'] ?? '');

    String type = existing?['type'] ?? _evidenceTypes.first;
    String source = existing?['source'] ?? _sourceModules.first['step']!;
    String status = existing?['status'] ?? 'Captured';
    String priority = existing?['priority'] ?? 'Medium';
    String quality = existing?['quality'] ?? 'Fair';

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
                editIndex == null ? 'Add Evidence' : 'Edit Evidence',
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        labelText: 'Evidence title',
                        prefixIcon: Icon(Icons.description_outlined),
                      ),
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      initialValue: type,
                      decoration: const InputDecoration(
                        labelText: 'Evidence type',
                      ),
                      items: _evidenceTypes
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
                    DropdownButtonFormField<String>(
                      initialValue: quality,
                      decoration: const InputDecoration(
                        labelText: 'Evidence quality',
                      ),
                      items: const <String>[
                        'Poor',
                        'Fair',
                        'Good',
                        'Excellent',
                      ]
                          .map(
                            (String item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(item),
                            ),
                          )
                          .toList(),
                      onChanged: (String? value) {
                        if (value != null) {
                          dialogSetState(() => quality = value);
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
                    if (title.isEmpty) {
                      return;
                    }

                    Navigator.pop(
                      context,
                      <String, String>{
                        'title': title,
                        'type': type,
                        'source': source,
                        'status': status,
                        'priority': priority,
                        'quality': quality,
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
        _evidence.add(result);
      } else {
        _evidence[editIndex] = result;
      }
    });

    await _saveEvidence();
  }

  Future<void> _deleteEvidence(int index) async {
    setState(() {
      _evidence.removeAt(index);
    });
    await _saveEvidence();
  }

  void _showEvidenceDetails(Map<String, String> item) {
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
                  item['title'] ?? 'Evidence',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: darkGreen,
                  ),
                ),
                const SizedBox(height: 12),
                ListTile(
                  dense: true,
                  leading: const Icon(Icons.category_outlined),
                  title: const Text('Evidence type'),
                  subtitle: Text(item['type'] ?? ''),
                ),
                ListTile(
                  dense: true,
                  leading: const Icon(Icons.hub_outlined),
                  title: const Text('Source module'),
                  subtitle: Text(item['source'] ?? ''),
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
                ListTile(
                  dense: true,
                  leading: const Icon(Icons.fact_check_outlined),
                  title: const Text('Quality'),
                  subtitle: Text(item['quality'] ?? ''),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Control note: evidence should remain traceable to its '
                  'source module and must be reviewed before being used for '
                  'safety-critical decisions.',
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDashboard() {
    final int captured = _countByStatus('Captured');
    final int review = _countByStatus('Under Review');
    final int verified = _countByStatus('Verified');
    final int critical = _countByPriority('Critical');
    final int excellent = _countByQuality('Excellent');

    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        const Text(
          'Step 104 — Unified Evidence Intelligence',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: darkGreen,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'A controlled evidence layer connecting existing HSE records.',
        ),
        const SizedBox(height: 16),
        _metricCard(
          'Total Evidence',
          _evidence.length,
          Icons.folder_copy_outlined,
        ),
        _metricCard(
          'Captured',
          captured,
          Icons.add_a_photo_outlined,
        ),
        _metricCard(
          'Under Review',
          review,
          Icons.rate_review_outlined,
        ),
        _metricCard(
          'Verified',
          verified,
          Icons.verified_outlined,
        ),
        _metricCard(
          'Critical',
          critical,
          Icons.warning_amber_outlined,
        ),
        _metricCard(
          'Excellent Quality',
          excellent,
          Icons.star_outline,
        ),
        const SizedBox(height: 12),
        Card(
          elevation: 0,
          child: Column(
            children: <Widget>[
              const ListTile(
                title: Text(
                  'Evidence lifecycle',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              _metricRow('Captured', captured),
              _metricRow('Under Review', review),
              _metricRow('Verified', verified),
              _metricRow('Rejected', _countByStatus('Rejected')),
              _metricRow('Archived', _countByStatus('Archived')),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEvidenceList() {
    final List<Map<String, String>> items = _filteredEvidence;

    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
          child: TextField(
            decoration: const InputDecoration(
              hintText: 'Search evidence, type or source',
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
              const SizedBox(width: 8),
              Expanded(
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
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
          child: DropdownButtonFormField<String>(
            initialValue: _typeFilter,
            decoration: const InputDecoration(
              labelText: 'Evidence type',
            ),
            items: <String>['All', ..._evidenceTypes]
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
        Expanded(
          child: items.isEmpty
              ? const Center(
                  child: Text('No evidence matches the current filters.'),
                )
              : ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 90),
                  itemCount: items.length,
                  itemBuilder: (BuildContext context, int visibleIndex) {
                    final Map<String, String> item = items[visibleIndex];
                    final int actualIndex = _evidence.indexOf(item);

                    return Card(
                      elevation: 0,
                      margin: const EdgeInsets.only(bottom: 10),
                      child: ListTile(
                        onTap: () => _showEvidenceDetails(item),
                        leading: CircleAvatar(
                          backgroundColor:
                              primaryGreen.withValues(alpha: 0.10),
                          child: const Icon(
                            Icons.folder_copy_outlined,
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
                          '${item['type']} • ${item['source']}\n'
                          'Status: ${item['status']} • '
                          'Priority: ${item['priority']} • '
                          'Quality: ${item['quality']}',
                        ),
                        isThreeLine: true,
                        trailing: PopupMenuButton<String>(
                          onSelected: (String action) {
                            if (action == 'edit') {
                              _showEvidenceDialog(editIndex: actualIndex);
                            } else if (action == 'delete') {
                              _deleteEvidence(actualIndex);
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

  Widget _buildSourceIntelligence() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        const Text(
          'Source Module Intelligence',
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.bold,
            color: darkGreen,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Visibility into where unified evidence originates. Source records '
          'remain owned by their original HSE modules.',
        ),
        const SizedBox(height: 14),
        ..._sourceModules.map(
          (Map<String, String> module) => Card(
            elevation: 0,
            child: ListTile(
              leading: const Icon(
                Icons.link,
                color: primaryGreen,
              ),
              title: Text(module['step']!),
              subtitle: Text(module['name']!),
              trailing: Text(
                '${_countBySource(module['step']!)}',
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
          'Step 104 Architecture Guide',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: darkGreen,
          ),
        ),
        SizedBox(height: 14),
        _GuideCard(
          number: '104A',
          title: 'Evidence Master',
          text: 'Register evidence references without duplicating source records.',
        ),
        _GuideCard(
          number: '104B',
          title: 'Source Integration',
          text: 'Identify the originating HSE module for every evidence item.',
        ),
        _GuideCard(
          number: '104C',
          title: 'Evidence Quality',
          text: 'Classify evidence quality so management can distinguish '
              'weak, usable and strong evidence.',
        ),
        _GuideCard(
          number: '104D',
          title: 'Verification Control',
          text: 'Separate captured evidence from evidence that has been '
              'competently verified.',
        ),
        _GuideCard(
          number: '104E–104J',
          title: 'Unified HSE Evidence',
          text: 'Support field, risk, RAMS, PTW, workforce, equipment, '
              'incident, audit, compliance and management evidence.',
        ),
        _GuideCard(
          number: '104K',
          title: 'Traceability',
          text: 'Keep evidence linked to its source module for auditability.',
        ),
        _GuideCard(
          number: '104L',
          title: 'Evidence Intelligence',
          text: 'Provide management visibility into volume, quality, status '
              'and critical evidence signals.',
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
          'Evidence intelligence supports decisions; it does not replace '
          'competent HSE assessment, authorization, investigation or approval.',
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> sections = <Widget>[
      _buildDashboard(),
      _buildEvidenceList(),
      _buildSourceIntelligence(),
      _buildGuide(),
    ];

    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        title: const Text('Step 104 • Evidence Intelligence'),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
      ),
      body: sections[_selectedSection],
      floatingActionButton: _selectedSection == 1
          ? FloatingActionButton.extended(
              onPressed: _showEvidenceDialog,
              backgroundColor: primaryGreen,
              foregroundColor: Colors.white,
              icon: const Icon(Icons.add),
              label: const Text('Add Evidence'),
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
            icon: Icon(Icons.folder_copy_outlined),
            selectedIcon: Icon(Icons.folder_copy),
            label: 'Evidence',
          ),
          NavigationDestination(
            icon: Icon(Icons.hub_outlined),
            selectedIcon: Icon(Icons.hub),
            label: 'Sources',
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
