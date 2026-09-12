import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// SafeNexus HSE
/// Step 17 - Master Dashboard & 16-Phase Integration
///
/// This is a single-file integration dashboard. It does not replace the
/// individual phase modules. It provides one management view and navigation
/// map for all 16 phases, plus configurable project-level readiness records.
class SafeNexusMasterDashboardPage extends StatefulWidget {
  const SafeNexusMasterDashboardPage({super.key});

  @override
  State<SafeNexusMasterDashboardPage> createState() =>
      _SafeNexusMasterDashboardPageState();
}

class _SafeNexusMasterDashboardPageState
    extends State<SafeNexusMasterDashboardPage> {
  static const String storageKey = 'safenexus_hse_step17_master_dashboard';
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);

  List<Map<String, dynamic>> projects = [];
  String search = '';
  String projectFilter = 'All';
  String readinessFilter = 'All';

  final List<Map<String, String>> phases = const [
    {
      'no': '1',
      'title': 'Project Pre-Start',
      'subtitle': 'Project information & setup',
      'icon': '1',
    },
    {
      'no': '2',
      'title': 'HSE Management System',
      'subtitle': 'Policy, plan, KPI & procedures',
      'icon': '2',
    },
    {
      'no': '3',
      'title': 'Risk & Planning',
      'subtitle': 'HIRA, JSA, JHA, RAMS & risks',
      'icon': '3',
    },
    {
      'no': '4',
      'title': 'Permit to Work',
      'subtitle': 'PTW & work permits',
      'icon': '4',
    },
    {
      'no': '5',
      'title': 'Site Mobilization',
      'subtitle': 'Site setup, welfare & access',
      'icon': '5',
    },
    {
      'no': '6',
      'title': 'Workforce & Competency',
      'subtitle': 'Induction, training & competency',
      'icon': '6',
    },
    {
      'no': '7',
      'title': 'Equipment & Machinery',
      'subtitle': 'Equipment, certificates & inspections',
      'icon': '7',
    },
    {
      'no': '8',
      'title': 'High-Risk Activities',
      'subtitle': 'Critical work activity controls',
      'icon': '8',
    },
    {
      'no': '9',
      'title': 'Daily HSE Work',
      'subtitle': 'TBT, inspections & observations',
      'icon': '9',
    },
    {
      'no': '10',
      'title': 'Emergency',
      'subtitle': 'ERP, drills, rescue & evacuation',
      'icon': '10',
    },
    {
      'no': '11',
      'title': 'Occupational Health',
      'subtitle': 'Medical, heat stress & welfare',
      'icon': '11',
    },
    {
      'no': '12',
      'title': 'Chemical & Environment',
      'subtitle': 'Chemical, waste & environmental records',
      'icon': '12',
    },
    {
      'no': '13',
      'title': 'Inspection & Audit',
      'subtitle': 'Inspections, audits & actions',
      'icon': '13',
    },
    {
      'no': '14',
      'title': 'Incident Management',
      'subtitle': 'Incident, investigation & lessons learned',
      'icon': '14',
    },
    {
      'no': '15',
      'title': 'HSE Reporting',
      'subtitle': 'Daily, weekly, monthly & KPI',
      'icon': '15',
    },
    {
      'no': '16',
      'title': 'Legal / Authority',
      'subtitle': 'UAE & jurisdiction requirements',
      'icon': '16',
    },
  ];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(storageKey);
    if (raw == null || raw.isEmpty) return;
    try {
      final decoded = jsonDecode(raw);
      if (decoded is List) {
        setState(() {
          projects = decoded
              .whereType<Map>()
              .map((e) => Map<String, dynamic>.from(e))
              .toList();
        });
      }
    } catch (_) {}
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(storageKey, jsonEncode(projects));
  }

  List<Map<String, dynamic>> get filteredProjects {
    final q = search.trim().toLowerCase();
    return projects.where((p) {
      final text = p.values.join(' ').toLowerCase();
      final project = '${p['project'] ?? ''}';
      final readiness = '${p['readiness'] ?? ''}';
      return (q.isEmpty || text.contains(q)) &&
          (projectFilter == 'All' || project == projectFilter) &&
          (readinessFilter == 'All' || readiness == readinessFilter);
    }).toList();
  }

  List<String> get projectNames {
    final values = projects
        .map((e) => '${e['project'] ?? ''}'.trim())
        .where((e) => e.isNotEmpty)
        .toSet()
        .toList();
    values.sort();
    return values;
  }

  int _countReadiness(String value) =>
      projects.where((p) => p['readiness'] == value).length;

  int get openActions => projects.fold<int>(
        0,
        (sum, p) => sum + _toInt(p['openActions']),
      );

  int get overdueActions => projects.fold<int>(
        0,
        (sum, p) => sum + _toInt(p['overdueActions']),
      );

  int get criticalRisks => projects.fold<int>(
        0,
        (sum, p) => sum + _toInt(p['criticalRisks']),
      );

  int get activePermits => projects.fold<int>(
        0,
        (sum, p) => sum + _toInt(p['activePermits']),
      );

  int get incidents => projects.fold<int>(
        0,
        (sum, p) => sum + _toInt(p['incidents']),
      );

  static int _toInt(dynamic value) {
    return int.tryParse('$value') ?? 0;
  }

  Future<void> _openProjectForm({
    Map<String, dynamic>? existing,
    int? index,
  }) async {
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      builder: (_) => _ProjectReadinessForm(existing: existing),
    );
    if (result == null) return;

    final now = DateTime.now().toIso8601String();
    result['updatedAt'] = now;

    if (index == null) {
      result['id'] = now;
      result['createdAt'] = now;
      projects.insert(0, result);
    } else {
      result['id'] = projects[index]['id'] ?? now;
      result['createdAt'] = projects[index]['createdAt'] ?? now;
      projects[index] = result;
    }

    await _save();
    if (mounted) setState(() {});
  }

  Future<void> _deleteProject(int index) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete Project Snapshot?'),
        content: const Text(
          'This Step 17 project readiness snapshot will be deleted.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (ok != true) return;
    projects.removeAt(index);
    await _save();
    if (mounted) setState(() {});
  }

  void _showPhaseDetails(Map<String, String> phase) {
    final no = phase['no']!;
    final integration = _integrationForPhase(no);
    showModalBottomSheet<void>(
      context: context,
      builder: (_) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Wrap(
            runSpacing: 12,
            children: [
              Text(
                'Phase $no • ${phase['title']}',
                style: const TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                phase['subtitle']!,
                style: const TextStyle(fontSize: 15),
              ),
              const Divider(),
              const Text(
                'Integration role',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(integration),
              const SizedBox(height: 4),
              const Text(
                'WorkHub flow',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(_flowForPhase(no)),
            ],
          ),
        ),
      ),
    );
  }

  String _integrationForPhase(String no) {
    const map = {
      '1': 'Defines project, scope, parties, dates and HSE readiness baseline.',
      '2': 'Controls policy, HSE plan, objectives, procedures and records.',
      '3': 'Provides risk identification, assessment, RAMS and control planning.',
      '4': 'Connects planned work to permit approval, issue, monitoring and closure.',
      '5': 'Confirms site facilities, access, traffic, utilities and mobilization readiness.',
      '6': 'Confirms worker induction, training, competency, authorization and deployment.',
      '7': 'Confirms equipment, certificates, inspections, maintenance and readiness.',
      '8': 'Checks critical activity controls before and during high-risk work.',
      '9': 'Captures daily toolbox talks, inspections, observations and corrective actions.',
      '10': 'Tracks emergency organization, drills, rescue readiness and response actions.',
      '11': 'Tracks medical fitness, health surveillance, heat stress and welfare readiness.',
      '12': 'Controls chemicals, SDS, waste, spills, environmental monitoring and actions.',
      '13': 'Provides inspection, audit, CAPA, verification and closure status.',
      '14': 'Provides incident reporting, investigation, RCA, CAPA and lessons learned.',
      '15': 'Aggregates HSE performance, statistics, KPI and management reporting.',
      '16': 'Tracks UAE legal, authority, permit, client and compliance obligations.',
    };
    return map[no] ?? 'Integrated HSE management function.';
  }

  String _flowForPhase(String no) {
    const map = {
      '1': 'Project → Setup → Readiness → Approval',
      '2': 'Policy → Plan → KPI → Procedures → Records',
      '3': 'Hazard → Risk → RAMS/JSA → Controls → Review',
      '4': 'Work → Risk → Permit → Approval → Monitor → Close',
      '5': 'Site → Facilities → Access → Utilities → Readiness → Handover',
      '6': 'Worker → Induction → Training → Competency → Authorization → Deployment',
      '7': 'Equipment → Inspection → Certificate → Maintenance → Clearance',
      '8': 'Activity → Critical Controls → Permit → Competency → Inspection → Clearance',
      '9': 'Plan → TBT → Inspection → Observation → Action → Verification',
      '10': 'Plan → Drill → Response → Rescue → Corrective Action → Review',
      '11': 'Fitness → Surveillance → Heat/Welfare → Action → Review',
      '12': 'Chemical/Waste → Control → Monitoring → Spill Response → Closure',
      '13': 'Inspection/Audit → Finding → CAPA → Verification → Closure',
      '14': 'Report → Notify → Investigate → RCA → CAPA → Lessons → Close',
      '15': 'Collect → Validate → KPI → Report → Review → Improve',
      '16': 'Requirement → Applicability → Compliance → Gap → Action → Review',
    };
    return map[no] ?? '';
  }

  Color _readinessColor(String readiness) {
    switch (readiness) {
      case 'Ready':
        return primaryGreen;
      case 'Conditional':
        return Colors.orange;
      case 'Not Ready':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final visible = filteredProjects;
    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        title: const Text('SafeNexus HSE • Master Dashboard'),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openProjectForm(),
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Add Project Snapshot'),
      ),
      body: RefreshIndicator(
        onRefresh: _load,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 100),
          children: [
            _heroCard(),
            const SizedBox(height: 12),
            _summaryGrid(),
            const SizedBox(height: 14),
            _workflowCard(),
            const SizedBox(height: 14),
            _filters(),
            const SizedBox(height: 8),
            _projectSection(visible),
            const SizedBox(height: 14),
            _phaseSection(),
          ],
        ),
      ),
    );
  }

  Widget _heroCard() {
    return Card(
      color: darkGreen,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.shield, color: Colors.white, size: 34),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'SafeNexus HSE',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'UAE-wide HSE Management System',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            const SizedBox(height: 12),
            Text(
              '${phases.length} core phases integrated into one WorkHub view.',
              style: const TextStyle(color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }

  Widget _summaryGrid() {
    final items = [
      ('Projects', projects.length, Icons.business),
      ('Ready', _countReadiness('Ready'), Icons.check_circle),
      ('Conditional', _countReadiness('Conditional'), Icons.warning_amber),
      ('Not Ready', _countReadiness('Not Ready'), Icons.error),
      ('Open Actions', openActions, Icons.assignment_late),
      ('Overdue', overdueActions, Icons.warning),
      ('Critical Risks', criticalRisks, Icons.priority_high),
      ('Active PTW', activePermits, Icons.receipt_long),
      ('Incidents', incidents, Icons.report),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 1.12,
      ),
      itemBuilder: (_, i) {
        final item = items[i];
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(item.$3),
                const SizedBox(height: 5),
                Text(
                  '${item.$2}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  item.$1,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 10),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _workflowCard() {
    const steps = [
      'Project',
      'Risk',
      'RAMS / JSA',
      'PTW',
      'Competency',
      'Equipment',
      'High-Risk Work',
      'Daily HSE',
      'Emergency',
      'Health',
      'Environment',
      'Inspection / Audit',
      'Incident',
      'Reporting',
      'Legal',
      'Management Review',
    ];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Integrated HSE Lifecycle',
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                for (var i = 0; i < steps.length; i++)
                  Chip(
                    avatar: CircleAvatar(
                      child: Text('${i + 1}'),
                    ),
                    label: Text(steps[i]),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _filters() {
    return Column(
      children: [
        TextField(
          onChanged: (v) => setState(() => search = v),
          decoration: const InputDecoration(
            labelText: 'Search project / HSE snapshot',
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: DropdownButtonFormField<String>(
                initialValue: projectFilter,
                decoration: const InputDecoration(
                  labelText: 'Project',
                  border: OutlineInputBorder(),
                ),
                items: [
                  'All',
                  ...projectNames,
                ]
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        ))
                    .toList(),
                onChanged: (v) =>
                    setState(() => projectFilter = v ?? 'All'),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: DropdownButtonFormField<String>(
                initialValue: readinessFilter,
                decoration: const InputDecoration(
                  labelText: 'Readiness',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  'All',
                  'Ready',
                  'Conditional',
                  'Not Ready',
                ]
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        ))
                    .toList(),
                onChanged: (v) =>
                    setState(() => readinessFilter = v ?? 'All'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _projectSection(List<Map<String, dynamic>> visible) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Project HSE Readiness Snapshots',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            if (visible.isEmpty)
              const Padding(
                padding: EdgeInsets.all(16),
                child: Center(
                  child: Text(
                    'No project snapshot yet. Add one to start the Step 17 management view.',
                  ),
                ),
              )
            else
              ...visible.map((record) {
                final index = projects.indexOf(record);
                final readiness = '${record['readiness'] ?? 'Not Ready'}';
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: _readinessColor(readiness),
                      child: const Icon(
                        Icons.business,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      '${record['project'] ?? ''}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      '${record['site'] ?? ''} • ${record['location'] ?? ''}\n'
                      'Readiness: $readiness • '
                      'Actions: ${record['openActions'] ?? '0'} • '
                      'Overdue: ${record['overdueActions'] ?? '0'}',
                    ),
                    isThreeLine: true,
                    onTap: () => _showProjectDetails(record),
                    trailing: PopupMenuButton<String>(
                      onSelected: (value) {
                        if (value == 'edit') {
                          _openProjectForm(
                            existing: Map<String, dynamic>.from(record),
                            index: index,
                          );
                        } else if (value == 'delete') {
                          _deleteProject(index);
                        }
                      },
                      itemBuilder: (_) => const [
                        PopupMenuItem(
                          value: 'edit',
                          child: Text('Edit'),
                        ),
                        PopupMenuItem(
                          value: 'delete',
                          child: Text('Delete'),
                        ),
                      ],
                    ),
                  ),
                );
              }),
          ],
        ),
      ),
    );
  }

  void _showProjectDetails(Map<String, dynamic> record) {
    final entries = record.entries
        .where((e) => e.value != null && '${e.value}'.trim().isNotEmpty)
        .toList();

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.84,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${record['project'] ?? ''}',
                  style: const TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.separated(
                    itemCount: entries.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (_, i) {
                      final entry = entries[i];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 9),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 135,
                              child: Text(
                                _label(entry.key),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Expanded(child: Text('${entry.value}')),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _phaseSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '16-Phase WorkHub',
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text(
              'Tap any phase to view its integration role and lifecycle.',
            ),
            const SizedBox(height: 8),
            ...phases.map(
              (phase) => ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 4),
                leading: CircleAvatar(
                  backgroundColor: primaryGreen,
                  child: Text(
                    phase['no']!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                title: Text(phase['title']!),
                subtitle: Text(phase['subtitle']!),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => _showPhaseDetails(phase),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static String _label(String key) {
    return key
        .replaceAllMapped(
          RegExp(r'([a-z])([A-Z])'),
          (m) => '${m.group(1)} ${m.group(2)}',
        )
        .replaceAll('_', ' ')
        .split(' ')
        .map(
          (e) => e.isEmpty
              ? e
              : '${e[0].toUpperCase()}${e.substring(1)}',
        )
        .join(' ');
  }
}

class _ProjectReadinessForm extends StatefulWidget {
  final Map<String, dynamic>? existing;

  const _ProjectReadinessForm({this.existing});

  @override
  State<_ProjectReadinessForm> createState() => _ProjectReadinessFormState();
}

class _ProjectReadinessFormState extends State<_ProjectReadinessForm> {
  final formKey = GlobalKey<FormState>();
  late final Map<String, TextEditingController> c;
  late String readiness;

  static const readinessOptions = [
    'Ready',
    'Conditional',
    'Not Ready',
  ];

  @override
  void initState() {
    super.initState();
    final r = widget.existing ?? {};
    c = {
      'project': TextEditingController(text: '${r['project'] ?? ''}'),
      'site': TextEditingController(text: '${r['site'] ?? ''}'),
      'location': TextEditingController(text: '${r['location'] ?? ''}'),
      'projectManager':
          TextEditingController(text: '${r['projectManager'] ?? ''}'),
      'hseManager':
          TextEditingController(text: '${r['hseManager'] ?? ''}'),
      'openActions':
          TextEditingController(text: '${r['openActions'] ?? '0'}'),
      'overdueActions':
          TextEditingController(text: '${r['overdueActions'] ?? '0'}'),
      'criticalRisks':
          TextEditingController(text: '${r['criticalRisks'] ?? '0'}'),
      'activePermits':
          TextEditingController(text: '${r['activePermits'] ?? '0'}'),
      'incidents':
          TextEditingController(text: '${r['incidents'] ?? '0'}'),
      'workforce':
          TextEditingController(text: '${r['workforce'] ?? '0'}'),
      'equipment':
          TextEditingController(text: '${r['equipment'] ?? '0'}'),
      'trainingExpiring':
          TextEditingController(text: '${r['trainingExpiring'] ?? '0'}'),
      'medicalExpiring':
          TextEditingController(text: '${r['medicalExpiring'] ?? '0'}'),
      'auditFindings':
          TextEditingController(text: '${r['auditFindings'] ?? '0'}'),
      'legalGaps':
          TextEditingController(text: '${r['legalGaps'] ?? '0'}'),
      'emergencyReadiness':
          TextEditingController(text: '${r['emergencyReadiness'] ?? ''}'),
      'environmentStatus':
          TextEditingController(text: '${r['environmentStatus'] ?? ''}'),
      'topRisks':
          TextEditingController(text: '${r['topRisks'] ?? ''}'),
      'priorityActions':
          TextEditingController(text: '${r['priorityActions'] ?? ''}'),
      'managementComment':
          TextEditingController(text: '${r['managementComment'] ?? ''}'),
      'lastReview':
          TextEditingController(text: '${r['lastReview'] ?? ''}'),
      'nextReview':
          TextEditingController(text: '${r['nextReview'] ?? ''}'),
      'remarks':
          TextEditingController(text: '${r['remarks'] ?? ''}'),
    };

    readiness = readinessOptions.contains(r['readiness'])
        ? r['readiness'] as String
        : readinessOptions.first;
  }

  @override
  void dispose() {
    for (final controller in c.values) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _pickDate(String key) async {
    final initial = DateTime.tryParse(c[key]!.text) ?? DateTime.now();
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      initialDate: initial,
    );
    if (picked != null) {
      c[key]!.text = picked.toIso8601String().split('T').first;
    }
  }

  Widget field(
    String key,
    String label, {
    int maxLines = 1,
    bool required = false,
    TextInputType? keyboardType,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: c[key],
        maxLines: maxLines,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: required ? '$label *' : label,
          border: const OutlineInputBorder(),
        ),
        validator: required
            ? (v) => v == null || v.trim().isEmpty ? 'Required' : null
            : null,
      ),
    );
  }

  Widget dateField(String key, String label) {
    return Row(
      children: [
        Expanded(child: field(key, label)),
        IconButton(
          onPressed: () => _pickDate(key),
          icon: const Icon(Icons.calendar_month),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        ),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.94,
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const Text(
                  'Project HSE Readiness Snapshot',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: ListView(
                    children: [
                      field('project', 'Project Name', required: true),
                      field('site', 'Site'),
                      field('location', 'Location'),
                      field('projectManager', 'Project Manager'),
                      field('hseManager', 'HSE Manager / Lead'),
                      DropdownButtonFormField<String>(
                        initialValue: readiness,
                        decoration: const InputDecoration(
                          labelText: 'Overall HSE Readiness',
                          border: OutlineInputBorder(),
                        ),
                        items: readinessOptions
                            .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(e),
                                ))
                            .toList(),
                        onChanged: (v) =>
                            setState(() => readiness = v ?? readiness),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Management Metrics',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      field(
                        'openActions',
                        'Open Actions',
                        keyboardType: TextInputType.number,
                      ),
                      field(
                        'overdueActions',
                        'Overdue Actions',
                        keyboardType: TextInputType.number,
                      ),
                      field(
                        'criticalRisks',
                        'Critical Risks',
                        keyboardType: TextInputType.number,
                      ),
                      field(
                        'activePermits',
                        'Active Permits',
                        keyboardType: TextInputType.number,
                      ),
                      field(
                        'incidents',
                        'Incidents',
                        keyboardType: TextInputType.number,
                      ),
                      field(
                        'workforce',
                        'Workforce',
                        keyboardType: TextInputType.number,
                      ),
                      field(
                        'equipment',
                        'Equipment / Machinery',
                        keyboardType: TextInputType.number,
                      ),
                      field(
                        'trainingExpiring',
                        'Training Expiring ≤30 Days',
                        keyboardType: TextInputType.number,
                      ),
                      field(
                        'medicalExpiring',
                        'Medical Expiring ≤30 Days',
                        keyboardType: TextInputType.number,
                      ),
                      field(
                        'auditFindings',
                        'Open Audit Findings',
                        keyboardType: TextInputType.number,
                      ),
                      field(
                        'legalGaps',
                        'Legal Compliance Gaps',
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Readiness & Management Review',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      field(
                        'emergencyReadiness',
                        'Emergency Readiness',
                        maxLines: 2,
                      ),
                      field(
                        'environmentStatus',
                        'Environment / Chemical Status',
                        maxLines: 2,
                      ),
                      field(
                        'topRisks',
                        'Top HSE Risks / Trends',
                        maxLines: 4,
                      ),
                      field(
                        'priorityActions',
                        'Priority Actions',
                        maxLines: 4,
                      ),
                      field(
                        'managementComment',
                        'Management Review Comment',
                        maxLines: 4,
                      ),
                      dateField('lastReview', 'Last Management Review'),
                      dateField('nextReview', 'Next Review'),
                      field('remarks', 'Remarks', maxLines: 3),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: () {
                      if (!formKey.currentState!.validate()) return;
                      final result = <String, dynamic>{};
                      for (final entry in c.entries) {
                        result[entry.key] = entry.value.text.trim();
                      }
                      result['readiness'] = readiness;
                      Navigator.pop(context, result);
                    },
                    icon: const Icon(Icons.save),
                    label: const Text('Save Snapshot'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
