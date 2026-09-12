import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// SafeNexus HSE - Step 19
/// App Integration & Navigation Shell
///
/// Purpose:
/// - Central navigation for the 16 HSE phases + Step 17/18.
/// - Does not modify existing phase files.
/// - Uses safe dynamic navigation: screens can be registered from main.dart
///   without creating hard imports to every module.
/// - Includes global module search, favourites, recent modules and integration
///   status.
/// - Designed for UAE-wide HSE scalability.

typedef SafeNexusModuleBuilder = Widget Function();

class SafeNexusModule {
  final String id;
  final String phase;
  final String title;
  final String subtitle;
  final IconData icon;
  final String group;
  final SafeNexusModuleBuilder? builder;

  const SafeNexusModule({
    required this.id,
    required this.phase,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.group,
    this.builder,
  });
}

class SafeNexusStep19Shell extends StatefulWidget {
  final List<SafeNexusModule> modules;

  const SafeNexusStep19Shell({
    super.key,
    this.modules = const <SafeNexusModule>[],
  });

  @override
  State<SafeNexusStep19Shell> createState() => _SafeNexusStep19ShellState();
}

class _SafeNexusStep19ShellState extends State<SafeNexusStep19Shell> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);

  static const String _favoritesKey = 'safenexus_step19_favorites';
  static const String _recentKey = 'safenexus_step19_recent';

  final TextEditingController _searchController = TextEditingController();

  List<String> _favorites = <String>[];
  List<String> _recent = <String>[];
  String _selectedGroup = 'All';
  String _searchText = '';

  final List<SafeNexusModule> _defaultModules = const <SafeNexusModule>[
    SafeNexusModule(
      id: 'phase1',
      phase: 'Phase 1',
      title: 'Project Pre-Start',
      subtitle: 'Project information, setup and readiness',
      icon: Icons.assignment,
      group: 'Core HSE',
    ),
    SafeNexusModule(
      id: 'phase2',
      phase: 'Phase 2',
      title: 'HSE Management System',
      subtitle: 'Policy, plan, KPI, procedures and records',
      icon: Icons.policy,
      group: 'Core HSE',
    ),
    SafeNexusModule(
      id: 'phase3',
      phase: 'Phase 3',
      title: 'Risk & Planning',
      subtitle: 'HIRA, JSA, JHA, RAMS and risk controls',
      icon: Icons.warning_amber,
      group: 'Risk & Control',
    ),
    SafeNexusModule(
      id: 'phase4',
      phase: 'Phase 4',
      title: 'Permit to Work',
      subtitle: 'PTW, permits, extensions and closure',
      icon: Icons.approval,
      group: 'Risk & Control',
    ),
    SafeNexusModule(
      id: 'phase5',
      phase: 'Phase 5',
      title: 'Site Mobilization',
      subtitle: 'Site setup, access, welfare and readiness',
      icon: Icons.construction,
      group: 'Operations',
    ),
    SafeNexusModule(
      id: 'phase6',
      phase: 'Phase 6',
      title: 'Workforce & Competency',
      subtitle: 'Induction, training, competency and deployment',
      icon: Icons.groups,
      group: 'People & Resources',
    ),
    SafeNexusModule(
      id: 'phase7',
      phase: 'Phase 7',
      title: 'Equipment & Machinery',
      subtitle: 'Equipment, certificates, inspections and readiness',
      icon: Icons.precision_manufacturing,
      group: 'People & Resources',
    ),
    SafeNexusModule(
      id: 'phase8',
      phase: 'Phase 8',
      title: 'High-Risk Activities',
      subtitle: 'Critical work activity controls',
      icon: Icons.engineering,
      group: 'Risk & Control',
    ),
    SafeNexusModule(
      id: 'phase9',
      phase: 'Phase 9',
      title: 'Daily HSE Work',
      subtitle: 'TBT, inspections, observations and actions',
      icon: Icons.today,
      group: 'Operations',
    ),
    SafeNexusModule(
      id: 'phase10',
      phase: 'Phase 10',
      title: 'Emergency Management',
      subtitle: 'ERP, drills, rescue and evacuation',
      icon: Icons.emergency,
      group: 'Emergency',
    ),
    SafeNexusModule(
      id: 'phase11',
      phase: 'Phase 11',
      title: 'Occupational Health',
      subtitle: 'Medical fitness, heat stress and welfare',
      icon: Icons.health_and_safety,
      group: 'Health & Environment',
    ),
    SafeNexusModule(
      id: 'phase12',
      phase: 'Phase 12',
      title: 'Chemical & Environment',
      subtitle: 'Chemicals, waste, spills and monitoring',
      icon: Icons.eco,
      group: 'Health & Environment',
    ),
    SafeNexusModule(
      id: 'phase13',
      phase: 'Phase 13',
      title: 'Inspection & Audit',
      subtitle: 'Inspections, audits, CAPA and closure',
      icon: Icons.fact_check,
      group: 'Assurance',
    ),
    SafeNexusModule(
      id: 'phase14',
      phase: 'Phase 14',
      title: 'Incident Management',
      subtitle: 'Incident reporting, investigation and lessons',
      icon: Icons.report_problem,
      group: 'Assurance',
    ),
    SafeNexusModule(
      id: 'phase15',
      phase: 'Phase 15',
      title: 'HSE Reporting',
      subtitle: 'Daily, weekly, monthly and KPI reporting',
      icon: Icons.bar_chart,
      group: 'Reporting',
    ),
    SafeNexusModule(
      id: 'phase16',
      phase: 'Phase 16',
      title: 'Legal / Authority',
      subtitle: 'UAE legal and authority compliance',
      icon: Icons.gavel,
      group: 'Compliance',
    ),
    SafeNexusModule(
      id: 'step17',
      phase: 'Step 17',
      title: 'Master Dashboard',
      subtitle: '16-phase HSE overview and management snapshot',
      icon: Icons.dashboard,
      group: 'Management',
    ),
    SafeNexusModule(
      id: 'step18',
      phase: 'Step 18',
      title: 'HSE Action Center',
      subtitle: 'Cross-module actions and follow-up',
      icon: Icons.task_alt,
      group: 'Management',
    ),
  ];

  List<SafeNexusModule> get _allModules {
    final custom = <String, SafeNexusModule>{
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
    final groups = <String>{'All'};
    for (final module in _allModules) {
      groups.add(module.group);
    }
    return groups.toList();
  }

  List<SafeNexusModule> get _filteredModules {
    final query = _searchText.trim().toLowerCase();
    return _allModules.where((module) {
      final groupMatch =
          _selectedGroup == 'All' || module.group == _selectedGroup;
      final textMatch = query.isEmpty ||
          module.title.toLowerCase().contains(query) ||
          module.subtitle.toLowerCase().contains(query) ||
          module.phase.toLowerCase().contains(query);
      return groupMatch && textMatch;
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    _loadState();
    _searchController.addListener(() {
      final value = _searchController.text;
      if (value != _searchText) {
        setState(() => _searchText = value);
      }
    });
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

  Future<void> _toggleFavorite(SafeNexusModule module) async {
    setState(() {
      if (_favorites.contains(module.id)) {
        _favorites.remove(module.id);
      } else {
        _favorites.add(module.id);
      }
    });
    await _saveState();
  }

  Future<void> _openModule(SafeNexusModule module) async {
    final updatedRecent = <String>[
      module.id,
      ..._recent.where((id) => id != module.id),
    ];
    if (updatedRecent.length > 8) {
      updatedRecent.removeRange(8, updatedRecent.length);
    }

    setState(() => _recent = updatedRecent);
    await _saveState();

    if (!mounted) return;

    if (module.builder != null) {
      await Navigator.of(context).push(
        MaterialPageRoute<void>(builder: (_) => module.builder!()),
      );
      return;
    }

    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => _ModuleIntegrationPage(module: module),
      ),
    );
  }

  void _showFavorites() {
    final favoriteModules = _allModules
        .where((module) => _favorites.contains(module.id))
        .toList();

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return SafeArea(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.65,
            child: Column(
              children: [
                const SizedBox(height: 12),
                Container(
                  width: 44,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Favourite Modules',
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: favoriteModules.isEmpty
                      ? const Center(
                          child: Text('No favourite modules yet.'),
                        )
                      : ListView.builder(
                          itemCount: favoriteModules.length,
                          itemBuilder: (_, index) {
                            final module = favoriteModules[index];
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundColor:
                                    primaryGreen.withValues(alpha: 0.10),
                                child: Icon(module.icon, color: primaryGreen),
                              ),
                              title: Text(module.title),
                              subtitle:
                                  Text('${module.phase} • ${module.group}'),
                              trailing: const Icon(Icons.chevron_right),
                              onTap: () {
                                Navigator.pop(context);
                                _openModule(module);
                              },
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final modules = _filteredModules;

    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
        title: const Text(
          'SafeNexus HSE',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            tooltip: 'Favourites',
            onPressed: _showFavorites,
            icon: const Icon(Icons.star_border),
          ),
        ],
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _buildHeader()),
            SliverToBoxAdapter(child: _buildSearch()),
            SliverToBoxAdapter(child: _buildGroupFilter()),
            SliverToBoxAdapter(child: _buildIntegrationFlow()),
            if (modules.isEmpty)
              const SliverFillRemaining(
                hasScrollBody: false,
                child: Center(child: Text('No modules found.')),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(12, 4, 12, 24),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (_, index) => _buildModuleCard(modules[index]),
                    childCount: modules.length,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [darkGreen, primaryGreen],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            blurRadius: 12,
            offset: Offset(0, 6),
            color: Color(0x22000000),
          ),
        ],
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.shield, color: Colors.white, size: 32),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'UAE-Wide HSE Management System',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            'SafeNexus HSE • Step 19 Integration & Navigation',
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
          SizedBox(height: 8),
          Text(
            'One secure navigation layer for the complete HSE lifecycle.',
            style: TextStyle(color: Colors.white, fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _buildSearch() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Search phase, module or HSE function...',
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
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildGroupFilter() {
    return SizedBox(
      height: 58,
      child: ListView.builder(
        padding: const EdgeInsets.fromLTRB(12, 10, 12, 8),
        scrollDirection: Axis.horizontal,
        itemCount: _groups.length,
        itemBuilder: (_, index) {
          final group = _groups[index];
          final selected = group == _selectedGroup;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(group),
              selected: selected,
              selectedColor: primaryGreen.withValues(alpha: 0.18),
              onSelected: (_) => setState(() => _selectedGroup = group),
            ),
          );
        },
      ),
    );
  }

  Widget _buildIntegrationFlow() {
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 2, 12, 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: primaryGreen.withValues(alpha: 0.18)),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'HSE Lifecycle Integration',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          SizedBox(height: 8),
          Text(
            'Plan → Risk → RAMS → PTW → Competency → Equipment → '
            'TBT → Pre-Start → Work → Inspection → Action → Verification → Close',
            style: TextStyle(height: 1.45, fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _buildModuleCard(SafeNexusModule module) {
    final favorite = _favorites.contains(module.id);

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 1.5,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _openModule(module),
        child: Padding(
          padding: const EdgeInsets.all(13),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: primaryGreen.withValues(alpha: 0.10),
                child: Icon(module.icon, color: primaryGreen, size: 26),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${module.phase} • ${module.title}',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      module.subtitle,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      module.group,
                      style: const TextStyle(
                        color: darkGreen,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                tooltip: favorite ? 'Remove favourite' : 'Add favourite',
                onPressed: () => _toggleFavorite(module),
                icon: Icon(
                  favorite ? Icons.star : Icons.star_border,
                  color: favorite ? Colors.amber.shade700 : Colors.grey,
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}

class _ModuleIntegrationPage extends StatelessWidget {
  final SafeNexusModule module;

  const _ModuleIntegrationPage({required this.module});

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
            radius: 34,
            backgroundColor: primaryGreen.withValues(alpha: 0.10),
            child: Icon(module.icon, color: primaryGreen, size: 34),
          ),
          const SizedBox(height: 14),
          Text(
            '${module.phase} • ${module.title}',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            module.subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey.shade700),
          ),
          const SizedBox(height: 24),
          _InfoCard(
            title: 'Integration Status',
            value: 'Ready for module connection',
            icon: Icons.link,
          ),
          _InfoCard(
            title: 'Architecture',
            value: 'UAE-wide scalable HSE module',
            icon: Icons.account_tree,
          ),
          _InfoCard(
            title: 'Lifecycle Role',
            value: _lifecycleRole(module.id),
            icon: Icons.route,
          ),
          const SizedBox(height: 12),
          if (module.builder == null)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Row(
                  children: [
                    const Icon(Icons.info_outline, color: darkGreen),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Register the existing module screen with '
                        'SafeNexusStep19Shell(modules: [...]) to open its '
                        'actual page from this integration layer.',
                        style: TextStyle(color: Colors.grey.shade800),
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

  String _lifecycleRole(String id) {
    switch (id) {
      case 'phase1':
        return 'Project setup and readiness';
      case 'phase2':
        return 'HSE management system';
      case 'phase3':
        return 'Risk identification and planning';
      case 'phase4':
        return 'Permit control before work';
      case 'phase5':
        return 'Site establishment';
      case 'phase6':
        return 'People and competency readiness';
      case 'phase7':
        return 'Equipment readiness';
      case 'phase8':
        return 'Critical activity controls';
      case 'phase9':
        return 'Daily field execution';
      case 'phase10':
        return 'Emergency preparedness and response';
      case 'phase11':
        return 'Occupational health';
      case 'phase12':
        return 'Chemical and environmental control';
      case 'phase13':
        return 'Inspection and assurance';
      case 'phase14':
        return 'Incident management';
      case 'phase15':
        return 'HSE performance reporting';
      case 'phase16':
        return 'Legal and authority compliance';
      case 'step17':
        return 'Management overview';
      case 'step18':
        return 'Cross-module action closure';
      default:
        return 'Integrated HSE workflow';
    }
  }
}

class _InfoCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _InfoCard({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: const Icon(Icons.check_circle_outline, color: Color(0xFF159447)),
        title: Text(title),
        subtitle: Text(value),
        trailing: Icon(icon, color: const Color(0xFF0B5D4B)),
      ),
    );
  }
}

/// Convenience function for main.dart.
///
/// Example:
/// runApp(
///   MaterialApp(
///     home: SafeNexusStep19Shell(
///       modules: [
///         SafeNexusModule(
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
Widget safeNexusStep19Home({
  List<SafeNexusModule> modules = const <SafeNexusModule>[],
}) {
  return SafeNexusStep19Shell(modules: modules);
}
