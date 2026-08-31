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
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
        scaffoldBackgroundColor: const Color(0xFFF5F7FA),
        appBarTheme: const AppBarTheme(
          centerTitle: false,
          elevation: 0,
        ),
        cardTheme: const CardThemeData(
          elevation: 2,
          margin: EdgeInsets.zero,
        ),
      ),

      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _openPage(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => page,
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
            onSelected: (Locale locale) {
              context.setLocale(locale);
            },
            icon: const Icon(Icons.language),
            itemBuilder: (BuildContext context) =>
                const <PopupMenuEntry<Locale>>[
              PopupMenuItem(
                value: Locale('en', 'US'),
                child: Text('English'),
              ),
              PopupMenuItem(
                value: Locale('ml', 'IN'),
                child: Text('മലയാളം'),
              ),
            ],
          ),
        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome / Header Card
              _buildWelcomeCard(context),

              const SizedBox(height: 20),

              Text(
                'Safety Management',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),

              const SizedBox(height: 12),

              // Main Action Grid
              GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.15,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildDashboardCard(
                    context: context,
                    icon: Icons.report_problem,
                    title: 'Hazard Report',
                    subtitle: 'Report unsafe conditions',
                    onTap: () {
                      _openPage(
                        context,
                        const HazardReportPage(),
                      );
                    },
                  ),

                  _buildDashboardCard(
                    context: context,
                    icon: Icons.mic,
                    title: 'Voice Report',
                    subtitle: 'Report using your voice',
                    onTap: () {
                      _openPage(
                        context,
                        const VoiceReportPage(),
                      );
                    },
                  ),

                  _buildDashboardCard(
                    context: context,
                    icon: Icons.menu_book,
                    title: 'HSE Guidelines',
                    subtitle: 'Safety knowledge A-Z',
                    onTap: () {
                      _openPage(
                        context,
                        const GuidelinesPage(),
                      );
                    },
                  ),

                  _buildDashboardCard(
                    context: context,
                    icon: Icons.visibility,
                    title: 'Safety Observation',
                    subtitle: 'Coming soon',
                    onTap: () {
                      _showComingSoon(context);
                    },
                  ),
                ],
              ),

              const SizedBox(height: 24),

              Text(
                'Quick Access',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),

              const SizedBox(height: 12),

              _buildQuickAction(
                context,
                icon: Icons.assignment,
                title: 'Inspections',
                subtitle: 'Site inspection & checklist',
              ),

              const SizedBox(height: 10),

              _buildQuickAction(
                context,
                icon: Icons.assessment,
                title: 'Risk Assessment',
                subtitle: 'Identify hazards and controls',
              ),

              const SizedBox(height: 10),

              _buildQuickAction(
                context,
                icon: Icons.history,
                title: 'Reports & History',
                subtitle: 'View submitted safety reports',
              ),

              const SizedBox(height: 24),

              // Safety Reminder
              _buildSafetyReminder(context),

              const SizedBox(height: 16),

              Center(
                child: Text(
                  'SafeNexus HSE • Safety First',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF1565C0),
            Color(0xFF1976D2),
          ],
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.18),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.health_and_safety,
              color: Colors.white,
              size: 34,
            ),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Welcome to SafeNexus HSE',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
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

  Widget _buildDashboardCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Theme.of(context)
                      .colorScheme
                      .primary
                      .withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  icon,
                  color: Theme.of(context).colorScheme.primary,
                  size: 28,
                ),
              ),

              const Spacer(),

              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                subtitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
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

  Widget _buildQuickAction(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 4,
        ),
        leading: Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: Theme.of(context)
                .colorScheme
                .primary
                .withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(12
