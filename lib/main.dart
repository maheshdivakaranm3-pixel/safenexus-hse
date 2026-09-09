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
  // REFERENCE COUNTS
  // ==========================================================

  int get _uaeGeneralCount => uaeGeneralGuidelines.length;

  int get _abuDhabiCount => abuDhabiGuidelines.length;

  int get _dubaiCount => dubaiGuidelines.length;

  int get _hseReferenceCount => hseSafetyReferences.length;

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

      if (!mounted) return;

      setState(() {
        _totalReports = total;
        _observations = observations;
        _hazards = hazards;
        _openReports = open;
        _loadingStats = false;
      });
    } catch (_) {
      if (!mounted) return;

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
  // REPORT TYPE
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
  // STRING
  // ==========================================================

  String _stringValue(dynamic value) {
    if (value == null) {
      return '';
    }

    return value.toString().trim();
  }

  // ==========================================================
  // PAGE NAVIGATION
  // ==========================================================

  Future<void> _openPage(Widget page) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => page,
      ),
    );

    if (!mounted) return;

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
              fontWeight: selected
                  ? FontWeight.w700
                  : FontWeight.w500,
              color: selected
                  ? darkGreen
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
              color: selected
                  ? darkGreen
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

          if (index == 0 || index == 4) {
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
          physics:
              const AlwaysScrollableScrollPhysics(),
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
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.image_not_supported_rounded,
                  color: primaryGreen,
                  size: 30,
                ),
                SizedBox(height: 4),
                Text(
                  'SafeNexus HSE',
                  style: TextStyle(
                    color: navy,
                    fontWeight: FontWeight.w800,
                    fontSize: 12,
                  ),
                ),
              ],
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
                Icons.image_not_supported_rounded,
                color: Colors.white,
                size: 40,
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
            crossAxisAlignment:
                CrossAxisAlignment.start,
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
                        fontSize: 13.5,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      maxLines: 1,
                      overflow:
                          TextOverflow.ellipsis,
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
                    fontWeight: FontWeight.w900,
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
                  color: const Color(0xFFEAF8F0),
                  borderRadius:
                      BorderRadius.circular(15),
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
                  icon: Icons.visibility_rounded,
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
                  icon: Icons.pending_actions_rounded,
                  iconColor:
                      const Color(0xFFB16A00),
                  value: _loadingStats
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
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(18),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
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
          Positioned(
            right: 8,
            bottom: -10,
            child: Opacity(
              opacity: 0.16,
              child: Transform.rotate(
                angle: -0.25,
                child: const Icon(
                  Icons.eco_rounded,
                  color: Colors.white,
                  size: 72,
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 96,
                right: 30,
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
                      height: 1.22,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(20),
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
        boxShadow: const [
          BoxShadow(
            color: Color(0x12000000),
            blurRadius: 12,
            offset: Offset(0, 5),
          ),
        ],
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
  // LEARNING
  // ==========================================================

  Widget _buildLearningHome() {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          _simplePageHeader(
            title: 'Learning Center',
            subtitle:
                'Build Knowledge - Build a Safer You',
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
            subtitle:
                'Safety alerts and important updates',
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
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(10),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
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
                    color: navy,
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
              borderRadius:
                  BorderRadius.circular(14),
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

          // LANGUAGE
          _settingsActionCard(
            icon: Icons.language_rounded,
            title: 'Language',
            subtitle: 'English',
            onTap: _showLanguageDialog,
          ),

          const SizedBox(height: 10),

          // APPEARANCE
          _settingsActionCard(
            icon: Icons.palette_outlined,
            title: 'Appearance',
            subtitle: 'System Default • Light • Dark',
            onTap: _showAppearanceDialog,
          ),

          const SizedBox(height: 10),

          // PRIVACY & SECURITY
          _settingsActionCard(
            icon: Icons.lock_outline_rounded,
            title: 'Privacy & Security',
            subtitle:
                'Privacy information • App permissions',
            onTap: _showPrivacySecurityDialog,
          ),

          const SizedBox(height: 10),

          // DATA & STORAGE
          _settingsActionCard(
            icon: Icons.storage_rounded,
            title: 'Data & Storage',
            subtitle:
                'Saved reports / local data • Clear local data',
            onTap: _showDataStorageDialog,
          ),

          const SizedBox(height: 10),

          // ABOUT
          _settingsActionCard(
            icon: Icons.info_outline_rounded,
            title: 'About SafeNexus HSE',
            subtitle:
                'App information • Version • Description',
            onTap: _showAboutDialog,
          ),

          const SizedBox(height: 10),

          // LEGAL
          _settingsActionCard(
            icon: Icons.gavel_rounded,
            title: 'Legal',
            subtitle:
                'Privacy Policy • Terms & Conditions • Disclaimer',
            onTap: _showLegalDialog,
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // SETTINGS HEADER
  // ==========================================================

  Widget _settingsHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(10),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 76,
            height: 76,
            decoration: BoxDecoration(
              color: const Color(0xFFE9F8F1),
              borderRadius:
                  BorderRadius.circular(22),
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
                    color: navy,
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
  // SETTINGS CARD
  // ==========================================================

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
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF7F0),
                  borderRadius:
                      BorderRadius.circular(17),
                ),
                child: Icon(
                  icon,
                  color: primaryGreen,
                  size: 29,
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
                        color: navy,
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      maxLines: 2,
                      overflow:
                          TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color(0xFF52636A),
                        fontSize: 11.5,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                color: Color(0xFF4E5653),
                size: 28,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // LANGUAGE DIALOG
  // ==========================================================

  void _showLanguageDialog() {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
          title: const Text(
            'Language',
            style: TextStyle(
              color: navy,
              fontWeight: FontWeight.w800,
            ),
          ),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(
                  Icons.check_circle_rounded,
                  color: primaryGreen,
                ),
                title: Text('English'),
                subtitle: Text('Current language'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () =>
                  Navigator.pop(context),
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

  // ==========================================================
  // APPEARANCE DIALOG
  // ==========================================================

  void _showAppearanceDialog() {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
          title: const Text(
            'Appearance',
            style: TextStyle(
              color: navy,
              fontWeight: FontWeight.w800,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _appearanceOption(
                icon: Icons.settings_suggest_rounded,
                title: 'System Default',
              ),
              _appearanceOption(
                icon: Icons.light_mode_rounded,
                title: 'Light',
              ),
              _appearanceOption(
                icon: Icons.dark_mode_rounded,
                title: 'Dark',
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _appearanceOption({
    required IconData icon,
    required String title,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: primaryGreen,
      ),
      title: Text(title),
      onTap: () {
        Navigator.pop(context);
        _showMessage(
          'Appearance',
          '$title appearance option selected.',
        );
      },
    );
  }

  // ==========================================================
  // PRIVACY & SECURITY
  // ==========================================================

  void _showPrivacySecurityDialog() {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
          title: const Text(
            'Privacy & Security',
            style: TextStyle(
              color: navy,
              fontWeight: FontWeight.w800,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(
                  Icons.privacy_tip_outlined,
                  color: primaryGreen,
                ),
                title: const Text(
                  'Privacy information',
                ),
                onTap: () {
                  Navigator.pop(context);
                  _showMessage(
                    'Privacy Information',
                    'SafeNexus HSE uses local storage for saved safety reports and app data.',
                  );
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.admin_panel_settings_outlined,
                  color: primaryGreen,
                ),
                title: const Text(
                  'App permissions',
                ),
                onTap: () {
                  Navigator.pop(context);
                  _showMessage(
                    'App Permissions',
                    'Camera, microphone and other permissions are used only when required by relevant HSE features.',
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // ==========================================================
  // DATA & STORAGE
  // ==========================================================

  Future<void> _showDataStorageDialog() async {
    final prefs = await SharedPreferences.getInstance();

    if (!mounted) return;

    final records =
        prefs.getStringList(_storageKey) ?? <String>[];

    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
          title: const Text(
            'Data & Storage',
            style: TextStyle(
              color: navy,
              fontWeight: FontWeight.w800,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(
                  Icons.description_outlined,
                  color: primaryGreen,
                ),
                title: const Text(
                  'Saved reports / local data',
                ),
                subtitle: Text(
                  '${records.length} saved report(s)',
                ),
              ),
              ListTile(
                leading: const Icon(
                  Icons.delete_outline_rounded,
                  color: Color(0xFFC51E30),
                ),
                title: const Text(
                  'Clear local data',
                ),
                subtitle: const Text(
                  'Delete saved reports from this device',
                ),
                onTap: () {
                  Navigator.pop(context);
                  _confirmClearLocalData();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // ==========================================================
  // CLEAR LOCAL DATA
  // ==========================================================

  void _confirmClearLocalData() {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
          title: const Text(
            'Clear local data?',
            style: TextStyle(
              color: navy,
              fontWeight: FontWeight.w800,
            ),
          ),
          content: const Text(
            'This will remove saved reports and local observation data from this device.',
          ),
          actions: [
            TextButton(
              onPressed: () =>
                  Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context);

                final prefs =
                    await SharedPreferences
                        .getInstance();

                await prefs.remove(_storageKey);

                await _loadDashboardStats();

                if (!mounted) return;

                _showMessage(
                  'Data Cleared',
                  'Local report data has been cleared from this device.',
                );
              },
              child: const Text(
                'Clear',
                style: TextStyle(
                  color: Color(0xFFC51E30),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // ==========================================================
  // ABOUT
  // ==========================================================

  void _showAboutDialog() {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
          title: const Text(
            'About SafeNexus HSE',
            style: TextStyle(
              color: navy,
              fontWeight: FontWeight.w800,
            ),
          ),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                'SafeNexus HSE',
                style: TextStyle(
                  color: primaryGreen,
                  fontSize: 19,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Version 1.0.1',
                style: TextStyle(
                  color: navy,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'AI-Powered HSE Safety & Observation App for UAE.',
                style: TextStyle(
                  color: Color(0xFF455A64),
                  height: 1.4,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Safe People - Safe Workplaces - Safer UAE',
                style: TextStyle(
                  color: darkGreen,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () =>
                  Navigator.pop(context),
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

  // ==========================================================
  // LEGAL
  // ==========================================================

  void _showLegalDialog() {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
          title: const Text(
            'Legal',
            style: TextStyle(
              color: navy,
              fontWeight: FontWeight.w800,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(
                  Icons.privacy_tip_outlined,
                  color: primaryGreen,
                ),
                title: const Text(
                  'Privacy Policy',
                ),
                onTap: () {
                  Navigator.pop(context);
                  _showMessage(
                    'Privacy Policy',
                    'Privacy Policy content can be added here.',
                  );
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.description_outlined,
                  color: primaryGreen,
                ),
                title: const Text(
                  'Terms & Conditions',
                ),
                onTap: () {
                  Navigator.pop(context);
                  _showMessage(
                    'Terms & Conditions',
                    'Terms & Conditions content can be added here.',
                  );
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.warning_amber_rounded,
                  color: const Color(0xFFB16A00),
                ),
                title: const Text(
                  'Disclaimer',
                ),
                onTap: () {
                  Navigator.pop(context);
                  _showMessage(
                    'Disclaimer',
                    'SafeNexus HSE provides safety information and reference material. Users should always follow applicable UAE laws, regulations, company procedures and competent professional advice.',
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // ==========================================================
  // PROFILE
  // ==========================================================

  Widget _buildProfileHome() {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(
          18,
          18,
          18,
          28,
        ),
        children: [
          _simplePageHeader(
            title: 'Profile',
            subtitle:
                'Your HSE safety workspace',
            icon: Icons.person_rounded,
          ),

          const SizedBox(height: 16),

          // ----------------------------------------------------
          // HSE PROFESSIONAL
          // ----------------------------------------------------

          _buildProfileProfessionalCard(),

          const SizedBox(height: 14),

          // ----------------------------------------------------
          // MY REPORTS
          // ----------------------------------------------------

          _profileSectionTitle(
            'My Reports',
            'Your submitted safety reports',
            Icons.assignment_rounded,
          ),

          const SizedBox(height: 9),

          _profileAction(
            title: 'Hazard Reports',
            subtitle:
                'View hazard reports submitted by you',
            icon: Icons.warning_amber_rounded,
            iconColor: const Color(0xFFC51E30),
            onTap: () {
              _openPage(
                const ObservationHistoryPage(),
              );
            },
          ),

          const SizedBox(height: 9),

          _profileAction(
            title: 'Safety Observations',
            subtitle:
                'View your submitted safety observations',
            icon: Icons.visibility_rounded,
            iconColor: const Color(0xFF1475D1),
            onTap: () {
              _openPage(
                const ObservationHistoryPage(),
              );
            },
          ),

          const SizedBox(height: 9),

          _profileAction(
            title: 'Report Status',
            subtitle:
                'Check open and completed reports',
            icon: Icons.pending_actions_rounded,
            iconColor: const Color(0xFFB16A00),
            onTap: () {
              _openPage(
                const ObservationHistoryPage(),
              );
            },
          ),

          const SizedBox(height: 18),

          // ----------------------------------------------------
          // MY SAFETY ACTIVITY
          // ----------------------------------------------------

          _profileSectionTitle(
            'My Safety Activity',
            'Your HSE reporting activity',
            Icons.analytics_rounded,
          ),

          const SizedBox(height: 9),

          _buildProfileActivityCard(),

          const SizedBox(height: 18),

          // ----------------------------------------------------
          // HSE GUIDELINES
          // ----------------------------------------------------

          _profileSectionTitle(
            'HSE Guidelines',
            'UAE safety reference library',
            Icons.menu_book_rounded,
          ),

          const SizedBox(height: 9),

          _profileGuidelineCard(
            title: 'UAE General',
            subtitle: 'UAE-wide HSE guidance',
            icon: Icons.flag_rounded,
            color: const Color(0xFF1475D1),
            onTap: () {
              _openGuidelineCategory(
                GuidelineCategory.uaeGeneral,
              );
            },
          ),

          const SizedBox(height: 9),

          _profileGuidelineCard(
            title: 'Abu Dhabi',
            subtitle: 'Abu Dhabi HSE guidance',
            icon: Icons.location_city_rounded,
            color: primaryGreen,
            onTap: () {
              _openGuidelineCategory(
                GuidelineCategory.abuDhabi,
              );
            },
          ),

          const SizedBox(height: 9),

          _profileGuidelineCard(
            title: 'Dubai',
            subtitle: 'Dubai HSE guidance',
            icon: Icons.apartment_rounded,
            color: const Color(0xFF6330D7),
            onTap: () {
              _openGuidelineCategory(
                GuidelineCategory.dubai,
              );
            },
          ),

          const SizedBox(height: 9),

          _profileGuidelineCard(
            title: 'Professional HSE Reference',
            subtitle:
                'Professional safety reference topics',
            icon: Icons.library_books_rounded,
            color: const Color(0xFFB16A00),
            onTap: () {
              _openGuidelineCategory(
                GuidelineCategory.hseReference,
              );
            },
          ),

          const SizedBox(height: 18),

          // ----------------------------------------------------
          // OBSERVATION HISTORY
          // ----------------------------------------------------

          _profileSectionTitle(
            'Observation History',
            'Review previous reports and status',
            Icons.history_rounded,
          ),

          const SizedBox(height: 9),

          _profileAction(
            title: 'Observation History',
            subtitle:
                'View old reports and check status',
            icon: Icons.history_rounded,
            iconColor: primaryGreen,
            onTap: () {
              _openPage(
                const ObservationHistoryPage(),
              );
            },
          ),

          const SizedBox(height: 18),

          // ----------------------------------------------------
          // ABOUT
          // ----------------------------------------------------

          _profileSectionTitle(
            'About SafeNexus HSE',
            'Application information',
            Icons.info_outline_rounded,
          ),

          const SizedBox(height: 9),

          _profileAction(
            title: 'App Information',
            subtitle:
                'Version 1.0.1 • SafeNexus HSE',
            icon: Icons.info_outline_rounded,
            iconColor: primaryGreen,
            onTap: _showAboutDialog,
          ),

          const SizedBox(height: 18),

          _buildUaeCard(),
        ],
      ),
    );
  }

  // ==========================================================
  // PROFILE PROFESSIONAL CARD
  // ==========================================================

  Widget _buildProfileProfessionalCard() {
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
            color: Colors.black.withAlpha(18),
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
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.person_rounded,
              size: 40,
              color: Color(0xFF075B45),
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
                    fontSize: 19,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Profile name / role',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 11,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  'SafeNexus HSE - UAE',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
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
  // PROFILE SECTION TITLE
  // ==========================================================

  Widget _profileSectionTitle(
    String title,
    String subtitle,
    IconData icon,
  ) {
    return Row(
      children: [
        Container(
          width: 39,
          height: 39,
          decoration: BoxDecoration(
            color: primaryGreen.withAlpha(18),
            borderRadius:
                BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: primaryGreen,
            size: 21,
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
                  color: navy,
                  fontSize: 17,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: const TextStyle(
                  color: Color(0xFF607D8B),
                  fontSize: 9.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ==========================================================
  // PROFILE ACTIVITY
  // ==========================================================

  Widget _buildProfileActivityCard() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFFE1E8EE),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _profileMetric(
                  icon: Icons.assignment_rounded,
                  value: _loadingStats
                      ? '...'
                      : _totalReports.toString(),
                  title: 'Total Reports',
                  color: primaryGreen,
                ),
              ),
              _profileMetricDivider(),
              Expanded(
                child: _profileMetric(
                  icon: Icons.warning_amber_rounded,
                  value: _loadingStats
                      ? '...'
                      : _hazards.toString(),
                  title: 'Hazards Reported',
                  color: const Color(0xFFC51E30),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          const Divider(
            height: 1,
            color: Color(0xFFE7ECEF),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: _profileMetric(
                  icon: Icons.visibility_rounded,
                  value: _loadingStats
                      ? '...'
                      : _observations.toString(),
                  title: 'Safety Observations',
                  color: const Color(0xFF1475D1),
                ),
              ),
              _profileMetricDivider(),
              Expanded(
                child: _profileMetric(
                  icon: Icons.pending_actions_rounded,
                  value: _loadingStats
                      ? '...'
                      : _openReports.toString(),
                  title: 'Open Reports',
                  color: const Color(0xFFB16A00),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _profileMetric({
    required IconData icon,
    required String value,
    required String title,
    required Color color,
  }) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color.withAlpha(18),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: color,
            size: 21,
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
          maxLines: 2,
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

  Widget _profileMetricDivider() {
    return Container(
      width: 1,
      height: 65,
      color: const Color(0xFFE2E9ED),
    );
  }

  // ==========================================================
  // PROFILE GUIDELINE CARD
  // ==========================================================

  Widget _profileGuidelineCard({
    required String title,
    required String subtitle,
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
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: color.withAlpha(18),
                  borderRadius:
                      BorderRadius.circular(14),
                ),
                child: Icon(
                  icon,
                  color: color,
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
                Icons.chevron_right_rounded,
                color: color,
                size: 25,
              ),
            ],
          ),
        ),
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
    required Color iconColor,
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
                  color: iconColor.withAlpha(18),
                  borderRadius:
                      BorderRadius.circular(14),
                ),
                child: Icon(
                  icon,
                  color: iconColor,
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
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      maxLines: 2,
                      overflow:
                          TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color(0xFF607D8B),
                        fontSize: 10.5,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: iconColor,
                size: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // SIMPLE HEADER
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
  // GENERAL MESSAGE
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
              height: 1.4,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () =>
                  Navigator.pop(context),
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
