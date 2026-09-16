import 'package:flutter/material.dart';

import '../../models/reference_topic.dart';

/// SafeNexus HSE — Topic 04
/// Construction HSE Plan
///
/// Canonical file:
/// lib/pages/dubai/dubai_hse_construction_hse_plan_page.dart
///
/// This page keeps the topic in one Dart file:
/// Main Page + Advanced Learning + detailed expandable study content.
class DubaiHseConstructionHsePlanPage extends StatelessWidget {
  const DubaiHseConstructionHsePlanPage({
    super.key,
    required this.topic,
  });

  final ReferenceTopic topic;

  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color primaryGreen = Color(0xFF159447);
  static const Color background = Color(0xFFF5F8F7);
  static const Color navy = Color(0xFF17324D);
  static const Color card = Color(0xFFF8FAF7);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
        children: [
          _advancedLearningCard(context),
          const SizedBox(height: 14),
          _referenceNotice(),
          const SizedBox(height: 18),
          const Text(
            'Construction HSE Plan — Detailed Reference',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: navy,
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            'Tap any section to study the requirements, controls, field verification points and records.',
            style: TextStyle(fontSize: 13.5, height: 1.45, color: Color(0xFF667085)),
          ),
          const SizedBox(height: 12),
          ..._sections.map((section) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: _sectionTile(section),
              )),
          const SizedBox(height: 6),
          _fieldVerificationCard(),
          const SizedBox(height: 12),
          _documentEvidenceCard(),
          const SizedBox(height: 12),
          _professionalQuestionsCard(),
        ],
      ),
    );
  }

  Widget _advancedLearningCard(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(22),
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (_) => const DubaiHseConstructionHsePlanAdvancedLearningPage(),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 18, 14, 18),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF0B765D), Color(0xFF159447)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(22),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: .10),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Row(
            children: [
              CircleAvatar(
                radius: 39,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.menu_book_rounded,
                  color: darkGreen,
                  size: 34,
                ),
              ),
              SizedBox(width: 18),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '📚 Advanced Learning',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 7),
                    Text(
                      'Detailed HSE Plan study, field application, verification and professional reference',
                      style: TextStyle(
                        fontSize: 14.5,
                        height: 1.45,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right_rounded, color: Colors.white, size: 34),
            ],
          ),
        ),
      ),
    );
  }

  Widget _referenceNotice() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 15, 16, 15),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F6EF),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFD9E2D8)),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline_rounded, color: darkGreen, size: 28),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'Learning and field-reference aid. For actual compliance decisions, always follow the current applicable UAE/Dubai requirements, approved project procedures, RAMS, permits and competent technical instructions.',
              style: TextStyle(fontSize: 14, height: 1.55, color: Color(0xFF26352D)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTile(_PlanSection section) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      color: card,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(color: Colors.black.withValues(alpha: .07)),
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        iconColor: darkGreen,
        collapsedIconColor: const Color(0xFF52605A),
        leading: Icon(section.icon, color: darkGreen, size: 29),
        title: Text(
          section.title,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w800,
            color: Color(0xFF202820),
          ),
        ),
        subtitle: Text(
          section.subtitle,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 12.5, height: 1.35),
        ),
        children: [
          ...section.items.map((item) => _detailItem(item)),
        ],
      ),
    );
  }

  Widget _detailItem(String item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 5),
            child: Icon(Icons.check_circle_rounded, size: 16, color: darkGreen),
          ),
          const SizedBox(width: 9),
          Expanded(
            child: Text(
              item,
              style: const TextStyle(fontSize: 13.5, height: 1.55, color: Color(0xFF425466)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _fieldVerificationCard() {
    const items = [
      'Confirm the current approved HSE Plan revision is available at the project and workface.',
      'Compare actual activities, work sequence, workforce, equipment and interfaces with the approved plan.',
      'Verify that significant risks are reflected in RAMS, permits, briefings and field controls.',
      'Check critical controls physically rather than relying only on documents or signatures.',
      'Record findings, assign responsible persons and verify effective close-out.',
      'Escalate critical uncontrolled conditions and control affected work before restart.',
    ];
    return _simpleListCard('🔍 Field Verification Checklist', items);
  }

  Widget _documentEvidenceCard() {
    const items = [
      'Approved HSE Plan and revision history',
      'Project risk register / risk assessments',
      'RAMS and method statements',
      'Permit-to-work records where applicable',
      'Training, induction and competency records',
      'Inspection and audit records',
      'Emergency drill and readiness records',
      'Incident, near-miss and corrective-action records',
      'Contractor/subcontractor HSE records',
      'Management review and HSE performance reports',
    ];
    return _simpleListCard('📄 Typical Evidence / Records', items);
  }

  Widget _professionalQuestionsCard() {
    const questions = [
      'What is the difference between a Construction HSE Plan, a risk assessment and a RAMS document?',
      'How do you verify that an HSE Plan reflects the actual site activities?',
      'What evidence would you request during an HSE Plan implementation audit?',
      'When should an HSE Plan be reviewed or revised?',
      'How should contractor interfaces and simultaneous operations be controlled?',
      'How are PTW, RAMS, inspections and toolbox talks connected to the HSE Plan?',
      'What should happen when site conditions no longer match the approved safe system?',
      'How can HSE KPIs demonstrate whether the plan is being implemented effectively?',
    ];
    return _simpleListCard('🧠 Professional / Interview Questions', questions, numbered: true);
  }

  Widget _simpleListCard(String title, List<String> items, {bool numbered = false}) {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.black.withValues(alpha: .07)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: navy),
          ),
          const SizedBox(height: 12),
          ...items.asMap().entries.map(
                (entry) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
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
}

class _PlanSection {
  const _PlanSection({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.items,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final List<String> items;
}

const List<_PlanSection> _sections = [
  _PlanSection(
    title: 'Purpose & Scope',
    subtitle: 'Why the Construction HSE Plan exists and what it covers.',
    icon: Icons.menu_book_rounded,
    items: [
      'Define the purpose of the project HSE Plan and how it supports safe construction delivery.',
      'Define project boundaries, locations, phases, work packages, facilities and construction activities covered by the plan.',
      'Identify employees, contractors, subcontractors, visitors and other persons whose activities or presence may be affected.',
      'Explain interfaces with project procedures, risk assessments, RAMS, permits, emergency plans and environmental controls.',
      'Keep the scope aligned with actual project conditions and update affected arrangements when the project changes.',
    ],
  ),
  _PlanSection(
    title: 'HSE Objectives & Targets',
    subtitle: 'Project-level safety, health and environmental objectives.',
    icon: Icons.flag_rounded,
    items: [
      'Set clear HSE objectives that are relevant to the project risk profile and planned construction activities.',
      'Define measurable targets and indicators where practical so performance can be monitored.',
      'Include safety, occupational health and environmental priorities applicable to the project.',
      'Communicate objectives to management, supervision, contractors and workers who influence implementation.',
      'Review performance against objectives and use findings to improve the HSE management arrangements.',
    ],
  ),
  _PlanSection(
    title: 'HSE Organization & Responsibilities',
    subtitle: 'Roles, authority, accountability and reporting lines.',
    icon: Icons.groups_rounded,
    items: [
      'Define responsibilities of the Project Manager, HSE Manager, HSE Officers, engineers, supervisors, foremen and workers.',
      'Define contractor and subcontractor HSE responsibilities and coordination interfaces.',
      'Clarify who approves, implements, verifies, reports and escalates significant HSE matters.',
      'Define emergency roles such as first aiders, fire wardens and designated response personnel where applicable.',
      'Ensure competent people and adequate resources are available for assigned HSE responsibilities.',
    ],
  ),
  _PlanSection(
    title: 'Applicable Requirements',
    subtitle: 'Project, client, authority, procedure and technical requirements.',
    icon: Icons.gavel_rounded,
    items: [
      'Identify the applicable UAE/Dubai requirements, client requirements, project specifications and approved procedures relevant to the work.',
      'Maintain controlled access to applicable requirements and approved project documents.',
      'Translate applicable requirements into practical project controls, responsibilities and verification activities.',
      'Ensure permits, RAMS, method statements and specialist instructions are consistent with applicable project requirements.',
      'Review requirements when project scope, work methods or applicable obligations change.',
    ],
  ),
  _PlanSection(
    title: 'Risk Management',
    subtitle: 'Hazard identification, risk assessment and control integration.',
    icon: Icons.warning_amber_rounded,
    items: [
      'Identify hazards arising from construction activities, site conditions, interfaces, equipment, materials and simultaneous operations.',
      'Assess risks using the project-approved risk assessment methodology and document significant risks.',
      'Apply the hierarchy of controls, prioritising elimination and higher-order controls where reasonably practicable.',
      'Link significant risks and controls to RAMS, permits, inspections, supervision and worker briefings as applicable.',
      'Review risk controls when activities, sequence, environment, personnel, equipment or interfaces change.',
      'Use dynamic/task-level risk assessment where changing site conditions require immediate reassessment.',
    ],
  ),
  _PlanSection(
    title: 'RAMS & Method Statements',
    subtitle: 'Safe systems of work for specific construction activities.',
    icon: Icons.description_rounded,
    items: [
      'Define how activity-specific method statements and risk assessments are prepared, reviewed, approved and communicated.',
      'Ensure RAMS describes the work sequence, hazards, controls, responsibilities, resources, competency and emergency arrangements.',
      'Confirm RAMS matches the actual workface before work starts and when conditions change.',
      'Brief affected personnel on relevant RAMS requirements and maintain required evidence of communication.',
      'Control revisions so obsolete RAMS are not used for current work.',
    ],
  ),
  _PlanSection(
    title: 'Training & Competency',
    subtitle: 'Ensure people are prepared and competent for assigned work.',
    icon: Icons.school_rounded,
    items: [
      'Define site induction and orientation requirements before personnel enter or commence work.',
      'Identify task-specific training and competency requirements for high-risk or specialist activities.',
      'Control operator authorisation and role-specific competency where required by the project system.',
      'Use toolbox talks, pre-task briefings and safety communications to address current hazards and critical controls.',
      'Maintain training, induction, competency and refresher records as required by the project.',
    ],
  ),
  _PlanSection(
    title: 'PPE Management',
    subtitle: 'Selection, issue, use, inspection and replacement of PPE.',
    icon: Icons.health_and_safety_rounded,
    items: [
      'Define minimum site PPE and additional task-specific PPE based on identified hazards.',
      'Select PPE appropriate to the hazard, work activity, fit, compatibility and operating conditions.',
      'Provide arrangements for issue, inspection, cleaning, storage, replacement and defect reporting.',
      'Supervisors should verify correct use and address non-compliance promptly.',
      'PPE should complement, not replace, higher-order risk controls where those controls are practicable.',
    ],
  ),
  _PlanSection(
    title: 'Site Access & Work-Zone Control',
    subtitle: 'Control people, vehicles, visitors and restricted work areas.',
    icon: Icons.directions_walk_rounded,
    items: [
      'Define site entry arrangements, visitor controls and access permissions.',
      'Provide suitable pedestrian routes and segregate people from moving vehicles and mobile equipment where required.',
      'Control restricted areas, hazardous zones, temporary openings, excavations and active workfaces.',
      'Use suitable signage, barricading and physical controls to communicate hazards and prevent unauthorised access.',
      'Maintain access and emergency routes clear and usable throughout construction activities.',
    ],
  ),
  _PlanSection(
    title: 'Construction Activity Controls',
    subtitle: 'Detailed planning for major construction work activities.',
    icon: Icons.construction_rounded,
    items: [
      'Address excavation and trenching, scaffolding, work at height, lifting operations and crane activities.',
      'Address MEWP, mobile equipment, temporary works, formwork, reinforcement and concreting activities.',
      'Address demolition, hot work, welding, cutting, grinding, hand tools and power tools as applicable.',
      'Address electrical work, confined space entry, material handling, manual handling and road/interface work.',
      'Define activity-specific controls through approved RAMS, permits, competent supervision and field verification.',
    ],
  ),
  _PlanSection(
    title: 'Plant, Machinery & Equipment',
    subtitle: 'Safe selection, inspection, operation and maintenance.',
    icon: Icons.precision_manufacturing_rounded,
    items: [
      'Ensure plant and equipment are suitable for the intended task, environment and load or capacity requirements.',
      'Define pre-use inspection, periodic inspection, maintenance and defect-reporting arrangements.',
      'Verify operator competency and authorisation for relevant equipment.',
      'Control unsafe or defective equipment so it is not returned to service before appropriate correction and verification.',
      'Maintain required equipment records, inspection evidence and certification where applicable.',
    ],
  ),
  _PlanSection(
    title: 'Electrical Safety',
    subtitle: 'Construction power, tools, cables, distribution and isolation.',
    icon: Icons.electrical_services_rounded,
    items: [
      'Control temporary electrical installations, distribution boards, cables, connections and protective devices.',
      'Provide appropriate inspection and maintenance arrangements for electrical tools and equipment.',
      'Protect cables and electrical equipment from mechanical damage, water and unsuitable environmental conditions.',
      'Control isolation and energy sources through approved procedures and competent persons.',
      'Remove damaged or unsafe electrical equipment from service and control its return only after suitable verification.',
    ],
  ),
  _PlanSection(
    title: 'Fire Prevention & Protection',
    subtitle: 'Prevent fire and maintain effective response capability.',
    icon: Icons.local_fire_department_rounded,
    items: [
      'Identify project fire hazards and define prevention and protection arrangements.',
      'Control hot work, ignition sources, combustible materials, gas cylinders and flammable substances.',
      'Provide suitable fire points, extinguishers and access arrangements appropriate to the work areas.',
      'Maintain emergency access, alarm, evacuation and fire-response arrangements.',
      'Use fire drills, inspections and fire-watch arrangements where applicable to the project work.',
    ],
  ),
  _PlanSection(
    title: 'Emergency Preparedness & Response',
    subtitle: 'Prepare for credible emergencies before they occur.',
    icon: Icons.emergency_rounded,
    items: [
      'Identify credible project emergencies and define response arrangements appropriate to the site.',
      'Define alarm, communication, evacuation, assembly, first aid, rescue and external assistance arrangements.',
      'Keep emergency routes, assembly areas, emergency contacts and response equipment available and communicated.',
      'Provide task-specific rescue arrangements for credible scenarios such as work at height or confined space where applicable.',
      'Conduct drills or exercises as required and use findings to improve emergency readiness.',
    ],
  ),
  _PlanSection(
    title: 'Occupational Health',
    subtitle: 'Manage health risks associated with construction work.',
    icon: Icons.medical_services_rounded,
    items: [
      'Identify occupational health hazards arising from dust, noise, vibration, chemicals, heat and other exposures.',
      'Define first-aid and medical-support arrangements appropriate to the project.',
      'Address health surveillance or monitoring where required by the project or applicable requirements.',
      'Consider fatigue, heat exposure, welfare and other work conditions that may affect worker health and safe performance.',
      'Provide worker awareness and reporting arrangements for occupational health concerns.',
    ],
  ),
  _PlanSection(
    title: 'Heat Stress Management',
    subtitle: 'Control hot-weather exposure and support worker wellbeing.',
    icon: Icons.wb_sunny_rounded,
    items: [
      'Plan work considering hot and humid conditions and applicable project requirements.',
      'Provide drinking water, suitable rest arrangements, shade/cooling and worker awareness controls.',
      'Plan work scheduling and exposure management according to the applicable project arrangements.',
      'Train workers and supervisors to recognise heat-stress symptoms and report concerns early.',
      'Provide response arrangements for workers showing signs of heat-related illness.',
    ],
  ),
  _PlanSection(
    title: 'Hazardous Substances & Chemicals',
    subtitle: 'Control chemical storage, handling, use and emergency response.',
    icon: Icons.science_rounded,
    items: [
      'Maintain an appropriate chemical inventory and ensure relevant safety information is available.',
      'Control labelling, storage, compatibility, handling and transportation of hazardous substances.',
      'Provide task-appropriate PPE and other controls based on the assessed exposure.',
      'Control spills, leaks and releases through suitable prevention and response arrangements.',
      'Ensure workers understand relevant chemical hazards, precautions and emergency actions.',
    ],
  ),
  _PlanSection(
    title: 'Environmental Management',
    subtitle: 'Prevent pollution and control construction environmental impacts.',
    icon: Icons.eco_rounded,
    items: [
      'Define construction waste segregation, storage, collection and disposal arrangements.',
      'Control dust, noise, spills, fuel storage, chemical releases and other project environmental risks.',
      'Maintain good housekeeping and pollution-prevention controls around work areas and storage locations.',
      'Define environmental inspection and reporting arrangements for significant impacts or incidents.',
      'Communicate relevant environmental controls to workers and contractors involved in affected activities.',
    ],
  ),
  _PlanSection(
    title: 'Housekeeping & Material Storage',
    subtitle: 'Maintain safe, orderly and accessible work areas.',
    icon: Icons.cleaning_services_rounded,
    items: [
      'Keep work areas, access routes, stairs, platforms and emergency paths clear of avoidable obstructions.',
      'Control waste, debris, loose materials and slip/trip hazards through planned housekeeping.',
      'Stack and store materials safely considering stability, access, load and interaction with other activities.',
      'Separate incompatible or hazardous materials and provide suitable storage arrangements.',
      'Include housekeeping in daily supervision and planned inspections.',
    ],
  ),
  _PlanSection(
    title: 'Traffic Management',
    subtitle: 'Control vehicles, mobile plant, pedestrians and deliveries.',
    icon: Icons.traffic_rounded,
    items: [
      'Define vehicle and pedestrian routes and provide segregation where required.',
      'Control reversing, blind spots, loading/unloading and interactions between mobile plant and workers.',
      'Use competent banksmen/signallers where required by the work arrangement.',
      'Control site speeds, parking, deliveries and temporary traffic changes.',
      'Review traffic arrangements when site layout, construction sequence or access conditions change.',
    ],
  ),
  _PlanSection(
    title: 'Inspection & Monitoring',
    subtitle: 'Verify that planned controls are operating in the field.',
    icon: Icons.search_rounded,
    items: [
      'Define daily, weekly and activity-specific inspection programmes appropriate to project risks.',
      'Inspect critical controls, plant, work areas, access, housekeeping and high-risk activities.',
      'Record findings with responsible persons, due dates and required corrective actions.',
      'Verify closure and effectiveness rather than closing actions only because a response was recorded.',
      'Use trends from inspections and observations to identify recurring control weaknesses.',
    ],
  ),
  _PlanSection(
    title: 'HSE Performance Monitoring',
    subtitle: 'Measure implementation and project HSE performance.',
    icon: Icons.bar_chart_rounded,
    items: [
      'Define relevant leading indicators such as inspections, training, toolbox talks, observations and action close-out.',
      'Monitor lagging indicators such as incidents and other project-defined performance measures.',
      'Review trends rather than relying only on single-period results.',
      'Use performance information to identify improvement needs, resource requirements and recurring risks.',
      'Include appropriate performance information in periodic HSE reporting and management review.',
    ],
  ),
  _PlanSection(
    title: 'Incident & Near-Miss Management',
    subtitle: 'Report, investigate, correct and learn from events.',
    icon: Icons.report_problem_rounded,
    items: [
      'Define arrangements for reporting incidents, near misses, unsafe conditions and significant HSE events.',
      'Provide appropriate immediate response, scene control and escalation arrangements.',
      'Investigate events using a structured approach that considers underlying and contributing causes.',
      'Assign corrective and preventive actions and verify effectiveness before closure.',
      'Communicate lessons learned and update affected procedures, RAMS, training or HSE arrangements when appropriate.',
    ],
  ),
  _PlanSection(
    title: 'HSE Communication',
    subtitle: 'Keep the workforce informed about current hazards and controls.',
    icon: Icons.campaign_rounded,
    items: [
      'Define formal and informal HSE communication channels appropriate to the project.',
      'Use toolbox talks, pre-task briefings, safety meetings, alerts and notice boards as applicable.',
      'Communicate changes in hazards, controls, work sequence and emergency arrangements.',
      'Ensure information reaches contractors, subcontractors and workers affected by the change.',
      'Maintain evidence of communication where records are required by the project system.',
    ],
  ),
  _PlanSection(
    title: 'Worker Consultation & Participation',
    subtitle: 'Use workforce knowledge to strengthen risk control.',
    icon: Icons.record_voice_over_rounded,
    items: [
      'Provide channels for workers to report hazards, unsafe conditions and improvement suggestions.',
      'Encourage participation in toolbox talks, safety meetings and task-level risk discussions.',
      'Use worker feedback to identify practical issues that may not be visible during document-based planning.',
      'Communicate decisions and corrective actions back to affected workers where appropriate.',
      'Support reporting of safety concerns without relying only on formal inspection programmes.',
    ],
  ),
  _PlanSection(
    title: 'Permit to Work',
    subtitle: 'Control work requiring formal authorisation and defined precautions.',
    icon: Icons.assignment_turned_in_rounded,
    items: [
      'Define which activities require permits under the approved project system.',
      'Control permit request, review, authorisation, display, suspension, extension and closure arrangements.',
      'Integrate isolation, risk assessment, RAMS and verification requirements into permit-controlled work.',
      'Ensure permit conditions remain valid for the actual workface and current site conditions.',
      'Prevent work from continuing when required permit conditions are absent, expired or no longer valid.',
    ],
  ),
  _PlanSection(
    title: 'Lockout / Isolation Controls',
    subtitle: 'Prevent unexpected release of hazardous energy.',
    icon: Icons.lock_rounded,
    items: [
      'Identify relevant energy sources and define approved isolation arrangements.',
      'Apply locking, tagging and verification processes through authorised competent personnel.',
      'Verify isolation and safe condition before work starts where required by the task.',
      'Control restoration of energy after work, including removal of locks/tags and confirmation of readiness.',
      'Maintain appropriate records and coordination when multiple people or work groups are involved.',
    ],
  ),
  _PlanSection(
    title: 'Temporary Works',
    subtitle: 'Plan, approve, inspect and control temporary structures and arrangements.',
    icon: Icons.foundation_rounded,
    items: [
      'Identify temporary works such as formwork, shoring, propping, temporary access and support arrangements.',
      'Define design, review, approval and inspection responsibilities appropriate to the project.',
      'Control loading, modification, sequencing and removal of temporary works.',
      'Prevent unauthorised alteration or removal of critical temporary supports.',
      'Inspect temporary works after relevant changes, events or conditions that could affect integrity.',
    ],
  ),
  _PlanSection(
    title: 'Welfare Facilities',
    subtitle: 'Provide suitable worker welfare arrangements.',
    icon: Icons.water_drop_rounded,
    items: [
      'Provide access to drinking water and suitable welfare facilities appropriate to project conditions.',
      'Maintain toilets, washing facilities, rest areas and hygiene arrangements.',
      'Provide shade/cooling arrangements where needed for environmental conditions and work activities.',
      'Inspect welfare facilities and correct deficiencies promptly.',
      'Communicate welfare arrangements and reporting channels to the workforce.',
    ],
  ),
  _PlanSection(
    title: 'Document Control',
    subtitle: 'Keep the HSE Plan and supporting documents controlled and traceable.',
    icon: Icons.folder_copy_rounded,
    items: [
      'Control HSE Plan numbering, revision status, approval, distribution and access.',
      'Ensure current versions of procedures, RAMS, forms and supporting documents are available to users.',
      'Prevent obsolete or superseded documents from being used for current work.',
      'Maintain revision history and required records according to the project document-control system.',
      'Control changes so affected personnel receive the correct revised information before relying on it.',
    ],
  ),
  _PlanSection(
    title: 'HSE Plan Review & Revision',
    subtitle: 'Keep the plan aligned with the changing project.',
    icon: Icons.update_rounded,
    items: [
      'Review the plan at planned intervals established by the project system and whenever significant change occurs.',
      'Trigger review when scope, organisation, work methods, site conditions, significant risks or interfaces change.',
      'Consider incident findings, audit results, inspection trends and lessons learned during review.',
      'Obtain required approval for revisions and communicate changes to affected personnel.',
      'Verify implementation of revised controls in the field after significant changes.',
    ],
  ),
  _PlanSection(
    title: 'Contractor & Subcontractor HSE Management',
    subtitle: 'Control interfaces and shared responsibilities.',
    icon: Icons.handshake_rounded,
    items: [
      'Define contractor HSE expectations, responsibilities, reporting and coordination requirements.',
      'Review relevant contractor HSE arrangements, RAMS and competency information before affected work starts.',
      'Control interfaces between contractors, simultaneous operations, shared access and common work areas.',
      'Monitor contractor performance through inspections, meetings, observations and audits as appropriate.',
      'Escalate unresolved interface risks and verify corrective actions.',
    ],
  ),
  _PlanSection(
    title: 'Audit & Compliance Verification',
    subtitle: 'Test whether the management arrangements are implemented effectively.',
    icon: Icons.fact_check_rounded,
    items: [
      'Define an audit and assurance programme appropriate to the project risk and organisational structure.',
      'Test both documented arrangements and field implementation of critical controls.',
      'Record findings clearly, assign actions and establish realistic close-out requirements.',
      'Verify effectiveness of corrective actions and identify recurring system weaknesses.',
      'Use audit results as an input to management review and HSE Plan improvement.',
    ],
  ),
  _PlanSection(
    title: 'Management Review',
    subtitle: 'Leadership review of HSE performance and system effectiveness.',
    icon: Icons.manage_accounts_rounded,
    items: [
      'Review HSE performance, significant risks, incidents, audit results, inspections and open actions.',
      'Consider whether resources, competency, supervision and controls remain adequate for current work.',
      'Review significant changes and determine whether the HSE Plan or supporting arrangements require revision.',
      'Track decisions, responsibilities and improvement actions resulting from management review.',
      'Communicate relevant decisions to those responsible for implementation.',
    ],
  ),
  _PlanSection(
    title: 'Lessons Learned & Continual Improvement',
    subtitle: 'Use experience and evidence to strengthen the HSE system.',
    icon: Icons.lightbulb_rounded,
    items: [
      'Capture lessons from incidents, near misses, inspections, audits, worker feedback and successful controls.',
      'Share relevant learning with affected teams, contractors and management.',
      'Update procedures, RAMS, training, risk controls or the HSE Plan when learning identifies a needed change.',
      'Track improvement actions to completion and verify that changes deliver the intended control.',
      'Use continual improvement to keep the project HSE system practical, current and risk-based.',
    ],
  ),
];

/// Advanced Learning is intentionally in the same canonical topic file.
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
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
        children: [
          _header(),
          const SizedBox(height: 14),
          ..._advancedModules.map((module) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: _module(module),
              )),
          _advancedChecklist(),
          const SizedBox(height: 12),
          _advancedQuestions(),
        ],
      ),
    );
  }

  Widget _header() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0B765D), Color(0xFF159447)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Construction HSE Plan — Advanced Study',
            style: TextStyle(fontSize: 21, fontWeight: FontWeight.w800, color: Colors.white),
          ),
          SizedBox(height: 8),
          Text(
            'Deep study for HSE professionals: planning, implementation, field verification, evidence, review and continual improvement.',
            style: TextStyle(fontSize: 14, height: 1.5, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _module(_AdvancedModule module) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(17),
        side: BorderSide(color: Colors.black.withValues(alpha: .07)),
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        leading: CircleAvatar(
          radius: 21,
          backgroundColor: const Color(0xFFE8F5ED),
          child: Text(
            module.number,
            style: const TextStyle(fontWeight: FontWeight.w800, color: darkGreen),
          ),
        ),
        title: Text(
          module.title,
          style: const TextStyle(fontWeight: FontWeight.w800, color: navy),
        ),
        subtitle: Text(module.subtitle),
        children: module.points
            .map(
              (point) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Icon(Icons.check_circle_rounded, size: 15, color: darkGreen),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        point,
                        style: const TextStyle(fontSize: 13.5, height: 1.55, color: Color(0xFF425466)),
                      ),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _advancedChecklist() {
    const items = [
      'Current approved HSE Plan and revision status verified.',
      'Project scope and construction sequence reflected in the plan.',
      'Significant risks connected to RAMS, permits and field controls.',
      'Roles, responsibilities, competence and resources clearly established.',
      'Emergency arrangements are available, communicated and tested as required.',
      'Contractor interfaces and simultaneous operations are controlled.',
      'Inspection, audit, monitoring and corrective-action systems are active.',
      'Document changes are controlled and communicated.',
      'Plan is reviewed after significant changes, events or learning.',
      'Field evidence demonstrates implementation rather than document-only compliance.',
    ];
    return _listCard('🔍 Advanced Field Verification', items);
  }

  Widget _advancedQuestions() {
    const questions = [
      'How do you establish whether a Construction HSE Plan is project-specific rather than generic?',
      'Which documents should be cross-checked against the HSE Plan during a field verification?',
      'How should a significant change in work sequence trigger HSE Plan and risk-control review?',
      'What evidence demonstrates that workers were actually briefed on changed controls?',
      'How do you verify the effectiveness of a corrective action after an audit finding?',
      'How should contractor interfaces be reflected in the project HSE planning process?',
      'What conditions should trigger escalation and control of affected work before restart?',
      'How can HSE performance data support continual improvement of the plan?',
    ];
    return _listCard('🧠 Advanced Professional Questions', questions, numbered: true);
  }

  Widget _listCard(String title, List<String> items, {bool numbered = false}) {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.black.withValues(alpha: .07)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: navy)),
          const SizedBox(height: 12),
          ...items.asMap().entries.map(
                (entry) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
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

const List<_AdvancedModule> _advancedModules = [
  _AdvancedModule(
    number: '01',
    title: 'HSE Plan Fundamentals',
    subtitle: 'Purpose, scope, interfaces and practical implementation.',
    points: [
      'A Construction HSE Plan should organise the project approach to health, safety and environmental risk control rather than function only as an approval document.',
      'The plan should reflect actual project scope, construction sequence, workforce, contractors, work locations and significant hazards.',
      'The plan should connect management arrangements with operational documents such as risk assessments, RAMS, permits, inspections and emergency arrangements.',
    ],
  ),
  _AdvancedModule(
    number: '02',
    title: 'Project-Specific Planning',
    subtitle: 'Avoid generic planning and establish controls for the actual project.',
    points: [
      'Start with project scope, work packages, interfaces, resources, construction phases and credible hazards.',
      'Identify where project conditions differ from previous work and make the plan specific to those conditions.',
      'Use evidence from design, planning, risk assessment, site surveys, contractor information and work sequencing to develop controls.',
    ],
  ),
  _AdvancedModule(
    number: '03',
    title: 'Risk & Control Integration',
    subtitle: 'Make the plan work together with risk-management processes.',
    points: [
      'The project risk register should identify significant risks and interfaces requiring management attention.',
      'Controls should be reflected in relevant RAMS, permits, inspections, supervision and workforce communication.',
      'When conditions change, reassess affected risks and confirm that controls remain suitable before work continues.',
    ],
  ),
  _AdvancedModule(
    number: '04',
    title: 'RAMS & PTW Interface',
    subtitle: 'Connect the project plan to task-level safe systems of work.',
    points: [
      'RAMS should explain the safe sequence and controls for specific activities and remain aligned with the project HSE Plan.',
      'Permit-controlled activities require formal authorisation and verification of specified precautions where applicable.',
      'The workface should be checked against the approved RAMS and permit conditions before exposure begins and during changing conditions.',
    ],
  ),
  _AdvancedModule(
    number: '05',
    title: 'Field Verification Method',
    subtitle: 'A practical sequence for an HSE Officer or Supervisor.',
    points: [
      'Review the current approved plan, relevant RAMS, permits and known significant risks before entering the workface.',
      'Observe the actual activity, people, equipment, environment, access, interfaces and critical controls.',
      'Compare what is happening with what was planned; record gaps and verify immediate controls for significant exposure.',
      'Track corrective action to effective closure and feed recurring issues back into the management system.',
    ],
  ),
  _AdvancedModule(
    number: '06',
    title: 'Competency & Workforce Communication',
    subtitle: 'Turn written controls into understood work practices.',
    points: [
      'Identify competency requirements for supervisors, operators, specialist workers and other safety-critical roles.',
      'Use induction, toolbox talks and pre-task briefings to communicate hazards, controls, changes and emergency arrangements.',
      'Verify understanding through practical supervision, questions, observations and competency evidence where appropriate.',
    ],
  ),
  _AdvancedModule(
    number: '07',
    title: 'Emergency Readiness',
    subtitle: 'Prepare credible response arrangements before an emergency.',
    points: [
      'Identify credible emergencies based on the actual project activities and environment.',
      'Confirm alarm, communication, evacuation, assembly, first-aid, rescue and external-assistance arrangements.',
      'Use drills, exercises, inspections and learning from events to test and improve readiness.',
    ],
  ),
  _AdvancedModule(
    number: '08',
    title: 'Contractor Interface Control',
    subtitle: 'Manage shared risks between organisations and work packages.',
    points: [
      'Define contractor responsibilities, coordination requirements and HSE expectations before work begins.',
      'Identify shared work areas, simultaneous operations, access conflicts, plant interactions and other interface risks.',
      'Use coordination meetings, inspections, RAMS review and field verification to control interfaces.',
    ],
  ),
  _AdvancedModule(
    number: '09',
    title: 'Inspection, Audit & Assurance',
    subtitle: 'Test both documentation and real implementation.',
    points: [
      'Inspections should verify physical conditions and critical controls at the workface.',
      'Audits should test whether management arrangements are effective and implemented, not merely whether documents exist.',
      'Findings should have clear ownership, due dates, evidence requirements and effectiveness verification.',
    ],
  ),
  _AdvancedModule(
    number: '10',
    title: 'Incident, CAPA & Learning',
    subtitle: 'Use events and findings to strengthen controls.',
    points: [
      'Report and investigate relevant incidents, near misses and significant unsafe conditions using the project process.',
      'Corrective actions should address contributing and underlying weaknesses where the investigation identifies them.',
      'Relevant lessons should be communicated and incorporated into affected controls, RAMS, training or the HSE Plan when appropriate.',
    ],
  ),
  _AdvancedModule(
    number: '11',
    title: 'Document Control & Change Management',
    subtitle: 'Keep the approved plan current and traceable.',
    points: [
      'Control revision, approval, distribution and withdrawal of superseded HSE Plan versions.',
      'Review the plan when scope, methods, organisation, significant risks, site conditions or applicable requirements change.',
      'Communicate material changes before affected personnel rely on the revised arrangements.',
    ],
  ),
  _AdvancedModule(
    number: '12',
    title: 'Management Review & Improvement',
    subtitle: 'Use performance evidence to improve the project HSE system.',
    points: [
      'Review HSE performance, incidents, audit findings, inspection trends, significant risks and open corrective actions.',
      'Confirm that resources, competence and supervision remain adequate for the current project phase.',
      'Use management decisions, lessons learned and performance trends to update controls and improve the HSE Plan.',
    ],
  ),
  _AdvancedModule(
    number: '13',
    title: 'Practical Site Scenario',
    subtitle: 'What to do when the approved plan no longer matches the workface.',
    points: [
      'A work sequence changes and another contractor enters the same work area. The affected activity should be reassessed before continuing.',
      'Confirm revised access, segregation, permits, RAMS, communication and supervision requirements as applicable.',
      'Record the change and update affected project controls where the project management system requires it.',
    ],
  ),
  _AdvancedModule(
    number: '14',
    title: 'Critical Control & Escalation',
    subtitle: 'Respond when important safeguards are missing or ineffective.',
    points: [
      'If a critical control is absent, bypassed or ineffective, control the affected exposure and escalate through the project process.',
      'Make the area safe where practicable and obtain reassessment or corrective action before restart.',
      'Verify restoration of required controls and communicate any changed requirements before work resumes.',
    ],
  ),
];
