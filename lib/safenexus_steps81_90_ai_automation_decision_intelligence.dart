import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// SafeNexus HSE — Steps 81–90
/// Advanced HSE AI, Automation & Decision Intelligence
///
/// 81  HSE AI Intelligence Management
/// 82  AI Risk Prediction & Early Warning
/// 83  AI Incident & Near-Miss Intelligence
/// 84  AI Safety Observation & Hazard Intelligence
/// 85  AI Critical Control Monitoring
/// 86  HSE Predictive Analytics & Forecasting
/// 87  Intelligent HSE Workflow Automation
/// 88  AI-Assisted Compliance & Assurance
/// 89  HSE Decision Support & Recommendations
/// 90  AI-Powered HSE Command Center
///
/// Important:
/// This module provides a structured AI-readiness and decision-support
/// management layer. It does not claim autonomous safety decisions.
/// Recommendations remain subject to competent HSE review and approval.
///
/// Architecture:
/// Collect → Understand → Predict → Detect → Recommend
/// → Automate → Verify → Decide → Improve
///
/// English + Malayalam ready. UAE-wide by design.
/// No additional package is required beyond shared_preferences.

class SafeNexusSteps81To90AiIntelligencePage extends StatefulWidget {
  const SafeNexusSteps81To90AiIntelligencePage({
    super.key,
  });

  @override
  State<SafeNexusSteps81To90AiIntelligencePage> createState() =>
      _SafeNexusSteps81To90AiIntelligencePageState();
}

class _SafeNexusSteps81To90AiIntelligencePageState
    extends State<SafeNexusSteps81To90AiIntelligencePage> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);
  static const String storageKey =
      'safenexus_hse_steps81_90_ai_automation_decision_intelligence';

  final TextEditingController _searchController = TextEditingController();

  final List<String> _steps = <String>[
    '81 - HSE AI Intelligence Management',
    '82 - AI Risk Prediction & Early Warning',
    '83 - AI Incident & Near-Miss Intelligence',
    '84 - AI Safety Observation & Hazard Intelligence',
    '85 - AI Critical Control Monitoring',
    '86 - HSE Predictive Analytics & Forecasting',
    '87 - Intelligent HSE Workflow Automation',
    '88 - AI-Assisted Compliance & Assurance',
    '89 - HSE Decision Support & Recommendations',
    '90 - AI-Powered HSE Command Center',
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

  final List<String> _aiLevels = <String>[
    'Informational',
    'Advisory',
    'High Attention',
    'Critical Attention',
  ];

  final List<String> _domains = <String>[
    'AI Governance',
    'Risk Prediction',
    'Incident Intelligence',
    'Hazard Intelligence',
    'Critical Controls',
    'Predictive Analytics',
    'Workflow Automation',
    'Compliance Assurance',
    'Decision Support',
    'AI Command Center',
  ];

  final List<Map<String, dynamic>> _records = <Map<String, dynamic>>[];

  String _selectedStep = 'All';
  String _selectedStatus = 'All';
  String _selectedPriority = 'All';
  String _selectedAiLevel = 'All';
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
      final bool aiLevelMatch =
          _selectedAiLevel == 'All' || item['aiLevel'] == _selectedAiLevel;

      final String searchable = <String>[
        item['title']?.toString() ?? '',
        item['site']?.toString() ?? '',
        item['owner']?.toString() ?? '',
        item['step']?.toString() ?? '',
        item['domain']?.toString() ?? '',
        item['status']?.toString() ?? '',
        item['priority']?.toString() ?? '',
        item['aiLevel']?.toString() ?? '',
        item['signal']?.toString() ?? '',
        item['recommendation']?.toString() ?? '',
        item['notes']?.toString() ?? '',
      ].join(' ').toLowerCase();

      return stepMatch &&
          statusMatch &&
          priorityMatch &&
          aiLevelMatch &&
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
          title: const Text('Delete AI intelligence record?'),
          content: const Text(
            'This record will be removed from the local AI intelligence '
            'register.',
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
    final TextEditingController recommendationController =
        TextEditingController(
      text: existing?['recommendation']?.toString() ?? '',
    );
    final TextEditingController notesController =
        TextEditingController(text: existing?['notes']?.toString() ?? '');

    String step = existing?['step']?.toString() ?? _steps.first;
    String status = existing?['status']?.toString() ?? 'Open';
    String priority = existing?['priority']?.toString() ?? 'Medium';
    String aiLevel =
        existing?['aiLevel']?.toString() ?? 'Informational';
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
                    ? 'Add AI HSE Intelligence Record'
                    : 'Edit AI Intelligence Record',
              ),
              content: SizedBox(
                width: 600,
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
                            labelText: 'AI Module',
                            prefixIcon: Icon(Icons.psychology_outlined),
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
                            labelText: 'Intelligence Domain',
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
                            labelText: 'HSE Owner / Reviewer',
                            prefixIcon: Icon(Icons.person_outline),
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: signalController,
                          maxLines: 3,
                          decoration: const InputDecoration(
                            labelText: 'AI Signal / Trigger',
                            alignLabelWithHint: true,
                            prefixIcon: Icon(Icons.sensors_outlined),
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: recommendationController,
                          maxLines: 3,
                          decoration: const InputDecoration(
                            labelText: 'AI Recommendation / Suggested Action',
                            alignLabelWithHint: true,
                            prefixIcon: Icon(Icons.lightbulb_outline),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: DropdownButtonFormField<String>(
                                initialValue: aiLevel,
                                decoration: const InputDecoration(
                                  labelText: 'AI Attention',
                                ),
                                items: _aiLevels.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (String? value) {
                                  if (value != null) {
                                    dialogSetState(() {
                                      aiLevel = value;
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
                            labelText: 'Notes / Evidence / Reviewer Decision',
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
                        'recommendation':
                            recommendationController.text.trim(),
                        'aiLevel': aiLevel,
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
    recommendationController.dispose();
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

  int _countByAiLevel(String aiLevel) {
    return _records
        .where((Map<String, dynamic> item) => item['aiLevel'] == aiLevel)
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
                          '81–90 AI HSE Command Dashboard',
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
                    'Advanced HSE AI, Automation & Decision Intelligence',
                    style: TextStyle(color: Colors.black54),
                  ),
                  const SizedBox(height: 18),
                  _metricRow('Total records', total),
                  _metricRow('Open', open),
                  _metricRow('In Progress', inProgress),
                  _metricRow('Verified', verified),
                  _metricRow('Closed', closed),
                  _metricRow('Critical priority', critical),
                  const Divider(height: 28),
                  const Text(
                    'AI attention distribution',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ..._aiLevels.map(
                    (String level) =>
                        _metricRow(level, _countByAiLevel(level)),
                  ),
                  const Divider(height: 28),
                  const Text(
                    'Intelligence domain distribution',
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
          title: const Text('81–90 AI HSE Guide'),
          content: const SingleChildScrollView(
            child: Text(
              '81 — HSE AI Intelligence Management\n'
              'Establish a controlled structure for AI signals, recommendations, review and governance.\n\n'
              '82 — AI Risk Prediction & Early Warning\n'
              'Capture emerging risk indicators and route early warnings for competent HSE review.\n\n'
              '83 — AI Incident & Near-Miss Intelligence\n'
              'Structure incident and near-miss patterns to support trend recognition and learning.\n\n'
              '84 — AI Safety Observation & Hazard Intelligence\n'
              'Use observation and hazard data as structured inputs for prioritization and preventive action.\n\n'
              '85 — AI Critical Control Monitoring\n'
              'Prioritize critical-control signals and verification gaps for human review.\n\n'
              '86 — HSE Predictive Analytics & Forecasting\n'
              'Organize leading indicators, trends and forecasts for planning and proactive intervention.\n\n'
              '87 — Intelligent HSE Workflow Automation\n'
              'Route alerts, tasks, reviews and follow-ups while keeping human approval for safety-critical decisions.\n\n'
              '88 — AI-Assisted Compliance & Assurance\n'
              'Support compliance reviews, evidence organization and assurance prioritization.\n\n'
              '89 — HSE Decision Support & Recommendations\n'
              'Present structured recommendations with context, evidence and reviewer accountability.\n\n'
              '90 — AI-Powered HSE Command Center\n'
              'Combine approved intelligence into an executive view for priorities, decisions and improvement.\n\n'
              'AI workflow:\n'
              'Collect → Understand → Predict → Detect → Recommend → Automate → Verify → Decide → Improve\n\n'
              'Human oversight:\n'
              'AI output is decision support only. Safety-critical actions require competent HSE review, authorization and verification.\n\n'
              'UAE-wide architecture:\n'
              'The module is designed for multi-site UAE operations and can support emirate-specific requirements without changing the core AI intelligence model.\n\n'
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
      _selectedAiLevel = 'All';
    });
  }

  Widget _recordCard(Map<String, dynamic> item, int index) {
    final String priority = item['priority']?.toString() ?? 'Medium';
    final String status = item['status']?.toString() ?? 'Open';
    final String aiLevel =
        item['aiLevel']?.toString() ?? 'Informational';

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      child: ExpansionTile(
        leading: CircleAvatar(
          backgroundColor: primaryGreen.withValues(alpha: 0.10),
          foregroundColor: darkGreen,
          child: const Icon(Icons.psychology_outlined),
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
                Chip(label: Text(aiLevel)),
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
              child: Text('AI Signal: ${item['signal']}'),
            ),
          if ((item['recommendation']?.toString() ?? '').isNotEmpty) ...<Widget>[
            const SizedBox(height: 6),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Recommendation: ${item['recommendation']}',
              ),
            ),
          ],
          if ((item['owner']?.toString() ?? '').isNotEmpty)
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Reviewer: ${item['owner']}'),
            ),
          if ((item['notes']?.toString() ?? '').isNotEmpty) ...<Widget>[
            const SizedBox(height: 6),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Notes: ${item['notes']}'),
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
          'SafeNexus HSE — AI 81–90',
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
        label: const Text('Add AI Record'),
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
                            'Advanced HSE AI & Decision Intelligence',
                            style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                              color: darkGreen,
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            'Steps 81–90 • AI + Automation + Decision Support 🇦🇪',
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
                      hintText: 'Search title, site, signal, recommendation...',
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
                          initialValue: _selectedAiLevel,
                          decoration: const InputDecoration(
                            labelText: 'AI Attention',
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          items: <String>[
                            'All',
                            ..._aiLevels,
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
                              _selectedAiLevel = value;
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
                              Icons.psychology_outlined,
                              size: 54,
                              color: darkGreen.withValues(alpha: 0.55),
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              'No AI HSE intelligence records found.',
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
