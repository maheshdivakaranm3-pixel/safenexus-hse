import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'guidelines.dart';
import 'hazard_report.dart';
import 'observation_history.dart';
import 'safety_observation.dart';
import 'models/guideline_category.dart';

import 'data/abu_dhabi_guidelines.dart';
import 'data/dubai_guidelines.dart';
import 'data/hse_safety_reference.dart';
import 'data/uae_general_guidelines.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const SafeNexusApp());
}

// ============================================================
// SAFE NEXUS APP
// ============================================================

class SafeNexusApp extends StatelessWidget {
  const SafeNexusApp({super.key});

  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF075B45);
  static const Color navy = Color(0xFF082653);

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
        scaffoldBackgroundColor: const Color(0xFFF4F8FB),
        fontFamily: 'Roboto',
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
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
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF075B45);
  static const Color navy = Color(0xFF082653);

  static const String _storageKey =
      'safenexus_observations';

  int _currentIndex = 0;

  int _totalReports = 0;
  int _observations = 0;
  int _hazards = 0;
  int _openReports = 0;

  bool _loadingStats = true;

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
  // DASHBOARD DATA
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

      final List<String> normalizedRecords =
          <String>[];

      bool storageChanged = false;

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

          final originalType =
              _stringValue(report['reportType']);

          final observationType =
              _stringValue(
            report['observationType'],
          );

          final canonicalType =
              _canonicalReportType(
            reportType: originalType,
            observationType: observationType,
          );

          if (originalType != canonicalType) {
            report['reportType'] =
                canonicalType;

            storageChanged = true;
          }

          normalizedRecords.add(
            jsonEncode(report),
          );

          total++;

          if (canonicalType ==
              'Hazard Report') {
            hazards++;
          } else {
            observations++;
          }

          final status =
              _normalizeStatus(
            report['status'],
          );

          if (_isOpenStatus(status)) {
            open++;
          }
        } catch (_) {
          continue;
        }
      }

      if (storageChanged) {
        await prefs.setStringList(
          _storageKey,
          normalizedRecords,
        );
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

  String _canonicalReportType({
    required String reportType,
    required String observationType,
  }) {
    final type =
        reportType.trim().toLowerCase();

    final observation =
        observationType.trim().toLowerCase();

    if (type.contains('hazard') ||
        observation.contains('hazard')) {
      return 'Hazard Report';
    }

    return 'Safety Observation';
  }

  String _normalizeStatus(dynamic value) {
    final status =
        _stringValue(value).toLowerCase();

    if (status.isEmpty) {
      return 'open';
    }

    if (status == 'in-progress' ||
        status == 'inprogress') {
      return 'in progress';
    }

    return status;
  }

  bool _isOpenStatus(String status) {
    return status == 'open' ||
        status == 'pending' ||
        status == 'in progress';
  }

  String _stringValue(dynamic value) {
    if (value == null) {
      return '';
    }

    return value.toString().trim();
  }

  // ==========================================================
  // NAVIGATION
  // ==========================================================

  Future<void> _openPage(
    Widget page,
  ) async {
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

  Future<void> _openGuidelines() async {
    await _openPage(
      const GuidelinesPage(),
    );
  }

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
  // MAIN BUILD
  // ==========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          _buildDashboard(),
          _buildGuidelinesHome(),
          _buildReportHome(),
          _buildLearningHome(),
          _buildProfileHome(),
        ],
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
      height: 78,
      backgroundColor: Colors.white,
      elevation: 8,
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
            Icons.home_outlined,
          ),
          selectedIcon: Icon(
            Icons.home_rounded,
          ),
          label: 'Home',
        ),
        NavigationDestination(
          icon: Icon(
            Icons.menu_book_outlined,
          ),
          selectedIcon: Icon(
            Icons.menu_book_rounded,
          ),
          label: 'Guidelines',
        ),
        NavigationDestination(
          icon: Icon(
            Icons.warning_amber_outlined,
          ),
          selectedIcon: Icon(
            Icons.warning_rounded,
          ),
          label: 'Report',
        ),
        NavigationDestination(
          icon: Icon(
            Icons.school_outlined,
          ),
          selectedIcon: Icon(
            Icons.school_rounded,
          ),
          label: 'Learning',
        ),
        NavigationDestination(
          icon: Icon(
            Icons.person_outline_rounded,
          ),
          selectedIcon: Icon(
            Icons.person_rounded,
          ),
          label: 'Profile',
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
        onRefresh: _loadDashboardStats,
        child: ListView(
          physics:
              const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(
            16,
            8,
            16,
            30,
          ),
          children: [
            _buildTopBanner(),

            const SizedBox(height: 18),

            _buildUaeHeroCard(),

            const SizedBox(height: 20),

            _buildQuickActionsTitle(),

            const SizedBox(height: 10),

            _buildQuickActions(),

            const SizedBox(height: 20),

            _buildSafetyOverview(),

            const SizedBox(height: 20),

            _buildReferencePreview(),

            const SizedBox(height: 20),

            _buildSafetyMessage(),

            const SizedBox(height: 16),

            _buildUaeInfoCard(),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // TOP GREEN BANNER
  // ==========================================================

  Widget _buildTopBanner() {
    return Container(
      width: double.infinity,
      height: 112,
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 13,
      ),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0xFF075B45),
            Color(0xFF0B9860),
          ],
        ),
        borderRadius:
            BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(18),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(25),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.eco_rounded,
              color: Color(0xFFDFFF91),
              size: 35,
            ),
          ),

          const SizedBox(width: 16),

          const Expanded(
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center,
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  'Small Actions. Big Difference.',
                  maxLines: 1,
                  overflow:
                      TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight:
                        FontWeight.w900,
                  ),
                ),

                SizedBox(height: 7),

                Text(
                  'Safe Today • Healthy Tomorrow • Stronger UAE',
                  maxLines: 2,
                  overflow:
                      TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Color(0xFFE2FFB1),
                    fontSize: 11.5,
                    height: 1.3,
                    fontWeight:
                        FontWeight.w500,
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
  // UAE HERO CARD
  // ==========================================================

  Widget _buildUaeHeroCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFE9F8F1),
        borderRadius:
            BorderRadius.circular(26),
        border: Border.all(
          color: const Color(0xFFCDEBDD),
          width: 1.4,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(16),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 112,
            height: 112,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color:
                      Colors.black.withAlpha(10),
                  blurRadius: 8,
                ),
              ],
            ),
            child: const Center(
              child: Icon(
                Icons.shield_rounded,
                color: darkGreen,
                size: 67,
              ),
            ),
          ),

          const SizedBox(width: 18),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                const Text(
                  'UAE-wide HSE Safety App',
                  style: TextStyle(
                    color: darkGreen,
                    fontSize: 19,
                    fontWeight:
                        FontWeight.w900,
                    height: 1.15,
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  'Built for HSE professionals and safer workplaces across the United Arab Emirates.',
                  style: TextStyle(
                    color: Color(0xFF527064),
                    fontSize: 12.5,
                    height: 1.45,
                  ),
                ),

                const SizedBox(height: 12),

                Container(
                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white
                        .withAlpha(170),
                    borderRadius:
                        BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'SafeNexus HSE • UAE',
                    style: TextStyle(
                      color: darkGreen,
                      fontSize: 10,
                      fontWeight:
                          FontWeight.w800,
                    ),
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
  // QUICK ACTION TITLE
  // ==========================================================

  Widget _buildQuickActionsTitle() {
    return Row(
      children: [
        const Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                'Quick Actions',
                style: TextStyle(
                  color: navy,
                  fontSize: 20,
                  fontWeight:
                      FontWeight.w900,
                ),
              ),
              SizedBox(height: 3),
              Text(
                'Take action for a safer workplace',
                style: TextStyle(
                  color: Color(0xFF607D8B),
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),

        Container(
          padding:
              const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 7,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFFE3F6EC),
            borderRadius:
                BorderRadius.circular(20),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.shield_rounded,
                color: primaryGreen,
                size: 15,
              ),
              SizedBox(width: 5),
              Text(
                'SAFETY FIRST',
                style: TextStyle(
                  color: darkGreen,
                  fontSize: 8.5,
                  fontWeight:
                      FontWeight.w900,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ==========================================================
  // QUICK ACTIONS
  // ==========================================================

  Widget _buildQuickActions() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _quickActionCard(
                title: 'Report Hazard',
                subtitle:
                    'Unsafe condition',
                icon:
                    Icons.warning_rounded,
                iconColor:
                    const Color(0xFFC51E30),
                background:
                    const Color(0xFFFFF2F2),
                onTap: () {
                  _openPage(
                    const HazardReportPage(),
                  );
                },
              ),
            ),

            const SizedBox(width: 11),

            Expanded(
              child: _quickActionCard(
                title: 'Voice Report',
                subtitle:
                    'Speak your concern',
                icon: Icons.mic_rounded,
                iconColor:
                    const Color(0xFF5A1BB8),
                background:
                    const Color(0xFFF4EEFF),
                onTap: () {
                  _showInfoDialog(
                    'Voice Report',
                    'Voice reporting is available from the reporting workflow.',
                  );
                },
              ),
            ),
          ],
        ),

        const SizedBox(height: 11),

        Row(
          children: [
            Expanded(
              child: _quickActionCard(
                title:
                    'Safety Observation',
                subtitle:
                    'Observe and record',
                icon:
                    Icons.visibility_rounded,
                iconColor:
                    const Color(0xFF1475D1),
                background:
                    const Color(0xFFEDF7FF),
                onTap: () {
                  _openPage(
                    const SafetyObservationPage(),
                  );
                },
              ),
            ),

            const SizedBox(width: 11),

            Expanded(
              child: _quickActionCard(
                title: 'HSE Guidelines',
                subtitle:
                    'UAE safety guidance',
                icon:
                    Icons.menu_book_rounded,
                iconColor:
                    primaryGreen,
                background:
                    const Color(0xFFEBF9F1),
                onTap:
                    _openGuidelines,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ==========================================================
  // QUICK ACTION CARD
  // ==========================================================

  Widget _quickActionCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color iconColor,
    required Color background,
    required VoidCallback onTap,
  }) {
    return Material(
      color: background,
      borderRadius:
          BorderRadius.circular(20),
      child: InkWell(
        borderRadius:
            BorderRadius.circular(20),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(15),
                ),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 27,
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
                      maxLines: 2,
                      overflow:
                          TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: navy,
                        fontSize: 13,
                        fontWeight:
                            FontWeight.w900,
                      ),
                    ),

                    const SizedBox(height: 3),

                    Text(
                      subtitle,
                      maxLines: 1,
                      overflow:
                          TextOverflow.ellipsis,
                      style: const TextStyle(
                        color:
                            Color(0xFF607D8B),
                        fontSize: 9.5,
                      ),
                    ),
                  ],
                ),
              ),

              Icon(
                Icons.chevron_right_rounded,
                color: iconColor,
                size: 22,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // SAFETY OVERVIEW
  // ==========================================================

  Widget _buildSafetyOverview() {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(23),
        border: Border.all(
          color: const Color(0xFFE1EAF0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(12),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Safety Overview',
                  style: TextStyle(
                    color: navy,
                    fontSize: 18,
                    fontWeight:
                        FontWeight.w900,
                  ),
                ),
              ),

              Container(
                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 9,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color:
                      const Color(0xFFEAF8F0),
                  borderRadius:
                      BorderRadius.circular(15),
                ),
                child: const Text(
                  'LIVE',
                  style: TextStyle(
                    color: darkGreen,
                    fontSize: 8,
                    fontWeight:
                        FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),

          Row(
            children: [
              Expanded(
                child: _overviewMetric(
                  icon:
                      Icons.warning_amber_rounded,
                  iconColor:
                      const Color(0xFFC51E30),
                  value: _loadingStats
                      ? '...'
                      : _hazards.toString(),
                  title: 'Hazards',
                ),
              ),

              _overviewDivider(),

              Expanded(
                child: _overviewMetric(
                  icon:
                      Icons.visibility_rounded,
                  iconColor:
                      const Color(0xFF1475D1),
                  value: _loadingStats
                      ? '...'
                      : _observations.toString(),
                  title: 'Observations',
                ),
              ),

              _overviewDivider(),

              Expanded(
                child: _overviewMetric(
                  icon:
                      Icons.pending_actions_rounded,
                  iconColor:
                      const Color(0xFFB16A00),
                  value: _loadingStats
                      ? '...'
                      : _openReports.toString(),
                  title: 'Open',
                ),
              ),

              _overviewDivider(),

              Expanded(
                child: _overviewMetric(
                  icon:
                      Icons.assignment_turned_in_rounded,
                  iconColor:
                      primaryGreen,
                  value: _loadingStats
                      ? '...'
                      : _totalReports.toString(),
                  title: 'Total',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _overviewMetric({
    required IconData icon,
    required Color iconColor,
    required String value,
    required String title,
  }) {
    return Column(
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: iconColor.withAlpha(18),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: iconColor,
            size: 20,
          ),
        ),

        const SizedBox(height: 7),

        Text(
          value,
          style: const TextStyle(
            color: navy,
            fontSize: 20,
            fontWeight: FontWeight.w900,
          ),
        ),

        const SizedBox(height: 2),

        Text(
          title,
          maxLines: 1,
          overflow:
              TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color(0xFF607D8B),
            fontSize: 8.5,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _overviewDivider() {
    return Container(
      width: 1,
      height: 65,
      color: const Color(0xFFE2E9ED),
    );
  }

  // ==========================================================
  // UAE HSE REFERENCE
  // ==========================================================

  Widget _buildReferencePreview() {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    'UAE HSE Reference',
                    style: TextStyle(
                      color: navy,
                      fontSize: 19,
                      fontWeight:
                          FontWeight.w900,
                    ),
                  ),
                  SizedBox(height: 3),
                  Text(
                    'Safety guidance across the United Arab Emirates',
                    style: TextStyle(
                      color:
                          Color(0xFF607D8B),
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.menu_book_rounded,
              color: primaryGreen,
              size: 24,
            ),
          ],
        ),

        const SizedBox(height: 11),

        Row(
          children: [
            Expanded(
              child: _referenceMiniCard(
                title: 'UAE General',
                count: _uaeGeneralCount,
                icon: Icons.flag_rounded,
                color:
                    const Color(0xFF1378C7),
                onTap: () {
                  _openGuidelineCategory(
                    GuidelineCategory.uaeGeneral,
                  );
                },
              ),
            ),

            const SizedBox(width: 9),

            Expanded(
              child: _referenceMiniCard(
                title: 'Abu Dhabi',
                count: _abuDhabiCount,
                icon:
                    Icons.location_city_rounded,
                color:
                    const Color(0xFF0B7B53),
                onTap: () {
                  _openGuidelineCategory(
                    GuidelineCategory.abuDhabi,
                  );
                },
              ),
            ),
          ],
        ),

        const SizedBox(height: 9),

        Row(
          children: [
            Expanded(
              child: _referenceMiniCard(
                title: 'Dubai',
                count: _dubaiCount,
                icon:
                    Icons.apartment_rounded,
                color:
                    const Color(0xFF6A36C8),
                onTap: () {
                  _openGuidelineCategory(
                    GuidelineCategory.dubai,
                  );
                },
              ),
            ),

            const SizedBox(width: 9),

            Expanded(
              child: _referenceMiniCard(
                title: 'HSE Reference',
                count: _hseReferenceCount,
                icon:
                    Icons.library_books_rounded,
                color:
                    const Color(0xFFB16A00),
                onTap: () {
                  _openGuidelineCategory(
                    GuidelineCategory.hseReference,
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _referenceMiniCard({
    required String title,
    required int count,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.white,
      borderRadius:
          BorderRadius.circular(18),
      child: InkWell(
        borderRadius:
            BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(13),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius:
                      BorderRadius.circular(13),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 22,
                ),
              ),

              const SizedBox(width: 9),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow:
                          TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: navy,
                        fontSize: 12,
                        fontWeight:
                            FontWeight.w900,
                      ),
                    ),

                    const SizedBox(height: 3),

                    Text(
                      '$count topics',
                      style: const TextStyle(
                        color:
                            Color(0xFF607D8B),
                        fontSize: 9.5,
                      ),
                    ),
                  ],
                ),
              ),

              Icon(
                Icons.chevron_right_rounded,
                color: color,
                size: 21,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // SAFETY MESSAGE
  // ==========================================================

  Widget _buildSafetyMessage() {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0xFF075B45),
            Color(0xFF0B9860),
          ],
        ),
        borderRadius:
            BorderRadius.circular(23),
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(20),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.eco_rounded,
              color: Color(0xFFDFFF91),
              size: 29,
            ),
          ),

          const SizedBox(width: 12),

          const Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  'Small Actions. Big Difference.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.5,
                    fontWeight:
                        FontWeight.w900,
                  ),
                ),

                SizedBox(height: 4),

                Text(
                  'Safe Today • Healthy Tomorrow • Stronger UAE',
                  maxLines: 2,
                  style: TextStyle(
                    color:
                        Color(0xFFE2FFB1),
                    fontSize: 10.5,
                    height: 1.3,
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
  // UAE INFO CARD
  // ==========================================================

  Widget _buildUaeInfoCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFE9F8F1),
        borderRadius:
            BorderRadius.circular(22),
        border: Border.all(
          color: const Color(0xFFCDEBDD),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.flag_rounded,
              color: darkGreen,
              size: 31,
            ),
          ),

          const SizedBox(width: 12),

          const Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  'SafeNexus HSE • UAE',
                  style: TextStyle(
                    color: darkGreen,
                    fontSize: 15,
                    fontWeight:
                        FontWeight.w900,
                  ),
                ),

                SizedBox(height: 4),

                Text(
                  'Safe People • Safe Workplaces • Safer UAE',
                  style: TextStyle(
                    color:
                        Color(0xFF527064),
                    fontSize: 10.5,
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

  // ==========================================================
  // GUIDELINES HOME
  // ==========================================================

  Widget _buildGuidelinesHome() {
    return SafeArea(
      child: Column(
        children: [
          _simplePageHeader(
            title: 'HSE Guidelines',
            subtitle:
                'UAE Regulations & Best Practices',
            icon:
                Icons.menu_book_rounded,
          ),

          const Expanded(
            child: GuidelinesPage(),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // REPORT HOME
  // ==========================================================

  Widget _buildReportHome() {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          _simplePageHeader(
            title: 'Safety Reports',
            subtitle:
                'Report an unsafe condition or workplace hazard',
            icon: Icons.warning_rounded,
          ),

          const SizedBox(height: 12),

          _reportChoiceCard(
            title: 'Report Hazard',
            subtitle:
                'Report an unsafe condition or workplace hazard.',
            icon: Icons.warning_rounded,
            color:
                const Color(0xFFC51E30),
            onTap: () {
              _openPage(
                const HazardReportPage(),
              );
            },
          ),

          const SizedBox(height: 12),

          _reportChoiceCard(
            title: 'Safety Observation',
            subtitle:
                'Record a safety observation and corrective action.',
            icon:
                Icons.visibility_rounded,
            color:
                const Color(0xFF1475D1),
            onTap: () {
              _openPage(
                const SafetyObservationPage(),
              );
            },
          ),

          const SizedBox(height: 12),

          _reportChoiceCard(
            title: 'Observation History',
            subtitle:
                'View previously submitted safety reports.',
            icon: Icons.history_rounded,
            color: primaryGreen,
            onTap: () {
              _openPage(
                const ObservationHistoryPage(),
              );
            },
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // REPORT CHOICE CARD
  // ==========================================================

  Widget _reportChoiceCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.white,
      borderRadius:
          BorderRadius.circular(22),
      child: InkWell(
        borderRadius:
            BorderRadius.circular(22),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius:
                      BorderRadius.circular(17),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 30,
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: navy,
                        fontSize: 17,
                        fontWeight:
                            FontWeight.w800,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      subtitle,
                      style: const TextStyle(
                        color:
                            Color(0xFF607D8B),
                        fontSize: 12,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),

              Icon(
                Icons.chevron_right_rounded,
                color: color,
                size: 28,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // LEARNING HOME
  // ==========================================================

  Widget _buildLearningHome() {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          _simplePageHeader(
            title: 'Learning Center',
            subtitle:
                'Build Knowledge • Build a Safer You',
            icon: Icons.school_rounded,
          ),

          const SizedBox(height: 16),

          _learningCard(
            title: 'UAE General HSE',
            subtitle:
                'Explore UAE-wide safety guidance and best practices.',
            icon: Icons.flag_rounded,
            color:
                const Color(0xFF1475D1),
            onTap: () {
              _openGuidelineCategory(
                GuidelineCategory.uaeGeneral,
              );
            },
          ),

          const SizedBox(height: 12),

          _learningCard(
            title: 'Abu Dhabi HSE',
            subtitle:
                'Explore Abu Dhabi specific HSE requirements.',
            icon:
                Icons.location_city_rounded,
            color: primaryGreen,
            onTap: () {
              _openGuidelineCategory(
                GuidelineCategory.abuDhabi,
              );
            },
          ),

          const SizedBox(height: 12),

          _learningCard(
            title: 'Dubai HSE',
            subtitle:
                'Explore Dubai safety requirements and guidance.',
            icon:
                Icons.apartment_rounded,
            color:
                const Color(0xFF6330D7),
            onTap: () {
              _openGuidelineCategory(
                GuidelineCategory.dubai,
              );
            },
          ),

          const SizedBox(height: 12),

          _learningCard(
            title: 'Professional HSE Reference',
            subtitle:
                'Useful professional HSE reference topics.',
            icon:
                Icons.library_books_rounded,
            color:
                const Color(0xFFB16A00),
            onTap: () {
              _openGuidelineCategory(
                GuidelineCategory.hseReference,
              );
            },
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // LEARNING CARD
  // ==========================================================

  Widget _learningCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.white,
      borderRadius:
          BorderRadius.circular(21),
      child: InkWell(
        borderRadius:
            BorderRadius.circular(21),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(17),
          child: Row(
            children: [
              Container(
                width: 57,
                height: 57,
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius:
                      BorderRadius.circular(16),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 29,
                ),
              ),

              const SizedBox(width: 13),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: navy,
                        fontSize: 16,
                        fontWeight:
                            FontWeight.w800,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      subtitle,
                      style: const TextStyle(
                        color:
                            Color(0xFF607D8B),
                        fontSize: 11.5,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),

              Icon(
                Icons.chevron_right_rounded,
                color: color,
                size: 26,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // PROFILE HOME
  // ==========================================================

  Widget _buildProfileHome() {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          _simplePageHeader(
            title: 'SafeNexus Profile',
            subtitle:
                'Your HSE safety workspace',
            icon:
                Icons.person_rounded,
          ),

          const SizedBox(height: 16),

          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF0A8653),
                  Color(0xFF075B45),
                ],
              ),
              borderRadius:
                  BorderRadius.circular(24),
            ),
            child: const Column(
              children: [
                CircleAvatar(
                  radius: 34,
                  backgroundColor:
                      Colors.white,
                  child: Icon(
                    Icons.person_rounded,
                    size: 39,
                    color:
                        Color(0xFF075B45),
                  ),
                ),

                SizedBox(height: 12),

                Text(
                  'HSE Professional',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight:
                        FontWeight.w800,
                  ),
                ),

                SizedBox(height: 4),

                Text(
                  'SafeNexus HSE • UAE',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 14),

          _profileAction(
            title:
                'Observation History',
            subtitle:
                'View your submitted safety reports',
            icon: Icons.history_rounded,
            onTap: () {
              _openPage(
                const ObservationHistoryPage(),
              );
            },
          ),

          const SizedBox(height: 10),

          _profileAction(
            title:
                'UAE HSE Guidelines',
            subtitle:
                'Open safety reference library',
            icon:
                Icons.menu_book_rounded,
            onTap:
                _openGuidelines,
          ),

          const SizedBox(height: 10),

          _profileAction(
            title:
                'About SafeNexus HSE',
            subtitle:
                'UAE-wide HSE safety platform',
            icon:
                Icons.info_outline_rounded,
            onTap: () {
              _showInfoDialog(
                'SafeNexus HSE',
                'Safe People • Safe Workplaces • Safer UAE',
              );
            },
          ),

          const SizedBox(height: 20),

          _buildUaeInfoCard(),
        ],
      ),
    );
  }

  // ==========================================================
  // PROFILE ACTION
  // ==========================================================

  Widget _profileAction({
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.white,
      borderRadius:
          BorderRadius.circular(18),
      child: InkWell(
        borderRadius:
            BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              Container(
                width: 47,
                height: 47,
                decoration: BoxDecoration(
                  color:
                      primaryGreen.withAlpha(18),
                  borderRadius:
                      BorderRadius.circular(14),
                ),
                child: Icon(
                  icon,
                  color: primaryGreen,
                  size: 25,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: navy,
                        fontSize: 14,
                        fontWeight:
                            FontWeight.w800,
                      ),
                    ),

                    const SizedBox(height: 3),

                    Text(
                      subtitle,
                      style: const TextStyle(
                        color:
                            Color(0xFF607D8B),
                        fontSize: 10.5,
                      ),
                    ),
                  ],
                ),
              ),

              const Icon(
                Icons.chevron_right_rounded,
                color: primaryGreen,
                size: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // SIMPLE PAGE HEADER
  // ==========================================================

  Widget _simplePageHeader({
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        18,
        12,
        18,
        4,
      ),
      child: Container(
        padding: const EdgeInsets.all(17),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.circular(21),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(12),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color:
                    primaryGreen.withAlpha(20),
                borderRadius:
                    BorderRadius.circular(15),
              ),
              child: Icon(
                icon,
                color: primaryGreen,
                size: 27,
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: navy,
                      fontSize: 19,
                      fontWeight:
                          FontWeight.w800,
                    ),
                  ),

                  const SizedBox(height: 3),

                  Text(
                    subtitle,
                    style: const TextStyle(
                      color:
                          Color(0xFF607D8B),
                      fontSize: 10.5,
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
  // INFO DIALOG
  // ==========================================================

  void _showInfoDialog(
    String title,
    String message,
  ) {
    if (!mounted) {
      return;
    }

    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(22),
          ),
          title: Text(
            title,
            style: const TextStyle(
              color: navy,
              fontWeight:
                  FontWeight.w800,
            ),
          ),
          content: Text(
            message,
            style: const TextStyle(
              color:
                  Color(0xFF455A64),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(
                  dialogContext,
                );
              },
              child: const Text(
                'OK',
                style: TextStyle(
                  color: primaryGreen,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
