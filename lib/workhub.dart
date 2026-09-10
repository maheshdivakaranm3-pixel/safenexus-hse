import 'package:flutter/material.dart';

import 'data/hse_work_categories.dart';
import 'models/hse_work_categories.dart';

/// SafeNexus WorkHub
///
/// Step 1:
/// - Dedicated WorkHub landing page
/// - 16 HSE work phases
/// - Start New Work entry point
/// - Activity search and selection
/// - Automatic document checklist based on selected activity
///
/// This page is intentionally self-contained for Step 1.
/// Existing HSE modules are not modified here.
class WorkHubPage extends StatefulWidget {
  const WorkHubPage({super.key});

  @override
  State<WorkHubPage> createState() => _WorkHubPageState();
}

class _WorkHubPageState extends State<WorkHubPage> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);

  final TextEditingController _searchController = TextEditingController();

  String _searchQuery = '';
  HseWorkActivity? _selectedActivity;

  static const List<_WorkHubPhase> _phases = [
    _WorkHubPhase(
      number: 1,
      icon: Icons.folder_copy_outlined,
      title: 'Project Pre-Start',
      subtitle: 'Project information & setup',
    ),
    _WorkHubPhase(
      number: 2,
      icon: Icons.assignment_outlined,
      title: 'HSE Management System',
      subtitle: 'Policy, plan, KPI & procedures',
    ),
    _WorkHubPhase(
      number: 3,
      icon: Icons.warning_amber_outlined,
      title: 'Risk & Planning',
      subtitle: 'HIRA, JSA, JHA, RAMS & risks',
    ),
    _WorkHubPhase(
      number: 4,
      icon: Icons.fact_check_outlined,
      title: 'Permit to Work',
      subtitle: 'PTW & work permits',
    ),
    _WorkHubPhase(
      number: 5,
      icon: Icons.home_work_outlined,
      title: 'Site Mobilization',
      subtitle: 'Site setup, welfare & access',
    ),
    _WorkHubPhase(
      number: 6,
      icon: Icons.groups_outlined,
      title: 'Workforce & Competency',
      subtitle: 'Induction, training & competency',
    ),
    _WorkHubPhase(
      number: 7,
      icon: Icons.construction_outlined,
      title: 'Equipment & Machinery',
      subtitle: 'Equipment, certificates & inspections',
    ),
    _WorkHubPhase(
      number: 8,
      icon: Icons.local_fire_department_outlined,
      title: 'High-Risk Activities',
      subtitle: 'Critical work activity controls',
    ),
    _WorkHubPhase(
      number: 9,
      icon: Icons.record_voice_over_outlined,
      title: 'Daily HSE Work',
      subtitle: 'TBT, inspections & observations',
    ),
    _WorkHubPhase(
      number: 10,
      icon: Icons.emergency_outlined,
      title: 'Emergency',
      subtitle: 'ERP, drills, rescue & evacuation',
    ),
    _WorkHubPhase(
      number: 11,
      icon: Icons.health_and_safety_outlined,
      title: 'Occupational Health',
      subtitle: 'Medical, heat stress & welfare',
    ),
    _WorkHubPhase(
      number: 12,
      icon: Icons.science_outlined,
      title: 'Chemical & Environment',
      subtitle: 'Chemical, waste & environmental records',
    ),
    _WorkHubPhase(
      number: 13,
      icon: Icons.search_outlined,
      title: 'Inspection & Audit',
      subtitle: 'Inspections, audits & actions',
    ),
    _WorkHubPhase(
      number: 14,
      icon: Icons.car_crash_outlined,
      title: 'Incident Management',
      subtitle: 'Incident, investigation & lessons learned',
    ),
    _WorkHubPhase(
      number: 15,
      icon: Icons.bar_chart_outlined,
      title: 'HSE Reporting',
      subtitle: 'Daily, weekly, monthly & KPI',
    ),
    _WorkHubPhase(
      number: 16,
      icon: Icons.account_balance_outlined,
      title: 'Legal / Authority',
      subtitle: 'UAE & jurisdiction-specific requirements',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      final value = _searchController.text.trim().toLowerCase();
      if (value == _searchQuery) return;
      setState(() => _searchQuery = value);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<HseWorkActivity> get _filteredActivities {
    if (_searchQuery.isEmpty) {
      return hseWorkActivities;
    }

    return hseWorkActivities.where((activity) {
      final haystack = [
        activity.title,
        activity.category,
        activity.description,
      ].join(' ').toLowerCase();

      return haystack.contains(_searchQuery);
    }).toList();
  }

  void _startNewWork() {
    setState(() {
      _selectedActivity = null;
      _searchController.clear();
    });

    _showActivityPicker();
  }

  void _showActivityPicker() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            final activities = _searchQuery.isEmpty
                ? hseWorkActivities
                : _filteredActivities;

            return SafeArea(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.86,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(24),
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Container(
                      width: 42,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 18, 20, 10),
                      child: Row(
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: primaryGreen.withValues(alpha: 0.10),
                              borderRadius: BorderRadius.circular(13),
                            ),
                            child: const Icon(
                              Icons.add_task_rounded,
                              color: primaryGreen,
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Start New Work',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800,
                                    color: darkGreen,
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  'Select the work activity',
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(Icons.close),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        controller: _searchController,
                        onChanged: (_) => setSheetState(() {}),
                        decoration: InputDecoration(
                          hintText: 'Search work activity...',
                          prefixIcon: const Icon(Icons.search),
                          suffixIcon: _searchQuery.isNotEmpty
                              ? IconButton(
                                  onPressed: () {
                                    _searchController.clear();
                                    setSheetState(() {});
                                  },
                                  icon: const Icon(Icons.clear),
                                )
                              : null,
                          filled: true,
                          fillColor: pageBackground,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Expanded(
                      child: activities.isEmpty
                          ? const Center(
                              child: Text(
                                'No matching work activity found.',
                                style: TextStyle(color: Colors.black54),
                              ),
                            )
                          : ListView.builder(
                              padding: const EdgeInsets.fromLTRB(
                                20,
                                0,
                                20,
                                20,
                              ),
                              itemCount: activities.length,
                              itemBuilder: (context, index) {
                                final activity = activities[index];

                                return _ActivityTile(
                                  activity: activity,
                                  onTap: () {
                                    Navigator.pop(context);
                                    _openActivityChecklist(activity);
                                  },
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _openActivityChecklist(HseWorkActivity activity) {
    setState(() => _selectedActivity = activity);

    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => _WorkActivityChecklistPage(
          activity: activity,
        ),
      ),
    );
  }

  void _openPhase(_WorkHubPhase phase) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${phase.title} is part of the SafeNexus WorkHub workflow. '
          'Its dedicated records will be connected in the next steps.',
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final activityCount = hseWorkActivities.length;

    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: darkGreen,
        titleSpacing: 16,
        title: const Text(
          'SafeNexus WorkHub',
          style: TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: _HeroCard(
                onStartNewWork: _startNewWork,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 10),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'HSE Work Lifecycle',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: darkGreen,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: primaryGreen.withValues(alpha: 0.10),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '$activityCount activities',
                      style: const TextStyle(
                        color: primaryGreen,
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
            sliver: SliverList.builder(
              itemCount: _phases.length,
              itemBuilder: (context, index) {
                final phase = _phases[index];

                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: _PhaseCard(
                    phase: phase,
                    onTap: () => _openPhase(phase),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroCard extends StatelessWidget {
  final VoidCallback onStartNewWork;

  const _HeroCard({
    required this.onStartNewWork,
  });

  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF0B5D4B),
            Color(0xFF159447),
          ],
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: darkGreen.withValues(alpha: 0.18),
            blurRadius: 16,
            offset: const Offset(0, 7),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.shield_outlined,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              const SizedBox(width: 14),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'SafeNexus WorkHub',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      'HSE Work Planning & Control',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          const Text(
            'Plan • Prepare • Control • Monitor • Close',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: onStartNewWork,
              icon: const Icon(Icons.add_task_rounded),
              label: const Text(
                'START NEW WORK',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.3,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: primaryGreen,
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PhaseCard extends StatelessWidget {
  final _WorkHubPhase phase;
  final VoidCallback onTap;

  const _PhaseCard({
    required this.phase,
    required this.onTap,
  });

  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(17),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(17),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: primaryGreen.withValues(alpha: 0.09),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  phase.icon,
                  color: darkGreen,
                  size: 25,
                ),
              ),
              const SizedBox(width: 13),
              Container(
                width: 28,
                height: 28,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: darkGreen,
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Text(
                  '${phase.number}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(width: 11),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      phase.title,
                      style: const TextStyle(
                        color: darkGreen,
                        fontWeight: FontWeight.w800,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      phase.subtitle,
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                color: Colors.black38,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActivityTile extends StatelessWidget {
  final HseWorkActivity activity;
  final VoidCallback onTap;

  const _ActivityTile({
    required this.activity,
    required this.onTap,
  });

  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);

  @override
  Widget build(BuildContext context) {
    final documentCount = activity.requiredDocuments.length;

    return Card(
      margin: const EdgeInsets.only(bottom: 9),
      elevation: 0,
      color: const Color(0xFFF8FAF9),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(
          color: Colors.black.withValues(alpha: 0.05),
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Padding(
          padding: const EdgeInsets.all(13),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: primaryGreen.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.work_outline_rounded,
                  color: darkGreen,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      activity.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        color: darkGreen,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      activity.category,
                      style: const TextStyle(
                        color: primaryGreen,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$documentCount HSE requirements',
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 15,
                color: Colors.black38,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WorkActivityChecklistPage extends StatefulWidget {
  final HseWorkActivity activity;

  const _WorkActivityChecklistPage({
    required this.activity,
  });

  @override
  State<_WorkActivityChecklistPage> createState() =>
      _WorkActivityChecklistPageState();
}

class _WorkActivityChecklistPageState
    extends State<_WorkActivityChecklistPage> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);

  late final Map<String, _ChecklistStatus> _statuses;

  @override
  void initState() {
    super.initState();
    _statuses = {
      for (final document in widget.activity.requiredDocuments)
        document.id: _ChecklistStatus.pending,
    };
  }

  int get _completedCount => _statuses.values
      .where((status) => status == _ChecklistStatus.completed)
      .length;

  int get _totalCount => _statuses.length;

  double get _progress =>
      _totalCount == 0 ? 0 : _completedCount / _totalCount;

  void _setStatus(String id, _ChecklistStatus status) {
    setState(() => _statuses[id] = status);
  }

  @override
  Widget build(BuildContext context) {
    final activity = widget.activity;

    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: darkGreen,
        title: const Text(
          'Work Checklist',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
              child: _ChecklistHeader(
                activity: activity,
                completed: _completedCount,
                total: _totalCount,
                progress: _progress,
              ),
            ),
          ),
          if (activity.requiredDocuments.isEmpty)
            const SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: Text(
                    'No document requirements are configured for this activity yet.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
              ),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
              sliver: SliverList.builder(
                itemCount: activity.requiredDocuments.length,
                itemBuilder: (context, index) {
                  final document = activity.requiredDocuments[index];
                  final status =
                      _statuses[document.id] ?? _ChecklistStatus.pending;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 9),
                    child: _ChecklistItem(
                      document: document,
                      status: status,
                      onStatusChanged: (value) {
                        _setStatus(document.id, value);
                      },
                    ),
                  );
                },
              ),
            ),
        ],
      ),
      bottomNavigationBar: _totalCount == 0
          ? null
          : SafeArea(
              child: Container(
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
                color: Colors.white,
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _completedCount == _totalCount
                        ? () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'All configured checklist items are complete.',
                                ),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          }
                        : null,
                    icon: const Icon(Icons.check_circle_outline),
                    label: Text(
                      _completedCount == _totalCount
                          ? 'READY FOR NEXT STEP'
                          : '$_completedCount / $_totalCount COMPLETED',
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryGreen,
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: Colors.black12,
                      disabledForegroundColor: Colors.black45,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}

class _ChecklistHeader extends StatelessWidget {
  final HseWorkActivity activity;
  final int completed;
  final int total;
  final double progress;

  const _ChecklistHeader({
    required this.activity,
    required this.completed,
    required this.total,
    required this.progress,
  });

  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(19),
        border: Border.all(
          color: primaryGreen.withValues(alpha: 0.10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            activity.title,
            style: const TextStyle(
              color: darkGreen,
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            activity.category,
            style: const TextStyle(
              color: primaryGreen,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
          if (activity.description.trim().isNotEmpty) ...[
            const SizedBox(height: 9),
            Text(
              activity.description,
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 13,
                height: 1.35,
              ),
            ),
          ],
          const SizedBox(height: 15),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 9,
              backgroundColor: Colors.black.withValues(alpha: 0.07),
              valueColor: const AlwaysStoppedAnimation<Color>(
                primaryGreen,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                '$completed of $total completed',
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: darkGreen,
                  fontSize: 12,
                ),
              ),
              const Spacer(),
              Text(
                '${(progress * 100).round()}%',
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  color: primaryGreen,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ChecklistItem extends StatelessWidget {
  final HseDocumentRequirement document;
  final _ChecklistStatus status;
  final ValueChanged<_ChecklistStatus> onStatusChanged;

  const _ChecklistItem({
    required this.document,
    required this.status,
    required this.onStatusChanged,
  });

  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);

  @override
  Widget build(BuildContext context) {
    final isCompleted = status == _ChecklistStatus.completed;
    final isNa = status == _ChecklistStatus.notApplicable;

    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: isCompleted
              ? primaryGreen.withValues(alpha: 0.35)
              : Colors.black.withValues(alpha: 0.05),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: isCompleted
                        ? primaryGreen.withValues(alpha: 0.11)
                        : Colors.black.withValues(alpha: 0.045),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    isCompleted
                        ? Icons.check_circle_outline
                        : Icons.description_outlined,
                    color: isCompleted ? primaryGreen : darkGreen,
                  ),
                ),
                const SizedBox(width: 11),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        document.title,
                        style: const TextStyle(
                          color: darkGreen,
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        document.category,
                        style: const TextStyle(
                          color: primaryGreen,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      if (document.description.trim().isNotEmpty) ...[
                        const SizedBox(height: 5),
                        Text(
                          document.description,
                          style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 11.5,
                            height: 1.3,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 11),
            Wrap(
              spacing: 7,
              runSpacing: 7,
              children: [
                _RequirementChip(
                  label: document.mandatory ? 'Mandatory' : 'As Required',
                  icon: document.mandatory
                      ? Icons.priority_high_rounded
                      : Icons.tune_rounded,
                  active: document.mandatory,
                ),
                if (document.requiresExpiry)
                  const _RequirementChip(
                    label: 'Expiry',
                    icon: Icons.event_outlined,
                    active: false,
                  ),
                if (document.requiresSignature)
                  const _RequirementChip(
                    label: 'Signature',
                    icon: Icons.draw_outlined,
                    active: false,
                  ),
              ],
            ),
            const SizedBox(height: 11),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () =>
                        onStatusChanged(_ChecklistStatus.completed),
                    icon: Icon(
                      isCompleted
                          ? Icons.check_circle
                          : Icons.check_circle_outline,
                      size: 17,
                    ),
                    label: const Text('Complete'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: primaryGreen,
                      side: BorderSide(
                        color: primaryGreen.withValues(alpha: 0.35),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(11),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () =>
                        onStatusChanged(_ChecklistStatus.notApplicable),
                    icon: Icon(
                      isNa ? Icons.remove_circle : Icons.remove_circle_outline,
                      size: 17,
                    ),
                    label: const Text('N/A'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.black54,
                      side: BorderSide(
                        color: Colors.black.withValues(alpha: 0.12),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(11),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                  ),
                ),
              ],
            ),
            if (status == _ChecklistStatus.pending)
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Text(
                    'Status: Pending',
                    style: TextStyle(
                      color: Colors.orange,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            if (isCompleted)
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Text(
                    'Status: Completed',
                    style: TextStyle(
                      color: primaryGreen,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            if (isNa)
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Text(
                    'Status: Not Applicable',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _RequirementChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool active;

  const _RequirementChip({
    required this.label,
    required this.icon,
    required this.active,
  });

  static const Color primaryGreen = Color(0xFF159447);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: active
            ? primaryGreen.withValues(alpha: 0.10)
            : Colors.black.withValues(alpha: 0.045),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 13,
            color: active ? primaryGreen : Colors.black54,
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: active ? primaryGreen : Colors.black54,
              fontSize: 10.5,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _WorkHubPhase {
  final int number;
  final IconData icon;
  final String title;
  final String subtitle;

  const _WorkHubPhase({
    required this.number,
    required this.icon,
    required this.title,
    required this.subtitle,
  });
}

enum _ChecklistStatus {
  pending,
  completed,
  notApplicable,
}
