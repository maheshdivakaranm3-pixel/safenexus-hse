import 'package:flutter/material.dart';

/// SafeNexus HSE — Step 102
/// Master Navigation & Integration Hub
///
/// Purpose:
/// - Provide one scalable navigation layer for the 100-step SafeNexus roadmap.
/// - Group modules by functional domain without duplicating business logic.
/// - Keep navigation lightweight and ready for UAE-wide multi-site expansion.
/// - Provide search, category filtering and quick-access sections.
///
/// Integration principle:
/// This hub owns navigation metadata only. Existing feature pages remain
/// responsible for their own business logic and data.
///
/// English + Malayalam ready.
/// No additional package required.
///
/// Recommended architecture:
/// Home → Master Navigation Hub → Domain → Module → Existing Feature Page
///
/// Safety principle:
/// Navigation must not bypass HSE authorization, verification or approval
/// controls already defined inside safety-critical workflows.

class SafeNexusStep102MasterNavigationPage extends StatefulWidget {
  const SafeNexusStep102MasterNavigationPage({
    super.key,
  });

  @override
  State<SafeNexusStep102MasterNavigationPage> createState() =>
      _SafeNexusStep102MasterNavigationPageState();
}

class _SafeNexusStep102MasterNavigationPageState
    extends State<SafeNexusStep102MasterNavigationPage> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);

  final TextEditingController _searchController = TextEditingController();

  final List<String> _categories = <String>[
    'All',
    'Foundation',
    'Operations',
    'Risk & Control',
    'Workforce & Assets',
    'Incident & Assurance',
    'Management & Improvement',
    'Advanced Intelligence',
    'Enterprise & AI',
  ];

  final List<Map<String, String>> _modules = <Map<String, String>>[
    {
      'step': '1–10',
      'title': 'Foundation HSE',
      'category': 'Foundation',
      'description': 'Core HSE setup, daily management and foundational controls.',
    },
    {
      'step': '11–20',
      'title': 'Operational HSE',
      'category': 'Operations',
      'description': 'Operational safety planning, field activities and control execution.',
    },
    {
      'step': '21–30',
      'title': 'HSE Control Framework',
      'category': 'Risk & Control',
      'description': 'Structured control, planning and compliance workflows.',
    },
    {
      'step': '31',
      'title': 'Smart Checklists & Digital Forms',
      'category': 'Operations',
      'description': 'Digital checklists and controlled HSE forms.',
    },
    {
      'step': '32',
      'title': 'Field Operations',
      'category': 'Operations',
      'description': 'Mobile field work, observations, hazards and verification.',
    },
    {
      'step': '33',
      'title': 'Communication & Workforce Engagement',
      'category': 'Workforce & Assets',
      'description': 'Safety communication, consultation, feedback and engagement.',
    },
    {
      'step': '34',
      'title': 'Documents & Records',
      'category': 'Foundation',
      'description': 'Controlled HSE documents, records, reviews and expiry tracking.',
    },
    {
      'step': '35',
      'title': 'Action Center',
      'category': 'Incident & Assurance',
      'description': 'Corrective actions, verification, effectiveness and closure.',
    },
    {
      'step': '36',
      'title': 'Risk & Control Center',
      'category': 'Risk & Control',
      'description': 'Hazards, 5×5 assessment, controls and residual risk.',
    },
    {
      'step': '37',
      'title': 'RAMS Center',
      'category': 'Risk & Control',
      'description': 'Risk assessments, method statements, approval and field verification.',
    },
    {
      'step': '38',
      'title': 'Permit to Work Center',
      'category': 'Risk & Control',
      'description': 'Permit request, authorization, isolation and closure workflows.',
    },
    {
      'step': '39',
      'title': 'Workforce & Competency',
      'category': 'Workforce & Assets',
      'description': 'Worker profiles, competency, training, certification and authorization.',
    },
    {
      'step': '40',
      'title': 'Equipment & Asset',
      'category': 'Workforce & Assets',
      'description': 'Inspection, certification, maintenance, calibration and deployment.',
    },
    {
      'step': '41',
      'title': 'Inspection & Certification',
      'category': 'Incident & Assurance',
      'description': 'Inspection planning, certification and compliance verification.',
    },
    {
      'step': '42',
      'title': 'Emergency Response',
      'category': 'Incident & Assurance',
      'description': 'Emergency preparedness, drills, response, recovery and readiness.',
    },
    {
      'step': '43',
      'title': 'Environmental Management',
      'category': 'Management & Improvement',
      'description': 'Environmental aspects, waste, monitoring, spills and compliance.',
    },
    {
      'step': '44',
      'title': 'Incident & Investigation',
      'category': 'Incident & Assurance',
      'description': 'Incident reporting, investigation, root cause and lessons learned.',
    },
    {
      'step': '45',
      'title': 'Audit & Assurance',
      'category': 'Incident & Assurance',
      'description': 'Audit planning, findings, evidence, follow-up and assurance.',
    },
    {
      'step': '46',
      'title': 'Legal & Compliance',
      'category': 'Incident & Assurance',
      'description': 'Legal registers, regulatory requirements and compliance status.',
    },
    {
      'step': '47',
      'title': 'Management Review & Governance',
      'category': 'Management & Improvement',
      'description': 'Management review, governance, KPIs and strategic decisions.',
    },
    {
      'step': '48',
      'title': 'Objectives & Continual Improvement',
      'category': 'Management & Improvement',
      'description': 'Objectives, targets, improvement initiatives and performance gaps.',
    },
    {
      'step': '49',
      'title': 'Training & Safety Culture',
      'category': 'Workforce & Assets',
      'description': 'Learning, training effectiveness and safety culture development.',
    },
    {
      'step': '50',
      'title': 'Contractor & Supplier Safety',
      'category': 'Workforce & Assets',
      'description': 'Prequalification, contractor performance and supply controls.',
    },
    {
      'step': '51–60',
      'title': 'Advanced HSE Management',
      'category': 'Advanced Intelligence',
      'description': 'Advanced management systems, governance, performance and command intelligence.',
    },
    {
      'step': '61–70',
      'title': 'Advanced Operations & Intelligence',
      'category': 'Advanced Intelligence',
      'description': 'Operations intelligence, predictive indicators and executive decision support.',
    },
    {
      'step': '71–80',
      'title': 'Digital Ecosystem & Enterprise Intelligence',
      'category': 'Enterprise & AI',
      'description': 'Enterprise integration, orchestration, benchmarking and digital maturity.',
    },
    {
      'step': '81–90',
      'title': 'AI, Automation & Decision Intelligence',
      'category': 'Enterprise & AI',
      'description': 'AI-assisted prediction, automation, compliance and decision support.',
    },
    {
      'step': '91–100',
      'title': 'Ultimate Enterprise, AI & Resilience',
      'category': 'Enterprise & AI',
      'description': 'Digital twin, critical risk, resilience, ESG, simulation and command center.',
    },
    {
      'step': '101',
      'title': 'Master Integration & System Architecture',
      'category': 'Enterprise & AI',
      'description': 'Integration mapping, architecture audit and release-readiness control.',
    },
    {
      'step': '102',
      'title': 'Master Navigation & Integration Hub',
      'category': 'Enterprise & AI',
      'description': 'Central navigation metadata and scalable access to the SafeNexus roadmap.',
    },
  ];

  String _selectedCategory = 'All';

  List<Map<String, String>> get _filteredModules {
    final String query = _searchController.text.trim().toLowerCase();

    return _modules.where((Map<String, String> module) {
      final bool categoryMatch = _selectedCategory == 'All' ||
          module['category'] == _selectedCategory;

      final String searchable = <String>[
        module['step'] ?? '',
        module['title'] ?? '',
        module['category'] ?? '',
        module['description'] ?? '',
      ].join(' ').toLowerCase();

      return categoryMatch && searchable.contains(query);
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_refresh);
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

  int _countByCategory(String category) {
    return _modules
        .where((Map<String, String> module) => module['category'] == category)
        .length;
  }

  Widget _metricCard({
    required String label,
    required String value,
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
              value,
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

  void _clearSearch() {
    _searchController.clear();
  }

  void _clearFilters() {
    _searchController.clear();
    setState(() {
      _selectedCategory = 'All';
    });
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
                          'Master Navigation Dashboard',
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
                  _metricRow('Navigation groups', _categories.length - 1),
                  _metricRow('Roadmap entries', _modules.length),
                  _metricRow('Core steps 1–50', 50),
                  _metricRow('Advanced steps 51–80', 30),
                  _metricRow('AI / Enterprise steps 81–100', 20),
                  _metricRow('Integration layer 101–102', 2),
                  const Divider(height: 28),
                  const Text(
                    'Category coverage',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ..._categories.skip(1).map(
                        (String category) =>
                            _metricRow(category, _countByCategory(category)),
                      ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _showArchitectureGuide() async {
    await showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Step 102 Architecture Guide'),
          content: const SingleChildScrollView(
            child: Text(
              'MASTER NAVIGATION PRINCIPLE\n\n'
              'Home → Master Navigation Hub → Category → Module → Existing Feature Page\n\n'
              'CORE GROUPS\n'
              '1–50: Foundation, operations, risk, workforce, assets, incidents and assurance.\n\n'
              'ADVANCED GROUPS\n'
              '51–80: Advanced HSE management, operations intelligence, digital ecosystem and enterprise integration.\n\n'
              'AI / ENTERPRISE GROUPS\n'
              '81–100: AI-assisted intelligence, automation, decision support, resilience and enterprise command capabilities.\n\n'
              'INTEGRATION GROUPS\n'
              '101: Master Integration & System Architecture.\n'
              '102: Master Navigation & Integration Hub.\n\n'
              'SCALABILITY\n'
              'Navigation metadata is separated from feature business logic. New modules can be added to the navigation registry without rewriting unrelated feature screens.\n\n'
              'PERFORMANCE\n'
              'The hub keeps navigation metadata in memory and does not initialize every feature page at startup.\n\n'
              'UAE-WIDE\n'
              'The navigation layer is not restricted to one emirate. Emirate-specific compliance content can remain inside its relevant module.\n\n'
              'LANGUAGE\n'
              'The user-facing architecture is English + Malayalam ready.\n\n'
              'SAFETY\n'
              'Navigation must never bypass authorization, approval, verification or other safety controls in the destination feature.',
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

  Future<void> _showModuleDetails(Map<String, String> module) async {
    await showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(
            'Step ${module['step']}',
            style: const TextStyle(color: darkGreen),
          ),
          content: Text(
            '${module['title'] ?? ''}\n\n'
            'Category: ${module['category'] ?? ''}\n\n'
            '${module['description'] ?? ''}\n\n'
            'Navigation status: Registered\n'
            'Integration principle: Open the existing feature page from the master navigation layer.',
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

  Widget _moduleCard(Map<String, String> module) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _showModuleDetails(module),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CircleAvatar(
                backgroundColor: primaryGreen.withValues(alpha: 0.10),
                foregroundColor: darkGreen,
                child: const Icon(Icons.apps_outlined),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Step ${module['step']}',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: darkGreen,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      module['title'] ?? '',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      module['description'] ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 7),
                    Chip(
                      label: Text(module['category'] ?? ''),
                      visualDensity: VisualDensity.compact,
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> filtered = _filteredModules;

    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        title: const Text(
          'SafeNexus HSE — Step 102',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            tooltip: 'Architecture guide',
            onPressed: _showArchitectureGuide,
            icon: const Icon(Icons.menu_book_outlined),
          ),
          IconButton(
            tooltip: 'Dashboard',
            onPressed: _showDashboard,
            icon: const Icon(Icons.dashboard_outlined),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        children: <Widget>[
          Card(
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Master Navigation & Integration Hub',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      color: darkGreen,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Central navigation layer for the SafeNexus HSE roadmap 🇦🇪',
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
                        label: 'Roadmap',
                        value: '${_modules.length}',
                        icon: Icons.map_outlined,
                      ),
                      _metricCard(
                        label: 'Groups',
                        value: '${_categories.length - 1}',
                        icon: Icons.category_outlined,
                      ),
                      _metricCard(
                        label: 'Current',
                        value: '102',
                        icon: Icons.navigation_outlined,
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
              hintText: 'Search step, module or category...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _searchController.text.isEmpty
                  ? null
                  : IconButton(
                      onPressed: _clearSearch,
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
          DropdownButtonFormField<String>(
            initialValue: _selectedCategory,
            decoration: const InputDecoration(
              labelText: 'Navigation Group',
              filled: true,
              fillColor: Colors.white,
              prefixIcon: Icon(Icons.category_outlined),
            ),
            items: _categories.map((String category) {
              return DropdownMenuItem<String>(
                value: category,
                child: Text(category),
              );
            }).toList(),
            onChanged: (String? value) {
              if (value == null) return;
              setState(() {
                _selectedCategory = value;
              });
            },
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: _clearFilters,
              icon: const Icon(Icons.filter_alt_off_outlined),
              label: const Text('Clear filters'),
            ),
          ),
          Text(
            '${filtered.length} navigation entries',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: darkGreen,
            ),
          ),
          const SizedBox(height: 8),
          if (filtered.isEmpty)
            Card(
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  children: <Widget>[
                    Icon(
                      Icons.search_off_outlined,
                      size: 54,
                      color: darkGreen.withValues(alpha: 0.55),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'No navigation entry found.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Try another search term or category.',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            )
          else
            ...filtered.map(_moduleCard),
        ],
      ),
    );
  }
}
