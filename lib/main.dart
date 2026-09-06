import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'hazard_report.dart';
import 'observation_history.dart';
import 'safety_observation.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    const SafeNexusApp(),
  );
}

// ============================================================
// APP
// ============================================================

class SafeNexusApp extends StatelessWidget {
  const SafeNexusApp({
    super.key,
  });

  static const Color primaryGreen =
      Color(0xFF159447);

  static const Color darkGreen =
      Color(0xFF0B5D4B);

  @override
  Widget build(
    BuildContext context,
  ) {
    return MaterialApp(
      debugShowCheckedModeBanner:
          false,
      title: 'SafeNexus HSE',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme:
            ColorScheme.fromSeed(
          seedColor:
              primaryGreen,
          brightness:
              Brightness.light,
        ),
        scaffoldBackgroundColor:
            const Color(
          0xFFF6F8F7,
        ),
        appBarTheme:
            const AppBarTheme(
          centerTitle: true,
          backgroundColor:
              Colors.transparent,
          elevation: 0,
        ),
        cardTheme:
            const CardThemeData(
          elevation: 0,
          margin: EdgeInsets.zero,
        ),
        inputDecorationTheme:
            const InputDecorationTheme(
          border:
              OutlineInputBorder(),
        ),
      ),
      home:
          const SafeNexusHomePage(),
    );
  }
}

// ============================================================
// HOME PAGE
// ============================================================

class SafeNexusHomePage
    extends StatefulWidget {
  const SafeNexusHomePage({
    super.key,
  });

  @override
  State<SafeNexusHomePage> createState() =>
      _SafeNexusHomePageState();
}

class _SafeNexusHomePageState
    extends State<SafeNexusHomePage> {
  static const String _storageKey =
      'safenexus_observations';

  int _currentIndex = 0;

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
  // LOAD DASHBOARD STATS
  // ==========================================================

  Future<void>
      _loadDashboardStats() async {
    try {
      final prefs =
          await SharedPreferences
              .getInstance();

      final records =
          prefs.getStringList(
                _storageKey,
              ) ??
              <String>[];

      int total = 0;
      int observations = 0;
      int hazards = 0;
      int open = 0;

      for (final raw in records) {
        try {
          final decoded =
              jsonDecode(raw);

          if (decoded is! Map) {
            continue;
          }

          final report =
              Map<String, dynamic>.from(
            decoded,
          );

          final id =
              _stringValue(
            report['id'],
          );

          if (id.isEmpty) {
            continue;
          }

          total++;

          final type =
              _stringValue(
            report['reportType'],
          ).toLowerCase();

          if (type.contains(
            'hazard',
          )) {
            hazards++;
          } else {
            observations++;
          }

          final status =
              _stringValue(
            report['status'],
          ).toLowerCase();

          if (status.isEmpty ||
              status == 'open' ||
              status == 'pending' ||
              status == 'in progress') {
            open++;
          }
        } catch (_) {
          // Ignore one corrupted record.
          continue;
        }
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
  // STRING
  // ==========================================================

  String _stringValue(
    dynamic value,
  ) {
    if (value == null) {
      return '';
    }

    return value
        .toString()
        .trim();
  }

  // ==========================================================
  // REFRESH
  // ==========================================================

  Future<void>
      _refreshDashboard() async {
    await _loadDashboardStats();

    if (!mounted) return;

    setState(() {});
  }

  // ==========================================================
  // NAVIGATION
  // ==========================================================

  void _openPage(
    Widget page,
  ) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => page,
      ),
    );

    // Reload dashboard after returning from
    // Observation / Hazard / History.
    await _loadDashboardStats();
  }

  // ==========================================================
  // NAVIGATION ITEMS
  // ==========================================================

  List<Widget> get _pages {
    return [
      _buildDashboard(),

      const SafetyObservationPage(),

      const HazardReportPage(),

      const ObservationHistoryPage(),
    ];
  }

  // ==========================================================
  // BUILD
  // ==========================================================

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      body:
          IndexedStack(
        index:
            _currentIndex,
        children:
            _pages,
      ),
      bottomNavigationBar:
          NavigationBar(
        selectedIndex:
            _currentIndex,
        onDestinationSelected:
            (index) {
          setState(() {
            _currentIndex =
                index;
          });

          if (index == 0) {
            _loadDashboardStats();
          }
        },
        destinations: const [
          NavigationDestination(
            icon:
                Icon(
              Icons
                  .dashboard_outlined,
            ),
            selectedIcon:
                Icon(
              Icons
                  .dashboard_rounded,
            ),
            label:
                'Dashboard',
          ),
          NavigationDestination(
            icon:
                Icon(
              Icons
                  .visibility_outlined,
            ),
            selectedIcon:
                Icon(
              Icons
                  .visibility_rounded,
            ),
            label:
                'Observation',
          ),
          NavigationDestination(
            icon:
                Icon(
              Icons
                  .warning_amber_outlined,
            ),
            selectedIcon:
                Icon(
              Icons
                  .warning_rounded,
            ),
            label:
                'Hazard',
          ),
          NavigationDestination(
            icon:
                Icon(
              Icons
                  .history_outlined,
            ),
            selectedIcon:
                Icon(
              Icons
                  .history_rounded,
            ),
            label:
                'History',
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
      child:
          RefreshIndicator(
        onRefresh:
            _refreshDashboard,
        child:
            ListView(
          physics:
              const AlwaysScrollableScrollPhysics(),
          padding:
              const EdgeInsets.fromLTRB(
            16,
            12,
            16,
            32,
          ),
          children: [
            _buildDashboardHeader(),

            const SizedBox(
              height: 18,
            ),

            _buildWelcomeCard(),

            const SizedBox(
              height: 18,
            ),

            _buildStatsGrid(),

            const SizedBox(
              height: 22,
            ),

            _buildQuickActions(),

            const SizedBox(
              height: 22,
            ),

            _buildSafetyReferenceCard(),

            const SizedBox(
              height: 16,
            ),

            _buildUaeIdentityCard(),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // HEADER
  // ==========================================================

  Widget _buildDashboardHeader() {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration:
              BoxDecoration(
            color:
                const Color(
              0xFF159447,
            ).withValues(
              alpha: 0.10,
            ),
            borderRadius:
                BorderRadius.circular(
              15,
            ),
          ),
          child:
              const Icon(
            Icons
                .health_and_safety_rounded,
            color:
                Color(
              0xFF159447,
            ),
            size: 28,
          ),
        ),

        const SizedBox(
          width: 12,
        ),

        Expanded(
          child:
              Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              const Text(
                'SafeNexus HSE',
                style:
                    TextStyle(
                  fontSize: 23,
                  fontWeight:
                      FontWeight.w900,
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              Text(
                'UAE HSE Safety Platform 🇦🇪',
                style:
                    Theme.of(
                  context,
                )
                        .textTheme
                        .bodySmall
                        ?.copyWith(
                          fontWeight:
                              FontWeight.w600,
                        ),
              ),
            ],
          ),
        ),

        IconButton(
          tooltip:
              'Refresh',
          onPressed:
              _loadDashboardStats,
          icon:
              const Icon(
            Icons
                .refresh_rounded,
          ),
        ),
      ],
    );
  }

  // ==========================================================
  // WELCOME CARD
  // ==========================================================

  Widget _buildWelcomeCard() {
    return Card(
      child:
          Padding(
        padding:
            const EdgeInsets.all(
          20,
        ),
        child:
            Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            const Text(
              'Workplace Safety Starts Here',
              style:
                  TextStyle(
                fontSize: 21,
                fontWeight:
                    FontWeight.w800,
              ),
            ),

            const SizedBox(
              height: 8,
            ),

            Text(
              'Report hazards, record safety observations and keep your HSE information organised in one place.',
              style:
                  Theme.of(
                context,
              )
                      .textTheme
                      .bodyMedium,
            ),

            const SizedBox(
              height: 18,
            ),

            SizedBox(
              width:
                  double.infinity,
              child:
                  FilledButton.icon(
                onPressed:
                    () {
                  setState(() {
                    _currentIndex =
                        2;
                  });
                },
                icon:
                    const Icon(
                  Icons
                      .warning_rounded,
                ),
                label:
                    const Text(
                  'Report a Hazard',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // STATS GRID
  // ==========================================================

  Widget _buildStatsGrid() {
    if (_loadingStats) {
      return const SizedBox(
        height: 160,
        child:
            Center(
          child:
              CircularProgressIndicator(),
        ),
      );
    }

    return GridView.count(
      crossAxisCount:
          2,
      shrinkWrap:
          true,
      physics:
          const NeverScrollableScrollPhysics(),
      crossAxisSpacing:
          12,
      mainAxisSpacing:
          12,
      childAspectRatio:
          1.55,
      children: [
        _buildStatCard(
          title:
              'Total Reports',
          value:
              _totalReports
                  .toString(),
          icon:
              Icons
                  .assessment_rounded,
        ),

        _buildStatCard(
          title:
              'Observations',
          value:
              _observations
                  .toString(),
          icon:
              Icons
                  .visibility_rounded,
        ),

        _buildStatCard(
          title:
              'Hazards',
          value:
              _hazards
                  .toString(),
          icon:
              Icons
                  .warning_rounded,
        ),

        _buildStatCard(
          title:
              'Open Reports',
          value:
              _openReports
                  .toString(),
          icon:
              Icons
                  .pending_actions_rounded,
        ),
      ],
    );
  }

  // ==========================================================
  // STAT CARD
  // ==========================================================

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
  }) {
    final scheme =
        Theme.of(context)
            .colorScheme;

    return Card(
      child:
          Padding(
        padding:
            const EdgeInsets.all(
          15,
        ),
        child:
            Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color:
                  scheme.primary,
              size:
                  25,
            ),

            const SizedBox(
              height: 7,
            ),

            Text(
              value,
              style:
                  const TextStyle(
                fontSize: 25,
                fontWeight:
                    FontWeight.w900,
              ),
            ),

            const SizedBox(
              height: 2,
            ),

            Text(
              title,
              maxLines:
                  1,
              overflow:
                  TextOverflow.ellipsis,
              style:
                  Theme.of(
                context,
              )
                      .textTheme
                      .bodySmall
                      ?.copyWith(
                        fontWeight:
                            FontWeight.w600,
                      ),
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // QUICK ACTIONS
  // ==========================================================

  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        const Text(
          'Quick Actions',
          style:
              TextStyle(
            fontSize: 19,
            fontWeight:
                FontWeight.w800,
          ),
        ),

        const SizedBox(
          height: 12,
        ),

        Row(
          children: [
            Expanded(
              child:
                  _buildActionCard(
                title:
                    'Safety Observation',
                subtitle:
                    'Record a safe or unsafe condition',
                icon:
                    Icons
                        .visibility_rounded,
                onTap:
                    () {
                  setState(() {
                    _currentIndex =
                        1;
                  });
                },
              ),
            ),

            const SizedBox(
              width: 12,
            ),

            Expanded(
              child:
                  _buildActionCard(
                title:
                    'Hazard Report',
                subtitle:
                    'Report a workplace hazard',
                icon:
                    Icons
                        .warning_rounded,
                onTap:
                    () {
                  setState(() {
                    _currentIndex =
                        2;
                  });
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ==========================================================
  // ACTION CARD
  // ==========================================================

  Widget _buildActionCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Card(
      child:
          InkWell(
        borderRadius:
            BorderRadius.circular(
          16,
        ),
        onTap:
            onTap,
        child:
            Padding(
          padding:
              const EdgeInsets.all(
            16,
          ),
          child:
              Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Container(
                width:
                    44,
                height:
                    44,
                decoration:
                    BoxDecoration(
                  color:
                      Theme.of(
                    context,
                  )
                          .colorScheme
                          .primaryContainer,
                  borderRadius:
                      BorderRadius.circular(
                    13,
                  ),
                ),
                child:
                    Icon(
                  icon,
                  color:
                      Theme.of(
                    context,
                  )
                          .colorScheme
                          .onPrimaryContainer,
                ),
              ),

              const SizedBox(
                height: 12,
              ),

              Text(
                title,
                style:
                    const TextStyle(
                  fontWeight:
                      FontWeight.w800,
                ),
              ),

              const SizedBox(
                height: 5,
              ),

              Text(
                subtitle,
                maxLines:
                    3,
                overflow:
                    TextOverflow.ellipsis,
                style:
                    Theme.of(
                  context,
                )
                        .textTheme
                        .bodySmall,
              ),

              const SizedBox(
                height: 10,
              ),

              const Align(
                alignment:
                    Alignment.centerRight,
                child:
                    Icon(
                  Icons
                      .arrow_forward_rounded,
                  size:
                      20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // SAFETY REFERENCE
  // ==========================================================

  Widget
      _buildSafetyReferenceCard() {
    return Card(
      child:
          InkWell(
        borderRadius:
            BorderRadius.circular(
          16,
        ),
        onTap:
            () {
          _showReferenceDialog();
        },
        child:
            Padding(
          padding:
              const EdgeInsets.all(
            18,
          ),
          child:
              Row(
            children: [
              Container(
                width:
                    48,
                height:
                    48,
                decoration:
                    BoxDecoration(
                  color:
                      const Color(
                    0xFF159447,
                  ).withValues(
                    alpha:
                        0.10,
                  ),
                  borderRadius:
                      BorderRadius.circular(
                    14,
                  ),
                ),
                child:
                    const Icon(
                  Icons
                      .menu_book_rounded,
                  color:
                      Color(
                    0xFF159447,
                  ),
                ),
              ),

              const SizedBox(
                width: 13,
              ),

              const Expanded(
                child:
                    Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      'HSE Safety Reference',
                      style:
                          TextStyle(
                        fontWeight:
                            FontWeight.w800,
                      ),
                    ),
                    SizedBox(
                      height:
                          4,
                    ),
                    Text(
                      'Access UAE-focused safety guidance and reference topics.',
                    ),
                  ],
                ),
              ),

              const Icon(
                Icons
                    .chevron_right_rounded,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // UAE IDENTITY
  // ==========================================================

  Widget _buildUaeIdentityCard() {
    return Card(
      child:
          Padding(
        padding:
            const EdgeInsets.all(
          18,
        ),
        child:
            Row(
          children: [
            const Text(
              '🇦🇪',
              style:
                  TextStyle(
                fontSize:
                    32,
              ),
            ),

            const SizedBox(
              width: 12,
            ),

            Expanded(
              child:
                  Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Built for UAE HSE',
                    style:
                        TextStyle(
                      fontWeight:
                          FontWeight.w800,
                    ),
                  ),
                  const SizedBox(
                    height:
                        4,
                  ),
                  Text(
                    'Designed to scale across UAE emirates while supporting emirate-specific HSE guidance.',
                    style:
                        Theme.of(
                      context,
                    )
                            .textTheme
                            .bodySmall,
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
  // REFERENCE DIALOG
  // ==========================================================

  void _showReferenceDialog() {
    showDialog<void>(
      context: context,
      builder:
          (dialogContext) {
        return AlertDialog(
          title:
              const Text(
            'HSE Safety Reference',
          ),
          content:
              const Text(
            'SafeNexus HSE is structured as a UAE-wide HSE safety application.\n\n'
            'The reference section can contain UAE General, Abu Dhabi and Dubai guidance, with future emirate-specific modules added independently.',
          ),
          actions: [
            FilledButton(
              onPressed:
                  () {
                Navigator.pop(
                  dialogContext,
                );
              },
              child:
                  const Text(
                'Close',
              ),
            ),
          ],
        );
      },
    );
  }
}
