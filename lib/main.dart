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
  static const Color darkGreen = Color(0xFF0B5D4B);

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

        scaffoldBackgroundColor:
            const Color(0xFFF6F9F7),

        navigationBarTheme:
            const NavigationBarThemeData(
          height: 82,
          backgroundColor:
              Color(0xFFF0F4EF),
          indicatorColor:
              Color(0xFFD4ECD9),
          labelTextStyle:
              WidgetStatePropertyAll(
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
  // COLORS
  // ==========================================================

  static const Color primaryGreen =
      Color(0xFF159447);

  static const Color darkGreen =
      Color(0xFF0B5D4B);

  static const Color secondaryText =
      Color(0xFF70838A);

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

  int get _uaeGeneralCount {
    return uaeGeneralGuidelines.length;
  }

  int get _abuDhabiCount {
    return abuDhabiGuidelines.length;
  }

  int get _dubaiCount {
    return dubaiGuidelines.length;
  }

  int get _hseReferenceCount {
    return hseSafetyReferences.length;
  }

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

    if (!mounted) {
      return;
    }

    setState(() {});
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
  // OPEN GUIDELINE CATEGORY
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
          NavigationBar(
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
        color: primaryGreen,

        onRefresh: _refreshDashboard,

        child: ListView(
          physics:
              const AlwaysScrollableScrollPhysics(),

          padding:
              const EdgeInsets.fromLTRB(
            16,
            16,
            16,
            28,
          ),

          children: [
            // ==================================================
            // STATISTICS
            // ==================================================

            _buildStatsGrid(),

            const SizedBox(height: 28),

            // ==================================================
            // QUICK ACTIONS
            // ==================================================

            _buildQuickActions(),

            const SizedBox(height: 28),

            // ==================================================
            // HSE REFERENCE
            // ==================================================

            _buildReferenceSection(),

            const SizedBox(height: 18),

            // ==================================================
            // UAE CARD
            // ==================================================

            _buildUaeIdentityCard(),
          ],
        ),
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

      childAspectRatio: 1.48,

      children: [
        _buildStatCard(
          title: 'Total Reports',
          value: _totalReports,
          icon: Icons
              .insert_chart_outlined_rounded,
        ),

        _buildStatCard(
          title: 'Observations',
          value: _observations,
          icon: Icons.visibility_rounded,
        ),

        _buildStatCard(
          title: 'Hazards',
          value: _hazards,
          icon: Icons.warning_amber_rounded,
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
          const EdgeInsets.all(15),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
            BorderRadius.circular(22),

        boxShadow: [
          BoxShadow(
            color: Colors.black
                .withValues(alpha: 0.035),

            blurRadius: 12,

            offset:
                const Offset(0, 4),
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
              color: primaryGreen
                  .withValues(alpha: 0.10),

              borderRadius:
                  BorderRadius.circular(15),
            ),

            child: Icon(
              icon,
              color: primaryGreen,
              size: 28,
            ),
          ),

          const SizedBox(width: 12),

          // --------------------------------------------------
          // TEXT
          // --------------------------------------------------

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

                  style:
                      const TextStyle(
                    fontSize: 12,
                    color: secondaryText,
                    fontWeight:
                        FontWeight.w400,
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  _loadingStats
                      ? '...'
                      : value.toString(),

                  style:
                      const TextStyle(
                    fontSize: 25,
                    fontWeight:
                        FontWeight.w700,
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
            fontSize: 23,
            fontWeight:
                FontWeight.w800,
            color: darkGreen,
          ),
        ),

        const SizedBox(height: 13),

        Row(
          children: [
            // ------------------------------------------------
            // OBSERVATION
            // ------------------------------------------------

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

            // ------------------------------------------------
            // HAZARD
            // ------------------------------------------------

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
            BorderRadius.circular(22),

        onTap: onTap,

        child: Container(
          height: 140,

          padding:
              const EdgeInsets.all(15),

          decoration: BoxDecoration(
            color: Colors.white,

            borderRadius:
                BorderRadius.circular(22),

            border: Border.all(
              color:
                  const Color(0xFFE0E8E4),
            ),

            boxShadow: [
              BoxShadow(
                color: Colors.black
                    .withValues(alpha: 0.025),

                blurRadius: 8,

                offset:
                    const Offset(0, 3),
              ),
            ],
          ),

          child: Row(
            children: [
              // ------------------------------------------------
              // ICON
              // ------------------------------------------------

              Container(
                width: 56,
                height: 56,

                decoration: BoxDecoration(
                  color: primaryGreen
                      .withValues(alpha: 0.10),

                  borderRadius:
                      BorderRadius.circular(16),
                ),

                child: Icon(
                  icon,
                  color: primaryGreen,
                  size: 31,
                ),
              ),

              const SizedBox(width: 12),

              // ------------------------------------------------
              // TEXT
              // ------------------------------------------------

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

                      style:
                          const TextStyle(
                        fontSize: 17,
                        fontWeight:
                            FontWeight.w800,
                        color: darkGreen,
                      ),
                    ),

                    const SizedBox(height: 3),

                    Text(
                      subtitle,

                      style:
                          const TextStyle(
                        fontSize: 13,
                        color: secondaryText,
                      ),
                    ),
                  ],
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
            fontSize: 23,
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

        const SizedBox(height: 14),

        // ------------------------------------------------------
        // UAE GENERAL
        // ------------------------------------------------------

        _buildReferenceTile(
          title: 'UAE General',

          count:
              _uaeGeneralCount,

          subtitle:
              'UAE-wide HSE guidance',

          icon:
              Icons.flag_outlined,

          category:
              GuidelineCategory.uaeGeneral,
        ),

        const SizedBox(height: 10),

        // ------------------------------------------------------
        // ABU DHABI
        // ------------------------------------------------------

        _buildReferenceTile(
          title: 'Abu Dhabi',

          count:
              _abuDhabiCount,

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

          count:
              _dubaiCount,

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

          count:
              _hseReferenceCount,

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
    return Material(
      color: Colors.transparent,

      child: InkWell(
        borderRadius:
            BorderRadius.circular(22),

        onTap: () {
          _openGuidelineCategory(
            category,
          );
        },

        child: Container(
          width: double.infinity,

          height: 118,

          padding:
              const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 14,
          ),

          decoration: BoxDecoration(
            color: Colors.white,

            borderRadius:
                BorderRadius.circular(22),

            border: Border.all(
              color:
                  const Color(0xFFDDE7E2),
            ),

            boxShadow: [
              BoxShadow(
                color: Colors.black
                    .withValues(alpha: 0.035),

                blurRadius: 9,

                offset:
                    const Offset(0, 3),
              ),
            ],
          ),

          child: Row(
            children: [
              // ------------------------------------------------
              // ICON BOX
              // ------------------------------------------------

              Container(
                width: 60,
                height: 60,

                decoration: BoxDecoration(
                  color: primaryGreen
                      .withValues(alpha: 0.10),

                  borderRadius:
                      BorderRadius.circular(16),
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

                        // --------------------------------------
                        // COUNT
                        // --------------------------------------

                        Container(
                          padding:
                              const EdgeInsets
                                  .symmetric(
                            horizontal: 12,
                            vertical: 7,
                          ),

                          decoration:
                              BoxDecoration(
                            color: primaryGreen
                                .withValues(
                              alpha: 0.10,
                            ),

                            borderRadius:
                                BorderRadius
                                    .circular(22),
                          ),

                          child: Text(
                            '$count',

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

              const SizedBox(width: 8),

              // ------------------------------------------------
              // ARROW
              // ------------------------------------------------

              const Icon(
                Icons.chevron_right_rounded,

                color: primaryGreen,

                size: 31,
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
          alpha: 0.06,
        ),

        borderRadius:
            BorderRadius.circular(22),
      ),

      child: Row(
        children: [
          // ----------------------------------------------------
          // UAE FLAG
          // ----------------------------------------------------

          const Text(
            '🇦🇪',

            style: TextStyle(
              fontSize: 34,
            ),
          ),

          const SizedBox(width: 13),

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
