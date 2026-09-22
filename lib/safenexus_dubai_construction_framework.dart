import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// SafeNexus HSE — Step 156
/// Dubai Construction Safety Framework
///
/// Each topic opens advanced learning, hazards, controls, field checklist,
/// learning check and official Dubai Municipality reference.
class SafenexusDubaiConstructionFrameworkPage extends StatelessWidget {
  const SafenexusDubaiConstructionFrameworkPage({super.key});

  static const green = Color(0xFF159447);
  static const darkGreen = Color(0xFF0B5D4B);
  static const purple = Color(0xFF6A3FB5);
  static const background = Color(0xFFF5F8F6);

  static const topics = <_DubaiTopic>[
    _DubaiTopic(
      id: 'DCF-01',
      title: 'Construction Site HSE Management',
      icon: Icons.business,
      overview: 'Site HSE management coordinates people, work activities, controls, inspections, emergency arrangements and records.',
      learning: [
        'Establish site HSE responsibilities, communication and supervision.',
        'Plan work using applicable risk assessments, method statements and permits.',
        'Maintain inspection, corrective-action and close-out records.',
        'Coordinate contractors and subcontractors before simultaneous work.'
      ],
      hazards: ['Unplanned work', 'Poor supervision', 'Simultaneous-work conflict', 'Uncontrolled work-method changes'],
      controls: ['Approved risk assessment and method statement', 'Competent supervision', 'Daily inspection and action tracking', 'Management of change'],
      checklist: ['HSE responsibilities available', 'RAMS available at work area', 'Workers briefed', 'Open actions tracked'],
      quiz: 'What should be completed before a planned high-risk activity starts?',
      answer: 'Applicable risk assessment/method statement and required controls must be established and communicated.',
      reference: 'Dubai Municipality — Administrative Resolution No. (112) of 2026 approving the Safety Guide for Construction Works in the Emirate of Dubai.',
      url: 'https://www.dm.gov.ae/municipality-business/',
    ),
    _DubaiTopic(
      id: 'DCF-02',
      title: 'Site Access, Fencing & Security',
      icon: Icons.fence,
      overview: 'Construction sites need controlled boundaries, safe access/egress, security and suitable lighting.',
      learning: ['Control entry and exit through designated gates.', 'Maintain fences and access points throughout the project.', 'Provide suitable lighting and security.', 'Store materials and equipment safely.'],
      hazards: ['Unauthorised access', 'Vehicle/pedestrian conflict', 'Poor visibility', 'Unsecured materials'],
      controls: ['Secure fencing and controlled gates', 'Security and surveillance as required', 'Adequate lighting', 'Safe storage'],
      checklist: ['Fence secure', 'Gates controlled', 'Lighting adequate', 'Materials safely stored'],
      quiz: 'Why are construction-site gates important?',
      answer: 'They organise entry/exit traffic and reduce unauthorised access and interface risks.',
      reference: 'Dubai Municipality Circular No. (12-11-1) of 2023 — security, guarding, surveillance, lighting, storage and external fences.',
      url: 'https://www.dm.gov.ae/wp-content/uploads/2024/12/12-11-1.pdf',
    ),
    _DubaiTopic(
      id: 'DCF-03',
      title: 'PPE & Worker Protection',
      icon: Icons.health_and_safety,
      overview: 'PPE is a last line of defence and must be selected, used and maintained according to task hazards.',
      learning: ['Identify task hazards before selecting PPE.', 'Ensure PPE is suitable and correctly fitted.', 'Combine PPE with higher-level controls.', 'Supervisors verify PPE at the workface.'],
      hazards: ['Head injury', 'Eye/face exposure', 'Hand/foot injury', 'Hearing/respiratory exposure'],
      controls: ['Task-specific PPE', 'Pre-use inspection', 'Worker instruction', 'Engineering/administrative controls'],
      checklist: ['PPE identified', 'PPE available and serviceable', 'Workers wearing PPE', 'Damaged PPE removed'],
      quiz: 'Is PPE the only control required for a construction hazard?',
      answer: 'No. PPE should complement higher-level controls and safe work practices.',
      reference: 'Dubai Municipality Technical Guidelines List — Health & Safety guidance including PPE and construction-site resources.',
      url: 'https://www.dm.gov.ae/municipality-business/technical-guidelines-list/',
    ),
    _DubaiTopic(
      id: 'DCF-04',
      title: 'Work at Height & Falling Objects',
      icon: Icons.height,
      overview: 'Work at height requires planned access, suitable edge/fall protection and dropped-object controls.',
      learning: ['Plan exposed edges and openings.', 'Use suitable collective protection where applicable.', 'Use compatible fall protection and rescue arrangements when required.', 'Secure tools and materials.'],
      hazards: ['Falls from edges', 'Falls from ladders/platforms', 'Dropped tools', 'Delayed rescue'],
      controls: ['Edge protection', 'Fall protection where required', 'Exclusion zones', 'Rescue planning'],
      checklist: ['Edges protected', 'Access inspected', 'Fall protection suitable', 'Dropped-object controls'],
      quiz: 'What is the purpose of an exclusion zone below overhead work?',
      answer: 'To prevent people entering an area where falling objects could cause injury.',
      reference: 'Dubai Municipality construction-site and site-control resources.',
      url: 'https://www.dm.gov.ae/municipality-business/health-and-safety/construction-sites/',
    ),
    _DubaiTopic(
      id: 'DCF-05',
      title: 'Lifting Operations',
      icon: Icons.precision_manufacturing,
      overview: 'Lifting requires competent planning, suitable equipment, controlled loads and effective communication.',
      learning: ['Plan according to load, capacity, ground conditions and travel path.', 'Use competent personnel and inspected equipment.', 'Keep people away from suspended loads.', 'Use clear lifting-team communication.'],
      hazards: ['Dropped/swinging load', 'Overloading', 'Unstable ground', 'Collision'],
      controls: ['Lift plan and supervision', 'Certified/inspected equipment', 'Exclusion zone', 'Clear communication'],
      checklist: ['Lift plan available', 'Equipment inspected', 'Load/capacity confirmed', 'Exclusion zone established'],
      quiz: 'What must be confirmed before lifting a load?',
      answer: 'Load, equipment capacity, lifting arrangement, ground/site conditions and controls must be suitable.',
      reference: 'Dubai Municipality Technical Guidelines for Examination and Certification of Cranes, Hoists, Lifts and Other Lifting Equipment.',
      url: 'https://www.dm.gov.ae/wp-content/uploads/2025/02/DM-HSD-GU48-ECLA2_Technical-Guidelines-for-Examination-and-Certification-of-Cranes-Hoists-Lifts-and-Other-Lifting-Equipment_V5.pdf',
    ),
    _DubaiTopic(
      id: 'DCF-06',
      title: 'Scaffolding, Ladders & Platforms',
      icon: Icons.account_tree,
      overview: 'Temporary access systems must be suitable, properly erected, inspected and maintained.',
      learning: ['Use appropriate access equipment.', 'Competent persons should erect/modify systems.', 'Keep access ways clear.', 'Recheck after erection, modification or events affecting stability.'],
      hazards: ['Falls', 'Collapse/instability', 'Unsafe ladders', 'Falling materials'],
      controls: ['Competent erection/inspection', 'Guarding and safe access', 'Stable foundation', 'Inspection status'],
      checklist: ['Configuration suitable', 'Access safe', 'Guarding provided where required', 'Inspection current'],
      quiz: 'When should a scaffold be rechecked?',
      answer: 'After erection/modification and after conditions that could affect stability or safety.',
      reference: 'Dubai Municipality building-control inspection and construction-site safety resources.',
      url: 'https://www.dm.gov.ae/building-planning-circulars-2/',
    ),
    _DubaiTopic(
      id: 'DCF-07',
      title: 'Excavation, Shoring & Dewatering',
      icon: Icons.construction,
      overview: 'Excavation requires planning for ground stability, services, water, access and adjacent structures.',
      learning: ['Assess soil and site conditions.', 'Identify underground services and adjacent structures.', 'Provide suitable protective arrangements.', 'Control water ingress and access/egress.'],
      hazards: ['Collapse/engulfment', 'Service strike', 'Water ingress', 'Plant/person interface'],
      controls: ['Excavation risk assessment', 'Service identification', 'Shoring/protection', 'Edge/access/dewatering controls'],
      checklist: ['Ground/service assessment', 'Protective system suitable', 'Safe access/egress', 'Water controlled'],
      quiz: 'Why identify underground services before excavation?',
      answer: 'To prevent service strikes causing electrocution, fire, explosion, flooding or other harm.',
      reference: 'Dubai Municipality Building & Planning Circulars — building-control procedures include excavation levels and periodic inspections.',
      url: 'https://www.dm.gov.ae/building-planning-circulars-2/',
    ),
    _DubaiTopic(
      id: 'DCF-08',
      title: 'Electrical Safety',
      icon: Icons.electrical_services,
      overview: 'Construction electrical systems require suitable equipment, protection, inspection and controlled access.',
      learning: ['Use suitable electrical equipment and protective devices.', 'Protect cables from damage.', 'Control access to panels/live parts.', 'Use isolation and verification before applicable electrical work.'],
      hazards: ['Electric shock', 'Arc flash', 'Fire', 'Damaged temporary connections'],
      controls: ['Competent electrical personnel', 'Suitable protection', 'Isolation/lockout where applicable', 'Safe cable routing'],
      checklist: ['Equipment suitable', 'Cables protected', 'Panels secured', 'Isolation procedure followed'],
      quiz: 'Why isolate electrical energy before work?',
      answer: 'To prevent unexpected energisation and reduce shock, arc-flash and related risks.',
      reference: 'Dubai Municipality building-control and construction-site resources.',
      url: 'https://www.dm.gov.ae/building-planning-circulars-2/',
    ),
    _DubaiTopic(
      id: 'DCF-09',
      title: 'Fire Prevention & Emergency Preparedness',
      icon: Icons.local_fire_department,
      overview: 'Construction sites must plan for fire and emergencies, maintain response access and communicate arrangements.',
      learning: ['Identify hot-work, electrical, fuel and combustible-material hazards.', 'Keep firefighting equipment accessible.', 'Maintain emergency routes and assembly arrangements.', 'Use suitable emergency communication and drills.'],
      hazards: ['Hot-work fire', 'Combustible waste', 'Blocked emergency access', 'Poor communication'],
      controls: ['Hot-work controls/permits where applicable', 'Fire equipment', 'Clear routes/assembly points', 'Emergency contacts'],
      checklist: ['Fire equipment accessible', 'Hot-work controls active', 'Routes clear', 'Workers know emergency arrangements'],
      quiz: 'Why must emergency routes remain clear?',
      answer: 'For safe evacuation and rapid emergency-responder access.',
      reference: 'Dubai Municipality construction safety campaign and construction-site safety resources.',
      url: 'https://www.dm.gov.ae/dubai-municipality-launches-comprehensive-safety-campaign-for-construction-sites-across-emirate/',
    ),
    _DubaiTopic(
      id: 'DCF-10',
      title: 'Demolition Safety',
      icon: Icons.domain_disabled,
      overview: 'Demolition requires controlled sequencing, structural assessment, exclusion zones and protection of workers/public.',
      learning: ['Plan demolition sequence and identify structural/service hazards.', 'Control access and protect adjacent areas.', 'Coordinate plant, workers and waste removal.', 'Stop and reassess when site conditions change materially.'],
      hazards: ['Uncontrolled collapse', 'Falling debris', 'Hidden services', 'Dust/noise'],
      controls: ['Approved method and risk assessment', 'Exclusion zones', 'Competent supervision', 'Dust/noise/debris controls'],
      checklist: ['Method approved and briefed', 'Exclusion zone established', 'Structural/services assessed', 'Waste route controlled'],
      quiz: 'What if site conditions materially differ from the demolition plan?',
      answer: 'Stop, reassess and update the method/risk controls before continuing.',
      reference: 'Dubai Municipality Building & Planning Circulars — construction-site works and demolition-related controls.',
      url: 'https://www.dm.gov.ae/building-planning-circulars-2/',
    ),
    _DubaiTopic(
      id: 'DCF-11',
      title: 'Housekeeping & Material Storage',
      icon: Icons.inventory_2,
      overview: 'Good housekeeping reduces trips, fire load, blocked access, falling-object and handling risks.',
      learning: ['Keep work areas and emergency access clear.', 'Store materials in designated stable locations.', 'Remove waste regularly.', 'Separate and secure materials appropriately.'],
      hazards: ['Trips/falls', 'Unstable stacks', 'Blocked emergency routes', 'Fire load'],
      controls: ['Defined storage areas', 'Regular waste removal', 'Stable stacking', 'Daily housekeeping'],
      checklist: ['Routes clear', 'Materials safely stored', 'Waste removed', 'Emergency access clear'],
      quiz: 'What is one major benefit of daily housekeeping?',
      answer: 'It removes hazards early and keeps access and emergency routes usable.',
      reference: 'Dubai Municipality Building & Planning Circulars — organising, cleaning and protecting construction sites.',
      url: 'https://www.dm.gov.ae/building-planning-circulars-2/',
    ),
    _DubaiTopic(
      id: 'DCF-12',
      title: 'Site Inspection & Compliance',
      icon: Icons.fact_check,
      overview: 'Inspection and audit systems verify whether site controls are implemented and corrective actions are effective.',
      learning: ['Use planned inspections based on construction activities and risk.', 'Record observations with evidence and responsible persons.', 'Prioritise actions by risk and due date.', 'Verify effectiveness before final close-out.'],
      hazards: ['Repeated unsafe conditions', 'Weak action close-out', 'Poor traceability', 'Uncontrolled high-risk work'],
      controls: ['Inspection schedules', 'Risk-based action priority', 'Owner/due-date tracking', 'Effectiveness verification'],
      checklist: ['Inspection schedule current', 'Findings have owners/dates', 'High-risk findings escalated', 'Closed actions verified'],
      quiz: 'What makes corrective-action close-out effective?',
      answer: 'The control is implemented, evidence exists and effectiveness has been verified.',
      reference: 'Dubai Municipality Building & Planning Circulars — site inspection file and periodic inspections/audits on construction sites.',
      url: 'https://www.dm.gov.ae/building-planning-circulars-2/',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: const Text('Dubai Construction Safety'),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              gradient: const LinearGradient(
                colors: [darkGreen, purple],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.apartment, color: Colors.white, size: 36),
                SizedBox(height: 12),
                Text(
                  'Dubai Construction Safety Framework',
                  style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900),
                ),
                SizedBox(height: 8),
                Text(
                  'Learn • Inspect • Control • Verify • Reference',
                  style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text('Advanced Learning Topics', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
          const SizedBox(height: 8),
          const Text('Tap any topic to study advanced details, hazards, controls, checklist, learning check and official reference.'),
          const SizedBox(height: 12),
          ...topics.map((topic) => Card(
                margin: const EdgeInsets.only(bottom: 10),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  leading: CircleAvatar(
                    backgroundColor: green.withValues(alpha: 0.12),
                    foregroundColor: green,
                    child: Icon(topic.icon),
                  ),
                  title: Text(topic.title, style: const TextStyle(fontWeight: FontWeight.w800)),
                  subtitle: Text('${topic.id} • Advanced learning + reference'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 17),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (_) => DubaiConstructionTopicDetailPage(topic: topic),
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}

class DubaiConstructionTopicDetailPage extends StatelessWidget {
  final _DubaiTopic topic;

  const DubaiConstructionTopicDetailPage({super.key, required this.topic});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SafenexusDubaiConstructionFrameworkPage.background,
      appBar: AppBar(
        title: Text(topic.title),
        backgroundColor: SafenexusDubaiConstructionFrameworkPage.darkGreen,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _section(Icons.menu_book, '1. Topic Overview', Text(topic.overview, style: const TextStyle(height: 1.5))),
          _section(Icons.school, '2. Advanced Learning', _bullets(topic.learning)),
          _section(Icons.warning_amber, '3. Hazards', _bullets(topic.hazards)),
          _section(Icons.shield, '4. Risk Controls', _bullets(topic.controls)),
          _section(
            Icons.fact_check,
            '5. Field Checklist',
            Column(
              children: topic.checklist.map((item) => CheckboxListTile(
                    value: false,
                    onChanged: (_) {},
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    controlAffinity: ListTileControlAffinity.leading,
                    title: Text(item),
                  )).toList(),
            ),
          ),
          _section(
            Icons.quiz,
            '6. Learning Check',
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.deepPurple.withValues(alpha: 0.07),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(topic.quiz, style: const TextStyle(fontWeight: FontWeight.w800)),
                  const SizedBox(height: 10),
                  Text('Answer: ${topic.answer}', style: const TextStyle(height: 1.45)),
                ],
              ),
            ),
          ),
          _section(
            Icons.link,
            '7. Official Reference',
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(topic.reference, style: const TextStyle(height: 1.45)),
                const SizedBox(height: 12),
                FilledButton.icon(
                  onPressed: () async {
                    final uri = Uri.parse(topic.url);
                    final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
                    if (!ok && context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Unable to open the official reference.')),
                      );
                    }
                  },
                  icon: const Icon(Icons.open_in_new),
                  label: const Text('Open Official Dubai Municipality Reference'),
                  style: FilledButton.styleFrom(backgroundColor: SafenexusDubaiConstructionFrameworkPage.darkGreen),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'SafeNexus note: Verify current official requirements and project-specific approvals before live work.',
            style: TextStyle(color: Colors.black54, fontSize: 12, height: 1.4),
          ),
        ],
      ),
    );
  }

  Widget _section(IconData icon, String title, Widget child) => Card(
        margin: const EdgeInsets.only(bottom: 12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Icon(icon, color: SafenexusDubaiConstructionFrameworkPage.purple),
                const SizedBox(width: 8),
                Expanded(child: Text(title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w900))),
              ]),
              const SizedBox(height: 12),
              child,
            ],
          ),
        ),
      );

  Widget _bullets(List<String> items) => Column(
        children: items.map((item) => Padding(
              padding: const EdgeInsets.only(bottom: 9),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('• ', style: TextStyle(fontWeight: FontWeight.w900)),
                  Expanded(child: Text(item, style: const TextStyle(height: 1.4))),
                ],
              ),
            )).toList(),
      );
}

class _DubaiTopic {
  final String id;
  final String title;
  final IconData icon;
  final String overview;
  final List<String> learning;
  final List<String> hazards;
  final List<String> controls;
  final List<String> checklist;
  final String quiz;
  final String answer;
  final String reference;
  final String url;

  const _DubaiTopic({
    required this.id,
    required this.title,
    required this.icon,
    required this.overview,
    required this.learning,
    required this.hazards,
    required this.controls,
    required this.checklist,
    required this.quiz,
    required this.answer,
    required this.reference,
    required this.url,
  });
}
