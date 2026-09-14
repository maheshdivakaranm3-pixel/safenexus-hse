import 'package:flutter/material.dart';
import 'dubai_hse_part1_advanced_learning_page.dart';

// ============================================================
// SAFE NEXUS HSE
// DUBAI HSE — PART 1 / TOPICS 1–10
// Same structure as Lifting Operations.
// Main Topic -> Sections -> small > -> Advanced Learning
// English only. No large round action arrow.
// ============================================================

class DubaiPart1Item {
  final String title;
  final String detail;

  const DubaiPart1Item({
    required this.title,
    required this.detail,
  });
}

class DubaiPart1Section {
  final String title;
  final String content;
  final List<DubaiPart1Item> items;
  final bool initiallyExpanded;

  const DubaiPart1Section({
    required this.title,
    required this.content,
    this.items = const [],
    this.initiallyExpanded = false,
  });
}

class DubaiHsePart1TopicPage extends StatelessWidget {
  final String topicId;

  const DubaiHsePart1TopicPage({
    super.key,
    required this.topicId,
  });

  @override
  Widget build(BuildContext context) {
    final topic = DubaiPart1Data.topic(topicId);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F8F7),
      appBar: AppBar(
        backgroundColor: const Color(0xFFEAF4F0),
        foregroundColor: const Color(0xFF17231F),
        elevation: 0,
        title: Text(
          topic.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
        children: [
          _HeaderCard(
            title: topic.title,
            subtitle: topic.subtitle,
            description: topic.description,
            icon: topic.icon,
          ),
          const SizedBox(height: 14),
          ...topic.sections.map(
            (section) => _SectionCard(
              section: section,
              topicId: topic.id,
              topicTitle: topic.title,
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
  final String description;
  final IconData icon;

  const _HeaderCard({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          gradient: const LinearGradient(
            colors: [
              Color(0xFFE8F6F0),
              Color(0xFFF8FBFA),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 58,
                  height: 58,
                  decoration: BoxDecoration(
                    color: const Color(0xFF0B7653),
                    borderRadius: BorderRadius.circular(17),
                  ),
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 31,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 27,
                      height: 1.12,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF10231D),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Text(
              subtitle.toUpperCase(),
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w800,
                letterSpacing: .5,
                color: Color(0xFF075C45),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              description,
              style: const TextStyle(
                fontSize: 16,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final DubaiPart1Section section;
  final String topicId;
  final String topicTitle;

  const _SectionCard({
    required this.section,
    required this.topicId,
    required this.topicTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 1.5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(19),
      ),
      clipBehavior: Clip.antiAlias,
      child: ExpansionTile(
        initiallyExpanded: section.initiallyExpanded,
        tilePadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 5,
        ),
        childrenPadding: const EdgeInsets.fromLTRB(
          16,
          0,
          16,
          17,
        ),
        iconColor: const Color(0xFF237A5C),
        title: Text(
          section.title,
          style: const TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w800,
          ),
        ),
        children: [
          if (section.content.trim().isNotEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(4, 0, 4, 12),
              child: Text(
                section.content,
                style: const TextStyle(
                  fontSize: 15.5,
                  height: 1.5,
                ),
              ),
            ),
          ...section.items.map(
            (item) => _DetailItemTile(
              item: item,
              topicId: topicId,
              topicTitle: topicTitle,
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailItemTile extends StatelessWidget {
  final DubaiPart1Item item;
  final String topicId;
  final String topicTitle;

  const _DetailItemTile({
    required this.item,
    required this.topicId,
    required this.topicTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      elevation: 0,
      color: const Color(0xFFF4F8F6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(
          color: Color(0xFFD7E7E0),
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => DubaiHsePart1AdvancedLearningPage(
                topicId: topicId,
                topicTitle: topicTitle,
                title: item.title,
                summary: item.detail,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 15, 12, 15),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: const TextStyle(
                        fontSize: 16.5,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF17332A),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      item.detail,
                      style: const TextStyle(
                        fontSize: 14.5,
                        height: 1.45,
                        color: Color(0xFF465650),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.chevron_right_rounded,
                size: 25,
                color: Color(0xFF4D5A55),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DubaiPart1Topic {
  final String id;
  final String title;
  final String subtitle;
  final String description;
  final IconData icon;
  final List<DubaiPart1Section> sections;

  const DubaiPart1Topic({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.icon,
    required this.sections,
  });
}

class DubaiPart1Data {
  static DubaiPart1Topic topic(String id) {
    return _topics[id] ?? _topics['dubai_construction_safety']!;
  }

  static final Map<String, DubaiPart1Topic> _topics = {
    'dubai_construction_safety': DubaiPart1Topic(
      id: 'dubai_construction_safety',
      title: 'Dubai Construction Safety Framework',
      subtitle: 'BUILD SAFE • CONTROL RISK • VERIFY EVERY WORKFACE',
      description:
          'A practical construction safety framework for planning, organising, supervising and verifying safe work across contractors, work fronts, plant, temporary works and public interfaces.',
      icon: Icons.account_balance_rounded,
      sections: [
        DubaiPart1Section(
          title: '1. Introduction — What is the Framework?',
          content:
              'The framework connects leadership, planning, risk control, supervision and field verification so construction work is performed within an approved and controlled safe system.',
          initiallyExpanded: true,
          items: [
            DubaiPart1Item(
              title: 'Purpose of the Framework',
              detail:
                  'Establish clear accountability and consistent controls from mobilisation through construction and closeout.',
            ),
            DubaiPart1Item(
              title: 'Safe Construction Principle',
              detail:
                  'PLAN → ASSESS → CONTROL → BRIEF → VERIFY → EXECUTE → MONITOR → CLOSE OUT.',
            ),
          ],
        ),
        DubaiPart1Section(
          title: '2. Types / Systems',
          content:
              'The framework is implemented through management systems and workface controls that match project risk.',
          items: [
            DubaiPart1Item(
              title: 'Project HSE Governance',
              detail:
                  'Defines authority, accountability, objectives, resources, reporting and escalation.',
            ),
            DubaiPart1Item(
              title: 'High-Risk Activity Control',
              detail:
                  'Provides enhanced planning and supervision for lifting, excavation, work at height and other high-risk work.',
            ),
            DubaiPart1Item(
              title: 'SIMOPS / Interface Control',
              detail:
                  'Controls conflicts between simultaneous construction activities and shared work areas.',
            ),
          ],
        ),
        DubaiPart1Section(
          title: '3. Components / Key Elements',
          content:
              'Each element must work together rather than exist only as paperwork.',
          items: [
            DubaiPart1Item(
              title: 'HSE Plan',
              detail:
                  'Sets project HSE arrangements, responsibilities, programmes and monitoring requirements.',
            ),
            DubaiPart1Item(
              title: 'Risk Assessment',
              detail:
                  'Identifies hazards, exposed persons, controls, residual risk and required actions.',
            ),
            DubaiPart1Item(
              title: 'RAMS / Safe Work Method',
              detail:
                  'Explains the safe sequence, resources, controls, supervision and emergency arrangements.',
            ),
            DubaiPart1Item(
              title: 'Inspection & Action System',
              detail:
                  'Provides field verification, defect recording, responsibility assignment and closeout.',
            ),
          ],
        ),
        DubaiPart1Section(
          title: '4. Technical Requirements',
          content:
              'The workface must reflect the approved project arrangements and applicable Dubai requirements.',
          items: [
            DubaiPart1Item(
              title: 'Defined Responsibilities',
              detail:
                  'Safety-critical duties must be assigned to competent people with suitable authority.',
            ),
            DubaiPart1Item(
              title: 'Hierarchy of Controls',
              detail:
                  'Select effective controls with preference for elimination, engineering and collective protection.',
            ),
            DubaiPart1Item(
              title: 'Management of Change',
              detail:
                  'Reassess safety controls when scope, sequence, people, equipment or site conditions change.',
            ),
          ],
        ),
        DubaiPart1Section(
          title: '5. Planning & Risk Control',
          content:
              'Planning should identify foreseeable hazards before workers are exposed and establish practical controls.',
          items: [
            DubaiPart1Item(
              title: 'Work Package Planning',
              detail:
                  'Break work into controlled activities with defined interfaces, resources and hold points.',
            ),
            DubaiPart1Item(
              title: 'Risk Communication',
              detail:
                  'Brief affected workers and supervisors on significant hazards and required controls.',
            ),
            DubaiPart1Item(
              title: 'SIMOPS Review',
              detail:
                  'Review overlapping activities, access routes, lifting paths, plant movement and shared work fronts.',
            ),
          ],
        ),
        DubaiPart1Section(
          title: '6. Main Hazards',
          content:
              'Common framework failures include uncontrolled work, weak supervision, poor interfaces and ineffective corrective action.',
          items: [
            DubaiPart1Item(
              title: 'Unplanned Work',
              detail:
                  'Work begins without adequate risk assessment, method, competent supervision or required authorisation.',
            ),
            DubaiPart1Item(
              title: 'Interface Failure',
              detail:
                  'One work activity creates exposure for another team, plant route, public area or temporary structure.',
            ),
            DubaiPart1Item(
              title: 'Control Drift',
              detail:
                  'The actual workface gradually differs from the approved safe method without reassessment.',
            ),
          ],
        ),
        DubaiPart1Section(
          title: '7. Safety Controls',
          content:
              'Controls must be visible and effective at the workface, not only recorded in documents.',
          items: [
            DubaiPart1Item(
              title: 'Field Supervision',
              detail:
                  'Maintain supervision appropriate to the risk and verify critical barriers during execution.',
            ),
            DubaiPart1Item(
              title: 'Worker Briefing',
              detail:
                  'Confirm workers understand hazards, controls, emergency arrangements and stop-work expectations.',
            ),
            DubaiPart1Item(
              title: 'Corrective Action',
              detail:
                  'Assign actions, set priorities and verify effectiveness after correction.',
            ),
          ],
        ),
        DubaiPart1Section(
          title: '8. Inspection & Verification',
          content:
              'Inspection confirms whether planned controls actually exist and work at the location where the task is being performed.',
          items: [
            DubaiPart1Item(
              title: 'Pre-Start Verification',
              detail:
                  'Check the work area, equipment, access, barriers, permits and critical controls before exposure.',
            ),
            DubaiPart1Item(
              title: 'Ongoing Monitoring',
              detail:
                  'Monitor changing conditions and control effectiveness during the work.',
            ),
            DubaiPart1Item(
              title: 'Action Closure',
              detail:
                  'Verify that corrections are implemented and effective before treating the issue as closed.',
            ),
          ],
        ),
        DubaiPart1Section(
          title: '9. Stop-Work Conditions',
          content:
              'Stop affected work when a critical control is missing, ineffective or materially different from the approved safe system.',
          items: [
            DubaiPart1Item(
              title: 'Critical Barrier Missing',
              detail:
                  'Suspend exposure until the missing barrier is restored and verified.',
            ),
            DubaiPart1Item(
              title: 'Unsafe Change',
              detail:
                  'Pause and reassess when site conditions or the work sequence change significantly.',
            ),
          ],
        ),
        DubaiPart1Section(
          title: '10. Responsibilities',
          content:
              'Accountability must be visible from project leadership to the workface.',
          items: [
            DubaiPart1Item(
              title: 'Management',
              detail:
                  'Provide resources, competent arrangements, leadership and escalation for significant HSE risks.',
            ),
            DubaiPart1Item(
              title: 'Supervisor',
              detail:
                  'Control the workface and verify that the approved method is followed.',
            ),
            DubaiPart1Item(
              title: 'Worker',
              detail:
                  'Follow instructions, use controls correctly and report hazards or changes.',
            ),
          ],
        ),
        DubaiPart1Section(
          title: '11. Emergency Response',
          content:
              'Emergency arrangements should be proportionate to the project hazards and known workface scenarios.',
          items: [
            DubaiPart1Item(
              title: 'Immediate Response',
              detail:
                  'Stop the affected task, raise the alarm and protect people from further exposure.',
            ),
            DubaiPart1Item(
              title: 'Area Control',
              detail:
                  'Establish safe access and prevent secondary exposure while emergency response is coordinated.',
            ),
          ],
        ),
        DubaiPart1Section(
          title: '12. Practical Site Example',
          content:
              'A high-risk activity starts while a nearby work front changes access and plant movement arrangements.',
          items: [
            DubaiPart1Item(
              title: 'Field Scenario',
              detail:
                  'The supervisor pauses the task, reviews the interface risk, updates controls and re-briefs the affected team before restart.',
            ),
            DubaiPart1Item(
              title: 'HSE Verification',
              detail:
                  'HSE verifies the revised controls in the field and records the corrective learning.',
            ),
          ],
        ),
        DubaiPart1Section(
          title: '13. Quick Learning Formula',
          content:
              'PLAN → ASSESS → CONTROL → BRIEF → VERIFY → EXECUTE → MONITOR → CLOSE OUT',
          items: [
            DubaiPart1Item(
              title: 'Verify in the Field',
              detail:
                  'A safe system is effective only when the actual workface matches the approved controls.',
            ),
          ],
        ),
        DubaiPart1Section(
          title: '🦺 HSE Roles — Topic-wise Responsibilities',
          content:
              'HSE responsibilities are consolidated at the end of the topic, with each role focused on the construction-safety framework.',
          items: [
            DubaiPart1Item(
              title: 'HSE Officer',
              detail:
                  'Conduct field observations, verify barriers, monitor RAMS implementation, record findings and support immediate intervention.',
            ),
            DubaiPart1Item(
              title: 'HSE Supervisor',
              detail:
                  'Coordinate daily HSE supervision, verify critical controls, follow up defects and escalate serious conditions.',
            ),
            DubaiPart1Item(
              title: 'Senior HSE',
              detail:
                  'Provide higher-level assurance, challenge recurring weaknesses and review significant construction-risk trends.',
            ),
            DubaiPart1Item(
              title: 'HSE Coordinator',
              detail:
                  'Coordinate HSE documentation, inspections, actions, contractor interfaces and controlled distribution of current information.',
            ),
            DubaiPart1Item(
              title: 'HSE Engineer',
              detail:
                  'Review technical interfaces, temporary works, access, sequencing and engineering-related safety assumptions.',
            ),
            DubaiPart1Item(
              title: 'HSE Manager',
              detail:
                  'Provide project HSE governance, resources, escalation, assurance and continual-improvement direction.',
            ),
          ],
        ),
      ],
    ),

    'dubai_hse_management': DubaiPart1Topic(
      id: 'dubai_hse_management',
      title: 'HSE Management System',
      subtitle: 'LEAD • PLAN • CONTROL • ASSURE • IMPROVE',
      description:
          'A practical management-system view of HSE policy, objectives, responsibilities, risk control, competence, assurance, reporting and continual improvement.',
      icon: Icons.health_and_safety_rounded,
      sections: _managementSections,
    ),

    'dubai_risk_assessment': DubaiPart1Topic(
      id: 'dubai_risk_assessment',
      title: 'Health & Safety Risk Assessment',
      subtitle: 'IDENTIFY • ASSESS • CONTROL • REVIEW',
      description:
          'A practical risk-assessment workflow for identifying hazards, evaluating risk, selecting controls, communicating significant risks and reviewing changes.',
      icon: Icons.fact_check_rounded,
      sections: _riskSections,
    ),

    'dubai_hse_plan': DubaiPart1Topic(
      id: 'dubai_hse_plan',
      title: 'Construction HSE Plan',
      subtitle: 'PLAN THE PROJECT • CONTROL THE WORK',
      description:
          'A project-level HSE planning structure connecting objectives, responsibilities, risk registers, RAMS, emergency arrangements, monitoring and corrective actions.',
      icon: Icons.assignment_rounded,
      sections: _planSections,
    ),

    'dubai_work_at_height': DubaiPart1Topic(
      id: 'dubai_work_at_height',
      title: 'Work at Height',
      subtitle: 'PREVENT FALLS • CONTROL THE EDGE • RESCUE READY',
      description:
          'A practical work-at-height structure covering selection of access systems, collective protection, personal fall protection, dropped objects, inspection and rescue.',
      icon: Icons.height_rounded,
      sections: _heightSections,
    ),

    'dubai_scaffolding': DubaiPart1Topic(
      id: 'dubai_scaffolding',
      title: 'Scaffolding Safety',
      subtitle: 'DESIGN • ERECT • INSPECT • TAG • USE',
      description:
          'A professional scaffolding safety structure covering scaffold types, components, stability, access, loading, inspection, tagging, modification and competent-person control.',
      icon: Icons.construction_rounded,
      sections: _scaffoldSections,
    ),

    'dubai_lifting': DubaiPart1Topic(
      id: 'dubai_lifting',
      title: 'Lifting Operations',
      subtitle: 'PLAN SAFE • LIFT SAFE • CONTROL EVERY MOVEMENT',
      description:
          'The dedicated Lifting Operations page remains the project benchmark and is routed to its existing implementation.',
      icon: Icons.construction_rounded,
      sections: const [],
    ),

    'dubai_excavation': DubaiPart1Topic(
      id: 'dubai_excavation',
      title: 'Excavation & Trenching',
      subtitle: 'IDENTIFY SERVICES • PROTECT THE EXCAVATION • CONTROL ACCESS',
      description:
          'The dedicated Excavation & Trenching page remains the project benchmark and is routed to its existing implementation.',
      icon: Icons.landscape_rounded,
      sections: const [],
    ),

    'dubai_confined_space': DubaiPart1Topic(
      id: 'dubai_confined_space',
      title: 'Confined Space Entry',
      subtitle: 'ASSESS • ISOLATE • TEST • ENTER • RESCUE',
      description:
          'A practical confined-space structure covering identification, permit control, isolation, atmospheric testing, ventilation, standby arrangements, communication and rescue.',
      icon: Icons.air_rounded,
      sections: _confinedSections,
    ),

    'dubai_electrical': DubaiPart1Topic(
      id: 'dubai_electrical',
      title: 'Electrical Safety',
      subtitle: 'ISOLATE • VERIFY • PROTECT • CONTROL',
      description:
          'A practical electrical-safety structure covering competent persons, isolation, LOTO, inspection, earthing, temporary power, cables, panels and emergency response.',
      icon: Icons.electrical_services_rounded,
      sections: _electricalSections,
    ),
  };
}

// ============================================================
// SHARED TOPIC-SPECIFIC SECTION SETS FOR TOPICS 2–5, 9–10
// Each set keeps the Lifting pattern but changes the actual HSE
// content to match the selected work/topic.
// ============================================================

List<DubaiPart1Section> _standardSections({
  required String topic,
  required String intro,
  required List<DubaiPart1Item> types,
  required List<DubaiPart1Item> components,
  required List<DubaiPart1Item> planning,
  required List<DubaiPart1Item> hazards,
  required List<DubaiPart1Item> controls,
  required List<DubaiPart1Item> inspection,
  required List<DubaiPart1Item> stop,
  required List<DubaiPart1Item> emergency,
  required List<DubaiPart1Item> example,
  required List<DubaiPart1Item> roles,
}) {
  return [
    DubaiPart1Section(
      title: '1. Introduction — What is $topic?',
      content: intro,
      items: [
        DubaiPart1Item(
          title: 'Purpose',
          detail: intro,
        ),
        DubaiPart1Item(
          title: 'Core Principle',
          detail:
              'PLAN → ASSESS → CONTROL → BRIEF → VERIFY → EXECUTE → MONITOR → CLOSE OUT.',
        ),
      ],
      initiallyExpanded: true,
    ),
    DubaiPart1Section(
      title: '2. Types / Systems',
      content:
          'Select the system or work arrangement that matches the task, risk and approved method.',
      items: types,
    ),
    DubaiPart1Section(
      title: '3. Components / Key Elements',
      content:
          'Each component or control element must be suitable, identifiable, inspected and used within its intended purpose.',
      items: components,
    ),
    DubaiPart1Section(
      title: '4. Technical Requirements',
      content:
          'Apply the current approved project requirements, applicable Dubai requirements, competent-person arrangements and manufacturer instructions where relevant.',
      items: [
        DubaiPart1Item(
          title: 'Competence',
          detail:
              'Safety-critical tasks must be performed or supervised by personnel with suitable knowledge, training, experience and authority.',
        ),
        DubaiPart1Item(
          title: 'Approved Method',
          detail:
              'The field arrangement must match the current approved method, risk assessment and required controls.',
        ),
        DubaiPart1Item(
          title: 'Change Control',
          detail:
              'Stop and reassess when the task, people, equipment, environment or sequence changes materially.',
        ),
      ],
    ),
    DubaiPart1Section(
      title: '5. Planning & Risk Control',
      content:
          'Planning should identify foreseeable hazards and establish controls before exposure.',
      items: planning,
    ),
    DubaiPart1Section(
      title: '6. Main Hazards',
      content:
          'Identify the principal hazards for this topic before work starts and monitor them during execution.',
      items: hazards,
    ),
    DubaiPart1Section(
      title: '7. Safety Controls',
      content:
          'Controls should be visible and effective at the workface.',
      items: controls,
    ),
    DubaiPart1Section(
      title: '8. Inspection & Verification',
      content:
          'Verify the actual condition of the work area, equipment, people and critical controls.',
      items: inspection,
    ),
    DubaiPart1Section(
      title: '9. Stop-Work Conditions',
      content:
          'Stop affected work when a critical control is missing, ineffective or materially different from the approved method.',
      items: stop,
    ),
    DubaiPart1Section(
      title: '10. Responsibilities',
      content:
          'Operational responsibilities must be assigned clearly and implemented at the workface.',
      items: [
        DubaiPart1Item(
          title: 'Supervisor',
          detail:
              'Control the workface, verify the method and intervene when conditions become unsafe.',
        ),
        DubaiPart1Item(
          title: 'Worker',
          detail:
              'Follow the approved method, use controls correctly and report hazards or changes.',
        ),
      ],
    ),
    DubaiPart1Section(
      title: '11. Emergency Response',
      content:
          'Emergency arrangements must match credible scenarios for the selected topic.',
      items: emergency,
    ),
    DubaiPart1Section(
      title: '12. Practical Site Example',
      content:
          'Use the example as a field-thinking model, then apply the actual project controls.',
      items: example,
    ),
    DubaiPart1Section(
      title: '13. Quick Learning Formula',
      content:
          'PLAN → ASSESS → CONTROL → BRIEF → VERIFY → EXECUTE → MONITOR → CLOSE OUT',
      items: [
        DubaiPart1Item(
          title: 'Field Learning',
          detail:
              'Do not rely only on paperwork. Compare the approved method with the actual workface before and during the task.',
        ),
      ],
    ),
    DubaiPart1Section(
      title: '🦺 HSE Roles — Topic-wise Responsibilities',
      content:
          'HSE responsibilities are placed once at the end of the topic, with role-specific focus for this work activity.',
      items: roles,
    ),
  ];
}

// Topic 2
final List<DubaiPart1Section> _managementSections = _standardSections(
  topic: 'HSE Management System',
  intro:
      'An HSE management system establishes policy, objectives, responsibilities, risk controls, competence, assurance, reporting and improvement processes.',
  types: [
    DubaiPart1Item(title: 'Policy & Objectives', detail: 'Set direction, expectations and measurable HSE objectives.'),
    DubaiPart1Item(title: 'Operational Control', detail: 'Translate HSE requirements into practical workface controls.'),
    DubaiPart1Item(title: 'Assurance & Audit', detail: 'Check whether the management system is implemented and effective.'),
    DubaiPart1Item(title: 'Corrective Action', detail: 'Control non-conformances, assign ownership and verify effectiveness.'),
  ],
  components: [
    DubaiPart1Item(title: 'HSE Policy', detail: 'Defines leadership commitment and broad HSE expectations.'),
    DubaiPart1Item(title: 'Risk Register', detail: 'Tracks significant project risks and required controls.'),
    DubaiPart1Item(title: 'Training Matrix', detail: 'Shows required competency and training status.'),
    DubaiPart1Item(title: 'Inspection Programme', detail: 'Provides planned field verification and action tracking.'),
    DubaiPart1Item(title: 'Audit Programme', detail: 'Tests system implementation and effectiveness at planned intervals.'),
  ],
  planning: [
    DubaiPart1Item(title: 'HSE Objectives', detail: 'Set realistic objectives linked to project risk and performance.'),
    DubaiPart1Item(title: 'Resource Planning', detail: 'Provide competent HSE resources, equipment and time for controls.'),
    DubaiPart1Item(title: 'Contractor Integration', detail: 'Align contractor arrangements with project HSE requirements.'),
  ],
  hazards: [
    DubaiPart1Item(title: 'Weak Accountability', detail: 'Responsibilities exist on paper but are not actively owned.'),
    DubaiPart1Item(title: 'System Disconnect', detail: 'Procedures do not reflect actual workface conditions.'),
    DubaiPart1Item(title: 'Recurring Findings', detail: 'Repeated observations indicate ineffective corrective action.'),
  ],
  controls: [
    DubaiPart1Item(title: 'Leadership Walkdowns', detail: 'Use field engagement to verify critical controls and visible leadership.'),
    DubaiPart1Item(title: 'Performance Review', detail: 'Review leading and lagging indicators and recurring themes.'),
    DubaiPart1Item(title: 'Corrective Action Verification', detail: 'Confirm actions are effective, not merely marked complete.'),
  ],
  inspection: [
    DubaiPart1Item(title: 'System Check', detail: 'Verify that required programmes and records are active.'),
    DubaiPart1Item(title: 'Field Check', detail: 'Compare documented controls with actual workface implementation.'),
  ],
  stop: [
    DubaiPart1Item(title: 'Critical System Failure', detail: 'Escalate and stop affected work where the safe system cannot be demonstrated.'),
    DubaiPart1Item(title: 'Uncontrolled Risk', detail: 'Pause work when critical controls are absent or ineffective.'),
  ],
  emergency: [
    DubaiPart1Item(title: 'Incident Response', detail: 'Activate the project emergency arrangements and protect people first.'),
    DubaiPart1Item(title: 'Management Escalation', detail: 'Escalate serious events according to the project emergency and reporting structure.'),
  ],
  example: [
    DubaiPart1Item(title: 'Recurring Finding', detail: 'The same lifting-zone defect appears repeatedly. Management reviews the root cause, assigns ownership and verifies the revised control in the field.'),
    DubaiPart1Item(title: 'Learning', detail: 'Repeated observations should trigger system improvement rather than repeated paperwork.'),
  ],
  roles: [
    DubaiPart1Item(title: 'HSE Officer', detail: 'Monitor field implementation, inspections, observations, briefings and corrective actions.'),
    DubaiPart1Item(title: 'HSE Supervisor', detail: 'Coordinate daily HSE monitoring, follow up deficiencies and support supervisors.'),
    DubaiPart1Item(title: 'Senior HSE', detail: 'Review significant trends, recurring failures and effectiveness of controls.'),
    DubaiPart1Item(title: 'HSE Coordinator', detail: 'Coordinate HSE records, actions, reports and contractor interfaces.'),
    DubaiPart1Item(title: 'HSE Engineer', detail: 'Review technical risk interfaces and management-of-change implications.'),
    DubaiPart1Item(title: 'HSE Manager', detail: 'Provide governance, resources, assurance, escalation and continual improvement.'),
  ],
);

// Topic 3
final List<DubaiPart1Section> _riskSections = _standardSections(
  topic: 'Health & Safety Risk Assessment',
  intro:
      'Risk assessment is a structured process for identifying hazards, assessing risk, selecting controls, communicating them and reviewing them when conditions change.',
  types: [
    DubaiPart1Item(title: 'Baseline Risk Assessment', detail: 'Establish project or activity-level hazards and controls.'),
    DubaiPart1Item(title: 'Task Risk Assessment / JSA', detail: 'Break the task into steps and identify step-specific hazards and controls.'),
    DubaiPart1Item(title: 'Dynamic Review', detail: 'Reassess when actual conditions change or new hazards appear.'),
    DubaiPart1Item(title: 'SIMOPS Risk Review', detail: 'Assess interactions between simultaneous activities.'),
  ],
  components: [
    DubaiPart1Item(title: 'Hazard Identification', detail: 'Identify sources of harm, energy, exposure and credible failure modes.'),
    DubaiPart1Item(title: 'People at Risk', detail: 'Identify workers, contractors, visitors, public and others who may be exposed.'),
    DubaiPart1Item(title: 'Existing Controls', detail: 'Record controls already present and assess their effectiveness.'),
    DubaiPart1Item(title: 'Additional Controls', detail: 'Select further controls using the hierarchy of controls.'),
    DubaiPart1Item(title: 'Residual Risk', detail: 'Confirm remaining risk after controls and whether the work can proceed.'),
  ],
  planning: [
    DubaiPart1Item(title: 'Task Breakdown', detail: 'Break complex work into logical steps before assessing hazards.'),
    DubaiPart1Item(title: 'Control Selection', detail: 'Prefer effective elimination, engineering and collective controls where practicable.'),
    DubaiPart1Item(title: 'Communication', detail: 'Brief affected personnel on significant hazards and controls.'),
  ],
  hazards: [
    DubaiPart1Item(title: 'Unidentified Hazard', detail: 'A credible hazard is absent from the assessment.'),
    DubaiPart1Item(title: 'Weak Control', detail: 'A control is listed but cannot be demonstrated in the field.'),
    DubaiPart1Item(title: 'Outdated Assessment', detail: 'The assessment no longer represents actual conditions.'),
  ],
  controls: [
    DubaiPart1Item(title: 'Hierarchy of Controls', detail: 'Select controls according to effectiveness rather than convenience.'),
    DubaiPart1Item(title: 'Control Ownership', detail: 'Assign each critical action to a responsible person.'),
    DubaiPart1Item(title: 'Field Validation', detail: 'Verify that planned controls are physically present and effective.'),
  ],
  inspection: [
    DubaiPart1Item(title: 'Pre-Task Review', detail: 'Check whether hazards and controls match the actual task.'),
    DubaiPart1Item(title: 'Change Review', detail: 'Reassess after significant change, incident, near miss or new information.'),
  ],
  stop: [
    DubaiPart1Item(title: 'Unacceptable Residual Risk', detail: 'Do not proceed until the risk is reduced to an acceptable level under the project process.'),
    DubaiPart1Item(title: 'Material Change', detail: 'Pause when conditions differ materially from the assessed task.'),
  ],
  emergency: [
    DubaiPart1Item(title: 'Unexpected Hazard', detail: 'Stop exposure, warn affected people and activate the relevant emergency arrangement.'),
    DubaiPart1Item(title: 'Incident Review', detail: 'Use the event to reassess controls before restarting the activity.'),
  ],
  example: [
    DubaiPart1Item(title: 'Excavation Change', detail: 'Ground conditions change after rain. The team pauses, reassesses stability, reviews access and protection and only restarts after controls are verified.'),
    DubaiPart1Item(title: 'Learning', detail: 'A risk assessment is a living control tool, not a document that stays unchanged while conditions move.'),
  ],
  roles: [
    DubaiPart1Item(title: 'HSE Officer', detail: 'Facilitate field checks, challenge weak controls and verify communication of significant risks.'),
    DubaiPart1Item(title: 'HSE Supervisor', detail: 'Coordinate task-level reviews and follow up implementation at the workface.'),
    DubaiPart1Item(title: 'Senior HSE', detail: 'Review significant and recurring risk themes and escalation cases.'),
    DubaiPart1Item(title: 'HSE Coordinator', detail: 'Coordinate risk-assessment records, revisions and distribution.'),
    DubaiPart1Item(title: 'HSE Engineer', detail: 'Review technical assumptions, interfaces and engineering controls.'),
    DubaiPart1Item(title: 'HSE Manager', detail: 'Provide risk-governance oversight and ensure significant risks receive management attention.'),
  ],
);

// Topic 4
final List<DubaiPart1Section> _planSections = _standardSections(
  topic: 'Construction HSE Plan',
  intro:
      'A Construction HSE Plan converts project HSE expectations into practical arrangements for risk management, competence, emergency response, inspections, reporting and improvement.',
  types: [
    DubaiPart1Item(title: 'Project HSE Plan', detail: 'Defines the overall project HSE organisation and control framework.'),
    DubaiPart1Item(title: 'Activity HSE Plan', detail: 'Focuses controls on a specific major work package or phase.'),
    DubaiPart1Item(title: 'Emergency Plan', detail: 'Defines credible emergency scenarios, response organisation and communication.'),
    DubaiPart1Item(title: 'Inspection / Assurance Plan', detail: 'Defines planned monitoring, inspections, audits and action follow-up.'),
  ],
  components: [
    DubaiPart1Item(title: 'HSE Organisation', detail: 'Defines roles, authority, communication and escalation.'),
    DubaiPart1Item(title: 'Risk Register', detail: 'Tracks significant project hazards and control ownership.'),
    DubaiPart1Item(title: 'RAMS Register', detail: 'Controls current work methods and required reviews.'),
    DubaiPart1Item(title: 'Emergency Arrangements', detail: 'Links credible scenarios with response resources and communication.'),
    DubaiPart1Item(title: 'Training Matrix', detail: 'Tracks competence requirements for project activities.'),
  ],
  planning: [
    DubaiPart1Item(title: 'Project Mobilisation', detail: 'Establish HSE organisation, site arrangements and critical procedures before work.'),
    DubaiPart1Item(title: 'Workfront Planning', detail: 'Coordinate work packages, access, plant, temporary works and interfaces.'),
    DubaiPart1Item(title: 'Monitoring Plan', detail: 'Define inspection, audit and performance-review arrangements.'),
  ],
  hazards: [
    DubaiPart1Item(title: 'Plan Not Implemented', detail: 'The approved plan exists but controls are not visible at the workface.'),
    DubaiPart1Item(title: 'Outdated RAMS', detail: 'The team is using information that no longer matches the work.'),
    DubaiPart1Item(title: 'Weak Interface Control', detail: 'Different contractors work to incompatible arrangements.'),
  ],
  controls: [
    DubaiPart1Item(title: 'Document Control', detail: 'Ensure teams use current approved information.'),
    DubaiPart1Item(title: 'Field Verification', detail: 'Check actual workface conditions against the plan.'),
    DubaiPart1Item(title: 'Action Management', detail: 'Track and verify corrective actions to closure.'),
  ],
  inspection: [
    DubaiPart1Item(title: 'Pre-Start Review', detail: 'Verify required documents, resources, competence and physical controls.'),
    DubaiPart1Item(title: 'Implementation Audit', detail: 'Check whether planned arrangements are actually implemented.'),
  ],
  stop: [
    DubaiPart1Item(title: 'Critical Plan Gap', detail: 'Pause affected work when a required safety arrangement is absent.'),
    DubaiPart1Item(title: 'Uncontrolled Change', detail: 'Stop and review when the work materially differs from the approved plan.'),
  ],
  emergency: [
    DubaiPart1Item(title: 'Emergency Activation', detail: 'Activate the project emergency arrangements for the credible event.'),
    DubaiPart1Item(title: 'Recovery & Restart', detail: 'Do not resume until the cause and critical controls have been addressed.'),
  ],
  example: [
    DubaiPart1Item(title: 'New Workfront', detail: 'A new workfront is opened. The team verifies RAMS, access, emergency arrangements, competence and interfaces before starting.'),
    DubaiPart1Item(title: 'HSE Verification', detail: 'HSE checks implementation and tracks any gaps to verified closure.'),
  ],
  roles: [
    DubaiPart1Item(title: 'HSE Officer', detail: 'Verify plan implementation in the field and record observations.'),
    DubaiPart1Item(title: 'HSE Supervisor', detail: 'Coordinate daily implementation checks and action follow-up.'),
    DubaiPart1Item(title: 'Senior HSE', detail: 'Review significant gaps and performance trends across workfronts.'),
    DubaiPart1Item(title: 'HSE Coordinator', detail: 'Control HSE submissions, registers, revisions and contractor interfaces.'),
    DubaiPart1Item(title: 'HSE Engineer', detail: 'Review technical interfaces, sequencing and risk-control assumptions.'),
    DubaiPart1Item(title: 'HSE Manager', detail: 'Own project HSE governance, resources, escalation and assurance.'),
  ],
);

// Topic 5
final List<DubaiPart1Section> _heightSections = _standardSections(
  topic: 'Work at Height',
  intro:
      'Work at height requires planned prevention of falls of people and objects through suitable access, collective protection, personal fall protection, inspection and rescue arrangements.',
  types: [
    DubaiPart1Item(title: 'Scaffold Work', detail: 'Use a suitable inspected scaffold system for the task and loading arrangement.'),
    DubaiPart1Item(title: 'Mobile Access Tower', detail: 'Use a suitable tower on an appropriate surface with required guarding and stability controls.'),
    DubaiPart1Item(title: 'MEWP Work', detail: 'Use a suitable mobile elevating work platform with trained operators and planned access.'),
    DubaiPart1Item(title: 'Ladder Work', detail: 'Use ladders only when suitable for the task and within the approved safe-use arrangement.'),
    DubaiPart1Item(title: 'Roof / Edge Work', detail: 'Control open edges, fragile surfaces, access and fall exposure.'),
  ],
  components: [
    DubaiPart1Item(title: 'Guardrail', detail: 'Provides collective edge protection where properly designed and maintained.'),
    DubaiPart1Item(title: 'Working Platform', detail: 'Must be stable, suitable for the task and protected against falls.'),
    DubaiPart1Item(title: 'Harness', detail: 'Use only as part of a suitable personal fall-protection system and inspect before use.'),
    DubaiPart1Item(title: 'Lifeline / Anchorage', detail: 'Must be suitable for the intended system and verified according to the approved arrangement.'),
    DubaiPart1Item(title: 'Dropped-Object Control', detail: 'Prevent tools and materials from falling onto people below.'),
    DubaiPart1Item(title: 'Rescue Plan', detail: 'Provide a realistic rescue arrangement for foreseeable fall scenarios.'),
  ],
  planning: [
    DubaiPart1Item(title: 'Avoid the Height', detail: 'Consider whether the task can be completed at ground level or by another safer method.'),
    DubaiPart1Item(title: 'Select Access System', detail: 'Choose the safest suitable access equipment for the task, duration and environment.'),
    DubaiPart1Item(title: 'Rescue Planning', detail: 'Plan recovery before work begins; do not rely only on emergency services.'),
  ],
  hazards: [
    DubaiPart1Item(title: 'Fall of Person', detail: 'Exposure can arise from unprotected edges, openings, unsuitable platforms or unsafe access.'),
    DubaiPart1Item(title: 'Dropped Objects', detail: 'Tools, materials and components can fall onto people or property below.'),
    DubaiPart1Item(title: 'Equipment Failure', detail: 'Defective or unsuitable access equipment can create instability or loss of protection.'),
    DubaiPart1Item(title: 'Weather', detail: 'Wind, rain, heat and poor visibility can change the risk of elevated work.'),
  ],
  controls: [
    DubaiPart1Item(title: 'Collective Protection', detail: 'Use guardrails, protected platforms and other collective controls where practicable.'),
    DubaiPart1Item(title: 'Personal Fall Protection', detail: 'Use a suitable system where required and verify anchorage, compatibility and rescue arrangements.'),
    DubaiPart1Item(title: 'Exclusion Zone', detail: 'Control areas below and around elevated work against falling-object exposure.'),
  ],
  inspection: [
    DubaiPart1Item(title: 'Access Equipment Check', detail: 'Inspect the selected access system before use and after relevant changes or events.'),
    DubaiPart1Item(title: 'Fall Protection Check', detail: 'Inspect harnesses, connectors, lifelines and anchor arrangements as required.'),
    DubaiPart1Item(title: 'Workface Check', detail: 'Verify edges, openings, housekeeping, weather and dropped-object controls.'),
  ],
  stop: [
    DubaiPart1Item(title: 'Unprotected Edge', detail: 'Stop where required fall protection is absent, damaged or ineffective.'),
    DubaiPart1Item(title: 'Unsafe Equipment', detail: 'Remove defective access or fall-protection equipment from use.'),
    DubaiPart1Item(title: 'Unsafe Weather', detail: 'Pause weather-sensitive work when conditions exceed the approved safe arrangement.'),
  ],
  emergency: [
    DubaiPart1Item(title: 'Fall Incident', detail: 'Raise the alarm, protect the area and activate the planned rescue arrangement.'),
    DubaiPart1Item(title: 'Suspension Rescue', detail: 'Use the planned rescue method and trained responders; avoid creating a second casualty.'),
  ],
  example: [
    DubaiPart1Item(title: 'Facade Work', detail: 'Before facade work, the team verifies access system, edge protection, dropped-object controls, weather and rescue arrangements.'),
    DubaiPart1Item(title: 'HSE Verification', detail: 'HSE checks the physical barriers and access system rather than relying only on paperwork.'),
  ],
  roles: [
    DubaiPart1Item(title: 'HSE Officer', detail: 'Verify fall controls, access equipment, exclusion zones and workface conditions.'),
    DubaiPart1Item(title: 'HSE Supervisor', detail: 'Coordinate daily height-work checks and challenge unsafe access or fall protection.'),
    DubaiPart1Item(title: 'Senior HSE', detail: 'Review high-risk height work, recurring fall exposures and assurance trends.'),
    DubaiPart1Item(title: 'HSE Coordinator', detail: 'Coordinate training, inspection, rescue-plan and document records.'),
    DubaiPart1Item(title: 'HSE Engineer', detail: 'Review technical access, anchorage, temporary works and sequencing interfaces.'),
    DubaiPart1Item(title: 'HSE Manager', detail: 'Set project governance for work-at-height assurance and escalation.'),
  ],
);

// Topics 9 and 10
final List<DubaiPart1Section> _confinedSections = _standardSections(
  topic: 'Confined Space Entry',
  intro:
      'Confined-space entry requires identification of the space, assessment of hazards, isolation, atmospheric control, communication, standby arrangements and a realistic rescue plan.',
  types: [
    DubaiPart1Item(title: 'Permit-Controlled Entry', detail: 'Formal entry arrangement with defined conditions, authorisation and controls.'),
    DubaiPart1Item(title: 'Tank / Vessel Entry', detail: 'Entry into enclosed equipment requiring isolation and atmospheric assessment.'),
    DubaiPart1Item(title: 'Manhole / Chamber Entry', detail: 'Entry into underground or enclosed chambers with atmospheric and access risks.'),
    DubaiPart1Item(title: 'Emergency Entry', detail: 'Only under an authorised emergency-response arrangement with suitable rescue controls.'),
  ],
  components: [
    DubaiPart1Item(title: 'Isolation / LOTO', detail: 'Prevent hazardous energy or connected services from creating exposure.'),
    DubaiPart1Item(title: 'Gas Detector', detail: 'Use suitable calibrated monitoring equipment and follow the approved testing regime.'),
    DubaiPart1Item(title: 'Ventilation', detail: 'Provide suitable ventilation where required by the hazard assessment.'),
    DubaiPart1Item(title: 'Standby Attendant', detail: 'Maintain the required communication and entry monitoring function.'),
    DubaiPart1Item(title: 'Rescue Equipment', detail: 'Provide equipment and trained responders appropriate to the credible rescue scenario.'),
  ],
  planning: [
    DubaiPart1Item(title: 'Space Assessment', detail: 'Identify access, egress, atmospheric, physical and process hazards.'),
    DubaiPart1Item(title: 'Isolation Plan', detail: 'Identify and control connected energy, process lines and hazardous sources.'),
    DubaiPart1Item(title: 'Atmospheric Plan', detail: 'Define testing, monitoring, ventilation and response requirements.'),
  ],
  hazards: [
    DubaiPart1Item(title: 'Oxygen Deficiency', detail: 'Low oxygen can rapidly impair judgement and cause collapse.'),
    DubaiPart1Item(title: 'Toxic Atmosphere', detail: 'Contaminants may cause acute or delayed harm.'),
    DubaiPart1Item(title: 'Flammable Atmosphere', detail: 'Ignition can cause fire or explosion.'),
    DubaiPart1Item(title: 'Engulfment / Physical Hazard', detail: 'Material, water, moving equipment or internal hazards can trap entrants.'),
  ],
  controls: [
    DubaiPart1Item(title: 'Atmospheric Testing', detail: 'Test before entry and continue monitoring where required by the assessment.'),
    DubaiPart1Item(title: 'Positive Isolation', detail: 'Verify isolation before entry and control changes during the task.'),
    DubaiPart1Item(title: 'Standby & Communication', detail: 'Maintain reliable communication and a competent standby arrangement.'),
  ],
  inspection: [
    DubaiPart1Item(title: 'Permit Verification', detail: 'Confirm required conditions, authorisation and controls before entry.'),
    DubaiPart1Item(title: 'Gas Test Verification', detail: 'Confirm monitoring equipment status and results are suitable for entry.'),
    DubaiPart1Item(title: 'Rescue Readiness', detail: 'Verify rescue equipment, access and trained response capability.'),
  ],
  stop: [
    DubaiPart1Item(title: 'Unsafe Atmosphere', detail: 'Stop entry and remove entrants when atmospheric conditions are outside the approved safe range.'),
    DubaiPart1Item(title: 'Isolation Lost', detail: 'Stop immediately if required isolation cannot be maintained or verified.'),
    DubaiPart1Item(title: 'Rescue Unavailable', detail: 'Do not start or continue entry if the planned rescue capability is not ready.'),
  ],
  emergency: [
    DubaiPart1Item(title: 'Entrant Collapse', detail: 'Raise the alarm and activate the planned rescue response; do not enter impulsively and create a second casualty.'),
    DubaiPart1Item(title: 'Atmospheric Alarm', detail: 'Stop entry, evacuate as required and follow the site emergency procedure.'),
  ],
  example: [
    DubaiPart1Item(title: 'Manhole Entry', detail: 'The team isolates connected services, tests the atmosphere, establishes ventilation and standby communication and confirms rescue readiness before entry.'),
    DubaiPart1Item(title: 'Learning', detail: 'A rescue plan must be physically achievable and supported by trained personnel and suitable equipment.'),
  ],
  roles: [
    DubaiPart1Item(title: 'HSE Officer', detail: 'Verify permit conditions, gas testing, access, PPE, standby and rescue readiness.'),
    DubaiPart1Item(title: 'HSE Supervisor', detail: 'Coordinate field monitoring and intervene when entry controls are not maintained.'),
    DubaiPart1Item(title: 'Senior HSE', detail: 'Review high-risk entries, recurring deficiencies and emergency preparedness.'),
    DubaiPart1Item(title: 'HSE Coordinator', detail: 'Coordinate permits, training, gas-testing records and rescue documentation.'),
    DubaiPart1Item(title: 'HSE Engineer', detail: 'Review isolation, ventilation, process interfaces and technical hazards.'),
    DubaiPart1Item(title: 'HSE Manager', detail: 'Provide governance for confined-space programmes, competence and emergency assurance.'),
  ],
);

final List<DubaiPart1Section> _electricalSections = _standardSections(
  topic: 'Electrical Safety',
  intro:
      'Electrical safety controls exposure to shock, arc energy, fire and equipment failure through competent work, isolation, verification, protection and inspection.',
  types: [
    DubaiPart1Item(title: 'De-energised Work', detail: 'Work performed after suitable isolation and verification of the safe state.'),
    DubaiPart1Item(title: 'Energised Work', detail: 'Only where specifically justified, authorised and controlled by applicable requirements.'),
    DubaiPart1Item(title: 'Temporary Power', detail: 'Construction distribution requiring suitable protection, inspection and environmental controls.'),
    DubaiPart1Item(title: 'Electrical Testing', detail: 'Testing activities requiring competent personnel, controlled access and suitable instruments.'),
  ],
  components: [
    DubaiPart1Item(title: 'Isolation Point', detail: 'A clearly identified means of disconnecting the relevant energy source.'),
    DubaiPart1Item(title: 'LOTO Device', detail: 'Prevents unintended restoration of isolated energy.'),
    DubaiPart1Item(title: 'Protective Device', detail: 'Provides protection against relevant electrical fault conditions.'),
    DubaiPart1Item(title: 'Earthing / Bonding', detail: 'Provides the required protective path and reduces electrical risk when correctly designed and maintained.'),
    DubaiPart1Item(title: 'Cable Management', detail: 'Protect cables from mechanical damage, water, traffic and uncontrolled routing.'),
    DubaiPart1Item(title: 'Distribution Board', detail: 'Must be suitable, protected, identified and accessible to authorised personnel.'),
  ],
  planning: [
    DubaiPart1Item(title: 'Isolation Planning', detail: 'Identify energy sources, isolation points and verification steps before work.'),
    DubaiPart1Item(title: 'Competent Personnel', detail: 'Assign electrical work to appropriately competent and authorised persons.'),
    DubaiPart1Item(title: 'Temporary Power Planning', detail: 'Plan distribution, protection, inspection, access and environmental controls.'),
  ],
  hazards: [
    DubaiPart1Item(title: 'Electric Shock', detail: 'Contact with live or unexpectedly energised parts can cause serious injury or death.'),
    DubaiPart1Item(title: 'Arc / Flash', detail: 'Fault energy can cause burns, blast effects and secondary injury.'),
    DubaiPart1Item(title: 'Electrical Fire', detail: 'Overload, fault, poor connections or damaged equipment can initiate fire.'),
    DubaiPart1Item(title: 'Unexpected Energisation', detail: 'Failure of isolation or control can expose workers to live energy.'),
  ],
  controls: [
    DubaiPart1Item(title: 'Isolation & Verification', detail: 'Isolate the relevant energy and verify the safe state before work.'),
    DubaiPart1Item(title: 'LOTO', detail: 'Control the isolation against unauthorised or unintended restoration.'),
    DubaiPart1Item(title: 'Restricted Access', detail: 'Control access to electrical installations and exposed conductors.'),
    DubaiPart1Item(title: 'Inspection & Testing', detail: 'Maintain required inspection and testing arrangements for electrical systems and equipment.'),
  ],
  inspection: [
    DubaiPart1Item(title: 'Pre-Use Check', detail: 'Inspect tools, leads, plugs, guards and visible condition before use.'),
    DubaiPart1Item(title: 'Distribution Check', detail: 'Verify boards, protection, identification, access and environmental condition.'),
    DubaiPart1Item(title: 'Isolation Check', detail: 'Confirm the correct circuit or equipment is isolated and the safe state is verified.'),
  ],
  stop: [
    DubaiPart1Item(title: 'Isolation Not Verified', detail: 'Do not start or continue work when the safe state cannot be demonstrated.'),
    DubaiPart1Item(title: 'Damaged Equipment', detail: 'Remove damaged electrical equipment from service.'),
    DubaiPart1Item(title: 'Unsafe Temporary Power', detail: 'Stop affected use when protection, routing or environmental controls are inadequate.'),
  ],
  emergency: [
    DubaiPart1Item(title: 'Electrical Contact', detail: 'Do not touch the casualty until the electrical hazard is controlled; activate the emergency response.'),
    DubaiPart1Item(title: 'Electrical Fire', detail: 'Raise the alarm, isolate energy where safe and use the site emergency/fire response arrangement.'),
  ],
  example: [
    DubaiPart1Item(title: 'Temporary Distribution', detail: 'A damaged cable is found feeding a work area. The circuit is controlled, equipment is removed from service and the arrangement is corrected and verified before reuse.'),
    DubaiPart1Item(title: 'Learning', detail: 'Electrical safety depends on verified isolation, suitable equipment and disciplined access control.'),
  ],
  roles: [
    DubaiPart1Item(title: 'HSE Officer', detail: 'Monitor electrical controls, access, cable condition, LOTO and field compliance.'),
    DubaiPart1Item(title: 'HSE Supervisor', detail: 'Coordinate daily electrical-safety checks and follow up unsafe conditions.'),
    DubaiPart1Item(title: 'Senior HSE', detail: 'Review significant electrical risks, recurring findings and high-risk work.'),
    DubaiPart1Item(title: 'HSE Coordinator', detail: 'Coordinate inspection, training, LOTO and electrical documentation records.'),
    DubaiPart1Item(title: 'HSE Engineer', detail: 'Review technical electrical interfaces, temporary power and isolation assumptions.'),
    DubaiPart1Item(title: 'HSE Manager', detail: 'Provide governance, competent-resource assurance and escalation for serious electrical risks.'),
  ],
);

// Topic 6 scaffolding is intentionally kept dedicated elsewhere.
// This part routes it to the existing professional scaffold page.
final List<DubaiPart1Section> _scaffoldSections = const [];

