import 'package:flutter/material.dart';

class DubaiHseManagementAdvancedLearningPage extends StatelessWidget {
  const DubaiHseManagementAdvancedLearningPage({super.key});

  static const Color primary = Color(0xFF0B6B4F);
  static const Color accent = Color(0xFF159447);
  static const Color background = Color(0xFFF5F8F6);

  @override
  Widget build(BuildContext context) {
    final modules = <_LearningModule>[
      const _LearningModule(
        number: '01',
        title: 'HSE Management System Basics',
        icon: Icons.account_tree_outlined,
        summary: 'Understand what an HSE management system is, why it is required, and how the elements work together.',
        sections: [
          _LearningSection(
            'What is an HSE Management System?',
            'An HSE Management System is an organised framework used to plan, implement, control, monitor and improve Health, Safety and Environmental performance. It connects leadership, responsibilities, risk management, procedures, competence, operational controls, inspections, incident management and continual improvement into one system.',
          ),
          _LearningSection(
            'Main objectives',
            'The system aims to prevent injury and ill health, control workplace hazards, protect people and property, reduce environmental impacts, meet applicable requirements, define accountability and provide evidence that safety controls are being managed.',
          ),
          _LearningSection(
            'Management-system cycle',
            'A practical way to understand the system is Plan → Do → Check → Act. Plan the work and controls, implement them at the workplace, check performance and compliance, then act on findings and improve the system.',
          ),
        ],
      ),
      const _LearningModule(
        number: '02',
        title: 'HSE Policy & Leadership',
        icon: Icons.policy_outlined,
        summary: 'Learn how management commitment becomes visible action at the project and work-front.',
        sections: [
          _LearningSection(
            'HSE Policy',
            'The policy communicates the organisation commitment to protecting people, complying with applicable requirements, preventing harm and improving HSE performance. It should be communicated to relevant personnel and reflected in project arrangements.',
          ),
          _LearningSection(
            'Leadership responsibilities',
            'Management should provide resources, competent people, suitable equipment, time for planning and authority for corrective action. Leaders should review performance and demonstrate that safety requirements apply to production and schedule decisions.',
          ),
          _LearningSection(
            'Site leadership example',
            'A management site walk should not be only a tour. Leaders should review critical activities, ask workers about hazards and controls, verify corrective actions and remove barriers that prevent safe work.',
          ),
        ],
      ),
      const _LearningModule(
        number: '03',
        title: 'HSE Organisation & Responsibilities',
        icon: Icons.groups_outlined,
        summary: 'Know who owns the risk, who controls the work and who verifies the controls.',
        sections: [
          _LearningSection(
            'Project Management',
            'Provides leadership, resources, project priorities, competent personnel and authority to implement the HSE arrangements.',
          ),
          _LearningSection(
            'HSE Manager / HSE Team',
            'Coordinates the HSE system, advises management, supports risk management, monitors compliance, conducts inspections and audits, reviews incidents and tracks corrective actions.',
          ),
          _LearningSection(
            'Supervisors and Foremen',
            'Implement approved methods at the workface, brief workers, verify controls before starting and intervene when conditions become unsafe or differ from the approved plan.',
          ),
          _LearningSection(
            'Workers',
            'Follow approved procedures, use required controls and PPE, attend required briefings, report hazards and stop or raise concerns when they face uncontrolled risk.',
          ),
        ],
      ),
      const _LearningModule(
        number: '04',
        title: 'Legal & Regulatory Compliance',
        icon: Icons.gavel_outlined,
        summary: 'Build a compliance process without treating a legal register as a document-only exercise.',
        sections: [
          _LearningSection(
            'Compliance process',
            'Identify applicable Dubai and UAE requirements, project requirements and authority conditions; assign responsibility; communicate relevant requirements; verify implementation; record evidence; and review changes when requirements or project conditions change.',
          ),
          _LearningSection(
            'Reference discipline',
            'Always distinguish legislation, authority requirements, technical guidance, client requirements, company procedures and project-specific controls. The applicable requirement should be verified against the current approved source before being treated as a mandatory legal requirement.',
          ),
          _LearningSection(
            'Site verification',
            'A compliance review should ask: What requirement applies? Where is it implemented? Who is responsible? What evidence proves implementation? What happens if the control is not met?',
          ),
        ],
      ),
      const _LearningModule(
        number: '05',
        title: 'Risk Assessment & Risk Control',
        icon: Icons.warning_amber_outlined,
        summary: 'Learn the complete path from hazard identification to verified residual risk.',
        sections: [
          _LearningSection(
            'Risk assessment sequence',
            'Identify the activity, identify hazards, identify people who may be exposed, evaluate risk, select additional controls, assign responsibility, communicate controls, verify implementation and review when conditions change.',
          ),
          _LearningSection(
            'Hierarchy of controls',
            'Use the hierarchy in this order: Elimination, Substitution, Engineering Controls, Administrative Controls and PPE. PPE is important, but it should not be treated as the only control where stronger controls are reasonably available.',
          ),
          _LearningSection(
            'Dynamic review',
            'Reassess when the sequence, equipment, environment, manpower, interfaces or work method changes. A risk assessment is not effective if the document remains unchanged while the actual work changes.',
          ),
        ],
      ),
      const _LearningModule(
        number: '06',
        title: 'HSE Plan & Operational Planning',
        icon: Icons.assignment_outlined,
        summary: 'Convert project requirements into practical work-front arrangements.',
        sections: [
          _LearningSection(
            'HSE Plan content',
            'A project HSE plan can define HSE objectives, organisation, responsibilities, risk-management arrangements, training, inspections, emergency arrangements, incident reporting, environmental controls, contractor management, audits and reporting.',
          ),
          _LearningSection(
            'Work package planning',
            'Before a critical activity starts, verify the approved method, risk assessment, competent personnel, equipment condition, permits where required, exclusion zones, access, emergency arrangements and communication.',
          ),
          _LearningSection(
            'SIMOPS',
            'Simultaneous operations should be planned so that one work activity does not introduce uncontrolled risk to another. Coordinate access, lifting, traffic, overhead work, public interfaces and shared work areas.',
          ),
        ],
      ),
      const _LearningModule(
        number: '07',
        title: 'RAMS / Method Statement',
        icon: Icons.description_outlined,
        summary: 'Understand how a written method becomes a controlled work sequence.',
        sections: [
          _LearningSection(
            'What RAMS should achieve',
            'RAMS should explain the work sequence, hazards, controls, responsibilities, equipment, competency requirements, permits or isolations where applicable, inspection/hold points and emergency arrangements.',
          ),
          _LearningSection(
            'Briefing and understanding',
            'Workers affected by the task should receive the relevant briefing and understand the hazards, controls, sequence and stop-work arrangements. A signed attendance sheet alone does not prove understanding.',
          ),
          _LearningSection(
            'Field verification',
            'Supervisors and HSE personnel should compare the approved method with actual site conditions. If conditions materially change, stop and reassess before continuing.',
          ),
        ],
      ),
      const _LearningModule(
        number: '08',
        title: 'Permit to Work',
        icon: Icons.fact_check_outlined,
        summary: 'Learn PTW as a control system rather than simply a form.',
        sections: [
          _LearningSection(
            'Purpose',
            'A permit system provides formal control and communication for specified higher-risk or controlled activities. The permit should identify the work, location, precautions, authorisation and validity requirements applicable to that task.',
          ),
          _LearningSection(
            'Before work',
            'Verify the correct permit, work boundary, required isolations or tests, competent persons, precautions, communication and site conditions before starting.',
          ),
          _LearningSection(
            'Suspension and closure',
            'Suspend or cancel the permit when conditions are no longer safe or the work changes beyond the authorised conditions. Close the permit according to the project procedure after the work is safely completed.',
          ),
        ],
      ),
      const _LearningModule(
        number: '09',
        title: 'Training, Competency & Toolbox Talks',
        icon: Icons.school_outlined,
        summary: 'Separate attendance, knowledge and demonstrated competence.',
        sections: [
          _LearningSection(
            'Training system',
            'Maintain an appropriate training matrix covering induction, task-specific training, emergency training, required operator or specialist competence and refresher needs.',
          ),
          _LearningSection(
            'Competency',
            'Competency depends on the knowledge, skills, experience and authorisation appropriate to the task. Safety-critical work should be assigned only to people who meet the applicable competency requirements.',
          ),
          _LearningSection(
            'Toolbox Talk',
            'A good toolbox talk is task-specific. Discuss today work, hazards, controls, interfaces, environmental conditions, emergency arrangements and worker questions rather than simply reading a generic sheet.',
          ),
        ],
      ),
      const _LearningModule(
        number: '10',
        title: 'Inspection, Audit & Monitoring',
        icon: Icons.search_outlined,
        summary: 'Learn how to verify that documented controls actually exist in the field.',
        sections: [
          _LearningSection(
            'Inspection',
            'Inspect work fronts, access, housekeeping, equipment, temporary works, barriers, PPE and safety-critical controls at a frequency appropriate to the risk.',
          ),
          _LearningSection(
            'Audit',
            'An audit evaluates whether the management arrangements are established and effective. It should use evidence, interviews, observations and records rather than relying only on documents.',
          ),
          _LearningSection(
            'Finding to closure',
            'Record the finding, assign an owner, define an appropriate action and due date, then verify effectiveness before closure. A closed action should address the actual risk rather than only the paperwork.',
          ),
        ],
      ),
      const _LearningModule(
        number: '11',
        title: 'Incident & Near-Miss Management',
        icon: Icons.report_problem_outlined,
        summary: 'Learn the management flow from immediate response to lessons learned.',
        sections: [
          _LearningSection(
            'Immediate response',
            'Make the area safe, provide appropriate emergency response, raise the alarm and prevent further exposure. Preserve relevant information and evidence where appropriate.',
          ),
          _LearningSection(
            'Investigation',
            'Establish what happened, contributing factors and underlying causes. Avoid stopping at worker blame; examine planning, supervision, equipment, procedures, competence, communication and organisational factors.',
          ),
          _LearningSection(
            'Learning and action',
            'Define corrective actions, assign responsibility, verify implementation and communicate relevant lessons to affected teams. Review whether the same risk exists elsewhere on the project.',
          ),
        ],
      ),
      const _LearningModule(
        number: '12',
        title: 'Emergency Preparedness',
        icon: Icons.emergency_outlined,
        summary: 'Prepare people and systems before an emergency occurs.',
        sections: [
          _LearningSection(
            'Emergency planning',
            'Identify credible emergencies, define alarms and communication, emergency contacts, evacuation arrangements, assembly points, first aid, fire response, rescue arrangements and responsibilities.',
          ),
          _LearningSection(
            'Drills',
            'Drills should test practical response, communication and coordination. Record observations and improve the plan based on identified gaps.',
          ),
          _LearningSection(
            'Restart after emergency',
            'Do not restart affected work simply because the immediate event is over. Reassess hazards, inspect the area, confirm controls and obtain the required authorisation before resuming.',
          ),
        ],
      ),
      const _LearningModule(
        number: '13',
        title: 'Contractor Management',
        icon: Icons.handshake_outlined,
        summary: 'Control risks introduced through contractors and subcontractors.',
        sections: [
          _LearningSection(
            'Prequalification',
            'Review contractor HSE capability, relevant experience, competent personnel, procedures and resources appropriate to the scope before engagement.',
          ),
          _LearningSection(
            'Mobilisation and control',
            'Provide induction, verify RAMS and competency, establish supervision, coordinate permits and monitor contractor performance at the workplace.',
          ),
          _LearningSection(
            'Performance management',
            'Track inspections, observations, incidents, corrective actions and repeated non-conformances. Escalate persistent failures through the project management process.',
          ),
        ],
      ),
      const _LearningModule(
        number: '14',
        title: 'Environmental & Occupational Health',
        icon: Icons.eco_outlined,
        summary: 'Include environmental protection and worker health within the same management cycle.',
        sections: [
          _LearningSection(
            'Environmental controls',
            'Consider waste, dust, noise, spills, chemical storage, water, pollution prevention and site housekeeping according to project and applicable requirements.',
          ),
          _LearningSection(
            'Worker welfare',
            'Plan suitable welfare, sanitation, drinking water, rest arrangements and other applicable worker-health controls. Consider occupational health risks associated with the work and environment.',
          ),
          _LearningSection(
            'Heat-stress planning',
            'For hot-weather work, plan work/rest arrangements, hydration, shaded recovery, acclimatisation and heat-stress awareness in accordance with applicable current requirements and project arrangements.',
          ),
        ],
      ),
      const _LearningModule(
        number: '15',
        title: 'HSE KPI & Performance Reporting',
        icon: Icons.analytics_outlined,
        summary: 'Use performance information to manage risk, not just to produce statistics.',
        sections: [
          _LearningSection(
            'Leading indicators',
            'Examples include planned inspections completed, toolbox talks, training, safety observations, corrective-action closure and critical-control verification.',
          ),
          _LearningSection(
            'Lagging indicators',
            'Examples include injuries, lost-time events, recordable incidents, property damage and environmental incidents. Interpret these together with leading information.',
          ),
          _LearningSection(
            'Management reporting',
            'Reports should highlight significant risks, trends, overdue actions, recurring findings and areas requiring management decisions or resources.',
          ),
        ],
      ),
      const _LearningModule(
        number: '16',
        title: 'Corrective Action, CAPA & Root Cause',
        icon: Icons.build_circle_outlined,
        summary: 'Move from fixing symptoms to preventing recurrence.',
        sections: [
          _LearningSection(
            'Corrective action',
            'Address the identified non-conformance or unsafe condition and restore the required control.',
          ),
          _LearningSection(
            'Root cause',
            'For significant or repeated events, examine why the control failed. Consider planning, design, supervision, competence, equipment, communication and management-system factors.',
          ),
          _LearningSection(
            'Effectiveness check',
            'After implementation, verify that the action controls the risk and that the problem does not remain elsewhere in the project.',
          ),
        ],
      ),
      const _LearningModule(
        number: '17',
        title: 'Management Review & Continual Improvement',
        icon: Icons.trending_up_outlined,
        summary: 'Use HSE information to improve the system over time.',
        sections: [
          _LearningSection(
            'Management review inputs',
            'Review HSE performance, audit findings, incidents, trends, corrective actions, legal or requirement changes, resources, training needs and improvement opportunities.',
          ),
          _LearningSection(
            'Continual improvement',
            'Use lessons learned, field observations, audits and performance trends to strengthen controls, procedures, competence and planning.',
          ),
          _LearningSection(
            'PDCA reference',
            'Plan the controls, Do the work safely, Check actual performance, and Act to correct and improve. Repeat the cycle as project conditions evolve.',
          ),
        ],
      ),
      const _LearningModule(
        number: '18',
        title: 'Practical HSE Officer Site Routine',
        icon: Icons.engineering_outlined,
        summary: 'A practical reference sequence for daily field monitoring.',
        sections: [
          _LearningSection(
            'Before work starts',
            'Review planned activities, high-risk work, permits, RAMS, manpower, competency, equipment, access, interfaces, emergency arrangements and weather/environmental conditions where relevant.',
          ),
          _LearningSection(
            'Work-front inspection',
            'Visit critical work areas. Verify that the physical controls match the approved plan. Speak with supervisors and workers and check whether changes have occurred.',
          ),
          _LearningSection(
            'During the shift',
            'Monitor high-risk activities, follow up observations, verify corrective actions, support toolbox communication and escalate significant uncontrolled risks.',
          ),
          _LearningSection(
            'End-of-day review',
            'Review outstanding actions, incidents or near misses, changes for the next shift, permit status, housekeeping and any controls requiring follow-up.',
          ),
        ],
      ),
      const _LearningModule(
        number: '19',
        title: 'Common HSE Management Mistakes',
        icon: Icons.error_outline,
        summary: 'Recognise system weaknesses before they become incidents.',
        sections: [
          _LearningSection(
            'Paper compliance',
            'Having a signed document without verifying field implementation creates false assurance.',
          ),
          _LearningSection(
            'Generic risk assessment',
            'A generic assessment may miss actual site conditions, interfaces and task-specific hazards.',
          ),
          _LearningSection(
            'Action without verification',
            'Marking an action closed without checking effectiveness leaves the underlying risk uncontrolled.',
          ),
          _LearningSection(
            'Production pressure',
            'Schedule pressure should not be allowed to override critical safety controls or required authorisations.',
          ),
        ],
      ),
      const _LearningModule(
        number: '20',
        title: 'Quick Revision & Interview Reference',
        icon: Icons.quiz_outlined,
        summary: 'Key questions to test your understanding.',
        sections: [
          _LearningSection(
            'Question 1 — What is an HSE Management System?',
            'A structured framework for planning, implementing, monitoring and improving health, safety and environmental performance.',
          ),
          _LearningSection(
            'Question 2 — What is the hierarchy of controls?',
            'Elimination, Substitution, Engineering Controls, Administrative Controls and PPE.',
          ),
          _LearningSection(
            'Question 3 — What should happen when site conditions change?',
            'Stop or control the affected work as appropriate, reassess the risk, update the method/controls where required, brief affected personnel and verify before restart.',
          ),
          _LearningSection(
            'Question 4 — What makes an HSE action truly closed?',
            'The required corrective action is implemented and its effectiveness has been verified.',
          ),
          _LearningSection(
            'Question 5 — What is the HSE Officer core role?',
            'Support and monitor the implementation of the HSE system, verify field controls, communicate risks, report findings, follow up corrective actions and escalate significant uncontrolled risks.',
          ),
        ],
      ),
    ];

    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: const Text(
          'HSE Management System',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        backgroundColor: primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(14, 16, 14, 28),
        children: [
          _hero(),
          const SizedBox(height: 14),
          const _NoticeCard(),
          const SizedBox(height: 14),
          for (final module in modules) ...[
            _ModuleCard(module: module),
            const SizedBox(height: 10),
          ],
        ],
      ),
    );
  }

  Widget _hero() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0B6B4F), Color(0xFF159447)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.10),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.verified_user_outlined, color: Colors.white, size: 38),
          SizedBox(height: 12),
          Text(
            'Advanced Learning & Reference',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Study the HSE management cycle from leadership and planning through field implementation, monitoring, incident learning and continual improvement.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.5,
              height: 1.55,
            ),
          ),
        ],
      ),
    );
  }
}

class _NoticeCard extends StatelessWidget {
  const _NoticeCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Color(0xFFD8E6DE)),
      ),
      child: const Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.menu_book_outlined, color: Color(0xFF0B6B4F)),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                'Learning note: this module is a study and field-reference aid. Always follow the current applicable Dubai/UAE requirements, approved project procedures, RAMS, permits and competent-person instructions for the actual task.',
                style: TextStyle(fontSize: 13.5, height: 1.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ModuleCard extends StatelessWidget {
  final _LearningModule module;

  const _ModuleCard({required this.module});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.5,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
        leading: CircleAvatar(
          radius: 23,
          backgroundColor: const Color(0xFFE5F4EC),
          child: Icon(module.icon, color: const Color(0xFF0B6B4F)),
        ),
        title: Text(
          '${module.number}  ${module.title}',
          style: const TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 16,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Text(
            module.summary,
            style: const TextStyle(
              fontSize: 12.5,
              height: 1.4,
              color: Colors.black87,
            ),
          ),
        ),
        children: [
          for (final section in module.sections) ...[
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFF7FAF8),
                borderRadius: BorderRadius.circular(13),
                border: Border.all(color: const Color(0xFFE1ECE5)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    section.title,
                    style: const TextStyle(
                      color: Color(0xFF0B6B4F),
                      fontWeight: FontWeight.w800,
                      fontSize: 14.5,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    section.body,
                    style: const TextStyle(
                      fontSize: 13.5,
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _LearningModule {
  final String number;
  final String title;
  final IconData icon;
  final String summary;
  final List<_LearningSection> sections;

  const _LearningModule({
    required this.number,
    required this.title,
    required this.icon,
    required this.summary,
    required this.sections,
  });
}

class _LearningSection {
  final String title;
  final String body;

  const _LearningSection(this.title, this.body);
}
