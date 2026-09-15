import 'package:flutter/material.dart';

class DubaiHseManagementAdvancedLearningPage extends StatelessWidget {
  const DubaiHseManagementAdvancedLearningPage({super.key});

  static const Color primary = Color(0xFF0B6B4F);
  static const Color background = Color(0xFFF5F8F6);

  @override
  Widget build(BuildContext context) {
    final modules = <_Module>[
      const _Module('01', 'HSE Management System Basics', Icons.account_tree_outlined, [
        _Section('What is an HSE Management System?', 'An HSE Management System is an organised framework used to plan, implement, control, monitor and improve Health, Safety and Environmental performance. It connects leadership, responsibilities, risk management, procedures, competence, operational controls, inspections, incident management and continual improvement.'),
        _Section('Main objectives', 'Prevent injury and ill health, control workplace hazards, protect people and property, reduce environmental impacts, meet applicable requirements and continually improve HSE performance.'),
        _Section('PDCA cycle', 'Plan the work and controls, Do the work, Check actual performance and Act on findings to improve the system.'),
      ]),
      const _Module('02', 'HSE Policy & Leadership', Icons.policy_outlined, [
        _Section('HSE Policy', 'The policy communicates the organisation commitment to protecting people, complying with applicable requirements, preventing harm and improving HSE performance.'),
        _Section('Leadership', 'Management should provide resources, competent people, suitable equipment and authority for corrective action. Leaders should review performance and demonstrate visible safety commitment.'),
        _Section('Site leadership', 'Management site walks should verify critical controls, speak with workers, review actions and remove barriers to safe work.'),
      ]),
      const _Module('03', 'Organisation & Responsibilities', Icons.groups_outlined, [
        _Section('Project Management', 'Provides leadership, resources, priorities, competent personnel and authority to implement HSE arrangements.'),
        _Section('HSE Manager / Team', 'Coordinates the HSE system, supports risk management, monitors compliance, conducts inspections and audits, reviews incidents and tracks corrective actions.'),
        _Section('Supervisor / Foreman', 'Implements approved methods at the workface, briefs workers and verifies controls before and during work.'),
        _Section('Worker', 'Follows procedures, uses controls and PPE, reports hazards and raises concerns about uncontrolled risk.'),
      ]),
      const _Module('04', 'Legal & Regulatory Compliance', Icons.gavel_outlined, [
        _Section('Compliance process', 'Identify applicable Dubai/UAE requirements and project requirements; assign responsibility; communicate requirements; verify implementation; retain evidence; review changes.'),
        _Section('Reference discipline', 'Distinguish legislation, authority requirements, guidance, client requirements, company procedures and project-specific controls. Verify current applicable sources before treating a requirement as mandatory.'),
        _Section('Site verification', 'Ask what requirement applies, where it is implemented, who owns it and what evidence proves implementation.'),
      ]),
      const _Module('05', 'Hazard Identification & Risk Assessment', Icons.warning_amber_outlined, [
        _Section('Risk assessment sequence', 'Identify activity and hazards, identify exposed people, evaluate risk, select controls, assign responsibility, communicate controls, verify implementation and review when conditions change.'),
        _Section('Hierarchy of controls', 'Elimination → Substitution → Engineering Controls → Administrative Controls → PPE. Use stronger controls where reasonably practicable.'),
        _Section('Dynamic review', 'Review the assessment when the work method, equipment, environment, manpower, interfaces or other significant conditions change.'),
      ]),
      const _Module('06', 'HSE Plan & Operational Planning', Icons.assignment_outlined, [
        _Section('HSE Plan', 'Can define objectives, organisation, responsibilities, risk management, training, inspections, emergency arrangements, incident reporting, environmental controls, contractor management, audits and reporting.'),
        _Section('Work package planning', 'Before critical work starts, verify approved method, risk assessment, competent personnel, equipment, permits where required, exclusion zones, access and emergency arrangements.'),
        _Section('SIMOPS', 'Coordinate simultaneous operations so one activity does not introduce uncontrolled risk to another activity or work group.'),
      ]),
      const _Module('07', 'RAMS / Method Statement', Icons.description_outlined, [
        _Section('Purpose', 'RAMS should explain the work sequence, hazards, controls, responsibilities, equipment, competence, permits or isolations where applicable and emergency arrangements.'),
        _Section('Briefing', 'Affected workers should understand the task, hazards, controls, sequence and stop-work arrangements. Attendance alone does not prove understanding.'),
        _Section('Field verification', 'Compare actual site conditions with the approved method. If conditions materially change, stop and reassess before continuing.'),
      ]),
      const _Module('08', 'Permit to Work', Icons.fact_check_outlined, [
        _Section('Purpose', 'PTW provides formal control and communication for specified higher-risk or controlled activities.'),
        _Section('Before work', 'Verify the correct permit, boundaries, isolations or tests, competent persons, precautions, communication and site conditions.'),
        _Section('Suspension and closure', 'Suspend when authorised conditions are no longer valid or the work changes materially. Close according to the approved project procedure.'),
      ]),
      const _Module('09', 'Training, Competency & Toolbox Talks', Icons.school_outlined, [
        _Section('Training', 'Maintain a training matrix covering induction, task-specific training, emergency training, specialist competence and refresher needs.'),
        _Section('Competency', 'Competency combines appropriate knowledge, skills, experience and authorisation. Safety-critical tasks should be assigned to suitably competent persons.'),
        _Section('Toolbox Talk', 'Make the talk task-specific: today work, hazards, controls, interfaces, environmental conditions, emergency arrangements and worker questions.'),
      ]),
      const _Module('10', 'Inspection, Audit & Monitoring', Icons.search_outlined, [
        _Section('Inspection', 'Inspect work fronts, access, housekeeping, equipment, temporary works, barriers, PPE and safety-critical controls at a risk-appropriate frequency.'),
        _Section('Audit', 'An audit evaluates whether management arrangements are established and effective using evidence, interviews, observations and records.'),
        _Section('Finding to closure', 'Record the finding, assign an owner and due date, implement the action and verify effectiveness before closure.'),
      ]),
      const _Module('11', 'Incident & Near-Miss Management', Icons.report_problem_outlined, [
        _Section('Immediate response', 'Make the area safe, provide appropriate emergency response, raise the alarm and prevent further exposure. Preserve relevant information and evidence where appropriate.'),
        _Section('Investigation', 'Establish what happened and contributing or underlying causes. Consider planning, supervision, equipment, procedures, competence and communication.'),
        _Section('Learning', 'Define actions, verify implementation and communicate relevant lessons. Check whether the same risk exists elsewhere.'),
      ]),
      const _Module('12', 'Emergency Preparedness', Icons.emergency_outlined, [
        _Section('Emergency planning', 'Identify credible emergencies and define alarms, communication, contacts, evacuation, assembly points, first aid, fire response and rescue arrangements.'),
        _Section('Drills', 'Drills should test practical response and coordination. Record observations and improve the plan based on gaps.'),
        _Section('Restart', 'After an emergency, reassess hazards, inspect the area, confirm controls and obtain required authorisation before resuming work.'),
      ]),
      const _Module('13', 'Contractor Management', Icons.handshake_outlined, [
        _Section('Prequalification', 'Review contractor HSE capability, relevant experience, competent personnel, procedures and resources appropriate to the scope.'),
        _Section('Mobilisation', 'Provide induction, verify RAMS and competency, establish supervision, coordinate permits and monitor performance.'),
        _Section('Performance', 'Track inspections, observations, incidents, corrective actions and repeated non-conformances. Escalate persistent failures.'),
      ]),
      const _Module('14', 'Environmental & Occupational Health', Icons.eco_outlined, [
        _Section('Environmental controls', 'Consider waste, dust, noise, spills, chemical storage, water, pollution prevention and housekeeping according to applicable and project requirements.'),
        _Section('Worker welfare', 'Plan suitable welfare, sanitation, drinking water, rest arrangements and occupational-health controls appropriate to the work.'),
        _Section('Heat stress', 'For hot-weather work, plan hydration, shaded recovery, acclimatisation and other applicable controls in accordance with current requirements and project arrangements.'),
      ]),
      const _Module('15', 'HSE KPI & Performance Reporting', Icons.analytics_outlined, [
        _Section('Leading indicators', 'Examples: planned inspections, toolbox talks, training, safety observations, corrective-action closure and critical-control verification.'),
        _Section('Lagging indicators', 'Examples: injuries, lost-time events, recordable incidents, property damage and environmental incidents.'),
        _Section('Management reporting', 'Highlight significant risks, trends, overdue actions, recurring findings and areas requiring management decisions or resources.'),
      ]),
      const _Module('16', 'CAPA & Root Cause Analysis', Icons.build_circle_outlined, [
        _Section('Corrective action', 'Restore the required control and address the identified non-conformance or unsafe condition.'),
        _Section('Root cause', 'For significant or repeated events, examine why controls failed, including planning, design, supervision, competence, equipment and management-system factors.'),
        _Section('Effectiveness', 'Verify that the action controls the risk and that the problem has not remained elsewhere.'),
      ]),
      const _Module('17', 'Management Review & Continual Improvement', Icons.trending_up_outlined, [
        _Section('Management review inputs', 'Review HSE performance, audit findings, incidents, trends, corrective actions, requirement changes, resources, training needs and improvement opportunities.'),
        _Section('Continual improvement', 'Use lessons learned, audits, observations and performance trends to strengthen controls, procedures, competence and planning.'),
      ]),
      const _Module('18', 'Practical HSE Officer Daily Routine', Icons.engineering_outlined, [
        _Section('Before work', 'Review planned activities, high-risk work, permits, RAMS, manpower, competency, equipment, access, interfaces, emergency arrangements and relevant environmental conditions.'),
        _Section('Work-front inspection', 'Visit critical areas, verify physical controls, speak with supervisors and workers and identify changes from the approved plan.'),
        _Section('During shift', 'Monitor high-risk activities, follow up observations, support toolbox communication and escalate significant uncontrolled risks.'),
        _Section('End-of-day', 'Review outstanding actions, incidents or near misses, next-shift changes, permit status, housekeeping and follow-up requirements.'),
      ]),
      const _Module('19', 'Common HSE Management Mistakes', Icons.error_outline, [
        _Section('Paper compliance', 'A signed document without field verification creates false assurance.'),
        _Section('Generic risk assessment', 'Generic assessments can miss actual site conditions, interfaces and task-specific hazards.'),
        _Section('Action without verification', 'Closing an action without checking effectiveness can leave the underlying risk uncontrolled.'),
        _Section('Production pressure', 'Schedule pressure should not override critical safety controls or required authorisations.'),
      ]),
      const _Module('20', 'Quick Revision & Interview Reference', Icons.quiz_outlined, [
        _Section('What is an HSE Management System?', 'A structured framework for planning, implementing, monitoring and improving health, safety and environmental performance.'),
        _Section('Hierarchy of controls?', 'Elimination, Substitution, Engineering Controls, Administrative Controls and PPE.'),
        _Section('What if site conditions change?', 'Control or stop the affected work as appropriate, reassess the risk, update controls where required, brief affected personnel and verify before restart.'),
        _Section('When is an action really closed?', 'When the required corrective action is implemented and its effectiveness has been verified.'),
        _Section('Core HSE Officer role?', 'Support and monitor implementation, verify field controls, communicate risks, report findings, follow up actions and escalate significant uncontrolled risks.'),
      ]),
    ];

    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: const Text('HSE Management System'),
        backgroundColor: primary,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(14, 16, 14, 28),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF0B6B4F), Color(0xFF159447)],
              ),
              borderRadius: BorderRadius.circular(22),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.verified_user_outlined, color: Colors.white, size: 38),
                SizedBox(height: 10),
                Text('Advanced Learning & Reference', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w800)),
                SizedBox(height: 8),
                Text('Learn the HSE management cycle from leadership and planning through implementation, monitoring, incident learning and continual improvement.', style: TextStyle(color: Colors.white, height: 1.5)),
              ],
            ),
          ),
          const SizedBox(height: 14),
          for (final module in modules) ...[
            Card(
              margin: EdgeInsets.zero,
              child: ExpansionTile(
                leading: CircleAvatar(
                  backgroundColor: const Color(0xFFE5F4EC),
                  child: Text(module.number, style: const TextStyle(color: primary, fontWeight: FontWeight.bold, fontSize: 12)),
                ),
                title: Text(module.title, style: const TextStyle(fontWeight: FontWeight.w800)),
                childrenPadding: const EdgeInsets.fromLTRB(14, 0, 14, 12),
                children: [
                  for (final section in module.sections)
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(bottom: 9),
                      padding: const EdgeInsets.all(13),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF7FAF8),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFE1ECE5)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(section.title, style: const TextStyle(color: primary, fontWeight: FontWeight.w800)),
                          const SizedBox(height: 6),
                          Text(section.body, style: const TextStyle(fontSize: 13.5, height: 1.55)),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 10),
          ],
        ],
      ),
    );
  }
}

class _Module {
  final String number;
  final String title;
  final IconData icon;
  final List<_Section> sections;

  const _Module(this.number, this.title, this.icon, this.sections);
}

class _Section {
  final String title;
  final String body;

  const _Section(this.title, this.body);
}
