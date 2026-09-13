import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// SafeNexus HSE — Step 105
/// Unified Risk, Control & Evidence Intelligence Hub
///
/// Purpose:
/// - Connect risk, critical controls, evidence and verification in one
///   controlled intelligence layer.
/// - Avoid duplicating source records owned by existing SafeNexus modules.
/// - Provide local CRUD, filtering, traceability and management visibility.
/// - UAE-wide scalable architecture.
/// - English + Malayalam ready.
///
/// Safety principle:
/// This layer is decision support. It must not bypass competent HSE review,
/// risk acceptance, permit authorization, field verification or escalation.

class SafeNexusStep105UnifiedRiskControlPage extends StatefulWidget {
  const SafeNexusStep105UnifiedRiskControlPage({super.key});

  @override
  State<SafeNexusStep105UnifiedRiskControlPage> createState() =>
      _SafeNexusStep105UnifiedRiskControlPageState();
}

class _SafeNexusStep105UnifiedRiskControlPageState
    extends State<SafeNexusStep105UnifiedRiskControlPage> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);
  static const String _storageKey =
      'safenexus_hse_step105_unified_risk_control_evidence';

  final List<String> _statuses = <String>[
    'Identified',
    'Controls Planned',
    'Verification',
    'Controlled',
    'Escalated',
    'Closed',
  ];

  final List<String> _priorities = <String>[
    'Low',
    'Medium',
    'High',
    'Critical',
  ];

  final List<String> _riskLevels = <String>[
    'Low',
    'Medium',
    'High',
    'Extreme',
  ];

  final List<String> _controlTypes = <String>[
    'Elimination',
    'Substitution',
    'Engineering',
    'Administrative',
    'PPE',
    'Critical Barrier',
  ];

  final List<Map<String, String>> _sourceModules =
      <Map<String, String>>[
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
    {'step': 'Step 103', 'name': 'Workflow Orchestration'},
    {'step': 'Step 104', 'name': 'Evidence Intelligence'},
    {'step': 'Step 81–90', 'name': 'AI Intelligence'},
    {'step': 'Step 91–100', 'name': 'Enterprise Intelligence'},
  ];

  final List<Map<String, String>> _templates =
      <Map<String, String>>[
    {
      'title': 'Work at Height Fall Risk',
      'hazard': 'Fall from height',
      'risk': 'High',
      'control': 'Critical Barrier',
      'verification': 'Verification',
      'evidence': 'Step 104',
      'source': 'Step 36',
      'status': 'Controls Planned',
      'priority': 'Critical',
    },
    {
      'title': 'Hot Work Fire Risk',
      'hazard': 'Ignition / fire',
      'risk': 'Extreme',
      'control': 'Engineering',
      'verification': 'Controlled',
      'evidence': 'Step 104',
      'source': 'Step 38',
      'status': 'Controlled',
      'priority': 'Critical',
    },
    {
      'title': 'Lifting Operation Risk',
      'hazard': 'Dropped load',
      'risk': 'High',
      'control': 'Administrative',
      'verification': 'Verification',
      'evidence': 'Step 41',
      'source': 'Step 40',
      'status': 'Verification',
      'priority': 'High',
    },
    {
      'title': 'Confined Space Exposure',
      'hazard': 'Atmospheric exposure',
      'risk': 'Extreme',
      'control': 'Engineering',
      'verification': 'Verification',
      'evidence': 'Step 104',
      'source': 'Step 38',
      'status': 'Escalated',
      'priority': 'Critical',
    },
    {
      'title': 'Contractor Competency Risk',
      'hazard': 'Unverified competency',
      'risk': 'High',
      'control': 'Administrative',
      'verification': 'Controlled',
      'evidence': 'Step 39',
      'source': 'Step 50',
      'status': 'Controlled',
      'priority': 'High',
    },
    {
      'title': 'Electrical Isolation Risk',
      'hazard': 'Unexpected energization',
      'risk': 'Extreme',
      'control': 'Critical Barrier',
      'verification': 'Verification',
      'evidence': 'Step 104',
      'source': 'Step 38',
      'status': 'Controls Planned',
      'priority': 'Critical',
    },
    {
      'title': 'Field Unsafe Condition',
      'hazard': 'Unsafe site condition',
      'risk': 'Medium',
      'control': 'Administrative',
      'verification': 'Verification',
      'evidence': 'Step 104',
      'source': 'Step 32',
      'status': 'Identified',
      'priority': 'Medium',
    },
  ];

  List<Map<String, String>> _riskItems = <Map<String, String>>[];
  String _search = '';
  String _statusFilter = 'All';
  String _priorityFilter = 'All';
  String _riskFilter = 'All';
  int _selectedSection = 0;

  @override
  void initState() {
    super.initState();
    _loadRiskItems();
  }

  Future<void> _loadRiskItems() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> saved =
        prefs.getStringList(_storageKey) ?? <String>[];

    if (saved.isEmpty) {
      _riskItems = _templates
          .map(
            (Map<String, String> item) => Map<String, String>.from(item),
          )
          .toList();
    } else {
      _riskItems = saved
          .map(_decodeRiskItem)
          .whereType<Map<String, String>>()
          .toList();
    }

    if (mounted) {
      setState(() {});
    }
  }

  Map<String, String>? _decodeRiskItem(String value) {
    final List<String> parts = value.split('¦');
    if (parts.length != 9) {
      return null;
    }

    return <String, String>{
      'title': parts[0],
      'hazard': parts[1],
      'risk': parts[2],
      'control': parts[3],
      'verification': parts[4],
      'evidence': parts[5],
      'source': parts[6],
      'status': parts[7],
      'priority': parts[8],
    };
  }

  String _encodeRiskItem(Map<String, String> item) {
    return <String>[
      item['title'] ?? '',
      item['hazard'] ?? '',
      item['risk'] ?? 'Medium',
      item['control'] ?? 'Administrative',
      item['verification'] ?? 'Verification',
      item['evidence'] ?? 'Step 104',
      item['source'] ?? 'Step 36',
      item['status'] ?? 'Identified',
      item['priority'] ?? 'Medium',
    ].join('¦');
  }

  Future<void> _saveRiskItems() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      _storageKey,
      _riskItems.map(_encodeRiskItem).toList(),
    );
  }

  List<Map<String, String>> get _filteredRiskItems {
    return _riskItems.where((Map<String, String> item) {
      final String haystack = <String>[
        item['title'] ?? '',
        item['hazard'] ?? '',
        item['risk'] ?? '',
        item['control'] ?? '',
        item['evidence'] ?? '',
        item['source'] ?? '',
      ].join(' ').toLowerCase();

      final bool searchMatch =
          _search.trim().isEmpty || haystack.contains(_search.toLowerCase());
      final bool statusMatch =
          _statusFilter == 'All' || item['status'] == _statusFilter;
      final bool priorityMatch =
          _priorityFilter == 'All' || item['priority'] == _priorityFilter;
      final bool riskMatch =
          _riskFilter == 'All' || item['risk'] == _riskFilter;

      return searchMatch && statusMatch && priorityMatch && riskMatch;
    }).toList();
  }

  int _countByStatus(String status) {
    return _riskItems
        .where((Map<String, String> item) => item['status'] == status)
        .length;
  }

  int _countByPriority(String priority) {
    return _riskItems
        .where((Map<String, String> item) => item['priority'] == priority)
        .length;
  }

  int _countByRisk(String risk) {
    return _riskItems
        .where((Map<String, String> item) => item['risk'] == risk)
        .length;
  }

  int _countByControl(String control) {
    return _riskItems
        .where((Map<String, String> item) => item['control'] == control)
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

  Future<void> _showRiskDialog({int? editIndex}) async {
    final Map<String, String>? existing =
        editIndex == null ? null : _riskItems[editIndex];

    final TextEditingController titleController =
        TextEditingController(text: existing?['title'] ?? '');
    final TextEditingController hazardController =
        TextEditingController(text: existing?['hazard'] ?? '');

    String risk = existing?['risk'] ?? 'Medium';
    String control = existing?['control'] ?? 'Administrative';
    String verification = existing?['verification'] ?? 'Verification';
    String evidence = existing?['evidence'] ?? 'Step 104';
    String source = existing?['source'] ?? 'Step 36';
    String status = existing?['status'] ?? 'Identified';
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
                editIndex == null ? 'Add Risk Intelligence' : 'Edit Risk',
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        labelText: 'Risk title',
                        prefixIcon: Icon(Icons.warning_amber_outlined),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: hazardController,
                      decoration: const InputDecoration(
                        labelText: 'Hazard',
                        prefixIcon: Icon(Icons.report_problem_outlined),
                      ),
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      initialValue: risk,
                      decoration: const InputDecoration(
                        labelText: 'Risk level',
                      ),
                      items: _riskLevels
                          .map(
                            (String item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(item),
                            ),
                          )
                          .toList(),
                      onChanged: (String? value) {
                        if (value != null) {
                          dialogSetState(() => risk = value);
                        }
                      },
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      initialValue: control,
                      decoration: const InputDecoration(
                        labelText: 'Primary control',
                      ),
                      items: _controlTypes
                          .map(
                            (String item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(item),
                            ),
                          )
                          .toList(),
                      onChanged: (String? value) {
                        if (value != null) {
                          dialogSetState(() => control = value);
                        }
                      },
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      initialValue: verification,
                      decoration: const InputDecoration(
                        labelText: 'Control verification',
                      ),
                      items: const <String>[
                        'Not Started',
                        'Verification',
                        'Verified',
                        'Failed',
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
                          dialogSetState(() => verification = value);
                        }
                      },
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      initialValue: evidence,
                      decoration: const InputDecoration(
                        labelText: 'Evidence source',
                      ),
                      items: const <String>[
                        'Step 104',
                        'Step 41',
                        'Step 44',
                        'Step 45',
                        'Step 39',
                        'Step 32',
                        'None',
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
                          dialogSetState(() => evidence = value);
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
                    final String hazard = hazardController.text.trim();

                    if (title.isEmpty || hazard.isEmpty) {
                      return;
                    }

                    Navigator.pop(
                      context,
                      <String, String>{
                        'title': title,
                        'hazard': hazard,
                        'risk': risk,
                        'control': control,
                        'verification': verification,
                        'evidence': evidence,
                        'source': source,
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
    hazardController.dispose();

    if (result == null || !mounted) {
      return;
    }

    setState(() {
      if (editIndex == null) {
        _riskItems.add(result);
      } else {
        _riskItems[editIndex] = result;
      }
    });

    await _saveRiskItems();
  }

  Future<void> _deleteRiskItem(int index) async {
    setState(() {
      _riskItems.removeAt(index);
    });
    await _saveRiskItems();
  }

  void _showRiskDetails(Map<String, String> item) {
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
                  item['title'] ?? 'Risk',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: darkGreen,
                  ),
                ),
                const SizedBox(height: 12),
                ListTile(
                  dense: true,
                  leading: const Icon(Icons.report_problem_outlined),
                  title: const Text('Hazard'),
                  subtitle: Text(item['hazard'] ?? ''),
                ),
                ListTile(
                  dense: true,
                  leading: const Icon(Icons.assessment_outlined),
                  title: const Text('Risk level'),
                  subtitle: Text(item['risk'] ?? ''),
                ),
                ListTile(
                  dense: true,
                  leading: const Icon(Icons.shield_outlined),
                  title: const Text('Primary control'),
                  subtitle: Text(item['control'] ?? ''),
                ),
                ListTile(
                  dense: true,
                  leading: const Icon(Icons.verified_outlined),
                  title: const Text('Verification'),
                  subtitle: Text(item['verification'] ?? ''),
                ),
                ListTile(
                  dense: true,
                  leading: const Icon(Icons.folder_copy_outlined),
                  title: const Text('Evidence'),
                  subtitle: Text(item['evidence'] ?? ''),
                ),
                ListTile(
                  dense: true,
                  leading: const Icon(Icons.hub_outlined),
                  title: const Text('Source module'),
                  subtitle: Text(item['source'] ?? ''),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Control note: residual risk must be reviewed by a '
                  'competent HSE person before acceptance or closure.',
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDashboard() {
    final int extreme = _countByRisk('Extreme');
    final int high = _countByRisk('High');
    final int verification = _countByStatus('Verification');
    final int escalated = _countByStatus('Escalated');
    final int critical = _countByPriority('Critical');

    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        const Text(
          'Step 105 — Unified Risk, Control & Evidence',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: darkGreen,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Integrated risk and control intelligence using traceable evidence.',
        ),
        const SizedBox(height: 16),
        _metricCard(
          'Total Risk Items',
          _riskItems.length,
          Icons.assessment_outlined,
        ),
        _metricCard(
          'Extreme Risk',
          extreme,
          Icons.warning_amber_outlined,
        ),
        _metricCard(
          'High Risk',
          high,
          Icons.priority_high,
        ),
        _metricCard(
          'Verification',
          verification,
          Icons.verified_outlined,
        ),
        _metricCard(
          'Escalated',
          escalated,
          Icons.arrow_upward_outlined,
        ),
        _metricCard(
          'Critical Priority',
          critical,
          Icons.error_outline,
        ),
        const SizedBox(height: 12),
        Card(
          elevation: 0,
          child: Column(
            children: <Widget>[
              const ListTile(
                title: Text(
                  'Risk lifecycle',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              _metricRow('Identified', _countByStatus('Identified')),
              _metricRow(
                'Controls Planned',
                _countByStatus('Controls Planned'),
              ),
              _metricRow('Verification', verification),
              _metricRow('Controlled', _countByStatus('Controlled')),
              _metricRow('Escalated', escalated),
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
                  'Control hierarchy snapshot',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              _metricRow(
                'Engineering',
                _countByControl('Engineering'),
              ),
              _metricRow(
                'Critical Barrier',
                _countByControl('Critical Barrier'),
              ),
              _metricRow(
                'Administrative',
                _countByControl('Administrative'),
              ),
              _metricRow(
                'PPE',
                _countByControl('PPE'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRiskList() {
    final List<Map<String, String>> items = _filteredRiskItems;

    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
          child: TextField(
            decoration: const InputDecoration(
              hintText: 'Search risk, hazard, control or evidence',
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
            initialValue: _riskFilter,
            decoration: const InputDecoration(
              labelText: 'Risk level',
            ),
            items: <String>['All', ..._riskLevels]
                .map(
                  (String item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(item),
                  ),
                )
                .toList(),
            onChanged: (String? value) {
              if (value != null) {
                setState(() => _riskFilter = value);
              }
            },
          ),
        ),
        Expanded(
          child: items.isEmpty
              ? const Center(
                  child: Text('No risk items match the current filters.'),
                )
              : ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 90),
                  itemCount: items.length,
                  itemBuilder: (BuildContext context, int visibleIndex) {
                    final Map<String, String> item = items[visibleIndex];
                    final int actualIndex = _riskItems.indexOf(item);

                    return Card(
                      elevation: 0,
                      margin: const EdgeInsets.only(bottom: 10),
                      child: ListTile(
                        onTap: () => _showRiskDetails(item),
                        leading: CircleAvatar(
                          backgroundColor:
                              primaryGreen.withValues(alpha: 0.10),
                          child: const Icon(
                            Icons.assessment_outlined,
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
                          '${item['hazard']} • Risk: ${item['risk']}\n'
                          'Control: ${item['control']} • '
                          'Evidence: ${item['evidence']}\n'
                          'Status: ${item['status']} • '
                          'Priority: ${item['priority']}',
                        ),
                        isThreeLine: true,
                        trailing: PopupMenuButton<String>(
                          onSelected: (String action) {
                            if (action == 'edit') {
                              _showRiskDialog(editIndex: actualIndex);
                            } else if (action == 'delete') {
                              _deleteRiskItem(actualIndex);
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
      {
        'from': 'Step 36',
        'to': 'Step 104',
        'label': 'Risk → Evidence',
      },
      {
        'from': 'Step 104',
        'to': 'Step 36',
        'label': 'Evidence → Risk Verification',
      },
      {
        'from': 'Step 36',
        'to': 'Step 37',
        'label': 'Risk → RAMS',
      },
      {
        'from': 'Step 37',
        'to': 'Step 38',
        'label': 'RAMS → PTW',
      },
      {
        'from': 'Step 39',
        'to': 'Step 38',
        'label': 'Competency → PTW',
      },
      {
        'from': 'Step 40',
        'to': 'Step 41',
        'label': 'Equipment → Inspection',
      },
      {
        'from': 'Step 44',
        'to': 'Step 35',
        'label': 'Incident → Corrective Action',
      },
      {
        'from': 'Step 45',
        'to': 'Step 46',
        'label': 'Audit → Compliance',
      },
      {
        'from': 'Step 103',
        'to': 'Step 105',
        'label': 'Workflow → Risk Intelligence',
      },
      {
        'from': 'Step 105',
        'to': 'Step 81–100',
        'label': 'Risk Signals → AI / Enterprise',
      },
    ];

    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        const Text(
          'Risk, Control & Evidence Integration',
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.bold,
            color: darkGreen,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Step 105 connects existing risk and evidence records without '
          'taking ownership away from the source modules.',
        ),
        const SizedBox(height: 14),
        ...links.map(
          (Map<String, String> link) => Card(
            elevation: 0,
            child: ListTile(
              leading: const Icon(
                Icons.compare_arrows,
                color: primaryGreen,
              ),
              title: Text(link['label']!),
              subtitle: Text('${link['from']}  →  ${link['to']}'),
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
          'Step 105 Architecture Guide',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: darkGreen,
          ),
        ),
        SizedBox(height: 14),
        _GuideCard(
          number: '105A',
          title: 'Unified Risk Master',
          text: 'Register risk intelligence references while the source '
              'risk module remains the system of record.',
        ),
        _GuideCard(
          number: '105B',
          title: 'Hazard & Risk Intelligence',
          text: 'Connect hazards with risk level, priority and operational '
              'context.',
        ),
        _GuideCard(
          number: '105C',
          title: 'Critical Controls / Barriers',
          text: 'Identify critical barriers and control hierarchy signals.',
        ),
        _GuideCard(
          number: '105D',
          title: 'Control Verification',
          text: 'Track whether controls are planned, being verified or '
              'verified.',
        ),
        _GuideCard(
          number: '105E',
          title: 'Evidence-to-Risk Linking',
          text: 'Connect risk decisions to evidence from Step 104 and other '
              'existing modules.',
        ),
        _GuideCard(
          number: '105F–105J',
          title: 'Residual Risk & Intelligence',
          text: 'Support escalation, cross-module links, audit trail and '
              'risk trend visibility.',
        ),
        _GuideCard(
          number: '105K',
          title: 'Predictive Decision Support',
          text: 'Prepare structured risk signals for future AI intelligence '
              'without autonomous safety decisions.',
        ),
        _GuideCard(
          number: '105L',
          title: 'Unified Risk Dashboard',
          text: 'Give HSE management one view of risk, controls, verification '
              'and evidence quality.',
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
          'AI and analytics support decisions only. Risk acceptance, critical '
          'control verification, permits and safety-critical actions require '
          'competent HSE review and authorization.',
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> sections = <Widget>[
      _buildDashboard(),
      _buildRiskList(),
      _buildIntegrationMap(),
      _buildGuide(),
    ];

    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        title: const Text('Step 105 • Risk Intelligence'),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
      ),
      body: sections[_selectedSection],
      floatingActionButton: _selectedSection == 1
          ? FloatingActionButton.extended(
              onPressed: _showRiskDialog,
              backgroundColor: primaryGreen,
              foregroundColor: Colors.white,
              icon: const Icon(Icons.add),
              label: const Text('Add Risk'),
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
            icon: Icon(Icons.assessment_outlined),
            selectedIcon: Icon(Icons.assessment),
            label: 'Risk',
          ),
          NavigationDestination(
            icon: Icon(Icons.hub_outlined),
            selectedIcon: Icon(Icons.hub),
            label: 'Integration',
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
