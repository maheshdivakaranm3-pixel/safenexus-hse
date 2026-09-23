import 'dart:convert';
import 'abu_dhabi_gold_root_page.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'guidelines.dart';
import 'hazard_report.dart';
import 'observation_history.dart';
import 'safety_observation.dart';
import 'voice_report.dart';
import 'models/guideline_category.dart';

import 'data/abu_dhabi_guidelines.dart';
import 'data/dubai_guidelines.dart';
import 'data/hse_safety_reference.dart';
import 'data/uae_general_guidelines.dart';
import 'tbt.dart';
import 'workhub.dart';
import 'safenexus_alert_center.dart';
import 'hse_analytics_center.dart';
import 'hse_workflow_approval.dart';
import 'hse_access_control.dart';
import 'hse_backup_recovery.dart';
import 'safenexus_unified_data_center.dart';

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

class _SafeNexusHomePageState extends State<SafeNexusHomePage> {
  // ==========================================================
  // COLORS
  // ==========================================================

  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF075B45);
  static const Color navy = Color(0xFF082653);

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
  // LOAD DASHBOARD STATISTICS
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

      final List<String> normalizedRecords = <String>[];
      bool storageChanged = false;

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

          final originalType = _stringValue(report['reportType']);
          final originalObservationType =
              _stringValue(report['observationType']);

          final canonicalType = _canonicalReportType(
            reportType: originalType,
            observationType: originalObservationType,
          );

          if (originalType != canonicalType) {
            report['reportType'] = canonicalType;
            storageChanged = true;
          } else if (originalType.isEmpty) {
            report['reportType'] = canonicalType;
            storageChanged = true;
          }

          normalizedRecords.add(jsonEncode(report));

          total++;

          if (canonicalType == 'Hazard Report') {
            hazards++;
          } else {
            observations++;
          }

          final status = _normalizeStatus(report['status']);

          if (_isOpenStatus(status)) {
            open++;
          }
        } catch (_) {
          // Ignore corrupted individual records.
          continue;
        }
      }

      // Keep dashboard classification aligned with Observation History.
      // Only rewrite storage when a legacy/missing reportType was normalized.
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

  // ==========================================================
  // CANONICAL REPORT TYPE
  // ==========================================================

  String _canonicalReportType({
    required String reportType,
    required String observationType,
  }) {
    final type = reportType.trim().toLowerCase();
    final legacyType = observationType.trim().toLowerCase();

    if (type.contains('hazard') ||
        legacyType.contains('hazard')) {
      return 'Hazard Report';
    }

    return 'Safety Observation';
  }

  // ==========================================================
  // NORMALIZED STATUS
  // ==========================================================

  String _normalizeStatus(dynamic value) {
    final status = _stringValue(value).toLowerCase();

    if (status.isEmpty) {
      return 'open';
    }

    if (status == 'in progress' ||
        status == 'in-progress' ||
        status == 'inprogress') {
      return 'in progress';
    }

    return status;
  }

  // ==========================================================
  // OPEN STATUS
  // ==========================================================

  bool _isOpenStatus(String status) {
    return status == 'open' ||
        status == 'pending' ||
        status == 'in progress';
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
          _buildReportHome(),
          const WorkHubPage(),
          _buildGuidelinesHome(),
          _buildSettingsHome(),
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
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home_rounded),
          label: 'Home',
        ),
        NavigationDestination(
          icon: Icon(Icons.warning_amber_outlined),
          selectedIcon: Icon(Icons.warning_rounded),
          label: 'Report',
        ),
        NavigationDestination(
          icon: Icon(Icons.work_outline_rounded),
          selectedIcon: Icon(Icons.work_rounded),
          label: 'WorkHub',
        ),
        NavigationDestination(
          icon: Icon(Icons.menu_book_outlined),
          selectedIcon: Icon(Icons.menu_book_rounded),
          label: 'Reference',
        ),
        NavigationDestination(
          icon: Icon(Icons.settings_outlined),
          selectedIcon: Icon(Icons.settings_rounded),
          label: 'Settings',
        ),
      ],
    );
  }

  // ==========================================================
  // DASHBOARD
  // ==========================================================

  Widget _buildDashboard() {
    return SafeArea(
      top: false,
      child: RefreshIndicator(
        onRefresh: _loadDashboardStats,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 24),
          children: [
            _buildProfessionalHeader(),
            _buildProfessionalHero(),
            const SizedBox(height: 22),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: _buildQuickActionsTitle(),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: _buildQuickActions(),
            ),
            const SizedBox(height: 18),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: _buildReferencePreview(),
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // PROFESSIONAL TOP HEADER
  //
  // IMAGE:
  // assets/images/safenexus_hse_header_mobile.png
  //
  // IMPORTANT:
  // BoxFit.contain keeps the FULL HEADER IMAGE visible.
  // No cropping.
  // ==========================================================

  Widget _buildProfessionalHeader() {
    return Container(
      width: double.infinity,
      height: 132,
      color: Colors.white,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 44,
              vertical: 8,
            ),
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Image.asset(
                'assets/images/safenexus_hse_header_mobile.png',
                fit: BoxFit.contain,
                alignment: Alignment.center,
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Text(
                      'SafeNexus HSE',
                      style: TextStyle(
                        color: navy,
                        fontWeight: FontWeight.w900,
                        fontSize: 22,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Positioned(
            right: 18,
            top: 0,
            bottom: 0,
            child: Center(
              child: IconButton(
                tooltip: 'Observation History',
                onPressed: () {
                  _openPage(const ObservationHistoryPage());
                },
                icon: const Icon(
                  Icons.history_rounded,
                  color: darkGreen,
                  size: 31,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // PROFESSIONAL HERO
  //
  // IMAGE:
  // assets/images/safenexus_hse_banner.png
  // ==========================================================

  Widget _buildProfessionalHero() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(24),
        ),
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: Image.asset(
            'assets/images/safenexus_hse_banner.png',
            width: double.infinity,
            fit: BoxFit.cover,
            alignment: Alignment.center,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF063E73),
                      Color(0xFF075B45),
                      Color(0xFF0B9860),
                    ],
                  ),
                ),
                child: const Center(
                  child: Icon(
                    Icons.image_not_supported_rounded,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // QUICK ACTIONS TITLE
  // ==========================================================

  Widget _buildQuickActionsTitle() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Safety Actions',
          style: TextStyle(
            color: navy,
            fontSize: 27,
            fontWeight: FontWeight.w900,
          ),
        ),
        SizedBox(height: 4),
        Text(
          'Field reporting',
          style: TextStyle(
            color: Color(0xFF607D8B),
            fontSize: 16,
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
                title: 'Safety Observation',
                subtitle: 'Record safe / unsafe conditions',
                icon: Icons.visibility_rounded,
                iconColor: primaryGreen,
                background: const Color(0xFFF4F7F1),
                onTap: () {
                  _openPage(const SafetyObservationPage());
                },
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: _quickActionCard(
                title: 'Hazard Report',
                subtitle: 'Report an immediate hazard',
                icon: Icons.warning_amber_rounded,
                iconColor: primaryGreen,
                background: const Color(0xFFF4F7F1),
                onTap: () {
                  _openPage(const HazardReportPage());
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(
              child: _quickActionCard(
                title: 'Voice Report',
                subtitle: 'Report by voice',
                icon: Icons.mic_rounded,
                iconColor: primaryGreen,
                background: const Color(0xFFF4F7F1),
                onTap: () {
                  _openPage(const VoiceReportPage());
                },
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: _quickActionCard(
                title: 'Report History',
                subtitle: 'Review saved reports',
                icon: Icons.history_rounded,
                iconColor: primaryGreen,
                background: const Color(0xFFF4F7F1),
                onTap: () {
                  _openPage(const ObservationHistoryPage());
                },
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
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 18, 16, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                icon,
                color: iconColor,
                size: 40,
              ),
              const SizedBox(height: 14),
              Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: navy,
                  fontSize: 17,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 7),
              Text(
                subtitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Color(0xFF78909C),
                  fontSize: 14,
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
  // SAFETY OVERVIEW
  // ==========================================================


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
        const Text(
          'HSE Reference',
          style: TextStyle(
            color: navy,
            fontSize: 27,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Professional UAE field reference',
          style: TextStyle(
            color: Color(0xFF78909C),
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 12),
        Material(
          color: const Color(0xFFF4F7F1),
          borderRadius: BorderRadius.circular(18),
          child: InkWell(
            borderRadius: BorderRadius.circular(18),
            onTap: () {
              _openGuidelineCategory(GuidelineCategory.uaeGeneral);
            },
            child: const Padding(
              padding: EdgeInsets.fromLTRB(18, 18, 16, 18),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 29,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.menu_book_rounded,
                      color: primaryGreen,
                      size: 30,
                    ),
                  ),
                  SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'UAE HSE Reference',
                          style: TextStyle(
                            color: navy,
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Federal laws, standards and best practices',
                          style: TextStyle(
                            color: Color(0xFF78909C),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.chevron_right_rounded,
                    color: primaryGreen,
                    size: 30,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }


  // ==========================================================
  // REFERENCE MINI CARD
  // ==========================================================

) {
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
        boxShadow: const [
          BoxShadow(
            color: Color(0x12000000),
            blurRadius: 12,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: Color(0xFFD7F0E3),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              Icons.flag_rounded,
              color: Color(0xFF159447),
              size: 30,
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

  void _openCanonicalFromHome(Widget page) {
    _openPage(page);
  }

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
            color: const Color(0xFFC51E30),
            onTap: () {
              _openPage(
                const HazardReportPage(),
              );
            },
          ),
          const SizedBox(height: 10),
          _reportChoiceCard(
            title: 'HSE Analytics',
            subtitle: 'KPIs, trends, completion rates and management metrics',
            icon: Icons.analytics_outlined,
            color: Color(0xFF159447),
            onTap: () => _openCanonicalFromHome(const HseAnalyticsCenterPage()),
          ),
          const SizedBox(height: 10),
          _reportChoiceCard(
            title: 'Alert Center',
            subtitle: 'Critical risks, overdue actions, permits and expiry alerts',
            icon: Icons.notifications_active_outlined,
            color: Color(0xFF8A4B08),
            onTap: () => _openCanonicalFromHome(const SafeNexusAlertCenterPage()),
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
  // SETTINGS HOME
  // ==========================================================

  Widget _buildSettingsHome() {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          _simplePageHeader(
            title: 'Settings',
            subtitle: 'SafeNexus HSE app settings',
            icon: Icons.settings_rounded,
          ),
          const SizedBox(height: 16),
          _settingsAction(
            title: 'App Information',
            subtitle: 'SafeNexus HSE - UAE-wide HSE Safety App',
            icon: Icons.info_outline_rounded,
            onTap: () {
              _showMessage(
                'SafeNexus HSE',
                'UAE-wide HSE Safety App for safer workplaces.',
              );
            },
          ),
          const SizedBox(height: 10),
          _settingsAction(
            title: 'HSE Guidelines',
            subtitle: 'UAE General, Abu Dhabi, Dubai & HSE references',
            icon: Icons.menu_book_rounded,
            onTap: _openGuidelines,
          ),
          const SizedBox(height: 10),
          _settingsAction(
            title: 'WorkHub',
            subtitle: 'HSE work planning and control',
            icon: Icons.work_outline_rounded,
            onTap: () {
              _openPage(const WorkHubPage());
            },
          ),
          const SizedBox(height: 10),
          const SizedBox(height: 10),
          _settingsAction(
            title: 'Workflow & Approval',
            subtitle: 'Review, approve and track HSE workflow actions',
            icon: Icons.approval_outlined,
            onTap: () => _openCanonicalFromHome(const HseWorkflowApprovalPage()),
          ),
          const SizedBox(height: 10),
          _settingsAction(
            title: 'Access Control',
            subtitle: 'HSE roles, access and authorization controls',
            icon: Icons.admin_panel_settings_outlined,
            onTap: () => _openCanonicalFromHome(const HseAccessControlPage()),
          ),
          const SizedBox(height: 10),
          _settingsAction(
            title: 'Backup & Recovery',
            subtitle: 'Backup records, verification and recovery readiness',
            icon: Icons.backup_outlined,
            onTap: () => _openCanonicalFromHome(const HseBackupRecoveryPage()),
          ),
          const SizedBox(height: 10),
          _settingsAction(
            title: 'Unified Data Center',
            subtitle: 'Cross-module HSE records and data management',
            icon: Icons.storage_outlined,
            onTap: () => _openCanonicalFromHome(const SafeNexusUnifiedDataCenterPage()),
          ),
          const SizedBox(height: 10),
          _settingsAction(
            title: 'Observation History',
            subtitle: 'View submitted safety observations and reports',
            icon: Icons.history_rounded,
            onTap: () {
              _openPage(const ObservationHistoryPage());
            },
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // SETTINGS ACTION
  // ==========================================================

  Widget _settingsAction({
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
  // PROFILE HOME
  // ==========================================================


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
    if (category == GuidelineCategory.abuDhabi) {
      await _openPage(
        const AbuDhabiGoldRootPage(),
      );
      return;
    }

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
