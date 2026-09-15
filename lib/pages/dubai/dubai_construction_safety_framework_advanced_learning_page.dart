
import 'package:flutter/material.dart';

/// SafeNexus HSE
/// Dubai Construction Safety Framework — Professional Advanced Learning
///
/// Standalone file. It deliberately accepts dynamic `item` so it can be
/// connected to the existing framework page without requiring a model import.

class DubaiConstructionSafetyAdvancedLearningPage extends StatelessWidget {
  final dynamic item;

  const DubaiConstructionSafetyAdvancedLearningPage({
    super.key,
    required this.item,
  });

  String get title {
    try {
      final v = item.title;
      if (v is String && v.trim().isNotEmpty) return v;
    } catch (_) {}
    return 'Construction Safety Framework';
  }

  @override
  Widget build(BuildContext context) {
    final data = _data(title);

    return Scaffold(
      backgroundColor: const Color(0xFFF4F7F5),
      appBar: AppBar(
        title: Text(title, maxLines: 2, overflow: TextOverflow.ellipsis),
        backgroundColor: const Color(0xFF0B6B4F),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 30),
        children: [
          _hero(),
          const SizedBox(height: 12),
          _block('1. Introduction — What is it?', data.introduction, Icons.menu_book_outlined),
          _block('2. Types / Systems / Key Elements', data.types, Icons.account_tree_outlined),
          _block('3. Components & Requirements', data.components, Icons.construction_outlined),
          _block('4. Technical & Planning Requirements', data.technical, Icons.engineering_outlined),
          _block('5. Main Hazards', data.hazards, Icons.warning_amber_rounded),
          _block('6. Safety Controls', data.controls, Icons.shield_outlined),
          _block('7. Field Verification — What to Check', data.field, Icons.fact_check_outlined),
          _block('8. Inspection & Monitoring', data.inspection, Icons.search_outlined),
          _block('9. Stop-Work Conditions', data.stopWork, Icons.pan_tool_alt_outlined),
          _block('10. Practical Site Example', data.example, Icons.location_on_outlined),
          _block('11. Quick Learning Formula', data.formula, Icons.bolt_outlined),
          _block('12. Deeper Learning', data.deeper, Icons.lightbulb_outline),
        ],
      ),
    );
  }

  Widget _hero() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0B6B4F), Color(0xFF159447)],
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.health_and_safety_outlined, color: Colors.white, size: 38),
          SizedBox(height: 8),
          Text(
            'ADVANCED LEARNING • FIELD REFERENCE',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: .8,
            ),
          ),
          SizedBox(height: 5),
          Text(
            'Professional Construction Safety Framework',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(height: 7),
          Text(
            'Structured for HSE Officers, Engineers, Supervisors, Consultants and workers.',
            style: TextStyle(color: Colors.white, height: 1.4, fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _block(String heading, List<String> points, IconData icon) {
    return Card(
      margin: const EdgeInsets.only(bottom: 11),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 15, 15, 13),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(icon, size: 22, color: const Color(0xFF0B6B4F)),
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
            const SizedBox(height: 11),
            ...points.asMap().entries.map(
              (e) => Padding(
                padding: const EdgeInsets.only(bottom: 9),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${e.key + 1}.',
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF159447),
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        e.value,
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

  _FrameworkData _data(String raw) {
    final k = raw.toLowerCase();

    if (k.contains('risk assessment')) {
      return const _FrameworkData(
        introduction: [
          'Risk assessment is the structured process of identifying hazards, evaluating the risk created by an activity and selecting controls before people are exposed.',
          'A construction risk assessment must reflect the real workface, sequence, people, plant, environment, interfaces and reasonably foreseeable changes.',
        ],
        types: [
          'Project / activity risk assessment — establishes the risk profile for planned work.',
          'Task risk assessment — focuses on a defined task and its steps.',
          'Dynamic review — reassesses conditions when the workface changes.',
          'Interface assessment — addresses risks created by simultaneous operations or neighbouring activities.',
        ],
        components: [
          'Work scope and boundaries.',
          'Hazard identification and exposed persons.',
          'Initial risk evaluation.',
          'Control measures using the hierarchy of controls.',
          'Residual risk and approval arrangements.',
          'Responsible persons, verification points and review triggers.',
        ],
        technical: [
          'Break the activity into logical steps before assessing hazards.',
          'Consider normal, abnormal and emergency conditions.',
          'Give priority to elimination and engineering controls before administrative controls and PPE.',
          'Define critical controls that must be physically verified.',
          'Review the assessment after significant change, incident, near miss or discovery of a new hazard.',
        ],
        hazards: [
          'Generic assessments may miss site-specific hazards.',
          'Controls may exist on paper but fail at the workface.',
          'Changing sequences can introduce new interfaces.',
          'Workers may continue using an assessment that no longer matches the actual job.',
        ],
        controls: [
          'Use task-specific hazard identification.',
          'Involve people who understand the actual work.',
          'Assign clear ownership for significant controls.',
          'Brief workers before exposure.',
          'Verify critical controls during the work, not only before it.',
          'Stop and reassess when conditions change.',
        ],
        field: [
          'Does the assessment describe the actual work location and sequence?',
          'Can the supervisor identify the highest-risk steps?',
          'Can workers explain the critical controls?',
          'Are engineering and physical controls actually installed?',
          'Are interfaces with lifting, excavation, traffic, temporary works or other contractors controlled?',
        ],
        inspection: [
          'Observe the work while it is happening.',
          'Check critical controls against the assessment.',
          'Record deviations and assign corrective actions.',
          'Verify closure physically.',
          'Trend repeated findings and revise the control system when necessary.',
        ],
        stopWork: [
          'A significant hazard is not assessed or controlled.',
          'The workface has changed materially from the assessment.',
          'A critical control has failed.',
          'Required supervision or competence is unavailable.',
          'A new interface creates an unacceptable exposure.',
        ],
        example: [
          'A lifting activity is planned beside an excavation. During preparation, the load path is found to pass through the excavation access area. The team pauses, reassesses the interface, separates the routes, verifies the exclusion zone and re-briefs the crew before restarting.',
        ],
        formula: [
          'DEFINE THE TASK → IDENTIFY HAZARDS → CONTROL THE RISK → VERIFY THE CONTROLS → REVIEW THE CHANGE.',
        ],
        deeper: [
          'A risk assessment is not successful because the risk score looks low. It is successful when the critical controls are suitable, implemented and effective at the workface.',
          'The strongest assessments influence design, sequencing, equipment selection, access, temporary works and emergency arrangements before exposure occurs.',
        ],
      );
    }

    if (k.contains('hse plan')) {
      return const _FrameworkData(
        introduction: [
          'The Project HSE Plan is the project-level framework describing how health, safety and environmental risks will be managed throughout construction.',
          'It should connect management arrangements with practical site systems such as RAMS, permits, inspections, emergency response, training and contractor control.',
        ],
        types: [
          'Project HSE management arrangements.',
          'Construction-phase HSE controls.',
          'Emergency and response arrangements.',
          'Worker welfare and occupational-health arrangements.',
          'Environmental and waste-management arrangements.',
          'Monitoring, audit, reporting and improvement arrangements.',
        ],
        components: [
          'HSE organisation and responsibilities.',
          'Risk-management process.',
          'RAMS and permit systems.',
          'Competence, training and consultation.',
          'Inspection and audit programme.',
          'Incident and corrective-action process.',
          'Emergency preparedness.',
          'Contractor and subcontractor management.',
        ],
        technical: [
          'Make the plan project-specific rather than generic.',
          'Define who owns each HSE process and how performance will be measured.',
          'Maintain document control and current revisions.',
          'Integrate changes in project scope and construction sequence.',
          'Ensure resources and competent personnel are available to implement the plan.',
        ],
        hazards: [
          'A generic plan may fail to address project-specific risks.',
          'Conflicting contractor procedures may create interface gaps.',
          'An outdated plan can leave the project working to obsolete assumptions.',
        ],
        controls: [
          'Clear management accountability.',
          'Adequate HSE resources.',
          'Current approved documentation.',
          'Strong contractor coordination.',
          'Field verification and performance review.',
        ],
        field: [
          'Check that site procedures actually implement the HSE Plan.',
          'Interview supervisors and workers.',
          'Verify current emergency, inspection and reporting arrangements.',
          'Check that high-risk activities are covered by suitable task controls.',
        ],
        inspection: [
          'Review implementation during site inspections.',
          'Audit selected HSE processes.',
          'Trend findings, incidents and corrective actions.',
          'Review the plan when the project enters a materially different phase.',
        ],
        stopWork: [
          'Critical project controls are not established.',
          'Site conditions fall outside the assumptions of the current plan.',
          'Required HSE resources or competence are unavailable.',
        ],
        example: [
          'A project moves from structural works into façade, lifting and fit-out activities. The project team reviews the HSE arrangements, identifies new interfaces and updates planning, supervision, emergency and monitoring requirements before the new phase starts.',
        ],
        formula: [
          'PLAN → ORGANISE → CONTROL → IMPLEMENT → VERIFY → LEARN → IMPROVE.',
        ],
        deeper: [
          'The HSE Plan should function as the project control architecture. Individual RAMS, permits and inspections should fit into that architecture rather than operate as disconnected paperwork.',
        ],
      );
    }

    if (k.contains('ram') || k.contains('method statement')) {
      return const _FrameworkData(
        introduction: [
          'RAMS combines risk assessment with a method statement so the workforce understands both the hazards and the controlled sequence of work.',
          'A good method statement turns risk controls into practical actions, responsibilities, prerequisites and hold points.',
        ],
        types: [
          'Routine task RAMS.',
          'High-risk activity RAMS.',
          'Interface / simultaneous-operation RAMS.',
          'Revised RAMS following a significant change.',
        ],
        components: [
          'Scope and location.',
          'Sequence of operations.',
          'Plant, tools and materials.',
          'Competence and supervision.',
          'Hazards and critical controls.',
          'Permits and prerequisites.',
          'Inspection / hold points.',
          'Emergency arrangements.',
        ],
        technical: [
          'Use the correct approved revision.',
          'Make the sequence realistic and consistent with drawings and site conditions.',
          'Define hold points before safety-critical stages.',
          'Control deviations through the project change process.',
          'Brief affected workers and verify understanding.',
        ],
        hazards: [
          'Obsolete documents.',
          'Generic wording.',
          'Uncontrolled deviations.',
          'Missing prerequisites or hold points.',
        ],
        controls: [
          'Current approved revision.',
          'Task-specific sequence.',
          'Competent supervision.',
          'Worker briefing.',
          'Pre-start and hold-point verification.',
          'Change management.',
        ],
        field: [
          'Compare the RAMS with the actual workface.',
          'Ask workers to explain the critical steps.',
          'Verify permits, inspections and equipment readiness.',
          'Check that the supervisor is controlling deviations.',
        ],
        inspection: [
          'Observe execution against the approved sequence.',
          'Record deviations.',
          'Escalate significant deviations.',
          'Reassess and re-brief after approved changes.',
        ],
        stopWork: [
          'No applicable approved RAMS where required.',
          'Actual work materially differs from the approved method.',
          'Critical prerequisite or hold point is not satisfied.',
        ],
        example: [
          'A planned concrete operation changes equipment arrangement. The supervisor pauses the activity, reassesses the changed interface and updates the safe method through the project change process before restarting.',
        ],
        formula: [
          'SCOPE → SEQUENCE → HAZARDS → CONTROLS → RESPONSIBILITIES → VERIFY → EXECUTE.',
        ],
        deeper: [
          'RAMS quality is demonstrated at the workface. A long document is not automatically a good safe system; the worker must be able to understand and apply the critical controls.',
        ],
      );
    }

    if (k.contains('competent') || k.contains('supervision')) {
      return const _FrameworkData(
        introduction: [
          'Competence means having the knowledge, skills, experience and authority appropriate to the work. Supervision ensures the safe system is implemented in the field.',
        ],
        types: [
          'Task competence.',
          'Equipment / plant competence.',
          'Technical or inspection competence.',
          'Supervisory competence.',
          'Safety-critical specialist competence.',
        ],
        components: [
          'Defined competence criteria.',
          'Qualification or training evidence where applicable.',
          'Relevant experience.',
          'Task-specific understanding.',
          'Authority and responsibility.',
          'Adequate supervision.',
        ],
        technical: [
          'Identify competence requirements before mobilisation.',
          'Verify competence rather than assuming it.',
          'Match supervision intensity to risk and workforce experience.',
          'Provide effective shift handover and continuity of responsibility.',
        ],
        hazards: [
          'Unverified competence.',
          'Inadequate supervision.',
          'Unclear responsibility.',
          'Loss of competent oversight during shift changes.',
        ],
        controls: [
          'Competence verification.',
          'Clear appointment and responsibility.',
          'Adequate supervision.',
          'Worker briefing and communication.',
          'Stop-work authority.',
        ],
        field: [
          'Ask who is responsible for the task.',
          'Verify required competence evidence.',
          'Observe supervisory presence and behaviour.',
          'Check that workers know escalation routes.',
        ],
        inspection: [
          'Review competence records as applicable.',
          'Observe actual performance.',
          'Identify repeated errors or weak supervision.',
          'Review competence after significant method or equipment changes.',
        ],
        stopWork: [
          'Required competent person is absent.',
          'Competence cannot be established for a safety-critical task.',
          'Supervision is inadequate for the risk.',
        ],
        example: [
          'A safety-critical temporary-works activity is scheduled on a shift where the required competent supervision is unavailable. The work is postponed until the correct competence and authority are available.',
        ],
        formula: [
          'RIGHT PERSON → RIGHT COMPETENCE → RIGHT AUTHORITY → RIGHT SUPERVISION.',
        ],
        deeper: [
          'Competence is contextual. General construction experience does not automatically make a person competent to make every specialist or safety-critical decision.',
        ],
      );
    }

    if (k.contains('temporary works')) {
      return const _FrameworkData(
        introduction: [
          'Temporary works are temporary structures or systems used to support construction, provide stability, enable access or protect people and property during the construction process.',
        ],
        types: [
          'Formwork and falsework.',
          'Temporary propping and shoring.',
          'Excavation support.',
          'Temporary access and platforms.',
          'Temporary bridges or working arrangements.',
          'Temporary stability systems.',
        ],
        components: [
          'Design basis and load assumptions.',
          'Drawings and installation sequence.',
          'Supports, connections and bracing.',
          'Foundations or bearing arrangements.',
          'Inspection and handover status.',
          'Modification and removal controls.',
        ],
        technical: [
          'Establish design responsibility and review requirements.',
          'Control erection and dismantling sequence.',
          'Maintain stability at each construction stage.',
          'Prevent unauthorised modification.',
          'Reinspect after relevant events or changes.',
        ],
        hazards: [
          'Collapse.',
          'Instability.',
          'Overloading.',
          'Incorrect installation.',
          'Premature removal.',
          'Unauthorised modification.',
        ],
        controls: [
          'Competent design and review.',
          'Approved installation sequence.',
          'Competent erection and inspection.',
          'Controlled loading.',
          'Change control.',
          'Protected temporary stability.',
        ],
        field: [
          'Compare installed arrangement with approved information.',
          'Check supports, bracing and connections.',
          'Look for movement, damage or distress.',
          'Verify inspection / handover status.',
          'Confirm no unauthorised alterations have occurred.',
        ],
        inspection: [
          'Inspect after installation.',
          'Inspect at defined stages and after relevant events.',
          'Record defects and restrict use where necessary.',
          'Verify corrective actions before release.',
        ],
        stopWork: [
          'Movement, damage or instability is observed.',
          'Installed works differ materially from approved design.',
          'Inspection status is unavailable where required.',
          'Unauthorised modification has occurred.',
        ],
        example: [
          'A temporary support is proposed for removal to improve access. The work is stopped because the support may form part of the temporary load path. The temporary-works responsible person reviews the change and provides an approved sequence before removal.',
        ],
        formula: [
          'DESIGN → REVIEW → INSTALL → INSPECT → CONTROL LOADS → MODIFY ONLY WITH APPROVAL → REMOVE SAFELY.',
        ],
        deeper: [
          'Temporary works can be most vulnerable during construction transitions because loads and support conditions change. Stability must therefore be considered for every construction stage, not only the final arrangement.',
        ],
      );
    }

    if (k.contains('plant') || k.contains('machinery')) {
      return const _FrameworkData(
        introduction: [
          'Plant and machinery safety controls moving equipment, mechanical hazards, energy sources and interaction between operators, pedestrians and other work activities.',
        ],
        types: [
          'Mobile plant.',
          'Lifting and material-handling equipment.',
          'Powered hand tools.',
          'Fixed machinery.',
          'Earthmoving equipment.',
          'Specialist construction equipment.',
        ],
        components: [
          'Suitable equipment selection.',
          'Guarding and safety devices.',
          'Operator controls.',
          'Inspection and maintenance.',
          'Isolation and stored-energy controls.',
          'Traffic / pedestrian segregation.',
        ],
        technical: [
          'Select equipment suitable for the task and environment.',
          'Verify operator competence and authorisation.',
          'Maintain guarding and safety devices.',
          'Control maintenance and isolation.',
          'Use pre-use inspections and defect reporting.',
        ],
        hazards: [
          'Crushing.',
          'Struck-by incidents.',
          'Entanglement.',
          'Unexpected movement.',
          'Overturning.',
          'Stored energy.',
        ],
        controls: [
          'Physical guarding.',
          'Segregation.',
          'Competent operation.',
          'Pre-use checks.',
          'Isolation.',
          'Maintenance control.',
        ],
        field: [
          'Inspect plant condition.',
          'Check safety devices and guards.',
          'Verify operator competence.',
          'Observe pedestrian interaction.',
          'Check work area and visibility.',
        ],
        inspection: [
          'Pre-use inspection.',
          'Planned inspection and maintenance.',
          'Defect reporting.',
          'Verification before return to service.',
        ],
        stopWork: [
          'Safety-critical guard or device is defective.',
          'Plant has an uncontrolled defect.',
          'Operator competence is not established.',
          'People are exposed to uncontrolled movement.',
        ],
        example: [
          'A mobile plant machine develops a safety-critical defect. The operator reports it and the equipment is removed from service until assessed and released through the site process.',
        ],
        formula: [
          'SELECT → COMPETENT OPERATOR → INSPECT → CONTROL MOVEMENT → ISOLATE FOR MAINTENANCE → VERIFY.',
        ],
        deeper: [
          'Engineering controls such as guarding and segregation are generally more reliable than relying only on warnings or worker behaviour.',
        ],
      );
    }

    if (k.contains('work at height')) {
      return const _FrameworkData(
        introduction: [
          'Work at height is work where a person could fall from one level to another and suffer injury. Construction planning should prioritise preventing falls and falling objects.',
        ],
        types: [
          'Work from protected platforms.',
          'Work using temporary access systems.',
          'Work near open edges or openings.',
          'Work using personal fall-protection systems where appropriate.',
        ],
        components: [
          'Safe access and egress.',
          'Working platform.',
          'Guardrails and edge protection.',
          'Protection of openings.',
          'Falling-object controls.',
          'Suitable fall-protection and rescue arrangements where required.',
        ],
        technical: [
          'Eliminate work at height where reasonably practicable.',
          'Use collective fall prevention before personal protection where suitable.',
          'Plan rescue before using systems that depend on fall arrest.',
          'Control fragile surfaces, openings and material handling.',
        ],
        hazards: [
          'Falls from edges.',
          'Falls through openings.',
          'Falling tools and materials.',
          'Unsafe access.',
          'Improvised platforms.',
        ],
        controls: [
          'Protected platforms.',
          'Edge protection.',
          'Safe access.',
          'Dropped-object prevention.',
          'Inspection.',
          'Competence and supervision.',
        ],
        field: [
          'Inspect platform and access.',
          'Check edges and openings.',
          'Verify fall-protection equipment where applicable.',
          'Check exclusion below overhead work.',
        ],
        inspection: [
          'Pre-use inspection.',
          'Routine checks.',
          'Post-change / post-event checks.',
          'Immediate correction of critical defects.',
        ],
        stopWork: [
          'Missing or defective edge protection.',
          'Unsafe access.',
          'Incomplete platform.',
          'Uncontrolled falling-object exposure.',
          'No viable rescue arrangement for the selected fall-protection system.',
        ],
        example: [
          'A worker is asked to install services beside an open edge with inadequate protection. The task is stopped, a suitable protected work position is established and controls are verified before work resumes.',
        ],
        formula: [
          'AVOID HEIGHT → PREVENT FALL → PROTECT PEOPLE BELOW → RESCUE IF REQUIRED → VERIFY.',
        ],
        deeper: [
          'Good height safety is often achieved during planning and temporary-works design, reducing the need for workers to depend on personal fall arrest.',
        ],
      );
    }

    if (k.contains('lifting')) {
      return const _FrameworkData(
        introduction: [
          'Lifting operations involve planned movement of loads using lifting equipment and accessories. Safe lifting depends on engineering, competent personnel, equipment condition and controlled load movement.',
        ],
        types: [
          'Mobile crane operations.',
          'Tower crane operations.',
          'Crawler crane operations.',
          'Hoists and material lifting.',
          'Personnel lifting where specifically designed and controlled.',
          'Critical or complex lifting operations.',
        ],
        components: [
          'Lifting equipment.',
          'Hook and safety latch.',
          'Wire rope, chain or web sling.',
          'Shackles and connectors.',
          'Spreader / lifting beam where required.',
          'Tag line where appropriate.',
          'Load indicator / monitoring systems as applicable.',
          'Exclusion zone and communication system.',
        ],
        technical: [
          'Confirm load characteristics and lifting points.',
          'Select suitable equipment and accessories.',
          'Verify setup area and ground conditions.',
          'Establish load path and exclusion zone.',
          'Define communication and responsibilities.',
          'Control weather and environmental limitations.',
        ],
        hazards: [
          'Dropped load.',
          'Uncontrolled swing.',
          'Equipment instability.',
          'Rigging failure.',
          'People entering the load path.',
          'Interface with excavation, scaffolding, temporary works or traffic.',
        ],
        controls: [
          'Task-specific lifting plan where required.',
          'Competent lifting team.',
          'Suitable and inspected equipment.',
          'Correct rigging.',
          'Controlled load path.',
          'Exclusion zone.',
          'Clear communication.',
        ],
        field: [
          'Check equipment and accessory identification / inspection status.',
          'Verify setup and ground condition.',
          'Check rigging and lifting points.',
          'Confirm exclusion zone.',
          'Confirm team communication.',
        ],
        inspection: [
          'Pre-lift inspection.',
          'Accessory checks.',
          'Setup verification.',
          'Continuous observation of changing conditions.',
        ],
        stopWork: [
          'Load, equipment or lifting points cannot be confirmed.',
          'Setup becomes unsafe.',
          'Exclusion zone is breached.',
          'Communication is lost.',
          'Environmental conditions become unsuitable.',
        ],
        example: [
          'A heavy HVAC unit is prepared for lifting, but its planned load path crosses an active access route. The lift is paused, the route is isolated, the exclusion zone is established and the lifting team verifies the plan before proceeding.',
        ],
        formula: [
          'PLAN → EQUIPMENT → RIGGING → SETUP → EXCLUSION → COMMUNICATE → LIFT → CONTROL → LAND.',
        ],
        deeper: [
          'A crane is only one part of a lifting system. Ground condition, rigging, load path, communication, exclusion and interfaces collectively determine lifting risk.',
        ],
      );
    }

    if (k.contains('excavation')) {
      return const _FrameworkData(
        introduction: [
          'Excavation safety controls collapse, falls, falling materials, underground-service strikes, plant interaction, water ingress and other hazards created by ground disturbance.',
        ],
        types: [
          'Open excavation.',
          'Trench excavation.',
          'Foundation excavation.',
          'Deep excavation.',
          'Utility excavation.',
          'Manhole / chamber excavation.',
        ],
        components: [
          'Shoring or other suitable protection.',
          'Trench box / shielding where applicable.',
          'Benching or sloping where appropriate.',
          'Edge protection and barricading.',
          'Safe ladder / stair access.',
          'Controlled spoil placement.',
          'Dewatering arrangements.',
          'Underground-service controls.',
        ],
        technical: [
          'Assess soil and ground conditions.',
          'Consider excavation geometry and adjacent structures.',
          'Select a suitable protective system.',
          'Control edge loads, plant and spoil.',
          'Provide safe access and egress.',
          'Inspect and reassess after relevant changes or events.',
        ],
        hazards: [
          'Collapse / engulfment.',
          'Falls into excavation.',
          'Falling materials.',
          'Underground service strike.',
          'Flooding.',
          'Plant interaction.',
        ],
        controls: [
          'Suitable protective system.',
          'Competent oversight.',
          'Safe access.',
          'Edge protection.',
          'Service identification.',
          'Water control.',
          'Plant segregation.',
        ],
        field: [
          'Check ground condition and protective system.',
          'Look for cracks, movement or water ingress.',
          'Verify access and egress.',
          'Check spoil and plant control.',
          'Verify service controls.',
        ],
        inspection: [
          'Inspect before entry.',
          'Reinspect after relevant changes, weather or events.',
          'Record defects and restrict entry when necessary.',
          'Verify corrective action before re-entry.',
        ],
        stopWork: [
          'Ground instability or unexpected movement.',
          'Protection system is damaged or unsuitable.',
          'Unknown underground service is encountered.',
          'Water ingress compromises stability.',
          'Safe access is unavailable.',
        ],
        example: [
          'Unexpected water and ground movement appear in an excavation. Entry is stopped, the area is isolated, conditions are reassessed and the protection/dewatering arrangements are corrected before re-entry.',
        ],
        formula: [
          'IDENTIFY SERVICES → ASSESS GROUND → PROTECT → ACCESS → CONTROL EDGES/LOADS → INSPECT → ENTER.',
        ],
        deeper: [
          'Excavation risk changes with soil, water, geometry, adjacent loads and construction activity. Any meaningful change can alter the stability assessment.',
        ],
      );
    }

    if (k.contains('traffic') || k.contains('public')) {
      return const _FrameworkData(
        introduction: [
          'Construction traffic management controls interaction between vehicles, mobile plant, workers, visitors and the public.',
        ],
        types: [
          'Site vehicle routes.',
          'Pedestrian routes.',
          'Delivery and unloading zones.',
          'Reversing arrangements.',
          'Public-interface protection.',
          'Temporary route changes.',
        ],
        components: [
          'Physical segregation.',
          'Controlled gates and access points.',
          'Traffic routes.',
          'Pedestrian walkways.',
          'Signs and barriers.',
          'Lighting and visibility.',
          'Reversing controls.',
        ],
        technical: [
          'Plan routes before work starts.',
          'Separate people and vehicles where reasonably practicable.',
          'Control deliveries and reversing.',
          'Maintain emergency access.',
          'Review traffic arrangements when site layout changes.',
        ],
        hazards: [
          'Vehicle-pedestrian collision.',
          'Reversing incidents.',
          'Blind spots.',
          'Public intrusion.',
          'Blocked emergency routes.',
        ],
        controls: [
          'Physical segregation.',
          'Controlled access.',
          'Competent traffic control.',
          'Clear signs and barriers.',
          'Good visibility.',
        ],
        field: [
          'Walk the actual route.',
          'Check conflict points and blind spots.',
          'Observe deliveries and reversing.',
          'Check pedestrian protection and emergency access.',
        ],
        inspection: [
          'Daily/periodic route checks as established by the project.',
          'Inspect barriers, signs and route condition.',
          'Review after layout or traffic-flow changes.',
        ],
        stopWork: [
          'People are exposed to uncontrolled vehicle movement.',
          'Segregation is ineffective.',
          'Emergency access is blocked.',
          'Public protection is compromised.',
        ],
        example: [
          'A delivery vehicle blocks the designated pedestrian route. Delivery is paused, the vehicle is moved to the approved area and the safe pedestrian route is restored.',
        ],
        formula: [
          'PLAN ROUTES → SEPARATE → CONTROL ACCESS → MANAGE REVERSING → PROTECT PUBLIC → VERIFY.',
        ],
        deeper: [
          'Traffic management is an interface system. It must coordinate lifting, excavation, deliveries, emergency response and public protection rather than operate as an isolated traffic plan.',
        ],
      );
    }

    if (k.contains('emergency')) {
      return const _FrameworkData(
        introduction: [
          'Emergency preparedness provides an organised response to foreseeable events such as fire, collapse, serious injury, hazardous release and task-specific rescue situations.',
        ],
        types: [
          'Fire and evacuation.',
          'Medical emergency.',
          'Structural / temporary-works failure.',
          'Confined-space rescue.',
          'Work-at-height rescue.',
          'Hazardous release.',
          'Major environmental event.',
        ],
        components: [
          'Alarm and communication.',
          'Evacuation routes.',
          'Assembly and accountability.',
          'Emergency access.',
          'First-aid and medical response.',
          'Task-specific rescue equipment.',
          'Trained responders.',
        ],
        technical: [
          'Base scenarios on the project risk profile.',
          'Define responsibilities and communication.',
          'Provide suitable rescue arrangements for high-risk tasks.',
          'Coordinate contractor and visitor arrangements.',
          'Test the arrangements and learn from exercises.',
        ],
        hazards: [
          'Delayed response.',
          'Blocked routes.',
          'Poor communication.',
          'Inadequate rescue capability.',
          'Incomplete accountability.',
        ],
        controls: [
          'Scenario-based planning.',
          'Reliable communication.',
          'Clear evacuation.',
          'Task-specific rescue.',
          'Regular testing and review.',
        ],
        field: [
          'Check routes and access.',
          'Verify communication systems.',
          'Check assembly arrangements.',
          'Verify rescue capability for current high-risk work.',
        ],
        inspection: [
          'Routine emergency-equipment checks.',
          'Review after drills and incidents.',
          'Verify corrective actions from exercises.',
        ],
        stopWork: [
          'Emergency access is blocked.',
          'Required rescue capability is unavailable.',
          'Alarm/communication cannot reliably function.',
        ],
        example: [
          'A high-level work activity is planned but the agreed rescue equipment is unavailable. The work does not start until an appropriate rescue arrangement and competent response capability are established.',
        ],
        formula: [
          'WHAT CAN HAPPEN? → HOW DO WE ALERT? → HOW DO WE EVACUATE/RESCUE? → WHO RESPONDS? → HOW DO WE VERIFY?',
        ],
        deeper: [
          'Emergency planning should be task-specific. A generic site emergency plan may not provide the equipment, access or trained response needed for a specialist rescue.',
        ],
      );
    }

    if (k.contains('incident') || k.contains('near-miss')) {
      return const _FrameworkData(
        introduction: [
          'Incident and near-miss management is a learning process used to understand what happened, why controls failed and how recurrence will be prevented.',
        ],
        types: [
          'Injury incident.',
          'Property / equipment damage.',
          'Environmental event.',
          'Near miss.',
          'Unsafe-condition report.',
          'High-potential event.',
        ],
        components: [
          'Immediate scene control.',
          'Notification and escalation.',
          'Evidence preservation.',
          'Interviews and information gathering.',
          'Cause analysis.',
          'Corrective and preventive actions.',
          'Verification and learning.',
        ],
        technical: [
          'Protect people first.',
          'Preserve relevant evidence.',
          'Build the event sequence from multiple sources.',
          'Look beyond the immediate unsafe act.',
          'Verify actions at the workface.',
        ],
        hazards: [
          'Repeated events because only worker behaviour is addressed.',
          'Corrective actions that do not address failed controls.',
          'Closing actions without checking effectiveness.',
        ],
        controls: [
          'Immediate risk control.',
          'Evidence-based investigation.',
          'Cause-focused analysis.',
          'Effective corrective action.',
          'Lessons learned.',
        ],
        field: [
          'Check immediate hazards are controlled.',
          'Inspect the affected work area.',
          'Look for similar exposures elsewhere.',
          'Verify corrective actions physically.',
        ],
        inspection: [
          'Review action closure.',
          'Trend incidents and near misses.',
          'Identify recurring control failures.',
        ],
        stopWork: [
          'A serious uncontrolled exposure remains.',
          'A critical control has repeatedly failed.',
          'Corrective action is not implemented and people remain exposed.',
        ],
        example: [
          'A worker nearly falls after temporary edge protection is removed during material movement. Investigation identifies both the removal and weak change control. The control process is redesigned before similar work resumes.',
        ],
        formula: [
          'MAKE SAFE → REPORT → PRESERVE → INVESTIGATE → CORRECT → VERIFY → LEARN.',
        ],
        deeper: [
          'Near misses are early-warning signals. A strong system uses them to identify control weaknesses before an injury or major event occurs.',
        ],
      );
    }

    if (k.contains('contractor') || k.contains('subcontractor')) {
      return const _FrameworkData(
        introduction: [
          'Contractor and subcontractor HSE management ensures every organisation working on the project understands and implements the project safety requirements.',
        ],
        types: [
          'Prequalification.',
          'Mobilisation.',
          'RAMS and competence review.',
          'Interface management.',
          'Performance monitoring.',
          'Corrective-action management.',
        ],
        components: [
          'HSE requirements.',
          'Competence verification.',
          'Scope and responsibility.',
          'Communication and induction.',
          'Inspection and audit.',
          'Action management.',
        ],
        technical: [
          'Define HSE expectations before mobilisation.',
          'Review the actual scope and hazards.',
          'Control changes in subcontractor methods and workforce.',
          'Monitor performance and recurring findings.',
        ],
        hazards: [
          'Conflicting methods.',
          'Unclear responsibility.',
          'Weak subcontractor supervision.',
          'Uncontrolled scope changes.',
        ],
        controls: [
          'Prequalification.',
          'Competence verification.',
          'Consistent site rules.',
          'Interface control.',
          'Performance monitoring.',
        ],
        field: [
          'Interview subcontractor workers.',
          'Verify competence and current RAMS.',
          'Compare actual work with approved methods.',
          'Check action performance.',
        ],
        inspection: [
          'Routine field inspections.',
          'Targeted audits.',
          'Performance trend review.',
          'Escalation of repeat failures.',
        ],
        stopWork: [
          'Work starts outside approved scope/method.',
          'Required competence or supervision is absent.',
          'Critical project controls are ignored.',
        ],
        example: [
          'A subcontractor introduces new plant and a different sequence without review. Work is paused until the change is assessed and affected interfaces are controlled.',
        ],
        formula: [
          'SELECT → INDUCT → VERIFY → SUPERVISE → MONITOR → CORRECT → IMPROVE.',
        ],
        deeper: [
          'Safety responsibility remains with the project management system even when work is subcontracted. Contractor control is therefore an interface-management function, not only a procurement activity.',
        ],
      );
    }

    if (k.contains('inspection') || k.contains('audit') || k.contains('monitoring')) {
      return const _FrameworkData(
        introduction: [
          'Inspection, audit and performance monitoring provide assurance that HSE controls are implemented and that the management system is working effectively.',
        ],
        types: [
          'Workface inspection.',
          'Focused critical-control verification.',
          'Formal HSE audit.',
          'Thematic inspection.',
          'Performance trend monitoring.',
        ],
        components: [
          'Inspection criteria.',
          'Competent inspector/auditor.',
          'Finding classification.',
          'Action ownership.',
          'Target date.',
          'Verification of closure.',
          'Trend analysis.',
        ],
        technical: [
          'Use a risk-based inspection programme.',
          'Focus on critical controls rather than only housekeeping.',
          'Escalate serious findings promptly.',
          'Verify corrective actions physically.',
          'Use trends to identify systemic problems.',
        ],
        hazards: [
          'Checklist-only inspections can miss changing conditions.',
          'Paper closure can leave the actual hazard uncontrolled.',
          'Repeated findings may indicate a management-system weakness.',
        ],
        controls: [
          'Risk-based inspections.',
          'Competent auditors.',
          'Clear findings.',
          'Accountability.',
          'Verified close-out.',
          'Trend-based improvement.',
        ],
        field: [
          'Inspect active high-risk work.',
          'Check previous findings.',
          'Speak with workers and supervisors.',
          'Verify critical controls physically.',
        ],
        inspection: [
          'Observe the work.',
          'Record clear findings.',
          'Assign actions.',
          'Verify closure.',
          'Escalate repeated or critical failures.',
        ],
        stopWork: [
          'Critical control is absent or failed.',
          'Serious finding is ignored.',
          'Unsafe work continues after escalation.',
        ],
        example: [
          'Repeated housekeeping findings occur in the same zone. The HSE team moves beyond repeated observations and investigates material flow, waste collection, supervision and contractor responsibility.',
        ],
        formula: [
          'OBSERVE → VERIFY → RECORD → ASSIGN → CORRECT → VERIFY CLOSURE → TREND.',
        ],
        deeper: [
          'Good HSE performance is not simply a low number of findings. It is consistent control of significant risks and evidence that the organisation learns from repeated weaknesses.',
        ],
      );
    }

    if (k.contains('stop-work')) {
      return const _FrameworkData(
        introduction: [
          'Stop-work authority is a preventive control that allows an activity to be paused when critical safety conditions are not satisfied.',
        ],
        types: [
          'Immediate danger.',
          'Critical-control failure.',
          'Unexpected site condition.',
          'Unsafe deviation from RAMS.',
          'Loss of competence or supervision.',
          'Loss of emergency capability.',
        ],
        components: [
          'Clear trigger.',
          'Immediate intervention.',
          'Area made safe.',
          'Cause identified.',
          'Corrective action.',
          'Verification.',
          'Controlled restart.',
        ],
        technical: [
          'Define stop-work triggers before work begins.',
          'Make authority clear to workers and supervisors.',
          'Never restart only because production pressure exists.',
          'Reassess and re-brief when the safe method changes.',
        ],
        hazards: [
          'Production pressure.',
          'Delayed escalation.',
          'Unclear authority.',
          'Normalisation of unsafe conditions.',
        ],
        controls: [
          'Visible management support.',
          'Worker stop-work authority.',
          'Immediate hazard isolation.',
          'Competent reassessment.',
          'Verified restart.',
        ],
        field: [
          'Ask workers who can stop the job.',
          'Check whether stop-work events are investigated.',
          'Verify restart controls.',
        ],
        inspection: [
          'Review previous stop-work events.',
          'Check recurring triggers.',
          'Use lessons learned to strengthen planning.',
        ],
        stopWork: [
          'Any immediate uncontrolled danger.',
          'Critical control failure.',
          'Unexpected condition that invalidates the safe method.',
          'Required competence, supervision, communication or emergency capability unavailable.',
        ],
        example: [
          'During a lift, the exclusion zone is breached. The lifting team stops the operation, establishes a safe condition, restores the exclusion zone and verifies the control before continuing.',
        ],
        formula: [
          'STOP → MAKE SAFE → ASSESS → CORRECT → VERIFY → RE-BRIEF → RESTART.',
        ],
        deeper: [
          'A strong stop-work culture is an early-warning system. It prevents control failures from becoming incidents and demonstrates that safety-critical decisions are stronger than production pressure.',
        ],
      );
    }

    if (k.contains('high-risk')) {
      return const _FrameworkData(
        introduction: [
          'High-risk construction activities require enhanced planning, competent personnel, supervision and verification because failure of a critical control can lead rapidly to serious harm.',
        ],
        types: [
          'Lifting operations.',
          'Excavation and ground works.',
          'Work at height.',
          'Confined-space work.',
          'Temporary works.',
          'High-energy / electrical work.',
          'Demolition and other project-specific high-risk activities.',
        ],
        components: [
          'Task-specific risk assessment.',
          'RAMS.',
          'Permit systems where required.',
          'Competent persons.',
          'Critical controls.',
          'Exclusion and emergency arrangements.',
        ],
        technical: [
          'Identify high-risk activities during planning.',
          'Define the controls that must not fail.',
          'Verify controls before exposure.',
          'Coordinate simultaneous operations.',
          'Establish stop-work criteria.',
        ],
        hazards: [
          'Major injury or fatality.',
          'Collapse.',
          'Dropped loads.',
          'Electrical energy.',
          'Engulfment.',
          'Fire or uncontrolled release.',
        ],
        controls: [
          'Elimination where practicable.',
          'Engineering controls.',
          'Competent supervision.',
          'Permit and interface control where required.',
          'Critical-control verification.',
        ],
        field: [
          'Identify current high-risk activities.',
          'Check critical controls at the workface.',
          'Verify competence and supervision.',
          'Check interfaces with other activities.',
        ],
        inspection: [
          'Target high-risk work during active operations.',
          'Review critical-control status.',
          'Escalate failures immediately.',
        ],
        stopWork: [
          'Critical control absent or ineffective.',
          'Work changes without reassessment.',
          'Required permit, competence or exclusion control absent.',
        ],
        example: [
          'Lifting and façade works are planned in overlapping areas. The combined exposure is reviewed, activities are sequenced or separated and the controls are verified before simultaneous work is allowed.',
        ],
        formula: [
          'IDENTIFY HIGH RISK → DEFINE CRITICAL CONTROLS → VERIFY → SUPERVISE → STOP IF CONTROL FAILS.',
        ],
        deeper: [
          'High-risk work is best controlled by identifying the few critical controls that must never fail and deliberately verifying them during execution.',
        ],
      );
    }

    // Strong default: still structured and useful for every other framework item.
    return const _FrameworkData(
      introduction: [
        'This topic forms part of the SafeNexus HSE Dubai Construction Safety Framework and should be managed as an operational safety control, not only as documentation.',
        'The objective is to prevent harm by identifying the work, understanding the hazards, applying suitable controls and verifying those controls in the field.',
      ],
      types: [
        'Planning and management controls.',
        'Engineering / physical controls.',
        'Administrative and procedural controls.',
        'Competence and supervision controls.',
        'Inspection, monitoring and improvement controls.',
      ],
      components: [
        'Defined scope and responsibilities.',
        'Hazard identification and risk assessment.',
        'Safe system of work / RAMS where applicable.',
        'Competent personnel and suitable equipment.',
        'Inspection and verification.',
        'Emergency arrangements.',
      ],
      technical: [
        'Make controls specific to the actual activity and location.',
        'Use the hierarchy of controls.',
        'Define critical controls and how they will be verified.',
        'Review the system whenever conditions or scope change.',
        'Maintain effective communication with the workforce and interfacing contractors.',
      ],
      hazards: [
        'Generic controls may not address actual site conditions.',
        'Uncontrolled changes can introduce new hazards.',
        'Weak supervision can allow deviations to become normal practice.',
        'Poor interfaces can create hazards not owned by a single work team.',
      ],
      controls: [
        'Plan before exposure.',
        'Use suitable engineering and physical controls.',
        'Assign competent people.',
        'Brief and supervise the workforce.',
        'Inspect and verify.',
        'Stop and reassess when conditions change.',
      ],
      field: [
        'Check the actual workface against the approved safe system.',
        'Ask workers to explain the main hazards and controls.',
        'Verify critical controls physically.',
        'Check interfaces with neighbouring activities.',
        'Confirm corrective actions are genuinely closed.',
      ],
      inspection: [
        'Observe active work.',
        'Record clear findings.',
        'Assign ownership and target dates.',
        'Verify closure.',
        'Use recurring findings to improve the system.',
      ],
      stopWork: [
        'Immediate uncontrolled danger.',
        'Critical control failure.',
        'Actual work differs materially from the safe method.',
        'Required competence, supervision or emergency capability is unavailable.',
        'Unexpected conditions create significant unassessed risk.',
      ],
      example: [
        'A planned activity encounters a site condition that was not present during planning. The supervisor pauses the work, reassesses the risk, establishes suitable controls, briefs the affected workforce and verifies the workface before restart.',
      ],
      formula: [
        'PLAN → ASSESS → CONTROL → BRIEF → EXECUTE → VERIFY → IMPROVE.',
      ],
      deeper: [
        'Professional HSE practice is continuous verification. A control is valuable only when it is suitable, implemented, understood and effective at the point of exposure.',
      ],
    );
  }
}

class _FrameworkData {
  final List<String> introduction;
  final List<String> types;
  final List<String> components;
  final List<String> technical;
  final List<String> hazards;
  final List<String> controls;
  final List<String> field;
  final List<String> inspection;
  final List<String> stopWork;
  final List<String> example;
  final List<String> formula;
  final List<String> deeper;

  const _FrameworkData({
    required this.introduction,
    required this.types,
    required this.components,
    required this.technical,
    required this.hazards,
    required this.controls,
    required this.field,
    required this.inspection,
    required this.stopWork,
    required this.example,
    required this.formula,
    required this.deeper,
  });
}
