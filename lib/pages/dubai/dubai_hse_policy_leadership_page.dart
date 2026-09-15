import 'package:flutter/material.dart';

/// SafeNexus HSE
/// Dubai HSE — Step 02: HSE Policy & Leadership
///
/// ONE-FILE ARCHITECTURE
/// - Main topic page
/// - 29 detailed learning sections
/// - Section detail pages
/// - Advanced Learning page
/// - Advanced reference modules
///
/// Note:
/// This page is a professional learning/reference aid. For formal
/// compliance decisions, always verify the current applicable authority,
/// client and approved project requirements.

class DubaiHsePolicyLeadershipPage extends StatelessWidget {
  const DubaiHsePolicyLeadershipPage({super.key});

  static const Color primary = Color(0xFF0B6B4F);
  static const Color accent = Color(0xFF159447);
  static const Color background = Color(0xFFF5F8F6);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: const Text(
          'HSE Policy & Leadership',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        backgroundColor: primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(14, 16, 14, 30),
        children: [
          const _IntroCard(),
          const SizedBox(height: 12),
          _AdvancedButton(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const DubaiHsePolicyLeadershipAdvancedPage(),
                ),
              );
            },
          ),
          const SizedBox(height: 14),
          const _NoticeCard(),
          const SizedBox(height: 16),
          const Text(
            'HSE Policy & Leadership — Complete Topic',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: primary,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Tap any section to study the concept, practical site application, '
            'verification approach and evidence expected from a professional HSE system.',
            style: TextStyle(fontSize: 13.5, height: 1.55),
          ),
          const SizedBox(height: 12),
          for (int i = 0; i < _policySections.length; i++) ...[
            _TopicTile(
              number: i + 1,
              section: _policySections[i],
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => DubaiHsePolicyLeadershipDetailPage(
                      section: _policySections[i],
                      number: i + 1,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 8),
          ],
          const SizedBox(height: 10),
          const _FinalReminderCard(),
        ],
      ),
    );
  }
}

class _IntroCard extends StatelessWidget {
  const _IntroCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0B6B4F), Color(0xFF159447)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            blurRadius: 12,
            offset: Offset(0, 5),
            color: Color(0x22000000),
          ),
        ],
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.policy_outlined, color: Colors.white, size: 38),
          SizedBox(height: 10),
          Text(
            'STEP 02',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 12,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.2,
            ),
          ),
          SizedBox(height: 3),
          Text(
            'HSE Policy & Leadership',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'How leadership commitment becomes visible, measurable and '
            'effective at the construction workface.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 13.5,
              height: 1.55,
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
      color: const Color(0xFF123F35),
      borderRadius: BorderRadius.circular(17),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(17),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.auto_stories_outlined,
                  color: Color(0xFF0B6B4F),
                ),
              ),
              SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '📚 Advanced Learning',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      'Leadership principles, implementation strategy and field reference',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 11.5,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, color: Colors.white, size: 18),
            ],
          ),
        ),
      ),
    );
  }
}

class _NoticeCard extends StatelessWidget {
  const _NoticeCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF5EF),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xFFB9DDC8)),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline,
            color: Color(0xFF0B6B4F),
            size: 23,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'A policy is only effective when management commitment can be '
              'seen in planning, resources, supervision, worker engagement, '
              'risk control and follow-up. The presence of a signed policy '
              'alone is not sufficient evidence of effective leadership.',
              style: TextStyle(
                fontSize: 13,
                height: 1.55,
                color: Color(0xFF23463A),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TopicTile extends StatelessWidget {
  final int number;
  final _PolicySection section;
  final VoidCallback onTap;

  const _TopicTile({
    required this.number,
    required this.section,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 0.7,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(13, 13, 11, 13),
          child: Row(
            children: [
              Container(
                width: 43,
                height: 43,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F4ED),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  number.toString().padLeft(2, '0'),
                  style: const TextStyle(
                    color: Color(0xFF0B6B4F),
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      section.title,
                      style: const TextStyle(
                        fontSize: 14.5,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF173C31),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Tap to read detailed explanation',
                      style: TextStyle(
                        fontSize: 11.5,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Color(0xFF5A6B64),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DubaiHsePolicyLeadershipDetailPage extends StatelessWidget {
  final _PolicySection section;
  final int number;

  const DubaiHsePolicyLeadershipDetailPage({
    super.key,
    required this.section,
    required this.number,
  });

  static const Color primary = Color(0xFF0B6B4F);
  static const Color background = Color(0xFFF5F8F6);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: Text(
          '${number.toString().padLeft(2, '0')}  ${section.title}',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        backgroundColor: primary,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(14, 16, 14, 30),
        children: [
          _DetailHeader(number: number, title: section.title),
          const SizedBox(height: 12),
          _DetailBlock(
            title: 'Detailed Explanation',
            icon: Icons.menu_book_outlined,
            text: section.explanation,
          ),
          const SizedBox(height: 10),
          _DetailBlock(
            title: 'Practical Construction-Site Application',
            icon: Icons.construction_outlined,
            text: section.application,
          ),
          const SizedBox(height: 10),
          _DetailBlock(
            title: 'HSE Officer / Supervisor Verification',
            icon: Icons.fact_check_outlined,
            text: section.verification,
          ),
          const SizedBox(height: 10),
          _DetailBlock(
            title: 'Evidence / Records',
            icon: Icons.folder_copy_outlined,
            text: section.evidence,
          ),
          const SizedBox(height: 10),
          _DetailBlock(
            title: 'Leadership Focus',
            icon: Icons.groups_outlined,
            text: section.leadership,
          ),
          const SizedBox(height: 12),
          _TakeawayCard(text: section.takeaway),
        ],
      ),
    );
  }
}

class _DetailHeader extends StatelessWidget {
  final int number;
  final String title;

  const _DetailHeader({
    required this.number,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFD9E7E0)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: const Color(0xFF0B6B4F),
            child: Text(
              number.toString().padLeft(2, '0'),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 21,
                height: 1.25,
                fontWeight: FontWeight.w900,
                color: Color(0xFF173C31),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailBlock extends StatelessWidget {
  final String title;
  final IconData icon;
  final String text;

  const _DetailBlock({
    required this.title,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 0.5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 15, 15, 17),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: const Color(0xFF0B6B4F), size: 22),
                const SizedBox(width: 9),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF0B6B4F),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 9),
            Text(
              text,
              style: const TextStyle(
                fontSize: 13.5,
                height: 1.7,
                color: Color(0xFF263B34),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TakeawayCard extends StatelessWidget {
  final String text;

  const _TakeawayCard({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF5EF),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFB9DDC8)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.check_circle_outline,
            color: Color(0xFF159447),
          ),
          const SizedBox(width: 9),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 13.5,
                height: 1.6,
                fontWeight: FontWeight.w600,
                color: Color(0xFF23463A),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FinalReminderCard extends StatelessWidget {
  const _FinalReminderCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF123F35),
        borderRadius: BorderRadius.circular(17),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Leadership Principle',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w900,
            ),
          ),
          SizedBox(height: 7),
          Text(
            'A strong HSE policy becomes credible when management decisions, '
            'resources and behaviour consistently support safe work. Leadership '
            'should be visible at the workface and measurable through evidence, '
            'not only through documents.',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 13,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}

class DubaiHsePolicyLeadershipAdvancedPage extends StatelessWidget {
  const DubaiHsePolicyLeadershipAdvancedPage({super.key});

  static const Color primary = Color(0xFF0B6B4F);
  static const Color background = Color(0xFFF5F8F6);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: const Text('Advanced Learning'),
        backgroundColor: primary,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(14, 16, 14, 30),
        children: [
          const _AdvancedIntro(),
          const SizedBox(height: 14),
          for (int i = 0; i < _advancedModules.length; i++) ...[
            _AdvancedModuleTile(
              number: i + 1,
              module: _advancedModules[i],
            ),
            const SizedBox(height: 9),
          ],
          const _AdvancedClosing(),
        ],
      ),
    );
  }
}

class _AdvancedIntro extends StatelessWidget {
  const _AdvancedIntro();

  @override
  Widget build(BuildContext context) {
    return const Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: EdgeInsets.all(17),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.auto_stories_outlined,
              color: Color(0xFF0B6B4F),
              size: 34,
            ),
            SizedBox(height: 8),
            Text(
              'Advanced HSE Policy & Leadership Reference',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: Color(0xFF0B6B4F),
              ),
            ),
            SizedBox(height: 7),
            Text(
              'This section goes deeper into how leadership is planned, '
              'implemented, verified and improved across a construction project.',
              style: TextStyle(
                fontSize: 13.5,
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AdvancedModuleTile extends StatelessWidget {
  final int number;
  final _AdvancedModule module;

  const _AdvancedModuleTile({
    required this.number,
    required this.module,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 0.6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
        childrenPadding: const EdgeInsets.fromLTRB(15, 0, 15, 16),
        leading: CircleAvatar(
          radius: 20,
          backgroundColor: const Color(0xFFE8F4ED),
          child: Text(
            number.toString().padLeft(2, '0'),
            style: const TextStyle(
              color: Color(0xFF0B6B4F),
              fontSize: 12,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        title: Text(
          module.title,
          style: const TextStyle(
            fontSize: 14.5,
            fontWeight: FontWeight.w800,
            color: Color(0xFF173C31),
          ),
        ),
        subtitle: Text(
          module.summary,
          style: const TextStyle(
            fontSize: 11.5,
            height: 1.3,
          ),
        ),
        children: [
          const Divider(height: 1),
          const SizedBox(height: 10),
          for (final item in module.items) ...[
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                item.title,
                style: const TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF0B6B4F),
                ),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              item.body,
              style: const TextStyle(
                fontSize: 13,
                height: 1.65,
              ),
            ),
            const SizedBox(height: 11),
          ],
        ],
      ),
    );
  }
}

class _AdvancedClosing extends StatelessWidget {
  const _AdvancedClosing();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 8),
      child: Text(
        'Professional principle: leadership should create the conditions in '
        'which safe work is planned, resourced, understood, supervised and '
        'continuously improved.',
        style: TextStyle(
          fontSize: 13.5,
          height: 1.65,
          fontWeight: FontWeight.w700,
          color: Color(0xFF0B6B4F),
        ),
      ),
    );
  }
}

class _PolicySection {
  final String title;
  final String explanation;
  final String application;
  final String verification;
  final String evidence;
  final String leadership;
  final String takeaway;

  const _PolicySection({
    required this.title,
    required this.explanation,
    required this.application,
    required this.verification,
    required this.evidence,
    required this.leadership,
    required this.takeaway,
  });
}

class _AdvancedModule {
  final String title;
  final String summary;
  final List<_AdvancedItem> items;

  const _AdvancedModule({
    required this.title,
    required this.summary,
    required this.items,
  });
}

class _AdvancedItem {
  final String title;
  final String body;

  const _AdvancedItem(this.title, this.body);
}

const List<_PolicySection> _policySections = [
  _PolicySection(
    title: 'HSE Policy — Meaning & Purpose',
    explanation:
        'An HSE policy is the organisation’s formal statement of intent and '
        'direction regarding health, safety and environmental performance. '
        'It establishes the principles that management expects the organisation '
        'to follow and provides a foundation for objectives, responsibilities, '
        'planning and operational controls. A professional policy should be '
        'understood as a commitment that influences decisions, rather than as '
        'a document displayed on a notice board only. Its purpose is to establish '
        'a consistent expectation that hazards will be identified, risks will be '
        'controlled, applicable requirements will be addressed and HSE performance '
        'will be improved.',
    application:
        'On a construction project, the policy should be translated into '
        'project objectives, responsibilities, procedures and workface controls. '
        'For example, a commitment to prevent harm should be visible in the way '
        'high-risk activities are planned, how competent people are assigned, how '
        'equipment is maintained and how unsafe conditions are corrected. Workers '
        'should be able to recognise the connection between the policy and their '
        'daily toolbox talks, permits, inspections and reporting arrangements.',
    verification:
        'The HSE Officer should check whether the policy is current, approved, '
        'communicated and reflected in the project HSE arrangements. Verification '
        'should go beyond checking a signature. Interviews with supervisors and '
        'workers can help determine whether people understand the main commitments '
        'and whether management behaviour is consistent with them.',
    evidence:
        'Typical evidence may include the approved HSE policy, communication '
        'records, induction material, toolbox-talk references, project objectives, '
        'management review records and evidence of leadership activities.',
    leadership:
        'Management should demonstrate that the policy influences real decisions '
        'about people, resources, planning, time, equipment and work restrictions.',
    takeaway:
        'A policy becomes credible when workers can see its commitments reflected '
        'in everyday project decisions and controls.',
  ),
  _PolicySection(
    title: 'Policy Development',
    explanation:
        'Policy development should reflect the organisation’s activities, risk '
        'profile, legal and client context and overall HSE direction. A useful '
        'policy is clear enough to guide behaviour while remaining broad enough '
        'to apply across the organisation. It should address commitment to '
        'prevention, compliance with applicable requirements, consultation and '
        'continual improvement where appropriate. Development should involve '
        'appropriate management input and should consider lessons from previous '
        'performance, incidents and operational experience.',
    application:
        'For a construction business, policy development should consider the '
        'actual hazards associated with construction, subcontracting, plant, '
        'temporary works, lifting, work at height, excavation, electrical work, '
        'environmental impacts and worker welfare. The policy should not promise '
        'controls that the organisation cannot realistically implement. Its '
        'commitments should be supported by procedures, competent personnel and '
        'resources at project level.',
    verification:
        'Check approval, issue status, review arrangements, communication and '
        'alignment with the organisation’s activities. Ask whether the policy '
        'commitments are supported by measurable objectives and practical systems.',
    evidence:
        'Policy revision history, approval record, consultation records where '
        'applicable, controlled distribution records and linked HSE objectives.',
    leadership:
        'Senior management should own the policy direction and make sure its '
        'commitments are realistic, relevant and supported.',
    takeaway:
        'A good policy is relevant to the work and connected to the management '
        'system that implements it.',
  ),
  _PolicySection(
    title: 'Management Commitment',
    explanation:
        'Management commitment means more than approving an HSE policy. It means '
        'actively providing the conditions necessary for safe work and making HSE '
        'part of normal business decisions. Commitment can be demonstrated through '
        'resources, competent staffing, planning time, equipment, training, '
        'leadership visits, response to serious findings and support for corrective '
        'actions. Strong commitment is especially important when production pressure '
        'or schedule constraints could otherwise encourage unsafe shortcuts.',
    application:
        'On site, management commitment may be visible when a manager delays a '
        'task until a critical control is installed, provides additional competent '
        'supervision for high-risk work, approves necessary lifting resources or '
        'supports a worker who raises a genuine safety concern. These decisions '
        'show the workforce that safety requirements are not optional when work '
        'becomes difficult.',
    verification:
        'Review management actions, site-visit records, action close-out, resource '
        'decisions and responses to significant HSE issues. Compare what management '
        'says with what the project actually receives and implements.',
    evidence:
        'Management meeting minutes, site-visit records, action trackers, training '
        'resources, procurement records, staffing arrangements and close-out evidence.',
    leadership:
        'Leaders should remove barriers to safe execution and demonstrate that '
        'critical controls will be protected even under delivery pressure.',
    takeaway:
        'Management commitment is measured by decisions and actions, not only by signatures.',
  ),
  _PolicySection(
    title: 'Leadership Responsibilities',
    explanation:
        'Leadership responsibilities should be clearly understood at each level '
        'of the organisation. Senior leaders establish direction and resources; '
        'project management integrates HSE into delivery; supervisors control the '
        'workface; and HSE professionals provide advice, monitoring and assurance. '
        'Clear responsibility prevents important controls from being assumed to '
        'belong to somebody else. Authority should accompany responsibility so that '
        'people can act when an unsafe condition is identified.',
    application:
        'A construction project should define who approves plans, who controls '
        'daily work, who verifies critical controls, who manages subcontractors, '
        'who investigates incidents and who escalates serious risks. For a lifting '
        'operation, for example, responsibilities should be clear for planning, '
        'equipment readiness, competent personnel, exclusion zones, supervision '
        'and emergency response.',
    verification:
        'Check the organisation chart, role descriptions, project HSE plan and '
        'actual workface understanding. Interview supervisors and workers to see '
        'whether they know who has authority for their task and how to escalate concerns.',
    evidence:
        'Organisation chart, responsibility matrix, appointment letters, project '
        'HSE plan, delegation records and meeting minutes.',
    leadership:
        'Leaders should make accountability clear and avoid creating gaps or '
        'overlapping responsibilities.',
    takeaway:
        'Every important HSE responsibility should have a clearly identified owner and escalation route.',
  ),
  _PolicySection(
    title: 'HSE Objectives & Targets',
    explanation:
        'HSE objectives translate policy commitments into planned results. Objectives '
        'should be relevant to the project’s risks and should help management measure '
        'whether the system is moving in the intended direction. A balanced approach '
        'can include leading indicators such as critical-control verification, training '
        'completion or action closure as well as appropriate lagging indicators such '
        'as incident performance. Targets should encourage improvement without creating '
        'pressure to hide reporting.',
    application:
        'A project may establish objectives for completion of planned inspections, '
        'critical-risk reviews, training, emergency drills, corrective-action closure '
        'and worker engagement. The project should ensure that targets are meaningful '
        'and that quality is not sacrificed for a numerical result. For example, '
        'closing an action should mean the risk is actually controlled, not simply '
        'that a form is marked complete.',
    verification:
        'Check whether objectives are documented, assigned, monitored and reviewed. '
        'Look for evidence that management responds when performance is below expectation.',
    evidence:
        'HSE objectives register, KPI dashboard, action plans, monthly reports and management review records.',
    leadership:
        'Management should set realistic objectives and provide the resources needed to achieve them.',
    takeaway:
        'Good targets measure useful HSE performance and encourage genuine improvement.',
  ),
  _PolicySection(
    title: 'Roles and Accountability',
    explanation:
        'Roles describe what people are expected to do; accountability establishes '
        'that responsibilities must be fulfilled and followed up. HSE accountability '
        'should exist within line management as well as within the HSE function. HSE '
        'personnel advise, facilitate, monitor and verify, but they should not become '
        'the only people responsible for controlling operational risks. Safe execution '
        'requires ownership by the people who plan and supervise the work.',
    application:
        'On a site, a supervisor should be accountable for implementing the approved '
        'method at the workface, while the HSE team verifies and advises. Project '
        'management should ensure that supervisors have enough people, equipment, '
        'time and authority to fulfil those responsibilities. When an issue is '
        'repeated, accountability should focus on why the system allowed it to continue.',
    verification:
        'Review action ownership, overdue findings, responsibility matrices and '
        'interviews with line management. Repeated unresolved findings can indicate '
        'an accountability weakness.',
    evidence:
        'Responsibility matrix, action register, meeting minutes, inspection reports and escalation records.',
    leadership:
        'Leaders should hold the right people accountable while providing support to fix system weaknesses.',
    takeaway:
        'HSE accountability belongs throughout the organisation, not only within the HSE department.',
  ),
  _PolicySection(
    title: 'Resource Allocation',
    explanation:
        'Safe work requires appropriate resources. These include competent people, '
        'equipment, protective systems, training, supervision, emergency resources, '
        'time for planning and suitable welfare arrangements. Resource allocation '
        'should be based on risk rather than simply on equal distribution. Higher-risk '
        'activities may require stronger engineering controls, additional supervision '
        'or specialist competence.',
    application:
        'If a project plans complex lifting, management should ensure suitable lifting '
        'equipment, competent lifting personnel, planning resources, ground preparation, '
        'communication and exclusion arrangements are available. If a task cannot be '
        'performed safely with the resources currently available, leadership should '
        'support delaying or changing the work rather than forcing an unsafe solution.',
    verification:
        'Check staffing levels, equipment availability, training arrangements, welfare '
        'resources and whether critical controls were delayed because of resource limitations.',
    evidence:
        'Manpower plans, procurement records, equipment registers, training budgets, '
        'inspection records and project resource plans.',
    leadership:
        'Management should treat resources required for critical controls as part of project delivery.',
    takeaway:
        'A safety commitment without adequate resources cannot reliably become a field control.',
  ),
  _PolicySection(
    title: 'Legal Commitment',
    explanation:
        'An HSE policy commonly includes a commitment to comply with applicable legal '
        'and other requirements. This commitment must be supported by a process for '
        'identifying which requirements apply to the organisation and project. Legal '
        'compliance should not depend on memory or an old document. Requirements may '
        'also include authority conditions, client requirements and approved project '
        'arrangements where applicable.',
    application:
        'The project should maintain an appropriate compliance process and make relevant '
        'requirements available to responsible personnel. When a regulatory question '
        'arises, the team should verify the current applicable source before treating '
        'a statement as a formal compliance conclusion.',
    verification:
        'Check the compliance register, assigned responsibilities, evaluation records '
        'and evidence of actions taken for identified gaps. Confirm that controlled '
        'sources are current.',
    evidence:
        'Compliance register, legal evaluations, authority correspondence, client '
        'requirements and corrective-action records.',
    leadership:
        'Leadership should provide competent support and time for compliance obligations '
        'and should not treat regulatory verification as a last-minute activity.',
    takeaway:
        'A legal commitment needs a controlled process that identifies, implements and verifies applicable requirements.',
  ),
  _PolicySection(
    title: 'Worker Consultation',
    explanation:
        'Worker consultation gives people who perform the work an opportunity to '
        'contribute practical knowledge about hazards, controls and changes. Workers '
        'often understand small operational difficulties that are not obvious from '
        'documents. Meaningful consultation is more than asking for a signature; it '
        'requires listening, responding and communicating what happened after concerns '
        'were raised.',
    application:
        'Before a high-risk activity, supervisors can ask workers about access, tools, '
        'sequence, environmental conditions and practical difficulties. Toolbox talks, '
        'pre-task discussions, safety committees and observation programmes can provide '
        'structured opportunities for participation. If a worker identifies a control '
        'that is impractical, management should evaluate the concern rather than simply '
        'insisting on paperwork compliance.',
    verification:
        'Interview workers and review consultation records. Check whether worker suggestions '
        'lead to actions or feedback and whether participation includes different work groups.',
    evidence:
        'Toolbox records, meeting minutes, worker feedback records, safety committee '
        'records and action trackers.',
    leadership:
        'Leaders should create an environment where workers can raise concerns without fear of being ignored.',
    takeaway:
        'Consultation is effective when worker knowledge changes or improves the way work is controlled.',
  ),
  _PolicySection(
    title: 'Communication of Policy',
    explanation:
        'The HSE policy must reach the people who are expected to follow its commitments. '
        'Communication should be understandable and appropriate to the workforce, including '
        'subcontractors and other relevant persons. A policy can be communicated through '
        'inductions, briefings, notice boards, digital systems, meetings and leadership '
        'discussions, but communication should focus on understanding rather than only '
        'distribution.',
    application:
        'At project level, the policy can be introduced during mobilisation and induction '
        'and reinforced during toolbox talks or management campaigns. Supervisors should '
        'be able to explain how the policy connects to current site controls. Where the '
        'workforce includes people with different languages or literacy levels, the project '
        'should use communication methods that achieve genuine understanding.',
    verification:
        'Ask workers to explain the key HSE commitments in their own words and compare '
        'their understanding with the policy. Review communication records and induction content.',
    evidence:
        'Induction records, toolbox material, displayed policy, communication campaigns and briefing records.',
    leadership:
        'Leaders should communicate the policy consistently and demonstrate it through their own behaviour.',
    takeaway:
        'A communicated policy should be understood and visible in work practices, not merely displayed.',
  ),
  _PolicySection(
    title: 'Implementation',
    explanation:
        'Implementation is the stage where policy commitments are converted into procedures, '
        'plans, resources and field controls. This includes establishing the HSE organisation, '
        'risk-management process, training arrangements, operational controls, inspections, '
        'emergency arrangements and reporting systems. Implementation should be planned and '
        'monitored so that important elements do not remain incomplete.',
    application:
        'During project mobilisation, management should establish the HSE plan, responsibilities, '
        'risk assessments, RAMS, PTW arrangements where required, emergency resources, welfare, '
        'training and inspection programmes before significant exposure occurs. As activities '
        'change, the implementation arrangements should change with them.',
    verification:
        'Use mobilisation checklists, field inspections, document reviews and worker interviews '
        'to determine whether the system exists in practice. Pay special attention to high-risk activities.',
    evidence:
        'Project HSE plan, procedures, RAMS, permits, training records, inspection reports and emergency plans.',
    leadership:
        'Management should actively remove implementation barriers and ensure planned systems are resourced.',
    takeaway:
        'Implementation proves whether the policy has been converted into a functioning management system.',
  ),
  _PolicySection(
    title: 'Monitoring',
    explanation:
        'Monitoring provides information about HSE performance and whether controls are being '
        'implemented. It can include inspections, observations, audits, KPI review, critical-control '
        'verification, worker feedback and incident trends. Monitoring should be planned and should '
        'focus on meaningful evidence rather than producing large volumes of paperwork.',
    application:
        'A construction project can monitor high-risk work fronts daily, review corrective actions '
        'weekly and analyse trends monthly. If repeated findings occur around lifting, housekeeping '
        'or work at height, management should investigate why the problem continues instead of only '
        'increasing the number of inspections.',
    verification:
        'Check whether monitoring activities are completed, findings are analysed and management responds '
        'to significant trends. Verify that inspection quality is adequate and not simply checklist completion.',
    evidence:
        'Inspection reports, observation records, KPI reports, trend analysis, audit reports and action trackers.',
    leadership:
        'Leaders should use monitoring information to make decisions and allocate resources.',
    takeaway:
        'Monitoring is valuable when information leads to decisions, correction and improvement.',
  ),
  _PolicySection(
    title: 'Review & Revision',
    explanation:
        'An HSE policy should remain suitable for the organisation and its changing context. '
        'Review may be planned at defined intervals and should also occur when there are significant '
        'changes in activities, organisation, legal requirements, risk profile or lessons from incidents. '
        'Revision should be controlled so people do not continue using obsolete versions.',
    application:
        'If a contractor expands into new construction activities, experiences a serious incident or '
        'faces significant changes in applicable requirements, management should evaluate whether the '
        'policy and supporting arrangements remain suitable. Revisions should be communicated to affected '
        'personnel and reflected in the management system.',
    verification:
        'Check revision history, approval, review dates, change triggers and evidence that updated commitments '
        'were communicated and implemented.',
    evidence:
        'Controlled policy, revision history, review minutes, approval records and communication evidence.',
    leadership:
        'Senior management should own the review process and approve meaningful changes.',
    takeaway:
        'A controlled review process keeps the policy relevant as the organisation and risk profile change.',
  ),
  _PolicySection(
    title: 'Leadership Site Visits',
    explanation:
        'Leadership site visits are an opportunity for management to understand real work conditions, '
        'listen to workers and verify whether critical controls are functioning. A useful leadership visit '
        'is not simply a walk-through for photographs. Leaders should focus on significant risks, ask practical '
        'questions, recognise good controls and ensure important issues receive appropriate follow-up.',
    application:
        'During a visit, a project manager may review a lifting area, excavation, work-at-height activity or '
        'traffic interface and ask the team what could go wrong, what the critical controls are and what would '
        'cause work to stop. The leader should avoid undermining the supervisor and instead use the visit to '
        'reinforce safe planning and escalation.',
    verification:
        'Review the quality of leadership visits, issues identified, actions raised and whether previous actions '
        'were effectively closed. Speak with workers to see whether leadership engagement is meaningful.',
    evidence:
        'Leadership walk records, photographs where appropriate, action registers and management meeting minutes.',
    leadership:
        'Leaders should use site visits to learn and act, not merely to demonstrate presence.',
    takeaway:
        'Visible leadership is strongest when site visits lead to useful conversations and timely decisions.',
  ),
  _PolicySection(
    title: 'Safety Culture',
    explanation:
        'Safety culture describes the shared attitudes, behaviours and expectations that influence how people '
        'treat HSE in everyday work. A positive culture supports reporting, learning, consultation and consistent '
        'control of risk. Culture is influenced strongly by management behaviour, supervisor actions, workload, '
        'communication and how the organisation responds to mistakes and concerns.',
    application:
        'On site, culture can be observed in whether workers report hazards, whether supervisors respond to concerns, '
        'whether permits are treated seriously and whether production pressure causes controls to be bypassed. A strong '
        'culture encourages people to stop and ask when conditions are unclear and supports learning from near misses.',
    verification:
        'Use interviews, observations, reporting trends, worker feedback and management behaviour to assess culture. '
        'Be cautious about relying on a zero-incident number alone as proof of a strong culture.',
    evidence:
        'Worker feedback, observation trends, near-miss reports, engagement records, leadership activities and action closure.',
    leadership:
        'Leaders shape culture through what they reward, tolerate, question and act upon.',
    takeaway:
        'Culture is built through repeated behaviour and decisions, especially when work becomes difficult.',
  ),
  _PolicySection(
    title: 'Leading by Example',
    explanation:
        'Leading by example means that leaders follow the same essential HSE expectations they ask others to follow. '
        'When managers ignore PPE, enter restricted areas, bypass controls or pressure teams to continue unsafe work, '
        'the workforce receives a stronger message from behaviour than from policy statements. Consistency therefore '
        'matters greatly to leadership credibility.',
    application:
        'A manager entering a construction area should comply with site access and PPE requirements, respect exclusion '
        'zones and avoid asking workers to bypass controls for convenience. If a leader supports a stop-work decision '
        'when a critical control is missing, the action demonstrates the organisation’s real priorities.',
    verification:
        'Observe management behaviour during site visits and meetings. Review whether leaders challenge unsafe conditions '
        'and follow project rules consistently.',
    evidence:
        'Leadership observations, site-visit records, management meeting actions and worker feedback.',
    leadership:
        'The safest leadership message is often demonstrated through the leader’s own behaviour.',
    takeaway:
        'Workers judge leadership credibility by what leaders actually do when safety and delivery pressures meet.',
  ),
  _PolicySection(
    title: 'Contractor Leadership',
    explanation:
        'Contractor leadership is essential because subcontractors may bring different systems, experience levels and '
        'working practices into the project. The principal project team should establish clear HSE expectations and '
        'coordinate them with contractor arrangements. Contractor management should continue throughout the work, not '
        'end after document approval or mobilisation.',
    application:
        'Before subcontractor work starts, the project should establish competence expectations, review relevant RAMS, '
        'coordinate interfaces and communicate emergency and reporting arrangements. During execution, contractor '
        'performance should be monitored through inspections, meetings, observations and corrective actions. Poor performance '
        'should be escalated through the agreed management process.',
    verification:
        'Check contractor induction, competency, RAMS review, inspections, meetings, action closure and field performance. '
        'Compare documentation with actual workface conditions.',
    evidence:
        'Prequalification records, competency records, RAMS approvals, coordination meetings, audits and action trackers.',
    leadership:
        'Project leadership should set consistent expectations and ensure contractors are integrated into the HSE system.',
    takeaway:
        'Contractor leadership means managing actual performance, not simply collecting contractor documents.',
  ),
  _PolicySection(
    title: 'Emergency Leadership',
    explanation:
        'During an emergency, leadership must provide clear coordination, decision-making and communication. Emergency '
        'leadership should be planned before an event occurs because confusion about authority can delay evacuation, rescue '
        'or escalation. Leaders should understand the project emergency plan, credible scenarios, communication routes and '
        'the responsibilities of key personnel.',
    application:
        'For a fire, serious injury, collapse or other credible emergency, management should support immediate protective '
        'action, ensure emergency arrangements are activated and coordinate with the responsible site team and external '
        'services as applicable. Production priorities should not interfere with life-safety decisions.',
    verification:
        'Review emergency plans, drills, leadership participation, lessons learned and corrective actions. Check whether '
        'responsible persons understand their roles and whether access routes and emergency resources are maintained.',
    evidence:
        'Emergency plans, drill reports, attendance records, action trackers and emergency communication records.',
    leadership:
        'Emergency leadership should prioritise life safety, clear communication and coordinated response.',
    takeaway:
        'Good emergency leadership is prepared before the emergency and decisive when the event occurs.',
  ),
  _PolicySection(
    title: 'Common Leadership Failures',
    explanation:
        'Common failures include having a policy without implementation, focusing only on lagging statistics, ignoring '
        'repeated findings, providing insufficient resources, tolerating shortcuts, failing to close actions, poor worker '
        'consultation and treating HSE as the responsibility of the HSE department alone. These weaknesses can create a gap '
        'between the stated management system and the actual workface.',
    application:
        'If the same work-at-height finding appears repeatedly, leadership should ask why the system has not prevented recurrence. '
        'Possible causes may include unsuitable equipment, poor planning, insufficient supervision, weak procurement or unclear '
        'responsibility. Simply issuing another reminder to workers may not address the real cause.',
    verification:
        'Look for recurring findings, overdue actions, high turnover, repeated permit errors, low-quality risk assessments '
        'and evidence that resources are consistently insufficient. Compare management statements with field conditions.',
    evidence:
        'Trend reports, audit findings, action registers, incident investigations, resource records and management reviews.',
    leadership:
        'Leaders should address system weaknesses rather than repeatedly blaming individual workers for recurring problems.',
    takeaway:
        'Repeated HSE problems are often signals that leadership or system controls need improvement.',
  ),
  _PolicySection(
    title: 'Practical Construction-Site Examples',
    explanation:
        'Leadership becomes easier to understand when connected to real work. A project may face decisions involving '
        'lifting, excavation, scaffolding, work at height, temporary works, electrical work, traffic, hot work or heat exposure. '
        'In each case, leadership affects whether sufficient planning, competent people, equipment and time are provided before '
        'workers are exposed.',
    application:
        'For example, if an excavation protection system is not ready, effective leadership supports stopping the excavation '
        'activity until the required protection and inspection arrangements are established. For a complex lift, leadership '
        'supports proper planning and resources rather than allowing the team to improvise because the crane is already mobilised.',
    verification:
        'Select actual high-risk activities and compare management expectations with field conditions. Review whether critical '
        'controls were planned, resourced and verified before work started.',
    evidence:
        'RAMS, permits, inspection records, lifting plans, excavation inspections, toolbox records and corrective actions.',
    leadership:
        'Leaders should make safe execution possible before asking the workforce to perform the task.',
    takeaway:
        'Real leadership is demonstrated through practical decisions at high-risk work fronts.',
  ),
  _PolicySection(
    title: 'HSE Officer Verification',
    explanation:
        'The HSE Officer provides independent field verification and professional advice within the project structure. '
        'Verification should test whether policy commitments and management arrangements are visible in actual work. The HSE '
        'Officer should identify gaps, communicate risks, support corrective action and escalate serious uncontrolled conditions.',
    application:
        'During inspections, the HSE Officer can compare the project HSE plan and approved RAMS with actual work conditions. '
        'If a critical control is missing, the officer should communicate the risk and follow the approved escalation and stop-work '
        'process where applicable. The officer should also verify that corrective actions are genuinely effective.',
    verification:
        'Use document review, field observation, interviews and evidence sampling. Check whether management receives useful '
        'information and whether significant findings are escalated appropriately.',
    evidence:
        'Inspection reports, observations, audit reports, photographs where appropriate, action registers and escalation records.',
    leadership:
        'Management should support HSE professionals when they raise legitimate concerns and should act on significant evidence.',
    takeaway:
        'HSE verification should test reality at the workface, not just paperwork compliance.',
  ),
  _PolicySection(
    title: 'Supervisor Application',
    explanation:
        'Supervisors convert management expectations into daily control of work. They are responsible for confirming that '
        'workers, equipment, materials, access, permits and controls are ready and for monitoring the task while it proceeds. '
        'A supervisor is also an important communication link between management and the workforce.',
    application:
        'Before a shift, the supervisor should review the planned work, discuss changes, brief the team and confirm critical '
        'controls. During the activity, the supervisor should watch for changed conditions, unsafe practices and interface risks. '
        'When a condition cannot be controlled immediately, the supervisor should escalate rather than allowing the team to improvise.',
    verification:
        'Observe supervisors during planning and work execution. Check briefing quality, field presence, corrective action and '
        'response to changes.',
    evidence:
        'Pre-task briefings, toolbox talks, permits, inspection records, action records and supervisor checklists where used.',
    leadership:
        'Supervisors demonstrate leadership through consistent control, communication and timely intervention.',
    takeaway:
        'The supervisor is one of the most important links between policy and actual work.',
  ),
  _PolicySection(
    title: 'Worker Expectations',
    explanation:
        'Workers are expected to follow applicable safe-work requirements, use controls correctly, participate in briefings, '
        'report hazards and raise concerns when work cannot be performed safely. Workers also contribute valuable practical '
        'knowledge and should be treated as active participants in the HSE system rather than as passive recipients of instructions.',
    application:
        'A worker who notices a damaged tool, missing barrier, unexpected service or changed work condition should report it and '
        'seek clarification before continuing. Workers should not remove or bypass critical controls for convenience and should '
        'support colleagues by reporting conditions that could affect others.',
    verification:
        'Interview workers about their understanding of the task, controls, reporting route and stop-work arrangements. Observe '
        'whether workers actually use the controls discussed during briefings.',
    evidence:
        'Induction records, toolbox attendance, competency evidence, hazard reports, near-miss reports and worker feedback.',
    leadership:
        'Leadership should create conditions where workers can raise concerns and receive a constructive response.',
    takeaway:
        'Worker expectations are strongest when the organisation provides clear instructions, suitable controls and a safe reporting culture.',
  ),
  _PolicySection(
    title: 'Evidence / Records',
    explanation:
        'Evidence demonstrates whether leadership commitments and HSE arrangements have been implemented. Records should be '
        'accurate, traceable and relevant to the activity. A large number of documents does not automatically indicate a strong '
        'system; evidence should help show what was planned, what was communicated, what was checked and what was corrected.',
    application:
        'For example, management commitment may be supported by site-visit records and action close-out; worker consultation '
        'by meeting and toolbox records; competence by training and authorisation evidence; and operational leadership by inspection '
        'and corrective-action records. The project should avoid creating records that nobody uses.',
    verification:
        'Sample records against actual field conditions. Check dates, responsible persons, status, signatures or approvals where '
        'required and evidence of effective closure.',
    evidence:
        'Policies, plans, objectives, minutes, inspections, audits, training records, action registers and communication records.',
    leadership:
        'Leaders should value accurate evidence and avoid encouraging paperwork completion that hides real weaknesses.',
    takeaway:
        'Good records provide reliable evidence of real management activity and field control.',
  ),
  _PolicySection(
    title: 'Audit Points',
    explanation:
        'Audits of HSE policy and leadership should examine whether commitments are established, communicated, implemented and '
        'reviewed. Auditors may examine documents, interview people and observe field conditions. The audit should test effectiveness, '
        'not merely the presence of a policy.',
    application:
        'An audit can sample a management site visit, trace one corrective action from finding to closure, interview a supervisor '
        'about HSE objectives and observe a high-risk work front. This approach helps identify gaps between system documentation '
        'and field implementation.',
    verification:
        'Check policy approval, communication, objectives, management involvement, worker consultation, resource allocation, '
        'action follow-up and evidence that significant findings reach management review.',
    evidence:
        'Audit reports, sampled records, interview notes, field observations and corrective-action evidence.',
    leadership:
        'Leadership should treat audit findings as opportunities to strengthen the system rather than as paperwork problems.',
    takeaway:
        'A useful audit asks whether leadership commitments actually influence work and results.',
  ),
  _PolicySection(
    title: 'KPI Connection',
    explanation:
        'Leadership should use HSE performance information to understand whether the management system is effective. KPIs can '
        'include leading and lagging measures, but numbers should be interpreted in context. A low incident count alone does not '
        'prove that leadership is strong, especially if reporting is weak. Useful indicators should support learning and decision-making.',
    application:
        'Management can review trends in critical-control verification, training, inspections, action closure, near-miss reporting, '
        'audit findings and significant incidents. If one project has many reports because workers actively report hazards, management '
        'should examine the quality and response rather than automatically treating higher reporting as poor performance.',
    verification:
        'Check whether KPIs are reviewed by management, whether trends are analysed and whether actions result from the information. '
        'Look for evidence that data quality is considered.',
    evidence:
        'Dashboards, monthly HSE reports, trend charts, management review minutes and action plans.',
    leadership:
        'Leaders should use KPIs as decision-support information, not as a reason to discourage reporting.',
    takeaway:
        'Good KPI use connects HSE information to management decisions and improvement.',
  ),
  _PolicySection(
    title: 'Corrective Actions',
    explanation:
        'Corrective actions respond to identified nonconformities, unsafe conditions, incidents, audit findings or system weaknesses. '
        'Effective corrective action controls the immediate risk and, where necessary, addresses the reason the problem occurred. '
        'Actions should have clear ownership and realistic completion requirements, followed by verification of effectiveness.',
    application:
        'If repeated scaffold access findings occur, the project should examine whether the cause is poor inspection, equipment '
        'availability, design, supervision or worker understanding. A corrective action might require a system-level improvement rather '
        'than another reminder. The final closure should verify that the improvement is working at the workface.',
    verification:
        'Review action descriptions, owners, due dates, immediate controls and closure evidence. Check whether repeated findings '
        'return after closure.',
    evidence:
        'Corrective-action register, photographs where appropriate, revised procedures, training records and verification records.',
    leadership:
        'Management should ensure important actions receive the resources and attention necessary for effective closure.',
    takeaway:
        'Corrective action is complete only when the identified risk has been properly controlled and recurrence is addressed where necessary.',
  ),
  _PolicySection(
    title: 'Stop-Work Authority',
    explanation:
        'Stop-work authority is a practical mechanism for preventing exposure when critical controls are missing or conditions '
        'become unsafe. The exact authority and escalation process should follow the approved project arrangements. The principle is '
        'that work should not continue simply because a schedule is important when a serious uncontrolled risk exists.',
    application:
        'Examples may include an uncontrolled suspended-load zone, inadequate excavation protection, serious electrical exposure, '
        'missing fall protection or a required permit/control not being in place. The affected work should be made safe, the issue '
        'communicated and the required controls verified before restart.',
    verification:
        'Check whether workers and supervisors know how to stop or escalate unsafe work and whether previous stop-work events were '
        'handled constructively. Review restart controls and lessons learned.',
    evidence:
        'Stop-work reports, incident/observation records, corrective actions, toolbox communications and management review records.',
    leadership:
        'Leaders must support appropriate stop-work decisions and avoid creating pressure that discourages intervention.',
    takeaway:
        'Stop-work authority is credible only when people know it, can use it and are supported after using it appropriately.',
  ),
  _PolicySection(
    title: 'Quick Checklist',
    explanation:
        'A leadership checklist provides a quick field-level review of whether the main policy and leadership principles are visible. '
        'It should be used as a prompt rather than a replacement for professional judgement. The checklist should cover policy status, '
        'objectives, responsibilities, resources, communication, worker engagement, management presence, monitoring and action closure.',
    application:
        'Before or during a management review, ask: Is the policy current? Are objectives understood? Are responsibilities clear? '
        'Are critical controls resourced? Are workers consulted? Is management visible? Are findings closed effectively? Can workers '
        'raise concerns? Are repeated problems being analysed? These questions can quickly identify areas needing deeper review.',
    verification:
        'Use the checklist with evidence sampling. Do not mark an item compliant simply because a document exists; verify implementation '
        'and effectiveness where the requirement is significant.',
    evidence:
        'Policy, objectives, organisation chart, communication records, leadership visits, inspection reports, KPI reports and action registers.',
    leadership:
        'Leadership should use quick checks to identify issues early and trigger deeper review when needed.',
    takeaway:
        'A checklist is most useful when it leads to evidence-based action and continuous improvement.',
  ),
];

const List<_AdvancedModule> _advancedModules = [
  _AdvancedModule(
    title: 'Policy to Workface — Implementation Chain',
    summary: 'Connect policy commitments to actual site controls.',
    items: [
      _AdvancedItem(
        'The chain',
        'Policy should influence objectives; objectives influence planning; planning creates procedures and resources; '
        'procedures and resources support workface controls; monitoring tests those controls; management review drives improvement.',
      ),
      _AdvancedItem(
        'Why the chain matters',
        'A gap at any stage can weaken the system. For example, a strong policy cannot compensate for missing competent supervision '
        'or unsuitable equipment at the workface.',
      ),
    ],
  ),
  _AdvancedModule(
    title: 'Visible Leadership Model',
    summary: 'A practical model for management engagement.',
    items: [
      _AdvancedItem(
        'Observe',
        'Visit the workface and understand the actual task, hazards, interfaces and critical controls.',
      ),
      _AdvancedItem(
        'Ask',
        'Ask workers and supervisors what could go wrong, what controls are critical and what would cause the job to stop.',
      ),
      _AdvancedItem(
        'Act',
        'Support immediate correction, allocate resources and follow important actions through to effective closure.',
      ),
    ],
  ),
  _AdvancedModule(
    title: 'Leadership Under Production Pressure',
    summary: 'Maintain control when schedule pressure increases.',
    items: [
      _AdvancedItem(
        'Decision principle',
        'Production targets should be achieved through safe planning and resource decisions, not by accepting uncontrolled critical risk.',
      ),
      _AdvancedItem(
        'Practical response',
        'When a critical control is missing, pause or control the work, identify the constraint, provide the necessary resource or change '
        'the method and verify the revised arrangement before restart.',
      ),
    ],
  ),
  _AdvancedModule(
    title: 'Worker Engagement Strategy',
    summary: 'Turn consultation into practical improvement.',
    items: [
      _AdvancedItem(
        'Listen',
        'Create regular opportunities for workers to discuss hazards, practical difficulties and proposed improvements.',
      ),
      _AdvancedItem(
        'Respond',
        'Explain what action was taken or why a proposal could not be adopted. Feedback builds trust in the reporting process.',
      ),
    ],
  ),
  _AdvancedModule(
    title: 'Contractor Leadership Framework',
    summary: 'Integrate subcontractors into project HSE leadership.',
    items: [
      _AdvancedItem(
        'Before work',
        'Establish requirements, verify competence, review relevant RAMS and coordinate interfaces.',
      ),
      _AdvancedItem(
        'During work',
        'Monitor field performance, attend coordination meetings, verify critical controls and escalate recurring weaknesses.',
      ),
      _AdvancedItem(
        'Improvement',
        'Use contractor findings and lessons to strengthen project-wide controls rather than treating each contractor problem in isolation.',
      ),
    ],
  ),
  _AdvancedModule(
    title: 'Leadership Evidence Review',
    summary: 'Test leadership using objective evidence.',
    items: [
      _AdvancedItem(
        'Evidence sampling',
        'Trace one management commitment from policy through objectives, implementation, field verification and review.',
      ),
      _AdvancedItem(
        'Reality check',
        'Compare records with worker interviews and actual work conditions. Differences may reveal weaknesses in implementation.',
      ),
    ],
  ),
  _AdvancedModule(
    title: 'HSE Leadership and Risk',
    summary: 'Connect leadership attention to risk significance.',
    items: [
      _AdvancedItem(
        'Risk-based attention',
        'Leadership attention should be strongest where potential consequences are severe or where controls are critical and vulnerable.',
      ),
      _AdvancedItem(
        'Critical controls',
        'Identify controls that must be present before exposure and ensure their verification is built into planning and supervision.',
      ),
    ],
  ),
  _AdvancedModule(
    title: 'Management Review',
    summary: 'Use leadership review to drive system improvement.',
    items: [
      _AdvancedItem(
        'Review inputs',
        'Consider objectives, KPI trends, audits, incidents, near misses, worker feedback, legal changes, corrective actions and significant risks.',
      ),
      _AdvancedItem(
        'Review outputs',
        'Decide what needs to change in resources, objectives, procedures, competence, controls or priorities.',
      ),
    ],
  ),
  _AdvancedModule(
    title: 'Leadership Culture Indicators',
    summary: 'Look beyond incident numbers.',
    items: [
      _AdvancedItem(
        'Positive indicators',
        'Useful indicators may include quality reporting, worker participation, management follow-up, critical-control verification '
        'and timely action on significant findings.',
      ),
      _AdvancedItem(
        'Warning signs',
        'Repeated findings, overdue critical actions, weak worker engagement, uncontrolled production pressure and frequent control bypasses '
        'can indicate a culture or leadership weakness.',
      ),
    ],
  ),
  _AdvancedModule(
    title: 'Professional Field Reference',
    summary: 'A compact leadership approach for daily HSE practice.',
    items: [
      _AdvancedItem(
        'Before work',
        'Know the risk, confirm the method, verify people and resources, establish critical controls and brief the workforce.',
      ),
      _AdvancedItem(
        'During work',
        'Observe conditions, communicate changes, verify critical controls and intervene early.',
      ),
      _AdvancedItem(
        'After work',
        'Record learning, close actions effectively and feed important lessons into future planning.',
      ),
    ],
  ),
];
