import 'package:flutter/material.dart';

/// SafeNexus HSE — Dubai Topic 04
/// Legal & Regulatory Compliance
///
/// Architecture:
/// - One complete Dart file for the topic.
/// - Main page + Advanced Learning + detailed topic pages.
/// - No dependency on the deleted Part 1 / Part 2 architecture.
/// - Intended to be routed from DubaiHsePartRouter using topic id:
///   dubai_legal_regulatory_compliance
///
/// Content is designed as professional learning/reference material.
/// Always verify current official requirements before making a legal decision.

class DubaiHseLegalRegulatoryCompliancePage extends StatelessWidget {
  const DubaiHseLegalRegulatoryCompliancePage({super.key});

  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color navy = Color(0xFF17324D);
  static const Color background = Color(0xFFF5F8F7);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: const Text(
          '04 • Legal & Regulatory Compliance',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
          children: [
            _hero(context),
            const SizedBox(height: 16),
            _advancedLearning(context),
            const SizedBox(height: 18),
            _sectionHeader('Complete Topic', 'All core legal and regulatory compliance content'),
            const SizedBox(height: 10),
            ..._legalSections.map((item) => _sectionCard(context, item)),
            const SizedBox(height: 18),
            _referenceCard(),
          ],
        ),
      ),
    );
  }

  Widget _hero(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [darkGreen, primaryGreen],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.10),
            blurRadius: 16,
            offset: const Offset(0, 7),
          ),
        ],
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: Colors.white24,
                child: Icon(Icons.gavel_rounded, color: Colors.white, size: 28),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'LEGAL & REGULATORY COMPLIANCE',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                    letterSpacing: .3,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Text(
            'Dubai Construction HSE Reference',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 7),
          Text(
            'Identify applicable requirements, convert them into site controls, verify implementation and maintain objective evidence.',
            style: TextStyle(
              color: Colors.white70,
              height: 1.45,
              fontSize: 13.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _advancedLearning(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const DubaiHseLegalRegulatoryAdvancedLearningPage(),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: const Color(0xFFEAF6F0),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: primaryGreen.withValues(alpha: .25)),
        ),
        child: const Row(
          children: [
            CircleAvatar(
              backgroundColor: primaryGreen,
              child: Icon(Icons.menu_book_rounded, color: Colors.white),
            ),
            SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '📚 ADVANCED LEARNING',
                    style: TextStyle(
                      color: darkGreen,
                      fontWeight: FontWeight.w800,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Regulatory intelligence, compliance assurance, audit evidence, legal-change management and professional HSE application.',
                    style: TextStyle(height: 1.35, fontSize: 12.8),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios_rounded, size: 17, color: darkGreen),
          ],
        ),
      ),
    );
  }

  Widget _sectionHeader(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: navy,
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: const TextStyle(color: Colors.black54, fontSize: 12.5),
        ),
      ],
    );
  }

  Widget _sectionCard(BuildContext context, _LegalSection item) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DubaiHseLegalRegulatoryDetailPage(section: item),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: primaryGreen.withValues(alpha: .10),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  item.id,
                  style: const TextStyle(
                    color: darkGreen,
                    fontWeight: FontWeight.w800,
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(width: 13),
              Expanded(
                child: Text(
                  item.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: navy,
                    fontSize: 14.5,
                  ),
                ),
              ),
              const Icon(Icons.chevron_right_rounded, color: Colors.black45),
            ],
          ),
        ),
      ),
    );
  }

  Widget _referenceCard() {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.library_books_rounded, color: darkGreen),
              SizedBox(width: 8),
              Text(
                'Reference Discipline',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: navy,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            'Use current official Dubai Municipality publications and the project-approved document set when verifying legal requirements. This learning module is not a substitute for the official legal text.',
            style: TextStyle(height: 1.5, fontSize: 13),
          ),
        ],
      ),
    );
  }
}

class DubaiHseLegalRegulatoryDetailPage extends StatelessWidget {
  final _LegalSection section;

  const DubaiHseLegalRegulatoryDetailPage({
    super.key,
    required this.section,
  });

  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color navy = Color(0xFF17324D);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(section.title),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(18, 18, 18, 32),
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: const Color(0xFFEAF6F0),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Text(
              section.description,
              style: const TextStyle(height: 1.55, fontSize: 14),
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            'Key Application Points',
            style: TextStyle(
              color: navy,
              fontWeight: FontWeight.w800,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 10),
          ...section.points.map(
            (point) => Padding(
              padding: const EdgeInsets.only(bottom: 11),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 3),
                    child: Icon(
                      Icons.check_circle_rounded,
                      size: 19,
                      color: Color(0xFF159447),
                    ),
                  ),
                  const SizedBox(width: 9),
                  Expanded(
                    child: Text(
                      point,
                      style: const TextStyle(height: 1.45, fontSize: 13.5),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.amber.withValues(alpha: .10),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.amber.withValues(alpha: .25)),
            ),
            child: const Text(
              'Field note: verify the current official requirement, project conditions and approved documents before treating a compliance point as legally applicable.',
              style: TextStyle(height: 1.45, fontSize: 12.5),
            ),
          ),
        ],
      ),
    );
  }
}

class DubaiHseLegalRegulatoryAdvancedLearningPage extends StatelessWidget {
  const DubaiHseLegalRegulatoryAdvancedLearningPage({super.key});

  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color navy = Color(0xFF17324D);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Advanced Learning'),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 30),
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [darkGreen, Color(0xFF159447)],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '📚 ADVANCED LEGAL & REGULATORY LEARNING',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 17,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'For HSE Officers, Supervisors, Engineers and project leaders who need to move from document compliance to field assurance.',
                  style: TextStyle(color: Colors.white70, height: 1.45),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          ..._advancedModules.map(
            (module) => Card(
              elevation: 0,
              margin: const EdgeInsets.only(bottom: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: Colors.grey.shade200),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${module.id}  ${module.title}',
                      style: const TextStyle(
                        color: navy,
                        fontWeight: FontWeight.w800,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      module.content,
                      style: const TextStyle(height: 1.5, fontSize: 13.2),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          _professionalChecklist(),
          const SizedBox(height: 16),
          _references(),
        ],
      ),
    );
  }

  Widget _professionalChecklist() {
    const items = [
      'Current legal / regulatory register reviewed',
      'Applicable requirements mapped to project controls',
      'Current approvals, permits and competency evidence verified',
      'RAMS and work-front controls aligned with requirements',
      'Field implementation physically verified',
      'Workers and supervisors understand critical controls',
      'Non-conformities assigned and tracked',
      'Closure effectiveness verified',
      'Regulatory changes assessed and communicated',
      'Objective evidence is retrievable for audit',
    ];

    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF6F0),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Professional Compliance Verification Checklist',
            style: TextStyle(
              color: navy,
              fontWeight: FontWeight.w800,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 10),
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.verified_rounded, size: 18, color: darkGreen),
                  const SizedBox(width: 8),
                  Expanded(child: Text(item, style: const TextStyle(fontSize: 13))),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _references() {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Official Reference Sources to Verify',
            style: TextStyle(
              color: navy,
              fontWeight: FontWeight.w800,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 10),
          Text(
            '• Dubai Municipality — Laws and Legislations\n'
            '• Dubai Municipality — Planning and Construction\n'
            '• Dubai Municipality — Construction Work Safety Guide / Safety Guide for Construction Works\n'
            '• Dubai Municipality — Health & Safety Technical Guidelines\n'
            '• Dubai Municipality Technical Guideline No. 137 — Health and Safety Risk Assessment\n'
            '• Applicable project permits, approvals, specifications and HSE requirements',
            style: TextStyle(height: 1.55, fontSize: 13),
          ),
          SizedBox(height: 10),
          Text(
            'Important: official legal text and current authority publications take precedence over this learning summary.',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Colors.black87,
              height: 1.45,
              fontSize: 12.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _LegalSection {
  final String id;
  final String title;
  final String description;
  final List<String> points;

  const _LegalSection({
    required this.id,
    required this.title,
    required this.description,
    required this.points,
  });
}

class _AdvancedModule {
  final String id;
  final String title;
  final String content;

  const _AdvancedModule({
    required this.id,
    required this.title,
    required this.content,
  });
}

const List<_LegalSection> _legalSections = [
  _LegalSection(
    id: '01',
    title: 'Legal & Regulatory Compliance — Introduction',
    description: 'Understand what legal compliance means on a Dubai construction project, why requirements must be identified before work starts, and how an HSE professional converts legal requirements into practical site controls.',
    points: [
      'Identify the authorities and legal instruments applicable to the project.',
      'Maintain a current legal and regulatory register.',
      'Translate applicable requirements into project procedures, RAMS, permits, inspections and training.',
      'Verify implementation in the field and retain objective evidence.'
    ],
  ),
  _LegalSection(
    id: '02',
    title: 'Legal Hierarchy & Applicability',
    description: 'Differentiate laws, decrees, administrative resolutions, technical guidelines, circulars, codes, project specifications and internal procedures. Apply the requirement that is actually relevant to the activity, location and project scope.',
    points: [
      'Confirm jurisdiction and activity scope before applying a requirement.',
      'Check effective dates and superseded versions.',
      'Distinguish mandatory legal requirements from guidance and internal standards.',
      'Escalate conflicts or uncertainty to competent management/legal/compliance support.'
    ],
  ),
  _LegalSection(
    id: '03',
    title: 'Dubai Construction Safety Framework',
    description: 'Use the Dubai construction safety framework as the principal reference context for construction activities, while checking the current official Dubai Municipality publications and project-specific requirements.',
    points: [
      'Identify the current construction safety legislation and approved guide.',
      'Map project activities to relevant safety requirements.',
      'Include construction safety obligations in project planning.',
      'Keep evidence that requirements have been communicated and implemented.'
    ],
  ),
  _LegalSection(
    id: '04',
    title: 'Decree No. (19) of 2025 — Safety in Construction Work',
    description: 'Treat the current Dubai construction-safety legislation as a primary legal reference and verify its current official publication before relying on detailed provisions.',
    points: [
      'Identify duties relevant to the project parties.',
      'Check project arrangements against the current decree and implementing requirements.',
      'Do not rely on an uncontrolled summary when a legal decision is required.',
      'Record compliance actions and responsible persons.'
    ],
  ),
  _LegalSection(
    id: '05',
    title: 'Administrative Resolution No. (112) of 2026',
    description: 'Recognize the Dubai Municipality administrative resolution approving the Safety Guide for Construction Works in the Emirate of Dubai and use the current official guide as a practical construction-safety reference.',
    points: [
      'Confirm the approved guide/version in the official source.',
      'Map guide requirements to project controls.',
      'Train relevant personnel on applicable requirements.',
      'Review the register when the guide or related requirements are updated.'
    ],
  ),
  _LegalSection(
    id: '06',
    title: 'Legal Register',
    description: 'Build and maintain a controlled register showing each applicable requirement, source, subject, responsible owner, project procedure, evidence and review status.',
    points: [
      'Use unique register references.',
      'Record issue/revision/effective information.',
      'Assign an accountable owner for each requirement.',
      'Link requirements to procedures, inspections, permits or records.',
      'Review periodically and after regulatory changes.'
    ],
  ),
  _LegalSection(
    id: '07',
    title: 'Regulatory Monitoring & Updates',
    description: 'Compliance is continuous. Monitor official authority publications, project instructions and approved changes rather than assuming an old register remains current.',
    points: [
      'Define a regulatory-monitoring responsibility.',
      'Check official authority updates at planned intervals.',
      'Assess whether each change affects the project.',
      'Document impact assessment and implementation.',
      'Brief affected teams after significant changes.'
    ],
  ),
  _LegalSection(
    id: '08',
    title: 'Permits, Approvals & NOCs',
    description: 'Understand the relationship between legal compliance, project approvals, permits, no-objection requirements and work-front authorization.',
    points: [
      'Verify required approvals before controlled activities start.',
      'Check validity, scope, location and conditions.',
      'Do not treat a permit as a substitute for risk assessment or supervision.',
      'Retain approval evidence and close conditions before work proceeds.'
    ],
  ),
  _LegalSection(
    id: '09',
    title: 'Contractor & Subcontractor Compliance',
    description: 'Control legal compliance across the contractor chain. Prequalification, contract requirements, competency, supervision and verification must be connected.',
    points: [
      'Define compliance duties in contracts and scope documents.',
      'Evaluate subcontractor legal registers where relevant.',
      'Verify licenses, competencies and required approvals.',
      'Audit implementation rather than relying only on submitted documents.',
      'Track and close subcontractor nonconformities.'
    ],
  ),
  _LegalSection(
    id: '10',
    title: 'Competent Persons & Professional Duties',
    description: 'Identify when competent, authorized or suitably qualified persons are required and verify that assigned personnel match the work and legal/project requirements.',
    points: [
      'Define competency criteria for safety-critical tasks.',
      'Verify qualifications, authorization and experience.',
      'Control expired or unsuitable credentials.',
      'Maintain a competency matrix and supporting evidence.'
    ],
  ),
  _LegalSection(
    id: '11',
    title: 'Risk Assessment as a Compliance Tool',
    description: 'Use risk assessment to demonstrate that hazards have been identified and appropriate controls selected. Legal requirements should inform the risk-control process, not sit separately from it.',
    points: [
      'Identify legal controls during hazard identification.',
      'Use the hierarchy of controls.',
      'Review assessments when work, plant, people or conditions change.',
      'Communicate significant controls to affected workers.',
      'Retain approved assessments and review records.'
    ],
  ),
  _LegalSection(
    id: '12',
    title: 'RAMS & Safe Work Procedures',
    description: 'Convert applicable requirements into method statements, risk assessments and safe work procedures that workers can actually follow.',
    points: [
      'Reference applicable requirements in RAMS where appropriate.',
      'Define responsibilities and hold points.',
      'Specify inspection and verification requirements.',
      'Brief workers before the task.',
      'Control revisions so obsolete RAMS are not used.'
    ],
  ),
  _LegalSection(
    id: '13',
    title: 'Permit to Work & Legal Controls',
    description: 'Use permit systems for defined high-risk activities where required by the project or applicable rules, with clear conditions, authorization, isolation and close-out.',
    points: [
      'Identify activities requiring permits.',
      'Verify prerequisites before authorization.',
      'Check isolations and simultaneous operations.',
      'Suspend permits when conditions change.',
      'Close permits and restore the area safely.'
    ],
  ),
  _LegalSection(
    id: '14',
    title: 'Inspection, Monitoring & Compliance Verification',
    description: 'Compliance must be tested in the field. Combine planned inspections, task observations, document checks and management verification.',
    points: [
      'Use inspection criteria linked to applicable requirements.',
      'Record objective findings.',
      'Classify nonconformities consistently.',
      'Assign corrective actions with owners and due dates.',
      'Verify effectiveness after closure.'
    ],
  ),
  _LegalSection(
    id: '15',
    title: 'Audit & Compliance Assessment',
    description: 'Audits test whether the management system and field controls are implemented and effective. They should sample evidence, interview people and inspect conditions.',
    points: [
      'Prepare audit criteria from controlled requirements.',
      'Sample records and work fronts.',
      'Interview workers and supervisors.',
      'Record evidence and findings.',
      'Track corrective and preventive actions.'
    ],
  ),
  _LegalSection(
    id: '16',
    title: 'Incident, Near-Miss & Legal Reporting',
    description: 'Understand that incidents may trigger internal escalation and external reporting obligations depending on the event, jurisdiction and applicable requirements.',
    points: [
      'Define incident classification and escalation.',
      'Preserve evidence after serious events.',
      'Check reporting obligations promptly.',
      'Investigate root and contributing causes.',
      'Track corrective actions and lessons learned.'
    ],
  ),
  _LegalSection(
    id: '17',
    title: 'Occupational Health & Worker Welfare',
    description: 'Legal compliance includes health protection and welfare arrangements, not only physical construction hazards.',
    points: [
      'Identify applicable occupational-health requirements.',
      'Provide suitable welfare facilities.',
      'Address heat stress and occupational exposure where applicable.',
      'Maintain health-related records with appropriate confidentiality.',
      'Verify welfare conditions through inspections.'
    ],
  ),
  _LegalSection(
    id: '18',
    title: 'Environmental & Public Safety Interfaces',
    description: 'Construction compliance can overlap with environmental, public safety, traffic, nuisance and community-protection requirements.',
    points: [
      'Identify public-interface risks.',
      'Control access, hoarding, lighting and site security as applicable.',
      'Control dust, noise, waste and spill risks according to applicable requirements.',
      'Coordinate with environmental and project controls.'
    ],
  ),
  _LegalSection(
    id: '19',
    title: 'Document & Record Control',
    description: 'Legal compliance is difficult to demonstrate when records are uncontrolled. Maintain current documents and traceable evidence.',
    points: [
      'Control document revision and approval.',
      'Prevent obsolete documents at work fronts.',
      'Maintain inspection, training, permit and corrective-action records.',
      'Define retention and access requirements.',
      'Protect records from unauthorized alteration.'
    ],
  ),
  _LegalSection(
    id: '20',
    title: 'Evidence of Compliance',
    description: 'A strong compliance system can show objective evidence: approved documents, inspections, photographs, training records, permits, certificates, audits and closure verification.',
    points: [
      'Link evidence to a requirement or control.',
      'Use dated and identifiable records.',
      'Avoid unsupported tick-box compliance.',
      'Verify authenticity and completeness.',
      'Make evidence retrievable for audit or inspection.'
    ],
  ),
  _LegalSection(
    id: '21',
    title: 'Non-Compliance & Corrective Action',
    description: 'Respond proportionately to non-compliance. Immediate risk control comes first, followed by root-cause correction and verification.',
    points: [
      'Make unsafe conditions safe immediately.',
      'Determine whether work must be stopped.',
      'Assign corrective action ownership.',
      'Identify systemic causes where appropriate.',
      'Verify closure in the field.'
    ],
  ),
  _LegalSection(
    id: '22',
    title: 'Stop-Work & Escalation',
    description: 'Legal or serious safety non-compliance may require escalation and suspension of work. Stop-work authority should be understood before an emergency occurs.',
    points: [
      'Define stop-work triggers in project procedures.',
      'Escalate serious or repeated non-compliance.',
      'Protect people before preserving production.',
      'Document the reason for suspension.',
      'Restart only after controls are verified.'
    ],
  ),
  _LegalSection(
    id: '23',
    title: 'Management of Change',
    description: 'Regulatory changes, design changes, new equipment, new contractors, changed sequencing or changed site conditions can alter compliance requirements.',
    points: [
      'Identify changes early.',
      'Assess legal and HSE impacts.',
      'Update RAMS, permits and training.',
      'Communicate changes before affected work resumes.',
      'Verify implementation.'
    ],
  ),
  _LegalSection(
    id: '24',
    title: 'Simultaneous Operations & Interface Compliance',
    description: 'Multiple contractors and work fronts can create conflicting requirements and controls. Interface management is therefore a compliance issue as well as an operational issue.',
    points: [
      'Identify overlapping work activities.',
      'Coordinate permits and isolations.',
      'Control access and exclusion zones.',
      'Define interface responsibilities.',
      'Review changing conditions during coordination meetings.'
    ],
  ),
  _LegalSection(
    id: '25',
    title: 'Regulatory Compliance Training',
    description: 'Workers and supervisors need practical understanding of the requirements that affect their tasks. Training should be role-specific and verifiable.',
    points: [
      'Create role-based training requirements.',
      'Include legal and site rules in induction.',
      'Use toolbox talks for task-specific controls.',
      'Verify understanding through questions or practical checks.',
      'Track attendance and competency evidence.'
    ],
  ),
  _LegalSection(
    id: '26',
    title: 'Compliance KPIs & Performance',
    description: 'Measure whether compliance controls are functioning. Avoid relying only on injury statistics; include leading indicators.',
    points: [
      'Track inspection completion and overdue actions.',
      'Monitor audit findings and repeat findings.',
      'Track training/competency status.',
      'Monitor permit and RAMS verification.',
      'Analyze recurring non-compliance trends.'
    ],
  ),
  _LegalSection(
    id: '27',
    title: 'Common Regulatory Compliance Failures',
    description: 'Recognize weak practices such as outdated legal registers, copied RAMS, missing evidence, expired certificates, unverified subcontractor documents and closing actions without field verification.',
    points: [
      'Test documents against actual site conditions.',
      'Check revision status.',
      'Sample records rather than accepting summaries.',
      'Investigate repeated findings.',
      'Escalate deliberate or serious non-compliance.'
    ],
  ),
  _LegalSection(
    id: '28',
    title: 'Practical Construction-Site Scenarios',
    description: 'Apply compliance thinking to real work fronts: excavation, lifting, scaffolding, work at height, hot work, temporary works and public interfaces.',
    points: [
      'Identify the applicable requirements.',
      'Check approvals, RAMS and permits.',
      'Verify competent persons and equipment.',
      'Inspect physical controls.',
      'Document and close findings.'
    ],
  ),
  _LegalSection(
    id: '29',
    title: 'HSE Officer Compliance Verification',
    description: 'Use a repeatable field routine to confirm legal requirements are implemented, evidenced and understood by the people doing the work.',
    points: [
      'Review current legal register and project controls.',
      'Select critical requirements for the day\'s activities.',
      'Inspect work fronts.',
      'Interview workers and supervisors.',
      'Record evidence and corrective actions.'
    ],
  ),
  _LegalSection(
    id: '30',
    title: 'Quick Reference & Professional Questions',
    description: 'Use this section for final revision, field reference and interview preparation.',
    points: [
      'What is the difference between law, regulation, guideline and internal procedure?',
      'How do you maintain a legal register?',
      'How do you verify a subcontractor\'s compliance?',
      'When would you escalate or stop work?',
      'How do you prove a requirement was implemented?'
    ],
  ),
];

const List<_AdvancedModule> _advancedModules = [
  _AdvancedModule(
    id: 'A1',
    title: 'Regulatory Intelligence',
    content: 'Build a controlled process for identifying new laws, decrees, administrative resolutions, technical guidelines and authority publications. Every update should be screened for applicability, impact and implementation ownership.',
  ),
  _AdvancedModule(
    id: 'A2',
    title: 'Requirement-to-Control Mapping',
    content: 'Create a compliance matrix linking each requirement to a procedure, RAMS, permit, inspection criterion, training requirement and objective evidence. This turns a legal register into an operational control system.',
  ),
  _AdvancedModule(
    id: 'A3',
    title: 'Compliance Assurance Model',
    content: 'Use three levels of assurance: document review, field verification and effectiveness verification. A signed document alone is not sufficient evidence that the control works.',
  ),
  _AdvancedModule(
    id: 'A4',
    title: 'Legal Change Management',
    content: 'When an official requirement changes, assess affected activities, contracts, drawings, RAMS, permits, training, inspections, emergency arrangements and records. Record the decision and implementation evidence.',
  ),
  _AdvancedModule(
    id: 'A5',
    title: 'Contractor Compliance Assurance',
    content: 'Use prequalification, onboarding, document verification, field audits, competency checks, performance reviews and corrective-action tracking as one connected assurance cycle.',
  ),
  _AdvancedModule(
    id: 'A6',
    title: 'Audit Evidence Strategy',
    content: 'For every major requirement ask: What is the requirement? Where is it controlled? Who owns it? What evidence proves implementation? How was effectiveness checked?',
  ),
  _AdvancedModule(
    id: 'A7',
    title: 'High-Risk Work Legal Interface',
    content: 'For high-risk work, combine legal requirements with risk assessment, method statement, permit, competent-person verification, equipment certification, supervision and emergency arrangements.',
  ),
  _AdvancedModule(
    id: 'A8',
    title: 'Regulatory Non-Conformance Analysis',
    content: 'Separate immediate unsafe conditions from system failures. A repeated finding often indicates weaknesses in supervision, competency, planning, procurement, contractor control or management review.',
  ),
  _AdvancedModule(
    id: 'A9',
    title: 'Dubai Authority Reference Discipline',
    content: 'Use current official Dubai Municipality sources for legal and technical references. Where a legal interpretation is uncertain, escalate rather than presenting an uncontrolled interpretation as law.',
  ),
  _AdvancedModule(
    id: 'A10',
    title: 'Compliance Dashboard',
    content: 'A professional dashboard can show open legal actions, overdue actions, audit findings, repeat findings, training gaps, expired certificates, permit deviations and regulatory changes awaiting implementation.',
  ),
  _AdvancedModule(
    id: 'A11',
    title: 'Professional HSE Interview Learning',
    content: 'Be prepared to explain how you identify applicable legislation, maintain a legal register, verify compliance, manage regulatory change, audit contractors and demonstrate objective evidence.',
  ),
  _AdvancedModule(
    id: 'A12',
    title: 'Field Master Check',
    content: 'Before accepting a work front, verify: current requirements, approved RAMS, competent people, permits/approvals, equipment status, physical controls, emergency arrangements, worker understanding and evidence.',
  ),
];
