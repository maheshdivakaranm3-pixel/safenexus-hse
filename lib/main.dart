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
        scaffoldBackgroundColor: const Color(0xFFF5F9FC),
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
  static const Color lightBlue = Color(0xFFEAF6FF);

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
            8,
            16,
            24,
          ),
          children: [
            _buildHeader(),
            const SizedBox(height: 14),
            _buildHeroBanner(),
            const SizedBox(height: 18),
            _buildFeatureGrid(),
            const SizedBox(height: 18),
            _buildStatsPanel(),
            const SizedBox(height: 18),
            _buildSafetyMessage(),
            const SizedBox(height: 18),
            _buildReferencePreview(),
            const SizedBox(height: 14),
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
        // ------------------------------------------------------
        // LOGO
        // ------------------------------------------------------

        Container(
          width: 62,
          height: 62,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF0A8F54),
                Color(0xFF063E73),
              ],
            ),
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: primaryGreen.withAlpha(35),
                blurRadius: 12,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: const Icon(
            Icons.health_and_safety_rounded,
            color: Colors.white,
            size: 38,
          ),
        ),

        const SizedBox(width: 12),

        // ------------------------------------------------------
        // BRAND
        // ------------------------------------------------------

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                maxLines: 1,
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: 'SafeNexus ',
                      style: TextStyle(
                        color: navy,
                        fontSize: 25,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    TextSpan(
                      text: 'HSE',
                      style: TextStyle(
                        color: primaryGreen,
                        fontSize: 25,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 2),
              const Text(
                'Safe People  •  Safe Workplaces  •  Safer UAE',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 10.5,
                  color: Color(0xFF607D8B),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),

        // ------------------------------------------------------
        // NOTIFICATION
        // ------------------------------------------------------

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

        // ------------------------------------------------------
        // SETTINGS
        // ------------------------------------------------------

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
              width: 45,
              height: 45,
              child: Icon(
                icon,
                color: navy,
                size: 25,
              ),
            ),
          ),
        ),
        if (showDot)
          Positioned(
            right: 1,
            top: 1,
            child: Container(
              width: 11,
              height: 11,
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
  // HERO BANNER
  // ==========================================================

  Widget _buildHeroBanner() {
    return Container(
      height: 265,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFBDE8FF),
            Color(0xFF68C1ED),
            Color(0xFF087BA5),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(22),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        children: [
          // ----------------------------------------------------
          // SKY DECORATION
          // ----------------------------------------------------

          Positioned(
            right: -30,
            top: -35,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(35),
                shape: BoxShape.circle,
              ),
            ),
          ),

          // ----------------------------------------------------
          // SKYLINE
          // ----------------------------------------------------

          Positioned(
            left: 165,
            right: 0,
            bottom: 0,
            child: SizedBox(
              height: 155,
              child: CustomPaint(
                painter: _SkylinePainter(),
              ),
            ),
          ),

          // ----------------------------------------------------
          // TEXT
          // ----------------------------------------------------

          Positioned(
            left: 20,
            top: 23,
            width: 205,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Safety',
                  style: TextStyle(
                    color: navy,
                    fontSize: 35,
                    height: 0.95,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const Text(
                  'Today',
                  style: TextStyle(
                    color: navy,
                    fontSize: 35,
                    height: 0.95,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  'A Safer',
                  style: TextStyle(
                    color: primaryGreen,
                    fontSize: 35,
                    height: 0.95,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const Text(
                  'Tomorrow',
                  style: TextStyle(
                    color: primaryGreen,
                    fontSize: 35,
                    height: 0.95,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 13),
                Container(
                  width: 72,
                  height: 6,
                  decoration: BoxDecoration(
                    color: primaryGreen,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                const SizedBox(height: 13),
                const Text(
                  'Together for a\nSafer UAE',
                  style: TextStyle(
                    color: navy,
                    fontSize: 15,
                    height: 1.25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          // ----------------------------------------------------
          // WORKER
          // ----------------------------------------------------

          Positioned(
            right: 13,
            bottom: 6,
            child: _buildSafetyWorker(),
          ),

          // ----------------------------------------------------
          // UAE FLAG
          // ----------------------------------------------------

          Positioned(
            right: 17,
            top: 20,
            child: Column(
              children: [
                Container(
                  width: 2,
                  height: 48,
                  color: Colors.white,
                ),
                Container(
                  width: 42,
                  height: 28,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF00843D),
                        Color(0xFFFFFFFF),
                        Color(0xFF000000),
                      ],
                    ),
                  ),
                  child: Container(
                    width: 9,
                    color: const Color(0xFFFF0000),
                    alignment: Alignment.centerLeft,
                  ),
                ),
              ],
            ),
          ),

          // ----------------------------------------------------
          // BOTTOM HERO LABELS
          // ----------------------------------------------------

          Positioned(
            left: 20,
            right: 20,
            bottom: 13,
            child: Row(
              children: [
                _heroBottomItem(
                  Icons.eco_rounded,
                  'People',
                ),
                const SizedBox(width: 20),
                _heroBottomItem(
                  Icons.groups_rounded,
                  'Workplaces',
                ),
                const SizedBox(width: 20),
                _heroBottomItem(
                  Icons.shield_rounded,
                  'UAE',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // HERO BOTTOM ITEM
  // ==========================================================

  Widget _heroBottomItem(
    IconData icon,
    String title,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: 19,
        ),
        const SizedBox(width: 5),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  // ==========================================================
  // SAFETY WORKER
  // ==========================================================

  Widget _buildSafetyWorker() {
    return SizedBox(
      width: 145,
      height: 165,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // Body
          Container(
            width: 108,
            height: 116,
            decoration: BoxDecoration(
              color: const Color(0xFF16263A),
              borderRadius: BorderRadius.circular(28),
            ),
          ),

          // Safety vest
          Positioned(
            bottom: 5,
            child: Container(
              width: 91,
              height: 106,
              decoration: BoxDecoration(
                color: const Color(0xFFD9FF35),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
              ),
              child: const Center(
                child: Text(
                  'THINK\nSAFETY',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                    height: 1.05,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
          ),

          // Head
          Positioned(
            top: 25,
            child: Container(
              width: 61,
              height: 64,
              decoration: BoxDecoration(
                color: const Color(0xFF9B6748),
                borderRadius: BorderRadius.circular(24),
              ),
            ),
          ),

          // Helmet
          Positioned(
            top: 8,
            child: Container(
              width: 88,
              height: 47,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(45),
                  topRight: Radius.circular(45),
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(30),
                    blurRadius: 5,
                  ),
                ],
              ),
              child: const Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: 105,
                  height: 8,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Color(0xFFE7E7E7),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Helmet symbol
          Positioned(
            top: 20,
            child: Icon(
              Icons.health_and_safety_rounded,
              color: primaryGreen.withAlpha(170),
              size: 22,
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // FEATURE GRID
  // ==========================================================

  Widget _buildFeatureGrid() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _featureCard(
                title: 'HSE Guidelines',
                subtitle: 'UAE Regulations\n& Best Practices',
                icon: Icons.menu_book_rounded,
                background: const Color(0xFFE4F3FF),
                iconBackground: const Color(0xFFB9DEFA),
                iconColor: const Color(0xFF116BC2),
                onTap: _openGuidelines,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _featureCard(
                title: 'Report Hazard',
                subtitle: 'Report Unsafe\nConditions',
                icon: Icons.warning_rounded,
                background: const Color(0xFFE3F8EC),
                iconBackground: const Color(0xFFC5F0D5),
                iconColor: const Color(0xFF087C54),
                onTap: () {
                  setState(() {
                    _currentIndex = 2;
                  });
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _featureCard(
                title: 'Voice Report',
                subtitle: 'Speak for\na Safer Workplace',
                icon: Icons.mic_rounded,
                background: const Color(0xFFF0E9FF),
                iconBackground: const Color(0xFFDCCBFF),
                iconColor: const Color(0xFF5A1BB8),
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
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _featureCard(
                title: 'Toolbox Talks',
                subtitle: 'Daily Safety\nAwareness',
                icon: Icons.groups_rounded,
                background: const Color(0xFFFFF5D9),
                iconBackground: const Color(0xFFFFE6A4),
                iconColor: const Color(0xFF996100),
                onTap: () {
                  _showMessage(
                    'Toolbox Talks',
                    'Daily safety toolbox talks will be available here.',
                  );
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _featureCard(
                title: 'Safety Checklists',
                subtitle: 'Stay Compliant\nStay Safe',
                icon: Icons.assignment_turned_in_rounded,
                background: const Color(0xFFFFE9E9),
                iconBackground: const Color(0xFFFFCACA),
                iconColor: const Color(0xFFC51E30),
                onTap: () {
                  _showMessage(
                    'Safety Checklists',
                    'Safety checklists will be available here.',
                  );
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _featureCard(
                title: 'Learning Center',
                subtitle: 'Build Knowledge\nBuild a Safer You',
                icon: Icons.school_rounded,
                background: const Color(0xFFDFF8FC),
                iconBackground: const Color(0xFFB9EEF5),
                iconColor: const Color(0xFF007B82),
                onTap: () {
                  setState(() {
                    _currentIndex = 3;
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
  // FEATURE CARD
  // ==========================================================

  Widget _featureCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color background,
    required Color iconBackground,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return Material(
      color: background,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: SizedBox(
          height: 205,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              8,
              13,
              7,
              12,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 62,
                  height: 62,
                  decoration: BoxDecoration(
                    color: iconBackground,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    color: iconColor,
                    size: 31,
                  ),
                ),
                const SizedBox(height: 13),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: navy,
                    fontSize: 15,
                    height: 1.05,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 7),
                Expanded(
                  child: Text(
                    subtitle,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFF30475E),
                      fontSize: 11,
                      height: 1.3,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Icon(
                    Icons.chevron_right_rounded,
                    color: iconColor,
                    size: 25,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // STATS PANEL
  // ==========================================================

  Widget _buildStatsPanel() {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 17,
        horizontal: 7,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: const Color(0xFFE5EEF2),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(15),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: _statItem(
              icon: Icons.shield_rounded,
              iconColor: primaryGreen,
              value: _loadingStats
                  ? '...'
                  : _hazards.toString(),
              title: 'Hazards Reported',
              subtitle: 'Today',
            ),
          ),
          _statDivider(),
          Expanded(
            child: _statItem(
              icon: Icons.groups_rounded,
              iconColor: const Color(0xFF1475D1),
              value: '0',
              title: 'People Using',
              subtitle: 'SafeNexus',
            ),
          ),
          _statDivider(),
          Expanded(
            child: _statItem(
              icon: Icons.bar_chart_rounded,
              iconColor: const Color(0xFF6330D7),
              value: '100%',
              title: 'Safer Workplace',
              subtitle: 'Our Goal',
            ),
          ),
          _statDivider(),
          Expanded(
            child: _statItem(
              icon: Icons.eco_rounded,
              iconColor: primaryGreen,
              value: 'A Safer',
              title: 'UAE',
              subtitle: 'Our Shared Future',
              greenText: true,
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // STAT ITEM
  // ==========================================================

  Widget _statItem({
    required IconData icon,
    required Color iconColor,
    required String value,
    required String title,
    required String subtitle,
    bool greenText = false,
  }) {
    return Column(
      children: [
        Icon(
          icon,
          color: iconColor,
          size: 31,
        ),
        const SizedBox(height: 5),
        Text(
          value,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: greenText ? primaryGreen : navy,
            fontSize: greenText ? 17 : 21,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          title,
          textAlign: TextAlign.center,
          maxLines: 2,
          style: const TextStyle(
            color: Color(0xFF30475E),
            fontSize: 10.5,
            height: 1.15,
          ),
        ),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Color(0xFF607D8B),
            fontSize: 9.5,
          ),
        ),
      ],
    );
  }

  // ==========================================================
  // STAT DIVIDER
  // ==========================================================

  Widget _statDivider() {
    return Container(
      width: 1,
      height: 82,
      color: const Color(0xFFE1E8EC),
    );
  }

  // ==========================================================
  // SAFETY MESSAGE
  // ==========================================================

  Widget _buildSafetyMessage() {
    return Container(
      height: 105,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0xFF087A4C),
            Color(0xFF0B9860),
          ],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -15,
            top: -30,
            child: Icon(
              Icons.eco_rounded,
              size: 145,
              color: Colors.white.withAlpha(18),
            ),
          ),
          Positioned(
            left: 17,
            top: 16,
            child: Icon(
              Icons.eco_rounded,
              color: const Color(0xFFD9FF88),
              size: 42,
            ),
          ),
          Positioned(
            left: 65,
            top: 17,
            right: 145,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Small Actions',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  'Make a Big Difference',
                  style: TextStyle(
                    color: Color(0xFFE4FF9A),
                    fontSize: 17,
                    height: 1,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Safe Today  •  Healthy Tomorrow  •  Stronger UAE',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 9.5,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 13,
            top: 25,
            child: Material(
              color: const Color(0xFFDFFF9A),
              borderRadius: BorderRadius.circular(30),
              child: InkWell(
                borderRadius: BorderRadius.circular(30),
                onTap: () {
                  _showMessage(
                    'Be the Change',
                    'Every safe action helps create a safer UAE.',
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 17,
                    vertical: 12,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Be Safe\nBe the Change',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF075B45),
                          fontSize: 11,
                          height: 1.15,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(width: 5),
                      Icon(
                        Icons.chevron_right_rounded,
                        color: Color(0xFF075B45),
                        size: 20,
                      ),
                    ],
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
  // REFERENCE PREVIEW
  // ==========================================================

  Widget _buildReferencePreview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'UAE HSE Reference',
          style: TextStyle(
            color: navy,
            fontSize: 19,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Professional safety guidance for workplaces across the UAE',
          style: TextStyle(
            color: Color(0xFF607D8B),
            fontSize: 11,
          ),
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
      borderRadius: BorderRadius.circular(17),
      child: InkWell(
        borderRadius: BorderRadius.circular(17),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(13),
          child: Row(
            children: [
              Container(
                width: 43,
                height: 43,
                decoration: BoxDecoration(
                  color: color.withAlpha(20),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 23,
                ),
              ),
              const SizedBox(width: 10),
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
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      '$count topics',
                      style: const TextStyle(
                        color: Color(0xFF607D8B),
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: color,
                size: 22,
              ),
            ],
          ),
        ),
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
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFCDEBDD),
        ),
      ),
      child: const Row(
        children: [
          Text(
            '🇦🇪',
            style: TextStyle(
              fontSize: 31,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'UAE-wide HSE Safety App',
                  style: TextStyle(
                    color: darkGreen,
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  'Built for HSE professionals and safer workplaces across the United Arab Emirates.',
                  style: TextStyle(
                    color: Color(0xFF527064),
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
            subtitle: 'UAE Regulations & Best Practices',
            icon: Icons.menu_book_rounded,
          ),
          Expanded(
            child: const GuidelinesPage(),
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
            subtitle: 'Report unsafe conditions and observations',
            icon: Icons.warning_rounded,
          ),
          const SizedBox(height: 12),
          _reportChoiceCard(
            title: 'Safety Observation',
            subtitle: 'Record a positive or unsafe safety observation.',
            icon: Icons.visibility_rounded,
            color: const Color(0xFF1475D1),
            onTap: () {
              _openPage(
                const SafetyObservationPage(),
              );
            },
          ),
          const SizedBox(height: 12),
          _reportChoiceCard(
            title: 'Report Hazard',
            subtitle: 'Report an unsafe condition or workplace hazard.',
            icon: Icons.warning_rounded,
            color: const Color(0xFFC51E30),
            onTap: () {
              _openPage(
                const HazardReportPage(),
              );
            },
          ),
          const SizedBox(height: 12),
          _reportChoiceCard(
            title: 'Observation History',
            subtitle: 'View previously submitted reports and observations.',
            icon: Icons.history_rounded,
            color: const Color(0xFF6330D7),
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
            subtitle: 'Explore UAE-wide safety guidance and best practices.',
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
            subtitle: 'Explore Abu Dhabi specific HSE requirements.',
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
            subtitle: 'Explore Dubai safety requirements and guidance.',
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
            subtitle: 'Useful professional HSE reference topics.',
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
                child: const Icon(
                  Icons.chevron_right_rounded,
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
              Icon(
                icon,
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
    return Container(
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

// ============================================================
// UAE SKYLINE PAINTER
// ============================================================

class _SkylinePainter extends CustomPainter {
  @override
  void paint(
    Canvas canvas,
    Size size,
  ) {
    final buildingPaint = Paint()
      ..color = const Color(0xFF79B7D7);

    final lightPaint = Paint()
      ..color = const Color(0xFFBDE5F5);

    final buildings = <Rect>[
      Rect.fromLTWH(
        8,
        70,
        25,
        85,
      ),
      Rect.fromLTWH(
        39,
        48,
        27,
        107,
      ),
      Rect.fromLTWH(
        73,
        83,
        25,
        72,
      ),
      Rect.fromLTWH(
        103,
        32,
        29,
        123,
      ),
      Rect.fromLTWH(
        137,
        65,
        25,
        90,
      ),
      Rect.fromLTWH(
        168,
        22,
        32,
        133,
      ),
      Rect.fromLTWH(
        207,
        70,
        26,
        85,
      ),
      Rect.fromLTWH(
        240,
        47,
        25,
        108,
      ),
      Rect.fromLTWH(
        271,
        82,
        26,
        73,
      ),
    ];

    for (int i = 0; i < buildings.length; i++) {
      canvas.drawRect(
        buildings[i],
        buildingPaint,
      );

      final rect = buildings[i];

      for (double y = rect.top + 10;
          y < rect.bottom - 7;
          y += 15) {
        canvas.drawRect(
          Rect.fromLTWH(
            rect.left + 5,
            y,
            5,
            4,
          ),
          lightPaint,
        );

        if (rect.width > 23) {
          canvas.drawRect(
            Rect.fromLTWH(
              rect.left + 15,
              y,
              5,
              4,
            ),
            lightPaint,
          );
        }
      }
    }

    // Tall central tower
    final towerPaint = Paint()
      ..color = const Color(0xFF5DA4C7);

    final towerPath = Path();

    towerPath.moveTo(
      size.width * 0.57,
      size.height,
    );

    towerPath.lineTo(
      size.width * 0.60,
      size.height * 0.17,
    );

    towerPath.lineTo(
      size.width * 0.63,
      size.height,
    );

    towerPath.close();

    canvas.drawPath(
      towerPath,
      towerPaint,
    );

    // Ground
    final groundPaint = Paint()
      ..color = const Color(0xFF4B9CB7);

    canvas.drawRect(
      Rect.fromLTWH(
        0,
        size.height - 9,
        size.width,
        9,
      ),
      groundPaint,
    );
  }

  @override
  bool shouldRepaint(
    covariant CustomPainter oldDelegate,
  ) {
    return false;
  }
}
