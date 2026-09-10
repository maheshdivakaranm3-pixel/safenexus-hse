import 'package:flutter/material.dart';

import 'data/hse_work_categories.dart';
import 'models/hse_work_categories.dart';

class WorkHubPage extends StatefulWidget {
  const WorkHubPage({super.key});

  @override
  State<WorkHubPage> createState() => _WorkHubPageState();
}

class _WorkHubPageState extends State<WorkHubPage> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);

  static const List<_WorkPhase> phases = <_WorkPhase>[
    _WorkPhase(
      number: 1,
      title: 'Project Pre-Start',
      subtitle: 'Project information, organization and requirements',
      icon: Icons.business_center_outlined,
    ),
    _WorkPhase(
      number: 2,
      title: 'HSE Management System',
      subtitle: 'HSE plan, policy, objectives, communication and control',
      icon: Icons.policy_outlined,
    ),
    _WorkPhase(
      number: 3,
      title: 'Risk & Planning',
      subtitle: 'HIRA, risk assessment, JSA, JHA, RAMS and method statements',
      icon: Icons.warning_amber_rounded,
    ),
    _WorkPhase(
      number: 4,
      title: 'Permit to Work',
      subtitle: 'PTW, isolation, hot work, confined space and other permits',
      icon: Icons.assignment_turned_in_outlined,
    ),
    _WorkPhase(
      number: 5,
      title: 'Site Mobilization',
      subtitle: 'Site setup, welfare, emergency and traffic arrangements',
      icon: Icons.construction_outlined,
    ),
    _WorkPhase(
      number: 6,
      title: 'Workforce',
      subtitle: 'Manpower, induction, training and competency management',
      icon: Icons.groups_outlined,
    ),
    _WorkPhase(
      number: 7,
      title: 'Equipment & Machinery',
      subtitle: 'Equipment, vehicles, lifting gear, inspections and certificates',
      icon: Icons.precision_manufacturing_outlined,
    ),
    _WorkPhase(
      number: 8,
      title: 'High-Risk Activities',
      subtitle: 'Critical activities and their required control documents',
      icon: Icons.warning_outlined,
    ),
    _WorkPhase(
      number: 9,
      title: 'Daily HSE Work',
      subtitle: 'TBT, inspections, observations, near misses and actions',
      icon: Icons.today_outlined,
    ),
    _WorkPhase(
      number: 10,
      title: 'Emergency',
      subtitle: 'ERP, rescue plans, drills, evacuation and response records',
      icon: Icons.emergency_outlined,
    ),
    _WorkPhase(
      number: 11,
      title: 'Occupational Health',
      subtitle: 'Medical fitness, heat stress, welfare and health risks',
      icon: Icons.health_and_safety_outlined,
    ),
    _WorkPhase(
      number: 12,
      title: 'Chemical & Environment',
      subtitle: 'Chemicals, SDS, waste, spills and environmental monitoring',
      icon: Icons.eco_outlined,
    ),
    _WorkPhase(
      number: 13,
      title: 'Inspection & Audit',
      subtitle: 'Inspections, audits, NCRs, CARs and closure evidence',
      icon: Icons.fact_check_outlined,
    ),
    _WorkPhase(
      number: 14,
      title: 'Incident Management',
      subtitle: 'Incident reporting, investigation, RCA and lessons learned',
      icon: Icons.report_problem_outlined,
    ),
    _WorkPhase(
      number: 15,
      title: 'HSE Reporting',
      subtitle: 'Daily, weekly and monthly reports, KPIs and statistics',
      icon: Icons.analytics_outlined,
    ),
    _WorkPhase(
      number: 16,
      title: 'Legal / Authority',
      subtitle: 'UAE federal, emirate, client and jurisdiction requirements',
      icon: Icons.gavel_outlined,
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
      builder: (BuildContext sheetContext) {
        return _ActivityPickerSheet(
          activities: hseWorkActivities,
          onActivitySelected: (HseWorkActivity activity) {
            Navigator.of(sheetContext).pop();
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => WorkActivityChecklistPage(
                  activity: activity,
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _openPhase(_WorkPhase phase) {
    if (phase.number == 3 || phase.number == 8) {
      _showActivityPicker();
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${phase.title}: dedicated forms and records will be connected in the next WorkHub steps.',
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 16,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'SafeNexus WorkHub',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
            Text(
              'HSE Work Planning & Control',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        actions: <Widget>[
          IconButton(
            tooltip: 'Start New Work',
            onPressed: _startNewWork,
            icon: const Icon(Icons.add_circle_outline),
          ),
        ],
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 18, 16, 8),
                child: _WorkHubHeader(
                  onStartNewWork: _startNewWork,
                  activityCount: hseWorkActivities.length,
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
              sliver: SliverList.separated(
                itemCount: phases.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (BuildContext context, int index) {
                  final _WorkPhase phase = phases[index];
                  return _PhaseCard(
                    phase: phase,
                    onTap: () => _openPhase(phase),
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

class _WorkHubHeader extends StatelessWidget {
  final VoidCallback onStartNewWork;
  final int activityCount;

  const _WorkHubHeader({
    required this.onStartNewWork,
    required this.activityCount,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: _WorkHubState.primaryGreen.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(
                    Icons.dashboard_customize_outlined,
                    color: _WorkHubState.primaryGreen,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Plan 鈥� Control 鈥� Monitor 鈥� Close',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'UAE-wide HSE work management framework',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: <Widget>[
                Expanded(
                  child: _SummaryBox(
                    value: '16',
                    label: 'Work Phases',
                    icon: Icons.view_list_outlined,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _SummaryBox(
                    value: '$activityCount',
                    label: 'Activities',
                    icon: Icons.work_outline,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: onStartNewWork,
                icon: const Icon(Icons.play_arrow_rounded),
                label: const Text('Start New Work'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _WorkHubState.primaryGreen,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
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

class _SummaryBox extends StatelessWidget {
  final String value;
  final String label;
  final IconData icon;

  const _SummaryBox({
    required this.value,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            size: 20,
            color: _WorkHubState.darkGreen,
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                value,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 10,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PhaseCard extends StatelessWidget {
  final _WorkPhase phase;
  final VoidCallback onTap;

  const _PhaseCard({
    required this.phase,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: <Widget>[
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: _WorkHubState.darkGreen.withOpacity(0.10),
                  borderRadius: BorderRadius.circular(13),
                ),
                alignment: Alignment.center,
                child: Icon(
                  phase.icon,
                  color: _WorkHubState.darkGreen,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '${phase.number}. ${phase.title}',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      phase.subtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        height: 1.3,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.chevron_right_rounded,
                color: Colors.black45,
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
      return activity.title.toLowerCase().contains(query) ||
          activity.category.toLowerCase().contains(query) ||
          activity.id.toLowerCase().contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height * 0.88;
    final List<HseWorkActivity> activities = _filteredActivities;

    return SafeArea(
      child: Container(
        height: height,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(24),
          ),
        ),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 10),
            Container(
              width: 42,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 16, 18, 10),
              child: Row(
                children: <Widget>[
                  const Expanded(
                    child: Text(
                      'Select HSE Work Activity',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w800,
                      ),
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
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: TextField(
                controller: _searchController,
                onChanged: (String value) {
                  setState(() {
                    _query = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search activity, category or ID',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: _query.isEmpty
                      ? null
                      : IconButton(
                          onPressed: () {
                            _searchController.clear();
                            setState(() {
                              _query = '';
                            });
                          },
                          icon: const Icon(Icons.clear),
                        ),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(13),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '${activities.length} activities',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 4),
            Expanded(
              child: activities.isEmpty
                  ? const Center(
                      child: Text(
                        'No matching HSE activity found.',
                        style: TextStyle(color: Colors.black54),
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.fromLTRB(18, 8, 18, 24),
                      itemCount: activities.length,
                      separatorBuilder: (_, __) =>
                          const SizedBox(height: 8),
                      itemBuilder: (BuildContext context, int index) {
                        final HseWorkActivity activity = activities[index];

                        return Card(
                          margin: EdgeInsets.zero,
                          elevation: 0,
                          color: Colors.grey.shade50,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13),
                            side: BorderSide(
                              color: Colors.grey.shade200,
                            ),
                          ),
                          child: ListTile(
                            onTap: () => widget.onActivitySelected(activity),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 5,
                            ),
                            leading: CircleAvatar(
                              backgroundColor: _WorkHubState.primaryGreen
                                  .withOpacity(0.12),
                              child: const Icon(
                                Icons.work_outline,
                                color: _WorkHubState.primaryGreen,
                              ),
                            ),
                            title: Text(
                              activity.title,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Text(
                                '${activity.category} 鈥� '
                                '${activity.requiredDocuments.length} controls',
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                            trailing: const Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 16,
                              color: Colors.black45,
                            ),
                          ),
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

class WorkActivityChecklistPage extends StatefulWidget {
  final HseWorkActivity activity;

  const WorkActivityChecklistPage({
    super.key,
    required this.activity,
  });

  @override
  State<WorkActivityChecklistPage> createState() =>
      _WorkActivityChecklistPageState();
}

class _WorkActivityChecklistPageState
    extends State<WorkActivityChecklistPage> {
  final Map<String, HseDocumentStatus> _status =
      <String, HseDocumentStatus>{};

  @override
  void initState() {
    super.initState();

    for (final HseDocumentRequirement document
        in widget.activity.requiredDocuments) {
      _status[document.id] = HseDocumentStatus.pending;
    }
  }

  int get _completedCount {
    return _status.values
        .where((HseDocumentStatus value) =>
            value == HseDocumentStatus.completed ||
            value == HseDocumentStatus.notApplicable)
        .length;
  }

  int get _totalCount => widget.activity.requiredDocuments.length;

  double get _progress {
    if (_totalCount == 0) {
      return 0;
    }
    return _completedCount / _totalCount;
  }

  bool get _mandatoryReady {
    final List<HseDocumentRequirement> mandatory = widget
        .activity
        .requiredDocuments
        .where((HseDocumentRequirement document) => document.mandatory)
        .toList();

    return mandatory.every(
      (HseDocumentRequirement document) =>
          _status[document.id] == HseDocumentStatus.completed,
    );
  }

  void _setStatus(
    HseDocumentRequirement document,
    HseDocumentStatus status,
  ) {
    setState(() {
      _status[document.id] = status;
    });
  }

  void _showReadinessMessage() {
    final String message = _mandatoryReady
        ? 'All mandatory controls are marked completed.'
        : 'Some mandatory controls are still pending.';

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _WorkHubState.pageBackground,
      appBar: AppBar(
        backgroundColor: _WorkHubState.darkGreen,
        foregroundColor: Colors.white,
        title: const Text(
          'Work Control Checklist',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      body: Column(
        children: <Widget>[
          _ActivityHeader(
            activity: widget.activity,
            progress: _progress,
            completedCount: _completedCount,
            totalCount: _totalCount,
            mandatoryReady: _mandatoryReady,
          ),
          Expanded(
            child: widget.activity.requiredDocuments.isEmpty
                ? const Center(
                    child: Text(
                      'No document requirements configured for this activity.',
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(14, 10, 14, 24),
                    itemCount: widget.activity.requiredDocuments.length,
                    separatorBuilder: (_, __) =>
                        const SizedBox(height: 8),
                    itemBuilder: (BuildContext context, int index) {
                      final HseDocumentRequirement document =
                          widget.activity.requiredDocuments[index];

                      return _ChecklistItem(
                        document: document,
                        status: _status[document.id] ??
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
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 8, 14, 12),
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
                    ? 'Mandatory Controls Ready'
                    : 'Check Mandatory Controls',
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: _mandatoryReady
                    ? _WorkHubState.primaryGreen
                    : _WorkHubState.darkGreen,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
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

class _ActivityHeader extends StatelessWidget {
  final HseWorkActivity activity;
  final double progress;
  final int completedCount;
  final int totalCount;
  final bool mandatoryReady;

  const _ActivityHeader({
    required this.activity,
    required this.progress,
    required this.completedCount,
    required this.totalCount,
    required this.mandatoryReady,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            activity.title,
            style: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            activity.category,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black54,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: <Widget>[
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 8,
                    backgroundColor: Colors.grey.shade200,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      _WorkHubState.primaryGreen,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                '$completedCount / $totalCount',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: <Widget>[
              Icon(
                mandatoryReady
                    ? Icons.verified_outlined
                    : Icons.info_outline,
                size: 18,
                color: mandatoryReady
                    ? _WorkHubState.primaryGreen
                    : Colors.orange.shade800,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  mandatoryReady
                      ? 'Mandatory control documents are ready.'
                      : 'Complete all mandatory controls before work release.',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: mandatoryReady
                        ? _WorkHubState.primaryGreen
                        : Colors.orange.shade800,
                  ),
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

  Color get _statusColor {
    switch (status) {
      case HseDocumentStatus.completed:
        return _WorkHubState.primaryGreen;
      case HseDocumentStatus.notApplicable:
        return Colors.blueGrey;
      case HseDocumentStatus.pending:
        return Colors.orange.shade800;
    }
  }

  String get _statusText {
    switch (status) {
      case HseDocumentStatus.completed:
        return 'Completed';
      case HseDocumentStatus.notApplicable:
        return 'N/A';
      case HseDocumentStatus.pending:
        return 'Pending';
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool completed = status == HseDocumentStatus.completed;
    final bool notApplicable = status == HseDocumentStatus.notApplicable;

    return Card(
      margin: EdgeInsets.zero,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Padding(
        padding: const EdgeInsets.all(13),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(
                  completed
                      ? Icons.check_circle
                      : notApplicable
                          ? Icons.remove_circle_outline
                          : Icons.radio_button_unchecked,
                  color: _statusColor,
                  size: 24,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              document.title,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          if (document.mandatory)
                            Container(
                              margin: const EdgeInsets.only(left: 6),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 7,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.red.shade50,
                                borderRadius: BorderRadius.circular(8),
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
                      if (document.description.isNotEmpty) ...<Widget>[
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
                      const SizedBox(height: 7),
                      Wrap(
                        spacing: 6,
                        runSpacing: 5,
                        children: <Widget>[
                          _SmallTag(text: document.category),
                          if (document.requiresExpiry)
                            const _SmallTag(text: 'Expiry Controlled'),
                          if (document.requiresSignature)
                            const _SmallTag(text: 'Signature'),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 11),
            Row(
              children: <Widget>[
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: completed
                        ? null
                        : () => onStatusChanged(
                              HseDocumentStatus.completed,
                            ),
                    icon: const Icon(
                      Icons.check,
                      size: 17,
                    ),
                    label: const Text('Complete'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: _WorkHubState.primaryGreen,
                      padding: const EdgeInsets.symmetric(vertical: 9),
                    ),
                  ),
                ),
                if (!document.mandatory) ...<Widget>[
                  const SizedBox(width: 8),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: notApplicable
                          ? null
                          : () => onStatusChanged(
                                HseDocumentStatus.notApplicable,
                              ),
                      icon: const Icon(
                        Icons.remove,
                        size: 17,
                      ),
                      label: const Text('N/A'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.blueGrey,
                        padding: const EdgeInsets.symmetric(vertical: 9),
                      ),
                    ),
                  ),
                ],
                if (status != HseDocumentStatus.pending) ...<Widget>[
                  const SizedBox(width: 8),
                  IconButton(
                    tooltip: 'Reset',
                    onPressed: () =>
                        onStatusChanged(HseDocumentStatus.pending),
                    icon: const Icon(Icons.refresh),
                  ),
                ],
              ],
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                _statusText,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  color: _statusColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SmallTag extends StatelessWidget {
  final String text;

  const _SmallTag({
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 7,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.w600,
          color: Colors.black54,
        ),
      ),
    );
  }
}

class _WorkPhase {
  final int number;
  final String title;
  final String subtitle;
  final IconData icon;

  const _WorkPhase({
    required this.number,
    required this.title,
    required this.subtitle,
    required this.icon,
  });
}
