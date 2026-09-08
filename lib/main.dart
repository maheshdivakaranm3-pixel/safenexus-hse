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
        scaffoldBackgroundColor: const Color(0xFFF4F8F6),
        navigationBarTheme: const NavigationBarThemeData(
          height: 82,
          backgroundColor: Color(0xFFF0F5F2),
          indicatorColor: Color(0xFFD7EFDF),
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

class _SafeNexusHomePageState extends State<SafeNexusHomePage> {
  // ==========================================================
  // COLORS
  // ==========================================================

  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color textGrey = Color(0xFF607D8B);

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
  // STRING
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
  // GUIDELINE CATEGORY
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
          padding: const EdgeInsets.fromLTRB(
            16,
            12,
            16,
            28,
          ),
          children: [
            _buildHeader(),

            const SizedBox(height: 14),

            _buildHero(),

            const SizedBox(height: 18),

            _buildStats(),

            const SizedBox(height: 24),

            _buildQuickActions(),

            const SizedBox(height: 26),

            _buildReferenceSection(),

            const SizedBox(height: 18),

            _buildUaeCard(),
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
        // MENU
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: const Color(0xFFEAF2EF),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.menu_rounded,
            color: Color(0xFF263238),
            size: 28,
          ),
        ),

        const SizedBox(width: 10),

        // SHIELD
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: const Color(0xFFE2F4E9),
            borderRadius:
                BorderRadius.circular(16),
          ),
          child: const Icon(
            Icons.shield_rounded,
            color: primaryGreen,
            size: 34,
          ),
        ),

        const SizedBox(width: 10),

        // BRAND
        const Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'SafeNexus ',
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight:
                            FontWeight.w800,
                        color: darkGreen,
                      ),
                    ),
                    TextSpan(
                      text: 'HSE',
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight:
                            FontWeight.w800,
                        color: primaryGreen,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 1),
              Text(
                'Together for a Safer UAE',
                style: TextStyle(
                  fontSize: 11,
                  color: textGrey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),

        // NOTIFICATION
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: Stack(
            children: [
              const Center(
                child: Icon(
                  Icons.notifications_none_rounded,
                  size: 28,
                  color: Color(0xFF263238),
                ),
              ),
              Positioned(
                right: 10,
                top: 8,
                child: Container(
                  width: 9,
                  height: 9,
                  decoration:
                      const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ==========================================================
  // HERO
  // ==========================================================

  Widget _buildHero() {
    return Container(
      height: 265,
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.circular(25),
        gradient:
            const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFE3F5EC),
            Color(0xFFEAF5F2),
            Color(0xFFDDECEF),
          ],
        ),
      ),
      child: Stack(
        children: [
          // SKYLINE
          Positioned(
            right: -5,
            bottom: 0,
            child: _buildSkyline(),
          ),

          // GREEN DECORATION
          Positioned(
            right: -80,
            top: -70,
            child: Container(
              width: 210,
              height: 210,
              decoration: BoxDecoration(
                color: primaryGreen
                    .withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
            ),
          ),

          // UAE FLAG
          Positioned(
            right: 20,
            top: 25,
            child: const Text(
              '🇦🇪',
              style: TextStyle(
                fontSize: 45,
              ),
            ),
          ),

          // SAFETY ICON
          Positioned(
            right: 25,
            bottom: 62,
            child: Container(
              width: 65,
              height: 65,
              decoration: BoxDecoration(
                color: Colors.white
                    .withValues(alpha: 0.82),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.health_and_safety_rounded,
                color: primaryGreen,
                size: 38,
              ),
            ),
          ),

          // TEXT
          const Positioned(
            left: 20,
            top: 25,
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  'Safe People',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight:
                        FontWeight.w800,
                    color: darkGreen,
                  ),
                ),
                Text(
                  'Safe Workplaces',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight:
                        FontWeight.w800,
                    color: darkGreen,
                  ),
                ),
                Text(
                  'A Stronger UAE',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight:
                        FontWeight.w800,
                    color: darkGreen,
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: 58,
                  child: Divider(
                    thickness: 4,
                    color: primaryGreen,
                    height: 4,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Report  •  Prevent  •  Build a Safer Tomorrow',
                  style: TextStyle(
                    fontSize: 11.5,
                    fontWeight:
                        FontWeight.w600,
                    color: Color(0xFF315B56),
                  ),
                ),
              ],
            ),
          ),

          // BOTTOM FEATURES
          Positioned(
            left: 18,
            right: 18,
            bottom: 13,
            child: Row(
              children: [
                Expanded(
                  child: _heroFeature(
                    Icons.eco_rounded,
                    'Safer',
                    'Workplaces',
                  ),
                ),
                Expanded(
                  child: _heroFeature(
                    Icons.groups_rounded,
                    'Healthier',
                    'Communities',
                  ),
                ),
                Expanded(
                  child: _heroFeature(
                    Icons.verified_user_rounded,
                    'Stronger',
                    'UAE',
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
  // HERO FEATURE
  // ==========================================================

  Widget _heroFeature(
    IconData icon,
    String first,
    String second,
  ) {
    return Row(
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: Colors.white
                .withValues(alpha: 0.75),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: 21,
            color: darkGreen,
          ),
        ),
        const SizedBox(width: 6),
        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                first,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight:
                      FontWeight.w700,
                  color: darkGreen,
                ),
              ),
              Text(
                second,
                style: const TextStyle(
                  fontSize: 10,
                  color: darkGreen,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ==========================================================
  // SKYLINE
  // ==========================================================

  Widget _buildSkyline() {
    final buildings = [
      50.0,
      85.0,
      45.0,
      125.0,
      62.0,
      75.0,
      100.0,
      58.0,
      90.0,
    ];

    return SizedBox(
      width: 260,
      height: 155,
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.end,
        mainAxisAlignment:
            MainAxisAlignment.end,
        children: buildings.map(
          (height) {
            return Container(
              width: 24,
              height: height,
              margin:
                  const EdgeInsets.only(left: 4),
              decoration: BoxDecoration(
                color: darkGreen
                    .withValues(alpha: 0.10),
                borderRadius:
                    const BorderRadius.vertical(
                  top: Radius.circular(3),
                ),
              ),
            );
          },
        ).toList(),
      ),
    );
  }

  // ==========================================================
  // STATS
  // ==========================================================

  Widget _buildStats() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics:
          const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.55,
      children: [
        _statCard(
          'Total Reports',
          _totalReports,
          Icons.bar_chart_rounded,
          primaryGreen,
          const Color(0xFFF0FAF4),
        ),
        _statCard(
          'Observations',
          _observations,
          Icons.visibility_rounded,
          const Color(0xFF1475D1),
          const Color(0xFFF0F7FF),
        ),
        _statCard(
          'Hazards',
          _hazards,
          Icons.warning_rounded,
          const Color(0xFFE53935),
          const Color(0xFFFFF0F1),
        ),
        _statCard(
          'Open Reports',
          _openReports,
          Icons.pending_actions_rounded,
          const Color(0xFFD47A00),
          const Color(0xFFFFF7EA),
        ),
      ],
    );
  }

  // ==========================================================
  // STAT CARD
  // ==========================================================

  Widget _statCard(
    String title,
    int value,
    IconData icon,
    Color iconColor,
    Color background,
  ) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(21),
        boxShadow: [
          BoxShadow(
            color: Colors.black
                .withValues(alpha: 0.035),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: background,
              borderRadius:
                  BorderRadius.circular(15),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 28,
            ),
          ),
          const Spacer(),
          Text(
            title,
            maxLines: 1,
            overflow:
                TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 12,
              color: textGrey,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            _loadingStats
                ? '...'
                : value.toString(),
            style: const TextStyle(
              fontSize: 25,
              fontWeight:
                  FontWeight.w800,
              color: darkGreen,
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
        Row(
          children: [
            Container(
              width: 5,
              height: 28,
              decoration: BoxDecoration(
                color: primaryGreen,
                borderRadius:
                    BorderRadius.circular(8),
              ),
            ),
            const SizedBox(width: 10),
            const Expanded(
              child: Text(
                'Quick Actions',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight:
                      FontWeight.w800,
                  color: Color(0xFF151A18),
                ),
              ),
            ),
            const Text(
              'Take action for a safer workplace',
              style: TextStyle(
                fontSize: 10,
                color: textGrey,
              ),
            ),
          ],
        ),

        const SizedBox(height: 13),

        Row(
          children: [
            Expanded(
              child: _actionCard(
                title: 'Observation',
                subtitle: 'Report',
                description:
                    'Report safe or unsafe conditions',
                icon: Icons.visibility_rounded,
                background:
                    const Color(0xFF079447),
                onTap: () {
                  setState(() {
                    _currentIndex = 1;
                  });
                },
              ),
            ),

            const SizedBox(width: 10),

            Expanded(
              child: _actionCard(
                title: 'Hazard',
                subtitle: 'Report',
                description:
                    'Report hazards and risks',
                icon: Icons.warning_rounded,
                background:
                    const Color(0xFFE32F3B),
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

  Widget _actionCard({
    required String title,
    required String subtitle,
    required String description,
    required IconData icon,
    required Color background,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius:
            BorderRadius.circular(21),
        onTap: onTap,
        child: Container(
          height: 158,
          padding:
              const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient:
                LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                background,
                Color.lerp(
                  background,
                  Colors.black,
                  0.10,
                )!,
              ],
            ),
            borderRadius:
                BorderRadius.circular(21),
            boxShadow: [
              BoxShadow(
                color: background
                    .withValues(alpha: 0.20),
                blurRadius: 10,
                offset:
                    const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  color: Colors.white
                      .withValues(alpha: 0.20),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 31,
                ),
              ),

              const Spacer(),

              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight:
                      FontWeight.w800,
                ),
              ),

              Text(
                subtitle,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                description,
                maxLines: 2,
                overflow:
                    TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10.5,
                  height: 1.25,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // REFERENCE SECTION
  // ==========================================================

  Widget _buildReferenceSection() {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 5,
              height: 28,
              decoration: BoxDecoration(
                color: primaryGreen,
                borderRadius:
                    BorderRadius.circular(8),
              ),
            ),
            const SizedBox(width: 10),
            const Expanded(
              child: Text(
                'HSE Safety Reference',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight:
                      FontWeight.w800,
                  color: Color(0xFF151A18),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 5),

        const Text(
          'Select a UAE safety reference category',
          style: TextStyle(
            fontSize: 11.5,
            color: textGrey,
          ),
        ),

        const SizedBox(height: 13),

        _referenceTile(
          title: 'UAE General',
          subtitle: 'UAE-wide HSE guidance',
          count: _uaeGeneralCount,
          icon: Icons.flag_rounded,
          iconColor: primaryGreen,
          background:
              const Color(0xFFF4FBF7),
          category:
              GuidelineCategory.uaeGeneral,
        ),

        const SizedBox(height: 10),

        _referenceTile(
          title: 'Abu Dhabi',
          subtitle:
              'Abu Dhabi HSE requirements',
          count: _abuDhabiCount,
          icon: Icons.location_city_rounded,
          iconColor:
              const Color(0xFF1976D2),
          background:
              const Color(0xFFF3F8FE),
          category:
              GuidelineCategory.abuDhabi,
        ),

        const SizedBox(height: 10),

        _referenceTile(
          title: 'Dubai',
          subtitle:
              'Dubai HSE requirements',
          count: _dubaiCount,
          icon: Icons.apartment_rounded,
          iconColor:
              const Color(0xFFD57900),
          background:
              const Color(0xFFFFF9F0),
          category:
              GuidelineCategory.dubai,
        ),

        const SizedBox(height: 10),

        _referenceTile(
          title: 'HSE Reference',
          subtitle:
              'Professional HSE reference topics',
          count: _hseReferenceCount,
          icon: Icons.menu_book_rounded,
          iconColor:
              const Color(0xFF6338B8),
          background:
              const Color(0xFFF8F3FF),
          category:
              GuidelineCategory.hseReference,
        ),
      ],
    );
  }

  // ==========================================================
  // REFERENCE TILE
  // ==========================================================

  Widget _referenceTile({
    required String title,
    required String subtitle,
    required int count,
    required IconData icon,
    required Color iconColor,
    required Color background,
    required GuidelineCategory category,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius:
            BorderRadius.circular(19),
        onTap: () {
          _openGuidelineCategory(
            category,
          );
        },
        child: Container(
          height: 105,
          padding:
              const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 12,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius:
                BorderRadius.circular(19),
            border: Border.all(
              color: const Color(0xFFE1EAE5),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black
                    .withValues(alpha: 0.03),
                blurRadius: 9,
                offset:
                    const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: background,
                  borderRadius:
                      BorderRadius.circular(16),
                ),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 31,
                ),
              ),

              const SizedBox(width: 13),

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
                              fontSize: 16,
                              fontWeight:
                                  FontWeight.w800,
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
                          decoration:
                              BoxDecoration(
                            color: background,
                            borderRadius:
                                BorderRadius
                                    .circular(18),
                          ),
                          child: Text(
                            '$count',
                            style: TextStyle(
                              color: iconColor,
                              fontSize: 12,
                              fontWeight:
                                  FontWeight.w800,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      maxLines: 1,
                      overflow:
                          TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 11,
                        color: textGrey,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 7),

              Icon(
                Icons.arrow_forward_ios_rounded,
                color: iconColor,
                size: 19,
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

  Widget _buildUaeCard() {
    return Container(
      width: double.infinity,
      padding:
          const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient:
            const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0xFFE8F4EF),
            Color(0xFFF1F7F4),
          ],
        ),
        borderRadius:
            BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          Container(
            width: 62,
            height: 62,
            decoration: BoxDecoration(
              color: Colors.white
                  .withValues(alpha: 0.8),
              borderRadius:
                  BorderRadius.circular(16),
            ),
            child: const Center(
              child: Text(
                '🇦🇪',
                style: TextStyle(
                  fontSize: 35,
                ),
              ),
            ),
          ),

          const SizedBox(width: 13),

          const Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  'UAE-wide HSE Safety App',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight:
                        FontWeight.w800,
                    color: darkGreen,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Built for HSE professionals across the United Arab Emirates.',
                  style: TextStyle(
                    fontSize: 11.5,
                    height: 1.4,
                    color: textGrey,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          const Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                'SAFER',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight:
                      FontWeight.w800,
                  color: darkGreen,
                ),
              ),
              Text(
                'PEOPLE',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight:
                      FontWeight.w800,
                  color: darkGreen,
                ),
              ),
              Text(
                'STRONGER',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight:
                      FontWeight.w800,
                  color: darkGreen,
                ),
              ),
              Text(
                'UAE',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight:
                      FontWeight.w800,
                  color: primaryGreen,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
