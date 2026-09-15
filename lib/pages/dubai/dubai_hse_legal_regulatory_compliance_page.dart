import 'package:flutter/material.dart';

/// SafeNexus HSE — Topic 04
/// Legal & Regulatory Compliance
///
/// Complete single-file topic module:
/// Main Page + topic-specific Advanced Learning + detailed sections.
///
/// Suggested topic id for router integration:
/// dubai_legal_regulatory_compliance
///
/// Important: this is a learning/reference module. Current official legal text,
/// authority publications, permits, project procedures and competent technical
/// instructions take precedence for actual compliance decisions.

class DubaiHseLegalRegulatoryCompliancePage extends StatelessWidget {
  const DubaiHseLegalRegulatoryCompliancePage({super.key});

  static const Color green = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color navy = Color(0xFF17324D);
  static const Color background = Color(0xFFF5F8F7);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: const Text('Legal & Regulatory Compliance'),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
        children: [
          _hero(),
          const SizedBox(height: 16),
          _advancedCard(context),
          const SizedBox(height: 16),
          _noticeCard(),
          const SizedBox(height: 20),
          const Text('Complete Topic', style: TextStyle(color: navy, fontSize: 21, fontWeight: FontWeight.w800)),
          const SizedBox(height: 5),
          const Text('Every section is specific to Legal & Regulatory Compliance.', style: TextStyle(color: Colors.black54, fontSize: 12.5)),
          const SizedBox(height: 12),
          ..._legalSections.map((s) => _sectionCard(context, s)),
          const SizedBox(height: 14),
          _referenceCard(),
        ],
      ),
    );
  }

  Widget _hero() => Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: const LinearGradient(colors: [darkGreen, green], begin: Alignment.topLeft, end: Alignment.bottomRight),
      borderRadius: BorderRadius.circular(22),
    ),
    child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        CircleAvatar(backgroundColor: Colors.white24, radius: 26, child: Icon(Icons.gavel_rounded, color: Colors.white, size: 29)),
        SizedBox(width: 12),
        Expanded(child: Text('LEGAL & REGULATORY COMPLIANCE', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800))),
      ]),
      SizedBox(height: 15),
      Text('Dubai Construction HSE Reference', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700)),
      SizedBox(height: 6),
      Text('Identify requirements → convert them into controls → verify implementation → maintain evidence.', style: TextStyle(color: Colors.white70, height: 1.45, fontSize: 13.5)),
    ]),
  );

  Widget _advancedCard(BuildContext context) => InkWell(
    borderRadius: BorderRadius.circular(20),
    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const DubaiHseLegalRegulatoryAdvancedLearningPage())),
    child: Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [darkGreen, green], begin: Alignment.centerLeft, end: Alignment.centerRight),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.10), blurRadius: 12, offset: const Offset(0, 5))],
      ),
      child: const Row(children: [
        CircleAvatar(radius: 27, backgroundColor: Colors.white, child: Icon(Icons.menu_book_rounded, color: darkGreen, size: 30)),
        SizedBox(width: 14),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('📚 Advanced Learning', style: TextStyle(color: Colors.white, fontSize: 19, fontWeight: FontWeight.w800)),
          SizedBox(height: 5),
          Text('Detailed legal study, compliance assurance, audit evidence and field reference', style: TextStyle(color: Colors.white70, height: 1.35, fontSize: 13)),
        ])),
        Icon(Icons.chevron_right_rounded, color: Colors.white, size: 32),
      ]),
    ),
  );

  Widget _noticeCard() => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(color: const Color(0xFFF1F5EF), borderRadius: BorderRadius.circular(18), border: Border.all(color: Colors.grey.shade300)),
    child: const Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Icon(Icons.info_outline_rounded, color: darkGreen, size: 28),
      SizedBox(width: 12),
      Expanded(child: Text('Learning and field-reference aid. For actual compliance decisions, always follow current applicable Dubai/UAE requirements, official authority publications, approved project procedures, RAMS, permits and competent technical instructions.', style: TextStyle(height: 1.5, fontSize: 13.5))),
    ]),
  );

  Widget _sectionCard(BuildContext context, _LegalSection s) => Card(
    elevation: 0,
    margin: const EdgeInsets.only(bottom: 10),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17), side: BorderSide(color: Colors.grey.shade200)),
    child: InkWell(
      borderRadius: BorderRadius.circular(17),
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DubaiHseLegalRegulatoryDetailPage(section: s))),
      child: Padding(padding: const EdgeInsets.all(15), child: Row(children: [
        Container(width: 44, height: 44, alignment: Alignment.center, decoration: BoxDecoration(color: green.withValues(alpha: .10), borderRadius: BorderRadius.circular(13)), child: Text(s.id, style: const TextStyle(color: darkGreen, fontWeight: FontWeight.w800, fontSize: 12))),
        const SizedBox(width: 13),
        Expanded(child: Text(s.title, style: const TextStyle(color: navy, fontWeight: FontWeight.w700, fontSize: 14.5))),
        const Icon(Icons.chevron_right_rounded, color: Colors.black45),
      ])),
    ),
  );

  Widget _referenceCard() => Container(
    padding: const EdgeInsets.all(17),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18), border: Border.all(color: Colors.grey.shade200)),
    child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Reference Sources to Verify', style: TextStyle(color: navy, fontSize: 16, fontWeight: FontWeight.w800)),
      SizedBox(height: 9),
      Text('''• Dubai Municipality — Laws and Legislations
• Dubai Municipality — Planning and Construction / Technical Guidelines
• Dubai Decree No. (19) of 2025 Concerning Safety in Construction Works
• Dubai Municipality Administrative Resolution No. (112) of 2026 approving the Safety Guide for Construction Works in the Emirate of Dubai
• Safety Guide for Construction Works in the Emirate of Dubai
• Dubai Municipality Health & Safety Technical Guidelines
• Applicable project permits, approvals, specifications and HSE procedures''', style: TextStyle(height: 1.55, fontSize: 13)),
      SizedBox(height: 10),
      Text('Always verify the current official publication and exact applicability before making a legal/compliance decision.', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12.5, height: 1.45)),
    ]),
  );
}

class DubaiHseLegalRegulatoryComplianceDetailPage extends StatelessWidget {
  final _LegalSection section;
  const DubaiHseLegalRegulatoryComplianceDetailPage({super.key, required this.section});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(section.title), backgroundColor: const Color(0xFF0B5D4B), foregroundColor: Colors.white),
    body: ListView(padding: const EdgeInsets.fromLTRB(18, 18, 18, 32), children: [
      Container(padding: const EdgeInsets.all(18), decoration: BoxDecoration(color: const Color(0xFFEAF6F0), borderRadius: BorderRadius.circular(18)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Section ${section.id}', style: const TextStyle(color: Color(0xFF0B5D4B), fontWeight: FontWeight.w800)),
        const SizedBox(height: 8),
        Text(section.overview, style: const TextStyle(fontSize: 14, height: 1.55)),
      ])),
      const SizedBox(height: 18),
      const Text('Field Application', style: TextStyle(color: Color(0xFF17324D), fontSize: 18, fontWeight: FontWeight.w800)),
      const SizedBox(height: 8),
      Text(section.detail, style: const TextStyle(fontSize: 13.5, height: 1.55)),
      const SizedBox(height: 16),
      Container(padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: Colors.amber.withValues(alpha: .10), borderRadius: BorderRadius.circular(14), border: Border.all(color: Colors.amber.withValues(alpha: .25))), child: const Text('HSE field note: confirm the current official requirement, project scope and approved controls before treating a compliance point as applicable.', style: TextStyle(fontSize: 12.5, height: 1.45))),
    ]),
  );
}

class DubaiHseLegalRegulatoryAdvancedLearningPage extends StatelessWidget {
  const DubaiHseLegalRegulatoryAdvancedLearningPage({super.key});

  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color navy = Color(0xFF17324D);

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Advanced Learning'), backgroundColor: darkGreen, foregroundColor: Colors.white),
    body: ListView(padding: const EdgeInsets.fromLTRB(16, 16, 16, 32), children: [
      Container(padding: const EdgeInsets.all(18), decoration: BoxDecoration(gradient: const LinearGradient(colors: [darkGreen, Color(0xFF159447)]), borderRadius: BorderRadius.circular(20)), child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('📚 LEGAL & REGULATORY — ADVANCED STUDY', style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w800)),
        SizedBox(height: 8),
        Text('This Advanced Learning module is specifically for Legal & Regulatory Compliance. It expands the topic into study, field assurance, audit and professional reference content.', style: TextStyle(color: Colors.white70, height: 1.5, fontSize: 13)),
      ])),
      const SizedBox(height: 16),
      ..._advancedModules.map((m) => _moduleCard(m)),
      const SizedBox(height: 10),
      _masterChecklist(),
      const SizedBox(height: 16),
      _professionalQuestions(),
      const SizedBox(height: 16),
      _referenceCard(),
    ]),
  );

  Widget _moduleCard(_AdvancedModule m) => Card(elevation: 0, margin: const EdgeInsets.only(bottom: 11), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(17), side: BorderSide(color: Colors.grey.shade200)), child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text('${m.id}  ${m.title}', style: const TextStyle(color: navy, fontSize: 15.5, fontWeight: FontWeight.w800)),
    const SizedBox(height: 11),
    ...m.points.map((p) => Padding(padding: const EdgeInsets.only(bottom: 9), child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [const Padding(padding: EdgeInsets.only(top: 3), child: Icon(Icons.check_circle_rounded, size: 18, color: Color(0xFF159447))), const SizedBox(width: 8), Expanded(child: Text(p, style: const TextStyle(fontSize: 13.2, height: 1.45)))]))),
  ])));

  Widget _masterChecklist() {
    const items=['Identify current official sources','Confirm applicability and effective status','Map each requirement to an operational control','Verify approvals / permits / competency','Check current RAMS and procedures','Perform field verification','Interview workers and supervisors','Capture objective evidence','Control and track non-compliance','Verify corrective-action effectiveness','Review regulatory changes','Retain traceable records'];
    return Container(padding: const EdgeInsets.all(17), decoration: BoxDecoration(color: const Color(0xFFEAF6F0), borderRadius: BorderRadius.circular(18)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('Legal Compliance Master Checklist', style: TextStyle(color: navy, fontSize: 16, fontWeight: FontWeight.w800)), const SizedBox(height: 10), ...items.map((x)=>Padding(padding: const EdgeInsets.only(bottom: 8), child: Row(children:[const Icon(Icons.verified_rounded,size:18,color:darkGreen),const SizedBox(width:8),Expanded(child:Text(x,style:const TextStyle(fontSize:13)))])))]));
  }

  Widget _professionalQuestions() => Container(padding: const EdgeInsets.all(17), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18), border: Border.all(color: Colors.grey.shade200)), child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text('Professional / Interview Questions', style: TextStyle(color: navy, fontSize: 16, fontWeight: FontWeight.w800)),
    SizedBox(height: 10),
    Text('''1. How do you identify applicable legislation for a project?
2. How do you maintain a legal register?
3. How do you verify that a regulation is current?
4. How do you convert a legal requirement into a site control?
5. How do you audit contractor compliance?
6. What evidence demonstrates implementation?
7. How do you manage a regulatory change?
8. When would you escalate or stop work?
9. How do you handle repeated non-compliance?
10. How do you verify corrective-action effectiveness?''', style: TextStyle(fontSize: 13, height: 1.55)),
  ]);

  Widget _referenceCard() => Container(padding: const EdgeInsets.all(17), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18), border: Border.all(color: Colors.grey.shade200)), child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text('Advanced Reference Sources', style: TextStyle(color: navy, fontSize: 16, fontWeight: FontWeight.w800)),
    SizedBox(height: 9),
    Text('Dubai Municipality Laws and Legislations; Dubai Municipality Planning and Construction resources; Safety Guide for Construction Works in the Emirate of Dubai; Dubai Decree No. (19) of 2025 Concerning Safety in Construction Works; Administrative Resolution No. (112) of 2026 approving the Safety Guide for Construction Works; Dubai Municipality Health & Safety Technical Guidelines; applicable project documents.', style: TextStyle(fontSize: 13, height: 1.55)),
    SizedBox(height: 9),
    Text('Reference rule: official current publications and approved project requirements take precedence.', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12.5)),
  ]);
}

class _LegalSection {
  final String id; final String title; final String overview; final String detail;
  const _LegalSection({required this.id, required this.title, required this.overview, required this.detail});
}

class _AdvancedModule {
  final String id; final String title; final List<String> points;
  const _AdvancedModule({required this.id, required this.title, required this.points});
}

const List<_LegalSection> _legalSections = [
  const _LegalSection(
    id: '01',
    title: 'Legal & Regulatory Compliance — Introduction',
    overview: 'Legal compliance means identifying every requirement that applies to the project, translating it into controls, implementing those controls and retaining objective evidence.',
    detail: 'Start with jurisdiction, project scope and activity. Identify the authority/source. Confirm the current version. Map the requirement to project controls. Verify implementation in the field. Record evidence and review changes.',
  ),
  const _LegalSection(
    id: '02',
    title: 'Legal Hierarchy & Applicability',
    overview: 'A professional HSE officer must distinguish mandatory legislation from administrative requirements, technical guidance, project specifications and internal procedures. Applicability must be demonstrated, not assumed.',
    detail: 'Confirm which requirement applies to the activity, location, client and project. Check effective status and revision. Where requirements overlap, use the applicable and more stringent project/legal control where required by the project, and escalate uncertainty rather than guessing.',
  ),
  const _LegalSection(
    id: '03',
    title: 'Dubai Construction Safety Framework',
    overview: 'Use the current Dubai Municipality construction-safety framework as the principal Dubai reference context for construction work. The project must also consider applicable permits, approvals, specifications and other authority requirements.',
    detail: 'Maintain a controlled reference set. Identify which construction activities are covered. Map requirements into HSE plans, RAMS, permits, inspections, training and emergency arrangements.',
  ),
  const _LegalSection(
    id: '04',
    title: 'Dubai Decree No. (19) of 2025 — Safety in Construction Work',
    overview: 'The current Dubai legal framework includes Decree No. (19) of 2025 Concerning Safety in Construction Works. The official legal text should always be checked for the exact duty, scope and effective provisions.',
    detail: 'Record the decree in the legal register when applicable. Identify duties affecting the project parties. Review project arrangements against current official requirements. Never treat an uncontrolled summary as a substitute for the official legal text.',
  ),
  const _LegalSection(
    id: '05',
    title: 'Administrative Resolution No. (112) of 2026',
    overview: 'The project reference set identifies Administrative Resolution No. (112) of 2026 approving the Safety Guide for Construction Works in the Emirate of Dubai. Use the current official publication and approved guide for detailed application.',
    detail: 'Confirm the current approved guide/version. Map relevant guide requirements to site controls. Communicate applicable requirements. Reassess when the guide or associated requirements change.',
  ),
  const _LegalSection(
    id: '06',
    title: 'Legal & Regulatory Register',
    overview: 'A legal register is a controlled list of applicable requirements with source, subject, revision/effective information, owner, project control, evidence and status.',
    detail: 'Give each entry a unique reference. Record applicability. Link each requirement to procedures, RAMS, permits, inspections or training. Assign an owner. Review the register on a defined schedule and after regulatory change.',
  ),
  const _LegalSection(
    id: '07',
    title: 'Regulatory Monitoring & Change Updates',
    overview: 'Compliance is continuous. A requirement that was correct last year may be superseded, amended or supplemented. Monitoring must therefore be planned and documented.',
    detail: 'Monitor official authority publications. Screen changes for applicability. Record impact assessment. Update affected documents and training. Communicate changes before affected work continues.',
  ),
  const _LegalSection(
    id: '08',
    title: 'Permits, Approvals & NOCs',
    overview: 'Legal compliance can depend on project permits, approvals, authority conditions and NOCs. These are controls with defined scope and conditions, not administrative paperwork only.',
    detail: 'Verify validity, location, activity, dates and conditions. Check prerequisites. Keep evidence. Do not allow permit possession to replace risk assessment, RAMS or supervision.',
  ),
  const _LegalSection(
    id: '09',
    title: 'Contractor & Subcontractor Compliance',
    overview: 'The main contractor remains responsible for controlling the HSE performance of its work interfaces. Subcontractor compliance must be checked through qualification, onboarding, documentation, field verification and corrective action.',
    detail: 'Define requirements in contracts. Verify licenses, competencies and approvals. Review subcontractor RAMS. Audit work fronts. Track findings and repeated non-compliance.',
  ),
  const _LegalSection(
    id: '10',
    title: 'Competent Persons & Professional Duties',
    overview: 'Safety-critical activities require suitably competent and, where applicable, authorised personnel. Competence includes knowledge, skill, experience and task-specific suitability.',
    detail: 'Define competency criteria. Verify certificates and authorisations. Maintain a competency matrix. Prevent expired or unsuitable credentials from being used. Verify actual competence in the field.',
  ),
  const _LegalSection(
    id: '11',
    title: 'Risk Assessment as a Compliance Tool',
    overview: 'Risk assessment converts hazards and legal requirements into practical controls. Legal requirements should be considered during hazard identification and control selection.',
    detail: 'Identify legal controls. Apply the hierarchy of controls. Assess residual risk. Review after change, incident, new equipment, altered sequence or changed conditions. Communicate critical controls.',
  ),
  const _LegalSection(
    id: '12',
    title: 'RAMS & Safe Work Procedures',
    overview: 'RAMS should convert requirements into a safe sequence of work, responsibilities, controls, hold points, emergency arrangements and verification requirements.',
    detail: 'Reference applicable requirements. Make controls task-specific. Brief affected workers. Control revisions. Verify the RAMS against the actual work front before accepting work.',
  ),
  const _LegalSection(
    id: '13',
    title: 'Permit to Work & Legal Controls',
    overview: 'Permit systems provide controlled authorisation for defined high-risk work where required by the project or applicable requirements. A permit is one layer of control, not the whole risk-control system.',
    detail: 'Verify prerequisites, isolations, competent persons and site conditions. Control simultaneous operations. Suspend when conditions change. Close the permit only after safe completion and restoration.',
  ),
  const _LegalSection(
    id: '14',
    title: 'Inspection, Monitoring & Compliance Verification',
    overview: 'Compliance must be tested where work happens. Document review without field verification can miss unsafe conditions or ineffective controls.',
    detail: 'Use inspection criteria linked to requirements. Record objective findings. Classify findings. Assign owners and due dates. Verify effectiveness after corrective action.',
  ),
  const _LegalSection(
    id: '15',
    title: 'Audit & Compliance Assessment',
    overview: 'Audits evaluate whether requirements are documented, implemented and effective. A strong audit samples records, interviews people and observes actual work.',
    detail: 'Define audit criteria. Sample high-risk activities and records. Interview workers and supervisors. Record evidence and findings. Track root causes and closure.',
  ),
  const _LegalSection(
    id: '16',
    title: 'Incident, Near-Miss & Reporting Duties',
    overview: 'Incidents and near misses can reveal regulatory non-compliance and may create internal or external escalation/reporting duties depending on the event and applicable requirements.',
    detail: 'Use a clear incident classification system. Escalate serious events promptly. Preserve evidence. Check reporting obligations. Investigate causes and verify corrective actions.',
  ),
  const _LegalSection(
    id: '17',
    title: 'Occupational Health & Worker Welfare',
    overview: 'Regulatory compliance includes occupational health, welfare, heat-stress controls, exposure management and suitable welfare arrangements where applicable.',
    detail: 'Identify applicable health requirements. Provide suitable welfare facilities. Monitor heat stress and occupational exposures where relevant. Protect confidential health information. Verify welfare conditions.',
  ),
  const _LegalSection(
    id: '18',
    title: 'Environmental & Public Safety Interfaces',
    overview: 'Construction HSE compliance can interface with environmental protection, public safety, traffic, dust, noise, waste, spills, site security and community protection requirements.',
    detail: 'Identify public-interface risks. Control access and boundaries. Manage dust/noise/waste/spills according to applicable requirements. Coordinate HSE and environmental controls.',
  ),
  const _LegalSection(
    id: '19',
    title: 'Document & Record Control',
    overview: 'Compliance is difficult to demonstrate when documents are uncontrolled. Current approved documents and traceable records must be available at the point of use.',
    detail: 'Control approval and revision. Prevent obsolete copies. Retain inspection, training, permit, audit and corrective-action evidence. Define access and retention requirements.',
  ),
  const _LegalSection(
    id: '20',
    title: 'Objective Evidence of Compliance',
    overview: 'Evidence should show that a requirement was understood, implemented and verified. Strong evidence is traceable, dated, identifiable and relevant to the control.',
    detail: 'Link evidence to requirements. Use approved records. Check completeness and authenticity. Avoid unsupported tick-box compliance. Make evidence retrievable for audit or authority inspection.',
  ),
  const _LegalSection(
    id: '21',
    title: 'Non-Compliance & Corrective Action',
    overview: 'A non-compliance response begins with immediate risk control and continues through cause analysis, correction and effectiveness verification.',
    detail: 'Make the unsafe condition safe. Decide whether work must stop. Assign ownership. Identify systemic causes where needed. Verify closure in the field.',
  ),
  const _LegalSection(
    id: '22',
    title: 'Stop-Work & Escalation',
    overview: 'Serious legal or safety non-compliance may require immediate escalation and suspension of work. Stop-work arrangements should be defined before an event occurs.',
    detail: 'Define triggers. Protect people first. Escalate serious/repeated breaches. Record why work was suspended. Restart only after controls are verified by authorised persons.',
  ),
  const _LegalSection(
    id: '23',
    title: 'Management of Change',
    overview: 'Changes to legislation, design, equipment, sequence, contractors, workforce or site conditions can change compliance obligations and risk controls.',
    detail: 'Identify the change. Assess legal/HSE impact. Update RAMS, permits, training and emergency arrangements. Communicate the change. Verify implementation.',
  ),
  const _LegalSection(
    id: '24',
    title: 'SIMOPS & Interface Compliance',
    overview: 'Simultaneous operations can create conflicts between permits, isolations, exclusion zones and responsibilities. Interface control is therefore a compliance assurance activity.',
    detail: 'Map overlapping work. Coordinate permits. Control access and isolations. Define interface ownership. Reassess as conditions change.',
  ),
  const _LegalSection(
    id: '25',
    title: 'Regulatory Compliance Training',
    overview: 'People need task-relevant understanding of the requirements that affect their work. Training should be role-based and evidence-based.',
    detail: 'Define training needs. Include applicable legal/site rules in induction. Use toolbox talks for task controls. Assess understanding. Track competence and refresher needs.',
  ),
  const _LegalSection(
    id: '26',
    title: 'Compliance KPIs & Performance',
    overview: 'Compliance performance should be measured with leading and lagging indicators, not injury statistics alone. Indicators should reveal control health and repeated weaknesses.',
    detail: 'Monitor inspection completion, overdue actions, repeat findings, training gaps, expired credentials, permit deviations and regulatory actions awaiting implementation.',
  ),
  const _LegalSection(
    id: '27',
    title: 'Common Regulatory Compliance Failures',
    overview: 'Typical weaknesses include outdated registers, copied RAMS, missing evidence, expired certificates, unverified subcontractor documents and closing actions without checking the field.',
    detail: 'Compare documents with site reality. Check revision status. Sample evidence. Investigate repeat findings. Escalate deliberate or serious non-compliance.',
  ),
  const _LegalSection(
    id: '28',
    title: 'Practical Construction-Site Scenarios',
    overview: 'Apply compliance thinking to excavation, lifting, scaffolding, work at height, hot work, temporary works and public interfaces.',
    detail: 'For each work front identify applicable requirements, approved controls, competent persons, permits/approvals, equipment status, physical controls and emergency arrangements.',
  ),
  const _LegalSection(
    id: '29',
    title: 'HSE Officer Compliance Verification',
    overview: 'A repeatable compliance routine helps the HSE officer move from paperwork checking to real assurance.',
    detail: 'Review the legal register. Select requirements relevant to today’s activities. Inspect work fronts. Interview workers/supervisors. Record evidence. Track and verify actions.',
  ),
  const _LegalSection(
    id: '30',
    title: 'Quick Reference & Professional Questions',
    overview: 'Use this section for revision, field reference and interview preparation.',
    detail: 'Know how to identify applicable legislation, maintain a legal register, manage changes, verify contractor compliance, audit evidence and escalate serious non-compliance.',
  ),
];

const List<_AdvancedModule> _advancedModules = [
  const _AdvancedModule(
    id: 'A1',
    title: 'Regulatory Intelligence & Source Control',
    points: [
          'Identify the exact authority and source before relying on a requirement.',
          'Keep official titles, reference numbers, issue/effective dates and revision information.',
          'Separate current requirements from superseded material.',
          'Record where the controlled copy is stored.',
          'Escalate legal interpretation questions to authorised management/legal support.'
        ],
  ),
  const _AdvancedModule(
    id: 'A2',
    title: 'Requirement-to-Control Mapping',
    points: [
          'Create a compliance matrix with requirement, applicability, project control, responsible owner and evidence.',
          'Link requirements to HSE plans, procedures, RAMS, PTW, inspections, training and emergency arrangements.',
          'Use the matrix to identify requirements that have no operational control.',
          'Use field verification to confirm that mapped controls actually exist.',
          'Review the matrix whenever a requirement or project scope changes.'
        ],
  ),
  const _AdvancedModule(
    id: 'A3',
    title: 'Three-Level Compliance Assurance',
    points: [
          'Level 1 — document assurance: current approvals, procedures, registers and records.',
          'Level 2 — field assurance: physical conditions, worker behaviour and supervision.',
          'Level 3 — effectiveness assurance: determine whether the control prevents/reduces the intended risk.',
          'Do not close a major finding only because a document was revised.',
          'Record evidence for all three levels where proportionate.'
        ],
  ),
  const _AdvancedModule(
    id: 'A4',
    title: 'Legal Change Management',
    points: [
          'Detect the official change.',
          'Screen it for project applicability.',
          'Assess affected activities, contracts, RAMS, permits, training and inspections.',
          'Assign implementation ownership and due dates.',
          'Communicate the change before affected work starts/continues.',
          'Verify implementation and close the change record.'
        ],
  ),
  const _AdvancedModule(
    id: 'A5',
    title: 'Dubai Construction Compliance Matrix',
    points: [
          'List applicable Dubai construction safety legislation and current approved guidance.',
          'Map each requirement to the project activity and responsible party.',
          'Identify related authority approvals, permits and conditions.',
          'Cross-reference project procedures and evidence.',
          'Review the matrix during HSE management review and regulatory updates.'
        ],
  ),
  const _AdvancedModule(
    id: 'A6',
    title: 'Contractor Compliance Assurance',
    points: [
          'Prequalify against defined HSE/legal criteria.',
          'Verify documents before mobilisation.',
          'Review contractor/subcontractor RAMS and competency.',
          'Conduct field audits and worker interviews.',
          'Track repeat findings and weak supervision.',
          'Use performance data in contractor review decisions.'
        ],
  ),
  const _AdvancedModule(
    id: 'A7',
    title: 'High-Risk Work Legal Interface',
    points: [
          'For high-risk work combine applicable requirements, risk assessment, RAMS, PTW where required, competent persons and supervision.',
          'Verify equipment certification/inspection where applicable.',
          'Confirm emergency and rescue arrangements.',
          'Check simultaneous-operation interfaces.',
          'Stop or escalate when critical prerequisites are absent.'
        ],
  ),
  const _AdvancedModule(
    id: 'A8',
    title: 'Audit Evidence Strategy',
    points: [
          'Ask: What is the requirement?',
          'Ask: Where is it controlled?',
          'Ask: Who owns it?',
          'Ask: What evidence proves implementation?',
          'Ask: How was effectiveness checked?',
          'Sample original/controlled evidence rather than relying on summary statements.'
        ],
  ),
  const _AdvancedModule(
    id: 'A9',
    title: 'Regulatory Non-Conformance Analysis',
    points: [
          'Immediate condition: what is unsafe now?',
          'Control failure: which required control was absent or ineffective?',
          'System cause: why did the system allow that failure?',
          'Repeat issue: has the organisation seen the same weakness before?',
          'Action: what prevents recurrence?',
          'Effectiveness: did the corrective action work?'
        ],
  ),
  const _AdvancedModule(
    id: 'A10',
    title: 'Evidence & Records Architecture',
    points: [
          'Use unique identifiers and dates.',
          'Link permits, RAMS, inspections, training and actions to the work activity.',
          'Control revisions and approvals.',
          'Keep evidence retrievable for audits and inspections.',
          'Avoid creating records that cannot demonstrate what was actually checked.'
        ],
  ),
  const _AdvancedModule(
    id: 'A11',
    title: 'Compliance Dashboard & KPIs',
    points: [
          'Legal register review completion.',
          'Regulatory changes assessed and implemented.',
          'Overdue compliance actions.',
          'Repeat audit findings.',
          'Training/competency gaps.',
          'Expired certificates or approvals.',
          'Permit/RAMS verification deviations.',
          'Field verification closure effectiveness.'
        ],
  ),
  const _AdvancedModule(
    id: 'A12',
    title: 'Management Review of Compliance',
    points: [
          'Review significant legal changes.',
          'Review major non-compliances and repeat findings.',
          'Review contractor compliance trends.',
          'Review audit results and overdue actions.',
          'Confirm resources and responsibilities.',
          'Record management decisions and follow-up actions.'
        ],
  ),
  const _AdvancedModule(
    id: 'A13',
    title: 'Field Verification Master Routine',
    points: [
          'Before work: confirm applicable requirements, RAMS, permits and competency.',
          'During work: inspect critical controls and worker understanding.',
          'After change: reassess controls.',
          'After finding: apply immediate control and corrective action.',
          'Before closure: verify the physical condition and evidence.'
        ],
  ),
  const _AdvancedModule(
    id: 'A14',
    title: 'Professional Interview & Assessment Learning',
    points: [
          'Explain law versus guidance versus internal procedure.',
          'Explain how you build a legal register.',
          'Explain how you verify applicability.',
          'Explain how you control regulatory changes.',
          'Explain how you audit contractor compliance.',
          'Explain how you demonstrate objective evidence.',
          'Explain when you would escalate or stop work.'
        ],
  ),
  const _AdvancedModule(
    id: 'A15',
    title: 'Final Legal Compliance Master Check',
    points: [
          'Current official sources identified.',
          'Applicability confirmed.',
          'Requirements mapped to controls.',
          'Approvals/permits verified.',
          'RAMS/procedures current.',
          'Competent persons verified.',
          'Field controls physically checked.',
          'Worker understanding checked.',
          'Evidence retrievable.',
          'Non-compliances controlled and closed effectively.'
        ],
  ),
];
