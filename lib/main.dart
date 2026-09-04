import 'package:flutter/material.dart';

import 'package:safenexus_hse/guidelines.dart';
import 'package:safenexus_hse/hazard_report.dart';
import 'package:safenexus_hse/observation_history.dart';
import 'package:safenexus_hse/safety_observation.dart';
import 'package:safenexus_hse/voice_report.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SafeNexus HSE',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF7F9F7),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF159447),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Color(0xFF161616),
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

  void openPage(BuildContext context, Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => page,
      ),
    );
  }

  void showComingSoon(
    BuildContext context,
    String feature,
  ) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
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
      backgroundColor: const Color(0xFFF7F9F7),

      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 76,
        titleSpacing: 16,
        title: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: green,
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(
                Icons.health_and_safety_rounded,
                color: Colors.white,
                size: 30,
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
                  'HSE',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    color: green,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(
            16,
            12,
            16,
            110,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _heroBanner(),

              const SizedBox(height: 24),

              const Padding(
                padding: EdgeInsets.only(left: 4),
                child: Text(
                  'QUICK ACTIONS',
                  style: TextStyle(
                    color: darkGreen,
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.8,
                  ),
                ),
              ),

              const SizedBox(height: 8),

              SizedBox(
                height: 430,
                width: double.infinity,
                child: _quickActions(context),
              ),

              const SizedBox(height: 8),

              _safetyOverview(),

              const SizedBox(height: 18),

              _responsibilityBanner(),

              const SizedBox(height: 20),

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
      constraints: const BoxConstraints(
        minHeight: 205,
      ),
      padding: const EdgeInsets.fromLTRB(
        22,
        24,
        18,
        24,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0xFF087A38),
            Color(0xFF159447),
            Color(0xFF2EAA61),
          ],
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x25000000),
            blurRadius: 18,
            offset: Offset(0, 9),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Safety Starts With You',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    height: 1.1,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  'Observe • Report • Prevent',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 7),
                Text(
                  'Together for a safer workplace',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 3,
            child: Container(
              height: 130,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.10),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.construction_rounded,
                color: Colors.white,
                size: 72,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _quickActions(BuildContext context) {
    return LayoutBuilder(
      builder: (
        BuildContext context,
        BoxConstraints constraints,
      ) {
        final double width = constraints.maxWidth;

        return Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            Container(
              width: width * 0.76,
              height: width * 0.76,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: green.withValues(alpha: 0.18),
                  width: 1,
                ),
              ),
            ),

            Container(
              width: width * 0.48,
              height: width * 0.48,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: purple.withValues(alpha: 0.14),
                  width: 1,
                ),
              ),
            ),

            Positioned(
              top: 18,
              left: 4,
              child: _circleAction(
                icon: Icons.visibility_rounded,
                title: 'Safety\nObservation',
                color: green,
                onTap: () {
                  openPage(
                    context,
                    const SafetyObservationPage(),
                  );
                },
              ),
            ),

            Positioned(
              top: 18,
              right: 4,
              child: _circleAction(
                icon: Icons.warning_rounded,
                title: 'Hazard\nReport',
                color: orange,
                onTap: () {
                  openPage(
                    context,
                    const HazardReportPage(),
                  );
                },
              ),
            ),

            Positioned(
              left: 0,
              top: 155,
              child: _circleAction(
                icon: Icons.camera_alt_rounded,
                title: 'Photo / AI\nAnalysis',
                color: green,
                onTap: () {
                  showComingSoon(
                    context,
                    'Photo / AI Analysis',
                  );
                },
              ),
            ),

            Positioned(
              right: 0,
              top: 155,
              child: _circleAction(
                icon: Icons.mic_rounded,
                title: 'Voice\nReport',
                color: purple,
                onTap: () {
                  openPage(
                    context,
                    const VoiceReportPage(),
                  );
                },
              ),
            ),

            Positioned(
              bottom: 12,
              left: width * 0.16,
              child: _circleAction(
                icon: Icons.shield_rounded,
                title: 'Risk\nAssessment',
                color: green,
                onTap: () {
                  showComingSoon(
                    context,
                    'Risk Assessment',
                  );
                },
              ),
            ),

            Positioned(
              bottom: 12,
              right: width * 0.16,
              child: _circleAction(
                icon: Icons.menu_book_rounded,
                title: 'HSE\nGuidelines',
                color: purple,
                onTap: () {
                  openPage(
                    context,
                    const GuidelinesPage(),
                  );
                },
              ),
            ),

            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                openPage(
                  context,
                  const HazardReportPage(),
                );
              },
              child: Container(
                width: 112,
                height: 112,
                decoration: const BoxDecoration(
                  color: green,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x30000000),
                      blurRadius: 18,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_rounded,
                      color: Colors.white,
                      size: 46,
                    ),
                    SizedBox(height: 1),
                    Text(
                      'REPORT',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 12,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _circleAction({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        width: 116,
        height: 132,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(58),
          border: Border.all(
            color: Colors.grey.shade200,
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0x14000000),
              blurRadius: 12,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.10),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: color,
                size: 28,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12.5,
                height: 1.15,
                fontWeight: FontWeight.w700,
                color: Color(0xFF171717),
              ),
            ),
            const SizedBox(height: 5),
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_forward_rounded,
                color: Colors.white,
                size: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _safetyOverview() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        14,
        18,
        14,
        16,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x10000000),
            blurRadius: 12,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'MY SAFETY OVERVIEW',
                style: TextStyle(
                  color: darkGreen,
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Row(
                children: [
                  Text(
                    'This Month',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF555555),
                    ),
                  ),
                  SizedBox(width: 4),
                  Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 18,
                    color: darkGreen,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: _statItem(
                  icon: Icons.assignment_rounded,
                  value: '12',
                  label: 'Observations\nReported',
                  color: purple,
                ),
              ),
              _divider(),
              Expanded(
                child: _statItem(
                  icon: Icons.warning_rounded,
                  value: '7',
                  label: 'Hazard Reports\nRaised',
                  color: orange,
                ),
              ),
              _divider(),
              Expanded(
                child: _statItem(
                  icon: Icons.check_circle_rounded,
                  value: '5',
                  label: 'Issues\nResolved',
                  color: green,
                ),
              ),
              _divider(),
              Expanded(
                child: _statItem(
                  icon: Icons.trending_up_rounded,
                  value: '94%',
                  label: 'Safety Score',
                  color: green,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _statItem({
    required IconData icon,
    required String value,
    required String label,
    required Color color,
  }) {
    return Column(
      children: [
        Container(
          width: 43,
          height: 43,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.09),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: color,
            size: 23,
          ),
        ),
        const SizedBox(height: 7),
        Text(
          value,
          style: const TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 9.5,
            height: 1.15,
            color: Color(0xFF555555),
          ),
        ),
      ],
    );
  }

  Widget _divider() {
    return Container(
      height: 65,
      width: 1,
      color: Colors.grey.shade200,
    );
  }

  Widget _responsibilityBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 18,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(21),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF075E2C),
            Color(0xFF159447),
          ],
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x20000000),
            blurRadius: 12,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 55,
            height: 55,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.13),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.verified_user_rounded,
              color: Colors.white,
              size: 32,
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Safety is Everyone's",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'Responsibility',
                  style: TextStyle(
                    color: Color(0xFFB9FF65),
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  'See it. Report it. Stop it. Change it.',
                  style: TextStyle(
                    color: Colors.white70,
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

  Widget _reportsButton(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        openPage(
          context,
          const ObservationHistoryPage(),
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 15,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: Colors.grey.shade200,
          ),
        ),
        child: const Row(
          children: [
            Icon(
              Icons.bar_chart_rounded,
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
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    'View your safety reports',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  Widget _bottomNavigation(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        8,
        9,
        8,
        10,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x18000000),
            blurRadius: 16,
            offset: Offset(0, -5),
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
              behavior: HitTestBehavior.opaque,
              onTap: () {
                openPage(
                  context,
                  const HazardReportPage(),
                );
              },
              child: Container(
                width: 58,
                height: 58,
                margin: const EdgeInsets.only(top: -28),
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
              icon: Icons.pie_chart_outline_rounded,
              label: 'Dashboard',
              onTap: () {
                openPage(
                  context,
                  const ObservationHistoryPage(),
                );
              },
            ),
            _bottomItem(
              icon: Icons.settings_outlined,
              label: 'Settings',
              onTap: () {
                showComingSoon(
                  context,
                  'Settings',
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
    final Color color =
        active ? green : const Color(0xFF555555);

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
              size: 25,
            ),
            const SizedBox(height: 3),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: color,
                fontSize: 10,
                fontWeight: active
                    ? FontWeight.w700
                    : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
