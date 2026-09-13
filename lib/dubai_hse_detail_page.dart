import 'package:flutter/material.dart';

import 'models/reference_topic.dart';

/// SafeNexus HSE - Dubai HSE Detail
///
/// Dubai-only detail experience. This page uses the existing ReferenceTopic
/// data as the source of technical content and presents it in a field-use
/// format. The DCP reference shown here is a SafeNexus internal mapping code;
/// it is NOT an official Dubai Municipality clause/section number.
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

  

  // SafeNexus internal reference numbers for the current Dubai topic library.
  // These numbers must not be presented as official Dubai Municipality clause
  // numbers unless the official source itself confirms the clause number.
  static const Map<String, String> _referenceNumbers = {
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


  String get _referenceNumber =>
      _referenceNumbers[topic.id] ?? 'DCP-${topic.id}';

  String get _title => topic.title;

  String get _basis {
    if (topic.id == 'dubai_building_code') {
      return 'Dubai Building Code and applicable Dubai Municipality building requirements';
    }
    if (topic.id == 'dubai_permit_to_work') {
      return 'Project / employer permit-to-work requirements and applicable Dubai safety requirements';
    }
    if (topic.id.startsWith('dubai_cop_')) {
      return 'Dubai Municipality Code of Construction Safety Practice / Safety Guide for Construction Works';
    }
    return 'Dubai Municipality Code of Construction Safety Practice / Safety Guide for Construction Works and applicable H&S Technical Guidelines';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Dubai HSE',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 36),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _header(),
              const SizedBox(height: 16),
              _referenceIdentityCard(),
              const SizedBox(height: 16),
              _infoCard(),
              const SizedBox(height: 16),
              _section(
                'Overview',
                Icons.info_outline,
                Text(
                  topic.description,
                  style: const TextStyle(
                    fontSize: 15,
                    height: 1.55,
                    color: textSecondary,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _listSection(
                context,
                'Key Requirements',
                Icons.checklist_outlined,
                topic.keyRequirements,
              ),
              const SizedBox(height: 16),
              _listSection(
                context,
                'Safety Controls',
                Icons.health_and_safety_outlined,
                topic.safetyControls,
              ),
              const SizedBox(height: 16),
              _listSection(
                context,
                'Responsibilities',
                Icons.groups_outlined,
                topic.responsibilities,
              ),
              const SizedBox(height: 16),
              _fieldChecklist(context),
              const SizedBox(height: 16),
              _emergencySection(),
              const SizedBox(height: 16),
              _applicabilitySection(),
              const SizedBox(height: 16),
              _referenceSection(context),
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
            padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: .16),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'DUBAI HSE',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            _title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              height: 1.25,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Detailed practical guidance for Dubai HSE field use',
            style: TextStyle(
              color: Colors.white.withValues(alpha: .9),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _referenceIdentityCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: primaryGreen.withValues(alpha: .35)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .04),
            blurRadius: 9,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.verified_outlined, color: primaryGreen),
              const SizedBox(width: 9),
              Expanded(
                child: Text(
                  'Code of Practice Reference',
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: darkGreen,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _referenceLine(
            'SafeNexus Ref.',
            _referenceNumber,
          ),
          const SizedBox(height: 9),
          _referenceLine(
            'Official basis',
            _basis,
          ),
          const SizedBox(height: 11),
          Text(
            'The DCP number is an internal SafeNexus topic mapping. It is not an official Dubai Municipality clause or section number.',
            style: const TextStyle(
              fontSize: 12,
              height: 1.45,
              color: textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _referenceLine(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 105,
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              color: textSecondary,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              color: textSecondary,
              height: 1.4,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _infoCard() {
    return _section(
      'Authority & Jurisdiction',
      Icons.account_balance_outlined,
      Column(
        children: [
          _row('Authority', topic.authority),
          const SizedBox(height: 10),
          _row('Jurisdiction', topic.jurisdiction),
        ],
      ),
    );
  }

  Widget _row(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 105,
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              color: textSecondary,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(color: textSecondary, height: 1.4),
          ),
        ),
      ],
    );
  }

  Widget _section(String title, IconData icon, Widget child) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: primaryGreen),
              const SizedBox(width: 9),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: darkGreen,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 13),
          child,
        ],
      ),
    );
  }

  Widget _listSection(
    BuildContext context,
    String title,
    IconData icon,
    List<String> items,
  ) {
    return _section(
      title,
      icon,
      Column(
        children: List.generate(items.length, (index) {
          final item = items[index];
          return Padding(
            padding: EdgeInsets.only(
              bottom: index == items.length - 1 ? 0 : 10,
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () => _showItemDetails(context, title, item),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 2,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 3),
                        child: Icon(
                          Icons.check_circle,
                          size: 17,
                          color: primaryGreen,
                        ),
                      ),
                      const SizedBox(width: 9),
                      Expanded(
                        child: Text(
                          item,
                          style: const TextStyle(
                            fontSize: 14.5,
                            height: 1.5,
                            color: textSecondary,
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      const Icon(
                        Icons.chevron_right,
                        size: 20,
                        color: primaryGreen,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  void _showItemDetails(
    BuildContext context,
    String section,
    String item,
  ) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => _itemDetailsSheet(
        sheetContext,
        section,
        item,
      ),
    );
  }

  Widget _itemDetailsSheet(
    BuildContext context,
    String section,
    String item,
  ) {
    final detail = _buildItemDetail(section, item);
    return SafeArea(
      child: Container(
        constraints: const BoxConstraints(maxHeight: 620),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 42,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.health_and_safety_outlined,
                    color: primaryGreen,
                    size: 28,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: darkGreen,
                        height: 1.3,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                section,
                style: const TextStyle(
                  color: primaryGreen,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 18),
              _detailBlock('What it means', detail.meaning),
              _detailBlock('Field checks', detail.fieldChecks),
              _detailBlock('Why it matters', detail.whyItMatters),
              _detailBlock('Reference', detail.reference),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.check),
                  label: const Text('Close'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _detailBlock(String title, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: pageBackground,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: darkGreen,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 7),
            Text(
              text,
              style: const TextStyle(
                height: 1.5,
                color: textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _ItemDetail _buildItemDetail(String section, String item) {
    final text = item.toLowerCase();
    String meaning;
    String fieldChecks;
    String whyItMatters;

    if (text.contains('guardrail')) {
      meaning = 'A guardrail is a collective fall-prevention barrier that protects people from an open edge or drop. It should be suitable for the work, securely installed and maintained.';
      fieldChecks = 'Check top and intermediate rails, toe boards where required, secure fixing, continuity, edge protection and openings. Do not remove or bypass protection without an approved control.';
      whyItMatters = 'It prevents people, tools and materials from reaching an unprotected edge and reduces reliance on personal fall protection.';
    } else if (text.contains('scaffold')) {
      meaning = 'Scaffolding provides a temporary working platform and access system. It must be properly designed, erected, inspected and used for its intended loading and configuration.';
      fieldChecks = 'Verify competent erection, stable foundations, access, platforms, guardrails, toe boards, ties/bracing, inspection status and safe loading.';
      whyItMatters = 'Poorly erected or altered scaffolds can cause falls, collapse and falling-object incidents.';
    } else if (text.contains('mobile access tower') || text.contains('access tower')) {
      meaning = 'A mobile access tower is a prefabricated temporary tower used for elevated work. It must be erected and used according to its approved configuration and manufacturer requirements.';
      fieldChecks = 'Check level base, wheels/castors, locking devices, stabilisers, platform, guardrails, access ladder and inspection status. Do not move the tower while people are on it unless the approved system specifically permits it.';
      whyItMatters = 'Incorrect assembly, movement or use can lead to overturning or falls from height.';
    } else if (text.contains('mewp')) {
      meaning = 'A MEWP is mobile elevating work equipment used to position people at height. Operators and equipment must be competent and authorised for the specific machine.';
      fieldChecks = 'Verify pre-use inspection, ground conditions, guarding, emergency lowering, safe operating zone, overhead hazards, load limits and operator competency.';
      whyItMatters = 'MEWP incidents can involve overturning, falls, crushing, entrapment and contact with overhead hazards.';
    } else if (text.contains('fall restraint')) {
      meaning = 'Fall restraint is a system designed to prevent a person from reaching a fall hazard in the first place.';
      fieldChecks = 'Confirm the system limits travel so the worker cannot reach the exposed edge, and verify suitable anchorage, equipment compatibility and correct adjustment.';
      whyItMatters = 'Preventing access to the fall edge is generally preferable to stopping a fall after it begins.';
    } else if (text.contains('fall arrest')) {
      meaning = 'Fall arrest is a personal protective system intended to safely stop a fall after it occurs.';
      fieldChecks = 'Check full-body harness, compatible connectors, suitable anchor point, clearance, inspection status and a practical rescue plan.';
      whyItMatters = 'A fall-arrest system only works when the complete system is compatible and there is sufficient clearance and rescue capability.';
    } else if (text.contains('lifeline')) {
      meaning = 'A lifeline provides a connection path for an approved fall-protection system. It must be suitable for the system and installed or certified as required.';
      fieldChecks = 'Verify anchorage, line condition, compatibility, installation arrangement, inspection/certification and user connection before work.';
      whyItMatters = 'An unsuitable or damaged lifeline can fail during a fall and expose the worker to severe injury.';
    } else if (text.contains('exclusion zone')) {
      meaning = 'An exclusion zone is a controlled area where people are prevented from entering because of a hazardous operation or falling-object exposure.';
      fieldChecks = 'Check boundaries, barriers, signs, access control, spotters where required and that the zone remains effective as the work progresses.';
      whyItMatters = 'It separates people from the line of fire and reduces exposure to moving plant, lifting, falling objects and other hazards.';
    } else if (text.contains('rescue plan')) {
      meaning = 'A rescue plan defines how an affected worker will be recovered quickly and safely after an emergency, including a fall or equipment failure.';
      fieldChecks = 'Confirm rescue method, competent rescuers, equipment, communication, access route, emergency contacts and a practical response time.';
      whyItMatters = 'A delayed rescue can turn a survivable incident into a fatality, particularly after a fall-arrest event.';
    } else if (text.contains('permit')) {
      meaning = 'A permit is a formal authorisation used to control specified high-risk work and confirm that required precautions are in place before work starts.';
      fieldChecks = 'Verify correct permit, scope, location, validity, isolations, atmospheric testing where applicable, controls, signatures and close-out.';
      whyItMatters = 'Permit controls help prevent uncontrolled high-risk work and ensure critical precautions are verified.';
    } else if (text.contains('risk assessment') || text.contains('jsa')) {
      meaning = 'A risk assessment or JSA identifies hazards, evaluates risk and defines controls before and during the task.';
      fieldChecks = 'Confirm the assessment matches the actual task, people, equipment, environment and current conditions, and that workers understand the controls.';
      whyItMatters = 'Controls are only effective when they address the hazards actually present at the work location.';
    } else if (text.contains('ppe')) {
      meaning = 'PPE is the last line of defence used to reduce exposure when hazards cannot be adequately controlled by higher-level measures.';
      fieldChecks = 'Check correct type, fit, condition, compatibility, approval/certification where required, user training and replacement arrangements.';
      whyItMatters = 'Incorrect, damaged or incompatible PPE can provide little protection when an incident occurs.';
    } else if (text.contains('housekeeping')) {
      meaning = 'Housekeeping means keeping work areas, routes and platforms orderly, clean and free from avoidable hazards.';
      fieldChecks = 'Remove waste, control trailing materials and cables, maintain clear access, stack materials safely and clean spills promptly.';
      whyItMatters = 'Good housekeeping reduces slips, trips, blocked access, fire loading and falling-material hazards.';
    } else if (text.contains('supervisor')) {
      meaning = 'The supervisor is responsible for ensuring planned controls are implemented at the work front and that unsafe conditions are corrected.';
      fieldChecks = 'Confirm briefing, competency, permits, equipment, work-area controls, inspections and ongoing monitoring.';
      whyItMatters = 'Effective supervision turns written procedures into actual field controls.';
    } else if (text.contains('worker')) {
      meaning = 'Workers are expected to follow approved safe systems of work, use controls correctly and report hazards or changes in conditions.';
      fieldChecks = 'Confirm workers understand the task, use required PPE, follow the method statement and stop/report when conditions become unsafe.';
      whyItMatters = 'Worker participation is essential for detecting changing hazards and maintaining controls at the work front.';
    } else if (text.contains('equipment') || text.contains('machinery')) {
      meaning = 'Plant and equipment must be suitable for the task, maintained, inspected and operated by competent authorised persons.';
      fieldChecks = 'Check pre-use inspection, guarding, emergency stops, defects, maintenance status, operator authorisation and safe operating limits.';
      whyItMatters = 'Defective or improperly operated equipment can cause struck-by, caught-in, crushing and mechanical incidents.';
    } else if (text.contains('weather') || text.contains('visibility') || text.contains('lighting')) {
      meaning = 'Work conditions must remain suitable for safe visibility, access and operation. Changing weather or inadequate lighting can invalidate existing controls.';
      fieldChecks = 'Check lighting, visibility, wind, heat, rain, dust and other environmental conditions; stop or modify work when safe limits are exceeded.';
      whyItMatters = 'Poor visibility and adverse weather can increase slips, falls, lifting incidents, vehicle interactions and loss of control.';
    } else {
      meaning = 'This control is a practical requirement within the selected Dubai HSE topic. It should be applied according to the approved method, risk assessment, project requirements and applicable Dubai Municipality requirements.';
      fieldChecks = 'Verify the control is present, suitable for the actual work, understood by the workforce, inspected where necessary and maintained throughout the activity.';
      whyItMatters = 'The control reduces exposure to the hazards identified for this activity and helps maintain safe conditions at the work front.';
    }

    final reference = '${_referenceNumber} — $_title; $_basis';
    return _ItemDetail(
      meaning: meaning,
      fieldChecks: fieldChecks,
      whyItMatters: whyItMatters,
      reference: reference,
    );
  }

  Widget _fieldChecklist(BuildContext context) {
    const items = [
      'Review the risk assessment / JSA before starting work.',
      'Verify the approved method statement / safe work procedure is available.',
      'Verify required permits, isolations, inspections and competency.',
      'Check barricading, signage, access/egress and housekeeping.',
      'Inspect equipment and PPE before use.',
      'Stop and reassess if hazards, work conditions or weather change.',
      'Record the supervisor pre-start briefing.',
      'Make the area safe and close required permits / inspection records after work.',
    ];

    return _section(
      'Field Verification Checklist',
      Icons.fact_check_outlined,
      Column(
        children: items
            .map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () => _showItemDetails(
                      context,
                      'Field Verification Checklist',
                      item,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 2,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.square_outlined,
                            size: 20,
                            color: primaryGreen,
                          ),
                          const SizedBox(width: 9),
                          Expanded(
                            child: Text(
                              item,
                              style: const TextStyle(
                                height: 1.45,
                                color: textSecondary,
                              ),
                            ),
                          ),
                          const SizedBox(width: 5),
                          const Icon(
                            Icons.chevron_right,
                            size: 20,
                            color: primaryGreen,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _emergencySection() {
    return _section(
      'Emergency & Stop-Work',
      Icons.emergency_outlined,
      const Text(
        'For a serious incident, unsafe condition, loss of control, fire, collapse, hazardous exposure or other emergency: stop the work, protect people from further exposure, follow the site emergency procedure, notify responsible management and emergency services as applicable, and do not restart until the area is assessed and controls are restored.',
        style: TextStyle(height: 1.55, color: textSecondary),
      ),
    );
  }

  Widget _applicabilitySection() {
    return _section(
      'Applicability & Verification',
      Icons.rule_folder_outlined,
      const Text(
        'This topic is a SafeNexus field reference summary. Final site requirements must be verified against the work scope, project requirements, approved method statement, risk assessment, permits, current Dubai Municipality publications and applicable legislation.',
        style: TextStyle(height: 1.55, color: textSecondary),
      ),
    );
  }

  Widget _referenceSection(BuildContext context) {
    return _section(
      'References & Official Sources',
      Icons.menu_book_outlined,
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _referenceBullet(
            context,
            'SafeNexus Reference: $_referenceNumber',
          ),
          _referenceBullet(context, _basis),
          ...topic.references.map(
            (reference) => _referenceBullet(context, reference),
          ),
          const Divider(height: 24),
          _referenceBullet(
            context,
            'Dubai Municipality — Code of Construction Safety Practice',
          ),
          _referenceBullet(
            context,
            'Dubai Municipality — Safety Guide for Construction Works in the Emirate of Dubai',
          ),
          _referenceBullet(
            context,
            'Dubai Municipality — Laws and Legislations',
          ),
          _referenceBullet(
            context,
            'Dubai Municipality — Health & Safety Technical Guidelines',
          ),
          _referenceBullet(
            context,
            'Dubai Municipality — Dubai Building Code, where applicable',
          ),
        ],
      ),
    );
  }

  Widget _referenceBullet(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () => _showReferenceDetails(context, text),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 3),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 3),
                  child: Icon(Icons.circle, size: 7, color: primaryGreen),
                ),
                const SizedBox(width: 9),
                Expanded(
                  child: Text(
                    text,
                    style: const TextStyle(
                      height: 1.45,
                      color: textSecondary,
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                const Icon(
                  Icons.chevron_right,
                  size: 19,
                  color: primaryGreen,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showReferenceDetails(BuildContext context, String reference) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => SafeArea(
        child: Container(
          constraints: const BoxConstraints(maxHeight: 560),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 42,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                const Row(
                  children: [
                    Icon(
                      Icons.menu_book_outlined,
                      color: primaryGreen,
                      size: 28,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Reference Details',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: darkGreen,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                _detailBlock(
                  'Reference',
                  reference,
                ),
                _detailBlock(
                  'How to use it',
                  'Use this reference to identify the applicable Dubai HSE requirement for the selected topic. Verify the current official publication, revision, project requirements and any authority-specific conditions before relying on it for site compliance.',
                ),
                _detailBlock(
                  'Topic link',
                  'SafeNexus topic: $_title ($_referenceNumber).',
                ),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: () => Navigator.of(sheetContext).pop(),
                    icon: const Icon(Icons.check),
                    label: const Text('Close'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ItemDetail {
  final String meaning;
  final String fieldChecks;
  final String whyItMatters;
  final String reference;

  const _ItemDetail({
    required this.meaning,
    required this.fieldChecks,
    required this.whyItMatters,
    required this.reference,
  });
}
