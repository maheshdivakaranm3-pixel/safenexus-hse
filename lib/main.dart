import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'guidelines.dart';
import 'hazard_report.dart';
import 'observation_history.dart';
import 'safety_observation.dart';

import 'data/abu_dhabi_guidelines.dart';
import 'data/dubai_guidelines.dart';
import 'data/hse_safety_reference.dart';
import 'data/uae_general_guidelines.dart';

import 'models/reference_topic.dart';

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
  State<SafeNexusHomePage> createState() => _SafeNexusHomePageState();
}

class _SafeNexusHomePageState extends State<SafeNexusHomePage> {
  // ==========================================================
  // COLORS
  // ==========================================================

  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF075B45);
  static const Color navy = Color(0xFF082653);

  // ==========================================================
  // ORIGINAL SAFENEXUS HSE LOGO
  // ==========================================================

  static const String _logoAsset =
      'assets/images/safenexus_hse_logo.png';

  // ==========================================================
  // STORAGE
  // ==========================================================

  static const String _storageKey = 'safenexus_observations';

  // ==========================================================
  // NAVIGATION
  // ==========================================================

  int _currentIndex = 0;

  // ==========================================================
  // STATISTICS
  // ==========================================================

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
  // LOAD STATISTICS
  // ==========================================================

  Future<void> _loadDashboardStats() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final records =
          prefs.getStringList(_storageKey) ?? <String>[];

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

          final report = Map<String, dynamic>.from(decoded);

          final id = _stringValue(report['id']);

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
  // STRING VALUE
  // ==========================================================

  String _stringValue(dynamic value) {
    if (value == null) {
      return '';
    }

    return value.toString().trim();
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

  Future<void> _openGuidelines() async {
    await _openPage(
      const GuidelinesPage(),
    );
  }

  // ==========================================================
  // BUILD
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
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  // ==========================================================
  // BOTTOM NAVIGATION
  // ==========================================================

  Widget _buildBottomNavigation() {
    return NavigationBar(
      height: 76,
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
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home_rounded),
          label: 'Home',
        ),
        NavigationDestination(
          icon: Icon(Icons.menu_book_outlined),
          selectedIcon: Icon(Icons.menu_book_rounded),
          label: 'Guidelines',
        ),
        NavigationDestination(
          icon: Icon(Icons.warning_amber_outlined),
          selectedIcon: Icon(Icons.warning_rounded),
          label: 'Report',
        ),
        NavigationDestination(
          icon: Icon(Icons.school_outlined),
          selectedIcon: Icon(Icons.school_rounded),
          label: 'Learning',
        ),
        NavigationDestination(
          icon: Icon(Icons.person_outline_rounded),
          selectedIcon: Icon(Icons.person_rounded),
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
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(
            16,
            12,
            16,
            28,
          ),
          children: [
            _buildHeader(),
            const SizedBox(height: 16),
            _buildProfessionalHero(),
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
            _buildUaeCard(),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // HEADER
  // ORIGINAL SAFENEXUS LOGO
  // ==========================================================

  Widget _buildHeader() {
    return Row(
      children: [
        // ======================================================
        // ORIGINAL FULL SAFENEXUS HSE LOGO
        // ======================================================

        Container(
          width: 74,
          height: 74,
          padding: const EdgeInsets.all(7),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(21),
            boxShadow: [
              BoxShadow(
                color: primaryGreen.withAlpha(35),
                blurRadius: 12,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Image.asset(
            _logoAsset,
            width: 60,
            height: 60,
            fit: BoxFit.contain,
            filterQuality: FilterQuality.high,
          ),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: 'Safe',
                      style: TextStyle(
                        color: navy,
                        fontSize: 23,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    TextSpan(
                      text: 'Nexus',
                      style: TextStyle(
                        color: primaryGreen,
                        fontSize: 23,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    TextSpan(
                      text: ' HSE',
                      style: TextStyle(
                        color: navy,
                        fontSize: 23,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 2),
              const Text(
                'Safe People • Safe Workplaces • Safer UAE',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Color(0xFF607D8B),
                  fontSize: 9.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),

        _buildHeaderButton(
          icon: Icons.notifications_none_rounded,
          showDot: true,
          onTap: () {
            _showMessage(
              'Notifications',
              'No new safety notifications.',
            );
          },
        ),

        const SizedBox(width: 6),

        _buildHeaderButton(
          icon: Icons.settings_outlined,
          onTap: () {
            _showMessage(
              'Settings',
              'SafeNexus HSE settings will be available here.',
            );
          },
        ),
      ],
    );
  }

  // ==========================================================
  // HEADER BUTTON
  // ==========================================================

  Widget _buildHeaderButton({
    required IconData icon,
    required VoidCallback onTap,
    bool showDot = false,
  }) {
    return Stack(
      children: [
        Material(
          color: const Color(0xFFE8F4FF),
          shape: const CircleBorder(),
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: onTap,
            child: SizedBox(
              width: 43,
              height: 43,
              child: Icon(
                icon,
                color: navy,
                size: 23,
              ),
            ),
          ),
        ),
        if (showDot)
          Positioned(
            right: 1,
            top: 1,
            child: Container(
              width: 10,
              height: 10,
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
            ),
          ),
      ],
    );
  }

  // ==========================================================
  // PROFESSIONAL HERO
  // ==========================================================

  Widget _buildProfessionalHero() {
    return Container(
      height: 205,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF063E73),
            Color(0xFF075B45),
            Color(0xFF0B9860),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(25),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -55,
            top: -65,
            child: Container(
              width: 190,
              height: 190,
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(14),
                shape: BoxShape.circle,
              ),
            ),
          ),

          Positioned(
            right: 25,
            bottom: -50,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(9),
                shape: BoxShape.circle,
              ),
            ),
          ),

          // ==================================================
          // UAE FLAG
          // ==================================================

          Positioned(
            right: 22,
            top: 22,
            child: Container(
              width: 55,
              height: 55,
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(20),
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white.withAlpha(45),
                ),
              ),
              child: const Center(
                child: Text(
                  '🇦🇪',
                  style: TextStyle(
                    fontSize: 28,
                  ),
                ),
              ),
            ),
          ),

          // ==================================================
          // HERO TEXT
          // ==================================================

          Positioned(
            left: 21,
            top: 22,
            right: 95,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'UAE HSE SAFETY',
                  style: TextStyle(
                    color: Color(0xFFB8F4D2),
                    fontSize: 11,
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Safety Starts\nWith You.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 31,
                    height: 0.98,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 9),
                Text(
                  'Protect People.\nPrevent Risk.',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                    height: 1.3,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          // ==================================================
          // ORIGINAL SAFENEXUS HSE LOGO
          // BOTTOM RIGHT
          // ==================================================

          Positioned(
            right: 14,
            bottom: 13,
            child: Container(
              width: 92,
              height: 92,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(22),
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white.withAlpha(35),
                  width: 1.2,
                ),
              ),
              child: Container(
                width: 76,
                height: 76,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(4),
                child: ClipOval(
                  child: Image.asset(
                    _logoAsset,
                    width: 68,
                    height: 68,
                    fit: BoxFit.contain,
                    filterQuality: FilterQuality.high,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // QUICK ACTIONS TITLE
  // ==========================================================

  Widget _buildQuickActionsTitle() {
    return Row(
      children: [
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Quick Actions',
                style: TextStyle(
                  color: navy,
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(height: 2),
              Text(
                'Take action for a safer workplace',
                style: TextStyle(
                  color: Color(0xFF607D8B),
                  fontSize: 10.5,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 6,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFFE3F6EC),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.shield_rounded,
                color: primaryGreen,
                size: 15,
              ),
              SizedBox(width: 4),
              Text(
                'SAFETY FIRST',
                style: TextStyle(
                  color: darkGreen,
                  fontSize: 8.5,
                  fontWeight: FontWeight.w900,
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
                subtitle: 'Unsafe condition',
                icon: Icons.warning_rounded,
                iconColor: const Color(0xFFC51E30),
                background: const Color(0xFFFFF2F2),
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
                subtitle: 'Speak your concern',
                icon: Icons.mic_rounded,
                iconColor: const Color(0xFF5A1BB8),
                background: const Color(0xFFF4EEFF),
                onTap: () {
                  _showMessage(
                    'Voice Report',
                    'Voice reporting can be connected here.',
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
                title: 'Safety Observation',
                subtitle: 'Observe & record',
                icon: Icons.visibility_rounded,
                iconColor: const Color(0xFF1475D1),
                background: const Color(0xFFEDF7FF),
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
                subtitle: 'UAE safety guidance',
                icon: Icons.menu_book_rounded,
                iconColor: primaryGreen,
                background: const Color(0xFFEBF9F1),
                onTap: _openGuidelines,
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
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Container(
                width: 51,
                height: 51,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: navy,
                        fontSize: 13.5,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color(0xFF607D8B),
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
        borderRadius: BorderRadius.circular(23),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Safety Overview',
                  style: TextStyle(
                    color: navy,
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 9,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF8F0),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Text(
                  'LIVE',
                  style: TextStyle(
                    color: darkGreen,
                    fontSize: 8,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: _overviewMetric(
                  icon: Icons.warning_amber_rounded,
                  iconColor: const Color(0xFFC51E30),
                  value: _loadingStats
                      ? '...'
                      : _hazards.toString(),
                  title: 'Hazards',
                ),
              ),
              _overviewDivider(),
              Expanded(
                child: _overviewMetric(
                  icon: Icons.visibility_rounded,
                  iconColor: const Color(0xFF1475D1),
                  value: _loadingStats
                      ? '...'
                      : _observations.toString(),
                  title: 'Observations',
                ),
              ),
              _overviewDivider(),
              Expanded(
                child: _overviewMetric(
                  icon: Icons.pending_actions_rounded,
                  iconColor: const Color(0xFFB16A00),
                  value: _loadingStats
                      ? '...'
                      : _openReports.toString(),
                  title: 'Open Reports',
                ),
              ),
              _overviewDivider(),
              Expanded(
                child: _overviewMetric(
                  icon: Icons.assignment_turned_in_rounded,
                  iconColor: primaryGreen,
                  value: _loadingStats
                      ? '...'
                      : _totalReports.toString(),
                  title: 'Total Reports',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // OVERVIEW METRIC
  // ==========================================================

  Widget _overviewMetric({
    required IconData icon,
    required Color iconColor,
    required String value,
    required String title,
  }) {
    return Column(
      children: [
        Container(
          width: 37,
          height: 37,
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
          overflow: TextOverflow.ellipsis,
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

  // ==========================================================
  // OVERVIEW DIVIDER
  // ==========================================================

  Widget _overviewDivider() {
    return Container(
      width: 1,
      height: 66,
      color: const Color(0xFFE2E9ED),
    );
  }

  // ==========================================================
  // REFERENCE PREVIEW
  // ==========================================================

  Widget _buildReferencePreview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'UAE HSE Reference',
                    style: TextStyle(
                      color: navy,
                      fontSize: 19,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  SizedBox(height: 3),
                  Text(
                    'Safety guidance across the United Arab Emirates',
                    style: TextStyle(
                      color: Color(0xFF607D8B),
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
                color: const Color(0xFF1378C7),
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
                icon: Icons.location_city_rounded,
                color: const Color(0xFF0B7B53),
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
                icon: Icons.apartment_rounded,
                color: const Color(0xFF6A36C8),
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
                icon: Icons.library_books_rounded,
                color: const Color(0xFFB16A00),
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

  // ==========================================================
  // REFERENCE MINI CARD
  // ==========================================================

  Widget _referenceMiniCard({
    required String title,
    required int count,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
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
                  borderRadius: BorderRadius.circular(13),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: navy,
                        fontSize: 12.5,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      '$count topics',
                      style: const TextStyle(
                        color: Color(0xFF607D8B),
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
        borderRadius: BorderRadius.circular(23),
      ),
      child: Row(
        children: [
          Container(
            width: 51,
            height: 51,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Small Actions. Big Difference.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.5,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Safe Today • Healthy Tomorrow • Stronger UAE',
                  maxLines: 2,
                  style: TextStyle(
                    color: Color(0xFFE2FFB1),
                    fontSize: 9.5,
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
  // UAE CARD
  // ==========================================================

  Widget _buildUaeCard() {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: const Color(0xFFE9F8F1),
        borderRadius: BorderRadius.circular(21),
        border: Border.all(
          color: const Color(0xFFCDEBDD),
        ),
      ),
      child: const Row(
        children: [
          Text(
            '🇦🇪',
            style: TextStyle(
              fontSize: 30,
            ),
          ),
          SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'UAE-wide HSE Safety App',
                  style: TextStyle(
                    color: darkGreen,
                    fontSize: 14.5,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  'Built for HSE professionals and safer workplaces across the United Arab Emirates.',
                  style: TextStyle(
                    color: Color(0xFF527064),
                    fontSize: 10,
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
            subtitle: 'UAE Regulations & Best Practices',
            icon: Icons.menu_book_rounded,
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

          // ==================================================
          // ONLY REPORT HAZARD
          // ==================================================

          _reportChoiceCard(
            title: 'Report Hazard',
            subtitle:
                'Report an unsafe condition or workplace hazard.',
            icon: Icons.warning_rounded,
            color: const Color(0xFFC51E30),
            onTap: () {
              _openPage(
                const HazardReportPage(),
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
      borderRadius: BorderRadius.circular(22),
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
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
                  borderRadius: BorderRadius.circular(17),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: navy,
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: Color(0xFF607D8B),
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
            subtitle: 'Build Knowledge • Build a Safer You',
            icon: Icons.school_rounded,
          ),
          const SizedBox(height: 16),
          _learningCard(
            title: 'UAE General HSE',
            subtitle:
                'Explore UAE-wide safety guidance and best practices.',
            icon: Icons.flag_rounded,
            color: const Color(0xFF1475D1),
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
            icon: Icons.location_city_rounded,
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
            icon: Icons.apartment_rounded,
            color: const Color(0xFF6330D7),
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
            icon: Icons.library_books_rounded,
            color: const Color(0xFFB16A00),
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
      borderRadius: BorderRadius.circular(21),
      child: InkWell(
        borderRadius: BorderRadius.circular(21),
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
                  borderRadius: BorderRadius.circular(16),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: navy,
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: Color(0xFF607D8B),
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
            subtitle: 'Your HSE safety workspace',
            icon: Icons.person_rounded,
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
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Column(
              children: [
                CircleAvatar(
                  radius: 34,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.person_rounded,
                    size: 39,
                    color: Color(0xFF075B45),
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  'HSE Professional',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
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
            title: 'Observation History',
            subtitle: 'View your submitted safety reports',
            icon: Icons.history_rounded,
            onTap: () {
              _openPage(
                const ObservationHistoryPage(),
              );
            },
          ),
          const SizedBox(height: 10),
          _profileAction(
            title: 'UAE HSE Guidelines',
            subtitle: 'Open safety reference library',
            icon: Icons.menu_book_rounded,
            onTap: _openGuidelines,
          ),
          const SizedBox(height: 10),
          _profileAction(
            title: 'About SafeNexus HSE',
            subtitle: 'UAE-wide HSE safety platform',
            icon: Icons.info_outline_rounded,
            onTap: () {
              _showMessage(
                'SafeNexus HSE',
                'Safe People • Safe Workplaces • Safer UAE',
              );
            },
          ),
          const SizedBox(height: 20),
          _buildUaeCard(),
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
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              Container(
                width: 47,
                height: 47,
                decoration: BoxDecoration(
                  color: primaryGreen.withAlpha(18),
                  borderRadius: BorderRadius.circular(14),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: navy,
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: Color(0xFF607D8B),
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
          borderRadius: BorderRadius.circular(21),
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
                color: primaryGreen.withAlpha(20),
                borderRadius: BorderRadius.circular(15),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: navy,
                      fontSize: 19,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Color(0xFF607D8B),
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
  // MESSAGE
  // ==========================================================

  void _showMessage(
    String title,
    String message,
  ) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
          title: Text(
            title,
            style: const TextStyle(
              color: navy,
              fontWeight: FontWeight.w800,
            ),
          ),
          content: Text(
            message,
            style: const TextStyle(
              color: Color(0xFF455A64),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'OK',
                style: TextStyle(
                  color: primaryGreen,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
