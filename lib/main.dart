import 'package:flutter/material.dart';

import 'abu_dhabi_gold_root_page.dart';
import 'data/dubai_guidelines.dart';
import 'data/hse_safety_reference.dart';
import 'data/uae_general_guidelines.dart';
import 'guidelines.dart';
import 'hazard_report.dart';
import 'models/guideline_category.dart';
import 'observation_history.dart';
import 'safety_observation.dart';
import 'voice_report.dart';
import 'workhub.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const SafeNexusApp());
}

/// SafeNexus HSE
/// Production app entry point.
///
/// This file is the active application shell. The previous large dashboard
/// implementation is intentionally removed from the app entry point so the
/// current HSE modules and reference layers are what the APK opens.
class SafeNexusApp extends StatelessWidget {
  const SafeNexusApp({super.key});

  static const Color green = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF075B45);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SafeNexus HSE',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: green,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF4F8FB),
        appBarTheme: const AppBarTheme(
          backgroundColor: darkGreen,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      home: const SafeNexusHomePage(),
    );
  }
}

class SafeNexusHomePage extends StatefulWidget {
  const SafeNexusHomePage({super.key});


  @override
  State<SafeNexusHomePage> createState() => _SafeNexusHomePageState();
}

class _SafeNexusHomePageState extends State<SafeNexusHomePage> {
  static const Color green = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF075B45);
  static const Color navy = Color(0xFF082653);

  int _index = 0;

  void _open(Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => page),
    );
  }

  void _openReference(GuidelineCategory category) {
    if (category == GuidelineCategory.abuDhabi) {
      _open(const AbuDhabiGoldRootPage());
      return;
    }

    _open(GuidelinesPage(initialCategory: category));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: darkGreen,
        toolbarHeight: 68,
        titleSpacing: 10,
        title: Image.asset(
          'assets/images/safenexus_hse_header_mobile.png',
          height: 54,
          fit: BoxFit.contain,
          alignment: Alignment.centerLeft,
        ),
        actions: [
          IconButton(
            tooltip: 'Observation History',
            onPressed: () => _open(const ObservationHistoryPage()),
            icon: const Icon(Icons.history_rounded),
          ),
        ],
      ),
      body: IndexedStack(
        index: _index,
        children: [
          _home(),
          _reporting(),
          const WorkHubPage(),
          _reference(),
          _settings(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (value) {
          setState(() => _index = value);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.report_outlined),
            selectedIcon: Icon(Icons.report_rounded),
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
      ),
    );
  }

  Widget _home() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
      children: [
        _hero(),
        const SizedBox(height: 18),
        _sectionTitle('Quick Safety Actions', 'Field reporting'),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: _actionCard(
                icon: Icons.visibility_rounded,
                title: 'Safety Observation',
                subtitle: 'Record safe / unsafe conditions',
                onTap: () => _open(const SafetyObservationPage()),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _actionCard(
                icon: Icons.warning_amber_rounded,
                title: 'Hazard Report',
                subtitle: 'Report an immediate hazard',
                onTap: () => _open(const HazardReportPage()),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: _actionCard(
                icon: Icons.mic_rounded,
                title: 'Voice Report',
                subtitle: 'Report by voice',
                onTap: () => _open(const VoiceReportPage()),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _actionCard(
                icon: Icons.history_rounded,
                title: 'Report History',
                subtitle: 'Review saved reports',
                onTap: () => _open(const ObservationHistoryPage()),
              ),
            ),
          ],
        ),
        const SizedBox(height: 22),
        _sectionTitle('HSE Reference', 'Professional UAE field reference'),
        const SizedBox(height: 10),
        _referenceCard(
          icon: '🇦🇪',
          title: 'UAE HSE Reference',
          subtitle: '${uaeGeneralGuidelines.length} UAE-wide reference topics',
          onTap: () => _openReference(GuidelineCategory.uaeGeneral),
        ),
        _referenceCard(
          icon: '🟢',
          title: 'Abu Dhabi HSE Reference',
          subtitle: 'ADPHC / Abu Dhabi Gold Standard reference',
          onTap: () => _openReference(GuidelineCategory.abuDhabi),
        ),
        _referenceCard(
          icon: '🔵',
          title: 'Dubai HSE Reference',
          subtitle: '${dubaiGuidelines.length} Dubai reference topics',
          onTap: () => _openReference(GuidelineCategory.dubai),
        ),
        _referenceCard(
          icon: '📚',
          title: 'Complete HSE Guide',
          subtitle: '${hseSafetyReferences.length} professional HSE reference topics',
          onTap: () => _openReference(GuidelineCategory.hseReference),
        ),
        const SizedBox(height: 22),
        _sectionTitle('HSE Field Areas', 'Current application modules'),
        const SizedBox(height: 10),
        _fieldAreaGrid(),
      ],
    );
  }

  Widget _hero() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: AspectRatio(
        aspectRatio: 1672 / 941,
        child: Image.asset(
          'assets/images/safenexus_hse_banner.png',
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _reporting() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _sectionTitle('Safety Reporting', 'Capture field information quickly'),
        const SizedBox(height: 12),
        _largeAction(
          Icons.visibility_rounded,
          'Safety Observation',
          'Record safe acts, unsafe acts and unsafe conditions.',
          () => _open(const SafetyObservationPage()),
        ),
        _largeAction(
          Icons.warning_amber_rounded,
          'Hazard Report',
          'Create a hazard report with field details and evidence.',
          () => _open(const HazardReportPage()),
        ),
        _largeAction(
          Icons.mic_rounded,
          'Voice Report',
          'Use the voice reporting workflow.',
          () => _open(const VoiceReportPage()),
        ),
        _largeAction(
          Icons.history_rounded,
          'Observation History',
          'Review previously saved observations and reports.',
          () => _open(const ObservationHistoryPage()),
        ),
      ],
    );
  }

  Widget _reference() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _sectionTitle('HSE Reference', 'Jurisdiction and professional guidance'),
        const SizedBox(height: 12),
        _referenceCard(
          icon: '🇦🇪',
          title: 'UAE HSE Reference',
          subtitle: 'UAE-wide HSE guidance',
          onTap: () => _openReference(GuidelineCategory.uaeGeneral),
        ),
        _referenceCard(
          icon: '🟢',
          title: 'Abu Dhabi HSE Reference',
          subtitle: 'Abu Dhabi / ADPHC Gold Standard routing',
          onTap: () => _openReference(GuidelineCategory.abuDhabi),
        ),
        _referenceCard(
          icon: '🔵',
          title: 'Dubai HSE Reference',
          subtitle: 'Dubai HSE guidance',
          onTap: () => _openReference(GuidelineCategory.dubai),
        ),
        _referenceCard(
          icon: '📚',
          title: 'Complete HSE Guide',
          subtitle: 'Professional HSE knowledge reference',
          onTap: () => _openReference(GuidelineCategory.hseReference),
        ),
      ],
    );
  }

  Widget _settings() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _sectionTitle('Settings', 'SafeNexus HSE'),
        const SizedBox(height: 12),
        Card(
          child: ListTile(
            leading: const Icon(Icons.menu_book_rounded, color: green),
            title: const Text('HSE Reference'),
            subtitle: const Text('Open the complete reference library'),
            trailing: const Icon(Icons.chevron_right_rounded),
            onTap: () => setState(() => _index = 3),
          ),
        ),
        Card(
          child: ListTile(
            leading: const Icon(Icons.history_rounded, color: green),
            title: const Text('Observation History'),
            subtitle: const Text('Review saved field reports'),
            trailing: const Icon(Icons.chevron_right_rounded),
            onTap: () => _open(const ObservationHistoryPage()),
          ),
        ),
        Card(
          child: const ListTile(
            leading: Icon(Icons.language_rounded, color: green),
            title: Text('Language'),
            subtitle: Text('English • Malayalam'),
          ),
        ),
        const SizedBox(height: 20),
        const Center(
          child: Text(
            'SafeNexus HSE\nSafe People • Safe Workplaces • Safer UAE',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF607D8B),
              height: 1.5,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _fieldAreaGrid() {
    const areas = [
      ('🏗️', 'Construction'),
      ('🛢️', 'Oil & Gas'),
      ('⚓', 'Offshore'),
      ('🏭', 'Industrial'),
      ('🩺', 'Occupational Health'),
      ('🌱', 'Environmental HSE'),
      ('🚨', 'Emergency & Rescue'),
      ('🔥', 'Fire & Life Safety'),
      ('📚', 'Specialist / Cross-Sector'),
      ('🎓', 'Learning + Interview'),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: areas.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1.55,
      ),
      itemBuilder: (context, index) {
        final area = areas[index];
        return Card(
          elevation: 0,
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () => _openReference(GuidelineCategory.hseReference),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(area.$1, style: const TextStyle(fontSize: 25)),
                  const SizedBox(height: 7),
                  Text(
                    area.$2,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: navy,
                      fontWeight: FontWeight.w800,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _sectionTitle(String title, String subtitle) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: navy,
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                subtitle,
                style: const TextStyle(
                  color: Color(0xFF607D8B),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _actionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 0,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: green, size: 28),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(
                  color: navy,
                  fontWeight: FontWeight.w900,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Color(0xFF607D8B),
                  fontSize: 10.5,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _referenceCard({
    required String icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 7,
        ),
        leading: CircleAvatar(
          backgroundColor: green.withAlpha(20),
          child: Text(icon, style: const TextStyle(fontSize: 20)),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: navy,
            fontWeight: FontWeight.w900,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 3),
          child: Text(subtitle),
        ),
        trailing: const Icon(Icons.chevron_right_rounded),
        onTap: onTap,
      ),
    );
  }

  Widget _largeAction(
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap,
  ) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        contentPadding: const EdgeInsets.all(14),
        leading: CircleAvatar(
          radius: 25,
          backgroundColor: green.withAlpha(20),
          child: Icon(icon, color: green),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: navy,
            fontWeight: FontWeight.w900,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Text(subtitle),
        ),
        trailing: const Icon(Icons.chevron_right_rounded),
        onTap: onTap,
      ),
    );
  }
}
