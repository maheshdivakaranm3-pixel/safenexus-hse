import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:safenexus_hse/guidelines.dart';
import 'package:safenexus_hse/hazard_report.dart';
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
        primarySwatch: Colors.blue,
        useMaterial3: true,
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
        content: Text('Coming soon'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'SafeNexus HSE',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
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
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _welcomeCard(),

            const SizedBox(height: 24),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Safety Management',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: _menuCard(
                    icon: Icons.report_problem,
                    title: 'Hazard Report',
                    subtitle: 'Report hazard',
                    onTap: () {
                      openPage(
                        context,
                        const HazardReportPage(),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _menuCard(
                    icon: Icons.mic,
                    title: 'Voice Report',
                    subtitle: 'Voice reporting',
                    onTap: () {
                      openPage(
                        context,
                        const VoiceReportPage(),
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
                  child: _menuCard(
                    icon: Icons.menu_book,
                    title: 'HSE Guidelines',
                    subtitle: 'A-Z safety guide',
                    onTap: () {
                      openPage(
                        context,
                        const GuidelinesPage(),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _menuCard(
                    icon: Icons.visibility,
                    title: 'Safety Observation',
                    subtitle: 'Coming soon',
                    onTap: () {
                      showComingSoon(context);
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Quick Access',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 12),

            _quickItem(
              icon: Icons.assignment,
              title: 'Inspections',
              subtitle: 'Site inspection and checklist',
              onTap: () {
                showComingSoon(context);
              },
            ),

            const SizedBox(height: 10),

            _quickItem(
              icon: Icons.assessment,
              title: 'Risk Assessment',
              subtitle: 'Identify hazards and controls',
              onTap: () {
                showComingSoon(context);
              },
            ),

            const SizedBox(height: 10),

            _quickItem(
              icon: Icons.history,
              title: 'Reports & History',
              subtitle: 'View safety reports',
              onTap: () {
                showComingSoon(context);
              },
            ),

            const SizedBox(height: 24),

            _safetyReminder(),

            const SizedBox(height: 20),

            Text(
              'SafeNexus HSE • Safety First',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _welcomeCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF1565C0),
            Color(0xFF1976D2),
          ],
        ),
      ),
      child: const Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.white24,
            child: Icon(
              Icons.health_and_safety,
              color: Colors.white,
              size: 34,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome to SafeNexus HSE',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Safety • Observation • Compliance',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _menuCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                icon,
                size: 32,
                color: Colors.blue,
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
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

  Widget _quickItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      child: ListTile(
        onTap: onTap,
        leading: Icon(
          icon,
          color: Colors.blue,
          size: 30,
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
        ),
      ),
    );
  }

  Widget _safetyReminder() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Icon(
              Icons.info_outline,
              color: Colors.blue,
            ),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                'If you identify an unsafe condition, report it promptly and follow the applicable site safety controls.',
                style: TextStyle(
                  fontSize: 13,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
