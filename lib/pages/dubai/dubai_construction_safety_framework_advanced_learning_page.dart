
import 'package:flutter/material.dart';

/// SafeNexus HSE
/// Dubai Construction Safety Framework — Advanced Learning
///
/// Standalone advanced-learning page.
/// Uses dynamic item input so it remains compatible with the existing
/// Dubai Construction Safety Framework main page without depending on
/// a specific model class.

class DubaiConstructionSafetyAdvancedLearningPage extends StatelessWidget {
  final dynamic item;

  const DubaiConstructionSafetyAdvancedLearningPage({
    super.key,
    required this.item,
  });

  String get _title {
    try {
      final value = item.title;
      if (value is String && value.trim().isNotEmpty) return value;
    } catch (_) {}
    try {
      final value = item.name;
      if (value is String && value.trim().isNotEmpty) return value;
    } catch (_) {}
    return 'Construction Safety Framework';
  }

  @override
  Widget build(BuildContext context) {
    final content = _contentFor(_title);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F8F6),
      appBar: AppBar(
        title: Text(
          _title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        backgroundColor: const Color(0xFF0B6B4F),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
        children: [
          _hero(context, _title),
          const SizedBox(height: 14),
          _section(
            '1. Core Explanation',
            content.core,
            Icons.school_outlined,
          ),
          _section(
            '2. Detailed Learning',
            content.learning,
            Icons.menu_book_outlined,
          ),
          _section(
            '3. Field Verification',
            content.fieldVerification,
            Icons.fact_check_outlined,
          ),
          _section(
            '4. Critical Control Points',
            content.criticalControls,
            Icons.verified_user_outlined,
          ),
          _section(
            '5. Hazards & Possible Consequences',
            content.hazards,
            Icons.warning_amber_rounded,
          ),
          _section(
            '6. Stop-Work Triggers',
            content.stopWork,
            Icons.pan_tool_alt_outlined,
          ),
          _section(
            '7. Practical Site Scenario',
            content.scenario,
            Icons.engineering_outlined,
          ),
          _section(
            '8. Deeper Learning',
            content.deeper,
            Icons.lightbulb_outline,
          ),
        ],
      ),
    );
  }

  Widget _hero(BuildContext context, String title) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0B6B4F), Color(0xFF159447)],
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.08),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.health_and_safety_outlined,
            color: Colors.white,
            size: 38,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'ADVANCED LEARNING',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.1,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 7),
                const Text(
                  'Professional field-learning module for construction HSE practice, supervision and decision-making.',
                  style: TextStyle(
                    color: Colors.white,
                    height: 1.4,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _section(String heading, List<String> points, IconData icon) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 1.2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 15, 16, 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(icon, color: const Color(0xFF0B6B4F), size: 22),
                const SizedBox(width: 9),
                Expanded(
                  child: Text(
                    heading,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF17352B),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ...points.map(
              (point) => Padding(
                padding: const EdgeInsets.only(bottom: 9),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 6),
                      child: Icon(
                        Icons.circle,
                        size: 5,
                        color: Color(0xFF159447),
                      ),
                    ),
                    const SizedBox(width: 9),
                    Expanded(
                      child: Text(
                        point,
                        style: const TextStyle(
                          fontSize: 13.5,
                          height: 1.48,
                          color: Color(0xFF34433D),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _LearningContent _contentFor(String title) {
    final key = title.toLowerCase();

    if (key.contains('management system')) {
      return _LearningContent(
        core: [
          'A construction HSE management system is the organised framework used to plan, implement, monitor and improve health and safety throughout the project lifecycle.',
          'It connects leadership, HSE planning, risk assessment, RAMS, competence, supervision, inspection, incident management, emergency response and corrective action.',
          'The objective is not simply to produce documents. The objective is to ensure that the controls described in the management system are actually implemented and verified in the field.',
        ],
        learning: [
          'Establish clear HSE responsibilities from project management through supervisors and workers.',
          'Set project HSE objectives and measurable performance indicators appropriate to the work scope and risk profile.',
          'Integrate HSE requirements into mobilisation, procurement, subcontractor selection, work planning and daily supervision.',
          'Use a document-control process so that teams work to the current approved plans, RAMS, permits and drawings.',
          'Create a feedback loop: inspection finding → action → responsible person → target date → verification → closure.',
          'Review the system when scope, sequence, design, equipment, workforce or site conditions change.',
        ],
        fieldVerification: [
          'Confirm the project HSE organisation chart and responsibilities are understood by supervisors.',
          'Check that current HSE plans, RAMS, permits and inspection forms are available at the point of work.',
          'Interview workers to verify that the documented controls are understood.',
          'Compare planned controls with actual site conditions and work methods.',
          'Check whether previous inspection and incident actions are genuinely closed rather than only marked closed.',
        ],
        criticalControls: [
          'Visible management leadership and adequate HSE resources.',
          'Clear ownership of every significant risk and corrective action.',
          'Effective communication between contractor, subcontractor, supervisor and workforce.',
          'Management of change whenever the original risk assumptions no longer apply.',
          'Routine verification of critical controls instead of relying only on paperwork.',
        ],
        hazards: [
          'A paper-based system with weak field implementation can leave high-risk activities uncontrolled.',
          'Unclear responsibilities can cause gaps between contractor, subcontractor and supervisor.',
          'Outdated RAMS or drawings can lead workers to follow an unsafe method.',
          'Repeated open actions can allow known hazards to remain in the workplace.',
        ],
        stopWork: [
          'Critical controls required for the task are absent or have failed.',
          'The actual work method materially differs from the approved safe system without reassessment.',
          'Competent supervision is unavailable for a high-risk activity.',
          'Workers cannot explain the critical hazards or required controls for the task.',
        ],
        scenario: [
          'A subcontractor starts a high-risk activity using a RAMS document that does not reflect a recent change in site layout. The HSE professional stops the activity, confirms the changed conditions, requires the work method and risk assessment to be reviewed, communicates the revised controls and verifies implementation before restart.',
        ],
        deeper: [
          'A mature HSE management system is a control cycle rather than a folder of documents: Plan → Assess → Control → Implement → Verify → Learn → Improve.',
          'The strongest systems make safety decisions at the planning stage, where hazards can often be eliminated or reduced before workers are exposed.',
        ],
      );
    }

    if (key.contains('risk assessment')) {
      return _LearningContent(
        core: [
          'Risk assessment identifies hazards, evaluates the risk created by the work and determines controls before and during execution.',
          'On a construction project, risk assessment must reflect the actual task, location, people, plant, environment, interfaces and changing site conditions.',
        ],
        learning: [
          'Define the activity and work boundaries clearly before identifying hazards.',
          'Identify routine, non-routine and reasonably foreseeable abnormal conditions.',
          'Consider people who may be affected, including workers, visitors, other contractors and the public.',
          'Apply the hierarchy of controls: eliminate, substitute, engineering controls, administrative controls and PPE.',
          'Assign control ownership and establish how critical controls will be verified.',
          'Review the assessment when there is a change in method, sequence, design, equipment, personnel or environmental condition.',
        ],
        fieldVerification: [
          'Check the risk assessment against the actual workface rather than only reviewing the document.',
          'Ask the supervisor to identify the highest-risk steps and their critical controls.',
          'Verify that workers received task-specific briefing and can explain the key controls.',
          'Check that residual risks are acceptable under the project approval process.',
        ],
        criticalControls: [
          'Task-specific hazard identification.',
          'Controls that address the hazard at source wherever reasonably practicable.',
          'Clear ownership for critical controls.',
          'Effective communication and worker involvement.',
          'Dynamic reassessment when conditions change.',
        ],
        hazards: [
          'Generic risk assessments may miss site-specific hazards.',
          'Risk ratings can create false confidence if controls are not verified.',
          'Changes in work sequence can introduce new interfaces and simultaneous-operation risks.',
        ],
        stopWork: [
          'A critical hazard has not been assessed or controlled.',
          'The risk assessment no longer matches the work being performed.',
          'Workers are exposed to a changed condition for which no control has been established.',
        ],
        scenario: [
          'Excavation work is planned beside an active lifting route. During the shift, the lifting exclusion zone overlaps the excavation access route. The work is paused, the interface is reassessed, routes and exclusion zones are revised, and the revised controls are briefed before work resumes.',
        ],
        deeper: [
          'Risk assessment is most effective when it drives the work method. A strong assessment therefore influences design, sequencing, temporary works, access, plant selection and emergency arrangements—not just the final risk score.',
        ],
      );
    }

    if (key.contains('ram') || key.contains('method statement')) {
      return _LearningContent(
        core: [
          'RAMS means the documented combination of risk assessment and method statement used to explain how work will be carried out safely and under controlled conditions.',
          'The method statement should translate identified hazards into a practical sequence of work, responsibilities, controls, resources and verification points.',
        ],
        learning: [
          'Describe the exact work scope, location, interfaces and sequence.',
          'Identify prerequisites such as permits, drawings, inspections, competence and equipment readiness.',
          'Explain the safe sequence from preparation through completion and handover.',
          'Identify hold points and critical control checks before the next stage starts.',
          'Define emergency arrangements relevant to the task.',
          'Brief the RAMS to the workforce and confirm understanding.',
        ],
        fieldVerification: [
          'Verify the approved revision is available at the workface.',
          'Check that the method described matches the actual equipment and sequence.',
          'Interview the supervisor and workers about the critical steps.',
          'Confirm required permits and inspections are completed before work starts.',
        ],
        criticalControls: [
          'Correct scope and current revision.',
          'Task-specific controls and sequence.',
          'Defined responsibilities and competent supervision.',
          'Pre-start checks and hold points.',
          'Change control and re-briefing.',
        ],
        hazards: [
          'Using an obsolete revision can invalidate important controls.',
          'A vague method statement may leave critical decisions to workers without adequate guidance.',
          'Uncontrolled changes can bypass the original risk assessment.',
        ],
        stopWork: [
          'Work starts without an approved applicable RAMS where required.',
          'The actual method differs significantly from the approved sequence.',
          'A critical prerequisite or hold point has not been satisfied.',
        ],
        scenario: [
          'A concrete operation changes from the planned pump arrangement to a different setup. The supervisor pauses the activity, reviews the changed equipment and interfaces, updates the safe method and risk controls through the project change process, then re-briefs the crew.',
        ],
        deeper: [
          'RAMS should be treated as a live operational control. Its quality is demonstrated by how well it guides decisions at the workface, not by document length.',
        ],
      );
    }

    if (key.contains('work at height')) {
      return _LearningContent(
        core: [
          'Work at height includes work where a person could fall from one level to another and suffer injury. Construction controls should prioritise prevention of falls and protection from falling objects.',
          'The safest approach is to eliminate work at height where reasonably practicable, then use collective protection before relying on individual systems.',
        ],
        learning: [
          'Plan access, work position, material handling and rescue before the task starts.',
          'Select suitable platforms, guardrails, access systems and fall-protection arrangements for the work.',
          'Control openings, edges, fragile surfaces and changes in level.',
          'Prevent tools and materials from falling onto people below.',
          'Ensure equipment is inspected and users are competent.',
          'Coordinate work above and below to avoid conflicting activities.',
        ],
        fieldVerification: [
          'Inspect access and working platforms before use.',
          'Check edge protection and openings.',
          'Verify that fall-protection equipment is suitable, inspected and correctly used where required.',
          'Confirm dropped-object controls and exclusion zones.',
        ],
        criticalControls: [
          'Suitable collective fall prevention.',
          'Safe access and egress.',
          'Secure working platforms and edge protection.',
          'Dropped-object prevention.',
          'Rescue arrangements appropriate to the fall-protection system.',
        ],
        hazards: [
          'Falls from unprotected edges, openings or incomplete platforms.',
          'Falling tools and materials.',
          'Unsafe access or overreaching.',
          'Improvised platforms and unauthorised modifications.',
        ],
        stopWork: [
          'Missing or defective edge protection.',
          'Unsafe access or an incomplete working platform.',
          'Fall-protection system cannot be safely used or rescued.',
          'Dropped-object controls are not established where people may be exposed.',
        ],
        scenario: [
          'A worker is asked to install services beside an open floor edge. The planned work position has inadequate collective protection. The supervisor stops the task, establishes a suitable protected work platform and access arrangement, confirms the controls and then permits the work to continue.',
        ],
        deeper: [
          'Height safety is strongest when the workface is designed so the worker does not need to depend on personal fall arrest. Temporary works, sequencing and prefabrication can often reduce exposure significantly.',
        ],
      );
    }

    if (key.contains('lifting')) {
      return _LearningContent(
        core: [
          'Lifting operations involve planned movement of a load using lifting equipment and accessories. Construction lifting must be controlled through suitable planning, competent personnel, inspected equipment and a managed exclusion zone.',
          'The lifting plan should match the actual crane, load, radius, ground conditions, route, interfaces and environmental conditions.',
        ],
        learning: [
          'Confirm the load characteristics, centre of gravity and lifting points.',
          'Select suitable lifting equipment and accessories for the planned operation.',
          'Verify ground conditions, access, setup area and proximity hazards.',
          'Establish communication arrangements, roles and exclusion zones.',
          'Control suspended-load movement and prevent people from entering the danger area.',
          'Use pre-lift checks and stop the operation when conditions become unsafe.',
        ],
        fieldVerification: [
          'Verify equipment identification, inspection status and suitability.',
          'Check lifting accessories before use.',
          'Confirm setup, ground condition and exclusion zone.',
          'Verify that the lifting team understands signals and roles.',
          'Confirm weather and site conditions remain suitable.',
        ],
        criticalControls: [
          'Competent lifting team.',
          'Suitable and inspected equipment/accessories.',
          'Approved task-specific lifting plan where required.',
          'Stable setup and controlled load path.',
          'Effective communication and exclusion zone.',
        ],
        hazards: [
          'Dropped loads, equipment instability, struck-by incidents and uncontrolled load swing.',
          'Interface with scaffolding, excavation, temporary works, buildings, services and traffic.',
        ],
        stopWork: [
          'Ground condition or equipment setup becomes unsafe.',
          'Load weight, lifting points or equipment suitability cannot be confirmed.',
          'People enter the exclusion zone or communication is lost.',
          'Wind or other environmental conditions exceed the safe operating limits established for the equipment and operation.',
        ],
        scenario: [
          'A heavy HVAC unit is ready for lifting but the planned load path crosses an active access route. The lifting team stops the operation, isolates the route, establishes a controlled exclusion zone, verifies the lift plan and communication system, and only then proceeds.',
        ],
        deeper: [
          'A lifting operation is an engineered and managed system. The crane itself is only one element; ground condition, rigging, load path, communication, exclusion, competence and interfaces determine overall risk.',
        ],
      );
    }

    if (key.contains('excavation')) {
      return _LearningContent(
        core: [
          'Excavation safety controls collapse, falls, falling materials, underground-service strikes, plant interaction, water ingress and hazardous atmospheres.',
          'The protection system must be appropriate to the ground conditions, excavation geometry, depth, adjacent structures and planned work activities.',
        ],
        learning: [
          'Confirm underground services and site constraints before excavation.',
          'Select a suitable protection method such as engineered shoring, shielding, benching or sloping as applicable.',
          'Control access, egress, plant movement and edge loading.',
          'Keep spoil, materials and equipment controlled so they do not create additional loading or falling-object hazards.',
          'Provide inspection and reassessment after relevant changes or events.',
        ],
        fieldVerification: [
          'Inspect the excavation, protective system, access and edge conditions.',
          'Check water ingress, cracks, ground movement and nearby loads.',
          'Verify service identification and controls.',
          'Check plant exclusion and traffic arrangements.',
        ],
        criticalControls: [
          'Suitable protective system and competent oversight.',
          'Safe access and egress.',
          'Edge and falling-object control.',
          'Underground-service protection.',
          'Inspection and dynamic reassessment.',
        ],
        hazards: [
          'Ground collapse, engulfment, falls, falling spoil, service strike, flooding and plant interaction.',
        ],
        stopWork: [
          'Signs of instability, collapse or unexpected ground movement.',
          'Protective system is damaged, incomplete or unsuitable.',
          'Unknown or uncontrolled underground services are encountered.',
          'Water ingress or environmental conditions compromise stability.',
        ],
        scenario: [
          'Unexpected water and ground movement appear in an excavation after nearby work. The competent person stops entry, isolates the area, reassesses the conditions and protection system, and only allows re-entry after safe conditions and controls are re-established.',
        ],
        deeper: [
          'Excavation safety depends on interaction between soil, water, geometry, adjacent loads, protection systems and human behaviour. Treat changes in any of these factors as potential changes to the risk profile.',
        ],
      );
    }

    if (key.contains('temporary works')) {
      return _LearningContent(
        core: [
          'Temporary works are structures or systems required to enable construction, support existing structures or provide temporary stability. Failure can have severe consequences because loads and conditions may change during construction.',
          'Temporary works require controlled design, review, installation, inspection, modification and removal.',
        ],
        learning: [
          'Define the temporary works scope, design basis and load assumptions.',
          'Establish responsibilities for design, review, approval, erection and inspection.',
          'Control sequencing and temporary stability during each construction stage.',
          'Prevent unauthorised alteration or removal of supports.',
          'Inspect after installation and after events that could affect stability.',
        ],
        fieldVerification: [
          'Confirm the installed arrangement matches the approved design and drawings.',
          'Check supports, connections, bracing and foundations.',
          'Verify inspection status and restrictions on modification.',
          'Confirm load paths are clear and no unplanned loads are imposed.',
        ],
        criticalControls: [
          'Competent design and review.',
          'Controlled erection sequence.',
          'Temporary stability at every stage.',
          'Inspection and change control.',
          'Protection against unauthorised modification.',
        ],
        hazards: [
          'Progressive collapse, instability, overload, incorrect installation and premature removal.',
        ],
        stopWork: [
          'Installed temporary works differ from the approved design.',
          'Damage, movement or instability is observed.',
          'Required design information or inspection status is unavailable.',
          'Unauthorised modification has occurred.',
        ],
        scenario: [
          'A contractor proposes removing a temporary support to improve access. The request is stopped because the support forms part of the temporary load path. The temporary works responsible person reviews the proposal and provides an approved sequence before any change is made.',
        ],
        deeper: [
          'Temporary works are often safety-critical because construction creates changing load paths. The correct question is not only “Is the structure designed?” but also “Is the structure stable in this exact construction stage?”',
        ],
      );
    }

    if (key.contains('plant') || key.contains('machinery')) {
      return _LearningContent(
        core: [
          'Construction plant and machinery can create crushing, struck-by, entanglement, overturning, electrical, mechanical and traffic risks. Safe use depends on equipment suitability, guarding, competence, inspection and controlled interaction with people.',
        ],
        learning: [
          'Select plant suitable for the task, environment and load.',
          'Ensure operators are competent and authorised for the equipment.',
          'Maintain effective guarding and safety devices.',
          'Establish pedestrian and vehicle segregation where practicable.',
          'Use pre-use inspections and defect reporting.',
          'Control maintenance, isolation and stored energy.',
        ],
        fieldVerification: [
          'Check equipment condition and inspection status.',
          'Verify guards, emergency stops, alarms and other safety devices.',
          'Confirm operator competence and task authorisation.',
          'Check work area, visibility, traffic interface and exclusion arrangements.',
        ],
        criticalControls: [
          'Correct plant selection.',
          'Competent operator.',
          'Effective guarding and safety devices.',
          'Pre-use inspection.',
          'Pedestrian segregation and traffic control.',
        ],
        hazards: [
          'Moving parts, reversing vehicles, blind spots, dropped attachments, unexpected movement and maintenance energy.',
        ],
        stopWork: [
          'Safety-critical guard or device is defective.',
          'Equipment has an uncontrolled defect.',
          'Operator is not competent or authorised.',
          'People are exposed to uncontrolled plant movement.',
        ],
        scenario: [
          'A mobile plant operator reports a defective reversing alarm. The machine is removed from service for assessment rather than allowing the operator to compensate by relying on spotters alone.',
        ],
        deeper: [
          'Engineering controls are generally more reliable than behavioural instructions alone. Guarding, segregation, interlocks and physical separation should therefore be considered before relying on warnings or PPE.',
        ],
      );
    }

    if (key.contains('traffic') || key.contains('public protection')) {
      return _LearningContent(
        core: [
          'Construction traffic management controls interaction between vehicles, mobile plant, workers, visitors and the public. The system should define routes, segregation, access points, speed control, reversing arrangements and public protection.',
        ],
        learning: [
          'Plan vehicle and pedestrian routes before work begins.',
          'Separate people and vehicles using physical controls where reasonably practicable.',
          'Control gates, deliveries, reversing and temporary route changes.',
          'Maintain visibility, lighting, signs and housekeeping.',
          'Coordinate traffic management with lifting, excavation and emergency access.',
        ],
        fieldVerification: [
          'Walk the route and identify blind spots and conflict points.',
          'Check barriers, signs, access control and pedestrian routes.',
          'Observe delivery and reversing practices.',
          'Confirm emergency routes remain available.',
        ],
        criticalControls: [
          'Physical segregation.',
          'Controlled vehicle routes and access.',
          'Reversing controls.',
          'Competent banksman/traffic control where required by the site system.',
          'Public protection at site boundaries and interfaces.',
        ],
        hazards: [
          'Vehicle-pedestrian collision, reversing incidents, struck-by events and public intrusion.',
        ],
        stopWork: [
          'Pedestrian route is unexpectedly exposed to moving vehicles.',
          'Traffic control measures are displaced or ineffective.',
          'Emergency access is blocked.',
          'Public protection is compromised.',
        ],
        scenario: [
          'A delivery vehicle blocks the designated pedestrian route. The delivery is paused, the vehicle is moved to the approved unloading area and the pedestrian route is restored before normal site movement resumes.',
        ],
        deeper: [
          'Traffic management is an interface-control problem. Its effectiveness depends on how well it coordinates deliveries, plant, lifting operations, excavation, emergency response and public access rather than treating traffic as a separate activity.',
        ],
      );
    }

    if (key.contains('emergency')) {
      return _LearningContent(
        core: [
          'Emergency preparedness ensures the project can respond rapidly and effectively to foreseeable emergencies such as fire, collapse, serious injury, hazardous release, rescue from height or confined space and major environmental events.',
        ],
        learning: [
          'Identify credible emergency scenarios from the project risk profile.',
          'Define alarm, communication, evacuation, assembly and accountability arrangements.',
          'Provide suitable rescue equipment and trained personnel for task-specific risks.',
          'Coordinate emergency arrangements with contractors, visitors and external responders.',
          'Exercise and review the plan so weaknesses are identified before a real emergency.',
        ],
        fieldVerification: [
          'Check emergency routes and access.',
          'Verify assembly arrangements and communication systems.',
          'Confirm task-specific rescue equipment and competence.',
          'Check emergency contact information and site access arrangements.',
        ],
        criticalControls: [
          'Credible scenario planning.',
          'Clear alarm and communication.',
          'Reliable evacuation and accountability.',
          'Task-specific rescue capability.',
          'Regular testing and learning from drills/incidents.',
        ],
        hazards: [
          'Delayed response, blocked access, poor communication, inadequate rescue capability and incomplete accountability.',
        ],
        stopWork: [
          'Emergency access or evacuation route is blocked.',
          'Required rescue capability is unavailable for a high-risk task.',
          'Alarm or communication system cannot reliably function.',
        ],
        scenario: [
          'A work-at-height activity is planned in an isolated area, but the agreed rescue equipment is unavailable. The task is not started until an appropriate rescue arrangement and competent response capability are established.',
        ],
        deeper: [
          'Emergency planning should begin with the question: “What can realistically go wrong here, and how will we recover people quickly?” A generic emergency plan may not address task-specific rescue needs.',
        ],
      );
    }

    if (key.contains('incident') || key.contains('near-miss')) {
      return _LearningContent(
        core: [
          'Incident and near-miss management is a learning and corrective-action process. The objective is to understand what happened, why controls failed or were bypassed, and how recurrence will be prevented.',
        ],
        learning: [
          'Make the area safe and protect people first.',
          'Preserve relevant evidence and establish the sequence of events.',
          'Collect information from people, equipment, documents and site conditions.',
          'Look beyond immediate unsafe acts to underlying system and management factors.',
          'Assign corrective actions that address causes and verify effectiveness.',
        ],
        fieldVerification: [
          'Check whether immediate controls were restored.',
          'Verify corrective actions at the physical workface.',
          'Review whether similar exposures exist elsewhere on the project.',
          'Confirm lessons learned were communicated to affected teams.',
        ],
        criticalControls: [
          'Immediate scene control.',
          'Accurate evidence gathering.',
          'Cause-focused investigation.',
          'Effective corrective actions.',
          'Verification of close-out and learning.',
        ],
        hazards: [
          'Repeating an incident because the investigation only identifies the worker action and not the failed controls.',
        ],
        stopWork: [
          'A serious uncontrolled exposure remains after an incident.',
          'The same critical control has failed repeatedly.',
          'Corrective action is not implemented and people remain exposed.',
        ],
        scenario: [
          'A worker nearly falls because temporary edge protection was removed during material movement. The investigation identifies not only the removal but also weak change control and supervision. Controls are redesigned and verified before similar work resumes.',
        ],
        deeper: [
          'A near miss is valuable because it reveals a control weakness without necessarily producing injury. Strong HSE systems use near misses as early-warning indicators.',
        ],
      );
    }

    if (key.contains('contractor') || key.contains('subcontractor')) {
      return _LearningContent(
        core: [
          'Contractor and subcontractor HSE management ensures every organisation working on the project meets the project safety requirements and that interfaces between companies are controlled.',
        ],
        learning: [
          'Prequalify contractors against relevant competence, resources and HSE capability.',
          'Communicate project rules, hazards, emergency arrangements and interfaces before mobilisation.',
          'Review contractor RAMS and competence for the actual scope.',
          'Monitor performance through inspections, observations, audits and meetings.',
          'Control changes in subcontractor scope and workforce.',
        ],
        fieldVerification: [
          'Check that subcontractor workers understand project controls.',
          'Verify current competency and authorisation requirements.',
          'Compare subcontractor methods with approved project arrangements.',
          'Check corrective-action performance and repeat findings.',
        ],
        criticalControls: [
          'Clear contractual HSE expectations.',
          'Competence verification.',
          'Interface management.',
          'Consistent site rules.',
          'Performance monitoring and corrective action.',
        ],
        hazards: [
          'Different contractors may apply conflicting methods, creating interface risks.',
          'Weak subcontractor control can allow unsafe practices to become normalised.',
        ],
        stopWork: [
          'A contractor starts work outside the approved scope or method.',
          'Required competence or supervision is absent.',
          'Critical project controls are ignored.',
        ],
        scenario: [
          'A subcontractor introduces new plant and a different work sequence without informing the main contractor. The activity is paused until the change is assessed, interfaces are reviewed and the workforce is briefed.',
        ],
        deeper: [
          'Contractor management is strongest when it is integrated into project planning and supervision. Safety cannot be outsourced simply because the work is subcontracted.',
        ],
      );
    }

    if (key.contains('inspection') || key.contains('audit') || key.contains('monitoring')) {
      return _LearningContent(
        core: [
          'Inspection, audit and performance monitoring provide assurance that the HSE management system and field controls are functioning.',
          'Inspection is generally focused on physical and operational conditions; audits examine system effectiveness; monitoring uses trends and indicators to identify improvement needs.',
        ],
        learning: [
          'Use risk-based inspection frequencies and focus on critical controls.',
          'Record clear findings with location, responsible person and target date.',
          'Escalate serious findings immediately.',
          'Verify corrective actions physically before closure.',
          'Use trend analysis to identify recurring problems and systemic weaknesses.',
        ],
        fieldVerification: [
          'Inspect high-risk workfaces during actual operations.',
          'Check whether previously closed findings remain controlled.',
          'Verify that action owners understand the required corrective measure.',
          'Review recurring findings for root causes.',
        ],
        criticalControls: [
          'Risk-based focus.',
          'Competent inspectors/auditors.',
          'Clear findings and ownership.',
          'Timely corrective action.',
          'Independent verification of closure.',
        ],
        hazards: [
          'Checklist-only inspections can miss changing conditions.',
          'Closing actions without physical verification can leave hazards uncontrolled.',
        ],
        stopWork: [
          'A critical control is absent or failed.',
          'A serious finding is ignored or repeatedly not corrected.',
          'Unsafe work continues despite previous escalation.',
        ],
        scenario: [
          'Repeated housekeeping findings are closed every week but return in the same work zone. The HSE team escalates from repeated observations to a systemic review of material flow, waste collection, supervision and contractor responsibility.',
        ],
        deeper: [
          'Good HSE performance is not the absence of recorded findings. It is evidence that critical risks are controlled consistently and that the system learns from recurring weaknesses.',
        ],
      );
    }

    if (key.contains('competent') || key.contains('supervision')) {
      return _LearningContent(
        core: [
          'Competence means having the knowledge, skills, experience and authority appropriate to the task. Supervision ensures the planned controls are translated into safe execution.',
        ],
        learning: [
          'Define competence requirements for safety-critical tasks before mobilisation.',
          'Verify qualifications, experience, task-specific training and practical capability as applicable.',
          'Match supervision intensity to risk and worker experience.',
          'Ensure supervisors understand when to stop work and escalate.',
          'Maintain clear responsibility during shifts, handovers and simultaneous operations.',
        ],
        fieldVerification: [
          'Ask who is responsible for the task and who can stop it.',
          'Check that competent persons are actually present when required.',
          'Observe whether supervisors monitor critical controls.',
          'Confirm shift handover communicates changes and outstanding hazards.',
        ],
        criticalControls: [
          'Defined competence criteria.',
          'Verification rather than assumption.',
          'Adequate supervision.',
          'Clear authority to stop unsafe work.',
          'Effective handover.',
        ],
        hazards: [
          'Unverified competence can lead to incorrect equipment use, poor judgement and uncontrolled deviations.',
          'Weak supervision can allow small deviations to become serious exposures.',
        ],
        stopWork: [
          'Required competent person is unavailable.',
          'Worker competence cannot be established for a safety-critical task.',
          'Supervision is inadequate for the risk level.',
        ],
        scenario: [
          'A specialist temporary-works activity is scheduled during a night shift, but the required competent supervision is unavailable. The activity is postponed rather than proceeding with an informal substitute.',
        ],
        deeper: [
          'Competence is task- and context-specific. A person may be experienced generally but not competent to make a particular safety-critical decision without the required technical knowledge or authority.',
        ],
      );
    }

    if (key.contains('high-risk')) {
      return _LearningContent(
        core: [
          'High-risk activities are tasks where the potential for serious injury, fatality, major property damage or significant environmental impact is elevated. These activities require stronger planning, supervision and verification.',
        ],
        learning: [
          'Identify high-risk activities during project planning and update the list as scope changes.',
          'Use task-specific RAMS, permits and competent supervision where required.',
          'Define critical controls and verify them before exposure occurs.',
          'Coordinate simultaneous operations and interfaces.',
          'Establish clear stop-work criteria.',
        ],
        fieldVerification: [
          'Identify the current high-risk activities on site.',
          'Check that controls are active at the workface.',
          'Confirm supervision and competent personnel.',
          'Review simultaneous-operation interfaces.',
        ],
        criticalControls: [
          'Task-specific planning.',
          'Critical-control verification.',
          'Competent supervision.',
          'Permit/interface control where applicable.',
          'Effective exclusion and emergency arrangements.',
        ],
        hazards: [
          'Failure of a single critical control can lead rapidly to a major event.',
          'Multiple activities may create combined risks not visible within individual RAMS.',
        ],
        stopWork: [
          'A critical control is missing or ineffective.',
          'The work changes without reassessment.',
          'Required permit, competent supervision or exclusion control is absent.',
        ],
        scenario: [
          'Lifting is planned while façade work continues below. The combined exposure creates a dropped-object and suspended-load interface. Work is paused until the activities are sequenced or physically separated.',
        ],
        deeper: [
          'High-risk work should be managed through critical controls rather than long lists of generic precautions. Identify the few controls that must never fail and verify them deliberately.',
        ],
      );
    }

    if (key.contains('project hse plan') || key.contains('hse plan')) {
      return _LearningContent(
        core: [
          'The Project HSE Plan explains how the project will manage health, safety and environmental risks throughout construction. It should be tailored to the project scope, location, organisation, hazards and interfaces.',
        ],
        learning: [
          'Define project HSE objectives, organisation and responsibilities.',
          'Describe risk-management, RAMS, permit, inspection, audit and incident processes.',
          'Address emergency response, worker welfare, environmental controls and contractor management.',
          'Define communication, training, consultation and reporting arrangements.',
          'Keep the plan under document control and update it when project conditions change.',
        ],
        fieldVerification: [
          'Confirm the plan reflects current project scope and organisation.',
          'Check that site procedures implement the commitments in the plan.',
          'Interview supervisors and workers to test awareness.',
          'Review whether performance data and corrective actions feed back into the plan.',
        ],
        criticalControls: [
          'Project-specific content.',
          'Clear responsibilities.',
          'Integration with RAMS and operational controls.',
          'Management of change.',
          'Performance review and continuous improvement.',
        ],
        hazards: [
          'A generic plan may overlook project-specific interfaces and high-risk activities.',
          'A plan that is not implemented becomes a compliance document rather than a safety-control system.',
        ],
        stopWork: [
          'Critical project controls are not defined or implemented.',
          'Current site conditions are outside the assumptions of the HSE plan and no change review has occurred.',
        ],
        scenario: [
          'A project enters a phase with major excavation, lifting and public-interface activities. The HSE plan is reviewed to ensure the organisation, resources, emergency arrangements and monitoring arrangements remain suitable for the new risk profile.',
        ],
        deeper: [
          'The HSE plan should act as the project-level control architecture. Task RAMS, permits, inspections and emergency plans should connect back to this framework rather than operating as isolated documents.',
        ],
      );
    }

    if (key.contains('public') || key.contains('site security')) {
      return _LearningContent(
        core: [
          'Public protection and site security prevent unauthorised access and protect people outside the construction operation from project hazards.',
        ],
        learning: [
          'Maintain secure boundaries, controlled access and suitable warning information.',
          'Identify interfaces with roads, pedestrians, neighbouring properties and occupied buildings.',
          'Control openings, deliveries, temporary diversions and public-facing work.',
          'Coordinate security with emergency access so controls do not obstruct rescue or firefighting.',
        ],
        fieldVerification: [
          'Walk the perimeter and public interface.',
          'Check barriers, gates, signage and access points.',
          'Look for gaps created by temporary works, deliveries or route changes.',
          'Verify public protection remains effective during changing work phases.',
        ],
        criticalControls: [
          'Effective site boundary.',
          'Controlled access.',
          'Physical protection at public interfaces.',
          'Clear communication and warning arrangements.',
          'Continuous monitoring during temporary changes.',
        ],
        hazards: [
          'Public entering the work area, falling objects, vehicle interaction and unsafe temporary diversions.',
        ],
        stopWork: [
          'Public can enter an uncontrolled hazardous area.',
          'Site boundary or protection is compromised.',
          'Construction activity creates an uncontrolled risk to adjacent public areas.',
        ],
        scenario: [
          'A temporary pedestrian diversion is moved during a delivery and leaves pedestrians close to moving plant. The delivery is stopped, the route is reinstated and the traffic-control arrangement is reviewed.',
        ],
        deeper: [
          'Public protection requires thinking beyond the project fence. People outside the project may not understand construction hazards, so controls should not depend on their behaviour.',
        ],
      );
    }

    if (key.contains('stop-work')) {
      return _LearningContent(
        core: [
          'Stop-work authority is the controlled decision to pause an activity when critical safety conditions are not satisfied. It is a preventive control, not a failure of production.',
        ],
        learning: [
          'Define clear triggers before work starts.',
          'Ensure workers and supervisors understand that unsafe work can be stopped without waiting for an incident.',
          'Make the work area safe before investigation or correction.',
          'Identify the failed control, correct it and verify the correction.',
          'Re-brief affected personnel before restart when the method or controls change.',
        ],
        fieldVerification: [
          'Ask workers who has authority to stop work.',
          'Check that previous stop-work events resulted in effective corrective action.',
          'Observe whether supervisors act when critical controls fail.',
        ],
        criticalControls: [
          'Clear stop-work criteria.',
          'Visible management support.',
          'Immediate hazard isolation.',
          'Competent reassessment.',
          'Verified restart.',
        ],
        hazards: [
          'Production pressure can cause workers to continue despite failed controls.',
          'Unclear authority can delay intervention during rapidly developing hazards.',
        ],
        stopWork: [
          'Any uncontrolled immediate danger to people.',
          'Failure of a safety-critical control.',
          'Unexpected condition that invalidates the safe method.',
          'Loss of required competence, supervision, communication or emergency capability.',
        ],
        scenario: [
          'During a lift, the exclusion zone is breached. The banksman stops the operation, the load is brought to a safe condition, the area is re-established and the team confirms the control before continuing.',
        ],
        deeper: [
          'A strong stop-work culture is an early-warning system. It allows the organisation to correct control failures before they become incidents.',
        ],
      );
    }

    if (key.contains('construction safety framework') || key.contains('introduction')) {
      return _LearningContent(
        core: [
          'The Dubai Construction Safety Framework is best understood as an integrated approach to managing construction health and safety through planning, risk control, competent people, safe systems of work, supervision, inspection, emergency preparedness and continuous improvement.',
          'For practical site use, the framework connects project-level management requirements with task-level controls such as RAMS, permits, inspections, exclusion zones, temporary works and emergency arrangements.',
        ],
        learning: [
          'Start with project scope, construction sequence and interfaces. Identify where people, plant, structures, temporary works and public areas interact.',
          'Establish the project HSE management arrangements and assign clear responsibilities.',
          'Identify hazards and assess risk before work starts, then reassess when conditions change.',
          'Translate risk controls into practical RAMS, permits and workface instructions.',
          'Provide competent people, suitable equipment, adequate supervision and resources.',
          'Verify critical controls through inspections, observations, audits and direct field engagement.',
          'Use incident and near-miss learning to strengthen controls and prevent recurrence.',
          'Maintain emergency preparedness for the credible worst-case scenarios associated with the project.',
        ],
        fieldVerification: [
          'Can the supervisor explain the current high-risk activities and their critical controls?',
          'Are current RAMS, permits, drawings and inspection records available where the work is happening?',
          'Do workers understand the hazards and know when to stop?',
          'Are temporary works, plant, access, traffic and exclusion arrangements physically suitable?',
          'Are previous findings and incidents producing visible improvements?',
        ],
        criticalControls: [
          'Leadership and accountability.',
          'Project-specific HSE planning.',
          'Task-specific risk assessment and RAMS.',
          'Competent persons and effective supervision.',
          'Critical-control verification for high-risk activities.',
          'Management of change and simultaneous operations.',
          'Emergency preparedness and response.',
          'Inspection, audit, learning and continual improvement.',
        ],
        hazards: [
          'Weak planning can allow hazards to reach the workface before controls are established.',
          'Poor interfaces between contractors can create risks that are not owned by any one party.',
          'Changing construction conditions can invalidate earlier assumptions.',
          'Production pressure can encourage deviation from the safe system of work.',
        ],
        stopWork: [
          'Immediate uncontrolled danger exists.',
          'A critical control required by the safe system has failed.',
          'The actual conditions no longer match the approved plan or RAMS.',
          'Required competent supervision, equipment, permit or emergency capability is unavailable.',
          'An unexpected condition creates a new significant risk that has not been assessed.',
        ],
        scenario: [
          'A multi-storey construction project enters a phase where lifting, façade work, temporary works and traffic movement occur simultaneously. The HSE team identifies the interfaces, reviews the work sequence and RAMS, separates incompatible activities, verifies exclusion zones and temporary stability, briefs the workforce and monitors the critical controls during execution.',
        ],
        deeper: [
          'The most useful way to apply the framework is to think in layers: project governance → risk assessment → safe system of work → competent execution → field verification → learning and improvement.',
          'If one layer is weak, the next layer must not simply compensate indefinitely. Management should fix the system weakness rather than relying on workers to manage excessive risk through personal caution.',
          'A professional HSE practitioner should continuously ask three questions: What can go wrong? What critical control prevents it? How do I know that control is working right now?',
        ],
      );
    }

    return _LearningContent(
      core: [
        'This advanced module explains the selected construction-safety topic as an operational control rather than a document-only requirement.',
        'The purpose is to help HSE professionals, engineers, supervisors and workers understand the hazard, required controls and field-verification approach.',
      ],
      learning: [
        'Define the work scope and interfaces.',
        'Identify hazards and assess the risk before exposure.',
        'Select practical controls using the hierarchy of controls.',
        'Assign responsibilities and verify competence.',
        'Brief the workforce and supervise the work.',
        'Inspect and reassess when conditions change.',
      ],
      fieldVerification: [
        'Check the actual workface against the approved safe system.',
        'Verify critical controls physically.',
        'Speak with the supervisor and workers.',
        'Record and close findings through the project action process.',
      ],
      criticalControls: [
        'Suitable planning.',
        'Task-specific risk control.',
        'Competent people.',
        'Effective supervision.',
        'Inspection and change management.',
      ],
      hazards: [
        'Generic controls may not address the actual site conditions.',
        'Uncontrolled changes can introduce new hazards.',
      ],
      stopWork: [
        'Critical controls are missing or ineffective.',
        'The work method is no longer suitable for current conditions.',
        'Required competence, supervision or emergency capability is unavailable.',
      ],
      scenario: [
        'A planned activity changes because site conditions are different from the original plan. The supervisor pauses the work, reassesses the risk, updates the controls through the project process and briefs the workforce before restart.',
      ],
      deeper: [
        'Professional HSE practice is based on continual verification: planned controls must be visible, understood, implemented and effective at the workface.',
      ],
    );
  }
}

class _LearningContent {
  final List<String> core;
  final List<String> learning;
  final List<String> fieldVerification;
  final List<String> criticalControls;
  final List<String> hazards;
  final List<String> stopWork;
  final List<String> scenario;
  final List<String> deeper;

  const _LearningContent({
    required this.core,
    required this.learning,
    required this.fieldVerification,
    required this.criticalControls,
    required this.hazards,
    required this.stopWork,
    required this.scenario,
    required this.deeper,
  });
}
