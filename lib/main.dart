import 'package:flutter/material.dart';

import 'package:safenexus_hse/guidelines.dart';
import 'package:safenexus_hse/hazard_report.dart';
import 'package:safenexus_hse/observation_history.dart';
import 'package:safenexus_hse/safety_observation.dart';
import 'package:safenexus_hse/voice_report.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const SafeNexusApp());
}

class SafeNexusApp extends StatelessWidget {
  const SafeNexusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SafeNexus HSE',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF6F8F7),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF159447),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Color(0xFF151515),
          elevation: 0,
          surfaceTintColor: Colors.transparent,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const Color green = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF087A38);
  static const Color purple = Color(0xFF6736C8);
  static const Color orange = Color(0xFFFF8A00);
  static const Color red = Color(0xFFD93636);

  void openPage(BuildContext context, Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => page),
    );
  }

  void showComingSoon(BuildContext context, String feature) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('$feature is coming soon'),
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(16),
          duration: const Duration(seconds: 2),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8F7),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 72,
        titleSpacing: 16,
        title: Row(
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: green,
                borderRadius: BorderRadius.circular(13),
              ),
              child: const Icon(
                Icons.health_and_safety_rounded,
                color: Colors.white,
                size: 29,
              ),
            ),
            const SizedBox(width: 11),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'SafeNexus',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  'HSE SAFETY',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    color: green,
                    letterSpacing: 1.1,
                  ),
                ),
              ],
            ),
          ],
        ),
        // Top-right Settings removed.
        // Settings remains available in bottom navigation.
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 105),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _heroBanner(),
              const SizedBox(height: 22),

              _sectionTitle(
                'QUICK ACTIONS',
                'Report and manage workplace safety issues',
              ),
              const SizedBox(height: 12),

              _quickActions(context),
              const SizedBox(height: 22),

              _sectionTitle(
                'SAFETY OVERVIEW',
                'Your current safety activity',
              ),
              const SizedBox(height: 12),

              _safetyOverview(context),
              const SizedBox(height: 22),

              _sectionTitle(
                'UAE HSE SAFETY',
                'Choose UAE, Dubai or Abu Dhabi safety guidance',
              ),
              const SizedBox(height: 12),

              _uaeSafetySection(context),
              const SizedBox(height: 22),

              _aiBanner(context),
              const SizedBox(height: 22),

              _reportsButton(context),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _bottomNavigation(context),
    );
  }

  Widget _heroBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(21, 22, 18, 22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            darkGreen,
            green,
            Color(0xFF2EAA61),
          ],
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x22000000),
            blurRadius: 16,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Safety Starts With You',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    height: 1.1,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Observe • Report • Prevent',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Together for a safer workplace.',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 82,
            height: 82,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.construction_rounded,
              color: Colors.white,
              size: 48,
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: darkGreen,
            fontSize: 14,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.8,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          subtitle,
          style: const TextStyle(
            color: Color(0xFF707070),
            fontSize: 11.5,
          ),
        ),
      ],
    );
  }

  Widget _quickActions(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.55,
      children: [
        _actionCard(
          icon: Icons.warning_amber_rounded,
          title: 'Hazard Report',
          subtitle: 'Report a workplace hazard',
          color: orange,
          onTap: () {
            openPage(context, const HazardReportPage());
          },
        ),
        _actionCard(
          icon: Icons.visibility_rounded,
          title: 'Safety Observation',
          subtitle: 'Record a safety observation',
          color: green,
          onTap: () {
            openPage(context, const SafetyObservationPage());
          },
        ),
        _actionCard(
          icon: Icons.mic_rounded,
          title: 'Voice Report',
          subtitle: 'Report using your voice',
          color: purple,
          onTap: () {
            openPage(context, const VoiceReportPage());
          },
        ),
        _actionCard(
          icon: Icons.menu_book_rounded,
          title: 'HSE Guidelines',
          subtitle: 'UAE safety guidance',
          color: darkGreen,
          onTap: () {
            openPage(context, const GuidelinesPage());
          },
        ),
        _actionCard(
          icon: Icons.shield_rounded,
          title: 'Risk Assessment',
          subtitle: 'Coming soon',
          color: red,
          onTap: () {
            showComingSoon(context, 'Risk Assessment');
          },
          comingSoon: true,
        ),
        _actionCard(
          icon: Icons.auto_awesome_rounded,
          title: 'AI Safety',
          subtitle: 'Smart safety assistance',
          color: purple,
          onTap: () {
            showComingSoon(context, 'AI Safety Assistant');
          },
          comingSoon: true,
        ),
      ],
    );
  }

  Widget _actionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
    bool comingSoon = false,
  }) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(13),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: Colors.grey.shade200,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 47,
                height: 47,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.10),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 25,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Color(0xFF777777),
                        fontSize: 10,
                        height: 1.15,
                      ),
                    ),
                  ],
                ),
              ),
              if (!comingSoon)
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 13,
                  color: color,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _safetyOverview(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(
                Icons.analytics_outlined,
                color: green,
                size: 21,
              ),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'Safety Activity',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  openPage(
                    context,
                    const ObservationHistoryPage(),
                  );
                },
                child: const Text('View Reports'),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: _stat(
                  '12',
                  'Observations',
                  Icons.visibility_outlined,
                  purple,
                ),
              ),
              _verticalDivider(),
              Expanded(
                child: _stat(
                  '7',
                  'Hazards',
                  Icons.warning_amber_rounded,
                  orange,
                ),
              ),
              _verticalDivider(),
              Expanded(
                child: _stat(
                  '5',
                  'Resolved',
                  Icons.check_circle_outline_rounded,
                  green,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _stat(
    String value,
    String label,
    IconData icon,
    Color color,
  ) {
    return Column(
      children: [
        Icon(icon, color: color, size: 23),
        const SizedBox(height: 5),
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        ),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color(0xFF666666),
            fontSize: 10,
          ),
        ),
      ],
    );
  }

  Widget _verticalDivider() {
    return Container(
      height: 52,
      width: 1,
      color: Colors.grey.shade200,
    );
  }

  Widget _uaeSafetySection(BuildContext context) {
    return Column(
      children: [
        _regionCard(
          context,
          icon: Icons.flag_rounded,
          title: 'UAE HSE Safety',
          subtitle: 'UAE-wide HSE guidance',
          color: green,
        ),
        const SizedBox(height: 10),
        _regionCard(
          context,
          icon: Icons.location_city_rounded,
          title: 'Dubai HSE Safety',
          subtitle: 'Dubai safety guidance',
          color: const Color(0xFF1677C8),
        ),
        const SizedBox(height: 10),
        _regionCard(
          context,
          icon: Icons.account_balance_rounded,
          title: 'Abu Dhabi HSE Safety',
          subtitle: 'ADOSH-SF safety guidance',
          color: purple,
        ),
      ],
    );
  }

  Widget _regionCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
  }) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () {
          openPage(
            context,
            const GuidelinesPage(),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: Colors.grey.shade200,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 27,
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
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: Color(0xFF777777),
                        fontSize: 11.5,
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

  Widget _aiBanner(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showComingSoon(context, 'AI Safety Assistant');
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(17),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            colors: [
              Color(0xFF512DA8),
              Color(0xFF6736C8),
            ],
          ),
        ),
        child: const Row(
          children: [
            Icon(
              Icons.auto_awesome_rounded,
              color: Colors.white,
              size: 32,
            ),
            SizedBox(width: 13),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'AI Safety Assistant',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 3),
                  Text(
                    'Smart HSE assistance is coming soon.',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.white,
              size: 15,
            ),
          ],
        ),
      ),
    );
  }

  Widget _reportsButton(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () {
          openPage(
            context,
            const ObservationHistoryPage(),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(17),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: Colors.grey.shade200,
            ),
          ),
          child: const Row(
            children: [
              Icon(
                Icons.folder_copy_outlined,
                color: green,
                size: 28,
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Reports & History',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      'View your saved safety reports',
                      style: TextStyle(
                        color: Color(0xFF777777),
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 15,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bottomNavigation(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 9),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x18000000),
            blurRadius: 14,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _bottomItem(
              icon: Icons.home_rounded,
              label: 'Home',
              active: true,
              onTap: () {},
            ),
            _bottomItem(
              icon: Icons.description_outlined,
              label: 'Reports',
              onTap: () {
                openPage(
                  context,
                  const ObservationHistoryPage(),
                );
              },
            ),
            GestureDetector(
              onTap: () {
                openPage(
                  context,
                  const HazardReportPage(),
                );
              },
              child: Container(
                width: 58,
                height: 58,
                margin: const EdgeInsets.only(top: -27),
                decoration: const BoxDecoration(
                  color: green,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x30000000),
                      blurRadius: 12,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.add_rounded,
                  color: Colors.white,
                  size: 35,
                ),
              ),
            ),
            _bottomItem(
              icon: Icons.menu_book_outlined,
              label: 'Guides',
              onTap: () {
                openPage(
                  context,
                  const GuidelinesPage(),
                );
              },
            ),
            _bottomItem(
              icon: Icons.settings_outlined,
              label: 'Settings',
              onTap: () {
                openPage(
                  context,
                  const SettingsPage(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _bottomItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool active = false,
  }) {
    final color = active ? green : const Color(0xFF555555);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: SizedBox(
        width: 62,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: color,
              size: 24,
            ),
            const SizedBox(height: 3),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: color,
                fontSize: 10,
                fontWeight:
                    active ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  static const Color green = Color(0xFF159447);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8F7),
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 18, 16, 30),
        children: [
          _settingsHeader(),
          const SizedBox(height: 18),

          _sectionLabel('APP SETTINGS'),
          const SizedBox(height: 8),

          _settingsTile(
            icon: Icons.language_rounded,
            title: 'Language',
            subtitle: 'English',
            onTap: () {},
          ),

          _settingsTile(
            icon: Icons.notifications_outlined,
            title: 'Notifications',
            subtitle: 'Coming soon',
            onTap: () {
              _showComingSoon(context, 'Notifications');
            },
          ),

          const SizedBox(height: 18),

          _sectionLabel('SAFETY & DATA'),
          const SizedBox(height: 8),

          _settingsTile(
            icon: Icons.security_rounded,
            title: 'Privacy & Data',
            subtitle: 'Your safety information',
            onTap: () {
              _showInfo(
                context,
                'Privacy & Data',
                'SafeNexus HSE stores safety information locally on the device unless a feature specifically sends data to a configured service.',
              );
            },
          ),

          _settingsTile(
            icon: Icons.cloud_done_outlined,
            title: 'AI Service',
            subtitle: 'Configured through secure backend',
            onTap: () {
              _showInfo(
                context,
                'AI Service',
                'AI requests are handled through the SafeNexus backend service. API credentials should not be stored directly inside the mobile application.',
              );
            },
          ),

          const SizedBox(height: 18),

          _sectionLabel('ABOUT'),
          const SizedBox(height: 8),

          _settingsTile(
            icon: Icons.info_outline_rounded,
            title: 'About SafeNexus HSE',
            subtitle: 'UAE-focused HSE safety application',
            onTap: () {
              _showInfo(
                context,
                'About SafeNexus HSE',
                'SafeNexus HSE is designed to support workplace hazard reporting, safety observations, HSE guidance and practical safety management.',
              );
            },
          ),

          _settingsTile(
            icon: Icons.verified_outlined,
            title: 'App Version',
            subtitle: 'Version 1.0.1',
            onTap: () {},
          ),

          const SizedBox(height: 25),

          Center(
            child: Column(
              children: [
                Container(
                  width: 58,
                  height: 58,
                  decoration: BoxDecoration(
                    color: green.withValues(alpha: 0.10),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.health_and_safety_rounded,
                    color: green,
                    size: 31,
                  ),
                ),
                const SizedBox(height: 9),
                const Text(
                  'SafeNexus HSE',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 3),
                const Text(
                  'Safety Starts With You',
                  style: TextStyle(
                    color: Color(0xFF777777),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _settingsHeader() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: const Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: Color(0x16159447),
            child: Icon(
              Icons.settings_rounded,
              color: green,
              size: 29,
            ),
          ),
          SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'SafeNexus Settings',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Manage app preferences and information',
                  style: TextStyle(
                    color: Color(0xFF777777),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Color(0xFF087A38),
        fontSize: 13,
        fontWeight: FontWeight.w800,
        letterSpacing: 0.7,
      ),
    );
  }

  Widget _settingsTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 9),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 3,
        ),
        leading: Container(
          width: 42,
          height: 42,
          decoration: const BoxDecoration(
            color: Color(0x14159447),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: green,
            size: 22,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 13.5,
            fontWeight: FontWeight.w700,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
            color: Color(0xFF777777),
            fontSize: 10.5,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios_rounded,
          size: 14,
          color: Color(0xFF999999),
        ),
      ),
    );
  }

  void _showComingSoon(BuildContext context, String feature) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('$feature is coming soon'),
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(16),
        ),
      );
  }

  void _showInfo(
    BuildContext context,
    String title,
    String message,
  ) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w800,
            ),
          ),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
