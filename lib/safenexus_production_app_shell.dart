import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// SafeNexus HSE - Step 20
/// Production Integration & Final App Shell
///
/// This file is intentionally self-contained.
/// It provides a production-safe shell around the existing SafeNexus
/// modules without importing or modifying those modules.
///
/// Connect real pages by passing SafeNexusProductionModule objects with
/// a builder callback from main.dart.

typedef SafeNexusPageBuilder = Widget Function();

class SafeNexusProductionModule {
  final String id;
  final String phase;
  final String title;
  final String subtitle;
  final IconData icon;
  final String group;
  final SafeNexusPageBuilder? builder;

  const SafeNexusProductionModule({
    required this.id,
    required this.phase,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.group,
    this.builder,
  });
}

class SafeNexusProductionAppShell extends StatefulWidget {
  final List<SafeNexusProductionModule> modules;
  final String appTitle;

  const SafeNexusProductionAppShell({
    super.key,
    this.modules = const <SafeNexusProductionModule>[],
    this.appTitle = 'SafeNexus HSE',
  });

  @override
  State<SafeNexusProductionAppShell> createState() =>
      _SafeNexusProductionAppShellState();
}

class _SafeNexusProductionAppShellState
    extends State<SafeNexusProductionAppShell> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);

  static const String _favoritesKey = 'safenexus_step20_favorites';
  static const String _recentKey = 'safenexus_step20_recent';

  int _currentIndex = 0;
  String _searchText = '';
  String _selectedGroup = 'All';
  List<String> _favorites = <String>[];
  List<String> _recent = <String>[];

  final TextEditingController _searchController = TextEditingController();

  final List<SafeNexusProductionModule> _defaultModules =
      const <SafeNexusProductionModule>[
    SafeNexusProductionModule(
      id: 'phase1',
      phase: 'Phase 1',
      title: 'Project Pre-Start',
      subtitle: 'Project information, setup and readiness',
      icon: Icons.assignment,
      group: 'Core HSE',
    ),
    SafeNexusProductionModule(
      id: 'phase2',
      phase: 'Phase 2',
      title: 'HSE Management System',
      subtitle: 'Policy, plan, KPI, procedures and records',
      icon: Icons.policy,
      group: 'Core HSE',
    ),
    SafeNexusProductionModule(
      id: 'phase3',
      phase: 'Phase 3',
      title: 'Risk & Planning',
      subtitle: 'HIRA, JSA, JHA, RAMS and risk controls',
      icon: Icons.warning_amber,
      group: 'Risk & Control',
    ),
    SafeNexusProductionModule(
      id: 'phase4',
      phase: 'Phase 4',
      title: 'Permit to Work',
      subtitle: 'PTW, permits, extensions and closure',
      icon: Icons.approval,
      group: 'Risk & Control',
    ),
    SafeNexusProductionModule(
      id: 'phase5',
      phase: 'Phase 5',
      title: 'Site Mobilization',
      subtitle: 'Site setup, access, welfare and readiness',
      icon: Icons.construction,
      group: 'Operations',
    ),
    SafeNexusProductionModule(
      id: 'phase6',
      phase: 'Phase 6',
      title: 'Workforce & Competency',
      subtitle: 'Induction, training, competency and deployment',
      icon: Icons.groups,
      group: 'People & Resources',
    ),
    SafeNexusProductionModule(
      id: 'phase7',
      phase: 'Phase 7',
      title: 'Equipment & Machinery',
      subtitle: 'Equipment, certificates, inspections and readiness',
      icon: Icons.precision_manufacturing,
      group: 'People & Resources',
    ),
    SafeNexusProductionModule(
      id: 'phase8',
      phase: 'Phase 8',
      title: 'High-Risk Activities',
      subtitle: 'Critical work activity controls',
      icon: Icons.engineering,
      group: 'Risk & Control',
    ),
    SafeNexusProductionModule(
      id: 'phase9',
      phase: 'Phase 9',
      title: 'Daily HSE Work',
      subtitle: 'TBT, inspections, observations and actions',
      icon: Icons.today,
      group: 'Operations',
    ),
    SafeNexusProductionModule(
      id: 'phase10',
      phase: 'Phase 10',
      title: 'Emergency Management',
      subtitle: 'ERP, drills, rescue and evacuation',
      icon: Icons.emergency,
      group: 'Emergency',
    ),
    SafeNexusProductionModule(
      id: 'phase11',
      phase: 'Phase 11',
      title: 'Occupational Health',
      subtitle: 'Medical fitness, heat stress and welfare',
      icon: Icons.health_and_safety,
      group: 'Health & Environment',
    ),
    SafeNexusProductionModule(
      id: 'phase12',
      phase: 'Phase 12',
      title: 'Chemical & Environment',
      subtitle: 'Chemicals, waste, spills and monitoring',
      icon: Icons.eco,
      group: 'Health & Environment',
    ),
    SafeNexusProductionModule(
      id: 'phase13',
      phase: 'Phase 13',
      title: 'Inspection & Audit',
      subtitle: 'Inspections, audits, CAPA and closure',
      icon: Icons.fact_check,
      group: 'Assurance',
    ),
    SafeNexusProductionModule(
      id: 'phase14',
      phase: 'Phase 14',
      title: 'Incident Management',
      subtitle: 'Incident reporting, investigation and lessons',
      icon: Icons.report_problem,
      group: 'Assurance',
    ),
    SafeNexusProductionModule(
      id: 'phase15',
      phase: 'Phase 15',
      title: 'HSE Reporting',
      subtitle: 'Daily, weekly, monthly and KPI reporting',
      icon: Icons.bar_chart,
      group: 'Reporting',
    ),
    SafeNexusProductionModule(
      id: 'phase16',
      phase: 'Phase 16',
      title: 'Legal / Authority',
      subtitle: 'UAE legal and authority compliance',
      icon: Icons.gavel,
      group: 'Compliance',
    ),
    SafeNexusProductionModule(
      id: 'step17',
      phase: 'Step 17',
      title: 'Master Dashboard',
      subtitle: '16-phase management overview',
      icon: Icons.dashboard,
      group: 'Management',
    ),
    SafeNexusProductionModule(
      id: 'step18',
      phase: 'Step 18',
      title: 'HSE Action Center',
      subtitle: 'Cross-module action follow-up',
      icon: Icons.task_alt,
      group: 'Management',
    ),
    SafeNexusProductionModule(
      id: 'step19',
      phase: 'Step 19',
      title: 'Integration & Navigation',
      subtitle: 'Module integration and navigation layer',
      icon: Icons.account_tree,
      group: 'Management',
    ),
  ];

  List<SafeNexusProductionModule> get _modules {
    final custom = <String, SafeNexusProductionModule>{
      for (final module in widget.modules) module.id: module,
    };

    final result = _defaultModules
        .map((module) => custom[module.id] ?? module)
        .toList();

    for (final module in widget.modules) {
      if (!result.any((item) => item.id == module.id)) {
        result.add(module);
      }
    }
    return result;
  }

  List<String> get _groups {
    final result = <String>{'All'};
    for (final module in _modules) {
      result.add(module.group);
    }
    return result.toList();
  }

  List<SafeNexusProductionModule> get _filteredModules {
    final query = _searchText.trim().toLowerCase();

    return _modules.where((module) {
      final groupMatch =
          _selectedGroup == 'All' || module.group == _selectedGroup;

      final textMatch = query.isEmpty ||
          module.title.toLowerCase().contains(query) ||
          module.subtitle.toLowerCase().contains(query) ||
          module.phase.toLowerCase().contains(query) ||
          module.group.toLowerCase().contains(query);

      return groupMatch && textMatch;
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_handleSearch);
    _loadState();
  }

  void _handleSearch() {
    final value = _searchController.text;
    if (value != _searchText) {
      setState(() => _searchText = value);
    }
  }

  Future<void> _loadState() async {
    final prefs = await SharedPreferences.getInstance();

    if (!mounted) return;

    setState(() {
      _favorites = prefs.getStringList(_favoritesKey) ?? <String>[];
      _recent = prefs.getStringList(_recentKey) ?? <String>[];
    });
  }

  Future<void> _saveState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_favoritesKey, _favorites);
    await prefs.setStringList(_recentKey, _recent);
  }

  Future<void> _toggleFavorite(
    SafeNexusProductionModule module,
  ) async {
    setState(() {
      if (_favorites.contains(module.id)) {
        _favorites.remove(module.id);
      } else {
        _favorites.add(module.id);
      }
    });

    await _saveState();
  }

  Future<void> _openModule(
    SafeNexusProductionModule module,
  ) async {
    final recent = <String>[
      module.id,
      ..._recent.where((id) => id != module.id),
    ];

    if (recent.length > 8) {
      recent.removeRange(8, recent.length);
    }

    setState(() => _recent = recent);
    await _saveState();

    if (!mounted) return;

    if (module.builder != null) {
      await Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (_) => module.builder!(),
        ),
      );
      return;
    }

    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => _ProductionModulePlaceholder(
          module: module,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.removeListener(_handleSearch);
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBackground,
      body: IndexedStack(
        index: _currentIndex,
        children: [
          _buildHomeTab(),
          _buildModulesTab(),
          _buildManagementTab(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() => _currentIndex = index);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.apps_outlined),
            selectedIcon: Icon(Icons.apps),
            label: 'Modules',
          ),
          NavigationDestination(
            icon: Icon(Icons.admin_panel_settings_outlined),
            selectedIcon: Icon(Icons.admin_panel_settings),
            label: 'Management',
          ),
        ],
      ),
    );
  }

  Widget _buildHomeTab() {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          backgroundColor: darkGreen,
          foregroundColor: Colors.white,
          title: Text(
            widget.appTitle,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              tooltip: 'Search',
              onPressed: () {
                setState(() => _currentIndex = 1);
              },
              icon: const Icon(Icons.search),
            ),
          ],
        ),
        SliverToBoxAdapter(child: _buildHero()),
        SliverToBoxAdapter(child: _buildQuickStats()),
        SliverToBoxAdapter(child: _buildQuickAccess()),
        SliverToBoxAdapter(child: _buildLifecycle()),
        SliverToBoxAdapter(child: _buildProductionStatus()),
        const SliverToBoxAdapter(child: SizedBox(height: 24)),
      ],
    );
  }

  Widget _buildHero() {
    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [darkGreen, primaryGreen],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.shield, color: Colors.white, size: 34),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'SafeNexus HSE',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            'UAE-Wide HSE Safety Management System 🇦🇪',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 7),
          Text(
            'Integrated production app shell for project, risk, PTW, '
            'workforce, equipment, daily HSE, emergency, environment, '
            'audit, incident, reporting and legal compliance.',
            style: TextStyle(
              color: Colors.white70,
              height: 1.4,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStats() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Expanded(
            child: _statCard(
              '16',
              'Phases',
              Icons.view_module,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _statCard(
              '19',
              'Integrated',
              Icons.link,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _statCard(
              '${_favorites.length}',
              'Favourites',
              Icons.star,
            ),
          ),
        ],
      ),
    );
  }

  Widget _statCard(
    String value,
    String label,
    IconData icon,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 13,
        ),
        child: Column(
          children: [
            Icon(icon, color: primaryGreen),
            const SizedBox(height: 5),
            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: darkGreen,
              ),
            ),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickAccess() {
    final preferredIds = <String>[
      'step17',
      'step18',
      'phase3',
      'phase4',
      'phase9',
      'phase13',
      'phase14',
      'phase16',
    ];

    final modules = preferredIds
        .map(
          (id) => _modules.where((module) => module.id == id).firstOrNull,
        )
        .whereType<SafeNexusProductionModule>()
        .toList();

    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 16, 12, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Quick Access',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: modules.length,
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 2.55,
            ),
            itemBuilder: (_, index) {
              final module = modules[index];
              return InkWell(
                onTap: () => _openModule(module),
                borderRadius: BorderRadius.circular(14),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: primaryGreen.withValues(alpha: 0.15),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(module.icon, color: primaryGreen),
                      const SizedBox(width: 7),
                      Expanded(
                        child: Text(
                          module.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLifecycle() {
    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'HSE Work Lifecycle',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Project → Risk → RAMS → PTW → Competency → Equipment → '
            'TBT → Pre-Start → Work → Inspection → Action → '
            'Verification → Close',
            style: TextStyle(
              height: 1.5,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductionStatus() {
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: primaryGreen.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(17),
        border: Border.all(
          color: primaryGreen.withValues(alpha: 0.18),
        ),
      ),
      child: const Row(
        children: [
          Icon(
            Icons.verified_user,
            color: primaryGreen,
            size: 30,
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Production Integration Layer',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: darkGreen,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  'Existing HSE modules can be connected through '
                  'builder callbacks without changing their internal files.',
                  style: TextStyle(
                    fontSize: 12,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModulesTab() {
    final modules = _filteredModules;

    return SafeArea(
      child: Column(
        children: [
          Container(
            color: darkGreen,
            padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'HSE Modules',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search modules...',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _searchText.isEmpty
                        ? null
                        : IconButton(
                            onPressed: _searchController.clear,
                            icon: const Icon(Icons.clear),
                          ),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(13),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 54,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
              scrollDirection: Axis.horizontal,
              itemCount: _groups.length,
              itemBuilder: (_, index) {
                final group = _groups[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(group),
                    selected: _selectedGroup == group,
                    selectedColor:
                        primaryGreen.withValues(alpha: 0.18),
                    onSelected: (_) {
                      setState(() => _selectedGroup = group);
                    },
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: modules.isEmpty
                ? const Center(
                    child: Text('No modules found.'),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(
                      12,
                      4,
                      12,
                      20,
                    ),
                    itemCount: modules.length,
                    itemBuilder: (_, index) {
                      return _moduleCard(modules[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _moduleCard(SafeNexusProductionModule module) {
    final favorite = _favorites.contains(module.id);

    return Card(
      margin: const EdgeInsets.only(bottom: 9),
      child: InkWell(
        onTap: () => _openModule(module),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor:
                    primaryGreen.withValues(alpha: 0.10),
                child: Icon(
                  module.icon,
                  color: primaryGreen,
                ),
              ),
              const SizedBox(width: 11),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${module.phase} • ${module.title}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      module.subtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                tooltip: favorite
                    ? 'Remove favourite'
                    : 'Add favourite',
                onPressed: () => _toggleFavorite(module),
                icon: Icon(
                  favorite
                      ? Icons.star
                      : Icons.star_border,
                  color: favorite
                      ? Colors.amber.shade700
                      : Colors.grey,
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildManagementTab() {
    final recentModules = _recent
        .map(
          (id) => _modules.where((module) => module.id == id).firstOrNull,
        )
        .whereType<SafeNexusProductionModule>()
        .toList();

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          const SizedBox(height: 8),
          const Text(
            'Management Center',
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
              color: darkGreen,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'Production control and navigation utilities',
            style: TextStyle(color: Colors.grey.shade700),
          ),
          const SizedBox(height: 15),
          _managementTile(
            'Master Dashboard',
            'Step 17 management overview',
            Icons.dashboard,
            () => _openById('step17'),
          ),
          _managementTile(
            'HSE Action Center',
            'Step 18 cross-module actions',
            Icons.task_alt,
            () => _openById('step18'),
          ),
          _managementTile(
            'Integration Layer',
            'Step 19 navigation architecture',
            Icons.account_tree,
            () => _openById('step19'),
          ),
          const SizedBox(height: 12),
          const Text(
            'Recent Modules',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 7),
          if (recentModules.isEmpty)
            const Card(
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  'Open a module to see it here.',
                ),
              ),
            )
          else
            ...recentModules.map(
              (module) => ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 8,
                ),
                leading: CircleAvatar(
                  backgroundColor:
                      primaryGreen.withValues(alpha: 0.10),
                  child: Icon(
                    module.icon,
                    color: primaryGreen,
                  ),
                ),
                title: Text(module.title),
                subtitle: Text(module.phase),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => _openModule(module),
              ),
            ),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  const Icon(
                    Icons.security,
                    color: darkGreen,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Step 20 is an integration shell. '
                      'Existing module business logic remains in its '
                      'own file, reducing regression risk.',
                      style: TextStyle(
                        color: Colors.grey.shade800,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _managementTile(
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap,
  ) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor:
              primaryGreen.withValues(alpha: 0.10),
          child: Icon(icon, color: primaryGreen),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }

  void _openById(String id) {
    final module =
        _modules.where((item) => item.id == id).firstOrNull;

    if (module != null) {
      _openModule(module);
    }
  }
}

class _ProductionModulePlaceholder extends StatelessWidget {
  final SafeNexusProductionModule module;

  const _ProductionModulePlaceholder({
    required this.module,
  });

  @override
  Widget build(BuildContext context) {
    const primaryGreen = Color(0xFF159447);
    const darkGreen = Color(0xFF0B5D4B);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
        title: Text(module.title),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          CircleAvatar(
            radius: 35,
            backgroundColor:
                primaryGreen.withValues(alpha: 0.10),
            child: Icon(
              module.icon,
              color: primaryGreen,
              size: 35,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            '${module.phase} • ${module.title}',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 7),
          Text(
            module.subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 20),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  const Icon(
                    Icons.link,
                    color: darkGreen,
                    size: 32,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Module connection ready',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    'Register the existing page using the builder '
                    'callback in SafeNexusProductionModule to open '
                    'the real module here.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Convenience helper for main.dart.
///
/// Example:
///
/// MaterialApp(
///   debugShowCheckedModeBanner: false,
///   home: SafeNexusProductionAppShell(
///     modules: [
///       SafeNexusProductionModule(
///         id: 'phase1',
///         phase: 'Phase 1',
///         title: 'Project Pre-Start',
///         subtitle: 'Project information, setup and readiness',
///         icon: Icons.assignment,
///         group: 'Core HSE',
///         builder: () => const ProjectPreStartPage(),
///       ),
///     ],
///   ),
/// );
Widget safeNexusProductionHome({
  List<SafeNexusProductionModule> modules =
      const <SafeNexusProductionModule>[],
}) {
  return SafeNexusProductionAppShell(
    modules: modules,
  );
}
