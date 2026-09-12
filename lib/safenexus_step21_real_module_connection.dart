import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// SafeNexus HSE - Step 21
/// Real Module Connection & Navigation Integration
///
/// This file is the connection layer between the production app shell and
/// the existing SafeNexus HSE module pages.
///
/// IMPORTANT:
/// Existing phase files are NOT imported here on purpose. Each real page is
/// registered from main.dart using a builder callback. This avoids circular
/// imports and prevents unnecessary changes to already-green modules.
///
/// Register a real page like:
///
/// SafeNexusModuleConnection(
///   id: 'phase1',
///   phase: 'Phase 1',
///   title: 'Project Pre-Start',
///   subtitle: 'Project information, setup and readiness',
///   icon: Icons.assignment,
///   group: 'Core HSE',
///   builder: () => const ProjectPreStartPage(),
/// )

typedef SafeNexusConnectedPage = Widget Function();

class SafeNexusModuleConnection {
  final String id;
  final String phase;
  final String title;
  final String subtitle;
  final IconData icon;
  final String group;
  final SafeNexusConnectedPage? builder;

  const SafeNexusModuleConnection({
    required this.id,
    required this.phase,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.group,
    this.builder,
  });

  SafeNexusModuleConnection copyWith({
    SafeNexusConnectedPage? builder,
  }) {
    return SafeNexusModuleConnection(
      id: id,
      phase: phase,
      title: title,
      subtitle: subtitle,
      icon: icon,
      group: group,
      builder: builder ?? this.builder,
    );
  }
}

class SafeNexusStep21App extends StatefulWidget {
  final List<SafeNexusModuleConnection> connections;
  final String title;

  const SafeNexusStep21App({
    super.key,
    this.connections = const <SafeNexusModuleConnection>[],
    this.title = 'SafeNexus HSE',
  });

  @override
  State<SafeNexusStep21App> createState() => _SafeNexusStep21AppState();
}

class _SafeNexusStep21AppState extends State<SafeNexusStep21App> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);

  static const String _favoritesKey = 'safenexus_step21_favorites';
  static const String _recentKey = 'safenexus_step21_recent';

  final TextEditingController _searchController = TextEditingController();

  int _tabIndex = 0;
  String _query = '';
  String _group = 'All';
  List<String> _favorites = <String>[];
  List<String> _recent = <String>[];

  final List<SafeNexusModuleConnection> _catalog =
      const <SafeNexusModuleConnection>[
    SafeNexusModuleConnection(
      id: 'phase1',
      phase: 'Phase 1',
      title: 'Project Pre-Start',
      subtitle: 'Project information, setup and readiness',
      icon: Icons.assignment,
      group: 'Core HSE',
    ),
    SafeNexusModuleConnection(
      id: 'phase2',
      phase: 'Phase 2',
      title: 'HSE Management System',
      subtitle: 'Policy, plan, KPI, procedures and records',
      icon: Icons.policy,
      group: 'Core HSE',
    ),
    SafeNexusModuleConnection(
      id: 'phase3',
      phase: 'Phase 3',
      title: 'Risk & Planning',
      subtitle: 'HIRA, JSA, JHA, RAMS and risk controls',
      icon: Icons.warning_amber,
      group: 'Risk & Control',
    ),
    SafeNexusModuleConnection(
      id: 'phase4',
      phase: 'Phase 4',
      title: 'Permit to Work',
      subtitle: 'PTW, permits, extensions and closure',
      icon: Icons.approval,
      group: 'Risk & Control',
    ),
    SafeNexusModuleConnection(
      id: 'phase5',
      phase: 'Phase 5',
      title: 'Site Mobilization',
      subtitle: 'Site setup, access, welfare and readiness',
      icon: Icons.construction,
      group: 'Operations',
    ),
    SafeNexusModuleConnection(
      id: 'phase6',
      phase: 'Phase 6',
      title: 'Workforce & Competency',
      subtitle: 'Induction, training, competency and deployment',
      icon: Icons.groups,
      group: 'People & Resources',
    ),
    SafeNexusModuleConnection(
      id: 'phase7',
      phase: 'Phase 7',
      title: 'Equipment & Machinery',
      subtitle: 'Equipment, certificates, inspections and readiness',
      icon: Icons.precision_manufacturing,
      group: 'People & Resources',
    ),
    SafeNexusModuleConnection(
      id: 'phase8',
      phase: 'Phase 8',
      title: 'High-Risk Activities',
      subtitle: 'Critical work activity controls',
      icon: Icons.engineering,
      group: 'Risk & Control',
    ),
    SafeNexusModuleConnection(
      id: 'phase9',
      phase: 'Phase 9',
      title: 'Daily HSE Work',
      subtitle: 'TBT, inspections, observations and actions',
      icon: Icons.today,
      group: 'Operations',
    ),
    SafeNexusModuleConnection(
      id: 'phase10',
      phase: 'Phase 10',
      title: 'Emergency Management',
      subtitle: 'ERP, drills, rescue and evacuation',
      icon: Icons.emergency,
      group: 'Emergency',
    ),
    SafeNexusModuleConnection(
      id: 'phase11',
      phase: 'Phase 11',
      title: 'Occupational Health',
      subtitle: 'Medical fitness, heat stress and welfare',
      icon: Icons.health_and_safety,
      group: 'Health & Environment',
    ),
    SafeNexusModuleConnection(
      id: 'phase12',
      phase: 'Phase 12',
      title: 'Chemical & Environment',
      subtitle: 'Chemicals, waste, spills and monitoring',
      icon: Icons.eco,
      group: 'Health & Environment',
    ),
    SafeNexusModuleConnection(
      id: 'phase13',
      phase: 'Phase 13',
      title: 'Inspection & Audit',
      subtitle: 'Inspections, audits, CAPA and closure',
      icon: Icons.fact_check,
      group: 'Assurance',
    ),
    SafeNexusModuleConnection(
      id: 'phase14',
      phase: 'Phase 14',
      title: 'Incident Management',
      subtitle: 'Incident reporting, investigation and lessons',
      icon: Icons.report_problem,
      group: 'Assurance',
    ),
    SafeNexusModuleConnection(
      id: 'phase15',
      phase: 'Phase 15',
      title: 'HSE Reporting',
      subtitle: 'Daily, weekly, monthly and KPI reporting',
      icon: Icons.bar_chart,
      group: 'Reporting',
    ),
    SafeNexusModuleConnection(
      id: 'phase16',
      phase: 'Phase 16',
      title: 'Legal / Authority',
      subtitle: 'UAE legal and authority compliance',
      icon: Icons.gavel,
      group: 'Compliance',
    ),
    SafeNexusModuleConnection(
      id: 'step17',
      phase: 'Step 17',
      title: 'Master Dashboard',
      subtitle: '16-phase management overview',
      icon: Icons.dashboard,
      group: 'Management',
    ),
    SafeNexusModuleConnection(
      id: 'step18',
      phase: 'Step 18',
      title: 'HSE Action Center',
      subtitle: 'Cross-module action follow-up',
      icon: Icons.task_alt,
      group: 'Management',
    ),
    SafeNexusModuleConnection(
      id: 'step19',
      phase: 'Step 19',
      title: 'Integration & Navigation',
      subtitle: 'Navigation and integration layer',
      icon: Icons.account_tree,
      group: 'Management',
    ),
    SafeNexusModuleConnection(
      id: 'step20',
      phase: 'Step 20',
      title: 'Production App Shell',
      subtitle: 'Production home and navigation shell',
      icon: Icons.phone_android,
      group: 'Management',
    ),
  ];

  List<SafeNexusModuleConnection> get _modules {
    final registered = <String, SafeNexusModuleConnection>{
      for (final item in widget.connections) item.id: item,
    };

    final result = _catalog
        .map((item) => registered[item.id] ?? item)
        .toList();

    for (final item in widget.connections) {
      if (!result.any((existing) => existing.id == item.id)) {
        result.add(item);
      }
    }

    return result;
  }

  List<String> get _groups {
    final groups = <String>{'All'};
    for (final item in _modules) {
      groups.add(item.group);
    }
    return groups.toList();
  }

  List<SafeNexusModuleConnection> get _filtered {
    final query = _query.trim().toLowerCase();

    return _modules.where((item) {
      final groupMatch = _group == 'All' || item.group == _group;
      final textMatch = query.isEmpty ||
          item.id.toLowerCase().contains(query) ||
          item.phase.toLowerCase().contains(query) ||
          item.title.toLowerCase().contains(query) ||
          item.subtitle.toLowerCase().contains(query) ||
          item.group.toLowerCase().contains(query);

      return groupMatch && textMatch;
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearch);
    _loadPreferences();
  }

  void _onSearch() {
    final value = _searchController.text;
    if (value != _query) {
      setState(() => _query = value);
    }
  }

  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;

    setState(() {
      _favorites =
          prefs.getStringList(_favoritesKey) ?? <String>[];
      _recent =
          prefs.getStringList(_recentKey) ?? <String>[];
    });
  }

  Future<void> _savePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_favoritesKey, _favorites);
    await prefs.setStringList(_recentKey, _recent);
  }

  Future<void> _toggleFavorite(
    SafeNexusModuleConnection item,
  ) async {
    setState(() {
      if (_favorites.contains(item.id)) {
        _favorites.remove(item.id);
      } else {
        _favorites.add(item.id);
      }
    });
    await _savePreferences();
  }

  Future<void> _connectAndOpen(
    SafeNexusModuleConnection item,
  ) async {
    final recent = <String>[
      item.id,
      ..._recent.where((id) => id != item.id),
    ];

    if (recent.length > 10) {
      recent.removeRange(10, recent.length);
    }

    setState(() => _recent = recent);
    await _savePreferences();

    if (!mounted) return;

    final builder = item.builder;

    if (builder != null) {
      await Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (_) => builder(),
        ),
      );
      return;
    }

    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => _ConnectionStatusPage(item: item),
      ),
    );
  }

  SafeNexusModuleConnection? _find(String id) {
    for (final item in _modules) {
      if (item.id == id) return item;
    }
    return null;
  }

  void _openById(String id) {
    final item = _find(id);
    if (item != null) {
      _connectAndOpen(item);
    }
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearch);
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBackground,
      body: IndexedStack(
        index: _tabIndex,
        children: [
          _homePage(),
          _modulesPage(),
          _managementPage(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _tabIndex,
        onDestinationSelected: (index) {
          setState(() => _tabIndex = index);
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
            label: 'Manage',
          ),
        ],
      ),
    );
  }

  Widget _homePage() {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          backgroundColor: darkGreen,
          foregroundColor: Colors.white,
          title: Text(
            widget.title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              tooltip: 'Modules',
              onPressed: () {
                setState(() => _tabIndex = 1);
              },
              icon: const Icon(Icons.apps),
            ),
          ],
        ),
        SliverToBoxAdapter(child: _hero()),
        SliverToBoxAdapter(child: _overviewCards()),
        SliverToBoxAdapter(child: _criticalAccess()),
        SliverToBoxAdapter(child: _workflow()),
        SliverToBoxAdapter(child: _connectionSummary()),
        const SliverToBoxAdapter(
          child: SizedBox(height: 24),
        ),
      ],
    );
  }

  Widget _hero() {
    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(19),
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
              Icon(
                Icons.shield,
                color: Colors.white,
                size: 35,
              ),
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
          SizedBox(height: 8),
          Text(
            'Real Module Connection & Navigation',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 7),
          Text(
            'All existing HSE modules can be connected through a single '
            'safe registration layer without changing their internal logic.',
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

  Widget _overviewCards() {
    final connected =
        _modules.where((item) => item.builder != null).length;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Expanded(
            child: _smallStat(
              '${_modules.length}',
              'Modules',
              Icons.apps,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _smallStat(
              '$connected',
              'Connected',
              Icons.link,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _smallStat(
              '${_favorites.length}',
              'Favourites',
              Icons.star,
            ),
          ),
        ],
      ),
    );
  }

  Widget _smallStat(
    String value,
    String label,
    IconData icon,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 5,
          vertical: 13,
        ),
        child: Column(
          children: [
            Icon(icon, color: primaryGreen),
            const SizedBox(height: 5),
            Text(
              value,
              style: const TextStyle(
                color: darkGreen,
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              label,
              style: const TextStyle(fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }

  Widget _criticalAccess() {
    final ids = <String>[
      'step17',
      'step18',
      'phase3',
      'phase4',
      'phase9',
      'phase13',
      'phase14',
      'phase16',
    ];

    final items = ids
        .map(_find)
        .whereType<SafeNexusModuleConnection>()
        .toList();

    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 16, 12, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Critical HSE Access',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 2.5,
            ),
            itemBuilder: (_, index) {
              final item = items[index];
              return InkWell(
                borderRadius: BorderRadius.circular(14),
                onTap: () => _connectAndOpen(item),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        item.icon,
                        color: primaryGreen,
                      ),
                      const SizedBox(width: 7),
                      Expanded(
                        child: Text(
                          item.title,
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

  Widget _workflow() {
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
            'Integrated HSE Workflow',
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

  Widget _connectionSummary() {
    final connected =
        _modules.where((item) => item.builder != null).length;
    final pending = _modules.length - connected;

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
      child: Row(
        children: [
          const Icon(
            Icons.link,
            color: primaryGreen,
            size: 30,
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Text(
              '$connected modules connected • '
              '$pending awaiting registration',
              style: const TextStyle(
                color: darkGreen,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _modulesPage() {
    final modules = _filtered;

    return SafeArea(
      child: Column(
        children: [
          Container(
            color: darkGreen,
            padding: const EdgeInsets.fromLTRB(
              12,
              10,
              12,
              12,
            ),
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'SafeNexus HSE Modules',
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
                    hintText: 'Search phase or module...',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _query.isEmpty
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
            height: 55,
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
                    selected: _group == group,
                    selectedColor:
                        primaryGreen.withValues(alpha: 0.18),
                    onSelected: (_) {
                      setState(() => _group = group);
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
                      return _moduleTile(modules[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _moduleTile(SafeNexusModuleConnection item) {
    final favorite = _favorites.contains(item.id);
    final connected = item.builder != null;

    return Card(
      margin: const EdgeInsets.only(bottom: 9),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _connectAndOpen(item),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor:
                    primaryGreen.withValues(alpha: 0.10),
                child: Icon(
                  item.icon,
                  color: primaryGreen,
                ),
              ),
              const SizedBox(width: 11),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${item.phase} • ${item.title}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      item.subtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Icon(
                          connected
                              ? Icons.check_circle
                              : Icons.link_off,
                          size: 14,
                          color: connected
                              ? primaryGreen
                              : Colors.grey,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          connected
                              ? 'Connected'
                              : 'Registration pending',
                          style: TextStyle(
                            fontSize: 10,
                            color: connected
                                ? primaryGreen
                                : Colors.grey.shade700,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                tooltip: favorite
                    ? 'Remove favourite'
                    : 'Add favourite',
                onPressed: () => _toggleFavorite(item),
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

  Widget _managementPage() {
    final recentItems = _recent
        .map(_find)
        .whereType<SafeNexusModuleConnection>()
        .toList();

    final connected =
        _modules.where((item) => item.builder != null).length;

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          const SizedBox(height: 8),
          const Text(
            'Management & Integration',
            style: TextStyle(
              color: darkGreen,
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            'Real module connection status',
            style: TextStyle(color: Colors.grey.shade700),
          ),
          const SizedBox(height: 14),
          _managementCard(
            'Master Dashboard',
            'Step 17',
            Icons.dashboard,
            () => _openById('step17'),
          ),
          _managementCard(
            'HSE Action Center',
            'Step 18',
            Icons.task_alt,
            () => _openById('step18'),
          ),
          _managementCard(
            'Integration & Navigation',
            'Step 19',
            Icons.account_tree,
            () => _openById('step19'),
          ),
          _managementCard(
            'Production App Shell',
            'Step 20',
            Icons.phone_android,
            () => _openById('step20'),
          ),
          const SizedBox(height: 14),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Connection Status',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 10),
                  LinearProgressIndicator(
                    value: _modules.isEmpty
                        ? 0
                        : connected / _modules.length,
                    minHeight: 8,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$connected / ${_modules.length} modules registered',
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          const Text(
            'Recent Modules',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 7),
          if (recentItems.isEmpty)
            const Card(
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  'Open a module to create recent-module history.',
                ),
              ),
            )
          else
            ...recentItems.map(
              (item) => ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 8),
                leading: CircleAvatar(
                  backgroundColor:
                      primaryGreen.withValues(alpha: 0.10),
                  child: Icon(
                    item.icon,
                    color: primaryGreen,
                  ),
                ),
                title: Text(item.title),
                subtitle: Text(item.phase),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => _connectAndOpen(item),
              ),
            ),
          const SizedBox(height: 14),
          const Card(
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Row(
                children: [
                  Icon(
                    Icons.security,
                    color: darkGreen,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Integration is builder-based. Existing module '
                      'logic remains untouched, reducing regression risk.',
                      style: TextStyle(height: 1.4),
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

  Widget _managementCard(
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
          child: Icon(
            icon,
            color: primaryGreen,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}

class _ConnectionStatusPage extends StatelessWidget {
  final SafeNexusModuleConnection item;

  const _ConnectionStatusPage({
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    const primaryGreen = Color(0xFF159447);
    const darkGreen = Color(0xFF0B5D4B);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
        title: Text(item.title),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          CircleAvatar(
            radius: 36,
            backgroundColor:
                primaryGreen.withValues(alpha: 0.10),
            child: Icon(
              item.icon,
              color: primaryGreen,
              size: 36,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            '${item.phase} • ${item.title}',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 7),
          Text(
            item.subtitle,
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
                    size: 34,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Registration pending',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    'Connect the existing ${item.title} page through '
                    'SafeNexusModuleConnection.builder in main.dart.',
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

/// Creates the Step 21 app shell.
///
/// Example:
///
/// runApp(
///   MaterialApp(
///     debugShowCheckedModeBanner: false,
///     home: safeNexusStep21Home(
///       connections: [
///         SafeNexusModuleConnection(
///           id: 'phase1',
///           phase: 'Phase 1',
///           title: 'Project Pre-Start',
///           subtitle: 'Project information, setup and readiness',
///           icon: Icons.assignment,
///           group: 'Core HSE',
///           builder: () => const ProjectPreStartPage(),
///         ),
///       ],
///     ),
///   ),
/// );
Widget safeNexusStep21Home({
  List<SafeNexusModuleConnection> connections =
      const <SafeNexusModuleConnection>[],
}) {
  return SafeNexusStep21App(
    connections: connections,
  );
}
