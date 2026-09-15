import 'package:flutter/material.dart';

/// SafeNexus HSE
/// STEP 03 — HSE Organisation & Responsibilities
///
/// Single-file architecture:
///   1. Main learning page
///   2. Detailed topic pages
///   3. Advanced Learning page
///
/// Add/replace only. This file does not delete or modify Step 01 or Step 02.

class DubaiHseOrganisationResponsibilitiesPage extends StatelessWidget {
  const DubaiHseOrganisationResponsibilitiesPage({super.key});

  static const Color green = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color purple = Color(0xFF6A3FB5);
  static const Color background = Color(0xFFF5F8F6);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: const Text(
          'HSE Organisation & Responsibilities',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 18, 16, 30),
        children: [
          _HeaderCard(
            title: 'HSE Organisation & Responsibilities',
            subtitle:
                'A practical framework for defining authority, accountability, competence, communication and HSE responsibilities across a construction project.',
            icon: Icons.account_tree_rounded,
            color: darkGreen,
          ),
          const SizedBox(height: 14),
          _NoticeCard(
            text:
                'Use this learning module to understand who is responsible for what, who has authority to act, how responsibilities are communicated, and how implementation is verified on site. Project-specific legal, contractual and organisational requirements must always be checked.',
          ),
          const SizedBox(height: 14),
          _AdvancedButton(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    const DubaiHseOrganisationResponsibilitiesAdvancedPage(),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const _SectionHeading(
            title: 'Complete Topic',
            subtitle:
                'Tap any section for detailed explanation and construction-site application.',
          ),
          const SizedBox(height: 10),
          ...List.generate(
            _sections.length,
            (index) => _TopicTile(
              number: index + 1,
              title: _sections[index].title,
              icon: _sections[index].icon,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      DubaiHseOrganisationResponsibilitiesDetailPage(
                    section: _sections[index],
                    number: index + 1,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DubaiHseOrganisationResponsibilitiesDetailPage
    extends StatelessWidget {
  final HseOrgSection section;
  final int number;

  const DubaiHseOrganisationResponsibilitiesDetailPage({
    super.key,
    required this.section,
    required this.number,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DubaiHseOrganisationResponsibilitiesPage.background,
      appBar: AppBar(
        title: Text(
          '${number.toString().padLeft(2, '0')}  ${section.title}',
          style: const TextStyle(fontWeight: FontWeight.w800),
        ),
        backgroundColor: DubaiHseOrganisationResponsibilitiesPage.darkGreen,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 18, 16, 30),
        children: [
          _HeaderCard(
            title: section.title,
            subtitle: section.summary,
            icon: section.icon,
            color: DubaiHseOrganisationResponsibilitiesPage.green,
          ),
          const SizedBox(height: 14),
          _ContentCard(
            title: 'Detailed Explanation',
            icon: Icons.menu_book_rounded,
            children: section.explanation,
          ),
          const SizedBox(height: 12),
          _ContentCard(
            title: 'Construction-Site Application',
            icon: Icons.construction_rounded,
            children: section.siteApplication,
          ),
          const SizedBox(height: 12),
          _ContentCard(
            title: 'HSE Officer / Supervisor Verification',
            icon: Icons.fact_check_rounded,
            children: section.verification,
          ),
          const SizedBox(height: 12),
          _ContentCard(
            title: 'Evidence / Records',
            icon: Icons.folder_copy_rounded,
            children: section.records,
          ),
          const SizedBox(height: 12),
          _ContentCard(
            title: 'Key Learning',
            icon: Icons.lightbulb_rounded,
            children: section.keyLearning,
          ),
        ],
      ),
    );
  }
}

class DubaiHseOrganisationResponsibilitiesAdvancedPage
    extends StatelessWidget {
  const DubaiHseOrganisationResponsibilitiesAdvancedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DubaiHseOrganisationResponsibilitiesPage.background,
      appBar: AppBar(
        title: const Text(
          'Advanced Learning',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        backgroundColor: DubaiHseOrganisationResponsibilitiesPage.purple,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 18, 16, 30),
        children: [
          _HeaderCard(
            title: 'Advanced Learning',
            subtitle:
                'Professional-level learning on HSE organisation, authority, accountability and field implementation.',
            icon: Icons.school_rounded,
            color: DubaiHseOrganisationResponsibilitiesPage.purple,
          ),
          const SizedBox(height: 14),
          _NoticeCard(
            text:
                'Advanced Learning expands the main topic into management-system thinking, field controls and verification. It does not replace the project HSE plan, approved procedures, contractual requirements or applicable authority requirements.',
          ),
          const SizedBox(height: 12),
          ...List.generate(
            _advancedModules.length,
            (index) => _AdvancedModuleTile(
              number: index + 1,
              module: _advancedModules[index],
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;

  const _HeaderCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color, Color.lerp(color, Colors.black, .20)!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: const [
          BoxShadow(
            blurRadius: 14,
            offset: Offset(0, 7),
            color: Color(0x22000000),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 27,
            backgroundColor: Colors.white.withValues(alpha: .18),
            child: Icon(icon, color: Colors.white, size: 29),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.white,
                    height: 1.45,
                    fontSize: 13.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NoticeCard extends StatelessWidget {
  final String text;

  const _NoticeCard({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(17),
        border: Border.all(color: const Color(0xFFD8E8DE)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.info_outline_rounded, color: Color(0xFF159447)),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(height: 1.5, fontSize: 13.5),
            ),
          ),
        ],
      ),
    );
  }
}

class _AdvancedButton extends StatelessWidget {
  final VoidCallback onTap;

  const _AdvancedButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: DubaiHseOrganisationResponsibilitiesPage.purple,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 18, vertical: 17),
          child: Row(
            children: [
              Icon(Icons.auto_stories_rounded, color: Colors.white, size: 27),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  '📚  Advanced Learning',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              Icon(Icons.arrow_forward_ios_rounded,
                  color: Colors.white, size: 17),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionHeading extends StatelessWidget {
  final String title;
  final String subtitle;

  const _SectionHeading({
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: const TextStyle(fontSize: 21, fontWeight: FontWeight.w900)),
        const SizedBox(height: 4),
        Text(subtitle,
            style: const TextStyle(color: Colors.black54, height: 1.4)),
      ],
    );
  }
}

class _TopicTile extends StatelessWidget {
  final int number;
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const _TopicTile({
    required this.number,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 9),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        onTap: onTap,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
        leading: CircleAvatar(
          backgroundColor: const Color(0xFFE6F4EB),
          child: Text(
            number.toString().padLeft(2, '0'),
            style: const TextStyle(
              color: Color(0xFF0B5D4B),
              fontWeight: FontWeight.w900,
              fontSize: 12,
            ),
          ),
        ),
        title: Text(title,
            style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14)),
        subtitle: const Text('Tap for detailed learning'),
        trailing: Icon(icon, color: const Color(0xFF159447)),
      ),
    );
  }
}

class _ContentCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<String> children;

  const _ContentCard({
    required this.title,
    required this.icon,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE0E9E4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: const Color(0xFF159447)),
              const SizedBox(width: 9),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...children.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 9),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 7),
                    child: Icon(Icons.circle, size: 6, color: Color(0xFF159447)),
                  ),
                  const SizedBox(width: 9),
                  Expanded(
                    child: Text(
                      item,
                      style: const TextStyle(height: 1.5, fontSize: 13.5),
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

class _AdvancedModuleTile extends StatelessWidget {
  final int number;
  final AdvancedModule module;

  const _AdvancedModuleTile({
    required this.number,
    required this.module,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ExpansionTile(
        leading: CircleAvatar(
          backgroundColor: const Color(0xFFF0E9FB),
          child: Text(
            number.toString().padLeft(2, '0'),
            style: const TextStyle(
              color: Color(0xFF6A3FB5),
              fontWeight: FontWeight.w900,
              fontSize: 12,
            ),
          ),
        ),
        title: Text(module.title,
            style: const TextStyle(fontWeight: FontWeight.w800)),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        children: [
          Text(module.introduction,
              style: const TextStyle(height: 1.5, fontSize: 13.5)),
          const SizedBox(height: 10),
          ...module.points.map(
            (point) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.check_circle_outline_rounded,
                      size: 19, color: Color(0xFF159447)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(point,
                        style: const TextStyle(height: 1.45, fontSize: 13.2)),
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

class HseOrgSection {
  final String title;
  final String summary;
  final IconData icon;
  final List<String> explanation;
  final List<String> siteApplication;
  final List<String> verification;
  final List<String> records;
  final List<String> keyLearning;

  const HseOrgSection({
    required this.title,
    required this.summary,
    required this.icon,
    required this.explanation,
    required this.siteApplication,
    required this.verification,
    required this.records,
    required this.keyLearning,
  });
}

class AdvancedModule {
  final String title;
  final String introduction;
  final List<String> points;

  const AdvancedModule({
    required this.title,
    required this.introduction,
    required this.points,
  });
}

const List<HseOrgSection> _sections = [
  HseOrgSection(
    title: 'HSE Organisation — Meaning & Purpose',
    summary: 'Understand why a defined HSE organisation is necessary.',
    icon: Icons.account_tree_rounded,
    explanation: [
      'An HSE organisation defines how safety, health and environmental responsibilities are arranged within the project management structure.',
      'It should make clear who has responsibility, who has authority, who must be consulted, who performs verification and who must act when an unsafe condition is identified.',
      'A good structure prevents responsibility gaps and avoids the assumption that safety belongs only to the HSE department.',
    ],
    siteApplication: [
      'At mobilisation, establish the project organisation chart and communicate reporting lines before major construction activities begin.',
      'Make the structure practical: project leadership, construction management, HSE personnel, supervisors, workers, specialist teams and contractors should know their interfaces.',
    ],
    verification: [
      'Confirm the organisation chart is current and reflects actual personnel on site.',
      'Interview personnel at different levels and ask them to explain their HSE responsibilities and escalation route.',
    ],
    records: [
      'Approved organisation chart, responsibility matrix, appointment letters and competency records.',
      'Meeting minutes, induction records and communication evidence showing that responsibilities were explained.',
    ],
    keyLearning: [
      'A chart is useful only when people understand and exercise the responsibilities assigned to them.',
    ],
  ),
  HseOrgSection(
    title: 'Project HSE Organisation Structure',
    summary: 'Build clear reporting and functional interfaces.',
    icon: Icons.schema_rounded,
    explanation: [
      'The project structure should reflect the size, complexity, hazards and contractual arrangements of the work.',
      'The HSE function should have sufficient access to project leadership and a clear route for escalating serious risks.',
      'Interfaces between construction, engineering, quality, environmental, occupational health, logistics and HSE functions must be defined.',
    ],
    siteApplication: [
      'Display or electronically communicate the current project organisation and escalation route.',
      'For high-risk activities, identify the responsible manager, supervisor, competent persons and HSE verification role before work starts.',
    ],
    verification: [
      'Check whether the actual site team matches the approved structure.',
      'Verify vacancies, acting appointments and temporary changes are formally controlled.',
    ],
    records: [
      'Organisation chart, project directory, appointment records and interface/responsibility matrix.',
    ],
    keyLearning: [
      'The organisation must match the real work, not merely satisfy a document requirement.',
    ],
  ),
  HseOrgSection(
    title: 'Management Roles & Responsibilities',
    summary: 'Translate management accountability into specific duties.',
    icon: Icons.manage_accounts_rounded,
    explanation: [
      'Management responsibilities should cover planning, resources, legal and project requirements, risk control, competence, monitoring and continual improvement.',
      'Senior management remains accountable for providing direction and resources; operational managers control the work through planning and supervision.',
      'HSE personnel provide specialist advice, monitoring and assurance but should not become a substitute for line management responsibility.',
    ],
    siteApplication: [
      'Before work begins, management confirms resources, competent personnel, approved plans and controls are available.',
      'During execution, management reviews significant findings and ensures actions are closed effectively.',
    ],
    verification: [
      'Review management meeting actions, site inspections and evidence of response to significant HSE issues.',
    ],
    records: [
      'Management review records, action trackers, inspection reports and resource approvals.',
    ],
    keyLearning: [
      'Safety leadership is demonstrated by decisions, resources and follow-through—not by titles alone.',
    ],
  ),
  HseOrgSection(
    title: 'HSE Manager / Head of HSE',
    summary: 'Define the leadership and assurance role of the senior HSE function.',
    icon: Icons.shield_rounded,
    explanation: [
      'The senior HSE function normally coordinates the HSE management framework, advises leadership, monitors implementation and escalates significant risks.',
      'The role includes maintaining effective HSE processes, competent HSE staffing, reporting, trend analysis, audits and improvement actions according to the project arrangement.',
      'The HSE manager should retain professional independence in reporting significant safety concerns.',
    ],
    siteApplication: [
      'Review critical risk controls, major incidents, recurring findings, training needs and contractor performance with project leadership.',
      'Ensure the HSE team has adequate access to work areas and information needed for monitoring and assurance.',
    ],
    verification: [
      'Check whether significant risks and overdue actions are escalated to the appropriate management level.',
    ],
    records: [
      'HSE reports, audit plans, management meeting minutes, KPI reports and action registers.',
    ],
    keyLearning: [
      'The senior HSE role combines technical guidance, assurance, escalation and leadership support.',
    ],
  ),
  HseOrgSection(
    title: 'HSE Officer / Advisor Responsibilities',
    summary: 'Understand the field-level specialist role.',
    icon: Icons.badge_rounded,
    explanation: [
      'The HSE Officer supports implementation through inspections, observations, advice, reporting, verification, worker engagement and follow-up.',
      'The officer should identify unsafe conditions and behaviours, assess whether controls are working and escalate serious concerns.',
      'The HSE Officer does not remove the line supervisor’s responsibility for controlling the work.',
    ],
    siteApplication: [
      'Conduct field inspections, verify permits and controls where assigned, participate in toolbox talks, record findings and follow corrective actions.',
      'Stop or escalate work when an immediate serious danger exists in accordance with project authority and procedure.',
    ],
    verification: [
      'Check that inspections identify meaningful conditions rather than only housekeeping observations.',
      'Verify that findings are tracked to closure and effectiveness is checked.',
    ],
    records: [
      'Inspection reports, observation cards, photographs where permitted, action trackers and daily HSE reports.',
    ],
    keyLearning: [
      'Effective HSE officers combine field presence, technical judgement, communication and disciplined follow-up.',
    ],
  ),
  HseOrgSection(
    title: 'Construction Manager / Project Manager Responsibilities',
    summary: 'Connect production management with HSE control.',
    icon: Icons.engineering_rounded,
    explanation: [
      'Construction and project management are responsible for integrating HSE into planning, sequencing, resources, interfaces and execution.',
      'Production targets should not override approved safety controls or create pressure to bypass requirements.',
      'Management must respond to significant HSE information and ensure appropriate resources are available.',
    ],
    siteApplication: [
      'Review high-risk activities before mobilisation, coordinate simultaneous operations and ensure adequate supervision.',
      'Include HSE performance in planning meetings and daily coordination where appropriate.',
    ],
    verification: [
      'Look for evidence that HSE constraints influence planning decisions and work sequencing.',
    ],
    records: [
      'Planning minutes, coordination records, work-front releases and management action trackers.',
    ],
    keyLearning: [
      'HSE must be integrated into construction decisions, not added after the work is planned.',
    ],
  ),
  HseOrgSection(
    title: 'Supervisor / Foreman Responsibilities',
    summary: 'Define the person closest to day-to-day work control.',
    icon: Icons.supervisor_account_rounded,
    explanation: [
      'Supervisors translate approved methods and controls into daily work. They allocate tasks, brief workers, check conditions and intervene when controls are not adequate.',
      'A supervisor should know the hazards of the activity, worker competence requirements, equipment limitations and relevant permits or restrictions.',
    ],
    siteApplication: [
      'Conduct pre-start checks, confirm workers understand the task, maintain exclusion zones and stop/reassess when conditions change.',
      'Do not allow work to continue simply because a permit or method statement exists if actual site conditions are unsafe.',
    ],
    verification: [
      'Interview supervisors about their current work-front hazards and required controls.',
      'Observe whether supervision is active during critical stages.',
    ],
    records: [
      'Toolbox attendance, pre-start checklists, supervisor inspection records and work-front briefings.',
    ],
    keyLearning: [
      'Supervision is an active control, not just attendance at the work location.',
    ],
  ),
  HseOrgSection(
    title: 'Worker Responsibilities',
    summary: 'Make worker responsibilities clear and practical.',
    icon: Icons.groups_rounded,
    explanation: [
      'Workers are expected to follow approved instructions, use required controls and PPE, attend required briefings, report hazards and incidents, and cooperate with the HSE system.',
      'Workers should not be expected to accept uncontrolled risks simply because a task is urgent or familiar.',
      'Workers should understand their right and responsibility to raise concerns through the available reporting and stop-work process.',
    ],
    siteApplication: [
      'Workers confirm they understand the task, report changed conditions and do not bypass guards, barriers, isolation or other critical controls.',
      'Workers immediately report injuries, near misses and dangerous conditions through the project process.',
    ],
    verification: [
      'Ask workers to explain the main hazards and controls for the job they are performing.',
    ],
    records: [
      'Induction, training, toolbox talk attendance, competency records and hazard/near-miss reports.',
    ],
    keyLearning: [
      'Worker involvement is strongest when reporting concerns is encouraged and acted upon.',
    ],
  ),
  HseOrgSection(
    title: 'Contractor & Subcontractor Responsibilities',
    summary: 'Control responsibilities across organisational boundaries.',
    icon: Icons.handshake_rounded,
    explanation: [
      'Contractors and subcontractors must understand their contractual HSE duties, project rules, competence requirements and interfaces with other work groups.',
      'Responsibilities should be coordinated so that no critical control is assumed to belong to another party.',
      'The principal/project organisation should monitor contractor performance according to the established management system.',
    ],
    siteApplication: [
      'Before mobilisation, verify required documentation, competence, equipment and HSE arrangements.',
      'Coordinate simultaneous operations and clarify who controls shared areas, permits, access, lifting zones, emergency interfaces and temporary works.',
    ],
    verification: [
      'Check contractor HSE plans, risk assessments, competency records and corrective-action performance.',
    ],
    records: [
      'Prequalification records, inductions, contractor meetings, audits, inspection reports and performance reviews.',
    ],
    keyLearning: [
      'Contracting work out does not mean contracting out the need for effective HSE coordination and oversight.',
    ],
  ),
  HseOrgSection(
    title: 'Authority, Accountability & Responsibility',
    summary: 'Separate duties from decision-making authority and accountability.',
    icon: Icons.gavel_rounded,
    explanation: [
      'Responsibility describes what a person must do; authority describes what they are empowered to decide or control; accountability describes ownership of outcomes within their role.',
      'A responsibility without adequate authority or resources can become ineffective.',
      'Critical HSE responsibilities should be assigned to competent people and supported by clear escalation arrangements.',
    ],
    siteApplication: [
      'Define who can approve work, who can release a work front, who can isolate equipment, who can authorize permits and who can stop unsafe work.',
    ],
    verification: [
      'Interview key personnel about their authority limits and escalation route.',
    ],
    records: [
      'Responsibility matrix, delegation records, appointment letters and approved procedures.',
    ],
    keyLearning: [
      'Clear authority prevents delays, confusion and unsafe assumptions at the work front.',
    ],
  ),
  HseOrgSection(
    title: 'Competence & Appointment of Responsible Persons',
    summary: 'Match responsibilities with competence.',
    icon: Icons.workspace_premium_rounded,
    explanation: [
      'People assigned safety-critical duties should have the knowledge, skills, experience and training appropriate to those duties.',
      'Competence should be verified rather than assumed from job title alone.',
      'Where a role requires a designated competent person, the project should retain evidence supporting the appointment.',
    ],
    siteApplication: [
      'Verify competent persons for activities such as lifting, scaffolding, electrical work, confined-space operations or other safety-critical tasks as required by the project and applicable requirements.',
    ],
    verification: [
      'Check credentials, training, experience, authorization and task-specific competence evidence.',
    ],
    records: [
      'Training matrix, certificates, competency assessments, authorization lists and appointment records.',
    ],
    keyLearning: [
      'Assigning a person is not enough; the person must be capable of performing the responsibility.',
    ],
  ),
  HseOrgSection(
    title: 'HSE Communication & Reporting Lines',
    summary: 'Ensure information reaches the right decision-maker quickly.',
    icon: Icons.forum_rounded,
    explanation: [
      'The organisation needs clear routes for reporting hazards, incidents, changes, resource constraints and serious risks.',
      'Communication should work both downward and upward: management communicates expectations while workers and supervisors provide field information.',
      'Emergency communication should be especially clear, simple and tested.',
    ],
    siteApplication: [
      'Display emergency contacts, escalation routes and reporting expectations at suitable locations.',
      'Use toolbox talks, briefings, meetings and digital or paper reporting systems according to the project arrangement.',
    ],
    verification: [
      'Test whether workers know who to contact for a hazard, incident or emergency.',
    ],
    records: [
      'Toolbox records, meeting minutes, emergency drills, notifications and incident reports.',
    ],
    keyLearning: [
      'A reporting line is effective only when information travels quickly enough to support action.',
    ],
  ),
  HseOrgSection(
    title: 'Delegation & Escalation',
    summary: 'Control delegated duties without losing accountability.',
    icon: Icons.alt_route_rounded,
    explanation: [
      'Delegation can distribute work effectively, but critical responsibilities should have defined limits, competent delegates and clear escalation triggers.',
      'Serious risks, major incidents, repeated failures or resource barriers should be escalated to the appropriate management level.',
    ],
    siteApplication: [
      'When the responsible supervisor is absent, use formally defined acting arrangements rather than informal assumptions.',
      'Escalate unresolved critical findings instead of repeatedly recording them at the same level.',
    ],
    verification: [
      'Review overdue or repeated findings for evidence of escalation.',
    ],
    records: [
      'Delegation records, escalation logs, action trackers and management correspondence.',
    ],
    keyLearning: [
      'Good escalation prevents known problems from becoming repeated events.',
    ],
  ),
  HseOrgSection(
    title: 'Worker Consultation & Participation',
    summary: 'Include workers in identifying and controlling workplace risks.',
    icon: Icons.diversity_3_rounded,
    explanation: [
      'Workers often have direct knowledge of task conditions, practical difficulties and changes at the work face.',
      'Consultation can include toolbox talks, safety meetings, observations, hazard reporting and structured feedback mechanisms.',
      'Participation should be genuine: reported concerns should be assessed and, where appropriate, acted upon.',
    ],
    siteApplication: [
      'Ask workers about difficult or unreliable controls during briefings and inspections.',
      'Use worker feedback when reviewing methods after changes or near misses.',
    ],
    verification: [
      'Check whether worker suggestions are recorded, assigned and closed where applicable.',
    ],
    records: [
      'Safety meeting minutes, consultation records, suggestion logs and toolbox talk feedback.',
    ],
    keyLearning: [
      'Consultation improves control quality because it brings field experience into planning.',
    ],
  ),
  HseOrgSection(
    title: 'HSE Resources & Staffing',
    summary: 'Provide adequate people, time, equipment and support.',
    icon: Icons.inventory_2_rounded,
    explanation: [
      'An HSE organisation requires sufficient competent personnel and resources for the scale and risk profile of the project.',
      'Resource needs can change as work fronts, workforce numbers, high-risk activities and contractor interfaces increase.',
      'Resource constraints should be visible to management rather than hidden at field level.',
    ],
    siteApplication: [
      'Review HSE coverage during mobilisation and major changes in project activity.',
      'Ensure inspection, emergency, welfare, monitoring and training arrangements have appropriate resources.',
    ],
    verification: [
      'Compare planned staffing and resources with actual project conditions and workload.',
    ],
    records: [
      'Staffing plans, resource requests, equipment registers and management review records.',
    ],
    keyLearning: [
      'Insufficient HSE resources can weaken the controls that the management system depends on.',
    ],
  ),
  HseOrgSection(
    title: 'Daily Coordination & Interface Management',
    summary: 'Control responsibilities where multiple teams interact.',
    icon: Icons.sync_alt_rounded,
    explanation: [
      'Construction activities frequently overlap. Responsibility must be coordinated when several employers, disciplines or work fronts share space or resources.',
      'Interface management should address access, lifting, temporary works, energy isolation, traffic, work sequencing and emergency arrangements as applicable.',
    ],
    siteApplication: [
      'Use daily coordination to identify simultaneous operations and assign clear control owners.',
      'Reassess interfaces when the sequence, work area or contractor changes.',
    ],
    verification: [
      'Observe whether workers know the boundaries and controls of shared work areas.',
    ],
    records: [
      'Daily coordination records, interface registers, permits and work-front plans.',
    ],
    keyLearning: [
      'Many site failures occur at interfaces, where responsibility is shared or assumed.',
    ],
  ),
  HseOrgSection(
    title: 'Emergency Roles & Responsibilities',
    summary: 'Assign clear responsibilities before an emergency occurs.',
    icon: Icons.emergency_rounded,
    explanation: [
      'Emergency arrangements should define who raises the alarm, controls the area, contacts emergency services, manages evacuation, accounts for personnel and coordinates response.',
      'Roles should be communicated and tested through suitable drills and exercises.',
      'Emergency responsibilities should consider contractors, visitors and vulnerable persons where relevant.',
    ],
    siteApplication: [
      'Display emergency contacts and evacuation arrangements and ensure responsible persons know their roles.',
      'After drills or events, review response performance and close identified gaps.',
    ],
    verification: [
      'Ask personnel what they would do first in a relevant emergency scenario.',
    ],
    records: [
      'Emergency plan, drill reports, attendance/accountability records and corrective actions.',
    ],
    keyLearning: [
      'Emergency organisation must be known before the emergency—not invented during it.',
    ],
  ),
  HseOrgSection(
    title: 'Environmental & Occupational Health Responsibilities',
    summary: 'Include health and environmental functions in the organisational structure.',
    icon: Icons.eco_rounded,
    explanation: [
      'HSE organisation should cover occupational health, welfare and environmental responsibilities relevant to the project.',
      'Responsibilities may include heat-stress controls, welfare facilities, exposure monitoring, waste management, spill response and environmental inspections as applicable.',
    ],
    siteApplication: [
      'Assign responsible persons for health and environmental controls and define interfaces with HSE and construction management.',
    ],
    verification: [
      'Check that health and environmental findings are assigned to competent owners and tracked to closure.',
    ],
    records: [
      'Monitoring records, welfare inspections, environmental inspections, waste records and health-related programme records as applicable.',
    ],
    keyLearning: [
      'A complete HSE organisation considers safety, occupational health and environmental responsibilities together.',
    ],
  ),
  HseOrgSection(
    title: 'HSE Meetings, Committees & Worker Engagement',
    summary: 'Create structured forums for HSE decision-making and feedback.',
    icon: Icons.groups_2_rounded,
    explanation: [
      'Formal HSE meetings help review performance, significant risks, incidents, actions, upcoming high-risk work and worker concerns.',
      'Meeting frequency and membership should suit project risk, size and contractual requirements.',
    ],
    siteApplication: [
      'Use meetings to make decisions and assign owners rather than simply reading statistics.',
      'Follow up actions and communicate relevant decisions to the workforce.',
    ],
    verification: [
      'Review whether meetings produce measurable actions and whether actions are closed.',
    ],
    records: [
      'Agendas, minutes, attendance, action registers and worker feedback.',
    ],
    keyLearning: [
      'A good HSE meeting changes site conditions or decisions; it is not only a reporting event.',
    ],
  ),
  HseOrgSection(
    title: 'Accountability & Performance Monitoring',
    summary: 'Measure whether assigned responsibilities are being performed.',
    icon: Icons.analytics_rounded,
    explanation: [
      'Accountability is strengthened by objective monitoring of inspections, action closure, training, audits, reporting quality and other project indicators.',
      'Performance measures should encourage effective control rather than unsafe production pressure or superficial reporting.',
    ],
    siteApplication: [
      'Review recurring findings by responsible area and identify whether the underlying control is being maintained.',
      'Use both leading and lagging indicators as appropriate.',
    ],
    verification: [
      'Check that KPI results are linked to actions and management decisions.',
    ],
    records: [
      'KPI dashboards, action trackers, audit reports and management review records.',
    ],
    keyLearning: [
      'Accountability becomes meaningful when performance is visible and followed by action.',
    ],
  ),
  HseOrgSection(
    title: 'Audit & Assurance of Responsibilities',
    summary: 'Verify that the organisation works as designed.',
    icon: Icons.verified_user_rounded,
    explanation: [
      'Audits and assurance activities test whether responsibilities are defined, understood, implemented and evidenced.',
      'Assurance should consider both documents and actual field behaviour.',
    ],
    siteApplication: [
      'Sample interviews across management, supervisors and workers and compare their answers with documented responsibilities.',
      'Observe critical work to confirm the assigned responsible persons are actually controlling the activity.',
    ],
    verification: [
      'Check for responsibility gaps, outdated appointments, missing competence evidence and repeated failures.',
    ],
    records: [
      'Audit reports, interview records, inspection findings and corrective-action evidence.',
    ],
    keyLearning: [
      'A responsibility system is effective only when field practice matches the documented arrangement.',
    ],
  ),
  HseOrgSection(
    title: 'Common Organisational Failures',
    summary: 'Recognise weak structures before they create incidents.',
    icon: Icons.warning_amber_rounded,
    explanation: [
      'Common failures include unclear reporting lines, duplicated authority, unfilled safety-critical roles, inadequate supervision, responsibility gaps and over-reliance on the HSE department.',
      'Another failure is assigning responsibility without resources, competence or decision-making authority.',
    ],
    siteApplication: [
      'During mobilisation and audits, actively look for tasks where workers cannot identify who controls the work.',
      'Treat repeated unresolved findings as a possible organisational problem, not only an individual error.',
    ],
    verification: [
      'Compare repeated findings with responsibility assignments and management actions.',
    ],
    records: [
      'Audit findings, incident investigations, action registers and organisation reviews.',
    ],
    keyLearning: [
      'Repeated control failures often indicate a system or leadership weakness behind the immediate unsafe act.',
    ],
  ),
  HseOrgSection(
    title: 'Practical Construction-Site Scenarios',
    summary: 'Apply the organisation structure to realistic site situations.',
    icon: Icons.engineering_rounded,
    explanation: [
      'Scenario learning tests whether people know who owns a risk and how the organisation should respond.',
      'Examples include an unplanned excavation condition, a lifting-zone conflict, a permit discrepancy, a contractor interface issue or a serious access problem.',
    ],
    siteApplication: [
      'For each scenario ask: Who identifies it? Who controls the work? Who has authority to stop? Who must be informed? Who verifies the corrective action? Who records the event?',
    ],
    verification: [
      'Run short scenario discussions with supervisors and workers during suitable briefings.',
    ],
    records: [
      'Toolbox discussion records, scenario training records and corrective-action logs.',
    ],
    keyLearning: [
      'The strongest organisation is one where responsibility is clear under normal and changing conditions.',
    ],
  ),
  HseOrgSection(
    title: 'HSE Officer Verification Checklist',
    summary: 'Use a field-oriented verification sequence.',
    icon: Icons.checklist_rounded,
    explanation: [
      'Verification should confirm the organisation is current, competent personnel are appointed, responsibilities are understood and critical authority routes are functional.',
    ],
    siteApplication: [
      'Check organisation chart, appointments, competence, supervisor coverage, contractor interfaces, emergency roles and escalation routes.',
    ],
    verification: [
      'Interview at least one management representative, supervisor and worker where practical.',
      'Verify findings are assigned to actual responsible persons and closed with evidence.',
    ],
    records: [
      'Completed verification checklist, interview notes, findings and close-out evidence.',
    ],
    keyLearning: [
      'Verification should test understanding and implementation—not just document availability.',
    ],
  ),
  HseOrgSection(
    title: 'Supervisor Application',
    summary: 'Turn assigned responsibility into daily work control.',
    icon: Icons.assignment_ind_rounded,
    explanation: [
      'Supervisors should understand the boundaries of their authority and know when to stop, reassess or escalate a task.',
      'They should coordinate workers and contractors under their control and ensure instructions are understood.',
    ],
    siteApplication: [
      'Before each shift, review work fronts, hazards, interfaces, permits, competency and equipment status.',
      'When conditions change, pause the task and obtain the required reassessment or authorization.',
    ],
    verification: [
      'Observe whether supervisors actively intervene when controls deteriorate.',
    ],
    records: [
      'Pre-start records, toolbox talks, supervisor checklists and escalation records.',
    ],
    keyLearning: [
      'Supervisors are a critical link between management intent and actual field behaviour.',
    ],
  ),
  HseOrgSection(
    title: 'Worker Expectations',
    summary: 'Define what workers should expect from the organisation and what it expects from them.',
    icon: Icons.person_pin_rounded,
    explanation: [
      'Workers should receive understandable instructions, suitable training, required controls and a clear route to report hazards and concerns.',
      'Workers are expected to follow safe work requirements, use controls correctly and report conditions that may create harm.',
    ],
    siteApplication: [
      'Use worker feedback to identify controls that are difficult to apply or not working as intended.',
    ],
    verification: [
      'Ask workers how they report a hazard and who they contact when a control is missing.',
    ],
    records: [
      'Induction, toolbox attendance, training records and worker reports.',
    ],
    keyLearning: [
      'Clear expectations must work both ways: management provides conditions for safe work and workers participate responsibly.',
    ],
  ),
  HseOrgSection(
    title: 'Evidence, Records & Document Control',
    summary: 'Maintain evidence that responsibilities are defined and implemented.',
    icon: Icons.description_rounded,
    explanation: [
      'Evidence may include organisation charts, appointments, competence records, meeting minutes, briefings, inspections, audits and action close-out records.',
      'Records should be controlled so that current information is identifiable and obsolete arrangements do not continue to guide work.',
    ],
    siteApplication: [
      'Ensure supervisors and HSE personnel use current versions of relevant responsibility matrices and procedures.',
    ],
    verification: [
      'Sample records and compare them with actual personnel and current work arrangements.',
    ],
    records: [
      'Controlled organisation documents, training matrix, appointment letters, meeting records and audit evidence.',
    ],
    keyLearning: [
      'Records demonstrate implementation, but they should support real control rather than become paperwork for its own sake.',
    ],
  ),
  HseOrgSection(
    title: 'Stop-Work Authority & Escalation',
    summary: 'Ensure serious safety concerns can be acted on immediately.',
    icon: Icons.pan_tool_rounded,
    explanation: [
      'The project should define how unsafe work is stopped or suspended when serious uncontrolled risk exists and how the issue is escalated.',
      'The exact authority, procedure and terminology should follow the project system and applicable requirements.',
    ],
    siteApplication: [
      'When a critical control is absent or conditions create an immediate serious danger, stop or suspend the affected activity in accordance with the established procedure, make the area safe and escalate.',
      'Restart only after appropriate controls, authorization and verification are in place.',
    ],
    verification: [
      'Ask workers and supervisors what they would do if a critical control failed.',
    ],
    records: [
      'Stop-work records, incident/observation reports, reassessment records and restart authorization where applicable.',
    ],
    keyLearning: [
      'Stop-work authority is credible only when people know the process and management supports appropriate intervention.',
    ],
  ),
  HseOrgSection(
    title: 'Quick HSE Organisation Checklist',
    summary: 'A concise final check for field use.',
    icon: Icons.fact_check_rounded,
    explanation: [
      'The organisation should be current, responsibilities should be assigned, authority should be clear, competent persons should be available, communication routes should work and evidence should be maintained.',
    ],
    siteApplication: [
      'Before significant work: confirm responsible persons, supervision, competence, controls, interfaces and escalation route.',
      'During work: monitor implementation, respond to changes and close findings.',
    ],
    verification: [
      'Can management, supervisors and workers each explain their HSE role?',
      'Can a serious concern be escalated without delay?',
      'Are assigned actions owned, tracked and verified?',
    ],
    records: [
      'Organisation chart, responsibility matrix, competence records, inspections, meeting minutes and action register.',
    ],
    keyLearning: [
      'If responsibility is unclear at the work face, the organisation needs correction before relying on the control system.',
    ],
  ),
];

const List<AdvancedModule> _advancedModules = [
  AdvancedModule(
    title: '01 — Organisation as a HSE Control',
    introduction:
        'An effective organisation is itself a preventive control because it defines ownership, authority and communication.',
    points: [
      'Map the project structure to the actual work scope, workforce, contractors, hazards and interfaces.',
      'Ensure safety-critical functions have named competent persons and defined escalation routes.',
      'Review the structure when project phases, work fronts or responsibilities materially change.',
    ],
  ),
  AdvancedModule(
    title: '02 — Line Management vs HSE Function',
    introduction:
        'HSE specialists support and assure the system; line management controls production activities and their associated risks.',
    points: [
      'Do not transfer operational responsibility to the HSE department merely because HSE personnel identify a problem.',
      'Supervisors and managers must own implementation of controls within their areas.',
      'HSE should provide specialist advice, monitoring, challenge and escalation consistent with the project arrangement.',
    ],
  ),
  AdvancedModule(
    title: '03 — Responsibility Matrix & RACI Thinking',
    introduction:
        'A responsibility matrix can clarify who performs, owns, supports, is consulted and is informed for important processes.',
    points: [
      'Use a practical matrix for safety-critical activities and management-system processes.',
      'Avoid assigning multiple owners for one decision without clarifying final accountability.',
      'Review the matrix whenever roles or contractors change.',
    ],
  ),
  AdvancedModule(
    title: '04 — Competence-Based Assignment',
    introduction:
        'Safety-critical responsibility should be assigned based on competence, not job title alone.',
    points: [
      'Identify the knowledge, skills, experience, training and authorization needed for each role.',
      'Maintain evidence and reassess competence when work changes or performance indicates a gap.',
      'Use competent-person arrangements where required by the project or applicable requirements.',
    ],
  ),
  AdvancedModule(
    title: '05 — Authority, Delegation & Escalation',
    introduction:
        'Clear authority allows timely decisions while escalation protects the project when a problem exceeds local control.',
    points: [
      'Define approval and intervention limits for supervisors, HSE personnel and management.',
      'Formalize acting arrangements for absences from safety-critical roles.',
      'Escalate serious or repeated failures rather than allowing them to remain at field level.',
    ],
  ),
  AdvancedModule(
    title: '06 — Contractor Interface Control',
    introduction:
        'Multiple organisations create additional responsibility interfaces that require deliberate coordination.',
    points: [
      'Define shared-area, permit, lifting, access, isolation, traffic and emergency responsibilities as applicable.',
      'Verify contractor competence and HSE arrangements before mobilisation and during execution.',
      'Use meetings and inspections to address interface risks before they become incidents.',
    ],
  ),
  AdvancedModule(
    title: '07 — Worker Consultation & Safety Culture',
    introduction:
        'A mature organisation treats workers as participants in risk control rather than passive recipients of instructions.',
    points: [
      'Create safe routes for reporting hazards and suggestions.',
      'Close the feedback loop by communicating actions taken where appropriate.',
      'Watch for fear of reporting, production pressure or normalization of unsafe conditions as culture indicators.',
    ],
  ),
  AdvancedModule(
    title: '08 — Performance, Assurance & Management Review',
    introduction:
        'Organisation effectiveness should be tested using field evidence and performance information.',
    points: [
      'Use inspections, audits, incident learning, action closure and relevant KPIs to evaluate responsibility performance.',
      'Investigate repeated findings for systemic organisational causes.',
      'Use management review to adjust resources, competence, responsibilities and priorities.',
    ],
  ),
  AdvancedModule(
    title: '09 — Emergency Organisation',
    introduction:
        'Emergency roles need clarity, communication and practice before an event occurs.',
    points: [
      'Define alarm, evacuation, first response, communication, accountability and coordination roles according to the emergency plan.',
      'Include contractor and visitor interfaces.',
      'Use drills and exercises to identify organisational weaknesses and verify corrective actions.',
    ],
  ),
  AdvancedModule(
    title: '10 — Field Verification Master Routine',
    introduction:
        'A strong field verification routine tests whether the documented organisation is functioning in reality.',
    points: [
      'Check current organisation, named responsible persons, competence, supervision and work-front interfaces.',
      'Interview management, supervisors and workers about their responsibilities and escalation routes.',
      'Verify that significant findings have owners, deadlines, evidence and effectiveness checks.',
      'Treat repeated gaps as management-system improvement opportunities rather than isolated paperwork issues.',
    ],
  ),
];

