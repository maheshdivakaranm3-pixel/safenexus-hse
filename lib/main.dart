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
          elevation: 0,
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

  void _showComingSoon(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'This module will be added in the next development phase.',
        ),
        duration: Duration(seconds: 2),
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
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildWelcomeCard(),

              const SizedBox(height: 24),

              const Text(
                'Safety Management',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.15,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildDashboardCard(
                    context,
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
                    context,
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
                    context,
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
                    context,
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

              const Text(
                'Quick Access',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              _buildQuickAction(
                context,
                icon: Icons.assignment,
                title: 'Inspections',
                subtitle: 'Site inspection and checklist',
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

              _buildSafetyReminder(),

              const SizedBox(height: 20),

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

  Widget _buildWelcomeCard() {
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
      child: const Row(
        children: [
          CircleAvatar(
            radius: 29,
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
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Safety • Observation • Compliance',
                  style: TextStyle(
                   
