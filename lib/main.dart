import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:safenexus_hse/guidelines.dart';
import 'package:safenexus_hse/hazard_report.dart';
import 'package:safenexus_hse/observation_history.dart';
import 'package:safenexus_hse/safety_observation.dart';
import 'package:safenexus_hse/voice_report.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('ml', 'IN'),
      ],
      path: 'assets/translations',
      useOnlyLangCode: true,
      fallbackLocale: const Locale('en', 'US'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SafeNexus HSE',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF7F8FA),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF16A34A),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Color(0xFF202124),
          elevation: 0,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void openPage(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => page,
      ),
    );
  }

  void showComingSoon(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('This feature is coming soon'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 18,
        title: const Row(
          children: [
            Icon(
              Icons.health_and_safety,
              color: Color(0xFF16A34A),
              size: 30,
            ),
            SizedBox(width: 8),
            Text(
              'SafeNexus HSE',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
        actions: [
          PopupMenuButton<Locale>(
            icon: const Icon(Icons.language),
            onSelected: (Locale locale) {
              context.setLocale(locale);
            },
            itemBuilder: (BuildContext context) {
              return const [
                PopupMenuItem<Locale>(
                  value: Locale('en', 'US'),
                  child: Text('English'),
                ),
                PopupMenuItem<Locale>(
                  value: Locale('ml', 'IN'),
                  child: Text('മലയാളം'),
                ),
              ];
            },
          ),
          const SizedBox(width: 8),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _safetyHeroCard(),

            const SizedBox(height: 24),

            const Text(
              'Safety Actions',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: _actionCard(
                    icon: Icons.visibility_outlined,
                    title: 'Safety Observation',
                    subtitle: 'Observe & record',
                    iconColor: const Color(0xFF16A34A),
                    backgroundColor: const Color(0xFFEAF8EF),
                    onTap: () {
                      openPage(
                        context,
                        const SafetyObservationPage(),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _actionCard(
                    icon: Icons.warning_amber_rounded,
                    title: 'Hazard Report',
                    subtitle: 'Report hazards',
                    iconColor: const Color(0xFF7C3AED),
                    backgroundColor: const Color(0xFFF1EAFE),
                    onTap: () {
                      openPage(
                        context,
                        const HazardReportPage(),
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
                  child: _actionCard(
                    icon: Icons.mic_none_rounded,
                    title: 'Voice Report',
                    subtitle: 'Report by voice',
                    iconColor: const Color(0xFF7C3AED),
                    backgroundColor: const Color(0xFFF1EAFE),
                    onTap: () {
                      openPage(
                        context,
                        const VoiceReportPage(),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _actionCard(
                    icon: Icons.camera_alt_outlined,
                    title: 'Photo / AI Analysis',
                    subtitle: 'Analyze hazards',
                    iconColor: const Color(0xFF16A34A),
                    backgroundColor: const Color(0xFFEAF8EF),
                    onTap: () {
                      showComingSoon(context);
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            const Text(
              'Safety Tools',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            _toolItem(
              icon: Icons.assignment_outlined,
              title: 'Risk Assessment',
              subtitle: 'Identify hazards and controls',
              iconColor: const Color(0xFF16A34A),
              onTap: () {
                showComingSoon(context);
              },
            ),

            const SizedBox(height: 10),

            _toolItem(
              icon: Icons.menu_book_outlined,
              title: 'HSE Guidelines',
              subtitle: 'A-Z safety guidance',
              iconColor: const Color(0xFF7C3AED),
              onTap: () {
                openPage(
                  context,
                  const GuidelinesPage(),
                );
              },
            ),

            const SizedBox(height: 10),

            _toolItem(
              icon: Icons.bar_chart_rounded,
              title: 'Reports & Dashboard',
              subtitle: 'View safety reports and history',
              iconColor: const Color(0xFF16A34A),
              onTap: () {
                openPage(
                  context,
                  const ObservationHistoryPage(),
                );
              },
            ),

            const SizedBox(height: 10),

            _toolItem(
              icon: Icons.settings_outlined,
              title: 'Settings',
              subtitle: 'Language and app settings',
              iconColor: const Color(0xFF7C3AED),
              onTap: () {
                showComingSoon(context);
              },
            ),

            const SizedBox(height: 24),

            _safetyReminder(),

            const SizedBox(height: 22),

            Center(
              child: Text(
                'SafeNexus HSE • Safety First',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _safetyHeroCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF16A34A),
            Color(0xFF7C3AED),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.10),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.18),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.shield_outlined,
              color: Colors.white,
              size: 36,
            ),
          ),

          const SizedBox(width: 16),

          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Safety Starts With You',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 7),
                Text(
                  'Observe • Report • Prevent',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Together for a safer workplace',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color iconColor,
    required Color backgroundColor,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          height: 155,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: Colors.grey.shade200,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 27,
                ),
              ),

              const Spacer(),

              Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _toolItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(17),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(17),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 26,
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
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),

              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16,
                color: Colors.grey.shade500,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _safetyReminder() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF1EAFE),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFE4D7FC),
        ),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline_rounded,
            color: Color(0xFF7C3AED),
            size: 24,
          ),

          SizedBox(width: 12),

          Expanded(
            child: Text(
              'If you identify an unsafe condition, report it promptly and follow the applicable site safety controls.',
              style: TextStyle(
                fontSize: 13,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
