import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'guidelines.dart';
import 'hazard_report.dart';
import 'observation_history.dart';
import 'safety_observation.dart';

import 'models/reference_topic.dart';
import 'data/uae_general_guidelines.dart';
import 'data/abu_dhabi_guidelines.dart';
import 'data/dubai_guidelines.dart';
import 'data/hse_safety_reference.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    const SafeNexusApp(),
  );
}

// ============================================================
// APP
// ============================================================

class SafeNexusApp extends StatelessWidget {
  const SafeNexusApp({
    super.key,
  });

  static const Color primaryGreen = Color(0xFF159447);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SafeNexus HSE',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryGreen,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF6F8F7),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          toolbarHeight: 48,
        ),
        cardTheme: const CardThemeData(
          elevation: 0,
          margin: EdgeInsets.zero,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
      ),
      home: const SafeNexusHomePage(),
    );
  }
}

// ============================================================
// HOME PAGE
// ============================================================

class SafeNexusHomePage extends StatefulWidget {
  const SafeNexusHomePage({
    super.key,
  });

  @override
  State<SafeNexusHomePage> createState() =>
      _SafeNexusHomePageState();
}

class _SafeNexusHomePageState
    extends State<SafeNexusHomePage> {
  // ==========================================================
  // CONSTANTS
  // ==========================================================

  static const String _storageKey =
      'safenexus_observations';

  static const Color primaryGreen =
      Color(0xFF159447);

  static const Color darkGreen =
      Color(0xFF0B5D4B);

  // ==========================================================
  // DASHBOARD STATE
  // ==========================================================

  int _currentIndex = 0;

  int _totalReports = 0;
  int _observations = 0;
  int _hazards = 0;
  int _openReports = 0;

  bool _loadingStats = true;

  // ==========================================================
  // INIT
  // ==========================================================

  @override
  void initState() {
    super.initState();

    _loadDashboardStats();
  }

  // ==========================================================
  // REFERENCE COUNTS
  //
  // These are read directly from the existing data lists.
  // Nothing is hard-coded or deleted.
  // ==========================================================

  int get _uaeGeneralCount =>
      uaeGeneralGuidelines.length;

  int get _abuDhabiCount =>
      abuDhabiGuidelines.length;

  int get _dubaiCount =>
      dubaiGuidelines.length;

  int get _hseReferenceCount =>
      hseSafetyReferences.length;

  // ==========================================================
  // LOAD DASHBOARD STATS
  // ==========================================================

  Future<void> _loadDashboardStats() async {
    try {
      final prefs =
          await SharedPreferences.getInstance();

      final records =
          prefs.getStringList(_storageKey) ??
              <String>[];

      int total = 0;
      int observations = 0;
      int hazards = 0;
      int open = 0;

      for (final raw in records) {
        try {
          final decoded = jsonDecode(raw);

          if (decoded is! Map) {
            continue;
          }

          final report =
              Map<String, dynamic>.from(decoded);

          final id =
              _stringValue(report['id']);

          if (id.isEmpty) {
            continue;
          }

          total++;

          final type = _stringValue(
            report['reportType'],
          ).toLowerCase();

          if (type.contains('hazard')) {
            hazards++;
          } else {
            observations++;
          }

          final status = _stringValue(
            report['status'],
          ).toLowerCase();

          if (status.isEmpty ||
              status == 'open' ||
              status == 'pending' ||
              status == 'in progress') {
            open++;
          }
        } catch (_) {
          // Ignore corrupted records.
          continue;
        }
      }

      if (!mounted) {
        return;
      }

      setState(() {
        _totalReports = total;
        _observations = observations;
        _hazards = hazards;
        _openReports = open;
        _loadingStats = false;
      });
    } catch (_) {
      if (!mounted) {
        return;
      }

      setState(() {
        _totalReports = 0;
        _observations = 0;
        _hazards = 0;
        _openReports = 0;
        _loadingStats = false;
      });
    }
  }

  // ==========================================================
  // STRING VALUE
  // ==========================================================

  String _stringValue(dynamic value) {
    if (value == null) {
      return '';
    }

    return value.toString().trim();
  }

  // ==========================================================
  // REFRESH DASHBOARD
  // ==========================================================

  Future<void> _refreshDashboard() async {
    await _loadDashboardStats();
  }

  // ==========================================================
  // OPEN PAGE
  // ==========================================================

  Future<void> _openPage(Widget page) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => page,
      ),
    );

    await _loadDashboardStats();
  }

  // ==========================================================
  // OPEN GUIDELINE CATEGORY
  // ==========================================================

  Future<void> _openGuidelineCategory(
    GuidelineCategory category,
  ) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => GuidelinesPage(
          initialCategory: category,
        ),
      ),
    );

    if (!mounted) {
      return;
    }

    setState(() {});
  }

  // ==========================================================
  // NAVIGATION PAGES
  // ==========================================================

  List<Widget> get _pages {
    return [
      _buildDashboard(),
      const SafetyObservationPage(),
      const HazardReportPage(),
      const ObservationHistoryPage(),
    ];
  }

  // ==========================================================
  // BUILD
  // ==========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });

          if (index == 0) {
            _loadDashboardStats();
          }
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(
              Icons.dashboard_outlined,
            ),
            selectedIcon: Icon(
              Icons.dashboard_rounded,
            ),
            label: 'Dashboard',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.visibility_outlined,
            ),
            selectedIcon: Icon(
              Icons.visibility_rounded,
            ),
            label: 'Observation',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.warning_amber_outlined,
            ),
            selectedIcon: Icon(
              Icons.warning_rounded,
            ),
            label: 'Hazard',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.history_outlined,
            ),
            selectedIcon: Icon(
              Icons.history_rounded,
            ),
            label: 'History',
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // DASHBOARD
  // ==========================================================

  Widget _buildDashboard() {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: _refreshDashboard,
        child: ListView(
          physics:
              const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(
            16,
            8,
            16,
            32,
          ),
          children: [
            _buildDashboardHeader(),

            const SizedBox(height: 12),

            _buildWelcomeCard(),

            const SizedBox(height: 18),

            _buildStatsGrid(),

            const SizedBox(height: 22),

            _buildQuickActions(),

            const SizedBox(height: 22),

            // ==================================================
            // DIRECT HSE REFERENCE CATEGORIES
            // ==================================================

            _buildReferenceSection(),

            const SizedBox(height: 16),

            _buildUaeIdentityCard(),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // COMPACT HEADER
  // ==========================================================

  Widget _buildDashboardHeader() {
    return Row(
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: primaryGreen.withValues(
              alpha: 0.10,
            ),
            borderRadius:
                BorderRadius.circular(12),
          ),
          child: const Icon(
            Icons.health_and_safety_rounded,
            color: primaryGreen,
            size: 24,
          ),
        ),

        const SizedBox(width: 10),

        const Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                'SafeNexus HSE',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: darkGreen,
                ),
              ),
              SizedBox(height: 1),
              Text(
                'UAE HSE Safety Platform',
                style: TextStyle(
                  fontSize: 11,
                  color: Color(0xFF607D8B),
                ),
              ),
            ],
          ),
        ),

        IconButton(
          tooltip: 'Refresh',
          visualDensity:
              VisualDensity.compact,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(
            minWidth: 36,
            minHeight: 36,
          ),
          onPressed: _loadDashboardStats,
          icon: const Icon(
            Icons.refresh_rounded,
            size: 22,
          ),
        ),
      ],
    );
  }

  // ==========================================================
  // WELCOME CARD
  // ==========================================================

  Widget _buildWelcomeCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            primaryGreen,
            darkGreen,
          ],
        ),
        borderRadius:
            BorderRadius.circular(22),
      ),
      child: const Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome to SafeNexus HSE',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Your UAE-wide HSE safety companion for reporting, observations and safety reference.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // STATS GRID
  // ==========================================================

  Widget _buildStatsGrid() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics:
          const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.65,
      children: [
        _buildStatCard(
          title: 'Total Reports',
          value: _totalReports,
          icon: Icons.assessment_outlined,
        ),
        _buildStatCard(
          title: 'Observations',
          value: _observations,
          icon: Icons.visibility_outlined,
        ),
        _buildStatCard(
          title: 'Hazards',
          value: _hazards,
          icon: Icons.warning_amber_outlined,
        ),
        _buildStatCard(
          title: 'Open Reports',
          value: _openReports,
          icon: Icons.pending_actions_outlined,
        ),
      ],
    );
  }

  // ==========================================================
  // STAT CARD
  // ==========================================================

  Widget _buildStatCard({
    required String title,
    required int value,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: 0.04,
            ),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: primaryGreen.withValues(
                alpha: 0.10,
              ),
              borderRadius:
                  BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: primaryGreen,
            ),
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              mainAxisAlignment:
                  MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow:
                      TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF607D8B),
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  _loadingStats
                      ? '...'
                      : value.toString(),
                  style: const TextStyle(
                    fontSize: 21,
                    fontWeight:
                        FontWeight.bold,
                    color: darkGreen,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // QUICK ACTIONS
  // ==========================================================

  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        const Text(
          'Quick Actions',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: darkGreen,
          ),
        ),

        const SizedBox(height: 12),

        Row(
          children: [
            Expanded(
              child: _buildActionCard(
                title: 'Observation',
                subtitle: 'Report',
                icon:
                    Icons.visibility_rounded,
                onTap: () {
                  setState(() {
                    _currentIndex = 1;
                  });
                },
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: _buildActionCard(
                title: 'Hazard',
                subtitle: 'Report',
                icon:
                    Icons.warning_rounded,
                onTap: () {
                  setState(() {
                    _currentIndex = 2;
                  });
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ==========================================================
  // ACTION CARD
  // ==========================================================

  Widget _buildActionCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius:
          BorderRadius.circular(18),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.circular(18),
          border: Border.all(
            color: const Color(0xFFE1E8E5),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: primaryGreen.withValues(
                  alpha: 0.10,
                ),
                borderRadius:
                    BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: primaryGreen,
              ),
            ),

            const SizedBox(width: 10),

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight:
                          FontWeight.bold,
                      color: darkGreen,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFF607D8B),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // DIRECT HSE REFERENCE SECTION
  // ==========================================================

  Widget _buildReferenceSection() {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        const Text(
          'HSE Safety Reference',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: darkGreen,
          ),
        ),

        const SizedBox(height: 5),

        const Text(
          'Select a UAE safety reference category',
          style: TextStyle(
            fontSize: 12,
            color: Color(0xFF607D8B),
          ),
        ),

        const SizedBox(height: 12),

        // ------------------------------------------------------
        // UAE GENERAL
        // ------------------------------------------------------

        _buildReferenceTile(
          title: 'UAE General',
          count: _uaeGeneralCount,
          subtitle: 'UAE-wide HSE guidance',
          icon: Icons.flag_outlined,
          category:
              GuidelineCategory.uaeGeneral,
        ),

        const SizedBox(height: 10),

        // ------------------------------------------------------
        // ABU DHABI
        // ------------------------------------------------------

        _buildReferenceTile(
          title: 'Abu Dhabi',
          count: _abuDhabiCount,
          subtitle:
              'Abu Dhabi HSE requirements',
          icon:
              Icons.location_city_outlined,
          category:
              GuidelineCategory.abuDhabi,
        ),

        const SizedBox(height: 10),

        // ------------------------------------------------------
        // DUBAI
        // ------------------------------------------------------

        _buildReferenceTile(
          title: 'Dubai',
          count: _dubaiCount,
          subtitle:
              'Dubai HSE requirements',
          icon:
              Icons.apartment_outlined,
          category:
              GuidelineCategory.dubai,
        ),

        const SizedBox(height: 10),

        // ------------------------------------------------------
        // HSE REFERENCE
        // ------------------------------------------------------

        _buildReferenceTile(
          title: 'HSE Reference',
          count: _hseReferenceCount,
          subtitle:
              'Professional HSE reference topics',
          icon:
              Icons.menu_book_outlined,
          category:
              GuidelineCategory.hseReference,
        ),
      ],
    );
  }

  // ==========================================================
  // REFERENCE TILE
  // ==========================================================

  Widget _buildReferenceTile({
    required String title,
    required int count,
    required String subtitle,
    required IconData icon,
    required GuidelineCategory category,
  }) {
    return InkWell(
      borderRadius:
          BorderRadius.circular(18),
      onTap: () {
        _openGuidelineCategory(
          category,
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.circular(18),
          border: Border.all(
            color: const Color(0xFFDDE8E3),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(
                alpha: 0.035,
              ),
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            // --------------------------------------------------
            // ICON
            // --------------------------------------------------

            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: primaryGreen.withValues(
                  alpha: 0.10,
                ),
                borderRadius:
                    BorderRadius.circular(14),
              ),
              child: Icon(
                icon,
                color: primaryGreen,
                size: 26,
              ),
            ),

            const SizedBox(width: 13),

            // --------------------------------------------------
            // TEXT + COUNT
            // --------------------------------------------------

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style:
                              const TextStyle(
                            fontSize: 16,
                            fontWeight:
                                FontWeight.bold,
                            color: darkGreen,
                          ),
                        ),
                      ),

                      Container(
                        padding:
                            const EdgeInsets
                                .symmetric(
                          horizontal: 9,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color:
                              primaryGreen.withValues(
                            alpha: 0.10,
                          ),
                          borderRadius:
                              BorderRadius.circular(
                            20,
                          ),
                        ),
                        child: Text(
                          '$count',
                          style:
                              const TextStyle(
                            fontSize: 12,
                            fontWeight:
                                FontWeight.bold,
                            color: primaryGreen,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 3),

                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 11,
                      color:
                          Color(0xFF607D8B),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 7),

            // --------------------------------------------------
            // ARROW
            // --------------------------------------------------

            const Icon(
              Icons.chevron_right_rounded,
              color: primaryGreen,
              size: 27,
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // UAE IDENTITY CARD
  // ==========================================================

  Widget _buildUaeIdentityCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: darkGreen.withValues(
          alpha: 0.06,
        ),
        borderRadius:
            BorderRadius.circular(18),
      ),
      child: const Row(
        children: [
          Text(
            '🇦🇪',
            style: TextStyle(
              fontSize: 30,
            ),
          ),

          SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  'UAE-wide HSE Safety App',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight:
                        FontWeight.bold,
                    color: darkGreen,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  'Built for HSE professionals across the United Arab Emirates.',
                  style: TextStyle(
                    fontSize: 11,
                    height: 1.4,
                    color:
                        Color(0xFF607D8B),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
