import 'package:flutter/material.dart';

/// SafeNexus HSE
/// Dubai HSE — HSE Management System
///
/// ONE-FILE ARCHITECTURE:
/// - Main HSE Management System page
/// - Advanced Learning page
/// - Detailed modules, references, practical examples and role guidance
/// are all contained in this single Dart file.
///
/// Main page: expanded field-reference sections.
/// Advanced Learning: preserved as the detailed study library.

class DubaiHseManagementPage extends StatelessWidget {
  const DubaiHseManagementPage({super.key});

  static const Color primary = Color(0xFF0B6B4F);
  static const Color background = Color(0xFFF5F8F6);

  @override
  Widget build(BuildContext context) {
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
        padding: const EdgeInsets.fromLTRB(14, 16, 14, 30),
        children: [
          _AdvancedButton(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const DubaiHseManagementAdvancedPage(),
                ),
              );
            },
          ),
          const SizedBox(height: 14),
          const _LearningNotice(),
          const SizedBox(height: 12),
          const _MainSection(
            icon: Icons.category_outlined,
            title: 'Types / Systems',
            sections: [
              _MainSubSection(
                'Integrated HSE Management System',
                'A coordinated framework that connects leadership, policy, planning, risk assessment, RAMS, PTW, training, inspections, audits, incident management, emergency preparedness, environmental controls and continual improvement. The system should operate as one connected process rather than as separate documents.',
              ),
              _MainSubSection(
                'Project HSE Management System',
                'A project-level system translates company requirements, client expectations and applicable Dubai/UAE requirements into project procedures, responsibilities, plans, registers, inspections, records and field controls. It should be established before major site activities begin and updated as the project changes.',
              ),
              _MainSubSection(
                'Construction HSE System',
                'Focuses on controlling construction risks such as lifting, excavation, scaffolding, work at height, temporary works, electrical work, hot work, traffic interface, confined spaces, plant and equipment, housekeeping and worker welfare.',
              ),
              _MainSubSection(
                'Environmental Management',
                'Controls environmental aspects such as waste, dust, noise, spills, chemicals, wastewater, fuel storage, resource use and pollution prevention. Environmental controls should be included in planning and field inspections where relevant.',
              ),
              _MainSubSection(
                'Occupational Health Management',
                'Addresses health risks associated with the work, including heat exposure, manual handling, noise, vibration, dust, hazardous substances, ergonomics, welfare and other occupational-health exposures relevant to the project.',
              ),
              _MainSubSection(
                'Continuous Improvement System',
                'Uses inspections, audits, observations, incident investigations, worker feedback, KPI trends and corrective actions to identify weaknesses and improve the HSE system over time.',
              ),
            ],
          ),
          const SizedBox(height: 10),
          const _MainSection(
            icon: Icons.build_outlined,
            title: 'Components / Key Items',
            sections: [
              _MainSubSection(
                'Leadership & Policy',
                'HSE policy, leadership commitment, objectives, resources, accountability, visible leadership and management review establish the direction of the system.',
              ),
              _MainSubSection(
                'Organisation & Responsibilities',
                'Define who is responsible, who has authority, who performs the work, who verifies controls and who must be informed or consulted. Responsibilities should be clear from project management to individual workers.',
              ),
              _MainSubSection(
                'Risk Management',
                'Hazard identification, risk assessment, hierarchy of controls, task-specific RAMS, dynamic risk assessment and verification of residual risk are central to safe work planning.',
              ),
              _MainSubSection(
                'Operational Controls',
                'PTW, isolation, exclusion zones, lifting controls, access control, traffic management, work-at-height controls, equipment inspection, housekeeping and other task-specific controls are implemented at the workface.',
              ),
              _MainSubSection(
                'Competence & Training',
                'Induction, toolbox talks, task-specific training, competency verification, operator authorisation and refresher training help ensure people can perform assigned work safely.',
              ),
              _MainSubSection(
                'Monitoring & Assurance',
                'Daily inspections, planned inspections, audits, observations, KPI monitoring, corrective-action tracking and management review provide evidence that the system is functioning.',
              ),
              _MainSubSection(
                'Emergency & Incident Management',
                'Emergency plans, communication arrangements, drills, first aid, fire response, rescue arrangements, incident reporting, investigation, root-cause analysis and corrective actions form the response and learning side of the system.',
              ),
              _MainSubSection(
                'Document & Record Control',
                'Controlled procedures, current RAMS, permits, inspection records, training records, audit reports and action registers must be identifiable, accessible and retained according to project requirements.',
              ),
            ],
          ),
          const SizedBox(height: 10),
          const _MainSection(
            icon: Icons.menu_book_outlined,
            title: 'Purpose & Scope',
            sections: [
              _MainSubSection(
                'Purpose',
                'The main purpose is to prevent injury and ill health, protect workers and others, prevent property damage, control environmental impacts, meet applicable requirements and provide a repeatable method for improving HSE performance.',
              ),
              _MainSubSection(
                'Scope',
                'The system should cover the project lifecycle and relevant activities: mobilisation, planning, procurement, construction, commissioning where applicable, subcontractor activities, temporary works, plant and equipment, welfare, emergency response and close-out.',
              ),
              _MainSubSection(
                'People Covered',
                'Employees, supervisors, subcontractors, visitors, suppliers, drivers and other persons who may be affected by project activities should be considered according to the project arrangements.',
              ),
              _MainSubSection(
                'Workplace Interfaces',
                'The scope should include interfaces between trades, contractors, public areas, existing facilities, utilities, traffic routes, neighbouring activities and simultaneous operations where those interfaces can create risk.',
              ),
              _MainSubSection(
                'System Objective',
                'The objective is not simply to produce documents. The real test is whether planned controls are implemented, understood, maintained and verified at the workface.',
              ),
            ],
          ),
          const SizedBox(height: 10),
          const _MainSection(
            icon: Icons.engineering_outlined,
            title: 'Technical Requirements',
            sections: [
              _MainSubSection(
                'Project HSE Plan',
                'Establish HSE objectives, organisation, responsibilities, risk-management arrangements, training, inspections, audits, emergency response, environmental controls, contractor management and reporting requirements.',
              ),
              _MainSubSection(
                'Risk Assessment & RAMS',
                'High-risk and significant activities should have appropriate risk assessments and method statements. The documents should match the actual sequence, equipment, people, interfaces and site conditions.',
              ),
              _MainSubSection(
                'Permit to Work',
                'Where the project requires PTW, the permit must be linked to the specific activity and controls. Verify authorisation, isolations, precautions, validity, handover and closure as applicable.',
              ),
              _MainSubSection(
                'Competence',
                'Personnel performing safety-critical work should have the required competence, training, experience, authorisation or certification applicable to the task and project requirements.',
              ),
              _MainSubSection(
                'Inspection & Maintenance',
                'Plant, equipment, temporary works and safety-critical controls require appropriate inspection, maintenance and verification. Defects should be controlled before equipment is returned to service.',
              ),
              _MainSubSection(
                'Emergency Preparedness',
                'Emergency arrangements should address credible scenarios, alarms, communication, access, evacuation, assembly, first aid, fire response, rescue and coordination with relevant emergency services as applicable.',
              ),
              _MainSubSection(
                'Legal / Authority Verification',
                'Use the current applicable Dubai/UAE authority requirements, client requirements and approved project procedures. Regulatory details should be verified before being used for a formal compliance decision.',
              ),
            ],
          ),
          const SizedBox(height: 10),
          const _MainSection(
            icon: Icons.warning_amber_rounded,
            title: 'Main Hazards',
            sections: [
              _MainSubSection(
                'Falls from Height',
                'Unprotected edges, openings, ladders, scaffolds, MEWPs and fragile surfaces can create serious fall risks. Controls include suitable access, edge protection, fall-prevention systems, inspection and task-specific planning.',
              ),
              _MainSubSection(
                'Struck-by / Falling Objects',
                'People can be struck by moving plant, suspended loads, falling materials or tools. Controls include exclusion zones, lifting plans, secure materials, segregation and communication.',
              ),
              _MainSubSection(
                'Caught-in / Crushing',
                'Plant movement, rotating machinery, excavation collapse, temporary works failure and pinch points can cause severe injury. Guarding, isolation, exclusion zones and safe positioning are important controls.',
              ),
              _MainSubSection(
                'Electrical Hazards',
                'Shock, burns, arc-flash and fire can result from damaged equipment, poor temporary electrical arrangements, unauthorised work or inadequate isolation. Competent persons, inspection, protection and isolation are essential.',
              ),
              _MainSubSection(
                'Fire / Hot Work',
                'Welding, cutting, grinding and other ignition sources can start fires, especially near combustible materials or flammable substances. Permit controls, gas-cylinder management, fire watch and suitable extinguishing arrangements may be required.',
              ),
              _MainSubSection(
                'Excavation / Ground Collapse',
                'Collapse, falls, underground services, water ingress and plant interaction are major excavation risks. Protective systems, access, service verification, edge controls and competent inspection are key considerations.',
              ),
              _MainSubSection(
                'Lifting Operations',
                'Unplanned lifting, unsuitable equipment, overload, poor rigging, suspended loads and poor communication can lead to dropped loads or equipment failure. Planning, competent personnel, inspected equipment and exclusion zones are critical.',
              ),
              _MainSubSection(
                'Heat & Occupational Health',
                'Hot weather, dehydration, fatigue, dust, noise, vibration, chemicals and manual handling can affect worker health and performance. Controls should follow the relevant risk assessment and current project requirements.',
              ),
              _MainSubSection(
                'Traffic & Mobile Plant',
                'Vehicle-pedestrian interaction, reversing, blind spots and uncontrolled routes can result in serious incidents. Segregation, traffic plans, speed control, visibility and trained operators are important.',
              ),
            ],
          ),
          const SizedBox(height: 10),
          const _MainSection(
            icon: Icons.shield_outlined,
            title: 'Safety Controls',
            sections: [
              _MainSubSection(
                'Hierarchy of Controls',
                'Start with elimination or substitution where reasonably practicable, then consider engineering controls, administrative controls and PPE. PPE is important but should not be the only control for significant hazards.',
              ),
              _MainSubSection(
                'Engineering Controls',
                'Examples include guardrails, barriers, machine guarding, physical segregation, interlocks, extraction systems, protective excavation systems and engineered access arrangements.',
              ),
              _MainSubSection(
                'Administrative Controls',
                'Examples include RAMS, PTW, training, supervision, inspection schedules, traffic plans, toolbox talks, signage, restricted access and work sequencing.',
              ),
              _MainSubSection(
                'PPE',
                'Select PPE based on the assessed hazard and ensure it is suitable, available, correctly fitted, maintained and used. Typical construction PPE may include safety helmet, footwear, eye protection, gloves, high-visibility clothing and task-specific protection.',
              ),
              _MainSubSection(
                'Critical Control Verification',
                'For high-risk activities, identify the controls that must be present before work starts and verify them in the field. Do not assume that an approved document means the control is physically in place.',
              ),
              _MainSubSection(
                'Supervision & Communication',
                'Supervisors should monitor work conditions, communicate changes, correct unsafe practices and escalate issues. Workers should have a clear method to stop and report unsafe work.',
              ),
            ],
          ),
          const SizedBox(height: 10),
          const _MainSection(
            icon: Icons.fact_check_outlined,
            title: 'Inspection & Verification',
            sections: [
              _MainSubSection(
                'Daily Field Inspection',
                'Check work areas, access, housekeeping, barriers, PPE, plant, temporary works, work-at-height arrangements, excavations, lifting areas, electrical systems and other controls relevant to the day\'s activities.',
              ),
              _MainSubSection(
                'Pre-use Checks',
                'Users should complete required pre-use checks on equipment and tools. Defects should be reported and defective equipment controlled so it cannot be used unintentionally.',
              ),
              _MainSubSection(
                'Planned Inspections',
                'Use a planned inspection programme for safety-critical systems, equipment, welfare facilities, emergency equipment, temporary works and other project-specific controls.',
              ),
              _MainSubSection(
                'Verification Evidence',
                'Evidence may include inspection records, photographs, permits, certificates, checklists, training records, audit findings and closed corrective actions, according to project requirements.',
              ),
              _MainSubSection(
                'Corrective Action',
                'Record the finding, identify the responsible person, agree a realistic due date, apply immediate controls where necessary and verify closure. A closed action should mean the underlying issue has actually been addressed.',
              ),
              _MainSubSection(
                'Trend Review',
                'Repeated observations should be analysed for patterns. Several similar findings may indicate a system weakness rather than isolated worker behaviour.',
              ),
            ],
          ),
          const SizedBox(height: 10),
          const _MainSection(
            icon: Icons.stop_circle_outlined,
            title: 'Stop-Work Conditions',
            sections: [
              _MainSubSection(
                'Immediate Serious Danger',
                'Stop or prevent the activity when there is an uncontrolled condition presenting a serious and immediate risk to people, property or the environment, within the authority and project procedure applicable to the situation.',
              ),
              _MainSubSection(
                'Missing Critical Controls',
                'Examples include absent edge protection, uncontrolled suspended loads, unsafe excavation conditions, missing isolation, serious electrical exposure or required permit/control not being in place.',
              ),
              _MainSubSection(
                'Changed Conditions',
                'Stop and reassess when weather, ground conditions, equipment, work sequence, personnel, access, interfaces or other conditions change enough to invalidate the planned controls.',
              ),
              _MainSubSection(
                'Unfit / Unauthorised Personnel',
                'Work should not continue when safety-critical work is being performed by a person who lacks required competence, authorisation, fitness or task-specific understanding.',
              ),
              _MainSubSection(
                'Unsafe Equipment',
                'Remove or isolate equipment from use when a defect or condition could make operation unsafe. Follow the project process for tagging, quarantine, repair and return-to-service verification.',
              ),
              _MainSubSection(
                'After Stop Work',
                'Make the area safe, communicate the reason, identify the required corrective actions, review the risk assessment or method where necessary and only resume when authorised controls have been verified.',
              ),
            ],
          ),
          const SizedBox(height: 10),
          const _MainSection(
            icon: Icons.groups_2_outlined,
            title: 'Responsibilities',
            sections: [
              _MainSubSection(
                'Project / Construction Manager',
                'Provides leadership, resources, competent personnel, planning support and authority needed to implement the HSE system. Ensures HSE is integrated into project decisions and delivery.',
              ),
              _MainSubSection(
                'HSE Manager',
                'Coordinates the HSE system, advises management, reviews significant risks, monitors performance, supports audits and investigations, and ensures corrective actions are tracked and escalated when necessary.',
              ),
              _MainSubSection(
                'HSE Officer / Engineer',
                'Performs field inspections, verifies controls, supports risk assessments, reviews relevant RAMS/PTW, communicates hazards, records observations, follows up actions and escalates uncontrolled risks.',
              ),
              _MainSubSection(
                'HSE Supervisor',
                'Maintains close workface monitoring, checks daily conditions, supports immediate correction, communicates requirements and coordinates with supervisors and workers on unsafe conditions.',
              ),
              _MainSubSection(
                'Supervisor / Foreman',
                'Directly controls the workface, briefs workers, verifies task readiness, implements the approved method and ensures unsafe work is stopped or escalated.',
              ),
              _MainSubSection(
                'Subcontractor Management',
                'Ensures subcontractors understand project HSE requirements, provide suitable RAMS and competent personnel, implement controls and close findings within agreed arrangements.',
              ),
            ],
          ),
          const SizedBox(height: 10),
          const _MainSection(
            icon: Icons.engineering_outlined,
            title: 'Worker Responsibilities',
            sections: [
              _MainSubSection(
                'Follow Safe Work Requirements',
                'Follow approved procedures, RAMS, permits, instructions and site rules applicable to the task. Do not intentionally bypass safety controls to save time.',
              ),
              _MainSubSection(
                'Use Controls Correctly',
                'Use required PPE and safety systems correctly, maintain barriers and guards, use equipment only as authorised and keep access and work areas in a safe condition.',
              ),
              _MainSubSection(
                'Report Hazards',
                'Immediately report unsafe conditions, defects, near misses, incidents and changes that could affect safety. Early reporting allows controls to be applied before harm occurs.',
              ),
              _MainSubSection(
                'Participate in Briefings',
                'Attend induction, toolbox talks and task briefings, ask questions when instructions are unclear and confirm understanding of hazards and controls.',
              ),
              _MainSubSection(
                'Stop and Ask',
                'If the job cannot be performed safely or the actual conditions differ from the agreed method, stop and seek clarification or assistance before continuing.',
              ),
              _MainSubSection(
                'Care for Others',
                'Workers should avoid actions that create risk for colleagues or the public and should raise unsafe conditions they observe, even when they are not personally performing the task.',
              ),
              _MainSubSection(
                'Learning Culture',
                'Use lessons from incidents, observations, toolbox talks and inspections to improve daily work practices. Safety is a shared responsibility at the workface.',
              ),
            ],
          ),
          const SizedBox(height: 14),
          const _QuickMapCard(),
        ],
      ),
    );
  }
}

class _MainSection extends StatelessWidget {
  final IconData icon;
  final String title;
  final List<_MainSubSection> sections;

  const _MainSection({
    required this.icon,
    required this.title,
    required this.sections,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 1.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        childrenPadding: const EdgeInsets.fromLTRB(14, 0, 14, 8),
        leading: Icon(icon, color: const Color(0xFF0B6B4F), size: 30),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w800,
          ),
        ),
        iconColor: const Color(0xFF45554D),
        collapsedIconColor: const Color(0xFF45554D),
        children: [
          for (final section in sections)
            _MainSubSectionCard(section: section),
        ],
      ),
    );
  }
}

class _MainSubSectionCard extends StatelessWidget {
  final _MainSubSection section;

  const _MainSubSectionCard({required this.section});

  String _fieldApplication() {
    switch (section.title) {
      case 'Integrated HSE Management System':
        return 'In a real project, this system should work as a connected cycle rather than as a collection of separate HSE documents. The HSE plan, risk assessments, RAMS, permits, training, inspections, audits, incident investigations and corrective actions should support one another. For example, if an inspection identifies a recurring lifting-control weakness, the finding should be recorded, responsibility assigned, the immediate risk controlled, the underlying cause reviewed and the learning fed back into planning, briefing or training. The effectiveness of the correction should then be verified at the workface.';
      case 'Project HSE Management System':
        return 'At project level, the system must be translated into practical arrangements that people can actually use. Before major work begins, management should establish responsibilities, project HSE objectives, applicable requirements, activity risk assessments, RAMS, emergency arrangements, training needs, inspection programmes and reporting channels. As the project develops, changes in design, sequence, workforce, equipment, subcontractors or surrounding conditions should be reflected in the relevant HSE arrangements rather than leaving the original plan unchanged.';
      case 'Construction HSE System':
        return 'Construction conditions change quickly, so the system must remain active at the workface. A strong arrangement links daily planning with permits, RAMS, toolbox talks, plant checks, access control, lifting arrangements, temporary works, excavation protection, work-at-height controls, housekeeping and traffic management. Supervisors should confirm that the planned controls are physically present before allowing the task to proceed and should intervene when actual site conditions no longer match the approved method.';
      case 'Environmental Management':
        return 'Environmental management should be treated as part of normal site planning and supervision, not as a separate paperwork exercise. The project should identify significant environmental aspects and establish controls for waste segregation, dust, noise, spills, chemicals, fuel, wastewater and pollution prevention where applicable. Field inspections should verify that storage areas are suitable, waste is controlled, spill-response arrangements are available and environmental incidents or repeated nonconformities are recorded and corrected.';
      case 'Occupational Health Management':
        return 'Occupational health controls require attention to exposure over time, not only immediate injury risks. The project should identify relevant exposures such as heat, dust, noise, vibration, manual handling, chemicals, fatigue and ergonomic strain and then apply suitable preventive measures. Supervisors should watch for signs that controls are not working, while HSE and management should review health-related observations, worker feedback and monitoring information and strengthen controls where necessary.';
      case 'Continuous Improvement System':
        return 'Continual improvement means learning from evidence and changing the system when evidence shows that a control is weak. Inspection findings, near misses, incidents, audit results, observations, worker suggestions and KPI trends should be reviewed for recurring patterns. A professional HSE system does not simply count findings; it asks why the same problem is appearing, whether the control is practical and whether the corrective action has prevented recurrence.';
      case 'Leadership & Policy':
        return 'Leadership becomes meaningful when management decisions consistently support safe work. A policy should be communicated, understood and reflected in resources, staffing, planning, supervision and decisions made under production pressure. Visible leadership can include site visits, participation in safety discussions, review of significant risks, support for stop-work decisions and follow-up of important corrective actions. Workers should be able to see that HSE commitments are being applied in practice.';
      case 'Organisation & Responsibilities':
        return 'Responsibilities should be defined clearly enough that a person at the workface knows who controls the task, who provides technical support, who authorises work and who verifies critical controls. Interfaces between the project manager, construction team, supervisors, HSE personnel, subcontractors and workers should be understood. Where responsibility is unclear, important controls can be missed or assumed to be someone else\'s responsibility, so the organisation should provide clear authority, escalation and communication routes.';
      case 'Risk Management':
        return 'Risk management should begin before exposure occurs and continue while the work is being performed. The team should identify hazards, understand who may be affected, evaluate the risk, select controls using the hierarchy of controls and verify the residual risk. The assessment should reflect actual equipment, sequence, location, workforce and interfaces. When conditions change, the affected work should be controlled and the risk assessment or RAMS reviewed before continuing.';
      case 'Operational Controls':
        return 'Operational controls are the measures that turn the planned HSE system into safe work at the actual workface. Depending on the task, these can include permits, isolations, barriers, exclusion zones, access arrangements, lifting controls, traffic segregation, fall protection, excavation protection, equipment inspections and housekeeping. The important point is verification: supervisors and HSE personnel should physically check that the required control exists, is suitable and is being used correctly.';
      case 'Competence & Training':
        return 'Competence is more than attendance on a course. The project should determine what knowledge, skill, experience and authorisation are required for each safety-critical role and ensure that personnel meet those requirements. Induction, toolbox talks and task briefings support awareness, while task-specific competency checks, supervision and practical verification help confirm that the person can perform the work safely. Training needs should also be reviewed after incidents, changes or identified weaknesses.';
      case 'Monitoring & Assurance':
        return 'Monitoring provides evidence of what is happening in the field, while assurance asks whether the management system is reliable and effective. Daily inspections, observations, audits, KPI reviews, critical-control checks and action tracking should be planned rather than performed only after an incident. Good assurance compares documented requirements with physical conditions, worker understanding and actual work practices, and it uses the results to improve the system.';
      case 'Emergency & Incident Management':
        return 'Emergency and incident arrangements must be practical enough to work under pressure. The project should identify credible scenarios, define alarms and communication methods, establish access and evacuation arrangements, provide first-aid and fire-response resources and make rescue arrangements where required. When an incident or near miss occurs, the response should protect people first, followed by reporting, evidence preservation where appropriate, investigation, root-cause analysis, corrective action and communication of lessons learned.';
      case 'Document & Record Control':
        return 'Document control is a safety control because people can be exposed when they work from outdated or incomplete information. Current procedures, approved RAMS, permits, inspection records, training evidence and registers should be identifiable and accessible to the people who need them. Superseded documents should not remain in uncontrolled work areas where they can be mistaken for current instructions. Records should provide reliable evidence of what was planned, what was checked and what action was taken.';
      case 'Purpose':
        return 'The purpose should be understood at both management and workface level. The system exists to prevent harm and control HSE risks through planned and verified arrangements, not simply to satisfy an administrative requirement. A useful test is to ask whether the system changes how work is planned, supervised and performed. If documents are completed but significant hazards remain uncontrolled, the purpose of the system has not been achieved.';
      case 'Scope':
        return 'A practical scope should cover the activities, people, locations and interfaces that can affect HSE performance. This normally means considering mobilisation, construction activities, subcontractors, plant and equipment, temporary works, welfare, emergency arrangements and close-out where relevant to the project. The scope should also consider simultaneous operations and interfaces with public areas, existing facilities, utilities, neighbouring contractors and traffic routes.';
      case 'People Covered':
        return 'Everyone who can be affected by the work should be considered, including employees, subcontractors, visitors, drivers, suppliers and other persons entering or working near the project. Different groups may have different levels of knowledge and exposure, so communication, induction, access control and supervision should be appropriate to their role. Particular attention should be given to people who may be unfamiliar with site hazards or who may be affected by another team\'s activity.';
      case 'Workplace Interfaces':
        return 'Interfaces are common sources of unexpected risk because one team can change the conditions for another. Examples include lifting over work areas, vehicle and pedestrian movement, excavation near existing services, simultaneous hot work and combustible-material activities, or subcontractors working in the same restricted zone. Interface controls should define boundaries, communication, sequencing and responsibility, and supervisors should coordinate simultaneous activities before work starts.';
      case 'System Objective':
        return 'The objective should be measured by performance at the workface rather than by the number of documents produced. Workers should understand the hazards, controls should be physically present, supervisors should verify them and management should act on evidence of weakness. A mature system therefore connects planning, implementation, checking and improvement so that the same risk is less likely to appear repeatedly.';
      case 'Project HSE Plan':
        return 'The Project HSE Plan should explain how the project will manage its HSE risks and responsibilities in a structured way. It should be consistent with applicable requirements and approved project arrangements and should address organisation, objectives, risk management, training, inspections, audits, emergency response, environmental controls, contractor management and reporting as relevant. The plan should be reviewed when project scope, activities or significant risks change so that it remains useful rather than becoming a static document.';
      case 'Risk Assessment & RAMS':
        return 'Risk assessments and RAMS should describe the real work, not a generic version of it. The team should consider the work sequence, location, equipment, people, interfaces, simultaneous operations and reasonably foreseeable changes. Workers and supervisors should understand the controls before starting, and critical controls should be checked at the workface. If the actual conditions differ materially from the approved method, the work should be controlled and the method or assessment reviewed before restart.';
      case 'Permit to Work':
        return 'Where a PTW system is required, the permit should clearly define the authorised work, location, validity, precautions, isolations and responsible persons. A permit is not a replacement for risk assessment or supervision. Before work starts, the issuing and receiving arrangements should be verified as required, and during the task the permit conditions should remain valid. Changes, expiry, handover and closure should be managed according to the project procedure.';
      case 'Competence':
        return 'Safety-critical work should be assigned only to people who meet the applicable competency and authorisation requirements. Verification may include training records, experience, assessment, licences or project-specific approvals depending on the activity. Supervisors should also consider whether the person is actually fit and capable for the task on the day, including whether unfamiliarity, fatigue, language or changed conditions could affect safe performance.';
      case 'Inspection & Maintenance':
        return 'Inspection and maintenance should focus on preventing equipment or control failure before exposure occurs. The project should identify safety-critical plant, tools, temporary works and systems, establish appropriate inspection or maintenance arrangements and control defects promptly. A defective item should be clearly identified and prevented from unintended use until the required repair, examination or verification is completed. Inspection records should support traceability and demonstrate the status of the equipment or control.';
      case 'Emergency Preparedness':
        return 'Emergency preparedness should be based on credible scenarios for the actual project rather than a generic plan alone. People should know how to raise an alarm, where to go, how to access first aid, how evacuation works and who coordinates the response. Where rescue or specialist response is required, the equipment, trained personnel, access routes and communication arrangements should be considered in advance. Drills and reviews can reveal weaknesses before a real emergency occurs.';
      case 'Legal / Authority Verification':
        return 'Compliance decisions should be based on the current applicable legal, authority, client and approved project requirements. Because requirements can change and may depend on the activity, location and project conditions, formal compliance checks should use the current controlled source rather than relying on memory or an old copy. Where a specific authority requirement is uncertain, it should be verified through the appropriate current source before being treated as a compliance conclusion.';
      case 'Falls from Height':
        return 'Work-at-height controls should address the complete task: access, working position, edges, openings, fragile surfaces, equipment selection, rescue and supervision. Wherever reasonably practicable, fall prevention should be prioritised over relying only on personal fall protection. Scaffolds, ladders and MEWPs should be suitable and appropriately inspected, and openings or edges should have effective protection. Any change in access, weather, work sequence or equipment should trigger reassessment of the control arrangement.';
      case 'Struck-by / Falling Objects':
        return 'The risk of being struck can arise from suspended loads, moving plant, falling tools or materials and uncontrolled movement of objects. Effective controls include planning, secure storage, exclusion zones, physical segregation, suitable lifting arrangements and clear communication. The HSE team and supervisors should verify that people cannot casually enter the danger zone and that materials or tools are secured against foreseeable movement. Particular care is required where work is carried out above or adjacent to occupied areas.';
      case 'Caught-in / Crushing':
        return 'Crushing hazards occur where people can become trapped between moving equipment, structures, materials or collapsing ground. Controls should consider guarding, isolation, safe positioning, exclusion zones, equipment movement and communication. Before intervention or maintenance, the energy source should be controlled according to the applicable isolation procedure. Workers should never rely only on another person\'s awareness to prevent movement where a physical or procedural control is required.';
      case 'Electrical Hazards':
        return 'Electrical risk should be controlled through suitable equipment, competent persons, protection, inspection and effective isolation arrangements. Damaged cables, unsuitable temporary supplies, exposed conductors, unauthorised modifications and poor earthing or protection can create serious shock, burn and fire risks. Supervisors should verify the condition of electrical equipment and the work area, while safety-critical electrical work should be carried out only by appropriately authorised personnel under the applicable project arrangement.';
      case 'Fire / Hot Work':
        return 'Hot work requires control of ignition sources as well as the materials and conditions around the work. The work area should be assessed for combustible materials, flammable substances, hidden fire paths and nearby activities. Where required, permit arrangements, gas-cylinder controls, fire watch, suitable extinguishing equipment and post-work monitoring should be established. If conditions change or the required precautions are not available, the work should not continue until the risk is controlled.';
      case 'Excavation / Ground Collapse':
        return 'Excavation safety requires consideration of ground conditions, depth, protective systems, access, water, underground services, nearby structures and plant loading. The protective arrangement should be suitable for the actual conditions and inspected by a competent person as required by the project. Spoil, materials and equipment should be controlled near edges, access and egress should remain safe, and work should stop when significant deterioration, unexpected services, water ingress or other uncontrolled conditions are identified.';
      case 'Lifting Operations':
        return 'Safe lifting depends on planning the load, equipment, lifting accessories, ground conditions, travel path, communication and exclusion zone before the lift begins. Equipment and accessories should be suitable and within their required inspection or certification status, and personnel should have the appropriate competence and roles. Suspended loads should be controlled so that people are not exposed unnecessarily. Weather, visibility, load changes and site congestion should also be considered because they can alter the risk during the operation.';
      case 'Heat & Occupational Health':
        return 'Heat and occupational-health risks can reduce concentration and physical capability as well as cause illness. Controls should be based on the applicable project requirements and assessed exposure and may include work-rest arrangements, hydration, shaded or cooled recovery areas, suitable scheduling, acclimatisation and monitoring of workers. Other exposures such as dust, noise, vibration, chemicals and manual handling should similarly be controlled through engineering and administrative measures rather than relying only on PPE.';
      case 'Traffic & Mobile Plant':
        return 'Vehicle and pedestrian interaction should be controlled through planned routes, physical segregation where practicable, suitable crossing points, visibility, speed management and clear communication. Reversing and blind-spot risks require particular attention. Operators should be appropriately trained and authorised, vehicles should be suitable and maintained, and supervisors should check that the actual traffic arrangement matches the plan. Changes in site layout should be communicated before routes or access patterns are altered.';
      case 'Hierarchy of Controls':
        return 'The hierarchy of controls provides a structured way to select stronger risk controls. First consider whether the hazard can be eliminated or the activity changed; then consider substitution and engineering controls before relying on administrative controls and PPE. The hierarchy should not be treated as a box-ticking exercise. The selected controls should be practical, proportionate to the risk and verified at the workface, with particular attention to critical controls for high-consequence activities.';
      case 'Engineering Controls':
        return 'Engineering controls physically reduce the likelihood or consequence of exposure and are often more reliable than relying entirely on worker behaviour. Examples include guardrails, barriers, machine guards, physical segregation, interlocks, extraction, protective excavation systems and engineered access. Their effectiveness depends on correct design, installation, inspection and maintenance. A missing, damaged or bypassed engineering control should be treated as a significant field issue and corrected before exposure continues.';
      case 'Administrative Controls':
        return 'Administrative controls organise how work is performed through procedures, RAMS, PTW, training, supervision, sequencing, signage, inspections and access restrictions. They are important, but their effectiveness depends on people understanding and following the arrangement. Supervisors should verify that the procedure reflects the actual task and that workers have been briefed. Where administrative controls repeatedly fail, the team should consider whether stronger engineering or elimination measures are reasonably practicable.';
      case 'PPE':
        return 'PPE should be selected from the assessed hazards and the task requirements, and it should complement rather than replace stronger controls. Equipment must be suitable, correctly fitted, available, maintained and used properly. Supervisors should check that workers understand limitations and that damaged or unsuitable PPE is removed from service. Task-specific protection may be required for hazards such as eye exposure, hearing, respiratory exposure, falling objects, chemicals or fall arrest.';
      case 'Critical Control Verification':
        return 'For activities with potentially severe consequences, identify the few controls that must never fail and verify them before exposure occurs. Examples can include isolation, edge protection, lifting exclusion zones, excavation protection or competent authorisation. Verification should be based on physical evidence and, where useful, worker or supervisor confirmation. If a critical control is missing or ineffective, the appropriate response is to control the exposure and escalate rather than simply record the issue for later.';
      case 'Supervision & Communication':
        return 'Effective supervision connects the written plan to the actual work. Supervisors should understand the task, confirm readiness, brief the team, monitor conditions, coordinate interfaces and intervene when unsafe behaviour or changed conditions are observed. Communication should be clear and understandable to the workforce, including the hazards, critical controls and emergency arrangements. A strong reporting culture also gives workers a practical way to raise concerns without being discouraged from stopping unsafe work.';
      case 'Daily Field Inspection':
        return 'A daily field inspection should be focused on the activities and risks that are actually present on that shift. The HSE professional should walk the workface, compare conditions with the approved arrangements and check access, housekeeping, barriers, PPE, plant, temporary works, work-at-height systems, excavations, lifting areas, electrical arrangements and other relevant controls. Findings should be prioritised according to risk, immediate exposure should be controlled and actions should be followed through to effective closure.';
      case 'Pre-use Checks':
        return 'Pre-use checks are intended to identify obvious defects or unsafe conditions before equipment is used. The user should know what to inspect, complete the required check and report any defect through the project process. Defective equipment should be clearly controlled so another person does not unknowingly use it. Pre-use checks do not replace scheduled inspection, examination or maintenance requirements; they are an additional frontline control before use.';
      case 'Planned Inspections':
        return 'A planned inspection programme should cover the safety-critical equipment, systems and areas relevant to the project and should define suitable frequency, responsibility and follow-up. It can include scaffolds, lifting equipment, excavations, temporary works, electrical systems, emergency equipment, welfare and other controls as applicable. The value comes from acting on the findings: repeated defects should trigger investigation and improvement rather than becoming routine entries on a checklist.';
      case 'Verification Evidence':
        return 'Evidence should demonstrate what was checked and what condition was found, rather than simply proving that a form exists. Depending on the requirement, useful evidence can include inspection records, photographs, permits, certificates, training records, interviews, observations and verified corrective actions. Evidence should be accurate, traceable and connected to the relevant activity or control. Good records make it easier to demonstrate performance and identify recurring weaknesses.';
      case 'Corrective Action':
        return 'A corrective action should address the identified risk and, where necessary, the underlying cause. The finding should be described clearly, immediate controls should be applied when people remain exposed, responsibility should be assigned and a realistic completion date should be established. Closure should include verification that the action has actually been implemented and is effective. If the same problem returns, the action should be reconsidered rather than repeatedly closed with superficial evidence.';
      case 'Trend Review':
        return 'Trend review looks across individual findings to identify patterns that may not be visible in a single inspection. Repeated housekeeping findings, recurring permit errors, similar equipment defects or repeated unsafe behaviours may indicate weaknesses in planning, supervision, training or system design. Management should review significant trends, identify causes and decide whether broader corrective action is needed. The goal is prevention, not merely reporting statistics.';
      case 'Immediate Serious Danger':
        return 'Where there is an immediate and serious risk of injury, the priority is to prevent further exposure. The affected activity should be stopped or controlled as appropriate, people should be moved to a safe position where necessary and responsible supervision or management should be informed. The issue should then be assessed, controls established and the conditions verified before restart. The exact stop-work and escalation process should follow the project\'s approved arrangements.';
      case 'Missing Critical Controls':
        return 'If a control identified as essential for a high-risk task is absent, damaged or ineffective, the work should not simply continue while the issue is recorded. The exposure should be controlled and the responsible team informed so the missing control can be restored. Examples include missing edge protection, absent excavation protection, inadequate lifting exclusion or an unverified isolation. Restart should occur only after the required control is physically in place and verified.';
      case 'Changed Conditions':
        return 'Conditions can change because of weather, ground movement, design changes, new equipment, different work sequences, additional workers, simultaneous operations or changes in surrounding activities. When a significant change affects the assessed risk, the team should pause or control the affected work, reassess the hazards, revise the method or controls where necessary and brief the people involved. Continuing with an old RAMS simply because it was previously approved can create a gap between planned and actual risk.';
      case 'Unfit / Unauthorised Personnel':
        return 'People performing safety-critical work should meet the applicable competency, authorisation and fitness requirements. If someone is not authorised, lacks the required competence or is not fit to perform the task safely, the work should be controlled and the responsible supervision informed. This is particularly important for operators, riggers, electrical work, work at height and other tasks where an individual\'s capability can directly affect the safety of others.';
      case 'Unsafe Equipment':
        return 'Unsafe equipment should be removed from exposure and controlled against unintended use. The defect should be reported, the required inspection or repair arranged and the equipment returned to service only when the project\'s acceptance requirements are satisfied. Temporary workarounds should not create a new risk. Where repeated equipment defects occur, management should examine procurement, maintenance, inspection or user practices rather than treating each defect as an isolated event.';
      case 'After Stop Work':
        return 'Stopping work is only the first step. After the immediate exposure is controlled, the responsible team should determine what caused the unsafe condition, establish the required controls, update the risk assessment or method where necessary and brief affected personnel. A competent person should verify the workface before restart, and significant stop-work events should be reviewed for lessons that can prevent recurrence elsewhere on the project.';
      case 'Project / Construction Manager':
        return 'Project and construction management own delivery decisions and therefore have a central role in ensuring that safe execution is properly resourced and planned. Their responsibilities can include setting expectations, providing competent resources, coordinating work, reviewing significant risks, supporting corrective actions and ensuring that production decisions do not bypass critical HSE controls. They should also ensure that subcontractor and interface arrangements are integrated into the project management process.';
      case 'HSE Manager':
        return 'The HSE Manager provides system-level leadership and assurance. The role commonly includes oversight of objectives, significant risks, legal and client requirements, audits, incident learning, resources, HSE reporting and continual improvement. The HSE Manager should ensure that the HSE team is capable of monitoring and advising effectively while maintaining clear escalation routes for significant risks. Line management should remain accountable for safe execution.';
      case 'HSE Officer / Engineer':
        return 'The HSE Officer or Engineer typically provides field verification, advice and follow-up. Duties can include inspections, observations, RAMS and permit checks, toolbox-talk support, training assistance, incident reporting, corrective-action follow-up and escalation of uncontrolled risks. The role is strongest when the professional understands the actual construction activity and can communicate practical controls to supervisors and workers rather than relying only on paperwork checks.';
      case 'HSE Supervisor':
        return 'The HSE Supervisor focuses strongly on workface conditions and coordination. The role may include close monitoring of high-risk activities, coordination with supervisors, immediate intervention, daily inspections, verification of critical controls and follow-up of findings. The HSE Supervisor should maintain good communication with the workforce and escalate significant issues promptly while supporting a culture in which unsafe work can be stopped without delay.';
      case 'Supervisor / Foreman':
        return 'The supervisor or foreman is closest to the work and therefore has direct influence over how the task is executed. Before work starts, the supervisor should confirm people, equipment, materials, access, RAMS, permits and controls are ready. During the task, the supervisor should monitor conditions, coordinate the team, correct unsafe practices and respond to changes. HSE personnel can advise and verify, but line supervision remains essential to safe execution.';
      case 'Subcontractor Management':
        return 'Subcontractor control should begin before mobilisation and continue through the work. The project should establish clear HSE expectations, verify relevant competence and documentation, review RAMS and coordinate interfaces. Once on site, subcontractor performance should be monitored through inspections, meetings, observations, audits and corrective actions. The goal is not merely to collect documents but to ensure the subcontractor actually implements the agreed controls at the workface.';
      case 'Follow Safe Work Requirements':
        return 'Workers should follow the approved method, permits, instructions and site rules that apply to their task and should not deliberately bypass controls to save time. If the method cannot be followed because conditions are different, the worker should stop and raise the issue rather than improvising an unsafe solution. Compliance is strongest when workers understand why the control exists and have a clear route to ask questions or request help.';
      case 'Use Controls Correctly':
        return 'Workers have an important role in maintaining the controls provided by the project. This includes correct use of PPE, barriers, guards, access systems and authorised equipment, as well as keeping the work area orderly. Controls should not be removed, bypassed or altered without proper authority and reassessment. If a control is damaged or impractical, it should be reported so that a safe solution can be established.';
      case 'Report Hazards':
        return 'Early reporting gives the project an opportunity to control a hazard before it becomes an incident. Workers should report unsafe conditions, equipment defects, near misses, incidents and changes that may affect safety through the available site process. Reports should be specific enough to allow action, and supervisors or HSE personnel should respond appropriately rather than discouraging reporting. A strong reporting culture treats useful hazard information as an opportunity for prevention.';
      case 'Participate in Briefings':
        return 'Inductions, toolbox talks and task briefings are opportunities to establish a common understanding before work begins. Workers should listen to the hazards, critical controls, work sequence and emergency arrangements and should ask questions when anything is unclear. Supervisors should confirm that the briefing matches the actual task and workforce. Where language or literacy differences exist, communication should be adapted so that understanding is genuine rather than assumed from a signature.';
      case 'Stop and Ask':
        return 'Workers should have the confidence and authority provided by the project arrangements to pause when the job cannot be performed safely. A stop-and-ask approach is particularly important when site conditions differ from the RAMS, a required control is missing, equipment is defective or the person does not understand the instruction. The concern should be raised to the appropriate supervisor or responsible person, and work should resume only when the condition has been properly addressed.';
      case 'Care for Others':
        return 'Safe behaviour includes considering how your actions affect colleagues, visitors, subcontractors and the public. Workers should avoid creating hazards, maintain barriers and access controls, keep materials secure and report conditions that could expose another person. This is especially important in shared work areas where one team may create a risk for another. Looking beyond one\'s own task helps strengthen the overall site safety culture.';
      case 'Learning Culture':
        return 'A learning culture encourages people to use observations, near misses, incidents, toolbox talks and inspection findings to improve how work is done. The objective is not to blame individuals for every error but to understand what allowed the condition to occur and what can prevent recurrence. Workers, supervisors and HSE personnel should share practical lessons and apply them to similar activities elsewhere on the project.';
      default:
        return 'This requirement should be understood as a practical field control, not only as a document or administrative task. The responsible supervisor should confirm that the requirement is reflected in the actual work arrangement, that affected workers understand what is expected and that the necessary control can be seen or verified at the workface. If conditions change, the team should stop or control the affected activity as appropriate, reassess the risk and confirm the revised arrangement before continuing.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 9),
      elevation: 0.6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 13, vertical: 5),
        childrenPadding: const EdgeInsets.fromLTRB(14, 0, 14, 15),
        leading: const Icon(
          Icons.menu_book_outlined,
          color: Color(0xFF159447),
          size: 21,
        ),
        title: Text(
          section.title,
          style: const TextStyle(
            color: Color(0xFF0B6B4F),
            fontSize: 14.5,
            fontWeight: FontWeight.w800,
          ),
        ),
        subtitle: const Text(
          'Tap to read detailed HSE explanation',
          style: TextStyle(fontSize: 11.5),
        ),
        iconColor: const Color(0xFF45554D),
        collapsedIconColor: const Color(0xFF45554D),
        children: [
          const Divider(height: 1),
          const SizedBox(height: 11),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Detailed Explanation',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: Color(0xFF0B6B4F),
              ),
            ),
          ),
          const SizedBox(height: 7),
          Text(
            section.body,
            style: const TextStyle(
              fontSize: 13.5,
              height: 1.65,
            ),
          ),
          const SizedBox(height: 13),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Field Application / Practical Understanding',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: Color(0xFF0B6B4F),
              ),
            ),
          ),
          const SizedBox(height: 7),
          Text(
            _fieldApplication(),
            style: const TextStyle(
              fontSize: 13.5,
              height: 1.65,
            ),
          ),
        ],
      ),
    );
  }
}

class _MainSubSection {
  final String title;
  final String body;

  const _MainSubSection(this.title, this.body);
}

class DubaiHseManagementAdvancedPage extends StatelessWidget {
  const DubaiHseManagementAdvancedPage({super.key});

  static const Color primary = Color(0xFF0B6B4F);
  static const Color background = Color(0xFFF5F8F6);

  static const List<_HseModule> modules = [
    _HseModule(
      number: '01',
      title: 'HSE Management System Fundamentals',
      icon: Icons.account_tree_outlined,
      summary:
          'Understand the structure, purpose, elements and operating cycle of an HSE management system.',
      sections: [
        _HseSection(
          'Definition',
          'An HSE Management System is a coordinated set of policies, processes, responsibilities, controls, records and review activities used to manage health, safety and environmental risks. It should connect management decisions with what actually happens at the workface.',
        ),
        _HseSection(
          'Why it matters',
          'A good system prevents safety from depending only on individual memory or personal experience. It establishes repeatable arrangements for planning work, controlling hazards, checking performance and learning from failures.',
        ),
        _HseSection(
          'Core cycle',
          'A useful learning model is Plan → Do → Check → Act. Plan the activity and controls; implement the controls; check whether the controls are working; then act on findings and improve the system.',
        ),
        _HseSection(
          'Construction example',
          'Before a lifting activity, the project identifies hazards, assesses risk, approves a lifting method, verifies competent people and equipment, establishes the exclusion zone, conducts the required briefing and permit checks, monitors the lift and closes any corrective actions. This is the management system operating at the workface.',
        ),
      ],
    ),
    _HseModule(
      number: '02',
      title: 'HSE Policy & Leadership',
      icon: Icons.policy_outlined,
      summary:
          'Learn how management commitment is translated into visible action.',
      sections: [
        _HseSection(
          'HSE Policy',
          'The policy communicates the organisation commitment to protecting people, preventing harm, complying with applicable requirements and improving HSE performance. It should be communicated to relevant personnel and reflected in project arrangements.',
        ),
        _HseSection(
          'Leadership commitment',
          'Management should provide appropriate resources, competent people, safe equipment, time for planning and authority for corrective action. Safety requirements should remain part of planning and decision-making rather than being treated as a separate activity.',
        ),
        _HseSection(
          'Visible leadership',
          'Effective leadership can include site visits, review of critical controls, discussions with workers, review of significant findings and timely decisions on resources or work restrictions.',
        ),
        _HseSection(
          'Worker participation',
          'Workers should have practical opportunities to raise hazards, ask questions, report near misses and contribute to improvement. A reporting culture is stronger when people receive feedback on what happened after they raised a concern.',
        ),
      ],
    ),
    _HseModule(
      number: '03',
      title: 'HSE Organisation & Responsibilities',
      icon: Icons.groups_outlined,
      summary:
          'Understand accountability from project leadership to the individual worker.',
      sections: [
        _HseSection(
          'Project / Construction Management',
          'Provides overall project direction, resources, priorities, competent personnel and authority needed to implement the HSE arrangements.',
        ),
        _HseSection(
          'HSE Manager',
          'Coordinates the HSE management system, advises project management, monitors performance, supports audits and investigations, reviews significant risks and tracks corrective actions.',
        ),
        _HseSection(
          'HSE Engineer / Officer',
          'Conducts field inspections, verifies controls, supports risk assessments, checks relevant permits and RAMS, communicates hazards, records observations, follows corrective actions and escalates significant uncontrolled risks.',
        ),
        _HseSection(
          'HSE Supervisor',
          'Maintains close workface monitoring, checks daily conditions, follows up unsafe acts and conditions and coordinates immediate corrective action with supervisors.',
        ),
        _HseSection(
          'Supervisor / Foreman',
          'Controls the work at the workface, briefs workers, verifies competence and equipment, implements the approved method and stops or escalates work when conditions are unsafe.',
        ),
        _HseSection(
          'Worker',
          'Follows the approved method and instructions, uses required controls and PPE, reports hazards and incidents, participates in briefings and raises concerns about unsafe conditions.',
        ),
      ],
    ),
    _HseModule(
      number: '04',
      title: 'Legal & Regulatory Compliance',
      icon: Icons.gavel_outlined,
      summary:
          'Build a disciplined process for identifying and verifying applicable requirements.',
      sections: [
        _HseSection(
          'Compliance register',
          'Maintain a controlled list of applicable legal, authority, client and project requirements relevant to the work. Assign ownership and define how compliance will be checked.',
        ),
        _HseSection(
          'Requirement hierarchy',
          'Distinguish legislation, authority requirements, guidance, client requirements, company procedures and project-specific controls. Do not automatically treat every guidance document as legislation.',
        ),
        _HseSection(
          'Verification',
          'For each important requirement ask: What applies? Where is it implemented? Who is responsible? What evidence demonstrates compliance? What action is required if it is not met?',
        ),
        _HseSection(
          'Dubai/UAE reference discipline',
          'The app should be used as a learning aid. For legal decisions, always verify the current applicable Dubai/UAE authority requirement, approved project procedure and competent technical advice before relying on a specific regulatory requirement.',
        ),
      ],
    ),
    _HseModule(
      number: '05',
      title: 'Hazard Identification & Risk Assessment',
      icon: Icons.warning_amber_outlined,
      summary:
          'Learn the complete process from identifying a hazard to verifying residual risk.',
      sections: [
        _HseSection(
          'Hazard vs risk',
          'A hazard is a source or situation with potential to cause harm. Risk considers the likelihood and consequence of that harm. The distinction helps the team select appropriate controls.',
        ),
        _HseSection(
          'Risk assessment sequence',
          'Define the activity; identify hazards; identify people who may be affected; evaluate the initial risk; identify existing controls; select additional controls; assign responsibilities; communicate the controls; verify implementation; review when conditions change.',
        ),
        _HseSection(
          'Hierarchy of controls',
          'Use the hierarchy as a control-selection principle: Elimination, Substitution, Engineering Controls, Administrative Controls and PPE. Stronger controls should be considered before relying mainly on administrative measures or PPE.',
        ),
        _HseSection(
          'Dynamic assessment',
          'Review risk when the work sequence, equipment, environment, personnel, access, interfaces or other important conditions change. The assessment must reflect actual work, not only the original paperwork.',
        ),
        _HseSection(
          'Practical example',
          'For an open excavation, consider collapse, falls, underground services, water, plant interface and access. Controls may include a suitable protective system, safe access, edge protection, service verification, plant segregation, inspection and emergency arrangements as applicable.',
        ),
      ],
    ),
    _HseModule(
      number: '06',
      title: 'HSE Plan & Project Planning',
      icon: Icons.assignment_outlined,
      summary:
          'Convert project requirements into an organised HSE delivery plan.',
      sections: [
        _HseSection(
          'Typical HSE Plan elements',
          'Project objectives, organisation, responsibilities, risk management, training, inspection, audit, incident reporting, emergency arrangements, environmental controls, contractor management, communication and performance reporting.',
        ),
        _HseSection(
          'Planning before mobilisation',
          'Identify major activities, high-risk work, interfaces, resources, competence needs, emergency arrangements and critical controls before the work reaches the field.',
        ),
        _HseSection(
          'Work package planning',
          'For each significant activity verify the approved method, risk assessment, competent personnel, equipment, access, exclusion zones, permits where required, environmental conditions and emergency arrangements.',
        ),
        _HseSection(
          'SIMOPS',
          'Simultaneous operations should be coordinated so that lifting, excavation, traffic, hot work, electrical work, work at height and other activities do not create uncontrolled interface risks for each other.',
        ),
      ],
    ),
    _HseModule(
      number: '07',
      title: 'RAMS — Risk Assessment & Method Statement',
      icon: Icons.description_outlined,
      summary:
          'Understand how RAMS controls the planned sequence of work.',
      sections: [
        _HseSection(
          'Purpose',
          'RAMS should describe the task sequence, hazards, controls, responsibilities, equipment, competence requirements and relevant emergency arrangements.',
        ),
        _HseSection(
          'Method statement',
          'The method should explain how the work will actually be carried out safely, including preparation, sequence, interfaces, inspection or hold points and completion requirements.',
        ),
        _HseSection(
          'Briefing',
          'Affected workers should receive the relevant briefing and understand the hazards, controls, sequence and stop-work arrangements. A signature alone is not proof that the worker understands the task.',
        ),
        _HseSection(
          'Change management',
          'If site conditions materially differ from the approved RAMS, the work should be controlled and the method/risk assessment reviewed before continuing.',
        ),
      ],
    ),
    _HseModule(
      number: '08',
      title: 'Permit to Work — PTW',
      icon: Icons.fact_check_outlined,
      summary:
          'Learn PTW as a formal control and communication system.',
      sections: [
        _HseSection(
          'Purpose',
          'A PTW system provides formal control for specified higher-risk or controlled activities. It identifies the work, location, precautions, authorisation and validity requirements applicable to that task.',
        ),
        _HseSection(
          'Before work',
          'Verify the correct permit, work boundary, isolations or tests where required, competent persons, precautions, communication and actual site conditions.',
        ),
        _HseSection(
          'Examples',
          'Depending on project arrangements, controlled activities may include hot work, confined space, excavation or electrical isolation. The exact permit categories must follow the current approved project PTW procedure.',
        ),
        _HseSection(
          'Suspension and closure',
          'Suspend when conditions are no longer safe or authorised conditions change. Close the permit according to the approved project procedure after the work is safely completed.',
        ),
      ],
    ),
    _HseModule(
      number: '09',
      title: 'Training, Competency & Authorisation',
      icon: Icons.school_outlined,
      summary:
          'Separate training attendance from actual competence and authorisation.',
      sections: [
        _HseSection(
          'Training matrix',
          'Maintain an appropriate matrix covering induction, task-specific training, emergency training, specialist competence and refresher requirements.',
        ),
        _HseSection(
          'Competence',
          'Competence depends on appropriate knowledge, skills, experience and authorisation for the task. Safety-critical activities should be performed only by suitably competent and authorised personnel.',
        ),
        _HseSection(
          'Verification',
          'Check certificates or records where required, but also verify practical ability, understanding of the task and compliance with project authorisation arrangements.',
        ),
        _HseSection(
          'Toolbox talks',
          'A good toolbox talk is task-specific and should cover today’s work, hazards, controls, interfaces, changing conditions, emergency arrangements and worker questions.',
        ),
      ],
    ),
    _HseModule(
      number: '10',
      title: 'Inspection & Field Monitoring',
      icon: Icons.search_outlined,
      summary:
          'Verify that documented controls exist and work at the actual workface.',
      sections: [
        _HseSection(
          'Daily field inspection',
          'Review active work fronts, access, housekeeping, barriers, PPE, temporary works, equipment condition and critical controls appropriate to the activity.',
        ),
        _HseSection(
          'Critical-control verification',
          'Do not only count inspections. Verify controls that prevent serious outcomes, such as lifting exclusion zones, excavation protection, work-at-height protection or electrical isolation as applicable.',
        ),
        _HseSection(
          'Observation process',
          'Record the unsafe condition or act, identify the risk, apply immediate control when necessary, assign an action, set a realistic due date and verify closure.',
        ),
        _HseSection(
          'Communication',
          'Significant findings should be communicated to the responsible supervisor and escalated through the project structure when the risk cannot be controlled immediately.',
        ),
      ],
    ),
    _HseModule(
      number: '11',
      title: 'HSE Audit',
      icon: Icons.fact_check_outlined,
      summary:
          'Learn the difference between an inspection and a management-system audit.',
      sections: [
        _HseSection(
          'Inspection vs audit',
          'An inspection mainly checks workplace conditions and controls. An audit evaluates whether the management arrangements are established, implemented and effective using documents, records, interviews and field evidence.',
        ),
        _HseSection(
          'Audit preparation',
          'Define scope, criteria, areas, activities, evidence and responsible participants before the audit.',
        ),
        _HseSection(
          'Findings',
          'Classify findings according to the approved project audit process. Explain the evidence, requirement or expectation, risk significance and required action clearly.',
        ),
        _HseSection(
          'Close-out',
          'Verify corrective actions and their effectiveness. Closing paperwork without fixing the underlying issue does not demonstrate effective close-out.',
        ),
      ],
    ),
    _HseModule(
      number: '12',
      title: 'Incident & Near-Miss Management',
      icon: Icons.report_problem_outlined,
      summary:
          'Manage events from immediate response through learning and prevention.',
      sections: [
        _HseSection(
          'Immediate response',
          'Make the area safe, provide appropriate emergency response, raise the alarm and prevent further exposure. Preserve relevant information and evidence where appropriate.',
        ),
        _HseSection(
          'Notification',
          'Follow the project incident-reporting procedure and applicable requirements for notification and escalation.',
        ),
        _HseSection(
          'Investigation',
          'Establish what happened and examine contributing and underlying causes. Consider planning, supervision, equipment, procedures, competence, communication and organisational factors.',
        ),
        _HseSection(
          'Near misses',
          'Near misses are valuable learning opportunities because they can reveal failed controls before serious harm occurs. Record, investigate proportionately and share relevant lessons.',
        ),
      ],
    ),
    _HseModule(
      number: '13',
      title: 'Emergency Preparedness & Response',
      icon: Icons.emergency_outlined,
      summary:
          'Prepare people, equipment and communication before emergencies occur.',
      sections: [
        _HseSection(
          'Emergency plan',
          'Identify credible emergencies and define alarm, communication, emergency contacts, evacuation, assembly points, first aid, fire response, rescue arrangements and responsibilities.',
        ),
        _HseSection(
          'Emergency equipment',
          'Ensure relevant emergency equipment and access arrangements are identified, available, maintained and not obstructed.',
        ),
        _HseSection(
          'Drills',
          'Drills should test practical response, communication and coordination. Record observations and improve arrangements based on lessons learned.',
        ),
        _HseSection(
          'Restart after emergency',
          'Do not automatically restart affected work after the immediate event. Reassess hazards, inspect the area, confirm controls and obtain required authorisation before resuming.',
        ),
      ],
    ),
    _HseModule(
      number: '14',
      title: 'Contractor & Subcontractor Management',
      icon: Icons.handshake_outlined,
      summary:
          'Control risks introduced through external companies and work groups.',
      sections: [
        _HseSection(
          'Prequalification',
          'Review relevant HSE capability, experience, competent personnel, procedures and resources appropriate to the scope before engagement.',
        ),
        _HseSection(
          'Mobilisation',
          'Verify induction, RAMS, competency, supervision, equipment, permits and project requirements before work starts.',
        ),
        _HseSection(
          'Interface management',
          'Coordinate contractor activities with the main contractor, client, other subcontractors and site operations so that interfaces are controlled.',
        ),
        _HseSection(
          'Performance management',
          'Monitor inspections, observations, incidents, corrective actions and repeated non-conformances. Escalate persistent failures through the project management process.',
        ),
      ],
    ),
    _HseModule(
      number: '15',
      title: 'Environmental Management',
      icon: Icons.eco_outlined,
      summary:
          'Integrate environmental risk into normal project planning and control.',
      sections: [
        _HseSection(
          'Environmental aspects',
          'Consider waste, dust, noise, spills, chemicals, water, fuel, emissions, pollution prevention and housekeeping according to applicable and project requirements.',
        ),
        _HseSection(
          'Waste management',
          'Use the project waste process, segregation arrangements and approved disposal routes. Prevent uncontrolled dumping or mixing of incompatible waste streams.',
        ),
        _HseSection(
          'Spill prevention',
          'Identify spill sources, provide appropriate prevention and response arrangements and ensure workers know the required reporting and containment process.',
        ),
        _HseSection(
          'Environmental inspections',
          'Verify actual site conditions, storage arrangements, waste areas, drainage protection and housekeeping rather than relying only on environmental paperwork.',
        ),
      ],
    ),
    _HseModule(
      number: '16',
      title: 'Occupational Health, Welfare & Heat Stress',
      icon: Icons.health_and_safety_outlined,
      summary:
          'Manage health and welfare risks as part of the HSE system.',
      sections: [
        _HseSection(
          'Worker welfare',
          'Plan suitable welfare facilities, sanitation, drinking water, rest arrangements and other controls appropriate to the project and applicable requirements.',
        ),
        _HseSection(
          'Occupational health',
          'Consider health risks associated with noise, dust, chemicals, ergonomics, vibration, heat and other exposures relevant to the work.',
        ),
        _HseSection(
          'Heat-stress management',
          'For hot-weather work, use applicable current requirements and project arrangements for hydration, shaded recovery, work/rest planning, acclimatisation, awareness and response to symptoms.',
        ),
        _HseSection(
          'Worker awareness',
          'Workers should know common warning signs, preventive measures and how to report symptoms or request assistance without delay.',
        ),
      ],
    ),
    _HseModule(
      number: '17',
      title: 'HSE Communication & Worker Engagement',
      icon: Icons.campaign_outlined,
      summary:
          'Make safety information understandable, timely and relevant to the work.',
      sections: [
        _HseSection(
          'Communication channels',
          'Use induction, toolbox talks, pre-task briefings, signage, meetings, safety alerts, observations and direct supervisor communication as appropriate.',
        ),
        _HseSection(
          'Language and understanding',
          'Where workers speak different languages, use suitable communication methods so that critical hazards and controls are genuinely understood.',
        ),
        _HseSection(
          'Feedback loop',
          'When workers report hazards or near misses, provide feedback on the action taken. This encourages continued participation and improves reporting quality.',
        ),
      ],
    ),
    _HseModule(
      number: '18',
      title: 'HSE KPI & Performance Management',
      icon: Icons.analytics_outlined,
      summary:
          'Use performance data to identify risk and improve decisions.',
      sections: [
        _HseSection(
          'Leading indicators',
          'Examples include planned inspections completed, toolbox talks, training completion, safety observations, critical-control checks and corrective-action closure.',
        ),
        _HseSection(
          'Lagging indicators',
          'Examples include injuries, lost-time events, recordable incidents, property damage and environmental incidents.',
        ),
        _HseSection(
          'Balanced interpretation',
          'Do not judge safety performance from one number. A low incident count with poor reporting or weak field verification can give a misleading picture.',
        ),
        _HseSection(
          'Trend analysis',
          'Review repeated findings, high-risk activities, overdue actions and changes in performance over time. Use trends to focus management attention.',
        ),
      ],
    ),
    _HseModule(
      number: '19',
      title: 'Corrective Action, CAPA & Root Cause',
      icon: Icons.build_circle_outlined,
      summary:
          'Move beyond fixing symptoms and prevent recurrence.',
      sections: [
        _HseSection(
          'Immediate correction',
          'Take appropriate immediate action to remove or control the identified unsafe condition or non-conformance.',
        ),
        _HseSection(
          'Corrective action',
          'Address the cause of the identified problem and restore the required control.',
        ),
        _HseSection(
          'Root-cause thinking',
          'For significant or repeated events, examine why the control failed. Consider planning, design, supervision, competence, equipment, procedures, communication and organisational factors.',
        ),
        _HseSection(
          'Effectiveness check',
          'After implementation, verify that the action actually controls the risk and that the same failure has not remained elsewhere on the project.',
        ),
      ],
    ),
    _HseModule(
      number: '20',
      title: 'Document & Record Control',
      icon: Icons.folder_copy_outlined,
      summary:
          'Keep HSE information controlled, current, accessible and traceable.',
      sections: [
        _HseSection(
          'Typical records',
          'HSE plan, risk assessments, RAMS, permits, inspections, training records, toolbox talks, equipment records, incident reports, audits, corrective actions and emergency drill records may form part of the project HSE record system.',
        ),
        _HseSection(
          'Revision control',
          'Use controlled versions so that personnel do not unknowingly work from obsolete procedures or methods.',
        ),
        _HseSection(
          'Evidence',
          'Records should provide credible evidence of what was planned, communicated, inspected, authorised, observed and corrected.',
        ),
        _HseSection(
          'Field availability',
          'Critical information should be accessible to the people who need it at the point of work, subject to the project document-control process.',
        ),
      ],
    ),
    _HseModule(
      number: '21',
      title: 'Management Review',
      icon: Icons.manage_accounts_outlined,
      summary:
          'Use HSE information to make management decisions and allocate resources.',
      sections: [
        _HseSection(
          'Review inputs',
          'Consider HSE performance, audit findings, incidents, trends, corrective actions, requirement changes, resources, competence and improvement opportunities.',
        ),
        _HseSection(
          'Management decisions',
          'The review should result in meaningful decisions where gaps or risks require changes to resources, controls, procedures, training or priorities.',
        ),
        _HseSection(
          'Follow-up',
          'Actions from management review should have owners, target dates and effectiveness verification where appropriate.',
        ),
      ],
    ),
    _HseModule(
      number: '22',
      title: 'Continual Improvement — PDCA',
      icon: Icons.autorenew_outlined,
      summary:
          'Turn lessons, findings and performance data into stronger controls.',
      sections: [
        _HseSection(
          'Plan',
          'Understand the activity, requirements, hazards, resources and controls before work starts.',
        ),
        _HseSection(
          'Do',
          'Implement the planned controls, communicate them and supervise the work.',
        ),
        _HseSection(
          'Check',
          'Inspect, audit, observe, measure performance and investigate failures.',
        ),
        _HseSection(
          'Act',
          'Correct problems, learn from events and improve the system so that performance becomes more reliable.',
        ),
      ],
    ),
    _HseModule(
      number: '23',
      title: 'Practical HSE Officer Daily Routine',
      icon: Icons.engineering_outlined,
      summary:
          'A practical sequence for daily construction-site HSE monitoring.',
      sections: [
        _HseSection(
          'Before site walk',
          'Review planned activities, high-risk work, permits, RAMS, manpower, competency, equipment, interfaces, previous findings, weather/environmental conditions and emergency arrangements as relevant.',
        ),
        _HseSection(
          'Morning work-front check',
          'Visit active work areas and verify access, housekeeping, barriers, PPE, equipment, critical controls and whether actual work matches the approved plan.',
        ),
        _HseSection(
          'During the shift',
          'Focus on high-risk activities and changing conditions. Speak with workers and supervisors, record observations, apply immediate controls and escalate serious uncontrolled risks.',
        ),
        _HseSection(
          'Action follow-up',
          'Check previous findings and overdue actions. Confirm that the corrective action is actually effective before marking it closed.',
        ),
        _HseSection(
          'End-of-day review',
          'Review incidents, near misses, outstanding actions, permit status, housekeeping, next-shift risks and issues requiring management attention.',
        ),
      ],
    ),
    _HseModule(
      number: '24',
      title: 'Practical Construction-Site Scenarios',
      icon: Icons.construction_outlined,
      summary:
          'Apply the management-system concepts to realistic work situations.',
      sections: [
        _HseSection(
          'Scenario — Open excavation',
          'The team plans excavation near a vehicle route. Before work, verify the risk assessment, underground-service information, protective system, safe access, edge protection, plant segregation, inspection arrangements and emergency plan as applicable.',
        ),
        _HseSection(
          'Scenario — Lifting operation',
          'Before a critical lift, verify the approved lifting arrangement, competent personnel, suitable equipment and accessories, ground conditions, exclusion zone, communication and weather/environmental conditions as applicable.',
        ),
        _HseSection(
          'Scenario — Work at height',
          'Verify the planned method, suitable access, edge protection or other required fall-prevention system, equipment condition, competence, dropped-object controls and rescue arrangements where applicable.',
        ),
        _HseSection(
          'Scenario — Hot work',
          'Verify the applicable permit process, work area, ignition-source controls, fire precautions, suitable equipment, housekeeping, gas testing where required and emergency arrangements.',
        ),
        _HseSection(
          'Scenario — Repeated unsafe condition',
          'If the same finding repeatedly appears, do not treat it only as a housekeeping issue. Investigate why the control is repeatedly failing and consider supervision, planning, training, resources and management-system causes.',
        ),
      ],
    ),
    _HseModule(
      number: '25',
      title: 'HSE Officer / Supervisor / Manager Reference',
      icon: Icons.badge_outlined,
      summary:
          'Role-focused reference for practical work and professional development.',
      sections: [
        _HseSection(
          'HSE Officer focus',
          'Field verification, risk communication, inspections, observations, permit/RAMS checks, training support, incident reporting, corrective-action follow-up and escalation.',
        ),
        _HseSection(
          'HSE Supervisor focus',
          'Close workface monitoring, supervisor coordination, immediate intervention, daily field conditions and follow-up of critical controls.',
        ),
        _HseSection(
          'HSE Manager focus',
          'System performance, resources, audits, significant risks, incident learning, management reporting, legal/compliance oversight and continual improvement.',
        ),
        _HseSection(
          'Golden rule',
          'The HSE function should not replace line-management responsibility. Supervisors and managers own safe execution of the work; the HSE team provides advice, monitoring, verification and escalation according to the project organisation.',
        ),
      ],
    ),
    _HseModule(
      number: '26',
      title: 'Common HSE Management Failures',
      icon: Icons.error_outline,
      summary:
          'Recognise weak-system patterns before they become serious events.',
      sections: [
        _HseSection(
          'Paper compliance',
          'A signed RAMS, checklist or toolbox sheet does not prove that controls exist in the field.',
        ),
        _HseSection(
          'Generic risk assessment',
          'A generic assessment can miss actual site conditions, interfaces, equipment and changing hazards.',
        ),
        _HseSection(
          'Weak supervision',
          'Controls can fail when supervisors do not verify the workface or intervene when conditions change.',
        ),
        _HseSection(
          'Closing actions too quickly',
          'An action should not be closed simply because a photograph or note was uploaded. Verify that the risk has actually been controlled.',
        ),
        _HseSection(
          'Production pressure',
          'Schedule or production pressure should not be used as a reason to bypass critical controls or required authorisations.',
        ),
      ],
    ),
    _HseModule(
      number: '27',
      title: 'Quick Reference — HSE Management Checklist',
      icon: Icons.checklist_outlined,
      summary:
          'Use this as a quick mental checklist before and during work.',
      sections: [
        _HseSection(
          'PLAN',
          'Is the activity identified? Are hazards assessed? Are controls defined? Is the RAMS approved? Are competent people and suitable equipment available?',
        ),
        _HseSection(
          'AUTHORISE',
          'Are required permits, isolations, approvals and work boundaries verified?',
        ),
        _HseSection(
          'BRIEF',
          'Have workers been briefed and do they understand the hazards, controls and emergency arrangements?',
        ),
        _HseSection(
          'CONTROL',
          'Are physical controls, access, exclusion zones, PPE and supervision in place at the workface?',
        ),
        _HseSection(
          'CHECK',
          'Are inspections, observations and critical-control verifications being completed?',
        ),
        _HseSection(
          'ACT',
          'Are findings corrected, assigned, followed up and verified for effectiveness?',
        ),
        _HseSection(
          'LEARN',
          'Are incidents, near misses, trends and lessons learned being used to improve the system?',
        ),
      ],
    ),
    _HseModule(
      number: '28',
      title: 'Interview & Professional Learning Questions',
      icon: Icons.quiz_outlined,
      summary:
          'Questions to test understanding for HSE Officer and Supervisor development.',
      sections: [
        _HseSection(
          'Q1 — What is an HSE Management System?',
          'A structured framework for planning, implementing, monitoring and improving health, safety and environmental performance.',
        ),
        _HseSection(
          'Q2 — What is the hierarchy of controls?',
          'Elimination, Substitution, Engineering Controls, Administrative Controls and PPE.',
        ),
        _HseSection(
          'Q3 — What should happen when site conditions change?',
          'Control or stop the affected work as appropriate, reassess the risk, update the method or controls where required, brief affected personnel and verify before restart.',
        ),
        _HseSection(
          'Q4 — What is the difference between inspection and audit?',
          'Inspection focuses mainly on workplace conditions and controls; an audit evaluates the management arrangements and their effectiveness using evidence.',
        ),
        _HseSection(
          'Q5 — When is corrective action really closed?',
          'When the required action is implemented and its effectiveness has been verified according to the project process.',
        ),
        _HseSection(
          'Q6 — Who owns safety at the workface?',
          'Safety is a line-management responsibility. HSE supports, advises, monitors and escalates according to the project organisation.',
        ),
        _HseSection(
          'Q7 — What should an HSE Officer do when a critical uncontrolled risk is found?',
          'Take or request immediate appropriate control, prevent further exposure, inform the responsible supervision/management and escalate according to the project process.',
        ),
      ],
    ),
    _HseModule(
      number: '29',
      title: 'Learning Method — How to Study This Topic',
      icon: Icons.menu_book_outlined,
      summary:
          'A simple method for building practical HSE knowledge.',
      sections: [
        _HseSection(
          'Step 1 — Understand',
          'Read the concept and make sure you can explain it in your own words.',
        ),
        _HseSection(
          'Step 2 — Connect',
          'Connect the concept with risk assessment, RAMS, PTW, inspection, supervision and incident prevention.',
        ),
        _HseSection(
          'Step 3 — Apply',
          'Imagine the same requirement at a real construction workface and identify what you would physically check.',
        ),
        _HseSection(
          'Step 4 — Verify',
          'Ask what document, observation, interview or physical evidence would demonstrate that the control is actually implemented.',
        ),
        _HseSection(
          'Step 5 — Review',
          'Use the quick-reference and interview questions to test yourself regularly.',
        ),
      ],
    ),
    _HseModule(
      number: '30',
      title: 'Final HSE Management System Reference',
      icon: Icons.verified_outlined,
      summary:
          'Bring the whole management system together into one practical model.',
      sections: [
        _HseSection(
          'One-line model',
          'Leadership sets direction → Planning identifies risks → Controls are implemented → Competence and communication support the work → Inspection and audit verify performance → Incidents and findings create learning → Management review drives improvement.',
        ),
        _HseSection(
          'Workface model',
          'Before work: Plan and verify. During work: Control and supervise. When conditions change: Stop/control and reassess. When a problem occurs: Respond, report, investigate and learn. After correction: Verify effectiveness.',
        ),
        _HseSection(
          'Professional mindset',
          'A strong HSE professional does not only look for violations. The professional understands the work, identifies critical risks, verifies controls, communicates clearly, supports supervisors and workers, follows actions through to effectiveness and uses lessons to prevent recurrence.',
        ),
        _HseSection(
          'Reference caution',
          'This learning module is an educational and field-reference aid. Specific legal, authority, client and project requirements must always be checked against the current applicable source and approved project documentation before making compliance decisions.',
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: const Text(
          'Advanced Learning',
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
          const _AdvancedHero(),
          const SizedBox(height: 14),
          const _LearningNotice(),
          const SizedBox(height: 14),
          const Text(
            'HSE Management System — Detailed Modules',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w800,
              color: primary,
            ),
          ),
          const SizedBox(height: 10),
          for (final module in modules) ...[
            _ModuleCard(module: module),
            const SizedBox(height: 10),
          ],
        ],
      ),
    );
  }
}

class _ModuleCard extends StatelessWidget {
  final _HseModule module;

  const _ModuleCard({required this.module});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 1.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        childrenPadding: const EdgeInsets.fromLTRB(14, 0, 14, 12),
        leading: CircleAvatar(
          radius: 22,
          backgroundColor: const Color(0xFFE4F3EC),
          child: Icon(
            module.icon,
            color: const Color(0xFF0B6B4F),
            size: 25,
          ),
        ),
        title: Text(
          '${module.number}. ${module.title}',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Text(
            module.summary,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 12.8,
              height: 1.4,
              color: Color(0xFF53615B),
            ),
          ),
        ),
        iconColor: const Color(0xFF45554D),
        collapsedIconColor: const Color(0xFF45554D),
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFF4F8F5),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text(
              module.summary,
              style: const TextStyle(
                fontSize: 14,
                height: 1.6,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          for (final section in module.sections)
            Card(
              margin: const EdgeInsets.only(bottom: 8),
              elevation: 0,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
                side: const BorderSide(color: Color(0xFFDDE9E2)),
              ),
              child: ExpansionTile(
                tilePadding: const EdgeInsets.symmetric(
                  horizontal: 13,
                  vertical: 2,
                ),
                childrenPadding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
                leading: const Icon(
                  Icons.menu_book_outlined,
                  color: Color(0xFF0B6B4F),
                  size: 24,
                ),
                title: Text(
                  section.title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                iconColor: const Color(0xFF45554D),
                collapsedIconColor: const Color(0xFF45554D),
                children: [
                  Text(
                    section.body,
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.65,
                      color: Color(0xFF26342E),
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

class _AdvancedHero extends StatelessWidget {
  const _AdvancedHero();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF0B6B4F),
            Color(0xFF159447),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.menu_book_rounded,
            color: Colors.white,
            size: 40,
          ),
          SizedBox(height: 10),
          Text(
            'Advanced Learning & Field Reference',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: 7),
          Text(
            'Study the complete HSE management cycle from leadership and planning to field control, monitoring, incident learning and continual improvement.',
            style: TextStyle(
              color: Colors.white,
              height: 1.55,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

class _LearningNotice extends StatelessWidget {
  const _LearningNotice();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(
          color: Color(0xFFD8E6DE),
        ),
      ),
      child: const Padding(
        padding: EdgeInsets.all(15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.info_outline,
              color: Color(0xFF0B6B4F),
            ),
            SizedBox(width: 11),
            Expanded(
              child: Text(
                'Learning and field-reference aid. For actual compliance decisions, always follow the current applicable Dubai/UAE requirements, approved project procedures, RAMS, permits and competent technical instructions.',
                style: TextStyle(
                  fontSize: 13.2,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AdvancedButton extends StatelessWidget {
  final VoidCallback onTap;

  const _AdvancedButton({
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            gradient: const LinearGradient(
              colors: [
                Color(0xFF0B6B4F),
                Color(0xFF159447),
              ],
            ),
          ),
          child: const Row(
            children: [
              CircleAvatar(
                radius: 26,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.menu_book_rounded,
                  color: Color(0xFF0B6B4F),
                  size: 29,
                ),
              ),
              SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '📚 Advanced Learning',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Tap to open detailed study and field reference',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.white,
                size: 19,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuickMapCard extends StatelessWidget {
  const _QuickMapCard();

  @override
  Widget build(BuildContext context) {
    const items = [
      'Policy & Leadership',
      'Responsibilities',
      'Legal Compliance',
      'Risk Assessment',
      'HSE Plan',
      'RAMS',
      'PTW',
      'Training',
      'Inspection & Audit',
      'Incident Management',
      'Emergency',
      'Contractor Management',
      'Environment',
      'Occupational Health',
      'KPI',
      'CAPA',
      'Document Control',
      'Management Review',
      'Daily HSE Routine',
      'Interview Reference',
    ];

    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Learning Roadmap',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 7,
              runSpacing: 7,
              children: [
                for (final item in items)
                  Chip(
                    avatar: const Icon(
                      Icons.check_circle_outline,
                      size: 17,
                    ),
                    label: Text(item),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _HseModule {
  final String number;
  final String title;
  final IconData icon;
  final String summary;
  final List<_HseSection> sections;

  const _HseModule({
    required this.number,
    required this.title,
    required this.icon,
    required this.summary,
    required this.sections,
  });
}

class _HseSection {
  final String title;
  final String body;

  const _HseSection(
    this.title,
    this.body,
  );
}
