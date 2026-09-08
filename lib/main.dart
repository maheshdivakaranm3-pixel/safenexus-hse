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
  runApp(const SafeNexusApp());
}

// ============================================================
// APP
// ============================================================

class SafeNexusApp extends StatelessWidget {
  const SafeNexusApp({super.key});

  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color background = Color(0xFFF7FAF8);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SafeNexus HSE',

      theme: ThemeData(
        useMaterial3: true,

        scaffoldBackgroundColor: background,

        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryGreen,
          brightness: Brightness.light,
        ),

        fontFamily: 'Roboto',

        navigationBarTheme: const NavigationBarThemeData(
          height: 82,
          backgroundColor: Color(0xFFF3F7F4),
          indicatorColor: Color(0xFFD6EDDD),
          labelTextStyle: WidgetStatePropertyAll(
            TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
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
  const SafeNexusHomePage({super.key});

  @override
  State<SafeNexusHomePage> createState() =>
      _SafeNexusHomePageState();
}

class _SafeNexusHomePageState
    extends State<SafeNexusHomePage> {
  // ==========================================================
  // COLORS
  // ==========================================================

  static const Color primaryGreen =
      Color(0xFF159447);

  static const Color darkGreen =
      Color(0xFF0B5D4B);

  static const Color lightGreen =
      Color(0xFFE8F5EC);

  static const Color secondaryText =
      Color(0xFF70838A);

  static const Color background =
      Color(0xFFF7FAF8);

  // ==========================================================
  // STORAGE
  // ==========================================================

  static const String _storageKey =
      'safenexus_observations';

  // ==========================================================
  // STATE
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
  // LOAD STATISTICS
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

          final type =
              _stringValue(
                report['reportType'],
              ).toLowerCase();

          if (type.contains('hazard')) {
            hazards++;
          } else {
            observations++;
          }

          final status =
              _stringValue(
                report['status'],
              ).toLowerCase();

          if (status.isEmpty ||
              status == 'open' ||
              status == 'pending' ||
              status == 'in progress') {
            open++;
          }
        } catch (_) {
          // Ignore invalid records.
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
  // REFRESH
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

    if (!mounted) {
      return;
    }

    await _loadDashboardStats();
  }

  // ==========================================================
  // OPEN GUIDELINES
  // ==========================================================

  Future<void> _openGuidelineCategory(
    GuidelineCategory category,
  ) async {
    await _openPage(
      GuidelinesPage(
        initialCategory: category,
      ),
    );
  }

  // ==========================================================
  // PAGES
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

      bottomNavigationBar:
          _buildBottomNavigation(),
    );
  }

  // ==========================================================
  // BOTTOM NAVIGATION
  // ==========================================================

  Widget _buildBottomNavigation() {
    return NavigationBar(
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
    );
  }

  // ==========================================================
  // DASHBOARD
  // ==========================================================

  Widget _buildDashboard() {
    return SafeArea(
      child: RefreshIndicator(
        color: primaryGreen,

        onRefresh: _refreshDashboard,

        child: ListView(
          physics:
              const AlwaysScrollableScrollPhysics(),

          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 12,
            bottom: 28,
          ),

          children: [
            _buildHeader(),

            const SizedBox(height: 20),

            _buildStatsGrid(),

            const SizedBox(height: 30),

            _buildQuickActions(),

            const SizedBox(height: 30),

            _buildReferenceSection(),

            const SizedBox(height: 22),

            _buildUaeIdentityCard(),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // HEADER
  // ==========================================================

  Widget _buildHeader() {
    return Row(
      children: [
        // ------------------------------------------------------
        // LOGO
        // ------------------------------------------------------

        Container(
          width: 52,
          height: 52,

          decoration: BoxDecoration(
            color: lightGreen,
            borderRadius:
                BorderRadius.circular(17),
          ),

          child: const Icon(
            Icons.shield_rounded,
            color: primaryGreen,
            size: 30,
          ),
        ),

        const SizedBox(width: 13),

        // ------------------------------------------------------
        // TITLE
        // ------------------------------------------------------

        const Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [
              Text(
                'SafeNexus HSE',

                style: TextStyle(
                  fontSize: 21,
                  fontWeight:
                      FontWeight.w800,
                  color: darkGreen,
                ),
              ),

              SizedBox(height: 2),

              Text(
                'UAE HSE Safety Dashboard',

                style: TextStyle(
                  fontSize: 12,
                  color: secondaryText,
                  fontWeight:
                      FontWeight.w400,
                ),
              ),
            ],
          ),
        ),

        // ------------------------------------------------------
        // UAE
        // ------------------------------------------------------

        Container(
          padding:
              const EdgeInsets.symmetric(
            horizontal: 11,
            vertical: 8,
          ),

          decoration: BoxDecoration(
            color: Colors.white,

            borderRadius:
                BorderRadius.circular(16),

            border: Border.all(
              color: const Color(
                0xFFE0E9E4,
              ),
            ),
          ),

          child: const Text(
            '🇦🇪 UAE',

            style: TextStyle(
              fontSize: 12,
              fontWeight:
                  FontWeight.w700,
              color: darkGreen,
            ),
          ),
        ),
      ],
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

      crossAxisSpacing: 14,

      mainAxisSpacing: 14,

      childAspectRatio: 1.43,

      children: [
        _buildStatCard(
          title: 'Total Reports',
          value: _totalReports,
          icon:
              Icons.insert_chart_outlined_rounded,
        ),

        _buildStatCard(
          title: 'Observations',
          value: _observations,
          icon:
              Icons.visibility_rounded,
        ),

        _buildStatCard(
          title: 'Hazards',
          value: _hazards,
          icon:
              Icons.warning_amber_rounded,
        ),

        _buildStatCard(
          title: 'Open Reports',
          value: _openReports,
          icon:
              Icons.pending_actions_rounded,
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
      padding:
          const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
            BorderRadius.circular(24),

        border: Border.all(
          color:
              const Color(0xFFE8EFEB),
        ),

        boxShadow: [
          BoxShadow(
            color: Colors.black
                .withValues(alpha: 0.025),

            blurRadius: 15,

            offset:
                const Offset(0, 5),
          ),
        ],
      ),

      child: Row(
        children: [
          Container(
            width: 51,
            height: 51,

            decoration: BoxDecoration(
              color: lightGreen,

              borderRadius:
                  BorderRadius.circular(16),
            ),

            child: Icon(
              icon,
              color: primaryGreen,
              size: 28,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center,

              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                Text(
                  title,

                  maxLines: 1,

                  overflow:
                      TextOverflow.ellipsis,

                  style: const TextStyle(
                    fontSize: 12,
                    color: secondaryText,
                    fontWeight:
                        FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  _loadingStats
                      ? '...'
                      : '$value',

                  style: const TextStyle(
                    fontSize: 27,
                    height: 1,
                    fontWeight:
                        FontWeight.w800,
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
            fontSize: 25,
            fontWeight:
                FontWeight.w800,
            color: darkGreen,
          ),
        ),

        const SizedBox(height: 6),

        const Text(
          'Create a new safety report',

          style: TextStyle(
            fontSize: 13,
            color: secondaryText,
          ),
        ),

        const SizedBox(height: 16),

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

            const SizedBox(width: 14),

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
    return Material(
      color: Colors.transparent,

      child: InkWell(
        borderRadius:
            BorderRadius.circular(24),

        onTap: onTap,

        child: Container(
          height: 145,

          padding:
              const EdgeInsets.all(16),

          decoration: BoxDecoration(
            color: Colors.white,

            borderRadius:
                BorderRadius.circular(24),

            border: Border.all(
              color:
                  const Color(0xFFDDE7E2),
            ),

            boxShadow: [
              BoxShadow(
                color: Colors.black
                    .withValues(alpha: 0.025),

                blurRadius: 12,

                offset:
                    const Offset(0, 4),
              ),
            ],
          ),

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [
              Container(
                width: 58,
                height: 58,

                decoration: BoxDecoration(
                  color: lightGreen,

                  borderRadius:
                      BorderRadius.circular(18),
                ),

                child: Icon(
                  icon,
                  color: primaryGreen,
                  size: 32,
                ),
              ),

              const Spacer(),

              Text(
                title,

                maxLines: 1,

                overflow:
                    TextOverflow.ellipsis,

                style: const TextStyle(
                  fontSize: 18,
                  fontWeight:
                      FontWeight.w800,
                  color: darkGreen,
                ),
              ),

              const SizedBox(height: 2),

              Text(
                subtitle,

                style: const TextStyle(
                  fontSize: 13,
                  color: secondaryText,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // HSE REFERENCE SECTION
  // ==========================================================

  Widget _buildReferenceSection() {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,

      children: [
        const Text(
          'HSE Safety Reference',

          style: TextStyle(
            fontSize: 25,
            fontWeight:
                FontWeight.w800,
            color: darkGreen,
          ),
        ),

        const SizedBox(height: 5),

        const Text(
          'Select a UAE safety reference category',

          style: TextStyle(
            fontSize: 13,
            color: secondaryText,
          ),
        ),

        const SizedBox(height: 16),

        _buildReferenceTile(
          title: 'UAE General',
          count: _uaeGeneralCount,
          subtitle:
              'UAE-wide HSE guidance',
          icon:
              Icons.flag_rounded,
          category:
              GuidelineCategory.uaeGeneral,
        ),

        const SizedBox(height: 12),

        _buildReferenceTile(
          title: 'Abu Dhabi',
          count: _abuDhabiCount,
          subtitle:
              'Abu Dhabi HSE requirements',
          icon:
              Icons.location_city_rounded,
          category:
              GuidelineCategory.abuDhabi,
        ),

        const SizedBox(height: 12),

        _buildReferenceTile(
          title: 'Dubai',
          count: _dubaiCount,
          subtitle:
              'Dubai HSE requirements',
          icon:
              Icons.apartment_rounded,
          category:
              GuidelineCategory.dubai,
        ),

        const SizedBox(height: 12),

        _buildReferenceTile(
          title: 'HSE Reference',
          count: _hseReferenceCount,
          subtitle:
              'Professional HSE reference topics',
          icon:
              Icons.menu_book_rounded,
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
    return Material(
      color: Colors.transparent,

      child: InkWell(
        borderRadius:
            BorderRadius.circular(24),

        onTap: () {
          _openGuidelineCategory(
            category,
          );
        },

        child: Container(
          width: double.infinity,

          constraints:
              const BoxConstraints(
            minHeight: 118,
          ),

          padding:
              const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 15,
          ),

          decoration: BoxDecoration(
            color: Colors.white,

            borderRadius:
                BorderRadius.circular(24),

            border: Border.all(
              color:
                  const Color(0xFFDDE7E2),
            ),

            boxShadow: [
              BoxShadow(
                color: Colors.black
                    .withValues(alpha: 0.025),

                blurRadius: 11,

                offset:
                    const Offset(0, 4),
              ),
            ],
          ),

          child: Row(
            children: [
              // ------------------------------------------------
              // ICON
              // ------------------------------------------------

              Container(
                width: 62,
                height: 62,

                decoration: BoxDecoration(
                  color: lightGreen,

                  borderRadius:
                      BorderRadius.circular(18),
                ),

                child: Icon(
                  icon,
                  color: primaryGreen,
                  size: 32,
                ),
              ),

              const SizedBox(width: 14),

              // ------------------------------------------------
              // CONTENT
              // ------------------------------------------------

              Expanded(
                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.center,

                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            title,

                            maxLines: 1,

                            overflow:
                                TextOverflow.ellipsis,

                            style:
                                const TextStyle(
                              fontSize: 18,
                              fontWeight:
                                  FontWeight.w800,
                              color: darkGreen,
                            ),
                          ),
                        ),

                        const SizedBox(
                          width: 8,
                        ),

                        Container(
                          constraints:
                              const BoxConstraints(
                            minWidth: 48,
                          ),

                          padding:
                              const EdgeInsets
                                  .symmetric(
                            horizontal: 10,
                            vertical: 7,
                          ),

                          decoration:
                              BoxDecoration(
                            color: lightGreen,

                            borderRadius:
                                BorderRadius
                                    .circular(20),
                          ),

                          child: Text(
                            '$count',

                            textAlign:
                                TextAlign.center,

                            style:
                                const TextStyle(
                              fontSize: 14,
                              fontWeight:
                                  FontWeight.w800,
                              color:
                                  primaryGreen,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 5),

                    Text(
                      subtitle,

                      maxLines: 1,

                      overflow:
                          TextOverflow.ellipsis,

                      style:
                          const TextStyle(
                        fontSize: 13,
                        color: secondaryText,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 7),

              const Icon(
                Icons.chevron_right_rounded,
                color: primaryGreen,
                size: 32,
              ),
            ],
          ),
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

      padding:
          const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: darkGreen.withValues(
          alpha: 0.055,
        ),

        borderRadius:
            BorderRadius.circular(24),

        border: Border.all(
          color:
              darkGreen.withValues(
            alpha: 0.08,
          ),
        ),
      ),

      child: Row(
        children: [
          // ----------------------------------------------------
          // FLAG
          // ----------------------------------------------------

          Container(
            width: 55,
            height: 55,

            alignment:
                Alignment.center,

            decoration: BoxDecoration(
              color: Colors.white,

              borderRadius:
                  BorderRadius.circular(17),
            ),

            child: const Text(
              '🇦🇪',

              style: TextStyle(
                fontSize: 30,
              ),
            ),
          ),

          const SizedBox(width: 14),

          // ----------------------------------------------------
          // TEXT
          // ----------------------------------------------------

          const Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                Text(
                  'UAE-wide HSE Safety App',

                  style: TextStyle(
                    fontSize: 17,
                    fontWeight:
                        FontWeight.w800,
                    color: darkGreen,
                  ),
                ),

                SizedBox(height: 4),

                Text(
                  'Built for HSE professionals across the United Arab Emirates.',

                  maxLines: 2,

                  overflow:
                      TextOverflow.ellipsis,

                  style: TextStyle(
                    fontSize: 12,
                    height: 1.4,
                    color: secondaryText,
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
