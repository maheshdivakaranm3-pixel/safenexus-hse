import 'package:flutter/material.dart';

import '../../dubai_hse_detail_page.dart';
import '../../models/reference_topic.dart';

/// SafeNexus HSE — Dubai Topic 04
/// Construction HSE Plan
///
/// IMPORTANT:
/// This page intentionally preserves the existing SafeNexus HSE detailed
/// content in DubaiHseDetailPage. It adds the new Advanced Learning layer
/// ABOVE the original content instead of replacing or deleting it.
///
/// Canonical file:
/// lib/pages/dubai/dubai_hse_construction_hse_plan_page.dart
class DubaiHseConstructionHsePlanPage extends StatelessWidget {
  const DubaiHseConstructionHsePlanPage({
    super.key,
    required this.topic,
  });

  final ReferenceTopic topic;

  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color navy = Color(0xFF17324D);
  static const Color background = Color(0xFFF5F8F7);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: const Text(
          '04 • Construction HSE Plan',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
          children: [
            _topicIntro(),
            const SizedBox(height: 12),
            _advancedLearningCard(context),
            const SizedBox(height: 12),
            _noticeCard(),
            const SizedBox(height: 18),
            _sectionTitle(
              'Original Detailed Topic',
              'All existing Construction HSE Plan content is preserved below.',
            ),
            const SizedBox(height: 10),
            // DO NOT replace this with a new short summary.
            // This is the original detailed SafeNexus content.
            SizedBox(
              height: 620,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: const _OriginalDetailHost(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _topicIntro() {
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: primaryGreen.withValues(alpha: .18)),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: Color(0xFFE8F5ED),
                child: Icon(
                  Icons.assignment_rounded,
                  color: darkGreen,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Construction HSE Plan',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w800,
                    color: navy,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            'A project-specific HSE plan translates safety requirements, project risks, responsibilities, procedures, emergency arrangements and monitoring activities into an organised system for safe construction delivery.',
            style: TextStyle(
              fontSize: 14.5,
              height: 1.55,
              color: Color(0xFF425466),
            ),
          ),
        ],
      ),
    );
  }

  Widget _advancedLearningCard(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (_) => const DubaiHseConstructionHsePlanAdvancedLearningPage(),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: primaryGreen.withValues(alpha: .30)),
          ),
          child: const Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: Color(0xFFE8F5ED),
                child: Icon(
                  Icons.menu_book_rounded,
                  color: darkGreen,
                  size: 26,
                ),
              ),
              SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '📚 ADVANCED LEARNING',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: darkGreen,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Detailed HSE Plan study, field application, verification and professional reference',
                      style: TextStyle(
                        fontSize: 13,
                        height: 1.4,
                        color: Color(0xFF52606D),
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right_rounded, color: darkGreen, size: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _noticeCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFBF0),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xFFE6C76A).withValues(alpha: .55)),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline_rounded, color: Color(0xFF8A6A00)),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'Learning reference: project HSE plans must be developed, approved, communicated, implemented and reviewed against the actual project scope, hazards, applicable requirements and approved control arrangements.',
              style: TextStyle(
                fontSize: 13,
                height: 1.5,
                color: Color(0xFF5F5200),
              ),
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
            fontSize: 19,
            fontWeight: FontWeight.w800,
            color: navy,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          subtitle,
          style: const TextStyle(
            fontSize: 12.5,
            color: Color(0xFF667085),
          ),
        ),
      ],
    );
  }
}

/// Hosts the existing detailed topic page without changing its content.
/// A constrained viewport is used so the original page can scroll internally.
class _OriginalDetailHost extends StatelessWidget {
  const _OriginalDetailHost();

  @override
  Widget build(BuildContext context) {
    // This page is the original source of the detailed Construction HSE Plan
    // content. It receives the same topic object that the router receives.
    final topic = ModalRoute.of(context)?.settings.arguments;
    if (topic is ReferenceTopic) {
      return DubaiHseDetailPage(topic: topic);
    }

    // Safe fallback for direct construction in the app.
    return const _DetailFallbackMessage();
  }
}

class _DetailFallbackMessage extends StatelessWidget {
  const _DetailFallbackMessage();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(20),
      child: const Center(
        child: Text(
          'Original detailed topic content is loaded by the app router.',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class DubaiHseConstructionHsePlanAdvancedLearningPage extends StatelessWidget {
  const DubaiHseConstructionHsePlanAdvancedLearningPage({super.key});

  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color navy = Color(0xFF17324D);
  static const Color background = Color(0xFFF5F8F7);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: const Text(
          '📚 Advanced Learning',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
        children: [
          _advancedHeader(),
          const SizedBox(height: 14),
          for (final module in _advancedModules) ...[
            _module(module),
            const SizedBox(height: 10),
          ],
          _professionalChecklist(),
          const SizedBox(height: 12),
          _questions(),
        ],
      ),
    );
  }

  Widget _advancedHeader() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFF159447).withValues(alpha: .22)),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Construction HSE Plan — Advanced Study',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: navy),
          ),
          SizedBox(height: 8),
          Text(
            'Use this section for deeper study and field reference. The existing detailed topic content remains separate and is not replaced by this advanced layer.',
            style: TextStyle(fontSize: 13.5, height: 1.5, color: Color(0xFF52606D)),
          ),
        ],
      ),
    );
  }

  Widget _module(_AdvancedModule item) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.black.withValues(alpha: .07)),
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        leading: CircleAvatar(
          radius: 20,
          backgroundColor: const Color(0xFFE8F5ED),
          child: Text(
            item.number,
            style: const TextStyle(fontWeight: FontWeight.w800, color: darkGreen),
          ),
        ),
        title: Text(
          item.title,
          style: const TextStyle(fontWeight: FontWeight.w800, color: navy),
        ),
        subtitle: Text(item.subtitle),
        children: [
          ...item.points.map(
            (point) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 6),
                    child: Icon(Icons.check_circle_rounded, size: 15, color: darkGreen),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      point,
                      style: const TextStyle(fontSize: 13.5, height: 1.5, color: Color(0xFF425466)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _professionalChecklist() {
    const items = [
      'Approved project HSE plan is available and controlled.',
      'Project scope, organisation and HSE responsibilities are defined.',
      'Risk register and activity controls are consistent with actual work.',
      'RAMS and permit requirements are linked to planned activities.',
      'Training, competency and toolbox-talk arrangements are established.',
      'Emergency arrangements, contacts and drills are addressed.',
      'Inspection, audit, monitoring and corrective-action processes are defined.',
      'Document revisions are communicated before affected work changes.',
      'Contractor and subcontractor interfaces are controlled.',
      'Plan effectiveness is reviewed when scope, conditions or risks change.',
    ];
    return _whiteCard(
      'Field Verification Checklist',
      items,
    );
  }

  Widget _questions() {
    const questions = [
      'What is the difference between an HSE plan, a risk assessment and a method statement?',
      'How would you verify that the HSE plan reflects actual site activities?',
      'What evidence would you request during an HSE plan audit?',
      'When should a project HSE plan be reviewed or revised?',
      'How should contractor interfaces be reflected in the project HSE plan?',
      'How do RAMS and PTW arrangements connect with the HSE plan?',
      'What would you do if site conditions no longer match the approved plan?',
      'How can HSE performance indicators be linked to the plan?',
      'What records demonstrate implementation rather than document-only compliance?',
      'What conditions would require escalation or stopping affected work?',
    ];
    return _whiteCard('Professional / Interview Questions', questions, numbered: true);
  }

  Widget _whiteCard(String title, List<String> items, {bool numbered = false}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black.withValues(alpha: .07)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: navy)),
          const SizedBox(height: 10),
          ...items.asMap().entries.map(
            (entry) => Padding(
              padding: const EdgeInsets.only(bottom: 9),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    numbered ? '${entry.key + 1}.' : '✓',
                    style: const TextStyle(fontWeight: FontWeight.w800, color: darkGreen),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      entry.value,
                      style: const TextStyle(fontSize: 13.5, height: 1.45, color: Color(0xFF425466)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AdvancedModule {
  const _AdvancedModule({
    required this.number,
    required this.title,
    required this.subtitle,
    required this.points,
  });

  final String number;
  final String title;
  final String subtitle;
  final List<String> points;
}

const _advancedModules = <_AdvancedModule>[
  _AdvancedModule(
    number: '01',
    title: 'HSE Plan Fundamentals',
    subtitle: 'Purpose, scope and the difference between planning and field implementation.',
    points: [
      'The HSE plan should translate project requirements and identified risks into an organised system of controls, responsibilities and monitoring activities.',
      'The plan should cover the project lifecycle and relevant interfaces rather than becoming a static document prepared only for approval.',
      'The plan should remain consistent with the project scope, work sequence, risk assessments, RAMS, permits and emergency arrangements.',
    ],
  ),
  _AdvancedModule(
    number: '02',
    title: 'Project Scope & HSE Objectives',
    subtitle: 'Define what the plan controls and what the project is trying to achieve.',
    points: [
      'Identify project phases, work packages, interfaces, locations, workforce and significant activities within the plan scope.',
      'Set clear HSE objectives and measurable targets appropriate to the project risk profile.',
      'Ensure objectives are communicated to management, supervisors, contractors and workers who influence performance.',
    ],
  ),
  _AdvancedModule(
    number: '03',
    title: 'Organisation & Accountability',
    subtitle: 'Turn the organisation chart into practical responsibility and authority.',
    points: [
      'Define management, HSE, supervision, engineering, logistics, specialist and worker responsibilities relevant to the project.',
      'Clarify who approves, who implements, who verifies and who escalates critical HSE matters.',
      'Ensure competent personnel and sufficient resources are available for the responsibilities assigned to them.',
    ],
  ),
  _AdvancedModule(
    number: '04',
    title: 'Risk Register & Control Integration',
    subtitle: 'Connect the HSE plan with risk-based operational controls.',
    points: [
      'The project risk register should reflect significant hazards and interfaces identified during planning and delivery.',
      'Controls should be traceable into RAMS, permits, inspections, supervision and worker briefings where applicable.',
      'Changes in scope, sequence, environment or interfaces should trigger review of affected risks and controls.',
    ],
  ),
  _AdvancedModule(
    number: '05',
    title: 'RAMS & Permit-to-Work Interface',
    subtitle: 'Control high-risk work through linked planning systems.',
    points: [
      'RAMS should describe how specific activities will be performed safely and should align with the project HSE plan.',
      'Permit-to-work arrangements should be integrated for activities requiring formal authorisation or isolation controls.',
      'Supervisors should verify that the approved documents actually match the workface before exposure begins.',
    ],
  ),
  _AdvancedModule(
    number: '06',
    title: 'Training, Competency & Communication',
    subtitle: 'Make the plan understandable and usable by the workforce.',
    points: [
      'Identify induction, task-specific training, competency and refresher requirements for relevant roles.',
      'Use toolbox talks and pre-task briefings to communicate changing hazards and critical controls.',
      'Maintain evidence of attendance, competency and communication for activities where records are required.',
    ],
  ),
  _AdvancedModule(
    number: '07',
    title: 'Emergency Preparedness',
    subtitle: 'Plan for credible emergencies before work starts.',
    points: [
      'Identify credible emergency scenarios and define alarm, communication, evacuation, first-aid, rescue and external-assistance arrangements as applicable.',
      'Ensure emergency routes, assembly arrangements, contacts and response resources are communicated and maintained.',
      'Use exercises, drills, inspections and incident learning to improve emergency readiness.',
    ],
  ),
  _AdvancedModule(
    number: '08',
    title: 'Inspection, Audit & Monitoring',
    subtitle: 'Verify that planned controls are operating in the field.',
    points: [
      'Define inspection and monitoring programmes appropriate to project activities and critical controls.',
      'Audits should test system effectiveness and implementation rather than only checking whether documents exist.',
      'Findings should be assigned, tracked, closed and verified for effectiveness.',
    ],
  ),
  _AdvancedModule(
    number: '09',
    title: 'Contractor & Interface Management',
    subtitle: 'Control shared risks across organisations and work packages.',
    points: [
      'Define contractor HSE requirements, responsibilities, coordination arrangements and reporting expectations.',
      'Control interfaces between contractors, plant, pedestrians, simultaneous operations and shared work areas.',
      'Escalate unresolved interface risks before they create uncontrolled exposure.',
    ],
  ),
  _AdvancedModule(
    number: '10',
    title: 'Incident, CAPA & Learning',
    subtitle: 'Use events and findings to improve the HSE plan.',
    points: [
      'Include arrangements for reporting incidents, near misses, unsafe conditions and significant findings.',
      'Corrective actions should address causes and control weaknesses, not only the visible symptom.',
      'Relevant learning should be communicated and incorporated into procedures, RAMS, training or the HSE plan where appropriate.',
    ],
  ),
  _AdvancedModule(
    number: '11',
    title: 'Document Control & Review',
    subtitle: 'Keep the approved plan current and traceable.',
    points: [
      'Control revision status, approval, distribution and withdrawal of superseded versions.',
      'Review the plan when project scope, organisation, legislation, significant risks, methods or site conditions change.',
      'Ensure affected personnel know which revision is current before relying on changed requirements.',
    ],
  ),
  _AdvancedModule(
    number: '12',
    title: 'HSE Officer Field Verification',
    subtitle: 'A practical verification sequence for daily professional use.',
    points: [
      'Check the approved plan, current revision and project scope before assessing implementation.',
      'Walk the workface and compare actual conditions with the plan, risk controls, RAMS, permits and required competence.',
      'Record gaps, apply immediate controls where necessary, escalate critical issues and verify corrective action before closure.',
    ],
  ),
  _AdvancedModule(
    number: '13',
    title: 'Supervisor Application',
    subtitle: 'Convert project arrangements into safe workface control.',
    points: [
      'Brief the team before work and confirm people understand the method, hazards, controls and emergency arrangements.',
      'Monitor changing conditions, housekeeping, access, plant interfaces and critical controls during the activity.',
      'Pause and seek reassessment when the work no longer matches the approved safe system.',
    ],
  ),
  _AdvancedModule(
    number: '14',
    title: 'Stop-Work & Escalation',
    subtitle: 'Respond when planned controls are absent or ineffective.',
    points: [
      'Affected work should be stopped or controlled when critical safeguards are missing, bypassed or ineffective.',
      'Make the area safe where practicable, inform the responsible supervision and reassess the task before restart.',
      'Restart should occur only after the required controls are restored and the appropriate authority has verified the change.',
    ],
  ),
  _AdvancedModule(
    number: '15',
    title: 'Practical Construction-Site Scenario',
    subtitle: 'Use the plan as a live control system.',
    points: [
      'A work sequence changes because another contractor enters the same area. The interface is paused and the affected risk controls are reassessed.',
      'The supervisor verifies revised access, segregation, permits and briefing requirements before the work resumes.',
      'The HSE team records the learning and updates affected documents or controls when required by the project system.',
    ],
  ),
];
