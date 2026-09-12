import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// SafeNexus HSE — Step 101
/// Master Integration & System Architecture Center
///
/// Purpose:
/// - Provide one controlled integration/audit layer for the 100-step roadmap.
/// - Track module readiness, navigation readiness, data/storage readiness,
///   workflow links, language readiness and performance-readiness.
/// - Keep the architecture UAE-wide and English + Malayalam ready.
///
/// Important:
/// This screen is an integration control center. It does not silently rewrite
/// existing modules. Existing feature files remain independently maintainable.
///
/// Recommended integration flow:
/// Discover → Map → Verify → Link → Test → Approve → Monitor
///
/// Safety principle:
/// AI and analytics remain decision-support only. Safety-critical decisions
/// require competent HSE review, authorization and verification.

class SafeNexusStep101MasterIntegrationPage extends StatefulWidget {
  const SafeNexusStep101MasterIntegrationPage({
    super.key,
  });

  @override
  State<SafeNexusStep101MasterIntegrationPage> createState() =>
      _SafeNexusStep101MasterIntegrationPageState();
}

class _SafeNexusStep101MasterIntegrationPageState
    extends State<SafeNexusStep101MasterIntegrationPage> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);
  static const String storageKey = 'safenexus_hse_step101_master_integration';

  final TextEditingController _searchController = TextEditingController();

  final List<String> _areas = <String>[
    'Architecture',
    'Navigation',
    'Data & Storage',
    'Workflow Integration',
    'Safety Controls',
    'AI & Decision Support',
    'UAE Compliance',
    'English & Malayalam',
    'Performance',
    'Release Readiness',
  ];

  final List<String> _statuses = <String>[
    'Planned',
    'In Progress',
    'Verified',
    'Blocked',
    'Approved',
  ];

  final List<String> _priorities = <String>[
    'Low',
    'Medium',
    'High',
    'Critical',
  ];

  final List<String> _checks = <Map<String, String>>[
    {
      'area': 'Architecture',
      'title': '100-step module architecture mapped',
      'description': 'Core modules are grouped without changing their ownership.',
      'priority': 'High',
    },
    {
      'area': 'Navigation',
      'title': 'Master navigation routes verified',
      'description': 'Every integrated feature should have one clear entry point.',
      'priority': 'High',
    },
    {
      'area': 'Data & Storage',
      'title': 'Local storage keys remain isolated',
      'description': 'Feature storage should not overwrite another module.',
      'priority': 'Critical',
    },
    {
      'area': 'Workflow Integration',
      'title': 'Risk to control workflow linked',
      'description': 'Risk, RAMS, PTW, field and action workflows must connect logically.',
      'priority': 'Critical',
    },
    {
      'area': 'Workflow Integration',
      'title': 'Incident to corrective action linked',
      'description': 'Incidents and findings should feed controlled actions and verification.',
      'priority': 'High',
    },
    {
      'area': 'Workflow Integration',
      'title': 'Workforce and equipment references linked',
      'description': 'Competency and asset information should support field controls.',
      'priority': 'High',
    },
    {
      'area': 'Safety Controls',
      'title': 'Critical-risk human verification retained',
      'description': 'Safety-critical recommendations require competent HSE review.',
      'priority': 'Critical',
    },
    {
      'area': 'AI & Decision Support',
      'title': 'AI outputs remain decision support',
      'description': 'No autonomous safety-critical authorization is assumed.',
      'priority': 'Critical',
    },
    {
      'area': 'UAE Compliance',
      'title': 'UAE-wide architecture preserved',
      'description': 'Emirate-specific requirements can remain within compliance layers.',
      'priority': 'High',
    },
    {
      'area': 'English & Malayalam',
      'title': 'User-facing language layer verified',
      'description': 'English and Malayalam remain the supported languages.',
      'priority': 'Medium',
    },
    {
      'area': 'Performance',
      'title': 'Startup work kept lightweight',
      'description': 'Avoid loading unnecessary heavy datasets during app startup.',
      'priority': 'High',
    },
    {
      'area': 'Release Readiness',
      'title': 'Analyze and release build gate',
      'description': 'Clean analyzer output and successful Android build are required.',
      'priority': 'Critical',
    },
  ];

  final List<Map<String, dynamic>> _records = <Map<String, dynamic>>[];

  String _selectedArea = 'All';
  String _selectedStatus = 'All';
  String _selectedPriority = 'All';
  bool _loading = true;

  List<Map<String, dynamic>> get _filteredRecords {
    final String query = _searchController.text.trim().toLowerCase();

    return _records.where((Map<String, dynamic> item) {
      final bool areaMatch =
          _selectedArea == 'All' || item['area'] == _selectedArea;
      final bool statusMatch =
          _selectedStatus == 'All' || item['status'] == _selectedStatus;
      final bool priorityMatch =
          _selectedPriority == 'All' || item['priority'] == _selectedPriority;

      final String searchable = <String>[
        item['title']?.toString() ?? '',
        item['area']?.toString() ?? '',
        item['status']?.toString() ?? '',
        item['priority']?.toString() ?? '',
        item['owner']?.toString() ?? '',
        item['notes']?.toString() ?? '',
      ].join(' ').toLowerCase();

      return areaMatch &&
          statusMatch &&
          priorityMatch &&
          searchable.contains(query);
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_refresh);
    _loadRecords();
  }

  @override
  void dispose() {
    _searchController
      ..removeListener(_refresh)
      ..dispose();
    super.dispose();
  }

  void _refresh() {
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
                  .map((Map item) => Map<String, dynamic>.from(item)),
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

  Future<void> _seedRecommendedChecks() async {
    final Set<String> existingTitles = _records
        .map((Map<String, dynamic> item) => item['title']?.toString() ?? '')
        .toSet();

    final List<Map<String, dynamic>> additions = <Map<String, dynamic>>[];

    for (final Map<String, String> item in _checks) {
      final String title = item['title'] ?? '';
      if (existingTitles.contains(title)) {
        continue;
      }

      additions.add(
        <String, dynamic>{
          'id': DateTime.now().microsecondsSinceEpoch.toString() +
              additions.length.toString(),
          'area': item['area'] ?? 'Architecture',
          'title': title,
          'status': 'Planned',
          'priority': item['priority'] ?? 'Medium',
          'owner': 'HSE / Project Team',
          'notes': item['description'] ?? '',
          'updatedAt': DateTime.now().toIso8601String(),
        },
      );
    }

    if (additions.isEmpty) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Recommended checks already added.')),
      );
      return;
    }

    setState(() {
      _records.insertAll(0, additions);
    });
    await _saveRecords();

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${additions.length} integration checks added.')),
    );
  }

  Future<void> _addRecord() async {
    final Map<String, dynamic>? result = await _showRecordDialog();
    if (result == null) return;

    setState(() {
      _records.insert(0, result);
    });
    await _saveRecords();
  }

  Future<void> _editRecord(int index) async {
    final Map<String, dynamic>? result =
        await _showRecordDialog(existing: _records[index]);

    if (result == null) return;

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
          title: const Text('Delete integration record?'),
          content: const Text(
            'This removes only the Step 101 local integration record.',
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

    if (confirmed != true) return;

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
    final TextEditingController ownerController =
        TextEditingController(text: existing?['owner']?.toString() ?? '');
    final TextEditingController notesController =
        TextEditingController(text: existing?['notes']?.toString() ?? '');

    String area = existing?['area']?.toString() ?? _areas.first;
    String status = existing?['status']?.toString() ?? 'Planned';
    String priority = existing?['priority']?.toString() ?? 'Medium';

    final Map<String, dynamic>? result =
        await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          builder: (
            BuildContext context,
            void Function(void Function()) dialogSetState,
          ) {
            return AlertDialog(
              title: Text(
                existing == null
                    ? 'Add Integration Check'
                    : 'Edit Integration Check',
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
                            labelText: 'Integration Check / Task',
                            prefixIcon: Icon(Icons.task_alt_outlined),
                          ),
                          validator: (String? value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Enter a task';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 12),
                        DropdownButtonFormField<String>(
                          initialValue: area,
                          decoration: const InputDecoration(
                            labelText: 'Area',
                            prefixIcon: Icon(Icons.category_outlined),
                          ),
                          items: _areas.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            if (value != null) {
                              dialogSetState(() {
                                area = value;
                              });
                            }
                          },
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: <Widget>[
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
                            const SizedBox(width: 10),
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
                        TextFormField(
                          controller: ownerController,
                          decoration: const InputDecoration(
                            labelText: 'Owner / Responsible Team',
                            prefixIcon: Icon(Icons.person_outline),
                          ),
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
                    if (!formKey.currentState!.validate()) return;

                    Navigator.pop(
                      dialogContext,
                      <String, dynamic>{
                        'id': existing?['id'] ??
                            DateTime.now().microsecondsSinceEpoch.toString(),
                        'area': area,
                        'title': titleController.text.trim(),
                        'status': status,
                        'priority': priority,
                        'owner': ownerController.text.trim(),
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

  int _countByArea(String area) {
    return _records
        .where((Map<String, dynamic> item) => item['area'] == area)
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
        padding: const EdgeInsets.all(14),
        child: Row(
          children: <Widget>[
            CircleAvatar(
              backgroundColor: primaryGreen.withValues(alpha: 0.10),
              foregroundColor: darkGreen,
              child: Icon(icon),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                label,
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

  Future<void> _showArchitectureMap() async {
    await showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('SafeNexus HSE Integration Map'),
          content: const SingleChildScrollView(
            child: Text(
              'CORE OPERATIONAL CHAIN\n'
              'Daily HSE → Field Operations → Observation → Risk → RAMS → PTW → Workforce → Equipment → Inspection\n\n'
              'EVENT & ASSURANCE CHAIN\n'
              'Incident → Investigation → Action Center → Verification → Audit → Compliance\n\n'
              'MANAGEMENT CHAIN\n'
              'Objectives → Training → Contractor/Supplier → Management Review → Strategy & Improvement\n\n'
              'INTELLIGENCE CHAIN\n'
              'Performance → Predictive Analytics → AI Decision Support → Enterprise Intelligence → Ultimate Command Center\n\n'
              'RESILIENCE CHAIN\n'
              'Emergency → Crisis → Resilience → Sustainability / ESG → Scenario Planning\n\n'
              'STEP 101 CONTROL LAYER\n'
              'Architecture → Navigation → Data → Workflow → Safety → AI Governance → UAE Compliance → Language → Performance → Release\n\n'
              'The integration layer should reference existing modules rather than duplicate their business logic.',
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

  Future<void> _showDashboard() async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext sheetContext) {
        return SafeArea(
          child: FractionallySizedBox(
            heightFactor: 0.9,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: ListView(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      const Expanded(
                        child: Text(
                          'Step 101 Integration Dashboard',
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
                  _metricRow('Total checks', _records.length),
                  _metricRow('Planned', _countByStatus('Planned')),
                  _metricRow('In Progress', _countByStatus('In Progress')),
                  _metricRow('Verified', _countByStatus('Verified')),
                  _metricRow('Approved', _countByStatus('Approved')),
                  _metricRow('Blocked', _countByStatus('Blocked')),
                  _metricRow('Critical priority', _countByPriority('Critical')),
                  const Divider(height: 28),
                  const Text(
                    'Area coverage',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ..._areas.map(
                    (String area) => _metricRow(area, _countByArea(area)),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _clearFilters() {
    _searchController.clear();
    setState(() {
      _selectedArea = 'All';
      _selectedStatus = 'All';
      _selectedPriority = 'All';
    });
  }

  Widget _recordCard(Map<String, dynamic> item, int index) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        isThreeLine: true,
        leading: CircleAvatar(
          backgroundColor: primaryGreen.withValues(alpha: 0.10),
          foregroundColor: darkGreen,
          child: const Icon(Icons.integration_instructions_outlined),
        ),
        title: Text(
          item['title']?.toString() ?? 'Untitled',
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        subtitle: Text(
          '${item['area'] ?? ''} • ${item['status'] ?? ''}\n'
          'Priority: ${item['priority'] ?? 'Medium'} • '
          'Owner: ${item['owner'] ?? 'Not assigned'}',
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (String value) {
            if (value == 'edit') {
              _editRecord(index);
            } else if (value == 'delete') {
              _deleteRecord(index);
            }
          },
          itemBuilder: (BuildContext context) => const <PopupMenuEntry<String>>[
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        title: const Text(
          'SafeNexus HSE — Step 101',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            tooltip: 'Architecture map',
            onPressed: _showArchitectureMap,
            icon: const Icon(Icons.account_tree_outlined),
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
        label: const Text('Add Integration Check'),
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
                            'Master Integration & System Architecture',
                            style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                              color: darkGreen,
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            '100-step roadmap integration control layer 🇦🇪',
                          ),
                          const SizedBox(height: 14),
                          GridView.count(
                            crossAxisCount:
                                MediaQuery.sizeOf(context).width >= 700 ? 3 : 2,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 2.2,
                            children: <Widget>[
                              _metricCard(
                                label: 'Checks',
                                value: _records.length,
                                icon: Icons.checklist_outlined,
                              ),
                              _metricCard(
                                label: 'Verified',
                                value: _countByStatus('Verified'),
                                icon: Icons.verified_outlined,
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
                  Card(
                    elevation: 0,
                    child: ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: Color(0x1A159447),
                        foregroundColor: darkGreen,
                        child: Icon(Icons.auto_fix_high_outlined),
                      ),
                      title: const Text(
                        'Recommended baseline',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: const Text(
                        'Load the Step 101 integration audit checklist.',
                      ),
                      trailing: FilledButton(
                        onPressed: _seedRecommendedChecks,
                        child: const Text('Load'),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search integration checks...',
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
                          initialValue: _selectedArea,
                          decoration: const InputDecoration(
                            labelText: 'Area',
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          items: <String>[
                            'All',
                            ..._areas,
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
                            if (value == null) return;
                            setState(() {
                              _selectedArea = value;
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
                            if (value == null) return;
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
                            if (value == null) return;
                            setState(() {
                              _selectedPriority = value;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: _clearFilters,
                          icon: const Icon(Icons.filter_alt_off_outlined),
                          label: const Text('Clear filters'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  if (_filteredRecords.isEmpty)
                    Card(
                      elevation: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(30),
                        child: Column(
                          children: <Widget>[
                            Icon(
                              Icons.integration_instructions_outlined,
                              size: 54,
                              color: darkGreen.withValues(alpha: 0.55),
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              'No integration checks found.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 6),
                            const Text(
                              'Use “Load” for the recommended Step 101 baseline.',
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    )
                  else
                    ..._filteredRecords.asMap().entries.map(
                      (MapEntry<int, Map<String, dynamic>> entry) {
                        final Map<String, dynamic> item = entry.value;
                        final int originalIndex = _records.indexOf(item);
                        return _recordCard(
                          item,
                          originalIndex >= 0 ? originalIndex : entry.key,
                        );
                      },
                    ),
                ],
              ),
            ),
    );
  }
}
