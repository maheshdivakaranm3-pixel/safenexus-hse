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

  void _startNewWork() {
    _showActivityPicker();
  }

  void _showActivityPicker() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return _ActivityPickerSheet(
          activities: hseWorkActivities,
          onActivitySelected: (HseWorkActivity activity) {
            Navigator.of(sheetContext).pop();
            _openActivityChecklist(activity);
          },
        );
      },
    );
  }

  void _openActivityChecklist(HseWorkActivity activity) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => _WorkActivityChecklistPage(
          activity: activity,
        ),
      ),
    );
  }

  void _openPhase(_WorkHubPhase phase) {
    if (phase.number == 3 || phase.number == 8) {
      _showActivityPicker();
      return;
    }

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
    final int activityCount = hseWorkActivities.length;

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
                final _WorkHubPhase phase = _phases[index];

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

class _ActivityPickerSheet extends StatefulWidget {
  final List<HseWorkActivity> activities;
  final ValueChanged<HseWorkActivity> onActivitySelected;

  const _ActivityPickerSheet({
    required this.activities,
    required this.onActivitySelected,
  });

  @override
  State<_ActivityPickerSheet> createState() => _ActivityPickerSheetState();
}

class _ActivityPickerSheetState extends State<_ActivityPickerSheet> {
  final TextEditingController _searchController = TextEditingController();

  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<HseWorkActivity> get _filteredActivities {
    final String query = _query.trim().toLowerCase();

    if (query.isEmpty) {
      return widget.activities;
    }

    return widget.activities.where((HseWorkActivity activity) {
      final String haystack = [
        activity.id,
        activity.title,
        activity.category,
        activity.description,
      ].join(' ').toLowerCase();

      return haystack.contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final List<HseWorkActivity> activities = _filteredActivities;

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
                      color: _WorkHubPageState.primaryGreen
                          .withValues(alpha: 0.10),
                      borderRadius: BorderRadius.circular(13),
                    ),
                    child: const Icon(
                      Icons.add_task_rounded,
                      color: _WorkHubPageState.primaryGreen,
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
                            color: _WorkHubPageState.darkGreen,
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
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _searchController,
                onChanged: (String value) {
                  setState(() {
                    _query = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search work activity...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _query.isNotEmpty
                      ? IconButton(
                          onPressed: () {
                            _searchController.clear();
                            setState(() {
                              _query = '';
                            });
                          },
                          icon: const Icon(Icons.clear),
                        )
                      : null,
                  filled: true,
                  fillColor: _WorkHubPageState.pageBackground,
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
                        style: TextStyle(
                          color: Colors.black54,
                        ),
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
                        final HseWorkActivity activity = activities[index];

                        return _ActivityTile(
                          activity: activity,
                          onTap: () {
                            widget.onActivitySelected(activity);
                          },
                        );
                      },
                    ),
            ),
          ],
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
    final int documentCount = activity.requiredDocuments.length;

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

  late final Map<String, HseDocumentStatus> _statuses;

  @override
  void initState() {
    super.initState();

    _statuses = {
      for (final HseDocumentRequirement document
          in widget.activity.requiredDocuments)
        document.id: HseDocumentStatus.pending,
    };
  }

  int get _completedCount {
    return _statuses.values
        .where(
          (status) =>
              status == HseDocumentStatus.completed ||
              status == HseDocumentStatus.notApplicable,
        )
        .length;
  }

  int get _totalCount => _statuses.length;

  double get _progress {
    if (_totalCount == 0) {
      return 0;
    }

    return _completedCount / _totalCount;
  }

  bool get _mandatoryReady {
    final List<HseDocumentRequirement> mandatoryDocuments = widget
        .activity
        .requiredDocuments
        .where(
          (HseDocumentRequirement document) => document.mandatory,
        )
        .toList();

    return mandatoryDocuments.every(
      (HseDocumentRequirement document) =>
          _statuses[document.id] == HseDocumentStatus.completed,
    );
  }

  void _setStatus(
    HseDocumentRequirement document,
    HseDocumentStatus status,
  ) {
    setState(() {
      _statuses[document.id] = status;
    });
  }

  void _showReadinessMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _mandatoryReady
              ? 'All mandatory controls are marked completed.'
              : 'Some mandatory controls are still pending.',
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final HseWorkActivity activity = widget.activity;

    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: darkGreen,
        title: const Text(
          'Work Checklist',
          style: TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: Column(
        children: [
          _ChecklistHeader(
            activity: activity,
            completed: _completedCount,
            total: _totalCount,
            progress: _progress,
          ),
          Expanded(
            child: activity.requiredDocuments.isEmpty
                ? const Center(
                    child: Text(
                      'No document requirements are configured for this activity yet.',
                      textAlign: TextAlign.center,
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(
                      14,
                      10,
                      14,
                      24,
                    ),
                    itemCount: activity.requiredDocuments.length,
                    separatorBuilder: (_, __) =>
                        const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final HseDocumentRequirement document =
                          activity.requiredDocuments[index];

                      return _ChecklistItem(
                        document: document,
                        status: _statuses[document.id] ??
                            HseDocumentStatus.pending,
                        onStatusChanged: (HseDocumentStatus status) {
                          _setStatus(document, status);
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
      bottomNavigationBar: _totalCount == 0
          ? null
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  14,
                  8,
                  14,
                  12,
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _showReadinessMessage,
                    icon: Icon(
                      _mandatoryReady
                          ? Icons.check_circle_outline
                          : Icons.pending_actions_outlined,
                    ),
                    label: Text(
                      _mandatoryReady
                          ? 'MANDATORY CONTROLS READY'
                          : 'CHECK MANDATORY CONTROLS',
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _mandatoryReady
                          ? primaryGreen
                          : darkGreen,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
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
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(
        16,
        16,
        16,
        14,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            activity.title,
            style: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w800,
              color: darkGreen,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            activity.category,
            style: const TextStyle(
              fontSize: 12,
              color: primaryGreen,
              fontWeight: FontWeight.w700,
            ),
          ),
          if (activity.description.trim().isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              activity.description,
              style: const TextStyle(
                fontSize: 12,
                height: 1.35,
                color: Colors.black54,
              ),
            ),
          ],
          const SizedBox(height: 13),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
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
                '$completed / $total completed',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: darkGreen,
                ),
              ),
              const Spacer(),
              Text(
                '${(progress * 100).round()}%',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: primaryGreen,
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
  final HseDocumentStatus status;
  final ValueChanged<HseDocumentStatus> onStatusChanged;

  const _ChecklistItem({
    required this.document,
    required this.status,
    required this.onStatusChanged,
  });

  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);

  Color get _statusColor {
    switch (status) {
      case HseDocumentStatus.pending:
        return Colors.orange.shade800;

      case HseDocumentStatus.completed:
        return primaryGreen;

      case HseDocumentStatus.expired:
        return Colors.red;

      case HseDocumentStatus.notApplicable:
        return Colors.blueGrey;
    }
  }

  String get _statusText {
    switch (status) {
      case HseDocumentStatus.pending:
        return 'Pending';

      case HseDocumentStatus.completed:
        return 'Completed';

      case HseDocumentStatus.expired:
        return 'Expired';

      case HseDocumentStatus.notApplicable:
        return 'N/A';
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isCompleted =
        status == HseDocumentStatus.completed;

    final bool isNa =
        status == HseDocumentStatus.notApplicable;

    final bool isExpired =
        status == HseDocumentStatus.expired;

    return Card(
      margin: EdgeInsets.zero,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(
          color: isCompleted
              ? primaryGreen.withValues(alpha: 0.35)
              : isExpired
                  ? Colors.red.withValues(alpha: 0.25)
                  : Colors.black.withValues(alpha: 0.05),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(13),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  isCompleted
                      ? Icons.check_circle
                      : isExpired
                          ? Icons.error_outline
                          : isNa
                              ? Icons.remove_circle_outline
                              : Icons.radio_button_unchecked,
                  color: _statusColor,
                  size: 25,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              document.title,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                                color: darkGreen,
                              ),
                            ),
                          ),
                          if (document.mandatory)
                            Container(
                              margin: const EdgeInsets.only(
                                left: 6,
                              ),
                              padding:
                                  const EdgeInsets.symmetric(
                                horizontal: 7,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.red.shade50,
                                borderRadius:
                                    BorderRadius.circular(8),
                              ),
                              child: Text(
                                'MANDATORY',
                                style: TextStyle(
                                  fontSize: 8,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.red.shade700,
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        document.category,
                        style: const TextStyle(
                          fontSize: 11,
                          color: primaryGreen,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      if (document.description
                          .trim()
                          .isNotEmpty) ...[
                        const SizedBox(height: 5),
                        Text(
                          document.description,
                          style: const TextStyle(
                            fontSize: 11,
                            height: 1.35,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                _RequirementChip(
                  label: document.mandatory
                      ? 'Mandatory'
                      : 'As Required',
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
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: isCompleted
                        ? null
                        : () {
                            onStatusChanged(
                              HseDocumentStatus.completed,
                            );
                          },
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
                      padding:
                          const EdgeInsets.symmetric(vertical: 9),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(11),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: isNa
                        ? null
                        : () {
                            onStatusChanged(
                              HseDocumentStatus.notApplicable,
                            );
                          },
                    icon: Icon(
                      isNa
                          ? Icons.remove_circle
                          : Icons.remove_circle_outline,
                      size: 17,
                    ),
                    label: const Text('N/A'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.black54,
                      side: BorderSide(
                        color: Colors.black.withValues(alpha: 0.12),
                      ),
                      padding:
                          const EdgeInsets.symmetric(vertical: 9),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(11),
                      ),
                    ),
                  ),
                ),
                if (status != HseDocumentStatus.pending) ...[
                  const SizedBox(width: 6),
                  IconButton(
                    tooltip: 'Reset',
                    onPressed: () {
                      onStatusChanged(
                        HseDocumentStatus.pending,
                      );
                    },
                    icon: const Icon(Icons.refresh),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 5),
            Text(
              'Status: $_statusText',
              style: TextStyle(
                color: _statusColor,
                fontSize: 11,
                fontWeight: FontWeight.w700,
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
