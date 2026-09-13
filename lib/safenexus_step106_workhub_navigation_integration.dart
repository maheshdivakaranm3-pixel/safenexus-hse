import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// SafeNexus HSE — Step 106
/// WorkHub ↔ Actual Module Navigation Integration
///
/// WorkHub → Integration Registry → Existing Feature Module
///
/// This layer owns navigation metadata only. Existing feature modules remain
/// responsible for records, validation, approvals and safety controls.

class SafeNexusStep106WorkHubIntegrationPage extends StatefulWidget {
  const SafeNexusStep106WorkHubIntegrationPage({super.key});

  @override
  State<SafeNexusStep106WorkHubIntegrationPage> createState() =>
      _SafeNexusStep106WorkHubIntegrationPageState();
}

class _SafeNexusStep106WorkHubIntegrationPageState
    extends State<SafeNexusStep106WorkHubIntegrationPage> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);
  static const String _storageKey =
      'safenexus_hse_step106_workhub_navigation_integration';

  final List<Map<String, String>> _modules = <Map<String, String>>[
    {'id': '1', 'title': 'Project / Site Setup', 'subtitle': 'Project, site and basic HSE setup', 'category': 'Foundation', 'target': 'Steps 1–2', 'state': 'Connected'},
    {'id': '3', 'title': 'Risk & Planning', 'subtitle': 'HIRA, JSA, JHA, RAMS and risk controls', 'category': 'Risk & Planning', 'target': 'Steps 36–37', 'state': 'Connected'},
    {'id': '4', 'title': 'Permit to Work', 'subtitle': 'PTW and work permits', 'category': 'High Risk Work', 'target': 'Step 38', 'state': 'Connected'},
    {'id': '5', 'title': 'Site Mobilization', 'subtitle': 'Site setup, welfare and access', 'category': 'Operations', 'target': 'Step 5', 'state': 'Connected'},
    {'id': '6', 'title': 'Workforce & Competency', 'subtitle': 'Induction, training and competency', 'category': 'Workforce', 'target': 'Step 39', 'state': 'Connected'},
    {'id': '7', 'title': 'Equipment & Machinery', 'subtitle': 'Equipment, certificates and inspections', 'category': 'Assets', 'target': 'Steps 40–41', 'state': 'Connected'},
    {'id': '8', 'title': 'High-Risk Activities', 'subtitle': 'Critical work activity controls', 'category': 'High Risk Work', 'target': 'Steps 36–38', 'state': 'Connected'},
    {'id': '9', 'title': 'Daily HSE Work', 'subtitle': 'TBT, inspections and observations', 'category': 'Daily HSE', 'target': 'Step 9', 'state': 'Connected'},
    {'id': '10', 'title': 'Emergency', 'subtitle': 'ERP, drills, rescue and evacuation', 'category': 'Emergency', 'target': 'Step 42', 'state': 'Connected'},
    {'id': '11', 'title': 'Occupational Health', 'subtitle': 'Medical, heat stress and welfare', 'category': 'Health', 'target': 'Step 11', 'state': 'Connected'},
    {'id': '12', 'title': 'Chemical & Environment', 'subtitle': 'Chemical, waste and environmental records', 'category': 'Environment', 'target': 'Step 43', 'state': 'Connected'},
    {'id': '13', 'title': 'Inspection & Audit', 'subtitle': 'Inspections, audits and actions', 'category': 'Assurance', 'target': 'Steps 41 & 45', 'state': 'Connected'},
    {'id': '14', 'title': 'Incident Management', 'subtitle': 'Incident, investigation and lessons learned', 'category': 'Incident', 'target': 'Step 44', 'state': 'Connected'},
    {'id': '15', 'title': 'HSE Reporting', 'subtitle': 'Daily, weekly, monthly and KPI', 'category': 'Performance', 'target': 'Steps 54 & 109', 'state': 'Connected'},
    {'id': '16', 'title': 'Legal / Authority', 'subtitle': 'Legal and regulatory compliance', 'category': 'Compliance', 'target': 'Step 46', 'state': 'Connected'},
    {'id': '17', 'title': 'Actions & Improvements', 'subtitle': 'Corrective actions and continual improvement', 'category': 'Improvement', 'target': 'Steps 35 & 48', 'state': 'Connected'},
    {'id': '18', 'title': 'Communication & Engagement', 'subtitle': 'Worker, contractor and safety communication', 'category': 'Engagement', 'target': 'Step 33', 'state': 'Connected'},
    {'id': '19', 'title': 'Documents & Records', 'subtitle': 'Controlled documents and HSE records', 'category': 'Records', 'target': 'Step 34', 'state': 'Connected'},
    {'id': '20', 'title': 'Contractor & Supplier', 'subtitle': 'Contractor HSE management', 'category': 'Supply Chain', 'target': 'Step 50', 'state': 'Connected'},
    {'id': '21', 'title': 'Risk & Evidence Intelligence', 'subtitle': 'Unified risk, controls and evidence', 'category': 'Intelligence', 'target': 'Steps 104–105', 'state': 'Connected'},
  ];

  final List<String> _categories = <String>[
    'All', 'Foundation', 'Risk & Planning', 'High Risk Work', 'Operations',
    'Workforce', 'Assets', 'Daily HSE', 'Emergency', 'Health', 'Environment',
    'Assurance', 'Incident', 'Performance', 'Compliance', 'Improvement',
    'Engagement', 'Records', 'Supply Chain', 'Intelligence',
  ];

  String _search = '';
  String _categoryFilter = 'All';
  int _selectedSection = 0;
  bool _showIntegrationDetails = true;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? category = prefs.getString('${_storageKey}_category');
    final bool? details = prefs.getBool('${_storageKey}_details');
    if (!mounted) return;
    setState(() {
      if (category != null && _categories.contains(category)) {
        _categoryFilter = category;
      }
      if (details != null) {
        _showIntegrationDetails = details;
      }
    });
  }

  Future<void> _savePreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('${_storageKey}_category', _categoryFilter);
    await prefs.setBool('${_storageKey}_details', _showIntegrationDetails);
  }

  List<Map<String, String>> get _filteredModules {
    final String query = _search.trim().toLowerCase();
    return _modules.where((Map<String, String> module) {
      final String haystack = <String>[
        module['id'] ?? '',
        module['title'] ?? '',
        module['subtitle'] ?? '',
        module['category'] ?? '',
        module['target'] ?? '',
      ].join(' ').toLowerCase();
      return (query.isEmpty || haystack.contains(query)) &&
          (_categoryFilter == 'All' ||
              module['category'] == _categoryFilter);
    }).toList();
  }

  int _countByState(String state) {
    return _modules
        .where((Map<String, String> module) => module['state'] == state)
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
              child: Text(title,
                  style: const TextStyle(fontWeight: FontWeight.w600)),
            ),
            Text('$value',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: darkGreen,
                )),
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
        child: Text('$value',
            style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold)),
      ),
    );
  }

  void _showModuleDetails(Map<String, String> module) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('${module['id']} • ${module['title']}',
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: darkGreen)),
                const SizedBox(height: 8),
                Text(module['subtitle'] ?? ''),
                const SizedBox(height: 12),
                ListTile(
                  dense: true,
                  leading: const Icon(Icons.category_outlined),
                  title: const Text('Category'),
                  subtitle: Text(module['category'] ?? ''),
                ),
                ListTile(
                  dense: true,
                  leading: const Icon(Icons.link_outlined),
                  title: const Text('Source module'),
                  subtitle: Text(module['target'] ?? ''),
                ),
                ListTile(
                  dense: true,
                  leading: const Icon(Icons.check_circle_outline),
                  title: const Text('Integration state'),
                  subtitle: Text(module['state'] ?? ''),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Navigation identifies the destination. The existing '
                  'module remains responsible for records, validation, '
                  'approvals and safety controls.',
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDashboard() {
    final int connected = _countByState('Connected');
    final int total = _modules.length;
    final int categories = _categories.length - 1;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        const Text('Step 106 — WorkHub Navigation Integration',
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: darkGreen)),
        const SizedBox(height: 6),
        const Text(
            'A controlled bridge from WorkHub entries to existing SafeNexus feature modules.'),
        const SizedBox(height: 16),
        _metricCard('Registered Modules', total, Icons.apps_outlined),
        _metricCard('Connected', connected, Icons.link_outlined),
        _metricCard('Integration Coverage',
            total == 0 ? 0 : ((connected * 100) ~/ total),
            Icons.percent_outlined),
        _metricCard('Categories', categories, Icons.category_outlined),
        const SizedBox(height: 12),
        Card(
          elevation: 0,
          child: Column(
            children: <Widget>[
              const ListTile(
                title: Text('Integration status',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              _metricRow('Connected', connected),
              _metricRow('Pending', _countByState('Pending')),
              _metricRow('Review Required', _countByState('Review Required')),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Card(
          elevation: 0,
          child: SwitchListTile(
            title: const Text('Show integration details'),
            subtitle: const Text('Display source-module mapping on the list.'),
            value: _showIntegrationDetails,
            onChanged: (bool value) {
              setState(() => _showIntegrationDetails = value);
              _savePreferences();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildModuleList() {
    final List<Map<String, String>> modules = _filteredModules;
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
          child: TextField(
            decoration: const InputDecoration(
              hintText: 'Search WorkHub module',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
            onChanged: (String value) {
              setState(() => _search = value);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 10),
          child: DropdownButtonFormField<String>(
            initialValue: _categoryFilter,
            decoration: const InputDecoration(labelText: 'Category'),
            items: _categories
                .map((String category) => DropdownMenuItem<String>(
                      value: category,
                      child: Text(category),
                    ))
                .toList(),
            onChanged: (String? value) {
              if (value == null) return;
              setState(() => _categoryFilter = value);
              _savePreferences();
            },
          ),
        ),
        Expanded(
          child: modules.isEmpty
              ? const Center(child: Text('No WorkHub modules match the filter.'))
              : ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                  itemCount: modules.length,
                  itemBuilder: (BuildContext context, int index) {
                    final Map<String, String> module = modules[index];
                    return Card(
                      elevation: 0,
                      margin: const EdgeInsets.only(bottom: 10),
                      child: ListTile(
                        onTap: () => _showModuleDetails(module),
                        leading: CircleAvatar(
                          backgroundColor:
                              primaryGreen.withValues(alpha: 0.10),
                          child: Text(module['id'] ?? '',
                              style: const TextStyle(
                                  color: darkGreen,
                                  fontWeight: FontWeight.bold)),
                        ),
                        title: Text(module['title'] ?? '',
                            style:
                                const TextStyle(fontWeight: FontWeight.w700)),
                        subtitle: _showIntegrationDetails
                            ? Text('${module['subtitle']}\n'
                                '${module['target']} • ${module['state']}')
                            : Text(module['subtitle'] ?? ''),
                        isThreeLine: _showIntegrationDetails,
                        trailing:
                            const Icon(Icons.arrow_forward_ios, size: 17),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildWorkflow() {
    final List<Map<String, String>> workflow = <Map<String, String>>[
      {'step': '1', 'title': 'Select WorkHub module', 'detail': 'User selects a functional HSE area.'},
      {'step': '2', 'title': 'Resolve integration target', 'detail': 'Navigation metadata identifies the existing source module.'},
      {'step': '3', 'title': 'Open source feature', 'detail': 'The production app shell performs the actual route/navigation.'},
      {'step': '4', 'title': 'Use source records', 'detail': 'The destination module remains the system of record.'},
      {'step': '5', 'title': 'Return to WorkHub', 'detail': 'User returns without creating duplicate records.'},
      {'step': '6', 'title': 'Feed intelligence layers', 'detail': 'Steps 103–105 can consume approved references and evidence.'},
    ];
    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        const Text('WorkHub Integration Workflow',
            style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                color: darkGreen)),
        const SizedBox(height: 8),
        const Text(
            'Navigation metadata and source-module ownership stay separated.'),
        const SizedBox(height: 14),
        ...workflow.map(
          (Map<String, String> item) => Card(
            elevation: 0,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: primaryGreen,
                foregroundColor: Colors.white,
                child: Text(item['step']!),
              ),
              title: Text(item['title']!,
                  style: const TextStyle(fontWeight: FontWeight.w700)),
              subtitle: Text(item['detail']!),
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
        Text('Step 106 Architecture Guide',
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: darkGreen)),
        SizedBox(height: 14),
        _GuideCard(
            number: '106A',
            title: 'WorkHub Registry',
            text: 'Maintain one central registry of WorkHub functional entries.'),
        _GuideCard(
            number: '106B',
            title: 'Route Mapping',
            text: 'Map each WorkHub entry to its existing SafeNexus source area.'),
        _GuideCard(
            number: '106C',
            title: 'Source Ownership',
            text: 'Keep business records and validation inside the existing feature module.'),
        _GuideCard(
            number: '106D',
            title: 'Integration State',
            text: 'Show integration readiness without treating navigation as execution.'),
        _GuideCard(
            number: '106E–106J',
            title: 'Cross-Module Navigation',
            text: 'Support risk, PTW, workforce, equipment, emergency, incident, audit, compliance and improvement pathways.'),
        _GuideCard(
            number: '106K',
            title: 'Traceability',
            text: 'Keep clear WorkHub-to-source mapping for audit and maintenance.'),
        _GuideCard(
            number: '106L',
            title: 'Integration Readiness',
            text: 'Prepare WorkHub for unified data and dashboard layers without duplicating source records.'),
        SizedBox(height: 10),
        Text('Production integration note',
            style: TextStyle(fontWeight: FontWeight.bold, color: darkGreen)),
        SizedBox(height: 5),
        Text(
            'The final route to a concrete feature page should be wired by the production app shell using its existing navigation architecture. This registry intentionally does not fabricate route names or duplicate source screens.',
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> sections = <Widget>[
      _buildDashboard(),
      _buildModuleList(),
      _buildWorkflow(),
      _buildGuide(),
    ];

    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        title: const Text('Step 106 • WorkHub Integration'),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
      ),
      body: sections[_selectedSection],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedSection,
        onDestinationSelected: (int index) {
          setState(() => _selectedSection = index);
        },
        destinations: const <NavigationDestination>[
          NavigationDestination(
              icon: Icon(Icons.dashboard_outlined),
              selectedIcon: Icon(Icons.dashboard),
              label: 'Dashboard'),
          NavigationDestination(
              icon: Icon(Icons.apps_outlined),
              selectedIcon: Icon(Icons.apps),
              label: 'Modules'),
          NavigationDestination(
              icon: Icon(Icons.account_tree_outlined),
              selectedIcon: Icon(Icons.account_tree),
              label: 'Workflow'),
          NavigationDestination(
              icon: Icon(Icons.menu_book_outlined),
              selectedIcon: Icon(Icons.menu_book),
              label: 'Guide'),
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
          child: Icon(Icons.shield_outlined, color: Colors.white, size: 18),
        ),
        title: Text('$number — $title',
            style: const TextStyle(fontWeight: FontWeight.w700)),
        subtitle: Text(text),
      ),
    );
  }
}
