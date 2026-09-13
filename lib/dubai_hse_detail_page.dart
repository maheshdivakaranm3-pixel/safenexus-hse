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
                'Key Requirements',
                Icons.checklist_outlined,
                topic.keyRequirements,
              ),
              const SizedBox(height: 16),
              _listSection(
                'Safety Controls',
                Icons.health_and_safety_outlined,
                topic.safetyControls,
              ),
              const SizedBox(height: 16),
              _listSection(
                'Responsibilities',
                Icons.groups_outlined,
                topic.responsibilities,
              ),
              const SizedBox(height: 16),
              _fieldChecklist(),
              const SizedBox(height: 16),
              _emergencySection(),
              const SizedBox(height: 16),
              _applicabilitySection(),
              const SizedBox(height: 16),
              _referenceSection(),
              const SizedBox(height: 16),
              _notice(),
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

  Widget _listSection(String title, IconData icon, List<String> items) {
    return _section(
      title,
      icon,
      Column(
        children: List.generate(items.length, (index) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: index == items.length - 1 ? 0 : 10,
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
                    items[index],
                    style: const TextStyle(
                      fontSize: 14.5,
                      height: 1.5,
                      color: textSecondary,
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _fieldChecklist() {
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
                  ],
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

  Widget _referenceSection() {
    return _section(
      'References & Official Sources',
      Icons.menu_book_outlined,
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _referenceBullet(
            'SafeNexus Reference: $_referenceNumber',
          ),
          _referenceBullet(_basis),
          ...topic.references.map(_referenceBullet),
          const Divider(height: 24),
          _referenceBullet(
            'Dubai Municipality — Code of Construction Safety Practice',
          ),
          _referenceBullet(
            'Dubai Municipality — Safety Guide for Construction Works in the Emirate of Dubai',
          ),
          _referenceBullet(
            'Dubai Municipality — Laws and Legislations',
          ),
          _referenceBullet(
            'Dubai Municipality — Health & Safety Technical Guidelines',
          ),
          _referenceBullet(
            'Dubai Municipality — Dubai Building Code, where applicable',
          ),
        ],
      ),
    );
  }

  Widget _referenceBullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
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
        ],
      ),
    );
  }

  Widget _notice() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: const Text(
        'SafeNexus HSE is a practical reference and does not replace the current official Dubai Municipality publication, legislation, project requirements or approved company procedures. Always verify the latest applicable requirement before work.',
        style: const TextStyle(
          fontSize: 12.5,
          height: 1.5,
          color: textSecondary,
        ),
      ),
    );
  }
}
