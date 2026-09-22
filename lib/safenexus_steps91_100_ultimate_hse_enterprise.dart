import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// SafeNexus HSE — Steps 91–100
/// Ultimate HSE Enterprise, AI & Resilience Layer
///
/// 91  Enterprise HSE Digital Twin & Site Intelligence
/// 92  Advanced Critical Risk & Barrier Management
/// 93  HSE Resilience & Business Continuity
/// 94  Integrated Emergency & Crisis Management
/// 95  Enterprise Sustainability & ESG-HSE Intelligence
/// 96  Advanced Workforce & Human Performance Intelligence
/// 97  Enterprise Contractor & Supply-Chain HSE Intelligence
/// 98  HSE Scenario Planning & Strategic Simulation
/// 99  AI-Ready HSE Governance & AI Assurance
/// 100 SafeNexus HSE Ultimate Enterprise Command Center
///
/// Final workflow:
/// Sense → Connect → Assess → Predict → Prevent → Respond
/// → Recover → Learn → Govern → Decide
///
/// This is a structured management and decision-support layer.
/// It does not make autonomous safety-critical decisions.
/// Competent HSE review, authorization and verification remain required.
///
/// English + Malayalam ready. UAE-wide by design.
/// No additional package is required beyond shared_preferences.

class SafeNexusSteps91To100UltimateHsePage extends StatefulWidget {
  const SafeNexusSteps91To100UltimateHsePage({
    super.key,
  });

  @override
  State<SafeNexusSteps91To100UltimateHsePage> createState() =>
      _SafeNexusSteps91To100UltimateHsePageState();
}

class _SafeNexusSteps91To100UltimateHsePageState
    extends State<SafeNexusSteps91To100UltimateHsePage> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);
  static const String storageKey =
      'safenexus_hse_steps91_100_ultimate_hse_enterprise';

  final TextEditingController _searchController = TextEditingController();

  final List<String> _steps = <String>[
    '91 - Enterprise HSE Digital Twin & Site Intelligence',
    '92 - Advanced Critical Risk & Barrier Management',
    '93 - HSE Resilience & Business Continuity',
    '94 - Integrated Emergency & Crisis Management',
    '95 - Enterprise Sustainability & ESG-HSE Intelligence',
    '96 - Advanced Workforce & Human Performance Intelligence',
    '97 - Enterprise Contractor & Supply-Chain HSE Intelligence',
    '98 - HSE Scenario Planning & Strategic Simulation',
    '99 - AI-Ready HSE Governance & AI Assurance',
    '100 - SafeNexus HSE Ultimate Enterprise Command Center',
  ];

  final List<String> _statuses = <String>[
    'Open',
    'In Progress',
    'Under Review',
    'Verified',
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
    'Critical',
  ];

  final List<String> _domains = <String>[
    'Digital Twin',
    'Critical Risk & Barriers',
    'Resilience & Continuity',
    'Emergency & Crisis',
    'Sustainability & ESG',
    'Human Performance',
    'Contractor & Supply Chain',
    'Scenario & Simulation',
    'AI Governance & Assurance',
    'Ultimate Command Center',
  ];

  final List<Map<String, dynamic>> _records = <Map<String, dynamic>>[];

  String _selectedStep = 'All';
  String _selectedStatus = 'All';
  String _selectedPriority = 'All';
  String _selectedRisk = 'All';
  bool _loading = true;

  List<Map<String, dynamic>> get _filteredRecords {
    final String query = _searchController.text.trim().toLowerCase();

    return _records.where((Map<String, dynamic> item) {
      final bool stepMatch =
          _selectedStep == 'All' || item['step'] == _selectedStep;
      final bool statusMatch =
          _selectedStatus == 'All' || item['status'] == _selectedStatus;
      final bool priorityMatch =
          _selectedPriority == 'All' || item['priority'] == _selectedPriority;
      final bool riskMatch =
          _selectedRisk == 'All' || item['risk'] == _selectedRisk;

      final String searchable = <String>[
        item['title']?.toString() ?? '',
        item['site']?.toString() ?? '',
        item['owner']?.toString() ?? '',
        item['step']?.toString() ?? '',
        item['domain']?.toString() ?? '',
        item['status']?.toString() ?? '',
        item['priority']?.toString() ?? '',
        item['risk']?.toString() ?? '',
        item['signal']?.toString() ?? '',
        item['decision']?.toString() ?? '',
        item['notes']?.toString() ?? '',
      ].join(' ').toLowerCase();

      return stepMatch &&
          statusMatch &&
          priorityMatch &&
          riskMatch &&
          searchable.contains(query);
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_refreshView);
    _loadRecords();
  }

  @override
  void dispose() {
    _searchController
      ..removeListener(_refreshView)
      ..dispose();
    super.dispose();
  }

  void _refreshView() {
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _loadRecords() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? raw = prefs.getString(storageKey);

    if (raw != null && raw.isNotEmpty) {
      try {
        final dynamic decoded = jsonDecode(raw);
        if (decoded is List) {
          _records
            ..clear()
            ..addAll(
              decoded
                  .whereType<Map>()
                  .map(
                    (Map item) => Map<String, dynamic>.from(item),
                  ),
            );
        }
      } catch (_) {
        _records.clear();
      }
    }

    if (mounted) {
      setState(() {
        _loading = false;
      });
    }
  }

  Future<void> _saveRecords() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(storageKey, jsonEncode(_records));
  }

  Future<void> _addRecord() async {
    final Map<String, dynamic>? result = await _showRecordDialog();

    if (result == null) {
      return;
    }

    setState(() {
      _records.insert(0, result);
    });
    await _saveRecords();
  }

  Future<void> _editRecord(int index) async {
    final Map<String, dynamic> existing = _records[index];
    final Map<String, dynamic>? result =
        await _showRecordDialog(existing: existing);

    if (result == null) {
      return;
    }

    setState(() {
      _records[index] = result;
    });
    await _saveRecords();
  }

  Future<void> _deleteRecord(int index) async {
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Delete enterprise record?'),
          content: const Text(
            'This record will be removed from the local Ultimate HSE register.',
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
        );
      },
    );

    if (confirmed != true) {
      return;
    }

    setState(() {
      _records.removeAt(index);
    });
    await _saveRecords();
  }

  Future<Map<String, dynamic>?> _showRecordDialog({
    Map<String, dynamic>? existing,
  }) async {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    final TextEditingController titleController =
        TextEditingController(text: existing?['title']?.toString() ?? '');
    final TextEditingController siteController =
        TextEditingController(text: existing?['site']?.toString() ?? '');
    final TextEditingController ownerController =
        TextEditingController(text: existing?['owner']?.toString() ?? '');
    final TextEditingController signalController =
        TextEditingController(text: existing?['signal']?.toString() ?? '');
    final TextEditingController decisionController =
        TextEditingController(text: existing?['decision']?.toString() ?? '');
    final TextEditingController notesController =
        TextEditingController(text: existing?['notes']?.toString() ?? '');

    String step = existing?['step']?.toString() ?? _steps.first;
    String status = existing?['status']?.toString() ?? 'Open';
    String priority = existing?['priority']?.toString() ?? 'Medium';
    String risk = existing?['risk']?.toString() ?? 'Medium';
    String domain = existing?['domain']?.toString() ?? _domains.first;

    final Map<String, dynamic>? result =
        await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          builder: (
            BuildContext dialogContext,
            void Function(void Function()) dialogSetState,
          ) {
            return AlertDialog(
              title: Text(
                existing == null
                    ? 'Add Ultimate HSE Record'
                    : 'Edit Ultimate HSE Record',
              ),
              content: SizedBox(
                width: 620,
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        TextFormField(
                          controller: titleController,
                          decoration: const InputDecoration(
                            labelText: 'Title',
                            prefixIcon: Icon(Icons.title),
                          ),
                          validator: (String? value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Enter a title';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 12),
                        DropdownButtonFormField<String>(
                          initialValue: step,
                          decoration: const InputDecoration(
                            labelText: 'Enterprise Module',
                            prefixIcon: Icon(Icons.account_tree_outlined),
                          ),
                          items: _steps.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            if (value != null) {
                              dialogSetState(() {
                                step = value;
                              });
                            }
                          },
                        ),
                        const SizedBox(height: 12),
                        DropdownButtonFormField<String>(
                          initialValue: domain,
                          decoration: const InputDecoration(
                            labelText: 'Enterprise Domain',
                            prefixIcon: Icon(Icons.hub_outlined),
                          ),
                          items: _domains.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            if (value != null) {
                              dialogSetState(() {
                                domain = value;
                              });
                            }
                          },
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: siteController,
                          decoration: const InputDecoration(
                            labelText: 'Site / Project / Location',
                            prefixIcon: Icon(Icons.location_on_outlined),
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: ownerController,
                          decoration: const InputDecoration(
                            labelText: 'Responsible HSE Owner',
                            prefixIcon: Icon(Icons.person_outline),
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: signalController,
                          maxLines: 3,
                          decoration: const InputDecoration(
                            labelText: 'Risk / Intelligence Signal',
                            alignLabelWithHint: true,
                            prefixIcon: Icon(Icons.sensors_outlined),
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: decisionController,
                          maxLines: 3,
                          decoration: const InputDecoration(
                            labelText: 'Management Decision / Required Action',
                            alignLabelWithHint: true,
                            prefixIcon: Icon(Icons.gavel_outlined),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: DropdownButtonFormField<String>(
                                initialValue: risk,
                                decoration: const InputDecoration(
                                  labelText: 'Risk',
                                ),
                                items: _riskLevels.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (String? value) {
                                  if (value != null) {
                                    dialogSetState(() {
                                      risk = value;
                                    });
                                  }
                                },
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: DropdownButtonFormField<String>(
                                initialValue: priority,
                                decoration: const InputDecoration(
                                  labelText: 'Priority',
                                ),
                                items: _priorities.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (String? value) {
                                  if (value != null) {
                                    dialogSetState(() {
                                      priority = value;
                                    });
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        DropdownButtonFormField<String>(
                          initialValue: status,
                          decoration: const InputDecoration(
                            labelText: 'Review Status',
                          ),
                          items: _statuses.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            if (value != null) {
                              dialogSetState(() {
                                status = value;
                              });
                            }
                          },
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: notesController,
                          maxLines: 4,
                          decoration: const InputDecoration(
                            labelText: 'Evidence / Notes / Reviewer Comment',
                            alignLabelWithHint: true,
                            prefixIcon: Icon(Icons.notes_outlined),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: const Text('Cancel'),
                ),
                FilledButton.icon(
                  onPressed: () {
                    if (!formKey.currentState!.validate()) {
                      return;
                    }

                    Navigator.pop(
                      dialogContext,
                      <String, dynamic>{
                        'id': existing?['id'] ??
                            DateTime.now().microsecondsSinceEpoch.toString(),
                        'title': titleController.text.trim(),
                        'step': step,
                        'domain': domain,
                        'site': siteController.text.trim(),
                        'owner': ownerController.text.trim(),
                        'signal': signalController.text.trim(),
                        'decision': decisionController.text.trim(),
                        'risk': risk,
                        'priority': priority,
                        'status': status,
                        'notes': notesController.text.trim(),
                        'updatedAt': DateTime.now().toIso8601String(),
                      },
                    );
                  },
                  icon: const Icon(Icons.save_outlined),
                  label: const Text('Save'),
                ),
              ],
            );
          },
        );
      },
    );

    titleController.dispose();
    siteController.dispose();
    ownerController.dispose();
    signalController.dispose();
    decisionController.dispose();
    notesController.dispose();

    return result;
  }

  int _countByStatus(String status) {
    return _records
        .where((Map<String, dynamic> item) => item['status'] == status)
        .length;
  }

  int _countByPriority(String priority) {
    return _records
        .where((Map<String, dynamic> item) => item['priority'] == priority)
        .length;
  }

  int _countByRisk(String risk) {
    return _records
        .where((Map<String, dynamic> item) => item['risk'] == risk)
        .length;
  }

  int _countByDomain(String domain) {
    return _records
        .where((Map<String, dynamic> item) => item['domain'] == domain)
        .length;
  }

  Widget _metricCard({
    required String label,
    required int value,
    required IconData icon,
  }) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: <Widget>[
            CircleAvatar(
              backgroundColor: primaryGreen.withValues(alpha: 0.10),
              foregroundColor: darkGreen,
              child: Icon(icon),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            Text(
              '$value',
              style: const TextStyle(
                fontSize: 24,
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

  Future<void> _showDashboard() async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext sheetContext) {
        final int total = _records.length;
        final int open = _countByStatus('Open');
        final int inProgress = _countByStatus('In Progress');
        final int verified = _countByStatus('Verified');
        final int closed = _countByStatus('Closed');
        final int critical = _countByPriority('Critical');
        final int criticalRisk = _countByRisk('Critical');

        return SafeArea(
          child: FractionallySizedBox(
            heightFactor: 0.92,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: ListView(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      const Expanded(
                        child: Text(
                          '91–100 Ultimate HSE Command Dashboard',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: darkGreen,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(sheetContext),
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),
                  const Text(
                    'Enterprise, AI, Resilience & Strategic Intelligence',
                    style: TextStyle(color: Colors.black54),
                  ),
                  const SizedBox(height: 18),
                  _metricRow('Total records', total),
                  _metricRow('Open', open),
                  _metricRow('In Progress', inProgress),
                  _metricRow('Verified', verified),
                  _metricRow('Closed', closed),
                  _metricRow('Critical priority', critical),
                  _metricRow('Critical risk', criticalRisk),
                  const Divider(height: 28),
                  const Text(
                    'Risk distribution',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ..._riskLevels.map(
                    (String risk) => _metricRow(risk, _countByRisk(risk)),
                  ),
                  const Divider(height: 28),
                  const Text(
                    'Enterprise domain distribution',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ..._domains.map(
                    (String domain) =>
                        _metricRow(domain, _countByDomain(domain)),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _showGuide() async {
    await showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('91–100 Ultimate HSE Guide'),
          content: const SingleChildScrollView(
            child: Text(
              '91 — Enterprise HSE Digital Twin & Site Intelligence\n'
              'Create a structured enterprise representation of sites, operational conditions, risks, controls and HSE performance.\n\n'
              '92 — Advanced Critical Risk & Barrier Management\n'
              'Focus on critical risks, barriers, control health and verification so high-consequence exposures receive management attention.\n\n'
              '93 — HSE Resilience & Business Continuity\n'
              'Connect HSE readiness with operational resilience, recovery planning and continuity priorities.\n\n'
              '94 — Integrated Emergency & Crisis Management\n'
              'Bring emergency preparedness, crisis escalation, response coordination and recovery visibility into one management layer.\n\n'
              '95 — Enterprise Sustainability & ESG-HSE Intelligence\n'
              'Structure environmental, social, safety and sustainability indicators for enterprise visibility and improvement.\n\n'
              '96 — Advanced Workforce & Human Performance Intelligence\n'
              'Use competency, engagement, fatigue-risk signals, learning and human-performance information to support prevention.\n\n'
              '97 — Enterprise Contractor & Supply-Chain HSE Intelligence\n'
              'Combine contractor, supplier, prequalification, performance and supply-chain HSE signals.\n\n'
              '98 — HSE Scenario Planning & Strategic Simulation\n'
              'Record scenarios, assumptions, potential impacts and response options to support preparedness and strategic planning.\n\n'
              '99 — AI-Ready HSE Governance & AI Assurance\n'
              'Control AI-assisted outputs through governance, evidence, human review, accountability and verification.\n\n'
              '100 — SafeNexus HSE Ultimate Enterprise Command Center\n'
              'Bring approved enterprise HSE intelligence into a strategic management view for priorities, decisions and improvement.\n\n'
              'Final workflow:\n'
              'Sense → Connect → Assess → Predict → Prevent → Respond → Recover → Learn → Govern → Decide\n\n'
              'Human oversight:\n'
              'AI and analytics are decision-support tools. Safety-critical decisions require competent HSE review, authorization and verification.\n\n'
              'UAE-wide architecture:\n'
              'The structure is intended for multi-site UAE operations and can retain emirate-specific requirements within the appropriate compliance and operational modules.\n\n'
              'Language architecture:\n'
              'English and Malayalam are supported for the user-facing layer.',
            ),
          ),
          actions: <Widget>[
            FilledButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _clearFilters() {
    _searchController.clear();
    setState(() {
      _selectedStep = 'All';
      _selectedStatus = 'All';
      _selectedPriority = 'All';
      _selectedRisk = 'All';
    });
  }

  Widget _recordCard(Map<String, dynamic> item, int index) {
    final String priority = item['priority']?.toString() ?? 'Medium';
    final String risk = item['risk']?.toString() ?? 'Medium';
    final String status = item['status']?.toString() ?? 'Open';

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      child: ExpansionTile(
        leading: CircleAvatar(
          backgroundColor: primaryGreen.withValues(alpha: 0.10),
          foregroundColor: darkGreen,
          child: const Icon(Icons.security_outlined),
        ),
        title: Text(
          item['title']?.toString() ?? 'Untitled',
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        subtitle: Text(
          '${item['step'] ?? ''}\n${item['site'] ?? 'Site not specified'}',
        ),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: <Widget>[
                Chip(label: Text(status)),
                Chip(label: Text(priority)),
                Chip(label: Text('Risk: $risk')),
                Chip(
                  avatar: const Icon(Icons.hub_outlined, size: 16),
                  label: Text(item['domain']?.toString() ?? ''),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          if ((item['signal']?.toString() ?? '').isNotEmpty)
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Intelligence Signal: ${item['signal']}'),
            ),
          if ((item['decision']?.toString() ?? '').isNotEmpty) ...<Widget>[
            const SizedBox(height: 6),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Decision / Action: ${item['decision']}'),
            ),
          ],
          if ((item['owner']?.toString() ?? '').isNotEmpty)
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Owner: ${item['owner']}'),
            ),
          if ((item['notes']?.toString() ?? '').isNotEmpty) ...<Widget>[
            const SizedBox(height: 6),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Evidence / Notes: ${item['notes']}'),
            ),
          ],
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              IconButton(
                tooltip: 'Edit',
                onPressed: () => _editRecord(index),
                icon: const Icon(Icons.edit_outlined),
              ),
              IconButton(
                tooltip: 'Delete',
                onPressed: () => _deleteRecord(index),
                icon: const Icon(Icons.delete_outline),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        title: const Text(
          'SafeNexus HSE — Ultimate 91–100',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            tooltip: 'Guide',
            onPressed: _showGuide,
            icon: const Icon(Icons.menu_book_outlined),
          ),
          IconButton(
            tooltip: 'Dashboard',
            onPressed: _showDashboard,
            icon: const Icon(Icons.dashboard_outlined),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addRecord,
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Add Enterprise Record'),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadRecords,
              child: ListView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
                children: <Widget>[
                  Card(
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            'Ultimate HSE Enterprise Intelligence',
                            style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                              color: darkGreen,
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            'Steps 91–100 • Enterprise + AI + Resilience 🇦🇪',
                          ),
                          const SizedBox(height: 14),
                          GridView.count(
                            crossAxisCount:
                                MediaQuery.sizeOf(context).width >= 700 ? 3 : 2,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 2.25,
                            children: <Widget>[
                              _metricCard(
                                label: 'Total',
                                value: _records.length,
                                icon: Icons.dataset_outlined,
                              ),
                              _metricCard(
                                label: 'Open',
                                value: _countByStatus('Open'),
                                icon: Icons.pending_actions_outlined,
                              ),
                              _metricCard(
                                label: 'Critical',
                                value: _countByPriority('Critical'),
                                icon: Icons.warning_amber_outlined,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search title, site, signal, decision...',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: _searchController.text.isEmpty
                          ? null
                          : IconButton(
                              onPressed: _searchController.clear,
                              icon: const Icon(Icons.clear),
                            ),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          initialValue: _selectedStep,
                          decoration: const InputDecoration(
                            labelText: 'Module',
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          items: <String>[
                            'All',
                            ..._steps,
                          ].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                overflow: TextOverflow.ellipsis,
                              ),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            if (value == null) {
                              return;
                            }
                            setState(() {
                              _selectedStep = value;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          initialValue: _selectedStatus,
                          decoration: const InputDecoration(
                            labelText: 'Status',
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          items: <String>[
                            'All',
                            ..._statuses,
                          ].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            if (value == null) {
                              return;
                            }
                            setState(() {
                              _selectedStatus = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          initialValue: _selectedPriority,
                          decoration: const InputDecoration(
                            labelText: 'Priority',
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          items: <String>[
                            'All',
                            ..._priorities,
                          ].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            if (value == null) {
                              return;
                            }
                            setState(() {
                              _selectedPriority = value;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          initialValue: _selectedRisk,
                          decoration: const InputDecoration(
                            labelText: 'Risk',
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          items: <String>[
                            'All',
                            ..._riskLevels,
                          ].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            if (value == null) {
                              return;
                            }
                            setState(() {
                              _selectedRisk = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton.icon(
                      onPressed: _clearFilters,
                      icon: const Icon(Icons.filter_alt_off_outlined),
                      label: const Text('Clear filters'),
                    ),
                  ),
                  if (_filteredRecords.isEmpty)
                    Card(
                      elevation: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(30),
                        child: Column(
                          children: <Widget>[
                            Icon(
                              Icons.verified_user_outlined,
                              size: 54,
                              color: darkGreen.withValues(alpha: 0.55),
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              'No Ultimate HSE records found.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 6),
                            const Text(
                              'Add a record or change the filters.',
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    )
                  else
                    ..._filteredRecords.asMap().entries.map(
                      (MapEntry<int, Map<String, dynamic>> entry) {
                        final int filteredIndex = entry.key;
                        final Map<String, dynamic> item = entry.value;
                        final int originalIndex = _records.indexOf(item);

                        return _recordCard(
                          item,
                          originalIndex >= 0 ? originalIndex : filteredIndex,
                        );
                      },
                    ),
                ],
              ),
            ),
    );
  }
}
