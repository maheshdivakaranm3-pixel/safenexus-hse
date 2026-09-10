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

class SafeNexusApp extends StatefulWidget {
  const SafeNexusApp({super.key});

  @override
  State<SafeNexusApp> createState() => _SafeNexusAppState();
}

class _SafeNexusAppState extends State<SafeNexusApp> {
  ThemeMode _themeMode = ThemeMode.system;

  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF075B45);
  static const Color navy = Color(0xFF082653);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SafeNexus HSE',
      themeMode: _themeMode,

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

      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryGreen,
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xFF101714),
        fontFamily: 'Roboto',
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ),

      home: SafeNexusHomePage(
        onThemeChanged: (ThemeMode mode) {
          setState(() {
            _themeMode = mode;
          });
        },
      ),
    );
  }
}

// ============================================================
// HOME PAGE
// ============================================================

class SafeNexusHomePage extends StatefulWidget {
  final ValueChanged<ThemeMode> onThemeChanged;

  const SafeNexusHomePage({
    super.key,
    required this.onThemeChanged,
  });

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
  // BOTTOM NAVIGATION
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
  // APPEARANCE
  // ==========================================================

  ThemeMode _themeMode = ThemeMode.system;

  String get _appearanceLabel {
    switch (_themeMode) {
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
      case ThemeMode.system:
        return 'System Default';
    }
  }

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

          final report =
              Map<String, dynamic>.from(decoded);

          final id = _stringValue(report['id']);

          if (id.isEmpty) {
            continue;
          }

          final originalType =
              _stringValue(report['reportType']);

          final originalObservationType =
              _stringValue(report['observationType']);

          final canonicalType =
              _canonicalReportType(
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

          normalizedRecords.add(
            jsonEncode(report),
          );

          total++;

          if (canonicalType == 'Hazard Report') {
            hazards++;
          } else {
            observations++;
          }

          final status =
              _normalizeStatus(report['status']);

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
    final type =
        reportType.trim().toLowerCase();

    final legacyType =
        observationType.trim().toLowerCase();

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
    final status =
        _stringValue(value).toLowerCase();

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
          _buildLearningHome(),
          _buildNotificationHome(),
          _buildSettingsHome(),
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
    return NavigationBarTheme(
      data: NavigationBarThemeData(
        height: 82,
        backgroundColor: Colors.white,
        elevation: 8,
        indicatorColor:
            const Color(0xFFDDF2E5),
        labelTextStyle:
            WidgetStateProperty.resolveWith<TextStyle>(
          (states) {
            final selected =
                states.contains(
              WidgetState.selected,
            );

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
                states.contains(
              WidgetState.selected,
            );

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
              Icons.school_outlined,
            ),
            selectedIcon: Icon(
              Icons.school_rounded,
            ),
            label: 'Learning',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.notifications_none_rounded,
            ),
            selectedIcon: Icon(
              Icons.notifications_rounded,
            ),
            label: 'Notification',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.settings_outlined,
            ),
            selectedIcon: Icon(
              Icons.settings_rounded,
            ),
            label: 'Settings',
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
          padding:
              const EdgeInsets.fromLTRB(
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
  // PROFESSIONAL TOP HEADER
  // ==========================================================

  Widget _buildProfessionalHeader() {
    return Container(
      width: double.infinity,
      height: 105,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(18),
        border: Border.all(
          color:
              const Color(0xFFE1E8EE),
        ),
        boxShadow: [
          BoxShadow(
            color:
                Colors.black.withAlpha(10),
            blurRadius: 10,
            offset:
                const Offset(0, 3),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/safenexus_hse_header_mobile.png',
              fit: BoxFit.contain,
              alignment: Alignment.center,
              errorBuilder:
                  (context, error, stackTrace) {
                return const Center(
                  child: Column(
                    mainAxisAlignment:
                        MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons
                            .image_not_supported_rounded,
                        color:
                            primaryGreen,
                        size: 30,
                      ),
                      SizedBox(height: 4),
                      Text(
                        'SafeNexus HSE',
                        style: TextStyle(
                          color: navy,
                          fontWeight:
                              FontWeight.w800,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // PROFESSIONAL HERO
  // ==========================================================

  Widget _buildProfessionalHero() {
    return Container(
      width: double.infinity,
      height: 155,
      clipBehavior:
          Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color:
                Colors.black.withAlpha(22),
            blurRadius: 14,
            offset:
                const Offset(0, 5),
          ),
        ],
      ),
      child: Image.asset(
        'assets/images/safenexus_hse_banner.png',
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
        alignment: Alignment.center,
        errorBuilder:
            (context, error, stackTrace) {
          return Container(
            decoration:
                const BoxDecoration(
              gradient:
                  LinearGradient(
                begin:
                    Alignment.topLeft,
                end:
                    Alignment.bottomRight,
                colors: [
                  Color(0xFF063E73),
                  Color(0xFF075B45),
                  Color(0xFF0B9860),
                ],
              ),
            ),
            child: const Center(
              child: Icon(
                Icons
                    .image_not_supported_rounded,
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
  // QUICK ACTIONS TITLE
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
              SizedBox(height: 2),
              Text(
                'Take action for a safer workplace',
                style: TextStyle(
                  color:
                      Color(0xFF607D8B),
                  fontSize: 10.5,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding:
              const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 6,
          ),
          decoration: BoxDecoration(
            color:
                const Color(0xFFE3F6EC),
            borderRadius:
                BorderRadius.circular(20),
          ),
          child: const Row(
            mainAxisSize:
                MainAxisSize.min,
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
                title:
                    'Report Hazard',
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
                title:
                    'Voice Report',
                subtitle:
                    'Speak your concern',
                icon:
                    Icons.mic_rounded,
                iconColor:
                    const Color(0xFF5A1BB8),
                background:
                    const Color(0xFFF4EEFF),
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
                title:
                    'Safety Observation',
                subtitle:
                    'Observe & record',
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
                title:
                    'HSE Guidelines',
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
          padding:
              const EdgeInsets.all(14),
          child: Row(
            children: [
              Container(
                width: 51,
                height: 51,
                decoration:
                    BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(
                    15,
                  ),
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
                      style:
                          const TextStyle(
                        color: navy,
                        fontSize: 13.5,
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
                      style:
                          const TextStyle(
                        color:
                            Color(0xFF607D8B),
                        fontSize: 9.5,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons
                    .chevron_right_rounded,
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
      padding:
          const EdgeInsets.all(17),
      decoration:
          BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(23),
        border: Border.all(
          color:
              const Color(0xFFE1EAF0),
        ),
        boxShadow: [
          BoxShadow(
            color:
                Colors.black.withAlpha(12),
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
                decoration:
                    BoxDecoration(
                  color:
                      const Color(0xFFEAF8F0),
                  borderRadius:
                      BorderRadius.circular(
                    15,
                  ),
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
          const SizedBox(height: 14),
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
                  title:
                      'Observations',
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
                  title:
                      'Open Reports',
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
                  title:
                      'Total Reports',
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
          decoration:
              BoxDecoration(
            color:
                iconColor.withAlpha(18),
            shape:
                BoxShape.circle,
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
            fontWeight:
                FontWeight.w900,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          title,
          maxLines: 1,
          overflow:
              TextOverflow.ellipsis,
          textAlign:
              TextAlign.center,
          style:
              const TextStyle(
            color:
                Color(0xFF607D8B),
            fontSize: 8.5,
            fontWeight:
                FontWeight.w600,
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
      color:
          const Color(0xFFE2E9ED),
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
                title:
                    'UAE General',
                count:
                    _uaeGeneralCount,
                icon:
                    Icons.flag_rounded,
                color:
                    const Color(0xFF1378C7),
                onTap: () {
                  _openGuidelineCategory(
                    GuidelineCategory
                        .uaeGeneral,
                  );
                },
              ),
            ),
            const SizedBox(width: 9),
            Expanded(
              child: _referenceMiniCard(
                title:
                    'Abu Dhabi',
                count:
                    _abuDhabiCount,
                icon:
                    Icons.location_city_rounded,
                color:
                    const Color(0xFF0B7B53),
                onTap: () {
                  _openGuidelineCategory(
                    GuidelineCategory
                        .abuDhabi,
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
                title:
                    'Dubai',
                count:
                    _dubaiCount,
                icon:
                    Icons.apartment_rounded,
                color:
                    const Color(0xFF6A36C8),
                onTap: () {
                  _openGuidelineCategory(
                    GuidelineCategory
                        .dubai,
                  );
                },
              ),
            ),
            const SizedBox(width: 9),
            Expanded(
              child: _referenceMiniCard(
                title:
                    'HSE Reference',
                count:
                    _hseReferenceCount,
                icon:
                    Icons.library_books_rounded,
                color:
                    const Color(0xFFB16A00),
                onTap: () {
                  _openGuidelineCategory(
                    GuidelineCategory
                        .hseReference,
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
      borderRadius:
          BorderRadius.circular(18),
      child: InkWell(
        borderRadius:
            BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding:
              const EdgeInsets.all(13),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration:
                    BoxDecoration(
                  color:
                      color.withAlpha(20),
                  borderRadius:
                      BorderRadius.circular(
                    13,
                  ),
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
                      style:
                          const TextStyle(
                        color: navy,
                        fontSize: 12.5,
                        fontWeight:
                            FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      '$count topics',
                      style:
                          const TextStyle(
                        color:
                            Color(0xFF607D8B),
                        fontSize: 9.5,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons
                    .chevron_right_rounded,
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
      clipBehavior:
          Clip.antiAlias,
      decoration:
          BoxDecoration(
        gradient:
            const LinearGradient(
          begin:
              Alignment.centerLeft,
          end:
              Alignment.centerRight,
          colors: [
            Color(0xFF075B45),
            Color(0xFF0B9860),
          ],
        ),
        borderRadius:
            BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color:
                Colors.black.withAlpha(18),
            blurRadius: 12,
            offset:
                const Offset(0, 5),
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
              decoration:
                  BoxDecoration(
                shape:
                    BoxShape.circle,
                color:
                    Colors.white.withAlpha(10),
                border: Border.all(
                  color:
                      Colors.white.withAlpha(35),
                  width: 1.2,
                ),
              ),
              child:
                  const Center(
                child: Icon(
                  Icons.shield_rounded,
                  color:
                      Colors.white,
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
              child:
                  Transform.rotate(
                angle: -0.25,
                child:
                    const Icon(
                  Icons.eco_rounded,
                  color:
                      Colors.white,
                  size: 72,
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Padding(
              padding:
                  const EdgeInsets.only(
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
                    fit:
                        BoxFit.scaleDown,
                    child: Text(
                      'Small Actions. Safer UAE.',
                      maxLines: 1,
                      textAlign:
                          TextAlign.center,
                      style:
                          TextStyle(
                        color:
                            Colors.white,
                        fontSize: 18,
                        fontWeight:
                            FontWeight.w900,
                        letterSpacing: 0.1,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Every observation matters. Every action counts.',
                    maxLines: 2,
                    textAlign:
                        TextAlign.center,
                    style:
                        TextStyle(
                      color:
                          Color(0xFFE6FFF3),
                      fontSize: 11.5,
                      fontWeight:
                          FontWeight.w500,
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
                    decoration:
                        BoxDecoration(
                      color:
                          Colors.white,
                      borderRadius:
                          BorderRadius.circular(
                        20,
                      ),
                    ),
                    child:
                        const Text(
                      'SafeNexus HSE - UAE',
                      textAlign:
                          TextAlign.center,
                      style:
                          TextStyle(
                        color:
                            Color(0xFF075B45),
                        fontSize: 11.5,
                        fontWeight:
                            FontWeight.w900,
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
      padding:
          const EdgeInsets.all(17),
      decoration:
          BoxDecoration(
        color:
            const Color(0xFFE9F8F1),
        borderRadius:
            BorderRadius.circular(21),
        border: Border.all(
          color:
              const Color(0xFFCDEBDD),
        ),
        boxShadow: const [
          BoxShadow(
            color:
                Color(0x12000000),
            blurRadius: 12,
            offset:
                Offset(0, 5),
          ),
        ],
      ),
      child: const Row(
        children: [
          Text(
            '🇦🇪',
            style:
                TextStyle(
              fontSize: 28,
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
                  style:
                      TextStyle(
                    color:
                        darkGreen,
                    fontSize: 14.5,
                    fontWeight:
                        FontWeight.w900,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  'Built for HSE professionals and safer workplaces across the United Arab Emirates.',
                  style:
                      TextStyle(
                    color:
                        Color(0xFF527064),
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
  // LEARNING HOME
  // ==========================================================

  Widget _buildLearningHome() {
    return SafeArea(
      child: ListView(
        padding:
            const EdgeInsets.all(18),
        children: [
          _simplePageHeader(
            title:
                'Learning Center',
            subtitle:
                'Build Knowledge - Build a Safer You',
            icon:
                Icons.school_rounded,
          ),
          const SizedBox(height: 16),
          _learningCard(
            title:
                'UAE General HSE',
            subtitle:
                'Explore UAE-wide safety guidance and best practices.',
            icon:
                Icons.flag_rounded,
            color:
                const Color(0xFF1475D1),
            onTap: () {
              _openGuidelineCategory(
                GuidelineCategory
                    .uaeGeneral,
              );
            },
          ),
          const SizedBox(height: 12),
          _learningCard(
            title:
                'Abu Dhabi HSE',
            subtitle:
                'Explore Abu Dhabi specific HSE requirements.',
            icon:
                Icons.location_city_rounded,
            color:
                primaryGreen,
            onTap: () {
              _openGuidelineCategory(
                GuidelineCategory
                    .abuDhabi,
              );
            },
          ),
          const SizedBox(height: 12),
          _learningCard(
            title:
                'Dubai HSE',
            subtitle:
                'Explore Dubai safety requirements and guidance.',
            icon:
                Icons.apartment_rounded,
            color:
                const Color(0xFF6330D7),
            onTap: () {
              _openGuidelineCategory(
                GuidelineCategory
                    .dubai,
              );
            },
          ),
          const SizedBox(height: 12),
          _learningCard(
            title:
                'Professional HSE Reference',
            subtitle:
                'Useful professional HSE reference topics.',
            icon:
                Icons.library_books_rounded,
            color:
                const Color(0xFFB16A00),
            onTap: () {
              _openGuidelineCategory(
                GuidelineCategory
                    .hseReference,
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
          padding:
              const EdgeInsets.all(17),
          child: Row(
            children: [
              Container(
                width: 57,
                height: 57,
                decoration:
                    BoxDecoration(
                  color:
                      color.withAlpha(20),
                  borderRadius:
                      BorderRadius.circular(
                    16,
                  ),
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
                      style:
                          const TextStyle(
                        color: navy,
                        fontSize: 16,
                        fontWeight:
                            FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style:
                          const TextStyle(
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
                Icons
                    .chevron_right_rounded,
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
  // NOTIFICATION HOME
  // ==========================================================

  Widget _buildNotificationHome() {
    return SafeArea(
      child: ListView(
        padding:
            const EdgeInsets.fromLTRB(
          18,
          20,
          18,
          28,
        ),
        children: [
          _simplePageHeader(
            title:
                'Notifications',
            subtitle:
                'Safety alerts and important updates',
            icon:
                Icons.notifications_rounded,
          ),
          const SizedBox(height: 18),
          Container(
            width: double.infinity,
            padding:
                const EdgeInsets.all(22),
            decoration:
                BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.circular(22),
              border: Border.all(
                color:
                    const Color(0xFFE1E8EE),
              ),
              boxShadow: [
                BoxShadow(
                  color:
                      Colors.black.withAlpha(10),
                  blurRadius: 12,
                  offset:
                      const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                Container(
                  width: 74,
                  height: 74,
                  decoration:
                      BoxDecoration(
                    color:
                        const Color(0xFFE9F8F1),
                    shape:
                        BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons
                        .notifications_none_rounded,
                    color:
                        primaryGreen,
                    size: 38,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'You are all caught up',
                  textAlign:
                      TextAlign.center,
                  style:
                      TextStyle(
                    color: navy,
                    fontSize: 19,
                    fontWeight:
                        FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 7),
                const Text(
                  'No new safety notifications or updates at the moment.',
                  textAlign:
                      TextAlign.center,
                  style:
                      TextStyle(
                    color:
                        Color(0xFF607D8B),
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _notificationInfoCard(
            icon:
                Icons.shield_rounded,
            title:
                'Safety Updates',
            subtitle:
                'Important HSE safety information will appear here.',
          ),
          const SizedBox(height: 10),
          _notificationInfoCard(
            icon:
                Icons.campaign_rounded,
            title:
                'App Updates',
            subtitle:
                'New SafeNexus HSE features and updates will appear here.',
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // NOTIFICATION INFO CARD
  // ==========================================================

  Widget _notificationInfoCard({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding:
          const EdgeInsets.all(15),
      decoration:
          BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(18),
        border: Border.all(
          color:
              const Color(0xFFE1E8EE),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration:
                BoxDecoration(
              color:
                  primaryGreen.withAlpha(18),
              borderRadius:
                  BorderRadius.circular(14),
            ),
            child: Icon(
              icon,
              color:
                  primaryGreen,
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
                  style:
                      const TextStyle(
                    color: navy,
                    fontSize: 14,
                    fontWeight:
                        FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style:
                      const TextStyle(
                    color:
                        Color(0xFF607D8B),
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
  // SETTINGS HOME
  // ==========================================================

  Widget _buildSettingsHome() {
    return SafeArea(
      child: ListView(
        padding:
            const EdgeInsets.fromLTRB(
          18,
          20,
          18,
          28,
        ),
        children: [
          _settingsHeader(),

          const SizedBox(height: 18),

          // ==================================================
          // LANGUAGE
          // ==================================================

          _settingsActionCard(
            icon:
                Icons.language_rounded,
            title:
                'Language',
            subtitle:
                'English',
            onTap:
                _showLanguageDialog,
          ),

          const SizedBox(height: 10),

          // ==================================================
          // APPEARANCE
          // ==================================================

          _settingsActionCard(
            icon:
                Icons.palette_outlined,
            title:
                'Appearance',
            subtitle:
                _appearanceLabel,
            onTap:
                _showAppearanceDialog,
          ),

          const SizedBox(height: 10),

          // ==================================================
          // PRIVACY & SECURITY
          // ==================================================

          _settingsActionCard(
            icon:
                Icons.lock_outline_rounded,
            title:
                'Privacy & Security',
            subtitle:
                'Privacy information • App permissions',
            onTap:
                _showPrivacySecurityDialog,
          ),

          const SizedBox(height: 10),

          // ==================================================
          // DATA & STORAGE
          // ==================================================

          _settingsActionCard(
            icon:
                Icons.storage_rounded,
            title:
                'Data & Storage',
            subtitle:
                'Saved reports / local data • Clear local data',
            onTap:
                _showDataStorageDialog,
          ),

          const SizedBox(height: 10),

          // ==================================================
          // ABOUT
          // ==================================================

          _settingsActionCard(
            icon:
                Icons.info_outline_rounded,
            title:
                'About SafeNexus HSE',
            subtitle:
                'App information • Version • Description',
            onTap:
                _showAboutDialog,
          ),

          const SizedBox(height: 10),

          // ==================================================
          // LEGAL
          // ==================================================

          _settingsActionCard(
            icon:
                Icons.gavel_rounded,
            title:
                'Legal',
            subtitle:
                'Privacy Policy • Terms & Conditions • Disclaimer',
            onTap:
                _showLegalDialog,
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
      padding:
          const EdgeInsets.all(22),
      decoration:
          BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color:
                Colors.black.withAlpha(10),
            blurRadius: 12,
            offset:
                const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 76,
            height: 76,
            decoration:
                BoxDecoration(
              color:
                  const Color(0xFFE9F8F1),
              borderRadius:
                  BorderRadius.circular(22),
            ),
            child: const Icon(
              Icons.settings_rounded,
              color:
                  primaryGreen,
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
                  style:
                      TextStyle(
                    color: navy,
                    fontSize: 24,
                    fontWeight:
                        FontWeight.w900,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Manage your SafeNexus HSE preferences',
                  style:
                      TextStyle(
                    color:
                        Color(0xFF78909C),
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
  // SETTINGS ACTION CARD
  // ==========================================================

  Widget _settingsActionCard({
    required IconData icon,
    required String title,
    required String subtitle,
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
          padding:
              const EdgeInsets.all(17),
          child: Row(
            children: [
              Container(
                width: 64,
                height: 64,
                decoration:
                    BoxDecoration(
                  color:
                      const Color(0xFFEAF7F0),
                  borderRadius:
                      BorderRadius.circular(
                    18,
                  ),
                ),
                child: Icon(
                  icon,
                  color:
                      primaryGreen,
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
                      maxLines: 1,
                      overflow:
                          TextOverflow.ellipsis,
                      style:
                          const TextStyle(
                        color: navy,
                        fontSize: 17,
                        fontWeight:
                            FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      maxLines: 2,
                      overflow:
                          TextOverflow.ellipsis,
                      style:
                          const TextStyle(
                        color:
                            Color(0xFF52636A),
                        fontSize: 12.5,
                        height: 1.25,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons
                    .chevron_right_rounded,
                color:
                    Color(0xFF4E5653),
                size: 29,
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
      builder: (dialogContext) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(22),
          ),
          title: const Row(
            children: [
              Icon(
                Icons.language_rounded,
                color:
                    primaryGreen,
              ),
              SizedBox(width: 10),
              Text(
                'Language',
                style:
                    TextStyle(
                  color: navy,
                  fontWeight:
                      FontWeight.w800,
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize:
                MainAxisSize.min,
            children: [
              _languageOption(
                context: dialogContext,
                title: 'English',
                selected: true,
              ),
            ],
          ),
        );
      },
    );
  }

  // ==========================================================
  // LANGUAGE OPTION
  // ==========================================================

  Widget _languageOption({
    required BuildContext context,
    required String title,
    required bool selected,
  }) {
    return InkWell(
      borderRadius:
          BorderRadius.circular(14),
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        width: double.infinity,
        padding:
            const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 14,
        ),
        decoration:
            BoxDecoration(
          color: selected
              ? const Color(0xFFE9F8F1)
              : Colors.transparent,
          borderRadius:
              BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            const Text(
              '🇬🇧',
              style:
                  TextStyle(
                fontSize: 23,
              ),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Text(
                'English',
                style:
                    TextStyle(
                  color: navy,
                  fontSize: 15,
                  fontWeight:
                      FontWeight.w700,
                ),
              ),
            ),
            if (selected)
              const Icon(
                Icons.check_circle_rounded,
                color:
                    primaryGreen,
              ),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // APPEARANCE DIALOG
  // ==========================================================

  void _showAppearanceDialog() {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(22),
          ),
          title: const Row(
            children: [
              Icon(
                Icons.palette_outlined,
                color:
                    primaryGreen,
              ),
              SizedBox(width: 10),
              Text(
                'Appearance',
                style:
                    TextStyle(
                  color: navy,
                  fontWeight:
                      FontWeight.w800,
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize:
                MainAxisSize.min,
            children: [
              _appearanceOption(
                dialogContext,
                'System Default',
                ThemeMode.system,
                Icons.phone_android_rounded,
              ),
              const SizedBox(height: 6),
              _appearanceOption(
                dialogContext,
                'Light',
                ThemeMode.light,
                Icons.light_mode_rounded,
              ),
              const SizedBox(height: 6),
              _appearanceOption(
                dialogContext,
                'Dark',
                ThemeMode.dark,
                Icons.dark_mode_rounded,
              ),
            ],
          ),
        );
      },
    );
  }

  // ==========================================================
  // APPEARANCE OPTION
  // ==========================================================

  Widget _appearanceOption(
    BuildContext dialogContext,
    String title,
    ThemeMode mode,
    IconData icon,
  ) {
    final selected = _themeMode == mode;

    return InkWell(
      borderRadius:
          BorderRadius.circular(14),
      onTap: () {
        setState(() {
          _themeMode = mode;
        });

        widget.onThemeChanged(mode);

        Navigator.pop(dialogContext);
      },
      child: Container(
        width: double.infinity,
        padding:
            const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 13,
        ),
        decoration:
            BoxDecoration(
          color: selected
              ? const Color(0xFFE9F8F1)
              : Colors.transparent,
          borderRadius:
              BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color:
                  selected
                      ? primaryGreen
                      : const Color(0xFF607D8B),
              size: 24,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style:
                    const TextStyle(
                  color: navy,
                  fontSize: 14.5,
                  fontWeight:
                      FontWeight.w700,
                ),
              ),
            ),
            if (selected)
              const Icon(
                Icons.check_circle_rounded,
                color:
                    primaryGreen,
              ),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // PRIVACY & SECURITY
  // ==========================================================

  void _showPrivacySecurityDialog() {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(22),
          ),
          title: const Row(
            children: [
              Icon(
                Icons.lock_outline_rounded,
                color:
                    primaryGreen,
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Privacy & Security',
                  style:
                      TextStyle(
                    color: navy,
                    fontWeight:
                        FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize:
                MainAxisSize.min,
            children: [
              _subOptionTile(
                icon:
                    Icons.privacy_tip_outlined,
                title:
                    'Privacy Information',
                subtitle:
                    'Learn how SafeNexus HSE handles local app data.',
                onTap: () {
                  Navigator.pop(dialogContext);
                  _showPrivacyInformation();
                },
              ),
              const SizedBox(height: 10),
              _subOptionTile(
                icon:
                    Icons.admin_panel_settings_outlined,
                title:
                    'App Permissions',
                subtitle:
                    'Camera, microphone and device permissions.',
                onTap: () {
                  Navigator.pop(dialogContext);
                  _showAppPermissions();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // ==========================================================
  // PRIVACY INFORMATION
  // ==========================================================

  void _showPrivacyInformation() {
    _showInfoPageDialog(
      title: 'Privacy Information',
      icon:
          Icons.privacy_tip_outlined,
      content: const [
        'SafeNexus HSE is designed to support workplace HSE reporting and safety activities.',
        'Reports created in the app may be stored locally on the device so they can be viewed later.',
        'The app should only collect or use information required for its intended HSE functions.',
        'Do not enter unnecessary personal or confidential information into safety reports.',
      ],
    );
  }

  // ==========================================================
  // APP PERMISSIONS
  // ==========================================================

  void _showAppPermissions() {
    _showInfoPageDialog(
      title: 'App Permissions',
      icon:
          Icons.admin_panel_settings_outlined,
      content: const [
        'Camera: Used when attaching photographs to safety reports, where supported.',
        'Microphone: Used for voice-based reporting features, where supported.',
        'Storage / Local data: Used to keep reports and application data on the device.',
        'Permissions are requested only when a related feature requires them.',
      ],
    );
  }

  // ==========================================================
  // DATA & STORAGE
  // ==========================================================

  Future<void> _showDataStorageDialog() async {
    int savedReports = _totalReports;

    try {
      final prefs =
          await SharedPreferences.getInstance();

      final records =
          prefs.getStringList(_storageKey) ??
              <String>[];

      savedReports = records.length;
    } catch (_) {}

    if (!mounted) {
      return;
    }

    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(22),
          ),
          title: const Row(
            children: [
              Icon(
                Icons.storage_rounded,
                color:
                    primaryGreen,
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Data & Storage',
                  style:
                      TextStyle(
                    color: navy,
                    fontWeight:
                        FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize:
                MainAxisSize.min,
            children: [
              _subOptionTile(
                icon:
                    Icons.description_outlined,
                title:
                    'Saved Reports / Local Data',
                subtitle:
                    '$savedReports report(s) saved on this device.',
                onTap: () {
                  Navigator.pop(dialogContext);
                  _showSavedReportsInfo(savedReports);
                },
              ),
              const SizedBox(height: 10),
              _subOptionTile(
                icon:
                    Icons.delete_outline_rounded,
                title:
                    'Clear Local Data',
                subtitle:
                    'Delete locally saved reports from this device.',
                iconColor:
                    const Color(0xFFC51E30),
                onTap: () {
                  Navigator.pop(dialogContext);
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
  // SAVED REPORTS INFO
  // ==========================================================

  void _showSavedReportsInfo(int count) {
    _showInfoPageDialog(
      title: 'Saved Reports',
      icon:
          Icons.description_outlined,
      content: [
        'Reports currently saved on this device: $count.',
        'These local records are used by the dashboard and Observation History.',
        'Clearing local data will remove these locally stored records.',
      ],
    );
  }

  // ==========================================================
  // CLEAR LOCAL DATA CONFIRMATION
  // ==========================================================

  void _confirmClearLocalData() {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(22),
          ),
          title: const Text(
            'Clear Local Data?',
            style:
                TextStyle(
              color: navy,
              fontWeight:
                  FontWeight.w800,
            ),
          ),
          content: const Text(
            'This will permanently remove locally saved reports from this device. This action cannot be undone.',
            style:
                TextStyle(
              color:
                  Color(0xFF455A64),
              height: 1.4,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text(
                'Cancel',
                style:
                    TextStyle(
                  color:
                      Color(0xFF607D8B),
                  fontWeight:
                      FontWeight.w700,
                ),
              ),
            ),
            FilledButton(
              style:
                  FilledButton.styleFrom(
                backgroundColor:
                    const Color(0xFFC51E30),
              ),
              onPressed: () async {
                Navigator.pop(dialogContext);
                await _clearLocalData();
              },
              child: const Text(
                'Clear Data',
              ),
            ),
          ],
        );
      },
    );
  }

  // ==========================================================
  // CLEAR LOCAL DATA
  // ==========================================================

  Future<void> _clearLocalData() async {
    try {
      final prefs =
          await SharedPreferences.getInstance();

      await prefs.remove(_storageKey);

      await _loadDashboardStats();

      if (!mounted) {
        return;
      }

      _showMessage(
        'Data Cleared',
        'All locally saved SafeNexus HSE report data has been cleared from this device.',
      );
    } catch (_) {
      if (!mounted) {
        return;
      }

      _showMessage(
        'Unable to Clear Data',
        'The local data could not be cleared. Please try again.',
      );
    }
  }

  // ==========================================================
  // ABOUT
  // ==========================================================

  void _showAboutDialog() {
    _showInfoPageDialog(
      title: 'About SafeNexus HSE',
      icon:
          Icons.info_outline_rounded,
      content: const [
        'App Information',
        'SafeNexus HSE',
        'Version 1.0.1',
        'UAE-wide HSE Safety App',
        'Built for HSE professionals and safer workplaces across the United Arab Emirates.',
        'Safe People • Safe Workplaces • Safer UAE',
      ],
    );
  }

  // ==========================================================
  // LEGAL
  // ==========================================================

  void _showLegalDialog() {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(22),
          ),
          title: const Row(
            children: [
              Icon(
                Icons.gavel_rounded,
                color:
                    primaryGreen,
              ),
              SizedBox(width: 10),
              Text(
                'Legal',
                style:
                    TextStyle(
                  color: navy,
                  fontWeight:
                      FontWeight.w800,
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize:
                MainAxisSize.min,
            children: [
              _subOptionTile(
                icon:
                    Icons.privacy_tip_outlined,
                title:
                    'Privacy Policy',
                subtitle:
                    'Information about privacy and data handling.',
                onTap: () {
                  Navigator.pop(dialogContext);
                  _showPrivacyPolicy();
                },
              ),
              const SizedBox(height: 10),
              _subOptionTile(
                icon:
                    Icons.description_outlined,
                title:
                    'Terms & Conditions',
                subtitle:
                    'Terms for using SafeNexus HSE.',
                onTap: () {
                  Navigator.pop(dialogContext);
                  _showTermsConditions();
                },
              ),
              const SizedBox(height: 10),
              _subOptionTile(
                icon:
                    Icons.warning_amber_rounded,
                title:
                    'Disclaimer',
                subtitle:
                    'Important information about HSE references.',
                onTap: () {
                  Navigator.pop(dialogContext);
                  _showDisclaimer();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // ==========================================================
  // PRIVACY POLICY
  // ==========================================================

  void _showPrivacyPolicy() {
    _showInfoPageDialog(
      title: 'Privacy Policy',
      icon:
          Icons.privacy_tip_outlined,
      content: const [
        'SafeNexus HSE is intended to support workplace health, safety and environment activities.',
        'Local report data may be stored on the user’s device for app functionality.',
        'Users should avoid entering unnecessary sensitive or confidential information.',
        'Any future online services or integrations should provide appropriate privacy information before collecting additional data.',
      ],
    );
  }

  // ==========================================================
  // TERMS & CONDITIONS
  // ==========================================================

  void _showTermsConditions() {
    _showInfoPageDialog(
      title: 'Terms & Conditions',
      icon:
          Icons.description_outlined,
      content: const [
        'SafeNexus HSE is provided as a safety support and reference application.',
        'Users are responsible for verifying applicable workplace requirements and following their employer’s HSE procedures.',
        'The application should not be treated as a replacement for competent professional judgement, site-specific risk assessment or official regulatory requirements.',
        'Use of the application should comply with applicable laws, workplace rules and organizational procedures.',
      ],
    );
  }

  // ==========================================================
  // DISCLAIMER
  // ==========================================================

  void _showDisclaimer() {
    _showInfoPageDialog(
      title: 'Disclaimer',
      icon:
          Icons.warning_amber_rounded,
      content: const [
        'SafeNexus HSE provides HSE information and reference material for general safety support.',
        'Guidance shown in the application should be checked against current official UAE requirements and applicable authority requirements.',
        'The app does not replace official regulations, approved procedures, competent-person advice, risk assessments or emergency instructions.',
        'In an emergency, follow the applicable site emergency procedure and contact the appropriate emergency services.',
      ],
    );
  }

  // ==========================================================
  // SUB OPTION TILE
  // ==========================================================

  Widget _subOptionTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Color iconColor = primaryGreen,
  }) {
    return Material(
      color:
          const Color(0xFFF7FAF9),
      borderRadius:
          BorderRadius.circular(16),
      child: InkWell(
        borderRadius:
            BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding:
              const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration:
                    BoxDecoration(
                  color:
                      iconColor.withAlpha(18),
                  borderRadius:
                      BorderRadius.circular(13),
                ),
                child: Icon(
                  icon,
                  color:
                      iconColor,
                  size: 24,
                ),
              ),
              const SizedBox(width: 11),
              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style:
                          const TextStyle(
                        color: navy,
                        fontSize: 13.5,
                        fontWeight:
                            FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      style:
                          const TextStyle(
                        color:
                            Color(0xFF607D8B),
                        fontSize: 10.5,
                        height: 1.25,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons
                    .chevron_right_rounded,
                color:
                    iconColor,
                size: 23,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // INFORMATION DIALOG
  // ==========================================================

  void _showInfoPageDialog({
    required String title,
    required IconData icon,
    required List<String> content,
  }) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(22),
          ),
          title: Row(
            children: [
              Icon(
                icon,
                color:
                    primaryGreen,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style:
                      const TextStyle(
                    color: navy,
                    fontWeight:
                        FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          content: ConstrainedBox(
            constraints:
                const BoxConstraints(
              maxHeight: 420,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children:
                    content.map(
                  (text) {
                    return Padding(
                      padding:
                          const EdgeInsets.only(
                        bottom: 10,
                      ),
                      child: Text(
                        text,
                        style:
                            const TextStyle(
                          color:
                              Color(0xFF455A64),
                          fontSize: 13,
                          height: 1.4,
                        ),
                      ),
                    );
                  },
                ).toList(),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(
                  dialogContext,
                );
              },
              child:
                  const Text(
                'OK',
                style:
                    TextStyle(
                  color:
                      primaryGreen,
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

  // ==========================================================
  // PROFILE HOME
  // ==========================================================

  Widget _buildProfileHome() {
    return SafeArea(
      child: ListView(
        padding:
            const EdgeInsets.all(18),
        children: [
          _simplePageHeader(
            title:
                'SafeNexus Profile',
            subtitle:
                'Your HSE safety workspace',
            icon:
                Icons.person_rounded,
          ),
          const SizedBox(height: 16),
          Container(
            padding:
                const EdgeInsets.all(22),
            decoration:
                BoxDecoration(
              gradient:
                  const LinearGradient(
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
                  style:
                      TextStyle(
                    color:
                        Colors.white,
                    fontSize: 19,
                    fontWeight:
                        FontWeight.w800,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'SafeNexus HSE - UAE',
                  style:
                      TextStyle(
                    color:
                        Colors.white70,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // ==================================================
          // MY REPORTS
          // ==================================================

          _profileSectionHeading(
            icon:
                Icons.assignment_outlined,
            title:
                'My Reports',
            subtitle:
                'Your submitted HSE reports and status',
          ),

          const SizedBox(height: 8),

          _profileAction(
            title:
                'Observation History',
            subtitle:
                'View your submitted safety reports',
            icon:
                Icons.history_rounded,
            onTap: () {
              _openPage(
                const ObservationHistoryPage(),
              );
            },
          ),

          const SizedBox(height: 10),

          // ==================================================
          // HSE GUIDELINES
          // ==================================================

          _profileSectionHeading(
            icon:
                Icons.menu_book_rounded,
            title:
                'HSE Guidelines',
            subtitle:
                'UAE HSE reference library',
          ),

          const SizedBox(height: 8),

          _profileAction(
            title:
                'UAE HSE Guidelines',
            subtitle:
                'Open safety reference library',
            icon:
                Icons.library_books_rounded,
            onTap:
                _openGuidelines,
          ),

          const SizedBox(height: 14),

          // ==================================================
          // MY SAFETY ACTIVITY
          // ==================================================

          _profileSectionHeading(
            icon:
                Icons.analytics_outlined,
            title:
                'My Safety Activity',
            subtitle:
                'Your current HSE reporting activity',
          ),

          const SizedBox(height: 10),

          _buildProfileActivityCard(),

          const SizedBox(height: 14),

          // ==================================================
          // ABOUT
          // ==================================================

          _profileSectionHeading(
            icon:
                Icons.info_outline_rounded,
            title:
                'About SafeNexus HSE',
            subtitle:
                'Application information',
          ),

          const SizedBox(height: 8),

          _profileAction(
            title:
                'App Information',
            subtitle:
                'Version 1.0.1 • SafeNexus HSE',
            icon:
                Icons.info_outline_rounded,
            onTap:
                _showAboutDialog,
          ),

          const SizedBox(height: 20),

          _buildUaeCard(),
        ],
      ),
    );
  }

  // ==========================================================
  // PROFILE SECTION HEADING
  // ==========================================================

  Widget _profileSectionHeading({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Row(
      crossAxisAlignment:
          CrossAxisAlignment.center,
      children: [
        Container(
          width: 50,
          height: 50,
          decoration:
              BoxDecoration(
            color:
                const Color(0xFFE9F8F1),
            borderRadius:
                BorderRadius.circular(15),
          ),
          child: Icon(
            icon,
            color:
                primaryGreen,
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
                style:
                    const TextStyle(
                  color: navy,
                  fontSize: 19,
                  fontWeight:
                      FontWeight.w900,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style:
                    const TextStyle(
                  color:
                      Color(0xFF607D8B),
                  fontSize: 10.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ==========================================================
  // PROFILE ACTIVITY CARD
  // ==========================================================

  Widget _buildProfileActivityCard() {
    return Container(
      padding:
          const EdgeInsets.all(15),
      decoration:
          BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(20),
        border: Border.all(
          color:
              const Color(0xFFE1E8EE),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: _profileMetric(
              value: _loadingStats
                  ? '...'
                  : _totalReports.toString(),
              label:
                  'Total Reports',
              icon:
                  Icons.assignment_rounded,
              color:
                  primaryGreen,
            ),
          ),
          _profileMetricDivider(),
          Expanded(
            child: _profileMetric(
              value: _loadingStats
                  ? '...'
                  : _hazards.toString(),
              label:
                  'Hazards',
              icon:
                  Icons.warning_amber_rounded,
              color:
                  const Color(0xFFC51E30),
            ),
          ),
          _profileMetricDivider(),
          Expanded(
            child: _profileMetric(
              value: _loadingStats
                  ? '...'
                  : _observations.toString(),
              label:
                  'Observations',
              icon:
                  Icons.visibility_rounded,
              color:
                  const Color(0xFF1475D1),
            ),
          ),
          _profileMetricDivider(),
          Expanded(
            child: _profileMetric(
              value: _loadingStats
                  ? '...'
                  : _openReports.toString(),
              label:
                  'Open',
              icon:
                  Icons.pending_actions_rounded,
              color:
                  const Color(0xFFB16A00),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // PROFILE METRIC
  // ==========================================================

  Widget _profileMetric({
    required String value,
    required String label,
    required IconData icon,
    required Color color,
  }) {
    return Column(
      children: [
        Icon(
          icon,
          color:
              color,
          size: 21,
        ),
        const SizedBox(height: 5),
        Text(
          value,
          style:
              const TextStyle(
            color: navy,
            fontSize: 18,
            fontWeight:
                FontWeight.w900,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          maxLines: 1,
          overflow:
              TextOverflow.ellipsis,
          textAlign:
              TextAlign.center,
          style:
              const TextStyle(
            color:
                Color(0xFF607D8B),
            fontSize: 8.5,
            fontWeight:
                FontWeight.w600,
          ),
        ),
      ],
    );
  }

  // ==========================================================
  // PROFILE METRIC DIVIDER
  // ==========================================================

  Widget _profileMetricDivider() {
    return Container(
      width: 1,
      height: 58,
      color:
          const Color(0xFFE2E9ED),
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
          padding:
              const EdgeInsets.all(15),
          child: Row(
            children: [
              Container(
                width: 47,
                height: 47,
                decoration:
                    BoxDecoration(
                  color:
                      primaryGreen.withAlpha(18),
                  borderRadius:
                      BorderRadius.circular(
                    14,
                  ),
                ),
                child: Icon(
                  icon,
                  color:
                      primaryGreen,
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
                      style:
                          const TextStyle(
                        color: navy,
                        fontSize: 14,
                        fontWeight:
                            FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      style:
                          const TextStyle(
                        color:
                            Color(0xFF607D8B),
                        fontSize: 10.5,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons
                    .chevron_right_rounded,
                color:
                    primaryGreen,
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
      padding:
          const EdgeInsets.fromLTRB(
        0,
        0,
        0,
        4,
      ),
      child: Container(
        padding:
            const EdgeInsets.all(17),
        decoration:
            BoxDecoration(
          color:
              Colors.white,
          borderRadius:
              BorderRadius.circular(21),
          boxShadow: [
            BoxShadow(
              color:
                  Colors.black.withAlpha(12),
              blurRadius: 10,
              offset:
                  const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration:
                  BoxDecoration(
                color:
                    primaryGreen.withAlpha(20),
                borderRadius:
                    BorderRadius.circular(
                  15,
                ),
              ),
              child: Icon(
                icon,
                color:
                    primaryGreen,
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
                    style:
                        const TextStyle(
                      color: navy,
                      fontSize: 19,
                      fontWeight:
                          FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style:
                        const TextStyle(
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
      builder: (dialogContext) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(
              22,
            ),
          ),
          title: Text(
            title,
            style:
                const TextStyle(
              color: navy,
              fontWeight:
                  FontWeight.w800,
            ),
          ),
          content: Text(
            message,
            style:
                const TextStyle(
              color:
                  Color(0xFF455A64),
              height: 1.4,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(
                  dialogContext,
                );
              },
              child:
                  const Text(
                'OK',
                style:
                    TextStyle(
                  color:
                      primaryGreen,
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
