import 'package:flutter/material.dart';

import 'models/reference_topic.dart';

class DubaiHseDetailPage extends StatelessWidget {
  final ReferenceTopic topic;

  const DubaiHseDetailPage({
    super.key,
    required this.topic,
  });

  static const Color primary = Color(0xFF0B6B4F);
  static const Color background = Color(0xFFF5F8F7);

  @override
  Widget build(BuildContext context) {
    final detail = _detailsWithFallback[topic.id] ?? _fallback(topic);
    final sections = _sectionsFor(topic.id, detail);

    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: Text(
          topic.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        backgroundColor: primary,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _header(detail),
          const SizedBox(height: 14),
          ...sections.map(
            (section) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _sectionCard(context, topic, section),
            ),
          ),
        ],
      ),
    );
  }

  Widget _header(_TopicDetail detail) {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.shield_outlined, color: primary, size: 28),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    topic.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              topic.description.isNotEmpty
                  ? topic.description
                  : detail.scope,
              style: const TextStyle(fontSize: 14, height: 1.45),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionCard(
    BuildContext context,
    ReferenceTopic topic,
    _DubaiSection section,
  ) {
    return Card(
      elevation: 1,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => DubaiHseSectionDetailPage(
                topic: topic,
                section: section,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: primary.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.menu_book_outlined,
                  color: primary,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  section.title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Icon(Icons.chevron_right, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }

  List<_DubaiSection> _sectionsFor(
    String topicId,
    _TopicDetail detail,
  ) {
    final titles = _sectionTitles[topicId] ??
        const <String>[
          'Scope & Purpose',
          'Main Hazards',
          'Planning Requirements',
          'Key Safety Controls',
          'Pre-Start Verification',
          'Safe Work Requirements',
          'Inspection Requirements',
          'Competent Person Responsibilities',
          'Worker Responsibilities',
          'Records & Documentation',
          'Stop-Work Conditions',
          'Emergency Response',
        ];

    final result = <_DubaiSection>[];

    for (var i = 0; i < titles.length; i++) {
      final title = titles[i];

      if (i == 0) {
        result.add(
          _DubaiSection(
            title: title,
            summary: detail.scope,
            bullets: detail.requirements.take(5).toList(),
          ),
        );
      } else if (i == 1) {
        result.add(
          _DubaiSection(
            title: title,
            summary: 'Identify the credible hazards before work starts.',
            bullets: detail.hazards.take(6).toList(),
          ),
        );
      } else if (i == 2) {
        result.add(
          _DubaiSection(
            title: title,
            summary: 'Plan the work so risks are controlled before execution.',
            bullets: detail.requirements.take(6).toList(),
          ),
        );
      } else if (i == 3) {
        result.add(
          _DubaiSection(
            title: title,
            summary: 'Apply the required controls and verify they remain effective.',
            bullets: detail.controls.take(6).toList(),
          ),
        );
      } else if (i == 4) {
        result.add(
          _DubaiSection(
            title: title,
            summary: 'Complete pre-start checks before authorising the activity.',
            bullets: detail.verification.take(6).toList(),
          ),
        );
      } else if (i == 5) {
        result.add(
          _DubaiSection(
            title: title,
            summary: 'Maintain safe conditions throughout the activity.',
            bullets: detail.controls.take(6).toList(),
          ),
        );
      } else if (i == 6) {
        result.add(
          _DubaiSection(
            title: title,
            summary: 'Inspect, monitor and document the condition of the work area.',
            bullets: detail.verification.take(6).toList(),
          ),
        );
      } else if (i == 7) {
        result.add(
          _DubaiSection(
            title: title,
            summary: 'Use competent supervision and clearly assigned responsibilities.',
            bullets: detail.responsibilities.take(6).toList(),
          ),
        );
      } else if (i == 8) {
        result.add(
          _DubaiSection(
            title: title,
            summary: 'Workers must follow the approved controls and report unsafe conditions.',
            bullets: detail.responsibilities.take(6).toList(),
          ),
        );
      } else if (i == 9) {
        result.add(
          _DubaiSection(
            title: title,
            summary: 'Keep evidence that required checks and controls were completed.',
            bullets: detail.records.take(6).toList(),
          ),
        );
      } else if (i == 10) {
        result.add(
          _DubaiSection(
            title: title,
            summary: 'Stop the activity when specified unsafe conditions exist.',
            bullets: detail.stopWork.take(6).toList(),
          ),
        );
      } else {
        result.add(
          _DubaiSection(
            title: title,
            summary: 'Respond quickly, protect people and escalate the emergency.',
            bullets: [
              'Stop the affected activity when safe to do so.',
              'Raise the alarm and inform the responsible supervisor.',
              'Keep unauthorised persons outside the affected area.',
              'Provide first response only within trained competence.',
              'Follow the site emergency plan and muster arrangements.',
            ],
          ),
        );
      }
    }

    return result;
  }

  _TopicDetail _fallback(ReferenceTopic topic) {
    return _TopicDetail(
      scope: topic.description,
      hazards: topic.keyRequirements.isNotEmpty
          ? topic.keyRequirements
          : const ['Identify activity-specific hazards before work starts.'],
      requirements: topic.keyRequirements.isNotEmpty
          ? topic.keyRequirements
          : const ['Use an approved risk assessment and method statement.'],
      controls: topic.safetyControls.isNotEmpty
          ? topic.safetyControls
          : const ['Apply the hierarchy of controls and maintain supervision.'],
      verification: const [
        'Verify the work area before starting.',
        'Confirm required permits, equipment and competency.',
        'Record inspections and corrective actions.',
      ],
      responsibilities: topic.responsibilities.isNotEmpty
          ? topic.responsibilities
          : const [
              'Supervisor: verify controls before work.',
              'Worker: follow approved controls and report hazards.',
            ],
      records: const [
        'Risk assessment / method statement',
        'Inspection and verification records',
        'Training or competency evidence',
      ],
      stopWork: const [
        'Stop when an uncontrolled serious risk is identified.',
        'Stop when required protective controls are missing.',
        'Restart only after the condition is corrected and verified.',
      ],
    );
  }
}

class DubaiHseSectionDetailPage extends StatelessWidget {
  final ReferenceTopic topic;
  final _DubaiSection section;

  const DubaiHseSectionDetailPage({
    super.key,
    required this.topic,
    required this.section,
  });

  static const Color primary = Color(0xFF0B6B4F);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          section.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        backgroundColor: primary,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            topic.title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: primary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            section.title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            section.summary,
            style: const TextStyle(fontSize: 15, height: 1.5),
          ),
          const SizedBox(height: 18),
          ...section.bullets.asMap().entries.map(
                (entry) => Card(
                  elevation: 0,
                  margin: const EdgeInsets.only(bottom: 9),
                  child: Padding(
                    padding: const EdgeInsets.all(13),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.check_circle_outline,
                          color: primary,
                          size: 21,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            entry.value,
                            style: const TextStyle(
                              fontSize: 14,
                              height: 1.45,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
        ],
      ),
    );
  }
}

class DubaiHseTopicRouter {
  const DubaiHseTopicRouter._();

  static Widget pageFor(ReferenceTopic topic) {
    return DubaiHseDetailPage(topic: topic);
  }
}

class _DubaiSection {
  final String title;
  final String summary;
  final List<String> bullets;

  const _DubaiSection({
    required this.title,
    required this.summary,
    required this.bullets,
  });
}

class _TopicDetail {
  final String scope;
  final List<String> hazards;
  final List<String> requirements;
  final List<String> controls;
  final List<String> verification;
  final List<String> responsibilities;
  final List<String> records;
  final List<String> stopWork;

  const _TopicDetail({
    required this.scope,
    required this.hazards,
    required this.requirements,
    required this.controls,
    required this.verification,
    required this.responsibilities,
    required this.records,
    required this.stopWork,
  });
}

const Map<String, List<String>> _sectionTitles = {
  'dubai_construction_safety_framework': [
    'Framework Purpose & Scope',
    'Construction Safety Hazards',
    'Planning & HSE Requirements',
    'Core Safety Controls',
    'Pre-Start Verification',
    'Safe Construction Operations',
    'Inspection & Monitoring',
    'HSE Management Responsibilities',
    'Worker Responsibilities',
    'Safety Records',
    'Stop-Work Conditions',
    'Emergency Response',
  ],
  'dubai_hse_management_system': [
    'HSE System Purpose & Scope',
    'Management System Hazards',
    'HSE Planning Requirements',
    'Leadership & Control Measures',
    'Pre-Start HSE Verification',
    'Operational HSE Controls',
    'Inspection & Audit',
    'Management Responsibilities',
    'Worker Responsibilities',
    'HSE Documentation',
    'Stop-Work Conditions',
    'Emergency Response',
  ],
  'dubai_risk_assessment': [
    'Risk Assessment Purpose & Scope',
    'Hazard Identification',
    'Risk Evaluation',
    'Risk Control Measures',
    'Pre-Start Risk Verification',
    'Safe Work Requirements',
    'Review & Monitoring',
    'Assessor & Supervisor Responsibilities',
    'Worker Responsibilities',
    'Risk Assessment Records',
    'Stop-Work Conditions',
    'Emergency Response',
  ],
  'dubai_construction_hse_plan': [
    'HSE Plan Purpose & Scope',
    'Construction Hazards',
    'HSE Planning Requirements',
    'HSE Control Measures',
    'Pre-Start Plan Verification',
    'Site Implementation',
    'Inspection & Monitoring',
    'HSE Plan Responsibilities',
    'Worker Responsibilities',
    'HSE Plan Records',
    'Stop-Work Conditions',
    'Emergency Response',
  ],
  'dubai_work_at_height': [
    'Work at Height Scope',
    'Fall & Dropped-Object Hazards',
    'Work at Height Planning Requirements',
    'Edge Protection & Fall Controls',
    'Pre-Start Height Checks',
    'Safe Work at Height',
    'Inspection & Access Verification',
    'Supervisor Responsibilities',
    'Worker Responsibilities',
    'Height Work Records',
    'Fall-Related Stop Work',
    'Fall Rescue & Emergency Response',
  ],
  'dubai_scaffolding': [
    'Scaffold Purpose & Scope',
    'Scaffold Types & Applications',
    'Scaffold Hazards',
    'Foundation / Base Requirements',
    'Erection & Dismantling',
    'Guardrails & Toe Boards',
    'Safe Access',
    'Bracing, Ties & Stability',
    'Platforms & Loading',
    'Inspection & Tagging',
    'Modification & Weather Control',
    'Scaffold Emergency / Stop Work',
  ],
  'dubai_lifting_operations': [
    'Lifting Purpose & Scope',
    'Lifting Equipment & Operations',
    'Lifting Hazards',
    'Ground & Set-Up Requirements',
    'Lift Planning',
    'Rigging & Accessories',
    'Exclusion Zones & Signalling',
    'Crane / Hoist Stability',
    'Load Control & Capacity',
    'Inspection & Certification',
    'Competent Persons & Responsibilities',
    'Lifting Emergency / Stop Work',
  ],
  'dubai_excavation_trenching': [
    'Excavation Purpose & Scope',
    'Excavation Types & Hazards',
    'Ground Condition Assessment',
    'Underground Services',
    'Excavation Planning',
    'Shoring / Benching / Sloping',
    'Access & Egress',
    'Plant, Traffic & Edge Protection',
    'Water, Atmosphere & Environmental Conditions',
    'Daily Inspection',
    'Collapse / Unsafe Excavation Stop Work',
    'Excavation Emergency Response',
  ],
  'dubai_confined_space': [
    'Confined Space Purpose & Scope',
    'Confined Space Hazards',
    'Entry Risk Assessment',
    'Permit & Isolation Controls',
    'Pre-Entry Verification',
    'Safe Entry & Work',
    'Atmospheric Monitoring',
    'Standby & Competent Person Duties',
    'Worker Responsibilities',
    'Entry Records',
    'Confined Space Stop Work',
    'Rescue & Emergency Response',
  ],
  'dubai_electrical_safety': [
    'Electrical Safety Scope',
    'Electrical Hazards',
    'Electrical Risk Assessment',
    'Isolation & Lockout Controls',
    'Pre-Start Electrical Checks',
    'Safe Electrical Work',
    'Inspection & Testing',
    'Competent Person Responsibilities',
    'Worker Responsibilities',
    'Electrical Records',
    'Electrical Stop Work',
    'Electrical Emergency Response',
  ],
  'dubai_hot_work': [
    'Hot Work Purpose & Scope',
    'Fire & Hot Work Hazards',
    'Hot Work Planning',
    'Permit & Fire Controls',
    'Pre-Start Hot Work Checks',
    'Safe Hot Work',
    'Fire Watch & Monitoring',
    'Supervisor Responsibilities',
    'Worker Responsibilities',
    'Hot Work Records',
    'Hot Work Stop Work',
    'Fire Emergency Response',
  ],
  'dubai_construction_traffic': [
    'Traffic Management Scope',
    'Vehicle & Pedestrian Hazards',
    'Traffic Planning',
    'Segregation & Control Measures',
    'Pre-Start Traffic Checks',
    'Safe Vehicle Operations',
    'Inspection & Monitoring',
    'Traffic Marshal Responsibilities',
    'Driver & Worker Responsibilities',
    'Traffic Records',
    'Traffic Stop Work',
    'Vehicle Emergency Response',
  ],
  'dubai_demolition_safety': [
    'Demolition Purpose & Scope',
    'Demolition Hazards',
    'Structural Assessment',
    'Demolition Planning',
    'Pre-Start Verification',
    'Safe Demolition Operations',
    'Inspection & Monitoring',
    'Competent Person Responsibilities',
    'Worker Responsibilities',
    'Demolition Records',
    'Demolition Stop Work',
    'Demolition Emergency Response',
  ],
  'dubai_temporary_works': [
    'Temporary Works Scope',
    'Temporary Works Hazards',
    'Design & Risk Assessment',
    'Temporary Works Controls',
    'Pre-Start Verification',
    'Safe Installation & Use',
    'Inspection & Monitoring',
    'Temporary Works Coordinator Duties',
    'Worker Responsibilities',
    'Temporary Works Records',
    'Temporary Works Stop Work',
    'Failure / Emergency Response',
  ],
  'dubai_heat_stress': [
    'Heat Stress Scope',
    'Heat Stress Hazards',
    'Heat Risk Assessment',
    'Heat Stress Controls',
    'Pre-Start Heat Checks',
    'Safe Work in Heat',
    'Monitoring & Inspection',
    'Supervisor Responsibilities',
    'Worker Responsibilities',
    'Heat Stress Records',
    'Heat-Related Stop Work',
    'Heat Illness Emergency Response',
  ],
  'dubai_occupational_health': [
    'Occupational Health Scope',
    'Health Hazards',
    'Health Risk Assessment',
    'Health Protection Controls',
    'Pre-Start Health Verification',
    'Safe Work Practices',
    'Health Monitoring',
    'Occupational Health Responsibilities',
    'Worker Responsibilities',
    'Health Records',
    'Health-Related Stop Work',
    'Medical Emergency Response',
  ],
  'dubai_ppe': [
    'PPE Purpose & Scope',
    'PPE Hazards',
    'PPE Selection Requirements',
    'PPE Control Measures',
    'Pre-Use PPE Checks',
    'Correct PPE Use',
    'PPE Inspection & Replacement',
    'Supervisor Responsibilities',
    'Worker Responsibilities',
    'PPE Records',
    'PPE Stop-Work Conditions',
    'PPE Emergency Response',
  ],
  'dubai_emergency_preparedness': [
    'Emergency Planning Scope',
    'Emergency Hazards',
    'Emergency Risk Assessment',
    'Emergency Controls',
    'Pre-Start Emergency Verification',
    'Emergency Preparedness',
    'Drills & Inspection',
    'Emergency Team Responsibilities',
    'Worker Responsibilities',
    'Emergency Records',
    'Emergency Stop-Work Conditions',
    'Emergency Response',
  ],
  'dubai_incident_reporting': [
    'Incident Reporting Scope',
    'Incident Hazards & Events',
    'Initial Risk Assessment',
    'Immediate Controls',
    'Initial Incident Verification',
    'Incident Response',
    'Investigation & Monitoring',
    'Investigator Responsibilities',
    'Worker Responsibilities',
    'Incident Records',
    'Stop-Work After Serious Incident',
    'Incident Emergency Response',
  ],
  'dubai_contractor_management': [
    'Contractor HSE Scope',
    'Contractor Hazards',
    'Prequalification & Risk Assessment',
    'Contractor Control Measures',
    'Pre-Start Verification',
    'Safe Contractor Operations',
    'Inspection & Performance Monitoring',
    'Principal Contractor Responsibilities',
    'Contractor Worker Responsibilities',
    'Contractor HSE Records',
    'Contractor Stop Work',
    'Contractor Emergency Response',
  ],
  'dubai_environmental_waste': [
    'Environmental Scope',
    'Environmental Hazards',
    'Environmental Risk Assessment',
    'Waste & Pollution Controls',
    'Pre-Start Environmental Checks',
    'Safe Waste Handling',
    'Inspection & Monitoring',
    'Environmental Responsibilities',
    'Worker Responsibilities',
    'Environmental Records',
    'Environmental Stop Work',
    'Environmental Emergency Response',
  ],
  'dubai_hse_inspection_audit': [
    'Inspection & Audit Scope',
    'Inspection Hazards',
    'Inspection Planning',
    'Corrective Control Measures',
    'Pre-Inspection Verification',
    'Inspection Execution',
    'Follow-Up & Verification',
    'Inspector Responsibilities',
    'Worker Responsibilities',
    'Inspection Records',
    'Serious Deficiency Stop Work',
    'Emergency Escalation',
  ],
  'dubai_hse_performance': [
    'Performance Monitoring Scope',
    'Performance Risk Indicators',
    'Monitoring Planning',
    'Performance Controls',
    'Pre-Start Data Verification',
    'Performance Monitoring',
    'Trend Review & Follow-Up',
    'Management Responsibilities',
    'Worker Responsibilities',
    'Performance Records',
    'Critical Performance Stop Work',
    'Emergency Escalation',
  ],
  'dubai_building_code': [
    'Building Code Scope',
    'Building Safety Hazards',
    'Code Compliance Assessment',
    'Safety Control Requirements',
    'Pre-Start Compliance Checks',
    'Safe Construction Requirements',
    'Inspection & Verification',
    'Designer / Consultant Responsibilities',
    'Worker Responsibilities',
    'Compliance Records',
    'Non-Compliance Stop Work',
    'Building Safety Emergency Response',
  ],
  'dubai_permit_to_work': [
    'PTW Purpose & Scope',
    'Permit-Related Hazards',
    'Permit Risk Assessment',
    'Permit Control Measures',
    'Pre-Start Permit Verification',
    'Permit Execution',
    'Permit Monitoring & Closure',
    'Authorised Person Responsibilities',
    'Worker Responsibilities',
    'PTW Records',
    'Permit Stop Work',
    'PTW Emergency Response',
  ],
  'dubai_site_establishment': [
    'Site Establishment Scope',
    'Site Set-Up Hazards',
    'Site Planning',
    'Site Control Measures',
    'Pre-Start Site Verification',
    'Safe Site Operations',
    'Inspection & Monitoring',
    'Site Management Responsibilities',
    'Worker Responsibilities',
    'Site Records',
    'Unsafe Site Stop Work',
    'Site Emergency Response',
  ],
  'dubai_site_security_public': [
    'Site Security Scope',
    'Public Protection Hazards',
    'Security Planning',
    'Barricading & Protection Controls',
    'Pre-Start Security Checks',
    'Safe Public Interface',
    'Inspection & Monitoring',
    'Security Responsibilities',
    'Worker Responsibilities',
    'Security Records',
    'Public Risk Stop Work',
    'Security Emergency Response',
  ],
  'dubai_access_egress_housekeeping': [
    'Access & Housekeeping Scope',
    'Access Hazards',
    'Access Planning',
    'Housekeeping Controls',
    'Pre-Start Access Checks',
    'Safe Access & Egress',
    'Inspection & Monitoring',
    'Supervisor Responsibilities',
    'Worker Responsibilities',
    'Housekeeping Records',
    'Blocked Access Stop Work',
    'Access Emergency Response',
  ],
  'dubai_worker_welfare': [
    'Worker Welfare Scope',
    'Welfare Hazards',
    'Welfare Planning',
    'Welfare Control Measures',
    'Pre-Start Welfare Verification',
    'Safe Welfare Facilities',
    'Inspection & Monitoring',
    'Site Management Responsibilities',
    'Worker Responsibilities',
    'Welfare Records',
    'Unsafe Welfare Stop Work',
    'Welfare Emergency Response',
  ],
  'dubai_material_storage': [
    'Material Storage Scope',
    'Storage & Handling Hazards',
    'Storage Risk Assessment',
    'Storage Control Measures',
    'Pre-Start Storage Checks',
    'Safe Material Handling',
    'Inspection & Monitoring',
    'Storekeeper / Supervisor Responsibilities',
    'Worker Responsibilities',
    'Storage Records',
    'Unsafe Storage Stop Work',
    'Storage Emergency Response',
  ],
  'dubai_formwork_falsework': [
    'Formwork & Falsework Scope',
    'Temporary Support Hazards',
    'Design & Stability Assessment',
    'Formwork Control Measures',
    'Pre-Start Verification',
    'Safe Installation & Use',
    'Inspection & Monitoring',
    'Competent Person Responsibilities',
    'Worker Responsibilities',
    'Formwork Records',
    'Unstable Support Stop Work',
    'Collapse Emergency Response',
  ],
  'dubai_reinforcement_concrete': [
    'Concrete Operations Scope',
    'Reinforcement & Concrete Hazards',
    'Concrete Work Planning',
    'Operational Control Measures',
    'Pre-Start Checks',
    'Safe Reinforcement & Concrete Work',
    'Inspection & Monitoring',
    'Supervisor Responsibilities',
    'Worker Responsibilities',
    'Concrete Work Records',
    'Unsafe Operation Stop Work',
    'Concrete Emergency Response',
  ],
  'dubai_plant_machinery_guarding': [
    'Plant & Machinery Scope',
    'Machinery Hazards',
    'Plant Risk Assessment',
    'Guarding & Control Measures',
    'Pre-Start Machinery Checks',
    'Safe Machinery Operation',
    'Inspection & Maintenance',
    'Competent Operator Responsibilities',
    'Worker Responsibilities',
    'Plant Records',
    'Unsafe Machinery Stop Work',
    'Machinery Emergency Response',
  ],
  'dubai_ladders_mobile_towers': [
    'Ladders & Towers Scope',
    'Ladder & Tower Hazards',
    'Equipment Selection',
    'Stability & Fall Controls',
    'Pre-Use Checks',
    'Safe Use',
    'Inspection & Tagging',
    'Supervisor Responsibilities',
    'Worker Responsibilities',
    'Access Equipment Records',
    'Unsafe Access Stop Work',
    'Fall Emergency Response',
  ],
  'dubai_fire_prevention': [
    'Fire Prevention Scope',
    'Fire Hazards',
    'Fire Risk Assessment',
    'Fire Prevention Controls',
    'Pre-Start Fire Checks',
    'Safe Fire Prevention Practices',
    'Inspection & Fire Drills',
    'Fire Warden Responsibilities',
    'Worker Responsibilities',
    'Fire Records',
    'Fire-Risk Stop Work',
    'Fire Emergency Response',
  ],
  'dubai_safety_signs_barricading': [
    'Signs & Barricading Scope',
    'Signage & Barricading Hazards',
    'Area Risk Assessment',
    'Exclusion Zone Controls',
    'Pre-Start Checks',
    'Safe Signage & Barricading',
    'Inspection & Maintenance',
    'Supervisor Responsibilities',
    'Worker Responsibilities',
    'Signage Records',
    'Inadequate Barrier Stop Work',
    'Public / Worker Emergency Response',
  ],
  'dubai_lighting_weather_visibility': [
    'Lighting & Visibility Scope',
    'Weather & Visibility Hazards',
    'Environmental Risk Assessment',
    'Lighting & Weather Controls',
    'Pre-Start Conditions Check',
    'Safe Work in Poor Visibility',
    'Inspection & Monitoring',
    'Supervisor Responsibilities',
    'Worker Responsibilities',
    'Weather Records',
    'Unsafe Visibility Stop Work',
    'Weather Emergency Response',
  ],
};

const Map<String, _TopicDetail> _details = {
  'dubai_construction_safety_framework': _TopicDetail(
    scope: 'Construction safety requirements for managing people, plant, temporary works and site activities.',
    hazards: ['Falls', 'Struck-by incidents', 'Plant movement', 'Collapse', 'Fire'],
    requirements: [
      'Use documented risk assessments and safe work methods.',
      'Provide competent supervision for construction activities.',
      'Maintain safe access, egress and housekeeping.',
      'Control interfaces between workers, plant and the public.',
      'Inspect critical work areas and equipment.',
    ],
    controls: ['Hierarchy of controls', 'Physical segregation', 'Permit controls', 'Inspection', 'Competent supervision'],
    verification: ['Approved risk assessment', 'Work area inspection', 'Equipment suitability', 'Worker competency'],
    responsibilities: ['Management provides resources.', 'Supervisors implement controls.', 'Workers follow approved procedures.'],
    records: ['Risk assessments', 'Inspection records', 'Training records', 'Corrective actions'],
    stopWork: ['Uncontrolled fall risk', 'Unstable structure or temporary works', 'Unsafe plant movement', 'Missing critical controls'],
  ),
  'dubai_hse_management_system': _TopicDetail(
    scope: 'A structured HSE management approach for planning, implementing, checking and improving site safety.',
    hazards: ['Poor planning', 'Uncontrolled changes', 'Weak supervision', 'Unclosed corrective actions'],
    requirements: ['Define HSE responsibilities.', 'Set project controls.', 'Review risk assessments.', 'Track corrective actions.', 'Measure performance.'],
    controls: ['Leadership', 'Risk management', 'Inspection', 'Audit', 'Corrective action'],
    verification: ['HSE plan', 'Assigned responsibilities', 'Open-action review', 'Inspection programme'],
    responsibilities: ['Management leads the system.', 'HSE personnel verify controls.', 'Supervisors manage field implementation.'],
    records: ['HSE plans', 'Audits', 'Inspections', 'Action trackers'],
    stopWork: ['Critical control failure', 'Repeated serious non-compliance', 'Immediate uncontrolled risk'],
  ),
  'dubai_risk_assessment': _TopicDetail(
    scope: 'Systematic identification, evaluation and control of hazards associated with work activities.',
    hazards: ['Unidentified hazards', 'Incorrect risk rating', 'Inadequate controls', 'Change in conditions'],
    requirements: ['Identify hazards.', 'Assess likelihood and consequence.', 'Apply the hierarchy of controls.', 'Communicate controls.', 'Review when conditions change.'],
    controls: ['Elimination', 'Substitution', 'Engineering controls', 'Administrative controls', 'PPE'],
    verification: ['Current assessment', 'Field conditions match assessment', 'Controls installed', 'Workers briefed'],
    responsibilities: ['Competent assessor prepares the assessment.', 'Supervisor verifies field controls.', 'Workers follow controls and report changes.'],
    records: ['Risk assessments', 'Toolbox talks', 'Review records', 'Action closure'],
    stopWork: ['Risk is not controlled', 'Conditions materially change', 'Critical control is absent'],
  ),
  'dubai_scaffolding': _TopicDetail(
    scope: 'Safe planning, erection, use, inspection and modification of scaffolds used for construction work.',
    hazards: ['Falls from height', 'Collapse', 'Falling objects', 'Overloading', 'Unsafe access', 'Weather effects'],
    requirements: ['Use a suitable scaffold system.', 'Provide sound foundations.', 'Erect under competent supervision.', 'Provide guardrails and toe boards.', 'Control loading and access.', 'Inspect before use and after significant changes.'],
    controls: ['Stable base', 'Bracing and ties', 'Guardrails', 'Toe boards', 'Safe access', 'Load control'],
    verification: ['Foundation checked', 'Scaffold complete', 'Guardrails fitted', 'Access provided', 'Inspection/tagging completed'],
    responsibilities: ['Competent person controls erection and inspection.', 'Supervisor prevents unauthorised modification.', 'Workers use the scaffold as intended.'],
    records: ['Inspection records', 'Scaffold tag/status', 'Modification records', 'Competency records'],
    stopWork: ['Missing guardrails', 'Unstable or damaged scaffold', 'Overloading', 'Unauthorised modification', 'Unsafe access'],
  ),
  'dubai_excavation_trenching': _TopicDetail(
    scope: 'Safe planning and execution of excavation and trenching work, including ground stability and underground services.',
    hazards: ['Collapse', 'Underground services', 'Falls into excavation', 'Plant interaction', 'Water ingress', 'Atmospheric hazards'],
    requirements: ['Assess ground conditions.', 'Locate services before digging.', 'Provide suitable shoring, benching or sloping.', 'Control edges and access.', 'Inspect excavations regularly.'],
    controls: ['Shoring', 'Benching/sloping', 'Edge protection', 'Service detection', 'Safe access'],
    verification: ['Ground assessment', 'Services identified', 'Protection installed', 'Access provided', 'Daily inspection'],
    responsibilities: ['Competent person inspects excavation.', 'Supervisor controls plant and access.', 'Workers stay within protected areas.'],
    records: ['Excavation inspections', 'Service drawings/checks', 'Risk assessment', 'Permit records'],
    stopWork: ['Cracking or movement', 'Unsupported excavation', 'Unknown service', 'Water undermining', 'Unsafe access'],
  ),
  'dubai_lifting_operations': _TopicDetail(
    scope: 'Safe planning and execution of lifting operations using cranes, hoists and lifting accessories.',
    hazards: ['Dropped loads', 'Overturning', 'Rigging failure', 'Crush zones', 'Power-line contact'],
    requirements: ['Prepare a lift plan.', 'Use suitable certified equipment.', 'Verify ground and set-up.', 'Control exclusion zones.', 'Use competent lifting personnel.'],
    controls: ['Lift plan', 'Certified accessories', 'Outriggers/stability', 'Exclusion zone', 'Signalling'],
    verification: ['Equipment certification', 'Accessory inspection', 'Ground condition', 'Load weight/capacity', 'Competent team'],
    responsibilities: ['Lifting supervisor controls the lift.', 'Operator follows the plan.', 'Riggers/signallers work within competency.'],
    records: ['Lift plans', 'Inspection/certification', 'Pre-use checks', 'Competency records'],
    stopWork: ['Overcapacity', 'Damaged accessory', 'Unstable set-up', 'Loss of communication', 'Unauthorised persons in exclusion zone'],
  ),
  'dubai_work_at_height': _TopicDetail(
    scope: 'Controls for work where a person could fall from a height or where falling objects could injure people below.',
    hazards: ['Falls', 'Dropped objects', 'Fragile surfaces', 'Unprotected edges'],
    requirements: ['Plan work at height.', 'Prefer collective protection.', 'Provide safe access.', 'Inspect fall protection equipment.', 'Plan rescue.'],
    controls: ['Guardrails', 'Safe platforms', 'Fall restraint', 'Fall arrest', 'Dropped-object controls'],
    verification: ['Edge protection', 'Access', 'Harness/equipment', 'Anchor suitability', 'Rescue plan'],
    responsibilities: ['Supervisor verifies controls.', 'Workers use access and fall protection correctly.', 'Only competent persons perform specialised work.'],
    records: ['Height-work assessment', 'Equipment inspection', 'Training', 'Rescue arrangements'],
    stopWork: ['Unprotected edge', 'Unsafe access', 'Unsuitable anchor', 'Damaged fall protection'],
  ),
  'dubai_confined_space': _TopicDetail(
    scope: 'Controlled entry and work in spaces with restricted access and potential atmospheric or other serious hazards.',
    hazards: ['Toxic atmosphere', 'Oxygen deficiency', 'Engulfment', 'Fire', 'Difficult rescue'],
    requirements: ['Identify the space.', 'Assess hazards.', 'Use permit controls where required.', 'Isolate energy/material sources.', 'Provide standby and rescue arrangements.'],
    controls: ['Isolation', 'Atmospheric testing', 'Ventilation', 'Standby person', 'Rescue plan'],
    verification: ['Permit', 'Gas test', 'Isolation', 'Ventilation', 'Rescue equipment'],
    responsibilities: ['Authorised person controls entry.', 'Standby person maintains communication.', 'Entrants follow permit conditions.'],
    records: ['Entry permits', 'Gas tests', 'Isolation records', 'Training'],
    stopWork: ['Unsafe atmosphere', 'Loss of ventilation', 'Failed communication', 'Changed conditions'],
  ),
  'dubai_electrical_safety': _TopicDetail(
    scope: 'Controls for electrical installation, maintenance, temporary supplies and electrical equipment.',
    hazards: ['Electric shock', 'Arc flash', 'Fire', 'Damaged cables', 'Unauthorised energisation'],
    requirements: ['Use competent electrical personnel.', 'Isolate where practicable.', 'Protect temporary supplies.', 'Inspect equipment and cables.', 'Control energisation.'],
    controls: ['Isolation/LOTO', 'RCD/GFCI protection', 'Grounding', 'Cable protection', 'Electrical inspection'],
    verification: ['Isolation confirmed', 'Equipment inspected', 'Protection tested', 'Competency verified'],
    responsibilities: ['Authorised electrical person controls work.', 'Workers do not interfere with electrical systems.', 'Supervisors enforce controls.'],
    records: ['Testing records', 'Inspection records', 'Isolation records', 'Competency'],
    stopWork: ['Exposed live parts', 'Damaged cable', 'Failed protection', 'Uncontrolled energisation'],
  ),
  'dubai_hot_work': _TopicDetail(
    scope: 'Control of welding, cutting, grinding and other activities capable of producing heat, sparks or flame.',
    hazards: ['Fire', 'Explosion', 'Fumes', 'Burns', 'Ignition of hidden combustibles'],
    requirements: ['Use a hot-work permit where required.', 'Remove or protect combustibles.', 'Provide suitable extinguishers.', 'Control cylinders and hoses.', 'Maintain fire watch as required.'],
    controls: ['Permit', 'Fire watch', 'Spark containment', 'Gas-cylinder controls', 'Ventilation'],
    verification: ['Area checked', 'Combustibles controlled', 'Extinguisher available', 'Equipment inspected'],
    responsibilities: ['Supervisor authorises controls.', 'Fire watch monitors the area.', 'Workers follow permit conditions.'],
    records: ['Hot-work permits', 'Equipment checks', 'Fire-watch records'],
    stopWork: ['Combustibles uncontrolled', 'No required permit', 'Gas leak', 'Fire protection unavailable'],
  ),
};

_TopicDetail _genericDetail(String title) {
  return _TopicDetail(
    scope: '$title: activity-specific HSE requirements for safe planning, execution and monitoring.',
    hazards: [
      'People may be exposed to activity-specific physical hazards.',
      'Poor planning can create uncontrolled interfaces.',
      'Equipment or environmental conditions may change during work.',
      'Inadequate supervision can allow unsafe practices.',
    ],
    requirements: [
      'Complete an activity-specific risk assessment.',
      'Use an approved safe work method and competent personnel.',
      'Verify required equipment, access and protective controls.',
      'Brief workers before starting and when conditions change.',
      'Maintain inspection and corrective-action processes.',
    ],
    controls: [
      'Eliminate or reduce hazards where practicable.',
      'Use suitable engineering controls.',
      'Segregate people from hazardous operations.',
      'Provide supervision and clear communication.',
      'Use PPE as the final layer of protection.',
    ],
    verification: [
      'Confirm the work area is suitable.',
      'Confirm equipment and controls are fit for use.',
      'Confirm required competency and authorisation.',
      'Record required inspections and corrective actions.',
    ],
    responsibilities: [
      'Management provides resources and arrangements.',
      'Supervisors verify field controls.',
      'Workers follow approved procedures and report unsafe conditions.',
    ],
    records: [
      'Risk assessment / method statement',
      'Inspection records',
      'Training or competency evidence',
      'Corrective-action records',
    ],
    stopWork: [
      'Stop for an uncontrolled serious risk.',
      'Stop when a critical protective control is missing.',
      'Stop when conditions change and the assessment is no longer valid.',
      'Restart only after controls are restored and verified.',
    ],
  );
}

final Map<String, _TopicDetail> _allGenericDetails = {
  for (final entry in _sectionTitles.entries)
    entry.key: _genericDetail(entry.value.first),
};

// Merge detailed profiles with topic-specific fallback profiles.
final Map<String, _TopicDetail> _detailsWithFallback = {
  ..._allGenericDetails,
  ..._details,
};
