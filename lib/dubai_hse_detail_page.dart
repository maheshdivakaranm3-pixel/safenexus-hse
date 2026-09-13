import 'package:flutter/material.dart';

import 'models/reference_topic.dart';

/// SafeNexus HSE - Dubai HSE detailed field reference.
///
/// The page is deliberately data-driven from ReferenceTopic while adding
/// topic-specific explanations for each list item. SafeNexus DCP-01..DCP-37
/// numbers are internal library identifiers, not official Dubai Municipality
/// clause numbers.
class DubaiHseDetailPage extends StatelessWidget {
  final ReferenceTopic topic;

  const DubaiHseDetailPage({
    super.key,
    required this.topic,
  });

  static const Color darkGreen = Color(0xFF0B5D3B);
  static const Color primaryGreen = Color(0xFF159447);
  static const Color pageBackground = Color(0xFFF5F7FA);
  static const Color textSecondary = Color(0xFF374151);

  static const Map<String, String> _dcp = {
    'dubai_construction_safety': 'DCP-01',
    'dubai_hse_management': 'DCP-02',
    'dubai_risk_assessment': 'DCP-03',
    'dubai_hse_plan': 'DCP-04',
    'dubai_work_at_height': 'DCP-05',
    'dubai_scaffolding': 'DCP-06',
    'dubai_lifting': 'DCP-07',
    'dubai_excavation': 'DCP-08',
    'dubai_confined_space': 'DCP-09',
    'dubai_electrical': 'DCP-10',
    'dubai_hot_work': 'DCP-11',
    'dubai_traffic': 'DCP-12',
    'dubai_demolition': 'DCP-13',
    'dubai_temporary_works': 'DCP-14',
    'dubai_heat_stress': 'DCP-15',
    'dubai_occupational_health': 'DCP-16',
    'dubai_ppe': 'DCP-17',
    'dubai_emergency': 'DCP-18',
    'dubai_incident': 'DCP-19',
    'dubai_contractor': 'DCP-20',
    'dubai_environment': 'DCP-21',
    'dubai_inspection': 'DCP-22',
    'dubai_performance': 'DCP-23',
    'dubai_building_code': 'DCP-24',
    'dubai_permit_to_work': 'DCP-25',
    'dubai_cop_site_establishment': 'DCP-26',
    'dubai_cop_public_protection': 'DCP-27',
    'dubai_cop_access_housekeeping': 'DCP-28',
    'dubai_cop_welfare_facilities': 'DCP-29',
    'dubai_cop_material_storage': 'DCP-30',
    'dubai_cop_formwork_falsework': 'DCP-31',
    'dubai_cop_rebar_concrete': 'DCP-32',
    'dubai_cop_machinery_guarding': 'DCP-33',
    'dubai_cop_ladders_mobile_towers': 'DCP-34',
    'dubai_cop_fire_emergency': 'DCP-35',
    'dubai_cop_signs_barricading': 'DCP-36',
    'dubai_cop_lighting_weather': 'DCP-37',
  };

  static const Map<String, String> _focus = {
    'dubai_construction_safety': 'construction-site governance, legal compliance and protection of workers, the public and property',
    'dubai_hse_management': 'leadership, accountability, planning, competence, monitoring and continual improvement of the HSE system',
    'dubai_risk_assessment': 'systematic hazard identification, risk evaluation, hierarchy of controls and review when conditions change',
    'dubai_hse_plan': 'project-specific HSE arrangements that translate risk assessments and legal duties into work-front controls',
    'dubai_work_at_height': 'preventing falls of people and materials through engineered protection, safe access, fall protection and rescue planning',
    'dubai_scaffolding': 'scaffold stability, safe access, competent erection, inspection, loading and controlled alteration',
    'dubai_lifting': 'planned lifting operations, equipment suitability, certified accessories, competent people, ground conditions and exclusion zones',
    'dubai_excavation': 'preventing collapse, service strikes, falls, plant interaction and water ingress during excavation and trenching',
    'dubai_confined_space': 'controlled entry into spaces where atmosphere, engulfment, access or rescue conditions can create serious risk',
    'dubai_electrical': 'preventing electric shock, arc flash, fire and equipment damage through isolation, protection, inspection and competent work',
    'dubai_hot_work': 'controlling ignition sources and combustible materials before, during and after cutting, welding, grinding or similar work',
    'dubai_traffic': 'separating vehicles from pedestrians and controlling reversing, deliveries, routes, speed and visibility',
    'dubai_demolition': 'planned and sequenced demolition with structural assessment, utility isolation, exclusion zones and control of falling materials',
    'dubai_temporary_works': 'ensuring temporary structures and supports are designed, checked, erected, loaded, inspected and removed safely',
    'dubai_heat_stress': 'controlling heat exposure through work-rest planning, hydration, acclimatisation, monitoring and rapid response to symptoms',
    'dubai_occupational_health': 'preventing work-related illness through exposure control, health surveillance, hygiene, welfare and early reporting',
    'dubai_ppe': 'selecting, fitting, inspecting, maintaining and replacing PPE according to the hazard and task',
    'dubai_emergency': 'preparedness, alarm, communication, evacuation, rescue, first aid, drills and coordinated incident response',
    'dubai_incident': 'rapid notification, scene preservation, evidence collection, root-cause analysis and verified corrective action',
    'dubai_contractor': 'assuring contractor competence, induction, RAMS, coordination, supervision, performance and corrective action',
    'dubai_environment': 'preventing pollution and uncontrolled waste through segregation, containment, storage, disposal and housekeeping',
    'dubai_inspection': 'planned inspections, evidence-based findings, corrective actions, ownership, deadlines and verification of closure',
    'dubai_performance': 'using leading and lagging HSE indicators to identify trends, weaknesses and opportunities for improvement',
    'dubai_building_code': 'building-related health, safety, welfare and design requirements that interface with construction and occupancy safety',
    'dubai_permit_to_work': 'formal authorization and control of high-risk work, isolations, interfaces, handover and permit close-out',
    'dubai_cop_site_establishment': 'safe site layout, boundaries, access, temporary utilities, work zones, storage and emergency routes',
    'dubai_cop_public_protection': 'protecting neighbours, visitors and the public from construction access, falling objects, traffic and site hazards',
    'dubai_cop_access_housekeeping': 'maintaining clear, stable and illuminated routes, stairs, walkways, openings and work areas',
    'dubai_cop_welfare_facilities': 'providing suitable drinking water, sanitation, washing, rest, heat protection and first-aid arrangements',
    'dubai_cop_material_storage': 'stable, segregated and accessible storage that prevents collapse, falling materials, incompatible storage and handling injuries',
    'dubai_cop_formwork_falsework': 'safe temporary support systems, design checks, stability, loading, inspection and controlled striking',
    'dubai_cop_rebar_concrete': 'safe reinforcement, concrete placement, pumping, access and control of impalement, struck-by and chemical hazards',
    'dubai_cop_machinery_guarding': 'preventing contact with dangerous moving parts through guarding, isolation, inspection and competent operation',
    'dubai_cop_ladders_mobile_towers': 'safe selection, inspection, setup, securing, access and stability of ladders and mobile access towers',
    'dubai_cop_fire_emergency': 'fire prevention, ignition control, extinguishing arrangements, escape routes, alarm and emergency access',
    'dubai_cop_signs_barricading': 'clear hazard communication, physical segregation, exclusion zones, visibility and maintained barriers',
    'dubai_cop_lighting_weather': 'maintaining adequate visibility and adjusting work controls for darkness, wind, rain, heat and other weather conditions',
  };

  static const Map<String, String> _emergency = {
    'dubai_construction_safety': 'Stop unsafe work, protect people from immediate hazards, establish the emergency chain of command and notify the responsible project and authority channels as required.',
    'dubai_hse_management': 'Escalate significant uncontrolled risks through the HSE management chain and activate the project emergency arrangements where people may be harmed.',
    'dubai_risk_assessment': 'Stop the activity when controls are ineffective or conditions differ materially from the assessment; reassess before restarting.',
    'dubai_hse_plan': 'Use the project emergency plan, muster arrangements, emergency contacts and rescue resources identified in the approved HSE plan.',
    'dubai_work_at_height': 'Stop exposure to the fall hazard, prevent further access, raise the alarm and use the planned rescue method. Do not create a second casualty by improvising a rescue.',
    'dubai_scaffolding': 'Stop access to an unstable or damaged scaffold, isolate the area, prevent use and arrange competent inspection before release.',
    'dubai_lifting': 'Stop the lift for loss of control, unsafe ground, equipment failure, communication failure or changing weather; secure the load and establish an exclusion zone.',
    'dubai_excavation': 'Stop entry after collapse, movement, service strike, flooding or atmospheric concern; withdraw to a safe area and activate the excavation emergency plan.',
    'dubai_confined_space': 'Do not enter for an unplanned rescue. Raise the alarm and use the trained rescue team and equipment specified by the entry/rescue plan.',
    'dubai_electrical': 'Isolate the supply if safe to do so, keep people away, raise the alarm and obtain competent electrical assistance. Do not touch a potentially energized casualty until the supply is controlled.',
    'dubai_hot_work': 'Stop work, isolate the ignition source where safe, raise the alarm and use the designated firefighting equipment. Evacuate if the fire cannot be immediately controlled.',
    'dubai_traffic': 'Stop vehicle movements in the affected area, protect pedestrians, isolate the route and manage the incident through the site traffic/emergency plan.',
    'dubai_demolition': 'Stop demolition, establish an exclusion zone and withdraw from unstable areas after unexpected movement, collapse, service strike or structural distress.',
    'dubai_temporary_works': 'Stop loading or use of distressed temporary works, evacuate the affected zone and obtain competent engineering assessment before re-entry.',
    'dubai_heat_stress': 'Move the affected worker to a cool safe area, begin appropriate first response, summon medical assistance and do not return the worker to heat exposure until medically cleared as required.',
    'dubai_occupational_health': 'Remove or reduce exposure, obtain medical support for acute symptoms and report occupational health concerns through the established process.',
    'dubai_ppe': 'Stop the task when required protection is unavailable, damaged or incompatible with the hazard. Replace or correct PPE before restarting.',
    'dubai_emergency': 'Follow the site emergency plan, raise the alarm, communicate the incident, evacuate or shelter as directed and account for personnel at the assembly point.',
    'dubai_incident': 'Make the area safe, provide first aid, preserve the scene where practicable and initiate the required notification and investigation process.',
    'dubai_contractor': 'Suspend contractor activity where serious non-compliance creates immediate danger and escalate through the agreed contractor management process.',
    'dubai_environment': 'Stop the source of a spill or release where safe, contain it, protect drains and watercourses, notify the responsible environmental team and dispose of contaminated material correctly.',
    'dubai_inspection': 'Escalate critical findings immediately and stop affected work until an effective control is verified.',
    'dubai_performance': 'Treat adverse trends as an early warning: escalate significant deterioration, identify the cause and implement corrective measures before serious harm occurs.',
    'dubai_building_code': 'For an immediate building-life-safety concern, restrict the affected area and involve the competent design, building-control and emergency authorities as applicable.',
    'dubai_permit_to_work': 'Suspend or cancel the permit when conditions change, controls fail or unauthorized work is found. Revalidate before restarting.',
    'dubai_cop_site_establishment': 'Restrict access to unsafe zones, secure temporary services and maintain emergency access while the site arrangement is corrected.',
    'dubai_cop_public_protection': 'Stop the public interface activity, secure the perimeter and remove the source of danger before allowing normal access to resume.',
    'dubai_cop_access_housekeeping': 'Restrict unsafe routes, provide an alternative safe route and remove the obstruction or hazard before reopening the area.',
    'dubai_cop_welfare_facilities': 'Provide immediate access to drinking water, sanitation, rest or first aid as required; stop work where welfare failure creates a serious health risk.',
    'dubai_cop_material_storage': 'Isolate unstable stacks or damaged storage systems, keep people outside the fall zone and arrange safe recovery by competent personnel.',
    'dubai_cop_formwork_falsework': 'Evacuate the affected zone after movement, overloading or instability and prevent re-entry until the temporary works are assessed and made safe.',
    'dubai_cop_rebar_concrete': 'Stop the operation after uncontrolled hose movement, formwork movement, serious impalement exposure or equipment failure and secure the area.',
    'dubai_cop_machinery_guarding': 'Stop and isolate machinery when a guard is missing, defeated or damaged, or when an emergency stop or interlock is unreliable.',
    'dubai_cop_ladders_mobile_towers': 'Stop use of an unstable, damaged or incorrectly erected access system and prevent access until it is corrected and inspected.',
    'dubai_cop_fire_emergency': 'Raise the alarm, stop work, evacuate through safe routes and only use firefighting equipment when trained and the situation is suitable for first-aid firefighting.',
    'dubai_cop_signs_barricading': 'Stop or isolate the affected activity when the hazard boundary is unclear or breached; restore the barrier and warning system before work continues.',
    'dubai_cop_lighting_weather': 'Suspend work where visibility or weather makes the task unsafe, secure plant/materials and restart only when adequate controls and conditions are restored.',
  };

  static const Map<String, String> _reference = {
    'dubai_construction_safety': 'Dubai Municipality — Code of Construction Safety Practice; Safety Guide for Construction Works in the Emirate of Dubai; Decree No. 19 of 2025, where applicable.',
    'dubai_hse_management': 'Dubai Municipality — Code of Construction Safety Practice; Safety Guide for Construction Works; applicable occupational safety requirements.',
    'dubai_risk_assessment': 'Dubai Municipality Technical Guidelines No. 137 — Health and Safety Risk Assessment (DM-HSD-GU137-RA2); Code of Construction Safety Practice.',
    'dubai_hse_plan': 'Dubai Municipality — Safety Guide for Construction Works in the Emirate of Dubai; Code of Construction Safety Practice.',
    'dubai_work_at_height': 'Dubai Municipality — Code of Construction Safety Practice; Safety Guide for Construction Works; applicable work-at-height guidance.',
    'dubai_scaffolding': 'Dubai Municipality — Code of Construction Safety Practice; Safety Guide for Construction Works; applicable scaffold requirements.',
    'dubai_lifting': 'Dubai Municipality Technical Guidelines No. 48 — Examination and Certification of Cranes, Hoists, Lifts and other Lifting Appliances; Code of Construction Safety Practice.',
    'dubai_excavation': 'Dubai Municipality — Code of Construction Safety Practice; Safety Guide for Construction Works; applicable utility and excavation requirements.',
    'dubai_confined_space': 'Dubai Municipality Technical Guidelines No. 39 — Confined Spaces Entry; Code of Construction Safety Practice.',
    'dubai_electrical': 'Dubai Municipality — Code of Construction Safety Practice; Safety Guide for Construction Works; applicable electrical safety requirements.',
    'dubai_hot_work': 'Dubai Municipality — Code of Construction Safety Practice; Safety Guide for Construction Works; applicable fire and permit-to-work requirements.',
    'dubai_traffic': 'Dubai Municipality Technical Guidelines No. 93 — Precautionary Measures for Labour Accommodations, Transportations and Working at Construction Sites; Code of Construction Safety Practice.',
    'dubai_demolition': 'Dubai Municipality — Safety Guide for Construction Works; Code of Construction Safety Practice; applicable demolition requirements.',
    'dubai_temporary_works': 'Dubai Municipality — Code of Construction Safety Practice; Safety Guide for Construction Works; applicable temporary-works requirements.',
    'dubai_heat_stress': 'Dubai Municipality Technical Guidelines No. 38 — Management of Heat Stress at Work (DM-HSD-GU38-MHSW2); applicable UAE summer work regulations.',
    'dubai_occupational_health': 'Dubai Municipality — Health & Safety Technical Guidelines; Code of Construction Safety Practice; applicable occupational-health requirements.',
    'dubai_ppe': 'Dubai Municipality Technical Guidelines No. 59, 60, 61, 65, 97 and 98 for relevant PPE categories; Code of Construction Safety Practice.',
    'dubai_emergency': 'Dubai Municipality — Code of Construction Safety Practice; Safety Guide for Construction Works; applicable emergency and fire requirements.',
    'dubai_incident': 'Dubai Municipality — Code of Construction Safety Practice; applicable Dubai occupational safety and incident-reporting requirements.',
    'dubai_contractor': 'Dubai Municipality — Code of Construction Safety Practice; Safety Guide for Construction Works; Decree No. 19 of 2025 where applicable.',
    'dubai_environment': 'Dubai Municipality — applicable environmental and waste requirements; Code of Construction Safety Practice; Local Order No. 61 of 1991 where applicable.',
    'dubai_inspection': 'Dubai Municipality — Code of Construction Safety Practice; Safety Guide for Construction Works; applicable H&S inspection requirements.',
    'dubai_performance': 'Dubai Municipality — Code of Construction Safety Practice; applicable H&S management and monitoring requirements.',
    'dubai_building_code': 'Dubai Municipality — Dubai Building Code; Code of Construction Safety Practice where construction safety interfaces apply.',
    'dubai_permit_to_work': 'Dubai Municipality — Code of Construction Safety Practice; Safety Guide for Construction Works; project-specific permit-to-work requirements.',
    'dubai_cop_site_establishment': 'Dubai Municipality — Code of Construction Safety Practice; Safety Guide for Construction Works in the Emirate of Dubai.',
    'dubai_cop_public_protection': 'Dubai Municipality — Code of Construction Safety Practice; Safety Guide for Construction Works; applicable public-protection requirements.',
    'dubai_cop_access_housekeeping': 'Dubai Municipality — Code of Construction Safety Practice; Safety Guide for Construction Works; applicable access and housekeeping requirements.',
    'dubai_cop_welfare_facilities': 'Dubai Municipality Technical Guidelines No. 93 where applicable; Code of Construction Safety Practice; applicable welfare requirements.',
    'dubai_cop_material_storage': 'Dubai Municipality Technical Guidelines No. 148 — Safe Storage; Code of Construction Safety Practice.',
    'dubai_cop_formwork_falsework': 'Dubai Municipality — Safety Guide for Construction Works; Code of Construction Safety Practice; applicable temporary-works requirements.',
    'dubai_cop_rebar_concrete': 'Dubai Municipality — Safety Guide for Construction Works; Code of Construction Safety Practice; applicable concrete/reinforcement controls.',
    'dubai_cop_machinery_guarding': 'Dubai Municipality Technical Guidelines No. 41 — Guarding of Dangerous Machinery; Code of Construction Safety Practice.',
    'dubai_cop_ladders_mobile_towers': 'Dubai Municipality Technical Guidelines No. 73 — Safe Use of Ladders and No. 74 — Mobile Access Towers; Code of Construction Safety Practice.',
    'dubai_cop_fire_emergency': 'Dubai Municipality — Code of Construction Safety Practice; Safety Guide for Construction Works; applicable fire-safety requirements.',
    'dubai_cop_signs_barricading': 'Dubai Municipality Technical Guidelines No. 99 — Safety Signs at Work; Code of Construction Safety Practice.',
    'dubai_cop_lighting_weather': 'Dubai Municipality — Code of Construction Safety Practice; Safety Guide for Construction Works; applicable lighting and weather controls.',
  };

  String get _dcpNumber => _dcp[topic.id] ?? 'DCP';
  String get _topicFocus => _focus[topic.id] ?? topic.description;
  String get _emergencyText => _emergency[topic.id] ?? 'Stop unsafe work, protect people and follow the approved emergency arrangements.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text('Dubai HSE'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _header(),
              const SizedBox(height: 14),
              _identityCard(),
              const SizedBox(height: 14),
              _overviewCard(),
              const SizedBox(height: 14),
              _sectionList(context, 'Key Requirements', Icons.checklist_outlined, topic.keyRequirements, 'requirements'),
              const SizedBox(height: 14),
              _sectionList(context, 'Safety Controls', Icons.health_and_safety_outlined, topic.safetyControls, 'controls'),
              const SizedBox(height: 14),
              _sectionList(context, 'Responsibilities', Icons.groups_outlined, topic.responsibilities, 'responsibilities'),
              const SizedBox(height: 14),
              _fieldVerification(context),
              const SizedBox(height: 14),
              _emergencyCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [darkGreen, Color(0xFF087F5B)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: .15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text('DUBAI HSE', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
          ),
          const SizedBox(height: 12),
          Text(topic.title, style: const TextStyle(color: Colors.white, fontSize: 22, height: 1.25, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(_topicFocus, style: TextStyle(color: Colors.white.withValues(alpha: .92), height: 1.45)),
        ],
      ),
    );
  }

  Widget _identityCard() {
    return _card(
      child: Row(
        children: [
          Container(
            width: 54,
            height: 54,
            alignment: Alignment.center,
            decoration: BoxDecoration(color: primaryGreen.withValues(alpha: .10), borderRadius: BorderRadius.circular(14)),
            child: const Icon(Icons.verified_outlined, color: primaryGreen, size: 28),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_dcpNumber, style: const TextStyle(fontWeight: FontWeight.bold, color: darkGreen, fontSize: 16)),
                const SizedBox(height: 4),
                const Text('SafeNexus internal topic reference — not an official Dubai Municipality clause number.', style: TextStyle(color: textSecondary, height: 1.35, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _overviewCard() {
    return _section(
      'Overview',
      Icons.info_outline,
      Text(topic.description, style: const TextStyle(fontSize: 15, height: 1.55, color: textSecondary)),
    );
  }

  Widget _sectionList(BuildContext context, String title, IconData icon, List<String> items, String section) {
    return _section(
      title,
      icon,
      Column(
        children: [
          for (int i = 0; i < items.length; i++) ...[
            _tapItem(context, title, items[i], section, i),
            if (i != items.length - 1) const Divider(height: 1),
          ],
        ],
      ),
    );
  }

  Widget _fieldVerification(BuildContext context) {
    final checks = _fieldChecks(topic.id);
    return _section(
      'Field Verification Checklist',
      Icons.fact_check_outlined,
      Column(
        children: [
          for (int i = 0; i < checks.length; i++) ...[
            _tapItem(context, 'Field Verification', checks[i], 'field', i),
            if (i != checks.length - 1) const Divider(height: 1),
          ],
        ],
      ),
    );
  }

  Widget _emergencyCard() {
    return _section(
      'Emergency / Stop-Work Conditions',
      Icons.warning_amber_rounded,
      Text(_emergencyText, style: const TextStyle(fontSize: 15, height: 1.55, color: textSecondary)),
    );
  }

  Widget _tapItem(BuildContext context, String sectionTitle, String item, String section, int index) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => _DubaiHseItemDetailPage(
              topicTitle: topic.title,
              sectionTitle: sectionTitle,
              item: item,
              explanation: _itemExplanation(section, index, item),
              topicFocus: _topicFocus,
              fieldAction: _fieldAction(section),
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 2),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 4),
              child: Icon(Icons.check_circle_outline, size: 20, color: primaryGreen),
            ),
            const SizedBox(width: 11),
            Expanded(
              child: Text(
                item,
                style: const TextStyle(fontSize: 14.5, height: 1.45, color: textSecondary),
              ),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  String _itemExplanation(String section, int index, String item) {
    final base = _topicFocus;
    switch (section) {
      case 'requirements':
        return 'For ${topic.title}, “$item” means the requirement must be translated into a documented and observable control for $base. The responsible supervisor should confirm the requirement before the work starts, communicate it to affected workers and verify it at the work front.';
      case 'controls':
        return 'For ${topic.title}, “$item” is a practical control used to reduce exposure to $base. The control should be suitable for the actual task, checked before use and maintained for the duration of the work. If the control is absent or ineffective, the affected activity should not continue.';
      case 'responsibilities':
        return 'For ${topic.title}, “$item” identifies a responsibility that must be clear at the work front. The responsible person should have the competence and authority to act, and evidence of implementation should be available through the project HSE records or field verification.';
      case 'field':
        return 'For ${topic.title}, this field check confirms whether “$item” is actually in place and effective. Verify the physical condition, compare it with the approved risk assessment or method statement, speak with the relevant worker where useful and record any corrective action.';
      case 'references':
        return 'This reference supports the ${topic.title} topic. Use the official source to confirm the current requirement, scope and revision before treating any guidance as a legal or contractual obligation. SafeNexus DCP numbering is only an internal navigation identifier.';
      default:
        return 'This item is specific to ${topic.title} and should be assessed against the approved work controls and current Dubai requirements.';
    }
  }

  String _fieldAction(String section) {
    switch (section) {
      case 'requirements':
        return 'Confirm the requirement is reflected in the approved RAMS, permit or HSE plan before work starts.';
      case 'controls':
        return 'Inspect the control at the work location and confirm it remains effective while the task is underway.';
      case 'responsibilities':
        return 'Confirm the named role is present, competent and able to stop or correct unsafe work.';
      case 'field':
        return 'Record the observation, assign an owner and close the action before the risk is accepted.';
      case 'references':
        return 'Use the current official Dubai Municipality publication or applicable legislation as the authoritative source.';
      default:
        return 'Apply the approved project controls and escalate uncertainty to the competent HSE/design authority.';
    }
  }

  List<String> _fieldChecks(String id) {
    switch (id) {
      case 'dubai_construction_safety': return ['Current legal and guidance requirements identified', 'Site HSE organisation and competent supervision confirmed', 'Risk controls visible at work fronts', 'Required records and inspections available', 'Unsafe conditions are escalated and corrected'];
      case 'dubai_hse_management': return ['HSE responsibilities are assigned', 'Risk register and objectives are current', 'Training and competency records are available', 'Inspection and corrective-action systems are active', 'Management reviews significant HSE trends'];
      case 'dubai_risk_assessment': return ['Hazards match the actual work', 'People exposed to each hazard are identified', 'Controls follow the hierarchy of controls', 'Residual risk is acceptable and communicated', 'Assessment is reviewed after changes or incidents'];
      case 'dubai_hse_plan': return ['Project HSE plan is approved and available', 'RAMS and emergency arrangements are aligned', 'Interfaces and simultaneous operations are addressed', 'Welfare and traffic arrangements are implemented', 'Inspection and reporting arrangements are active'];
      case 'dubai_work_at_height': return ['Edges and openings are protected', 'Safe access is provided', 'Fall protection is suitable and inspected', 'Dropped-object controls are effective', 'Rescue arrangements are available'];
      case 'dubai_scaffolding': return ['Scaffold is on a stable base', 'Guardrails and platforms are complete', 'Access is safe', 'Inspection status is current', 'Unauthorised alteration is prevented'];
      case 'dubai_lifting': return ['Lift plan matches the actual lift', 'Crane and accessories are suitable and certified', 'Ground conditions are adequate', 'Exclusion zone is established', 'Signaller and communication arrangements are effective'];
      case 'dubai_excavation': return ['Services are identified and controlled', 'Excavation support or safe battering is adequate', 'Access and egress are available', 'Spoil and plant are kept clear of edges', 'Excavation is inspected after relevant changes or events'];
      case 'dubai_confined_space': return ['Space and hazards are identified', 'Isolation is verified', 'Atmosphere is tested and recorded', 'Ventilation and communication are effective', 'Standby and rescue arrangements are ready'];
      case 'dubai_electrical': return ['Temporary electrical system is inspected', 'Isolation and lockout controls are effective', 'Protection devices are functional', 'Cables and connections are protected', 'Only competent persons perform electrical work'];
      case 'dubai_hot_work': return ['Hot-work authorization is valid', 'Combustibles are controlled', 'Gas cylinders are secured', 'Fire watch and extinguishers are available', 'Post-work fire monitoring is completed'];
      case 'dubai_traffic': return ['Pedestrian and vehicle routes are separated', 'Reversing controls are effective', 'Banksman/signaller is available where required', 'Speed and visibility controls are implemented', 'Delivery routes remain clear'];
      case 'dubai_demolition': return ['Pre-demolition survey is available', 'Utilities are isolated', 'Sequence is approved', 'Exclusion zone is maintained', 'Unexpected structural movement is monitored'];
      case 'dubai_temporary_works': return ['Design and approval are complete', 'Temporary works are erected as designed', 'Inspection records are current', 'Loads remain within design limits', 'Alterations are controlled'];
      case 'dubai_heat_stress': return ['Heat exposure is assessed', 'Drinking water is available', 'Rest/shade arrangements are adequate', 'Workers are acclimatised and monitored', 'Heat illness response is understood'];
      case 'dubai_occupational_health': return ['Relevant exposures are identified', 'Health surveillance is provided where required', 'Hygiene and welfare are adequate', 'Occupational symptoms are reported', 'Exposure controls are maintained'];
      case 'dubai_ppe': return ['PPE matches the hazard', 'Fit and compatibility are checked', 'PPE is inspected before use', 'Damaged PPE is removed', 'Workers understand correct use and limitations'];
      case 'dubai_emergency': return ['Emergency plan is current', 'Alarm and communication methods work', 'Escape routes are clear', 'Muster/accountability arrangements are known', 'Drills and response equipment are maintained'];
      case 'dubai_incident': return ['Immediate danger is controlled', 'Required notification is made', 'Scene/evidence is preserved where practicable', 'Root causes are identified', 'Corrective actions are verified closed'];
      case 'dubai_contractor': return ['Contractor competence is verified', 'Induction is completed', 'RAMS are approved and understood', 'Supervision matches the risk', 'Non-compliance is tracked to closure'];
      case 'dubai_environment': return ['Waste streams are segregated', 'Hazardous materials are contained', 'Spill controls are available', 'Disposal routes are approved', 'Pollution incidents are reported'];
      case 'dubai_inspection': return ['Inspection schedule is current', 'Findings are evidence-based', 'Critical findings are escalated', 'Actions have owners and deadlines', 'Closure is physically verified'];
      case 'dubai_performance': return ['Leading indicators are tracked', 'Lagging indicators are reviewed', 'Trends are analysed', 'Actions target root causes', 'Management receives meaningful HSE information'];
      case 'dubai_building_code': return ['Applicable building requirements are identified', 'Life-safety interfaces are addressed', 'Access/egress requirements are maintained', 'Design changes are controlled', 'Competent design/building-control input is obtained'];
      case 'dubai_permit_to_work': return ['Permit scope matches the job', 'Isolations are verified', 'Work area controls are established', 'Permit handover is controlled', 'Permit is closed or suspended correctly'];
      case 'dubai_cop_site_establishment': return ['Site boundaries are secure', 'Access routes are controlled', 'Emergency routes remain available', 'Temporary utilities are protected', 'Work and storage zones are clearly defined'];
      case 'dubai_cop_public_protection': return ['Public boundary is intact', 'Falling-object protection is adequate', 'Construction traffic is controlled', 'Public access is prevented from hazardous areas', 'Warning signs remain visible'];
      case 'dubai_cop_access_housekeeping': return ['Walkways are clear', 'Stairs and access points are safe', 'Openings are protected', 'Waste is removed routinely', 'Lighting is adequate for the route'];
      case 'dubai_cop_welfare_facilities': return ['Drinking water is available', 'Sanitation is clean and usable', 'Rest facilities are suitable', 'Heat protection is available', 'First-aid arrangements are accessible'];
      case 'dubai_cop_material_storage': return ['Stacks are stable', 'Materials are segregated', 'Access aisles are clear', 'Heavy items are stored safely', 'Storage systems are inspected for damage'];
      case 'dubai_cop_formwork_falsework': return ['Temporary works design is approved', 'Props/bracing are correctly installed', 'Loads are controlled', 'Inspection is completed before loading', 'Striking sequence is controlled'];
      case 'dubai_cop_rebar_concrete': return ['Rebar ends are protected', 'Cutting/bending equipment is controlled', 'Concrete pump lines are secured', 'Formwork remains stable', 'Workers have safe access and PPE'];
      case 'dubai_cop_machinery_guarding': return ['Guards are fitted and effective', 'Interlocks/emergency stops work', 'Isolation is applied before maintenance', 'Operators are competent', 'Defects are removed from service promptly'];
      case 'dubai_cop_ladders_mobile_towers': return ['Correct access equipment is selected', 'Ladder condition is checked', 'Ladders are positioned and secured', 'Tower platforms and guardrails are complete', 'Tower brakes and stability are confirmed before use'];
      case 'dubai_cop_fire_emergency': return ['Combustible storage is controlled', 'Extinguishers are accessible and suitable', 'Escape routes are clear', 'Hot-work controls are active', 'Emergency access is maintained'];
      case 'dubai_cop_signs_barricading': return ['Signs match the hazard', 'Barriers define the actual exclusion zone', 'Signs are visible from the approach', 'Night visibility is adequate', 'Damaged signs/barriers are replaced'];
      case 'dubai_cop_lighting_weather': return ['Work areas have adequate illumination', 'Emergency lighting/escape visibility is considered', 'Wind-sensitive work is controlled', 'Rain/water hazards are managed', 'Work stops when visibility or weather exceeds safe limits'];
      default: return ['Requirement is understood', 'Control is physically present', 'Condition is acceptable', 'Responsible person is identified', 'Corrective action is closed'];
    }
  }

  Widget _section(String title, IconData icon, Widget child) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: const [BoxShadow(color: Color(0x0D000000), blurRadius: 10, offset: Offset(0, 3))]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [Icon(icon, color: primaryGreen, size: 22), const SizedBox(width: 9), Expanded(child: Text(title, style: const TextStyle(color: darkGreen, fontWeight: FontWeight.bold, fontSize: 17)))]),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }

  Widget _card({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: const [BoxShadow(color: Color(0x0D000000), blurRadius: 10, offset: Offset(0, 3))]),
      child: child,
    );
  }
}

/// Full-screen detail page opened when a Dubai HSE list item is tapped.
/// This intentionally contains no References section and no generic disclaimer.
class _DubaiHseItemDetailPage extends StatelessWidget {
  final String topicTitle;
  final String sectionTitle;
  final String item;
  final String explanation;
  final String topicFocus;
  final String fieldAction;

  const _DubaiHseItemDetailPage({
    required this.topicTitle,
    required this.sectionTitle,
    required this.item,
    required this.explanation,
    required this.topicFocus,
    required this.fieldAction,
  });

  static const Color darkGreen = Color(0xFF0B5D3B);
  static const Color primaryGreen = Color(0xFF159447);
  static const Color pageBackground = Color(0xFFF5F7FA);
  static const Color textSecondary = Color(0xFF374151);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
        title: const Text('Dubai HSE'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _card(
                context,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      topicTitle,
                      style: const TextStyle(
                        color: darkGreen,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        height: 1.25,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      sectionTitle,
                      style: const TextStyle(
                        color: primaryGreen,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      item,
                      style: const TextStyle(
                        color: textSecondary,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              _infoCard(
                title: 'Explanation',
                icon: Icons.info_outline,
                text: explanation,
              ),
              const SizedBox(height: 14),
              _infoCard(
                title: 'Topic Focus',
                icon: Icons.track_changes_outlined,
                text: topicFocus,
              ),
              const SizedBox(height: 14),
              _infoCard(
                title: 'Field Action',
                icon: Icons.engineering_outlined,
                text: fieldAction,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoCard({
    required String title,
    required IconData icon,
    required String text,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: primaryGreen, size: 22),
              const SizedBox(width: 9),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: darkGreen,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            text,
            style: const TextStyle(
              color: textSecondary,
              fontSize: 15,
              height: 1.55,
            ),
          ),
        ],
      ),
    );
  }

  Widget _card(BuildContext context, {required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: child,
    );
  }
}
