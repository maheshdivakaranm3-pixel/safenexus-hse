import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'hazard_report.dart';
import 'observation_history.dart';
import 'safety_observation.dart';
import 'voice_report.dart';

import 'workhub.dart';
import 'safenexus_alert_center.dart';
import 'hse_analytics_center.dart';
import 'hse_workflow_approval.dart';
import 'hse_access_control.dart';
import 'hse_backup_recovery.dart';
import 'safenexus_unified_data_center.dart';
import 'data/abu_dhabi/abu_dhabi_cop_01_to_03_reference_page.dart';

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


          if (canonicalType == 'Hazard Report') {
          } else {
          }

          final status = _normalizeStatus(report['status']);

          if (_isOpenStatus(status)) {
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

    } catch (_) {
      if (!mounted) {
        return;
      }

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
    if (!mounted) return;
    setState(() {
      _currentIndex = 3;
    });
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
                iconColor: const Color(0xFF159447),
                background: const Color(0xFFE7F8EE),
                arrowColor: const Color(0xFF159447),
                onTap: () => _openPage(const SafetyObservationPage()),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _quickActionCard(
                title: 'Hazard Report',
                subtitle: 'Report an immediate hazard',
                icon: Icons.warning_amber_rounded,
                iconColor: const Color(0xFFD92828),
                background: const Color(0xFFFFE8E8),
                arrowColor: const Color(0xFFD92828),
                onTap: () => _openPage(const HazardReportPage()),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _quickActionCard(
                title: 'Voice Report',
                subtitle: 'Report by voice',
                icon: Icons.mic_rounded,
                iconColor: const Color(0xFF6A1B9A),
                background: const Color(0xFFF0E7FF),
                arrowColor: const Color(0xFF6A1B9A),
                onTap: () => _openPage(const VoiceReportPage()),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _quickActionCard(
                title: 'Report History',
                subtitle: 'Review saved reports',
                icon: Icons.history_rounded,
                iconColor: const Color(0xFF1976D2),
                background: const Color(0xFFE5F2FF),
                arrowColor: const Color(0xFF1976D2),
                onTap: () => _openPage(const ObservationHistoryPage()),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _quickActionCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color iconColor,
    required Color background,
    required Color arrowColor,
    required VoidCallback onTap,
  }) {
    return Material(
      color: background,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 12, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: iconColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(icon, color: Colors.white, size: 27),
                  ),
                  const Spacer(),
                  Icon(Icons.arrow_forward_ios_rounded,
                      color: arrowColor, size: 20),
                ],
              ),
              const SizedBox(height: 15),
              Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: navy,
                  fontSize: 17,
                  height: 1.12,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 7),
              Text(
                subtitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Color(0xFF607D8B),
                  fontSize: 13,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // OVERVIEW DIVIDER
  // ==========================================================


  // ==========================================================
  // REFERENCE PREVIEW
  // ==========================================================

  Widget _buildReferencePreview() {
    const categories = <Map<String, dynamic>>[
      {
        'emoji': '🇦🇪',
        'title': 'UAE HSE',
        'subtitle': 'UAE-wide HSE laws, standards and best practices',
        'color': Color(0xFF159447),
        'number': '01',
      },
      {
        'emoji': '🟢',
        'title': 'Abu Dhabi HSE',
        'subtitle': 'Abu Dhabi HSE and ADPHC Gold Reference',
        'color': Color(0xFF43A047),
        'number': '02',
      },
      {
        'emoji': '🔵',
        'title': 'Dubai HSE',
        'subtitle': 'Dubai HSE requirements and safety guidance',
        'color': Color(0xFF1976D2),
        'number': '03',
      },
      {
        'emoji': '🏗️',
        'title': 'Construction',
        'subtitle': 'Construction HSE, site safety and field controls',
        'color': Color(0xFFE38B00),
        'number': '04',
      },
      {
        'emoji': '🛢️',
        'title': 'Oil & Gas',
        'subtitle': 'Oil & Gas HSE, process safety and field controls',
        'color': Color(0xFF7B35C8),
        'number': '05',
      },
      {
        'emoji': '⚓',
        'title': 'Offshore',
        'subtitle': 'Offshore operations, marine safety and emergency controls',
        'color': Color(0xFF0C9DB5),
        'number': '06',
      },
      {
        'emoji': '🏭',
        'title': 'Industrial',
        'subtitle': 'Industrial HSE, machinery, plant and operational safety',
        'color': Color(0xFFE23B45),
        'number': '07',
      },
      {
        'emoji': '🩺',
        'title': 'Occupational Health',
        'subtitle': 'Occupational health, welfare and workplace exposure control',
        'color': Color(0xFFE83E8C),
        'number': '08',
      },
      {
        'emoji': '🌱',
        'title': 'Environmental',
        'subtitle': 'Environmental protection, waste and pollution controls',
        'color': Color(0xFF4CAF50),
        'number': '09',
      },
      {
        'emoji': '🚨',
        'title': 'Emergency & Rescue',
        'subtitle': 'Emergency preparedness, response and rescue planning',
        'color': Color(0xFFE53935),
        'number': '10',
      },
      {
        'emoji': '🔥',
        'title': 'Fire & Life Safety',
        'subtitle': 'Fire prevention, protection, evacuation and life safety',
        'color': Color(0xFFFF7A00),
        'number': '11',
      },
      {
        'emoji': '📚',
        'title': 'Specialist / Cross-Sector',
        'subtitle': 'Specialist HSE topics applicable across sectors',
        'color': Color(0xFF7B2CBF),
        'number': '12',
      },
      {
        'emoji': '🎓',
        'title': 'Learning + Interview',
        'subtitle': 'HSE learning, practical knowledge and interview preparation',
        'color': Color(0xFF1976D2),
        'number': '13',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'HSE Reference',
          style: TextStyle(
            color: navy,
            fontSize: 28,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 3),
        const Text(
          'Professional UAE field reference',
          style: TextStyle(
            color: Color(0xFF607D8B),
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 14),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFE1F5E8), Color(0xFFE9F5FF)],
            ),
            borderRadius: BorderRadius.circular(22),
          ),
          child: const Row(
            children: [
              Icon(Icons.menu_book_rounded, color: primaryGreen, size: 32),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Professional UAE HSE knowledge at your fingertips',
                  style: TextStyle(
                    color: navy,
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        LayoutBuilder(
          builder: (context, constraints) {
            final twoColumns = constraints.maxWidth >= 500;
            final width = twoColumns
                ? (constraints.maxWidth - 12) / 2
                : constraints.maxWidth;

            return Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                for (final item in categories)
                  SizedBox(
                    width: width,
                    child: _referenceCategoryCard(
                      item['emoji'] as String,
                      item['title'] as String,
                      item['subtitle'] as String,
                      item['color'] as Color,
                      () {
                        final title = item['title'] as String;
                        _openSectorReference(title, item['subtitle'] as String);
                      },
                      number: item['number'] as String,
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _referenceCategoryCard(
    String emoji,
    String title,
    String subtitle,
    Color color,
    VoidCallback onTap, {
    required String number,
  }) {
    return Material(
      color: color.withAlpha(22),
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 13),
          child: Row(
            children: [
              Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(17),
                  boxShadow: [
                    BoxShadow(
                      color: color.withAlpha(25),
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Text(
                  emoji,
                  style: const TextStyle(fontSize: 28),
                ),
              ),
              const SizedBox(width: 11),
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
                        fontSize: 15.5,
                        height: 1.12,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      number,
                      style: TextStyle(
                        color: color,
                        fontSize: 11,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color(0xFF607D8B),
                        fontSize: 11.5,
                        height: 1.25,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 5),
              Icon(Icons.chevron_right_rounded, color: color, size: 29),
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


  // ==========================================================
  // GUIDELINES HOME
  // ==========================================================

  Widget _buildGuidelinesHome() {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(18, 18, 18, 24),
        child: _buildReferencePreview(),
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
  // SECTOR REFERENCE
  // ==========================================================

  Future<void> _openSectorReference(
    String title,
    String subtitle,
  ) async {
    if (title == 'Abu Dhabi HSE') {
      await _openPage(const AbuDhabiCop01To03ReferencePage());
      return;
    }

    await _openPage(
      _SectorReferencePage(
        title: title,
        subtitle: subtitle,
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

class _SectorReferencePage extends StatelessWidget {
  final String title;
  final String subtitle;

  const _SectorReferencePage({
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    const green = Color(0xFF159447);
    const navy = Color(0xFF082653);

    return Scaffold(
      backgroundColor: const Color(0xFFF4F8FB),
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.white,
        foregroundColor: navy,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                      color: navy,
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                    )),
                const SizedBox(height: 8),
                Text(subtitle,
                    style: const TextStyle(
                      color: Color(0xFF607D8B),
                      fontSize: 14,
                      height: 1.4,
                    )),
                const SizedBox(height: 18),
                const Divider(),
                const SizedBox(height: 12),
                const Text(
                  'Professional HSE Reference',
                  style: TextStyle(
                    color: navy,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Use the complete HSE reference topics for detailed safety guidance, controls, field practices and UAE requirements.',
                  style: TextStyle(
                    color: Color(0xFF607D8B),
                    fontSize: 13,
                    height: 1.45,
                  ),
                ),
                const SizedBox(height: 18),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.menu_book_rounded),
                    label: const Text('Open HSE Reference Topics'),
                    style: FilledButton.styleFrom(
                      backgroundColor: green,
                      padding: const EdgeInsets.symmetric(vertical: 15),
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
}

