import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// SafeNexus HSE — Steps 61–70
/// UAE-wide Advanced HSE Operations & Intelligence Center
///
/// 61  Advanced HSE Operations Management
/// 62  Safety Performance Intelligence
/// 63  Predictive HSE & Leading Indicators
/// 64  Digital Field Assurance
/// 65  Integrated Control Verification
/// 66  HSE Data & Evidence Intelligence
/// 67  Emergency & Critical Risk Intelligence
/// 68  Contractor & Workforce Performance Intelligence
/// 69  HSE Improvement & Change Intelligence
/// 70  Executive HSE Command & Decision Center
///
/// Architecture:
/// Leadership → Planning → Risk → Operations → Assurance → Intelligence
/// → Decision → Improvement
///
/// English + Malayalam ready. UAE-wide by design.
/// No additional package is required beyond shared_preferences.

class SafeNexusSteps61To70AdvancedOperationsIntelligencePage
    extends StatefulWidget {
  const SafeNexusSteps61To70AdvancedOperationsIntelligencePage({
    super.key,
  });

  @override
  State<SafeNexusSteps61To70AdvancedOperationsIntelligencePage> createState() =>
      _SafeNexusSteps61To70AdvancedOperationsIntelligencePageState();
}

class _SafeNexusSteps61To70AdvancedOperationsIntelligencePageState
    extends State<SafeNexusSteps61To70AdvancedOperationsIntelligencePage> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);
  static const String storageKey =
      'safenexus_hse_steps61_70_advanced_operations_intelligence';

  final TextEditingController _searchController = TextEditingController();

  final List<String> _steps = <String>[
    '61 - Advanced HSE Operations Management',
    '62 - Safety Performance Intelligence',
    '63 - Predictive HSE & Leading Indicators',
    '64 - Digital Field Assurance',
    '65 - Integrated Control Verification',
    '66 - HSE Data & Evidence Intelligence',
    '67 - Emergency & Critical Risk Intelligence',
    '68 - Contractor & Workforce Performance Intelligence',
    '69 - HSE Improvement & Change Intelligence',
    '70 - Executive HSE Command & Decision Center',
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

  final List<Map<String, dynamic>> _records = <Map<String, dynamic>>[];
  String _selectedStep = 'All';
  String _selectedStatus = 'All';
  bool _loading = true;

  List<Map<String, dynamic>> get _filteredRecords {
    final String query = _searchController.text.trim().toLowerCase();

    return _records.where((Map<String, dynamic> item) {
      final bool stepMatch =
          _selectedStep == 'All' || item['step'] == _selectedStep;
      final bool statusMatch =
          _selectedStatus == 'All' || item['status'] == _selectedStatus;

      final String searchable = <String>[
        item['title']?.toString() ?? '',
        item['site']?.toString() ?? '',
        item['owner']?.toString() ?? '',
        item['step']?.toString() ?? '',
        item['category']?.toString() ?? '',
        item['status']?.toString() ?? '',
        item['priority']?.toString() ?? '',
      ].join(' ').toLowerCase();

      return stepMatch && statusMatch && searchable.contains(query);
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
          title: const Text('Delete record?'),
          content: const Text(
            'This record will be removed from the local HSE register.',
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
    final TextEditingController notesController =
        TextEditingController(text: existing?['notes']?.toString() ?? '');

    String step = existing?['step']?.toString() ?? _steps.first;
    String status = existing?['status']?.toString() ?? 'Open';
    String priority = existing?['priority']?.toString() ?? 'Medium';
    String category =
        existing?['category']?.toString() ?? 'Operational Control';

    final List<String> categories = <String>[
      'Operational Control',
      'Field Assurance',
      'KPI / Performance',
      'Leading Indicator',
      'Critical Risk',
      'Evidence / Data',
      'Emergency Readiness',
      'Contractor / Workforce',
      'Improvement / Change',
      'Executive Decision',
    ];

    final Map<String, dynamic>? result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          builder: (
            BuildContext dialogContext,
            void Function(void Function()) dialogSetState,
          ) {
            return AlertDialog(
              title: Text(
                existing == null ? 'Add HSE Intelligence Record' : 'Edit Record',
              ),
              content: SizedBox(
                width: 560,
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
                            labelText: 'Module',
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
                          initialValue: category,
                          decoration: const InputDecoration(
                            labelText: 'Category',
                            prefixIcon: Icon(Icons.category_outlined),
                          ),
                          items: categories.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            if (value != null) {
                              dialogSetState(() {
                                category = value;
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
                            labelText: 'Responsible Person / Owner',
                            prefixIcon: Icon(Icons.person_outline),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: <Widget>[
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
                            const SizedBox(width: 12),
                            Expanded(
                              child: DropdownButtonFormField<String>(
                                initialValue: status,
                                decoration: const InputDecoration(
                                  labelText: 'Status',
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
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: notesController,
                          maxLines: 4,
                          decoration: const InputDecoration(
                            labelText: 'Notes / Evidence / Decision',
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
                        'category': category,
                        'site': siteController.text.trim(),
                        'owner': ownerController.text.trim(),
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

  int _countByStep(String step) {
    return _records
        .where((Map<String, dynamic> item) => item['step'] == step)
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
            heightFactor: 0.88,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: ListView(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      const Expanded(
                        child: Text(
                          '61–70 Command Dashboard',
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
                    'Advanced HSE Operations & Intelligence',
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
                    'Module distribution',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ..._steps.map(
                    (String step) => _metricRow(step, _countByStep(step)),
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
          title: const Text('61–70 Advanced HSE Guide'),
          content: const SingleChildScrollView(
            child: Text(
              '61 — Advanced HSE Operations Management\n'
              'Centralize operational HSE planning, controls, ownership and execution.\n\n'
              '62 — Safety Performance Intelligence\n'
              'Combine lagging and leading indicators into actionable performance views.\n\n'
              '63 — Predictive HSE & Leading Indicators\n'
              'Track warning signals such as overdue controls, repeated findings and weak assurance.\n\n'
              '64 — Digital Field Assurance\n'
              'Connect site observations, verification, evidence and field leadership.\n\n'
              '65 — Integrated Control Verification\n'
              'Verify whether critical controls are implemented and effective.\n\n'
              '66 — HSE Data & Evidence Intelligence\n'
              'Create a structured evidence trail for decisions, audits and assurance.\n\n'
              '67 — Emergency & Critical Risk Intelligence\n'
              'Bring emergency readiness and critical-risk status into management visibility.\n\n'
              '68 — Contractor & Workforce Performance Intelligence\n'
              'Combine competency, workforce and contractor performance signals.\n\n'
              '69 — HSE Improvement & Change Intelligence\n'
              'Track improvement initiatives, change impacts and effectiveness.\n\n'
              '70 — Executive HSE Command & Decision Center\n'
              'Convert HSE intelligence into management decisions, priorities and actions.\n\n'
              'Workflow:\n'
              'Operate → Measure → Predict → Verify → Assure → Decide → Improve → Learn\n\n'
              'UAE-wide architecture:\n'
              'The structure can support projects and requirements across Abu Dhabi, Dubai and other UAE emirates without changing the core data model.\n\n'
              'Malayalam support:\n'
              'English is the operational data language and Malayalam can be used for user-facing guidance and labels.',
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
    });
  }

  Widget _recordCard(Map<String, dynamic> item, int index) {
    final String priority = item['priority']?.toString() ?? 'Medium';
    final String status = item['status']?.toString() ?? 'Open';

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      child: ExpansionTile(
        leading: CircleAvatar(
          backgroundColor: primaryGreen.withValues(alpha: 0.10),
          foregroundColor: darkGreen,
          child: const Icon(Icons.shield_outlined),
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
                Chip(
                  avatar: const Icon(Icons.category_outlined, size: 16),
                  label: Text(item['category']?.toString() ?? ''),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          if ((item['owner']?.toString() ?? '').isNotEmpty)
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Owner: ${item['owner']}'),
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
          'SafeNexus HSE — Advanced 61–70',
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
        label: const Text('Add Record'),
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
                            'Advanced HSE Operations & Intelligence',
                            style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                              color: darkGreen,
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            'Steps 61–70 • UAE-wide management layer 🇦🇪',
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
                      hintText: 'Search title, site, owner, module...',
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
                              Icons.analytics_outlined,
                              size: 54,
                              color: darkGreen.withValues(alpha: 0.55),
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              'No HSE intelligence records found.',
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
