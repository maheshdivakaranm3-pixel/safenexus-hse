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
  State<SafeNexusHomePage> createState() => _SafeNexusHomePageState();
}

class _SafeNexusHomePageState extends State<SafeNexusHomePage> {
  // ==========================================================
  // COLORS
  // ==========================================================

  static const Color primaryGreen = Color(0xFF159447);

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

  int get _uaeGeneralCount => uaeGeneralGuidelines.length;

  int get _abuDhabiCount => abuDhabiGuidelines.length;

  int get _dubaiCount => dubaiGuidelines.length;

  int get _hseReferenceCount => hseSafetyReferences.length;

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

          final originalType =
              _stringValue(report['reportType']);

          final originalObservationType =
              _stringValue(report['observationType']);

          final canonicalType = _canonicalReportType(
            reportType: originalType,
            observationType: originalObservationType,
          );

          if (originalType != canonicalType ||
              originalType.isEmpty) {
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
  // STATUS
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
  // GUIDELINES
  // ==========================================================

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
  // BUILD
  // ==========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          _buildDashboard(),
          _buildLearningHome(),
          _buildNotificationHome(),
          _buildSettingsHome(),
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
    return NavigationBarTheme(
      data: NavigationBarThemeData(
        height: 82,
        backgroundColor: Colors.white,
        elevation: 8,
        indicatorColor: const Color(0xFFDDF2E5),
        labelTextStyle:
            WidgetStateProperty.resolveWith<TextStyle>(
          (states) {
            final selected =
                states.contains(WidgetState.selected);

            return TextStyle(
              fontSize: 11.5,
              fontWeight:
                  selected ? FontWeight.w700 : FontWeight.w500,
              color:
                  selected
                      ? const Color(0xFF075B45)
                      : const Color(0xFF424242),
            );
          },
        ),
        iconTheme:
            WidgetStateProperty.resolveWith<IconThemeData>(
          (states) {
            final selected =
                states.contains(WidgetState.selected);

            return IconThemeData(
              size: 25,
              color:
                  selected
                      ? const Color(0xFF075B45)
                      : const Color(0xFF424242),
            );
          },
        ),
      ),
      child: NavigationBar(
        selectedIndex: _currentIndex,
        labelBehavior:
            NavigationDestinationLabelBehavior.alwaysShow,
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
            icon: Icon(Icons.school_outlined),
            selectedIcon: Icon(Icons.school_rounded),
            label: 'Learning',
          ),
          NavigationDestination(
            icon: Icon(Icons.notifications_none_rounded),
            selectedIcon: Icon(Icons.notifications_rounded),
            label: 'Notification',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings_rounded),
            label: 'Settings',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline_rounded),
            selectedIcon: Icon(Icons.person_rounded),
            label: 'Profile',
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
        onRefresh: _loadDashboardStats,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(
            16,
            8,
            16,
            28,
          ),
          children: [
            _buildProfessionalHeader(),
            const SizedBox(height: 14),
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
  // ==========================================================

  Widget _buildProfessionalHeader() {
    return Container(
      width: double.infinity,
      height: 105,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFE1E8EE),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(10),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Image.asset(
        'assets/images/safenexus_hse_header_mobile.png',
        fit: BoxFit.contain,
        alignment: Alignment.center,
        errorBuilder: (context, error, stackTrace) {
          return const Center(
            child: Text(
              'SafeNexus HSE',
              style: TextStyle(
                color: Color(0xFF082653),
                fontWeight: FontWeight.w800,
                fontSize: 14,
              ),
            ),
          );
        },
      ),
    );
  }

  // ==========================================================
  // HERO
  // ==========================================================

  Widget _buildProfessionalHero() {
    return Container(
      width: double.infinity,
      height: 155,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(22),
            blurRadius: 14,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Image.asset(
        'assets/images/safenexus_hse_banner.png',
        width: double.infinity,
        height: double.infinity,
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
                Icons.shield_rounded,
                color: Colors.white,
                size: 42,
              ),
            ),
          );
        },
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Quick Actions',
                style: TextStyle(
                  color: Color(0xFF082653),
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
                  color: Color(0xFF075B45),
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
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color(0xFF082653),
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
                    color: Color(0xFF082653),
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
                    color: Color(0xFF075B45),
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
                  value:
                      _loadingStats
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
                  value:
                      _loadingStats
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
                  value:
                      _loadingStats
                          ? '...'
                          : _openReports.toString(),
                  title: 'Open Reports',
                ),
              ),
              _overviewDivider(),
              Expanded(
                child: _overviewMetric(
                  icon:
                      Icons.assignment_turned_in_rounded,
                  iconColor: primaryGreen,
                  value:
                      _loadingStats
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
            color: Color(0xFF082653),
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
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    'UAE HSE Reference',
                    style: TextStyle(
                      color: Color(0xFF082653),
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
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color(0xFF082653),
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
      width: double.infinity,
      height: 128,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0xFF075B45),
            Color(0xFF0B9860),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 16,
            top: 19,
            child: Container(
              width: 76,
              height: 76,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withAlpha(10),
                border: Border.all(
                  color: Colors.white.withAlpha(35),
                  width: 1.2,
                ),
              ),
              child: const Center(
                child: Icon(
                  Icons.shield_rounded,
                  color: Colors.white,
                  size: 38,
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 96,
                right: 20,
                top: 13,
                bottom: 10,
              ),
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center,
                crossAxisAlignment:
                    CrossAxisAlignment.center,
                children: [
                  const FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      'Small Actions. Safer UAE.',
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Every observation matters. Every action counts.',
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFFE6FFF3),
                      fontSize: 11.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'SafeNexus HSE - UAE',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF075B45),
                        fontSize: 11.5,
                        fontWeight: FontWeight.w900,
                      ),
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
            style: TextStyle(fontSize: 28),
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
                    color: Color(0xFF075B45),
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
  // LEARNING
  // ==========================================================

  Widget _buildLearningHome() {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          _simplePageHeader(
            title: 'Learning Center',
            subtitle: 'Build Knowledge - Build a Safer You',
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
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Color(0xFF082653),
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
  // NOTIFICATIONS
  // ==========================================================

  Widget _buildNotificationHome() {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(
          18,
          20,
          18,
          28,
        ),
        children: [
          _simplePageHeader(
            title: 'Notifications',
            subtitle: 'Safety alerts and important updates',
            icon: Icons.notifications_rounded,
          ),
          const SizedBox(height: 18),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(
                color: const Color(0xFFE1E8EE),
              ),
            ),
            child: Column(
              children: [
                Container(
                  width: 74,
                  height: 74,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE9F8F1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.notifications_none_rounded,
                    color: primaryGreen,
                    size: 38,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'You are all caught up',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF082653),
                    fontSize: 19,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 7),
                const Text(
                  'No new safety notifications or updates at the moment.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF607D8B),
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _notificationInfoCard(
            icon: Icons.shield_rounded,
            title: 'Safety Updates',
            subtitle:
                'Important HSE safety information will appear here.',
          ),
          const SizedBox(height: 10),
          _notificationInfoCard(
            icon: Icons.campaign_rounded,
            title: 'App Updates',
            subtitle:
                'New SafeNexus HSE features and updates will appear here.',
          ),
        ],
      ),
    );
  }

  Widget _notificationInfoCard({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFE1E8EE),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: primaryGreen.withAlpha(18),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              icon,
              color: primaryGreen,
              size: 24,
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
                    color: Color(0xFF082653),
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
  // SETTINGS
  // ==========================================================

  Widget _buildSettingsHome() {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(
          18,
          20,
          18,
          28,
        ),
        children: [
          _settingsHeader(),
          const SizedBox(height: 18),
          _settingsActionCard(
            icon: Icons.language_rounded,
            title: 'Language',
            subtitle: 'English',
            onTap: () {
              _showMessage(
                'Language',
                'English is currently available in SafeNexus HSE.',
              );
            },
          ),
          const SizedBox(height: 10),
          _settingsActionCard(
            icon: Icons.palette_outlined,
            title: 'Appearance',
            subtitle: 'Light theme',
            onTap: () {
              _showMessage(
                'Appearance',
                'Light theme is currently enabled.',
              );
            },
          ),
          const SizedBox(height: 10),
          _settingsActionCard(
            icon: Icons.info_outline_rounded,
            title: 'About SafeNexus HSE',
            subtitle: 'UAE-wide HSE safety app',
            onTap: () {
              _openPage(
                const AboutSafeNexusPage(),
              );
            },
          ),
          const SizedBox(height: 10),
          _settingsActionCard(
            icon: Icons.verified_outlined,
            title: 'App Version',
            subtitle: 'Version 1.0.1',
            onTap: () {
              _showMessage(
                'SafeNexus HSE',
                'Version 1.0.1',
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _settingsHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Container(
            width: 76,
            height: 76,
            decoration: BoxDecoration(
              color: const Color(0xFFE9F8F1),
              borderRadius: BorderRadius.circular(22),
            ),
            child: const Icon(
              Icons.settings_rounded,
              color: primaryGreen,
              size: 40,
            ),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  'Settings',
                  style: TextStyle(
                    color: Color(0xFF082653),
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Manage your SafeNexus HSE preferences',
                  style: TextStyle(
                    color: Color(0xFF78909C),
                    fontSize: 12.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _settingsActionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(22),
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(17),
          child: Row(
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF7F0),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Icon(
                  icon,
                  color: primaryGreen,
                  size: 31,
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Color(0xFF082653),
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: Color(0xFF52636A),
                        fontSize: 12.5,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                color: Color(0xFF4E5653),
                size: 29,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // PROFILE HOME - EXPANDED
  // ==========================================================

  Widget _buildProfileHome() {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(
          18,
          18,
          18,
          30,
        ),
        children: [
          _simplePageHeader(
            title: 'SafeNexus Profile',
            subtitle: 'Your HSE safety workspace',
            icon: Icons.person_rounded,
          ),

          const SizedBox(height: 14),

          // ----------------------------------------------------
          // PROFILE CARD
          // ----------------------------------------------------

          _profileHeroCard(),

          const SizedBox(height: 16),

          const Text(
            'My Safety',
            style: TextStyle(
              color: Color(0xFF082653),
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),

          const SizedBox(height: 9),

          _profileAction(
            title: 'Observation History',
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
            title: 'My Safety Activity',
            subtitle:
                'View your safety reporting statistics',
            icon: Icons.analytics_rounded,
            onTap: () {
              _openPage(
                SafetyActivityPage(
                  totalReports: _totalReports,
                  hazards: _hazards,
                  observations: _observations,
                  openReports: _openReports,
                ),
              );
            },
          ),

          const SizedBox(height: 10),

          _profileAction(
            title: 'Safety Performance',
            subtitle:
                'Review your overall safety contribution',
            icon: Icons.emoji_events_rounded,
            onTap: () {
              _openPage(
                SafetyPerformancePage(
                  totalReports: _totalReports,
                  hazards: _hazards,
                  observations: _observations,
                  openReports: _openReports,
                ),
              );
            },
          ),

          const SizedBox(height: 18),

          const Text(
            'HSE Resources',
            style: TextStyle(
              color: Color(0xFF082653),
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),

          const SizedBox(height: 9),

          _profileAction(
            title: 'UAE HSE Guidelines',
            subtitle:
                'Open the UAE safety reference library',
            icon: Icons.menu_book_rounded,
            onTap: _openGuidelines,
          ),

          const SizedBox(height: 10),

          _profileAction(
            title: 'UAE General HSE',
            subtitle:
                'UAE-wide safety guidance',
            icon: Icons.flag_rounded,
            onTap: () {
              _openGuidelineCategory(
                GuidelineCategory.uaeGeneral,
              );
            },
          ),

          const SizedBox(height: 10),

          _profileAction(
            title: 'Abu Dhabi HSE',
            subtitle:
                'Abu Dhabi specific HSE guidance',
            icon: Icons.location_city_rounded,
            onTap: () {
              _openGuidelineCategory(
                GuidelineCategory.abuDhabi,
              );
            },
          ),

          const SizedBox(height: 10),

          _profileAction(
            title: 'Dubai HSE',
            subtitle:
                'Dubai specific HSE guidance',
            icon: Icons.apartment_rounded,
            onTap: () {
              _openGuidelineCategory(
                GuidelineCategory.dubai,
              );
            },
          ),

          const SizedBox(height: 10),

          _profileAction(
            title: 'Professional HSE Reference',
            subtitle:
                'Professional HSE reference topics',
            icon: Icons.library_books_rounded,
            onTap: () {
              _openGuidelineCategory(
                GuidelineCategory.hseReference,
              );
            },
          ),

          const SizedBox(height: 18),

          const Text(
            'About',
            style: TextStyle(
              color: Color(0xFF082653),
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),

          const SizedBox(height: 9),

          _profileAction(
            title: 'About SafeNexus HSE',
            subtitle:
                'Learn about the SafeNexus platform',
            icon: Icons.info_outline_rounded,
            onTap: () {
              _openPage(
                const AboutSafeNexusPage(),
              );
            },
          ),

          const SizedBox(height: 10),

          _profileAction(
            title: 'UAE HSE Platform',
            subtitle:
                'SafeNexus HSE vision for safer UAE workplaces',
            icon: Icons.public_rounded,
            onTap: () {
              _openPage(
                const UaePlatformPage(),
              );
            },
          ),

          const SizedBox(height: 16),

          _buildUaeCard(),
        ],
      ),
    );
  }

  // ==========================================================
  // PROFILE HERO
  // ==========================================================

  Widget _profileHeroCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF0A8653),
            Color(0xFF075B45),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(20),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white.withAlpha(80),
                width: 2,
              ),
            ),
            child: const Icon(
              Icons.person_rounded,
              color: Color(0xFF075B45),
              size: 42,
            ),
          ),
          const SizedBox(width: 15),
          const Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  'HSE Professional',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'SafeNexus HSE - UAE',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.shield_rounded,
                      color: Colors.white,
                      size: 15,
                    ),
                    SizedBox(width: 5),
                    Text(
                      'Safety starts with awareness',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
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
      borderRadius: BorderRadius.circular(19),
      child: InkWell(
        borderRadius: BorderRadius.circular(19),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: primaryGreen.withAlpha(18),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(
                  icon,
                  color: primaryGreen,
                  size: 26,
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
                        color: Color(0xFF082653),
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color(0xFF607D8B),
                        fontSize: 10.5,
                        height: 1.25,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
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
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF082653),
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
              color: Color(0xFF082653),
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

// ============================================================================
// SAFETY ACTIVITY PAGE
// ============================================================================

class SafetyActivityPage extends StatelessWidget {
  const SafetyActivityPage({
    super.key,
    required this.totalReports,
    required this.hazards,
    required this.observations,
    required this.openReports,
  });

  final int totalReports;
  final int hazards;
  final int observations;
  final int openReports;

  static const Color green = Color(0xFF159447);
  static const Color navy = Color(0xFF082653);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Safety Activity',
          style: TextStyle(
            color: navy,
            fontWeight: FontWeight.w800,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: navy,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          _introCard(),
          const SizedBox(height: 18),
          _statCard(
            icon: Icons.assignment_turned_in_rounded,
            title: 'Total Reports',
            value: totalReports,
            color: green,
          ),
          const SizedBox(height: 10),
          _statCard(
            icon: Icons.warning_amber_rounded,
            title: 'Hazard Reports',
            value: hazards,
            color: const Color(0xFFC51E30),
          ),
          const SizedBox(height: 10),
          _statCard(
            icon: Icons.visibility_rounded,
            title: 'Safety Observations',
            value: observations,
            color: const Color(0xFF1475D1),
          ),
          const SizedBox(height: 10),
          _statCard(
            icon: Icons.pending_actions_rounded,
            title: 'Open Reports',
            value: openReports,
            color: const Color(0xFFB16A00),
          ),
          const SizedBox(height: 20),
          _infoCard(
            icon: Icons.lightbulb_rounded,
            title: 'Keep Reporting',
            text:
                'Every hazard identified and every safety observation submitted can help create a safer workplace.',
          ),
        ],
      ),
    );
  }

  Widget _introCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF075B45),
            Color(0xFF0B9860),
          ],
        ),
        borderRadius: BorderRadius.circular(23),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.analytics_rounded,
            color: Colors.white,
            size: 34,
          ),
          SizedBox(height: 12),
          Text(
            'Your Safety Activity',
            style: TextStyle(
              color: Colors.white,
              fontSize: 21,
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(height: 5),
          Text(
            'A simple overview of your contribution to workplace safety.',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 11.5,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _statCard({
    required IconData icon,
    required String title,
    required int value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(19),
        border: Border.all(
          color: const Color(0xFFE1E8EE),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: color.withAlpha(18),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(
              icon,
              color: color,
              size: 27,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: navy,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Text(
            value.toString(),
            style: TextStyle(
              color: color,
              fontSize: 25,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoCard({
    required IconData icon,
    required String title,
    required String text,
  }) {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: const Color(0xFFE9F8F1),
        borderRadius: BorderRadius.circular(19),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.lightbulb_rounded,
            color: green,
            size: 25,
          ),
          const SizedBox(width: 11),
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
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  text,
                  style: const TextStyle(
                    color: Color(0xFF527064),
                    fontSize: 11,
                    height: 1.4,
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

// ============================================================================
// SAFETY PERFORMANCE PAGE
// ============================================================================

class SafetyPerformancePage extends StatelessWidget {
  const SafetyPerformancePage({
    super.key,
    required this.totalReports,
    required this.hazards,
    required this.observations,
    required this.openReports,
  });

  final int totalReports;
  final int hazards;
  final int observations;
  final int openReports;

  static const Color green = Color(0xFF159447);
  static const Color navy = Color(0xFF082653);

  @override
  Widget build(BuildContext context) {
    final score =
        totalReports == 0
            ? 0
            : (observations * 2 + hazards).clamp(0, 100);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Safety Performance',
          style: TextStyle(
            color: navy,
            fontWeight: FontWeight.w800,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: navy,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF075B45),
                  Color(0xFF0B9860),
                ],
              ),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Column(
              children: [
                const Text(
                  'Safety Contribution',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '$score',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 52,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const Text(
                  'Activity Score',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          _performanceItem(
            icon: Icons.visibility_rounded,
            title: 'Safety Awareness',
            value:
                observations > 0
                    ? 'Active'
                    : 'Start observing',
            color: const Color(0xFF1475D1),
          ),
          const SizedBox(height: 10),
          _performanceItem(
            icon: Icons.warning_amber_rounded,
            title: 'Hazard Identification',
            value:
                hazards > 0
                    ? 'Contributing'
                    : 'No hazards reported',
            color: const Color(0xFFC51E30),
          ),
          const SizedBox(height: 10),
          _performanceItem(
            icon: Icons.pending_actions_rounded,
            title: 'Open Reports',
            value: openReports.toString(),
            color: const Color(0xFFB16A00),
          ),
          const SizedBox(height: 10),
          _performanceItem(
            icon: Icons.assignment_turned_in_rounded,
            title: 'Total Contribution',
            value: totalReports.toString(),
            color: green,
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: const Color(0xFFE1E8EE),
              ),
            ),
            child: const Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  'Safety Mindset',
                  style: TextStyle(
                    color: navy,
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 7),
                Text(
                  'Good HSE performance starts with identifying hazards, making observations, reporting concerns and taking action.',
                  style: TextStyle(
                    color: Color(0xFF607D8B),
                    fontSize: 11.5,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _performanceItem({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(19),
        border: Border.all(
          color: const Color(0xFFE1E8EE),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: color.withAlpha(18),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              icon,
              color: color,
              size: 25,
            ),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: navy,
                fontSize: 13.5,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Text(
            value,
            textAlign: TextAlign.end,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// ABOUT SAFE NEXUS PAGE
// ============================================================================

class AboutSafeNexusPage extends StatelessWidget {
  const AboutSafeNexusPage({super.key});

  static const Color green = Color(0xFF159447);
  static const Color navy = Color(0xFF082653);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'About SafeNexus HSE',
          style: TextStyle(
            color: navy,
            fontWeight: FontWeight.w800,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: navy,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          Container(
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF075B45),
                  Color(0xFF0B9860),
                ],
              ),
              borderRadius: BorderRadius.circular(25),
            ),
            child: const Column(
              children: [
                CircleAvatar(
                  radius: 38,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.shield_rounded,
                    color: green,
                    size: 44,
                  ),
                ),
                SizedBox(height: 14),
                Text(
                  'SafeNexus HSE',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'UAE-wide HSE Safety App',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          _aboutCard(
            title: 'Our Purpose',
            text:
                'SafeNexus HSE is designed to support safer workplaces by making safety reporting, observation and HSE reference information easier to access.',
          ),
          const SizedBox(height: 10),
          _aboutCard(
            title: 'Built for UAE',
            text:
                'The platform is designed with UAE-wide HSE use in mind, while supporting emirate-specific guidance such as Abu Dhabi and Dubai requirements.',
          ),
          const SizedBox(height: 10),
          _aboutCard(
            title: 'Core Focus',
            text:
                'Hazard reporting, safety observations, HSE learning and practical safety reference information.',
          ),
          const SizedBox(height: 10),
          _aboutCard(
            title: 'Version',
            text:
                'SafeNexus HSE Version 1.0.1',
          ),
          const SizedBox(height: 20),
          const Center(
            child: Text(
              'Safe People • Safe Workplaces • Safer UAE',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: green,
                fontSize: 12,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _aboutCard({
    required String title,
    required String text,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(19),
        border: Border.all(
          color: const Color(0xFFE1E8EE),
        ),
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: navy,
              fontSize: 15,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            text,
            style: const TextStyle(
              color: Color(0xFF607D8B),
              fontSize: 11.5,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// UAE PLATFORM PAGE
// ============================================================================

class UaePlatformPage extends StatelessWidget {
  const UaePlatformPage({super.key});

  static const Color green = Color(0xFF159447);
  static const Color navy = Color(0xFF082653);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'UAE HSE Platform',
          style: TextStyle(
            color: navy,
            fontWeight: FontWeight.w800,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: navy,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: const Color(0xFFE9F8F1),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: const Color(0xFFCDEBDD),
              ),
            ),
            child: const Column(
              children: [
                Text(
                  '🇦🇪',
                  style: TextStyle(fontSize: 48),
                ),
                SizedBox(height: 10),
                Text(
                  'Safer UAE Workplaces',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: navy,
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 7),
                Text(
                  'One safety platform for HSE awareness, reporting and learning.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF527064),
                    fontSize: 11.5,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          _platformCard(
            icon: Icons.warning_amber_rounded,
            title: 'Hazard Reporting',
            text:
                'Identify and report unsafe conditions before they become incidents.',
          ),
          const SizedBox(height: 10),
          _platformCard(
            icon: Icons.visibility_rounded,
            title: 'Safety Observations',
            text:
                'Record positive and improvement-focused safety observations.',
          ),
          const SizedBox(height: 10),
          _platformCard(
            icon: Icons.menu_book_rounded,
            title: 'HSE Learning',
            text:
                'Access UAE General, Abu Dhabi, Dubai and professional HSE reference topics.',
          ),
          const SizedBox(height: 10),
          _platformCard(
            icon: Icons.public_rounded,
            title: 'UAE-wide Vision',
            text:
                'Designed to grow as a UAE-wide HSE safety platform.',
          ),
        ],
      ),
    );
  }

  Widget _platformCard({
    required IconData icon,
    required String title,
    required String text,
  }) {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(19),
        border: Border.all(
          color: const Color(0xFFE1E8EE),
        ),
      ),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Container(
            width: 49,
            height: 49,
            decoration: BoxDecoration(
              color: green.withAlpha(18),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              icon,
              color: green,
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
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  text,
                  style: const TextStyle(
                    color: Color(0xFF607D8B),
                    fontSize: 11,
                    height: 1.4,
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
