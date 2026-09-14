import 'package:flutter/material.dart';

/// SafeNexus HSE — Dubai HSE Part 1 Advanced Learning
/// Multi-level professional learning for Topics 1–10.
/// Each topic contains tappable sub-topics leading to a deeper detail page.
class DubaiHsePart1AdvancedLearningPage extends StatelessWidget {
  final String topicId;
  final String topicTitle;

  const DubaiHsePart1AdvancedLearningPage({
    super.key, required this.topicId, required this.topicTitle,
  });

  static const Map<String, DubaiAdvancedTopic> _topics = {
    "dubai_construction_safety_framework": DubaiAdvancedTopic(
      title: "Dubai Construction Safety Framework",
      sections: [
        DubaiAdvancedSubTopic(
          title: "Governance & Accountability",
          summary: "Defines client, consultant, contractor, subcontractor and workforce duties.",
          focus: "responsibility, reporting lines, authority, escalation",
          hazards: "Unclear authority, conflicting instructions, uncontrolled interfaces",
          verification: "Verify organization chart, reporting lines and stop-work authority.",
        ),
        DubaiAdvancedSubTopic(
          title: "Project HSE Planning",
          summary: "Converts project requirements into practical HSE arrangements.",
          focus: "HSE plan, RAMS, permits, emergency planning",
          hazards: "High-risk work starts without adequate planning",
          verification: "Check approved documents against actual work sequence.",
        ),
        DubaiAdvancedSubTopic(
          title: "Contractor Interface Control",
          summary: "Controls multiple contractors working under one project system.",
          focus: "prequalification, induction, coordination, supervision",
          hazards: "Different standards, simultaneous operations, communication gaps",
          verification: "Verify contractor alignment and interface meetings.",
        ),
        DubaiAdvancedSubTopic(
          title: "Field Verification",
          summary: "Tests whether the written HSE system is actually implemented.",
          focus: "inspection, observation, worker interview, evidence",
          hazards: "Paper compliance, repeated findings",
          verification: "Compare approved method with workface conditions.",
        ),
        DubaiAdvancedSubTopic(
          title: "Corrective Action",
          summary: "Controls findings through ownership, deadlines and effectiveness checks.",
          focus: "action owner, due date, evidence, effectiveness",
          hazards: "Repeated or overdue critical findings",
          verification: "Verify closure and confirm the underlying cause was controlled.",
        ),
      ],
    ),
    "dubai_hse_management_system": DubaiAdvancedTopic(
      title: "HSE Management System",
      sections: [
        DubaiAdvancedSubTopic(
          title: "Leadership & Commitment",
          summary: "Management establishes direction, resources and visible HSE leadership.",
          focus: "policy, objectives, leadership tours, resources",
          hazards: "Weak ownership, insufficient resources",
          verification: "Verify management actions and resource availability.",
        ),
        DubaiAdvancedSubTopic(
          title: "Planning & Objectives",
          summary: "Sets measurable HSE goals based on project risks.",
          focus: "objectives, indicators, risk priorities",
          hazards: "Unmeasurable goals, risk not reflected in planning",
          verification: "Check objectives against significant project risks.",
        ),
        DubaiAdvancedSubTopic(
          title: "Implementation & Communication",
          summary: "Makes procedures, RAMS, permits and training usable at the workface.",
          focus: "competence, communication, document control",
          hazards: "Workers unaware of controls, uncontrolled documents",
          verification: "Interview workers and verify current approved documents.",
        ),
        DubaiAdvancedSubTopic(
          title: "Monitoring & Audit",
          summary: "Measures system performance through planned assurance activities.",
          focus: "inspection, audit, observations, trends",
          hazards: "Findings not analysed, recurring failures",
          verification: "Review trends rather than isolated findings.",
        ),
        DubaiAdvancedSubTopic(
          title: "Continual Improvement",
          summary: "Uses incidents, audits and trends to improve the management system.",
          focus: "lessons learned, root cause, management review",
          hazards: "Same failure repeated",
          verification: "Verify improvement after corrective action.",
        ),
      ],
    ),
    "dubai_health_safety_risk_assessment": DubaiAdvancedTopic(
      title: "Health & Safety Risk Assessment",
      sections: [
        DubaiAdvancedSubTopic(
          title: "Hazard Identification",
          summary: "Identifies hazards from people, plant, materials, energy, environment and interfaces.",
          focus: "task sequence, equipment, simultaneous operations",
          hazards: "Missed hazards, generic assessments",
          verification: "Walk the workface and compare it with the assessment.",
        ),
        DubaiAdvancedSubTopic(
          title: "Risk Evaluation",
          summary: "Ranks risk using the approved project methodology.",
          focus: "likelihood, consequence, risk matrix",
          hazards: "Incorrect ranking, underestimated consequence",
          verification: "Confirm the approved matrix is used consistently.",
        ),
        DubaiAdvancedSubTopic(
          title: "Hierarchy of Controls",
          summary: "Selects controls in order of effectiveness.",
          focus: "elimination, substitution, engineering, administrative, PPE",
          hazards: "Over-reliance on PPE or paperwork",
          verification: "Check whether higher-level controls are reasonably practicable.",
        ),
        DubaiAdvancedSubTopic(
          title: "Dynamic Risk Assessment",
          summary: "Updates controls when conditions change.",
          focus: "change management, weather, design, method",
          hazards: "Uncontrolled change",
          verification: "Stop and reassess significant deviations.",
        ),
        DubaiAdvancedSubTopic(
          title: "Critical Control Verification",
          summary: "Confirms controls that must be present before work proceeds.",
          focus: "critical controls, verification, supervision",
          hazards: "Control exists on paper but not in field",
          verification: "Physically verify critical controls.",
        ),
      ],
    ),
    "dubai_construction_hse_plan": DubaiAdvancedTopic(
      title: "Construction HSE Plan",
      sections: [
        DubaiAdvancedSubTopic(
          title: "Project Scope & HSE Organization",
          summary: "Defines how HSE will be managed across project phases and work packages.",
          focus: "scope, organization, roles, interfaces",
          hazards: "Gaps between phases or contractors",
          verification: "Check responsibilities against current construction activities.",
        ),
        DubaiAdvancedSubTopic(
          title: "RAMS & Permit Integration",
          summary: "Connects project HSE planning to task-level execution.",
          focus: "RAMS, risk assessments, permits, approvals",
          hazards: "Documents disconnected from actual work",
          verification: "Verify work is performed to the approved method.",
        ),
        DubaiAdvancedSubTopic(
          title: "Competence & Training",
          summary: "Ensures safety-critical people are trained and authorized.",
          focus: "induction, training, authorization, competence records",
          hazards: "Unverified competence",
          verification: "Sample records and verify field competence.",
        ),
        DubaiAdvancedSubTopic(
          title: "Emergency Preparedness",
          summary: "Plans credible emergencies and response resources.",
          focus: "alarm, communication, first aid, rescue, access",
          hazards: "Generic or unavailable response arrangements",
          verification: "Conduct drills/tabletop checks and verify access.",
        ),
        DubaiAdvancedSubTopic(
          title: "HSE Performance Monitoring",
          summary: "Tracks leading and lagging performance.",
          focus: "inspections, audits, indicators, incidents",
          hazards: "Targets without action",
          verification: "Review trends and management response.",
        ),
      ],
    ),
    "dubai_work_at_height": DubaiAdvancedTopic(
      title: "Work at Height",
      sections: [
        DubaiAdvancedSubTopic(
          title: "Access System Selection",
          summary: "Selects the safest suitable access method for the task.",
          focus: "scaffold, mobile tower, MEWP, ladder, permanent access",
          hazards: "Wrong equipment, improvised access",
          verification: "Verify equipment is suitable for task, location and user.",
        ),
        DubaiAdvancedSubTopic(
          title: "Fall Prevention",
          summary: "Prevents a fall using collective measures before personal protection.",
          focus: "guardrails, platforms, edge protection, openings",
          hazards: "Unprotected edges/openings",
          verification: "Inspect all exposed edges and access routes.",
        ),
        DubaiAdvancedSubTopic(
          title: "Fall Protection",
          summary: "Adds restraint/fall-arrest where required after prevention measures.",
          focus: "harness, lanyard, anchorage, compatibility",
          hazards: "Poor anchorage, insufficient clearance",
          verification: "Verify compatibility and rescue method.",
        ),
        DubaiAdvancedSubTopic(
          title: "Falling Object Control",
          summary: "Prevents tools/materials from striking people below.",
          focus: "toe boards, securing, exclusion zones",
          hazards: "Dropped objects, poor housekeeping",
          verification: "Inspect overhead areas and exclusion zones.",
        ),
        DubaiAdvancedSubTopic(
          title: "Rescue Planning",
          summary: "Provides a realistic response after a fall or access emergency.",
          focus: "rescue equipment, trained responders, communication",
          hazards: "Delayed rescue, improvised rescue",
          verification: "Confirm rescue equipment and trained responders are available.",
        ),
      ],
    ),
    "dubai_scaffolding_safety": DubaiAdvancedTopic(
      title: "Scaffolding Safety",
      sections: [
        DubaiAdvancedSubTopic(
          title: "Scaffold Types",
          summary: "Selects scaffold configuration according to access, load and site conditions.",
          focus: "fixed, independent, tied, mobile, tower, suspended, cantilever, system, tube-and-fitting",
          hazards: "Wrong configuration, unsuitable use",
          verification: "Verify system and intended duty before use.",
        ),
        DubaiAdvancedSubTopic(
          title: "Scaffold Components",
          summary: "Explains standards, ledgers, transoms, bases, braces, ties, couplers, platforms and protection.",
          focus: "standards, ledgers, transoms, base plates, sole boards, braces, ties, couplers, guardrails, toe boards",
          hazards: "Missing or incompatible components",
          verification: "Check component condition and configuration.",
        ),
        DubaiAdvancedSubTopic(
          title: "Stability & Foundation",
          summary: "Controls settlement, movement and structural stability.",
          focus: "foundation, base arrangement, ties, bracing",
          hazards: "Settlement, instability, unauthorized alteration",
          verification: "Inspect foundation and stability controls.",
        ),
        DubaiAdvancedSubTopic(
          title: "Inspection & Tagging",
          summary: "Controls status identification and safe use.",
          focus: "inspection, tag/status system, handover",
          hazards: "Expired/unclear status, use of incomplete scaffold",
          verification: "Verify inspection status before access.",
        ),
        DubaiAdvancedSubTopic(
          title: "Modification & Dismantling",
          summary: "Controls changes and removal of scaffold components.",
          focus: "competent scaffold team, sequence, exclusion zone",
          hazards: "Removed ties/rails, falling components",
          verification: "Stop unauthorized modification and control dismantling.",
        ),
      ],
    ),
    "dubai_lifting_operations": DubaiAdvancedTopic(
      title: "Lifting Operations",
      sections: [
        DubaiAdvancedSubTopic(
          title: "Lift Planning",
          summary: "Defines load, crane configuration, route, landing area and controls.",
          focus: "weight, centre of gravity, radius, configuration, ground, weather",
          hazards: "Overload, unstable setup, wrong equipment",
          verification: "Verify plan against actual load and site.",
        ),
        DubaiAdvancedSubTopic(
          title: "Crane Setup",
          summary: "Controls ground/support, configuration and clearances.",
          focus: "outriggers, support, level, clearances",
          hazards: "Ground failure, contact, instability",
          verification: "Verify setup before lifting.",
        ),
        DubaiAdvancedSubTopic(
          title: "Rigging & Accessories",
          summary: "Controls slings, shackles, hooks and lifting beams.",
          focus: "WLL/capacity, condition, sling protection, connections",
          hazards: "Rigging failure, imbalance, dropped load",
          verification: "Inspect accessories and rigging before lift.",
        ),
        DubaiAdvancedSubTopic(
          title: "Communication & Exclusion",
          summary: "Prevents uncontrolled movement and personnel exposure.",
          focus: "banksman/signaller, signals, exclusion zone, tag line",
          hazards: "Miscommunication, line-of-fire exposure",
          verification: "Verify one recognized signaling system and controlled zone.",
        ),
        DubaiAdvancedSubTopic(
          title: "Pre-Lift & Stop Work",
          summary: "Confirms readiness and defines immediate stop conditions.",
          focus: "inspection, permits where applicable, weather, route",
          hazards: "Damaged accessory, changing conditions, loss of communication",
          verification: "Stop and reassess when a critical condition changes.",
        ),
      ],
    ),
    "dubai_excavation_trenching": DubaiAdvancedTopic(
      title: "Excavation & Trenching",
      sections: [
        DubaiAdvancedSubTopic(
          title: "Excavation Types",
          summary: "Selects controls for open, trench, foundation, deep, utility and chamber excavation.",
          focus: "excavation type, depth, ground conditions",
          hazards: "Wrong protection approach",
          verification: "Verify the protection method against actual conditions.",
        ),
        DubaiAdvancedSubTopic(
          title: "Protection Systems",
          summary: "Controls collapse using suitable engineered protection.",
          focus: "shoring, trench box, benching, sloping",
          hazards: "Collapse, ground movement",
          verification: "Inspect protective system before entry.",
        ),
        DubaiAdvancedSubTopic(
          title: "Underground Services",
          summary: "Prevents utility strikes and associated releases.",
          focus: "service drawings, locating, verification, protection",
          hazards: "Electric/gas/water/service strike",
          verification: "Confirm service information and field verification.",
        ),
        DubaiAdvancedSubTopic(
          title: "Water, Spoil & Plant",
          summary: "Controls water ingress, edge loading and plant interaction.",
          focus: "dewatering, spoil control, vehicle separation",
          hazards: "Collapse, flooding, plant entering excavation",
          verification: "Inspect edges, water and plant interface.",
        ),
        DubaiAdvancedSubTopic(
          title: "Inspection & Emergency",
          summary: "Maintains excavation safety after changes and incidents.",
          focus: "competent inspection, rescue, collapse/flooding response",
          hazards: "Entry into unstable excavation",
          verification: "Stop on instability or uncontrolled service/water conditions.",
        ),
      ],
    ),
    "dubai_confined_space_entry": DubaiAdvancedTopic(
      title: "Confined Space Entry",
      sections: [
        DubaiAdvancedSubTopic(
          title: "Entry Decision",
          summary: "Determines whether entry is necessary and defines hazards.",
          focus: "entry assessment, alternatives, task plan",
          hazards: "Unnecessary entry",
          verification: "Avoid entry where safe external work is possible.",
        ),
        DubaiAdvancedSubTopic(
          title: "Permit & Isolation",
          summary: "Controls process and energy sources before entry.",
          focus: "permit, isolation, LOTO, verification",
          hazards: "Unexpected flow/energy",
          verification: "Verify isolation before entry.",
        ),
        DubaiAdvancedSubTopic(
          title: "Atmospheric Testing",
          summary: "Checks atmosphere before and during controlled entry.",
          focus: "oxygen, flammable gas, toxic contaminants, monitoring",
          hazards: "Asphyxiation, poisoning, fire/explosion",
          verification: "Verify suitable testing and monitoring.",
        ),
        DubaiAdvancedSubTopic(
          title: "Ventilation & Communication",
          summary: "Maintains acceptable conditions and contact with entrants.",
          focus: "ventilation, communication, attendant",
          hazards: "Atmosphere deterioration, lost contact",
          verification: "Verify communication and ventilation arrangements.",
        ),
        DubaiAdvancedSubTopic(
          title: "Rescue",
          summary: "Provides planned recovery by trained responders.",
          focus: "rescue plan, equipment, attendant, emergency communication",
          hazards: "Unplanned rescue, secondary victim",
          verification: "Confirm rescue capability before entry.",
        ),
      ],
    ),
    "dubai_electrical_safety": DubaiAdvancedTopic(
      title: "Electrical Safety",
      sections: [
        DubaiAdvancedSubTopic(
          title: "Electrical Energy Identification",
          summary: "Maps sources and circuits before work.",
          focus: "supply, circuits, temporary power, generators",
          hazards: "Hidden or multiple energy sources",
          verification: "Identify all sources and interfaces.",
        ),
        DubaiAdvancedSubTopic(
          title: "Isolation & LOTO",
          summary: "Prevents unexpected energization.",
          focus: "isolation, lockout/tagout, test/verify",
          hazards: "Shock, arc event, re-energization",
          verification: "Verify isolation before work.",
        ),
        DubaiAdvancedSubTopic(
          title: "Temporary Power",
          summary: "Controls construction distribution and cable hazards.",
          focus: "DBs, cables, sockets, protection, routing",
          hazards: "Damage, water, unauthorized access",
          verification: "Inspect temporary systems and protection.",
        ),
        DubaiAdvancedSubTopic(
          title: "Electrical Equipment Inspection",
          summary: "Controls tools, leads and equipment condition.",
          focus: "pre-use checks, periodic inspection, defect removal",
          hazards: "Damaged insulation, faulty tools",
          verification: "Remove defective equipment from service.",
        ),
        DubaiAdvancedSubTopic(
          title: "Emergency & Stop Work",
          summary: "Controls response to shock, arc event and electrical fire.",
          focus: "alarm, isolation, first aid, emergency response",
          hazards: "Contact with live source",
          verification: "Do not approach live electrical contact until energy is made safe.",
        ),
      ],
    ),
  };

  DubaiAdvancedTopic get topic => _topics[topicId] ??
      const DubaiAdvancedTopic(title: 'Advanced Learning', sections: [
        DubaiAdvancedSubTopic(title: 'Topic not configured', summary: 'Select a configured Dubai HSE topic.', focus: '', hazards: '', verification: ''),
      ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8F7),
      appBar: AppBar(title: const Text('Advanced Learning', style: TextStyle(fontWeight: FontWeight.w700)), centerTitle: true),
      body: ListView(padding: const EdgeInsets.fromLTRB(16,16,16,30), children: [
        _header(),
        const SizedBox(height: 14),
        ...List<Widget>.generate(topic.sections.length, (i) => Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: _subTopicCard(context, i + 1, topic.sections[i]),
        )),
        _roleCard(context),
      ]),
    );
  }

  Widget _header() => Card(
    elevation: 0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
    child: Padding(padding: const EdgeInsets.all(18), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('Advanced Learning', style: TextStyle(fontWeight: FontWeight.w700)),
      const SizedBox(height: 7),
      Text(topic.title, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.w800)),
      const SizedBox(height: 8),
      const Text('Tap a sub-topic to open a deeper, topic-specific safety page.', style: TextStyle(height: 1.45)),
    ])),
  );

  Widget _subTopicCard(BuildContext context, int number, DubaiAdvancedSubTopic item) => Card(
    elevation: 0,
    margin: EdgeInsets.zero,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    child: InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DubaiHsePart1SubTopicPage(topicTitle: topic.title, subTopic: item))),
      child: Padding(padding: const EdgeInsets.all(15), child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(width: 30, child: Text('$number.', style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16))),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(item.title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15)),
          const SizedBox(height: 5),
          Text(item.summary, style: const TextStyle(fontSize: 13, height: 1.4)),
        ])),
        const SizedBox(width: 8),
        const Icon(Icons.chevron_right, size: 21),
      ])),
    ),
  );

  Widget _roleCard(BuildContext context) => Card(
    elevation: 0,
    margin: const EdgeInsets.only(top: 4),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    child: InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DubaiHsePart1RoleResponsibilitiesPage(topicTitle: topic.title))),
      child: const Padding(padding: EdgeInsets.all(16), child: Row(children: [
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('🦺 HSE Roles — Topic-specific Responsibilities', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
          SizedBox(height: 6),
          Text('Six HSE roles with responsibilities matched to this topic.', style: TextStyle(height: 1.4)),
        ])),
        Icon(Icons.chevron_right, size: 21),
      ])),
    ),
  );
}

class DubaiHsePart1SubTopicPage extends StatelessWidget {
  final String topicTitle;
  final DubaiAdvancedSubTopic subTopic;
  const DubaiHsePart1SubTopicPage({super.key, required this.topicTitle, required this.subTopic});

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: const Color(0xFFF6F8F7),
    appBar: AppBar(title: const Text('Advanced Detail', style: TextStyle(fontWeight: FontWeight.w700)), centerTitle: true),
    body: ListView(padding: const EdgeInsets.fromLTRB(16,16,16,30), children: [
      _hero(),
      const SizedBox(height: 12),
      _detail('1', 'What this controls', subTopic.summary),
      _detail('2', 'Professional Focus', subTopic.focus),
      _detail('3', 'Main Safety Risks', subTopic.hazards),
      _detail('4', 'Field Verification', subTopic.verification),
      _detail('5', 'Safe Response', 'If a critical control is missing, ineffective or materially different from the approved method, stop the activity, make the area safe and escalate through the project HSE process.'),
      _detail('6', 'Practical Learning', 'Confirm the approved method, competent personnel, required permits, equipment condition, interfaces, communication and emergency arrangements before work starts.'),
    ]),
  );

  Widget _hero() => Card(
    elevation: 0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
    child: Padding(padding: const EdgeInsets.all(18), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('Advanced Detail', style: TextStyle(fontWeight: FontWeight.w700)),
      const SizedBox(height: 7),
      Text(topicTitle, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
      const SizedBox(height: 5),
      Text(subTopic.title, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.w800)),
    ])),
  );

  Widget _detail(String number, String title, String body) => Card(
    elevation: 0, margin: const EdgeInsets.only(bottom: 10),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('$number.', style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16)),
        const SizedBox(width: 9),
        Expanded(child: Text(title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16))),
      ]),
      const SizedBox(height: 9),
      Text(body, style: const TextStyle(fontSize: 14, height: 1.5)),
    ])),
  );
}

class DubaiHsePart1RoleResponsibilitiesPage extends StatelessWidget {
  final String topicTitle;
  const DubaiHsePart1RoleResponsibilitiesPage({super.key, required this.topicTitle});

  static const Map<String, String> responsibilities = {
    "HSE Officer": "Field inspection, worker communication, evidence collection and immediate reporting of unsafe conditions.",
    "HSE Supervisor": "Daily workface control, crew briefing, supervisor coordination and immediate intervention.",
    "Senior HSE": "Senior assurance, trend analysis, challenge of weak controls and escalation of significant risks.",
    "HSE Coordinator": "Cross-contractor coordination, permits/interfaces, meetings, action tracking and HSE documentation.",
    "HSE Engineer": "Technical risk review, engineering controls, method/interface review and technical assurance.",
    "HSE Manager": "Governance, resources, management review, strategic assurance and accountability for significant HSE risks.",
  };

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: const Color(0xFFF6F8F7),
    appBar: AppBar(title: const Text('HSE Responsibilities', style: TextStyle(fontWeight: FontWeight.w700)), centerTitle: true),
    body: ListView(padding: const EdgeInsets.fromLTRB(16,16,16,30), children: [
      Card(elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)), child: Padding(padding: const EdgeInsets.all(18), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('🦺 HSE Roles', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
        const SizedBox(height: 7),
        Text(topicTitle, style: const TextStyle(fontWeight: FontWeight.w700)),
        const SizedBox(height: 7),
        const Text('Responsibilities are adapted to the HSE role and the work represented by this topic.', style: TextStyle(height: 1.45)),
      ]))),
      const SizedBox(height: 12),
      ...responsibilities.entries.map((e) => Card(elevation: 0, margin: const EdgeInsets.only(bottom: 9), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)), child: Padding(padding: const EdgeInsets.all(15), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(e.key, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
        const SizedBox(height: 7),
        Text(e.value, style: const TextStyle(fontSize: 14, height: 1.48)),
      ])))),
    ]),
  );
}

class DubaiAdvancedTopic {
  final String title;
  final List<DubaiAdvancedSubTopic> sections;
  const DubaiAdvancedTopic({required this.title, required this.sections});
}

class DubaiAdvancedSubTopic {
  final String title;
  final String summary;
  final String focus;
  final String hazards;
  final String verification;
  const DubaiAdvancedSubTopic({required this.title, required this.summary, required this.focus, required this.hazards, required this.verification});
}
