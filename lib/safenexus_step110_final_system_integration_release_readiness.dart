import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// SafeNexus HSE — Step 110
/// Final System Integration & Release Readiness
///
/// Purpose:
/// - Provide the final controlled integration and release-readiness layer.
/// - Track architecture, navigation, data, workflow, safety, AI governance,
///   UAE compliance, language, performance and release readiness.
/// - Bring together Steps 101–109 without duplicating source-module business
///   logic.
/// - Provide a final pre-release checklist for the SafeNexus HSE platform.
/// - UAE-wide scalable architecture.
/// - English + Malayalam ready.
///
/// Final architecture:
/// Navigation → Data → Workflow → Intelligence → Safety → Governance
/// → Compliance → Performance → Release
///
/// Important:
/// This page is a release-readiness control layer. It does not certify the
/// application, approve safety-critical work, or replace competent HSE,
/// technical, security, legal or management review.

class SafeNexusStep110FinalIntegrationPage extends StatefulWidget {
  const SafeNexusStep110FinalIntegrationPage({super.key});

  @override
  State<SafeNexusStep110FinalIntegrationPage> createState() =>
      _SafeNexusStep110FinalIntegrationPageState();
}

class _SafeNexusStep110FinalIntegrationPageState
    extends State<SafeNexusStep110FinalIntegrationPage> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);

  static const String _storageKey =
      'safenexus_hse_step110_final_system_integration_release_readiness';

  final List<String> _domains = <String>[
    'Architecture',
    'Navigation',
    'Data',
    'Workflow',
    'Safety',
    'AI Governance',
    'UAE Compliance',
    'Language',
    'Performance',
    'Security',
    'Testing',
    'Release',
  ];

  final List<String> _statuses = <String>[
    'Not Started',
    'In Progress',
    'Ready',
    'Needs Review',
    'Blocked',
  ];

  final List<String> _priorities = <String>[
    'Low',
    'Medium',
    'High',
    'Critical',
  ];

  final List<Map<String, String>> _checklistTemplates =
      <Map<String, String>>[
    {
      'title': 'Master architecture integration',
      'domain': 'Architecture',
      'status': 'Ready',
      'priority': 'Critical',
      'owner': 'System Architecture',
      'evidence': 'Steps 101–109 reviewed',
    },
    {
      'title': 'Master navigation integration',
      'domain': 'Navigation',
      'status': 'Ready',
      'priority': 'High',
      'owner': 'Application',
      'evidence': 'Step 102 / WorkHub routes',
    },
    {
      'title': 'Unified record and data links',
      'domain': 'Data',
      'status': 'Ready',
      'priority': 'Critical',
      'owner': 'Data Integration',
      'evidence': 'Step 107',
    },
    {
      'title': 'Cross-module workflow verification',
      'domain': 'Workflow',
      'status': 'Ready',
      'priority': 'Critical',
      'owner': 'HSE Operations',
      'evidence': 'Step 108',
    },
    {
      'title': 'Global HSE intelligence readiness',
      'domain': 'Safety',
      'status': 'Ready',
      'priority': 'Critical',
      'owner': 'HSE Management',
      'evidence': 'Step 109',
    },
    {
      'title': 'AI decision-support governance',
      'domain': 'AI Governance',
      'status': 'Needs Review',
      'priority': 'Critical',
      'owner': 'HSE + Technical',
      'evidence': 'Human review required',
    },
    {
      'title': 'UAE HSE compliance review',
      'domain': 'UAE Compliance',
      'status': 'In Progress',
      'priority': 'Critical',
      'owner': 'HSE / Legal',
      'evidence': 'Applicable requirements review',
    },
    {
      'title': 'English and Malayalam verification',
      'domain': 'Language',
      'status': 'Ready',
      'priority': 'Medium',
      'owner': 'Product',
      'evidence': 'UI language review',
    },
    {
      'title': 'Performance and startup review',
      'domain': 'Performance',
      'status': 'Needs Review',
      'priority': 'High',
      'owner': 'Technical',
      'evidence': 'Release build profiling',
    },
    {
      'title': 'Security and permissions review',
      'domain': 'Security',
      'status': 'Needs Review',
      'priority': 'Critical',
      'owner': 'Technical',
      'evidence': 'Permissions / storage review',
    },
    {
      'title': 'Flutter analyze clean',
      'domain': 'Testing',
      'status': 'In Progress',
      'priority': 'Critical',
      'owner': 'Development',
      'evidence': 'flutter analyze',
    },
    {
      'title': 'Android release build',
      'domain': 'Release',
      'status': 'In Progress',
      'priority': 'Critical',
      'owner': 'Development',
      'evidence': 'assembleRelease / APK',
    },
  ];

  List<Map<String, String>> _checks =
      <Map<String, String>>[];

  String _search = '';
  String _domainFilter = 'All';
  String _statusFilter = 'All';
  String _priorityFilter = 'All';
  int _selectedSection = 0;

  @override
  void initState() {
    super.initState();
    _loadChecks();
  }

  Future<void> _loadChecks() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> saved =
        prefs.getStringList(_storageKey) ?? <String>[];

    if (saved.isEmpty) {
      _checks = _checklistTemplates
          .map((Map<String, String> item) => Map<String, String>.from(item))
          .toList();
    } else {
      _checks = saved
          .map(_decodeCheck)
          .whereType<Map<String, String>>()
          .toList();
    }

    if (mounted) {
      setState(() {});
    }
  }

  Map<String, String>? _decodeCheck(String value) {
    final List<String> parts = value.split('¦');
    if (parts.length != 6) {
      return null;
    }

    return <String, String>{
      'title': parts[0],
      'domain': parts[1],
      'status': parts[2],
      'priority': parts[3],
      'owner': parts[4],
      'evidence': parts[5],
    };
  }

  String _encodeCheck(Map<String, String> item) {
    return <String>[
      item['title'] ?? '',
      item['domain'] ?? 'Architecture',
      item['status'] ?? 'Not Started',
      item['priority'] ?? 'Medium',
      item['owner'] ?? '',
      item['evidence'] ?? '',
    ].join('¦');
  }

  Future<void> _saveChecks() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      _storageKey,
      _checks.map(_encodeCheck).toList(),
    );
  }

  List<Map<String, String>> get _filteredChecks {
    final String query = _search.trim().toLowerCase();

    return _checks.where((Map<String, String> item) {
      final String haystack = <String>[
        item['title'] ?? '',
        item['domain'] ?? '',
        item['status'] ?? '',
        item['priority'] ?? '',
        item['owner'] ?? '',
        item['evidence'] ?? '',
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
    return _checks
        .where((Map<String, String> item) => item['status'] == status)
        .length;
  }

  int _countByDomain(String domain) {
    return _checks
        .where((Map<String, String> item) => item['domain'] == domain)
        .length;
  }

  int _countByPriority(String priority) {
    return _checks
        .where((Map<String, String> item) => item['priority'] == priority)
        .length;
  }

  int _readyCount() {
    return _countByStatus('Ready');
  }

  int _attentionCount() {
    return _countByStatus('Needs Review') +
        _countByStatus('Blocked');
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

  Future<void> _showCheckDialog({int? editIndex}) async {
    final Map<String, String>? existing =
        editIndex == null ? null : _checks[editIndex];

    final TextEditingController titleController =
        TextEditingController(text: existing?['title'] ?? '');
    final TextEditingController ownerController =
        TextEditingController(text: existing?['owner'] ?? '');
    final TextEditingController evidenceController =
        TextEditingController(text: existing?['evidence'] ?? '');

    String domain = existing?['domain'] ?? 'Architecture';
    String status = existing?['status'] ?? 'Not Started';
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
                    ? 'Add Release Check'
                    : 'Edit Release Check',
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        labelText: 'Check title',
                        prefixIcon: Icon(Icons.fact_check_outlined),
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
                      controller: ownerController,
                      decoration: const InputDecoration(
                        labelText: 'Owner / responsible team',
                        prefixIcon: Icon(Icons.person_outline),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: evidenceController,
                      decoration: const InputDecoration(
                        labelText: 'Evidence / verification note',
                        prefixIcon: Icon(Icons.description_outlined),
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
                    final String owner = ownerController.text.trim();
                    final String evidence =
                        evidenceController.text.trim();

                    if (title.isEmpty) {
                      return;
                    }

                    Navigator.pop(
                      context,
                      <String, String>{
                        'title': title,
                        'domain': domain,
                        'status': status,
                        'priority': priority,
                        'owner': owner,
                        'evidence': evidence,
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
    ownerController.dispose();
    evidenceController.dispose();

    if (result == null || !mounted) {
      return;
    }

    setState(() {
      if (editIndex == null) {
        _checks.add(result);
      } else {
        _checks[editIndex] = result;
      }
    });

    await _saveChecks();
  }

  Future<void> _deleteCheck(int index) async {
    setState(() {
      _checks.removeAt(index);
    });
    await _saveChecks();
  }

  void _showCheckDetails(Map<String, String> item) {
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
                  item['title'] ?? 'Release Check',
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
                  leading: const Icon(Icons.person_outline),
                  title: const Text('Owner'),
                  subtitle: Text(item['owner'] ?? ''),
                ),
                ListTile(
                  dense: true,
                  leading: const Icon(Icons.description_outlined),
                  title: const Text('Evidence'),
                  subtitle: Text(item['evidence'] ?? ''),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Release-control note: a Ready status is an internal '
                  'tracking state only. Final release decisions require '
                  'appropriate technical, HSE, security, compliance and '
                  'management review.',
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDashboard() {
    final int ready = _readyCount();
    final int attention = _attentionCount();
    final int critical = _countByPriority('Critical');
    final int inProgress = _countByStatus('In Progress');

    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        const Text(
          'Step 110 — Final System Integration & Release Readiness',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: darkGreen,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Final controlled readiness view for the SafeNexus HSE platform.',
        ),
        const SizedBox(height: 16),
        _metricCard(
          'Total Checks',
          _checks.length,
          Icons.fact_check_outlined,
        ),
        _metricCard(
          'Ready',
          ready,
          Icons.check_circle_outline,
        ),
        _metricCard(
          'In Progress',
          inProgress,
          Icons.timelapse,
        ),
        _metricCard(
          'Needs Attention',
          attention,
          Icons.warning_amber_outlined,
        ),
        _metricCard(
          'Critical',
          critical,
          Icons.priority_high,
        ),
        const SizedBox(height: 12),
        Card(
          elevation: 0,
          child: Column(
            children: <Widget>[
              const ListTile(
                title: Text(
                  'Final readiness lifecycle',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              _metricRow(
                'Not Started',
                _countByStatus('Not Started'),
              ),
              _metricRow(
                'In Progress',
                inProgress,
              ),
              _metricRow(
                'Ready',
                ready,
              ),
              _metricRow(
                'Needs Review',
                _countByStatus('Needs Review'),
              ),
              _metricRow(
                'Blocked',
                _countByStatus('Blocked'),
              ),
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
                  'Release gate',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const ListTile(
                leading: Icon(
                  Icons.rule_outlined,
                  color: primaryGreen,
                ),
                title: Text('Analyze'),
                subtitle: Text(
                  'flutter analyze must complete without analyzer errors/warnings treated as failure.',
                ),
              ),
              const ListTile(
                leading: Icon(
                  Icons.build_outlined,
                  color: primaryGreen,
                ),
                title: Text('Build'),
                subtitle: Text(
                  'Android release build must complete successfully.',
                ),
              ),
              const ListTile(
                leading: Icon(
                  Icons.security_outlined,
                  color: primaryGreen,
                ),
                title: Text('Review'),
                subtitle: Text(
                  'HSE, security, compliance, privacy and technical review remain required.',
                ),
              ),
              const ListTile(
                leading: Icon(
                  Icons.verified_outlined,
                  color: primaryGreen,
                ),
                title: Text('Release'),
                subtitle: Text(
                  'Release only after the responsible team confirms all applicable gates.',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCheckList() {
    final List<Map<String, String>> items = _filteredChecks;

    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
          child: TextField(
            decoration: const InputDecoration(
              hintText: 'Search release check',
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
                    'No release checks match the current filters.',
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
                    final int actualIndex = _checks.indexOf(item);

                    return Card(
                      elevation: 0,
                      margin: const EdgeInsets.only(bottom: 10),
                      child: ListTile(
                        onTap: () => _showCheckDetails(item),
                        leading: CircleAvatar(
                          backgroundColor:
                              primaryGreen.withValues(alpha: 0.10),
                          child: const Icon(
                            Icons.fact_check_outlined,
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
                          'Owner: ${item['owner']}',
                        ),
                        isThreeLine: true,
                        trailing: PopupMenuButton<String>(
                          onSelected: (String action) {
                            if (action == 'edit') {
                              _showCheckDialog(
                                editIndex: actualIndex,
                              );
                            } else if (action == 'delete') {
                              _deleteCheck(actualIndex);
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
          'Final Integration Domains',
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.bold,
            color: darkGreen,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Coverage of the final SafeNexus HSE release-control domains.',
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
                '${_countByDomain(domain)} release checks',
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

  Widget _buildRoadmap() {
    final List<Map<String, String>> roadmap =
        <Map<String, String>>[
      {
        'step': '101',
        'title': 'Master Integration & System Architecture',
      },
      {
        'step': '102',
        'title': 'Master Navigation & Integration Hub',
      },
      {
        'step': '103',
        'title': 'Unified Workflow & Cross-Module Orchestration',
      },
      {
        'step': '104',
        'title': 'Unified Data & Evidence Intelligence',
      },
      {
        'step': '105',
        'title': 'Unified Risk, Control & Evidence Intelligence',
      },
      {
        'step': '106',
        'title': 'WorkHub ↔ Actual Module Navigation Integration',
      },
      {
        'step': '107',
        'title': 'Unified Data & Record Linking',
      },
      {
        'step': '108',
        'title': 'Cross-Module Workflow Integration',
      },
      {
        'step': '109',
        'title': 'Global HSE Dashboard & Intelligence',
      },
      {
        'step': '110',
        'title': 'Final System Integration & Release Readiness',
      },
    ];

    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        const Text(
          'Final Integration Roadmap',
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.bold,
            color: darkGreen,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Steps 101–110 form the final platform integration layer.',
        ),
        const SizedBox(height: 14),
        ...roadmap.map(
          (Map<String, String> item) => Card(
            elevation: 0,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: primaryGreen,
                child: Text(
                  item['step']!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              title: Text(
                item['title']!,
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
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
          'Step 110 Final Release Guide',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: darkGreen,
          ),
        ),
        SizedBox(height: 14),
        _GuideCard(
          number: '110A',
          title: 'Architecture Freeze',
          text: 'Confirm the final module architecture and avoid unnecessary duplication before release.',
        ),
        _GuideCard(
          number: '110B',
          title: 'Navigation Verification',
          text: 'Verify WorkHub, master navigation and existing feature routes.',
        ),
        _GuideCard(
          number: '110C',
          title: 'Data & Record Integrity',
          text: 'Verify that unified links reference source records without creating conflicting duplicate authorities.',
        ),
        _GuideCard(
          number: '110D',
          title: 'Workflow Integration',
          text: 'Verify cross-module workflow routing, verification and escalation controls.',
        ),
        _GuideCard(
          number: '110E',
          title: 'Safety & HSE Review',
          text: 'Confirm that safety-critical decisions remain under competent HSE control.',
        ),
        _GuideCard(
          number: '110F',
          title: 'AI Governance',
          text: 'AI features remain decision support and require appropriate human review and authorization.',
        ),
        _GuideCard(
          number: '110G',
          title: 'UAE Compliance Review',
          text: 'Review applicable UAE and emirate-specific HSE, legal and regulatory requirements before release.',
        ),
        _GuideCard(
          number: '110H',
          title: 'Language & UX Review',
          text: 'Verify English and Malayalam content, labels, layouts and accessibility.',
        ),
        _GuideCard(
          number: '110I',
          title: 'Performance & Security',
          text: 'Review startup performance, storage, permissions, error handling and security controls.',
        ),
        _GuideCard(
          number: '110J',
          title: 'Testing & Build',
          text: 'Run flutter analyze and the Android release build; resolve every analyzer failure before release.',
        ),
        _GuideCard(
          number: '110K',
          title: 'Release Evidence',
          text: 'Keep the final build evidence, version information and responsible approvals.',
        ),
        _GuideCard(
          number: '110L',
          title: 'Production Release Gate',
          text: 'Release only after all applicable technical, HSE, security, compliance and management gates are confirmed.',
        ),
        SizedBox(height: 10),
        Text(
          'Final SafeNexus HSE architecture',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: darkGreen,
          ),
        ),
        SizedBox(height: 5),
        Text(
          'WorkHub → Master Navigation → Existing Modules → Unified Records → Workflow → Global Intelligence → Final Integration → Release',
        ),
        SizedBox(height: 10),
        Text(
          'Release rule',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: darkGreen,
          ),
        ),
        SizedBox(height: 5),
        Text(
          'Step 110 provides readiness tracking. It is not a legal, regulatory, security or product certification. The responsible team must make the final release decision.',
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> sections = <Widget>[
      _buildDashboard(),
      _buildCheckList(),
      _buildDomainIntelligence(),
      _buildRoadmap(),
      _buildGuide(),
    ];

    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        title: const Text('Step 110 • Final Integration'),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
      ),
      body: sections[_selectedSection],
      floatingActionButton: _selectedSection == 1
          ? FloatingActionButton.extended(
              onPressed: _showCheckDialog,
              backgroundColor: primaryGreen,
              foregroundColor: Colors.white,
              icon: const Icon(Icons.add_task),
              label: const Text('Add Check'),
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
            icon: Icon(Icons.fact_check_outlined),
            selectedIcon: Icon(Icons.fact_check),
            label: 'Checks',
          ),
          NavigationDestination(
            icon: Icon(Icons.hub_outlined),
            selectedIcon: Icon(Icons.hub),
            label: 'Domains',
          ),
          NavigationDestination(
            icon: Icon(Icons.route_outlined),
            selectedIcon: Icon(Icons.route),
            label: 'Roadmap',
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
            Icons.verified_outlined,
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
