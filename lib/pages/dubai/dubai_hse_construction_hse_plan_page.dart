import 'package:flutter/material.dart';

import '../../dubai_hse_detail_page.dart';
import '../../models/reference_topic.dart';

/// SafeNexus HSE — Dubai Topic 04
/// Construction HSE Plan
///
/// IMPORTANT ARCHITECTURE RULE:
/// - Original Topic 04 is preserved: dubai_hse_plan.
/// - The existing DubaiHseDetailPage remains the source for the original
///   detailed topic content and is NOT deleted or replaced.
/// - This page adds the new Advanced Learning layer and detailed expandable
///   study sections around that original content.
/// - No Part 1 / Part 2 dependency.
class DubaiHseConstructionHsePlanPage extends StatelessWidget {
  const DubaiHseConstructionHsePlanPage({
    super.key,
    required this.topic,
  });

  final ReferenceTopic topic;

  static const Color green = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color navy = Color(0xFF17324D);
  static const Color bg = Color(0xFFF5F8F7);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
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
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 36),
          children: [
            _intro(),
            const SizedBox(height: 12),
            _advancedButton(context),
            const SizedBox(height: 12),
            _notice(),
            const SizedBox(height: 18),
            _heading('Complete Topic', 'Detailed Construction HSE Plan study sections'),
            const SizedBox(height: 8),
            for (final section in _sections) ...[
              _sectionCard(section),
              const SizedBox(height: 9),
            ],
            const SizedBox(height: 6),
            _originalContentButton(context),
            const SizedBox(height: 12),
            _referenceCard(),
          ],
        ),
      ),
    );
  }

  Widget _intro() {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Row(
            children: [
              CircleAvatar(
                radius: 23,
                backgroundColor: Color(0xFFE8F5ED),
                child: Icon(Icons.assignment_rounded, color: darkGreen, size: 27),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Construction HSE Plan',
                  style: TextStyle(fontSize: 21, fontWeight: FontWeight.w800, color: navy),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            'A project-specific HSE plan converts Dubai construction safety requirements and project risks into defined responsibilities, procedures, programmes, emergency arrangements and monitoring activities.',
            style: TextStyle(fontSize: 14.5, height: 1.55, color: Color(0xFF425466)),
          ),
        ],
      ),
    );
  }

  Widget _advancedButton(BuildContext context) {
    return _card(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (_) => const DubaiHseConstructionHsePlanAdvancedLearningPage(),
        ),
      ),
      borderColor: green.withValues(alpha: .30),
      child: const Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: Color(0xFFE8F5ED),
            child: Icon(Icons.menu_book_rounded, color: darkGreen, size: 27),
          ),
          SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('📚 ADVANCED LEARNING', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: darkGreen)),
                SizedBox(height: 4),
                Text('Detailed study, field application, verification and professional reference', style: TextStyle(fontSize: 13, height: 1.4, color: Color(0xFF52606D))),
              ],
            ),
          ),
          Icon(Icons.chevron_right_rounded, color: darkGreen, size: 30),
        ],
      ),
    );
  }

  Widget _notice() {
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
              'Field reference: the plan should match the actual project scope, hazards, approved methods, responsibilities, emergency arrangements and applicable requirements. Review it when project conditions or controls change.',
              style: TextStyle(fontSize: 13, height: 1.5, color: Color(0xFF5F5200)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionCard(_PlanSection section) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(color: Colors.black.withValues(alpha: .07)),
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
        childrenPadding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
        leading: CircleAvatar(
          radius: 19,
          backgroundColor: const Color(0xFFE8F5ED),
          child: Text(section.number, style: const TextStyle(fontWeight: FontWeight.w800, color: darkGreen)),
        ),
        title: Text(section.title, style: const TextStyle(fontWeight: FontWeight.w800, color: navy)),
        subtitle: Text(section.summary),
        children: [
          _detailBlock('What to understand', section.detail),
          if (section.field.isNotEmpty) _detailBlock('Field application', section.field),
          if (section.verify.isNotEmpty) _detailBlock('Verification', section.verify),
        ],
      ),
    );
  }

  Widget _detailBlock(String title, String text) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAF9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w800, color: darkGreen)),
          const SizedBox(height: 5),
          Text(text, style: const TextStyle(fontSize: 13.5, height: 1.55, color: Color(0xFF425466))),
        ],
      ),
    );
  }

  Widget _originalContentButton(BuildContext context) {
    return _card(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (_) => DubaiHseDetailPage(topic: topic),
        ),
      ),
      child: const Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: Color(0xFFEAF0F7),
            child: Icon(Icons.library_books_rounded, color: navy),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Original Detailed Topic', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: navy)),
                SizedBox(height: 4),
                Text('Open the existing SafeNexus detailed content without deleting or replacing it.', style: TextStyle(fontSize: 13, height: 1.4, color: Color(0xFF52606D))),
              ],
            ),
          ),
          Icon(Icons.chevron_right_rounded, color: navy, size: 29),
        ],
      ),
    );
  }

  Widget _referenceCard() {
    return _card(
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Reference Discipline', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: navy)),
          SizedBox(height: 7),
          Text('Use approved project documents, current applicable requirements, risk assessments, method statements, permits and competent-person arrangements as the working basis for the plan.', style: TextStyle(fontSize: 13.5, height: 1.55, color: Color(0xFF52606D))),
        ],
      ),
    );
  }

  Widget _heading(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: navy)),
        const SizedBox(height: 3),
        Text(subtitle, style: const TextStyle(fontSize: 12.5, color: Color(0xFF667085))),
      ],
    );
  }

  Widget _card({required Widget child, VoidCallback? onTap, Color? borderColor}) {
    final content = Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(color: borderColor ?? Colors.black.withValues(alpha: .07)),
      ),
      child: child,
    );
    if (onTap == null) return content;
    return Material(color: Colors.transparent, child: InkWell(borderRadius: BorderRadius.circular(17), onTap: onTap, child: content));
  }

  static const List<_PlanSection> _sections = [
    _PlanSection('01', 'HSE Plan Introduction', 'Purpose and role of the project HSE plan.', 'The plan is the organised framework for translating project HSE requirements and risks into responsibilities, procedures, programmes, emergency arrangements and monitoring activities.', 'Confirm that the document is project-specific rather than a generic uncontrolled template.', 'Check title, project scope, approval status and revision information.'),
    _PlanSection('02', 'Purpose & Scope', 'Define where and how the plan applies.', 'The original project content identifies Purpose as defining project HSE arrangements and translating requirements into work-package controls, with Scope covering planning, execution, inspection, supervision and close-out.', 'Map the plan to actual work packages, interfaces and project phases.', 'Verify that planned activities and interfaces are covered.'),
    _PlanSection('03', 'Project HSE Organisation', 'Establish clear management and workface responsibilities.', 'The plan should identify management, HSE personnel, supervisors and other responsible roles so accountability is visible and workable.', 'Use an organisation chart and clear responsibility matrix.', 'Check named roles, authority, competence and communication lines.'),
    _PlanSection('04', 'HSE Objectives & Programmes', 'Turn project commitments into measurable activities.', 'Objectives, programmes and planned activities should support the project risk profile and provide a basis for monitoring implementation.', 'Link objectives to inspections, training, toolbox talks, audits and corrective actions.', 'Check that planned programmes have owners, frequency and records.'),
    _PlanSection('05', 'Risk Register & Hazard Controls', 'Connect the plan to project risks.', 'The original content identifies the Risk Register as a key component and requires controls to reflect actual hazards, conditions and changes.', 'Review high-risk activities and interfaces before mobilisation and as work progresses.', 'Confirm risks, controls, owners and review status are current.'),
    _PlanSection('06', 'RAMS / Method Controls', 'Align methods with the approved safe system.', 'Approved methods and risk controls must align with actual site activities and competent arrangements.', 'Brief affected personnel before exposure and stop when the actual task materially differs from the approved method.', 'Compare field activity with the approved method and risk controls.'),
    _PlanSection('07', 'Permit to Work Interface', 'Integrate permits where controlled work requires them.', 'Where a permit system applies, the HSE plan should identify how permits interface with risk assessment, method statements, authorisation and field verification.', 'Verify permit conditions at the workface before starting controlled activities.', 'Check permit validity, conditions, isolations and close-out where applicable.'),
    _PlanSection('08', 'Training & Competence Plan', 'Ensure people are competent for assigned work.', 'The original plan identifies Training Plan as a key component and requires suitable training, experience and authority for the work.', 'Maintain induction, task-specific training, competency and refresher arrangements appropriate to the risk.', 'Check competency evidence and current training records.'),
    _PlanSection('09', 'Communication & Toolbox Talks', 'Make controls understood at workface level.', 'Communication must brief affected personnel on relevant controls before exposure and provide a mechanism for feedback and reporting.', 'Use toolbox talks for task hazards, changes, lessons learned and critical controls.', 'Sample attendance, briefing content and worker understanding.'),
    _PlanSection('10', 'Inspection & Monitoring Programme', 'Plan systematic field verification.', 'Inspection Programme is identified in the original content as a key component. Ongoing checks should monitor critical conditions during work and after changes.', 'Use risk-based inspections and record findings and actions.', 'Verify inspection frequency, findings, responsible persons and closure.'),
    _PlanSection('11', 'Emergency Preparedness', 'Provide practical emergency arrangements.', 'The original content includes Emergency Plan as a key type/component and requires relevant emergency arrangements for the activity.', 'Ensure alarm, communication, access, assembly, response and recovery arrangements are understood for the site.', 'Check drills, equipment, contacts, access and response readiness.'),
    _PlanSection('12', 'Contractor & Subcontractor Controls', 'Integrate contractor activities into one site HSE system.', 'The plan should make responsibilities and interfaces clear where multiple organisations work together.', 'Coordinate induction, RAMS, permits, supervision, inspections and corrective actions.', 'Verify contractor documents, competency, supervision and interface controls.'),
    _PlanSection('13', 'Occupational Health & Welfare', 'Address worker health and welfare arrangements.', 'The plan should consider occupational health and welfare needs relevant to the project and workforce.', 'Include welfare, occupational health controls and task-specific exposure management where relevant.', 'Check welfare facilities, health arrangements and required records.'),
    _PlanSection('14', 'Environmental Controls', 'Include environmental aspects within project planning.', 'Environmental requirements should be coordinated with the project controls where they affect construction activities and site conditions.', 'Address waste, spill prevention, nuisance, housekeeping and relevant project environmental controls.', 'Verify implementation and records against project requirements.'),
    _PlanSection('15', 'Incident & Near-Miss Management', 'Define reporting, investigation and learning.', 'The plan should provide an organised route for reporting incidents and near misses, controlling immediate risk and applying learning.', 'Protect the scene where appropriate, report promptly and track actions to closure.', 'Check reports, investigation records, actions and lessons communicated.'),
    _PlanSection('16', 'Corrective Actions', 'Turn findings into verified improvements.', 'The original content states that defects should be corrected and effectiveness verified before restart where critical controls fail.', 'Assign actions to responsible persons with realistic target dates and verification.', 'Do not close an action only on a verbal statement; verify effectiveness.'),
    _PlanSection('17', 'Document & Record Control', 'Keep the plan controlled and traceable.', 'The plan, risk register, methods, permits, training and inspection records should be controlled so workers use the applicable information.', 'Remove obsolete copies from active use and communicate revisions.', 'Check revision, approval, distribution and retention arrangements.'),
    _PlanSection('18', 'Change Management', 'Keep controls aligned when conditions change.', 'The original content identifies change as a reason to review controls when conditions affecting the HSE plan change.', 'Pause, reassess and update the safe system when scope, sequence, equipment, environment or interfaces change materially.', 'Verify revised documents and re-brief affected workers.'),
    _PlanSection('19', 'Supervisor Application', 'Apply the plan at the workface.', 'Supervisors control the workface and verify safe execution. The plan becomes effective only when its arrangements are implemented in daily work.', 'Conduct pre-start checks, brief the team, monitor controls and intervene early.', 'Confirm field conditions match approved arrangements.'),
    _PlanSection('20', 'HSE Officer Verification', 'Monitor compliance and provide assurance.', 'The HSE function monitors compliance, advises on controls and verifies corrective actions without replacing line-management responsibility.', 'Use inspections, observations, document reviews and action tracking.', 'Record objective evidence and escalate critical control failures.'),
    _PlanSection('21', 'Worker Responsibilities', 'Workers follow the approved safe system and report change.', 'The original content requires workers to perform work within approved instructions and competence and report hazards, defects and changes.', 'Encourage stop-and-report behaviour and protect others through safe housekeeping and segregation.', 'Check understanding through field conversations and observations.'),
    _PlanSection('22', 'Practical Construction Example', 'Apply the plan to a changing workface.', 'If a control gap is identified, the affected task should be paused, the area made safe, the condition corrected and the work rechecked before restart.', 'Use the event as a learning opportunity and update controls where necessary.', 'Verify corrective action and record the learning.'),
    _PlanSection('23', 'Stop-Work Conditions', 'Stop when critical controls are missing or the safe system cannot be maintained.', 'The original content identifies missing critical controls, unsafe conditions and material deviation from the plan as stop-work triggers.', 'Stop the affected work, make the area safe, escalate and reassess before restart.', 'Restart only after critical controls are restored and verified.'),
    _PlanSection('24', 'Key Learning & Close-Out', 'PLAN → CONTROL → INSPECT → ACT.', 'The original key learning points emphasise active control, field verification and early intervention. Documentation must match real site conditions.', 'Use lessons learned and management review to improve future work.', 'Confirm open actions, records, lessons and final close-out.'),
  ];
}

class DubaiHseConstructionHsePlanAdvancedLearningPage extends StatelessWidget {
  const DubaiHseConstructionHsePlanAdvancedLearningPage({super.key});

  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color navy = Color(0xFF17324D);
  static const Color bg = Color(0xFFF5F8F7);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        title: const Text('📚 Advanced Learning', style: TextStyle(fontWeight: FontWeight.w700)),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 36),
        children: [
          _advancedIntro(),
          const SizedBox(height: 12),
          for (final module in _modules) ...[
            _module(module),
            const SizedBox(height: 9),
          ],
          _checklist(),
          const SizedBox(height: 12),
          _questions(),
        ],
      ),
    );
  }

  Widget _advancedIntro() {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(color: const Color(0xFF159447).withValues(alpha: .25)),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Construction HSE Plan — Advanced Study', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: navy)),
          SizedBox(height: 8),
          Text('This is the advanced reference layer for deeper study. It expands the original topic without replacing the original detailed SafeNexus content.', style: TextStyle(fontSize: 13.5, height: 1.55, color: Color(0xFF52606D))),
        ],
      ),
    );
  }

  Widget _module(_AdvancedModule module) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(color: Colors.black.withValues(alpha: .07)),
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
        childrenPadding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
        leading: CircleAvatar(
          radius: 19,
          backgroundColor: const Color(0xFFE8F5ED),
          child: Text(module.number, style: const TextStyle(fontWeight: FontWeight.w800, color: darkGreen)),
        ),
        title: Text(module.title, style: const TextStyle(fontWeight: FontWeight.w800, color: navy)),
        subtitle: Text(module.subtitle),
        children: [
          for (final point in module.points)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(padding: EdgeInsets.only(top: 5), child: Icon(Icons.check_circle_rounded, size: 15, color: darkGreen)),
                  const SizedBox(width: 8),
                  Expanded(child: Text(point, style: const TextStyle(fontSize: 13.5, height: 1.5, color: Color(0xFF425466)))),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _checklist() {
    return _advancedCard(
      'Professional Field Verification Checklist',
      const [
        'Approved project HSE Plan is available and current.',
        'Project scope, phases and high-risk activities are covered.',
        'Organisation chart and responsibilities are clear.',
        'Risk register and RAMS align with actual work.',
        'Permit interfaces are identified and controlled where applicable.',
        'Training and competency evidence is current.',
        'Inspection, monitoring and audit programmes are active.',
        'Emergency arrangements are communicated and tested as required.',
        'Findings and corrective actions are tracked to verified closure.',
        'Changes are assessed and affected personnel are re-briefed.',
      ],
    );
  }

  Widget _questions() {
    return _advancedCard(
      'Professional Learning / Interview Questions',
      const [
        'What is the purpose of a project-specific Construction HSE Plan?',
        'How do you verify that an HSE Plan reflects actual site conditions?',
        'How should the HSE Plan connect with the risk register and RAMS?',
        'What evidence would you check during an HSE Plan audit?',
        'When should an HSE Plan be reviewed or revised?',
        'How do contractors and subcontractors fit into the project HSE Plan?',
        'What would make you stop affected work because the plan cannot be safely implemented?',
        'How do toolbox talks and training support implementation of the plan?',
        'How do you verify corrective-action effectiveness?',
        'Give a practical example where a change in site conditions requires reassessment.',
      ],
    );
  }

  Widget _advancedCard(String title, List<String> points) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.black.withValues(alpha: .07))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: navy)),
          const SizedBox(height: 10),
          for (final point in points)
            Padding(
              padding: const EdgeInsets.only(bottom: 9),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(padding: EdgeInsets.only(top: 5), child: Icon(Icons.check_circle_outline_rounded, size: 16, color: darkGreen)),
                  const SizedBox(width: 8),
                  Expanded(child: Text(point, style: const TextStyle(fontSize: 13.5, height: 1.5, color: Color(0xFF425466)))),
                ],
              ),
            ),
        ],
      ),
    );
  }

  static const List<_AdvancedModule> _modules = [
    _AdvancedModule('A1', 'Plan Architecture & Control', 'How a project HSE plan becomes an operational control system.', [
      'Start with project scope, work phases, interfaces, hazards and applicable requirements rather than copying a generic plan.',
      'Define ownership, approval, distribution, implementation, monitoring and review so the document has an operational life.',
      'Keep the plan consistent with the risk register, approved methods, permits, emergency arrangements and project programmes.',
    ]),
    _AdvancedModule('A2', 'Risk-Based Planning', 'Use the risk profile to determine the depth of controls and assurance.', [
      'Identify significant hazards and high-risk activities early and link controls to responsible persons.',
      'Consider simultaneous operations, interfaces, temporary works, access, plant, people and changing conditions.',
      'Review the plan when risk information changes materially.',
    ]),
    _AdvancedModule('A3', 'RAMS & Workface Implementation', 'Move from approved documentation to actual work.', [
      'Confirm the method is understood before exposure and that workers have the required competence.',
      'Check field conditions against the approved safe system rather than treating document approval as proof of field compliance.',
      'Stop and reassess when the actual activity differs materially from the approved arrangement.',
    ]),
    _AdvancedModule('A4', 'Permit Interface', 'Coordinate controlled work through the project permit system where applicable.', [
      'Identify which activities require permits and define responsibilities for request, review, authorisation, field verification and close-out.',
      'Ensure permit conditions remain consistent with isolation, risk assessment, method and actual work conditions.',
    ]),
    _AdvancedModule('A5', 'Competency & Supervision', 'Ensure people and supervision match the risk.', [
      'Use training, experience, task competency and authority as part of work planning.',
      'Supervision should be proportionate to risk and capable of detecting deviations early.',
      'Maintain objective competency and briefing records.',
    ]),
    _AdvancedModule('A6', 'Inspection, Audit & Assurance', 'Verify implementation with objective evidence.', [
      'Use inspections to check critical controls and audits to test whether the management arrangements are working as intended.',
      'Sample documents and field conditions together; either one alone can give an incomplete picture.',
      'Track findings to verified closure and examine recurring failures for systemic causes.',
    ]),
    _AdvancedModule('A7', 'Emergency Preparedness', 'Make emergency arrangements practical and site-specific.', [
      'Plan alarm, communication, access, assembly, response, first aid and escalation arrangements appropriate to the site.',
      'Communicate arrangements to affected personnel and test them through appropriate exercises or drills.',
      'Review emergency arrangements after significant site or project changes.',
    ]),
    _AdvancedModule('A8', 'Contractor Integration', 'Prevent gaps between organisations.', [
      'Define contractor responsibilities and interfaces before work starts.',
      'Coordinate induction, RAMS, permits, supervision, inspections, reporting and corrective actions.',
      'Verify contractor performance using field evidence and records.',
    ]),
    _AdvancedModule('A9', 'Change Management', 'Keep the HSE Plan alive as the project changes.', [
      'Trigger review for scope changes, sequence changes, new equipment, changed environment, new interfaces or changed risk.',
      'Update affected documents and re-brief workers before exposure to the changed condition.',
      'Record the change and the resulting control decisions.',
    ]),
    _AdvancedModule('A10', 'Incident Learning & CAPA', 'Use events and findings to strengthen the plan.', [
      'Control immediate risk first, then investigate and identify corrective actions.',
      'Verify action effectiveness rather than closing actions only because a task was completed.',
      'Feed significant lessons into procedures, briefings, training and future planning.',
    ]),
    _AdvancedModule('A11', 'Field Verification & Stop Work', 'Know when the approved safe system is no longer valid.', [
      'Stop affected work when critical controls are missing, unsafe conditions exist or the activity cannot be performed within the approved safe system.',
      'Make the area safe, escalate, reassess and verify controls before restart.',
      'Record objective evidence and communicate the learning.',
    ]),
    _AdvancedModule('A12', 'HSE Professional Review', 'Use the plan as an assurance tool, not just a document.', [
      'Ask whether the plan is current, understood, implemented, monitored and improved.',
      'Check alignment between management intent, workface practice and evidence.',
      'Use recurring findings, KPI trends, audits and lessons learned to support continual improvement.',
    ]),
  ];
}

class _PlanSection {
  const _PlanSection(this.number, this.title, this.summary, this.detail, this.field, this.verify);
  final String number;
  final String title;
  final String summary;
  final String detail;
  final String field;
  final String verify;
}

class _AdvancedModule {
  const _AdvancedModule(this.number, this.title, this.subtitle, this.points);
  final String number;
  final String title;
  final String subtitle;
  final List<String> points;
}
