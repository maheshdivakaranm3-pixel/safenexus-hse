import 'package:flutter/material.dart';

class GuidelineDetailPage extends StatelessWidget {
  final Map<String, String> guideline;

  const GuidelineDetailPage({
    super.key,
    required this.guideline,
  });

  String get title => guideline['title'] ?? '';
  String get desc => guideline['desc'] ?? '';

  // ------------------------------------------------------------
  // TOPIC-SPECIFIC HSE CONTENT
  // ------------------------------------------------------------

  Map<String, Map<String, String>> get details {
    return {
      'Code of Practice': {
        'what': 'What is a Code of Practice?',
        'whatText':
            'A Code of Practice (CoP) provides practical occupational safety and health requirements and guidance for specific workplace hazards and activities.',
        'purpose': 'Purpose',
        'purposeText':
            'To provide clear technical guidance for controlling workplace risks and supporting consistent HSE practices.',
        'requirements': 'Key Requirements',
        'requirementsText':
            'Identify the applicable Code of Practice, review the relevant requirements, implement suitable controls, communicate requirements to workers and maintain evidence of compliance.',
        'responsibilities': 'HSE Responsibilities',
        'responsibilitiesText':
            'HSE personnel should identify applicable requirements, support implementation, conduct inspections, monitor compliance and follow up corrective actions.',
        'checklist': 'Site Checklist',
        'checklistText':
            'Applicable CoP identified • Requirements reviewed • Risk assessment • Safe work procedure • Worker briefing • Inspection • Records.',
        'violations': 'Common Issues',
        'violationsText':
            'Using outdated requirements, incomplete implementation, poor documentation and treating the CoP as paperwork only.',
        'best': 'Best Practice',
        'bestText':
            'Always verify the latest applicable official authority requirements and integrate them into the project HSE management system.',
        'reference': 'Reference',
        'referenceText':
            'Applicable ADPHC / ADOSH-SF Codes of Practice and current project or authority requirements.',
      },

      'Lifting': {
        'what': 'What are Lifting Operations?',
        'whatText':
            'Lifting operations involve raising, lowering or moving loads using cranes, hoists or other lifting equipment and accessories.',
        'purpose': 'Purpose',
        'purposeText':
            'To prevent dropped loads, equipment failure, struck-by incidents and uncontrolled movement of loads.',
        'requirements': 'Key Requirements',
        'requirementsText':
            'Use competent personnel, suitable lifting equipment and accessories, verified load capacity, appropriate lifting plans where required, stable ground conditions, exclusion zones and effective communication.',
        'responsibilities': 'Responsibilities',
        'responsibilitiesText':
            'Lifting supervisors, crane operators, riggers and signalers must be competent and perform their assigned roles safely.',
        'checklist': 'Lifting Checklist',
        'checklistText':
            'Lift plan • Crane inspection • Lifting accessories • SWL/WLL • Ground condition • Outriggers • Exclusion zone • Banksman/signalman • Communication.',
        'violations': 'Common Issues',
        'violationsText':
            'Overloading, damaged lifting accessories, poor rigging, side loading, lifting over people and inadequate exclusion zones.',
        'best': 'Best Practice',
        'bestText':
            'Plan every lift, verify the load and equipment capacity, inspect lifting accessories and keep people away from suspended loads.',
        'reference': 'Reference',
        'referenceText':
            'Applicable UAE and Abu Dhabi lifting requirements, authority Codes of Practice and approved project lifting procedures.',
      },

      'Excavation': {
        'what': 'What is Excavation Safety?',
        'whatText':
            'Excavation safety covers hazards associated with digging, trenching and earthworks, including collapse, underground services, falling materials and plant movement.',
        'purpose': 'Purpose',
        'purposeText':
            'To prevent trench collapse, worker falls, underground service strikes, flooding and plant-related incidents.',
        'requirements': 'Key Requirements',
        'requirementsText':
            'Conduct risk assessment, identify underground services, provide suitable excavation protection, maintain safe access and egress, control plant movement and inspect excavations regularly.',
        'responsibilities': 'Responsibilities',
        'responsibilitiesText':
            'Supervisors must ensure excavation controls are implemented. Competent persons should inspect excavation conditions and protection systems.',
        'checklist': 'Excavation Checklist',
        'checklistText':
            'Permit where required • Service drawings • Service detection • Shoring/sloping • Safe access • Edge protection • Spoil setback • Water control • Inspection.',
        'violations': 'Common Issues',
        'violationsText':
            'Unprotected trenches, spoil too close to edges, unsafe access, missing service identification and workers entering unstable excavations.',
        'best': 'Best Practice',
        'bestText':
            'Never enter an unsafe excavation. Identify underground services before digging and provide suitable protective systems based on the risk.',
        'reference': 'Reference',
        'referenceText':
            'Applicable UAE / Abu Dhabi excavation, trenching, temporary works and underground service requirements.',
      },

      'Scaffolding': {
        'what': 'What is Scaffolding Safety?',
        'whatText':
            'Scaffolding safety covers the design, erection, inspection, alteration, tagging and safe use of scaffold systems.',
        'purpose': 'Purpose',
        'purposeText':
            'To prevent falls from height, scaffold collapse, falling objects and unsafe access.',
        'requirements': 'Key Requirements',
        'requirementsText':
            'Use competent scaffold personnel, provide stable foundations, proper access, guardrails, toe boards, suitable platforms, safe loading and required inspections.',
        'responsibilities': 'Responsibilities',
        'responsibilitiesText':
            'Only authorised and competent personnel should erect, alter or inspect scaffolding. Users must not make unauthorised modifications.',
        'checklist': 'Scaffold Checklist',
        'checklistText':
            'Foundation • Standards • Bracing • Guardrails • Toe boards • Platforms • Access ladder/stair • Inspection • Tag • Safe load.',
        'violations': 'Common Issues',
        'violationsText':
            'Missing guardrails, damaged components, unsafe access, overloading, incomplete platforms and unauthorised alterations.',
        'best': 'Best Practice',
        'bestText':
            'Do not use a scaffold until it has been inspected and released for use under the applicable site system.',
        'reference': 'Reference',
        'referenceText':
            'Applicable UAE / Abu Dhabi scaffolding requirements, authority guidance and project procedures.',
      },

      'Working at Height': {
        'what': 'What is Working at Height?',
        'whatText':
            'Working at height includes work where a person could fall from one level to another and suffer injury.',
        'purpose': 'Purpose',
        'purposeText':
            'To prevent falls from roofs, scaffolds, platforms, ladders, openings and other elevated work areas.',
        'requirements': 'Key Requirements',
        'requirementsText':
            'Avoid work at height where possible, assess risks, provide suitable platforms and edge protection, control openings and use fall protection systems where required.',
        'responsibilities': 'Responsibilities',
        'responsibilitiesText':
            'Supervisors must ensure suitable access, protection and rescue arrangements. Workers must use provided systems correctly.',
        'checklist': 'Height Safety Checklist',
        'checklistText':
            'Risk assessment • Safe access • Guardrails • Edge protection • Floor opening protection • Harness where required • Anchor points • Rescue plan.',
        'violations': 'Common Issues',
        'violationsText':
            'Unprotected edges, unsafe ladders, missing guardrails, incorrect harness use and working without a rescue arrangement.',
        'best': 'Best Practice',
        'bestText':
            'Prioritise collective protection such as guardrails and safe platforms before relying on personal fall protection.',
        'reference': 'Reference',
        'referenceText':
            'Applicable UAE / Abu Dhabi work-at-height requirements and approved project procedures.',
      },

      'Power Tools': {
        'what': 'What are Power Tool Safety Requirements?',
        'whatText':
            'Power tools include portable electrical, pneumatic and other powered tools used for cutting, drilling, grinding and similar activities.',
        'purpose': 'Purpose',
        'purposeText':
            'To prevent electric shock, cuts, eye injuries, entanglement, burns, noise exposure and flying-particle injuries.',
        'requirements': 'Key Requirements',
        'requirementsText':
            'Use suitable tools, inspect before use, maintain guards, use correct accessories, provide electrical protection where required and wear appropriate PPE.',
        'responsibilities': 'Responsibilities',
        'responsibilitiesText':
            'Workers must use tools correctly and report damaged equipment. Supervisors should ensure inspection, maintenance and competency.',
        'checklist': 'Power Tool Checklist',
        'checklistText':
            'Pre-use inspection • Guards • Cable/plug • Correct disc/blade • RCD/GFCI where applicable • PPE • Safe position • Maintenance.',
        'violations': 'Common Issues',
        'violationsText':
            'Damaged cables, removed guards, incorrect discs, improvised repairs and using tools without suitable PPE.',
        'best': 'Best Practice',
        'bestText':
            'Inspect tools before use and remove defective equipment from service immediately.',
        'reference': 'Reference',
        'referenceText':
            'Applicable UAE electrical safety requirements, manufacturer instructions and project HSE procedures.',
      },

      'Formwork': {
        'what': 'What is Formwork Safety?',
        'whatText':
            'Formwork is a temporary structure used to support fresh concrete until it gains sufficient strength.',
        'purpose': 'Purpose',
        'purposeText':
            'To prevent formwork collapse, falling materials, struck-by incidents and worker falls.',
        'requirements': 'Key Requirements',
        'requirementsText':
            'Use approved design, suitable materials, proper bracing and supports, safe access, inspection before loading and controlled stripping procedures.',
        'responsibilities': 'Responsibilities',
        'responsibilitiesText':
            'Engineers and competent personnel should verify the formwork system. Supervisors must ensure erection and use follow the approved design.',
        'checklist': 'Formwork Checklist',
        'checklistText':
            'Approved design • Props • Bracing • Base condition • Connections • Working platforms • Access • Inspection • Pour sequence.',
        'violations': 'Common Issues',
        'violationsText':
            'Inadequate bracing, damaged components, unstable props, unauthorised changes and premature stripping.',
        'best': 'Best Practice',
        'bestText':
            'Follow the approved temporary works design and inspect the formwork before concrete placement.',
        'reference': 'Reference',
        'referenceText':
            'Applicable UAE / Abu Dhabi temporary works, formwork and construction safety requirements.',
      },

      'Permit to Work': {
        'what': 'What is a Permit to Work?',
        'whatText':
            'A Permit to Work (PTW) is a formal control system used to manage specified high-risk activities under defined conditions.',
        'purpose': 'Purpose',
        'purposeText':
            'To ensure hazards are identified, controls are established and responsible persons understand the conditions before work starts.',
        'requirements': 'Key Requirements',
        'requirementsText':
            'Define the work scope, identify hazards, establish controls, verify isolations where applicable, authorise the permit and close it after work.',
        'responsibilities': 'Responsibilities',
        'responsibilitiesText':
            'Permit issuers, performing authorities, supervisors and workers must understand and comply with the permit conditions.',
        'checklist': 'PTW Checklist',
        'checklistText':
            'Correct scope • Risk assessment • Isolation • Gas testing where required • Controls • Authorisation • Validity • Display • Closure.',
        'violations': 'Common Issues',
        'violationsText':
            'Working without a permit, expired permits, changed conditions, missing isolations and poor permit close-out.',
        'best': 'Best Practice',
        'bestText':
            'Stop work and reassess whenever conditions change from those covered by the permit.',
        'reference': 'Reference',
        'referenceText':
            'Applicable UAE / Abu Dhabi PTW requirements and project permit-to-work procedures.',
      },

      'Working in Hot & Humid Climate': {
        'what': 'What is Heat Stress Management?',
        'whatText':
            'Heat stress management protects workers from illness caused by high temperatures, humidity, workload and prolonged exposure.',
        'purpose': 'Purpose',
        'purposeText':
            'To prevent heat exhaustion, heat stroke, dehydration and other heat-related illnesses.',
        'requirements': 'Key Requirements',
        'requirementsText':
            'Provide drinking water, shaded or suitable rest areas, heat awareness training, work/rest planning, supervision and compliance with applicable UAE heat-related work restrictions.',
        'responsibilities': 'Responsibilities',
        'responsibilitiesText':
            'Supervisors should monitor workers, recognise symptoms and take prompt action when heat stress is suspected.',
        'checklist': 'Heat Stress Checklist',
        'checklistText':
            'Drinking water • Shade • Rest area • Acclimatisation • Heat awareness • Work/rest planning • First aid • Emergency response.',
        'violations': 'Common Issues',
        'violationsText':
            'Insufficient water, inadequate rest, poor supervision, lack of acclimatisation and failure to follow applicable work restrictions.',
        'best': 'Best Practice',
        'bestText':
            'Plan demanding work around heat conditions and encourage workers to report symptoms early without fear of blame.',
        'reference': 'Reference',
        'referenceText':
            'Applicable UAE Ministry of Human Resources and Emiratisation requirements and local OSH authority guidance.',
      },

      'Confined Space': {
        'what': 'What is a Confined Space?',
        'whatText':
            'A confined space is an enclosed or partially enclosed space that may present serious hazards because of its configuration, atmosphere or other conditions.',
        'purpose': 'Purpose',
        'purposeText':
            'To prevent asphyxiation, toxic exposure, fire, explosion, engulfment and other confined-space incidents.',
        'requirements': 'Key Requirements',
        'requirementsText':
            'Avoid entry where possible. Where entry is necessary, use risk assessment, permit controls where required, atmospheric testing, ventilation, isolation, communication, standby and rescue arrangements.',
        'responsibilities': 'Responsibilities',
        'responsibilitiesText':
            'Only trained and authorised personnel should enter where applicable. Supervisors must ensure controls remain effective throughout the work.',
        'checklist': 'Confined Space Checklist',
        'checklistText':
            'Permit • Gas test • Oxygen level • Toxic/flammable gases • Ventilation • Isolation • Attendant • Communication • Rescue plan.',
        'violations': 'Common Issues',
        'violationsText':
            'Entry without testing, inadequate ventilation, poor isolation, no attendant and no effective rescue arrangement.',
        'best': 'Best Practice',
        'bestText':
            'Treat every confined-space entry as a high-risk activity and verify atmospheric and physical controls before entry.',
        'reference': 'Reference',
        'referenceText':
            'Applicable UAE / Abu Dhabi confined-space requirements and approved project procedures.',
      },

      'Working Near Live Road': {
        'what': 'What is Roadside / Live Traffic Safety?',
        'whatText':
            'Working near a live road involves construction or maintenance activities close to moving public or site traffic.',
        'purpose': 'Purpose',
        'purposeText':
            'To prevent vehicle collisions, worker struck-by incidents and traffic-related injuries.',
        'requirements': 'Key Requirements',
        'requirementsText':
            'Use an approved traffic management arrangement, barriers, signs, lighting, trained traffic marshals and suitable separation between workers and moving vehicles.',
        'responsibilities': 'Responsibilities',
        'responsibilitiesText':
            'Supervisors must maintain the approved traffic control arrangement. Workers must stay within designated safe areas.',
        'checklist': 'Road Safety Checklist',
        'checklistText':
            'Traffic plan • Barriers • Signs • Cones • Lighting • Safe pedestrian route • Traffic marshal • Speed control • Emergency access.',
        'violations': 'Common Issues',
        'violationsText':
            'Poor barricading, inadequate signs, workers entering traffic lanes and uncontrolled vehicle movements.',
        'best': 'Best Practice',
        'bestText':
            'Physically separate workers from live traffic wherever reasonably practicable and inspect traffic controls regularly.',
        'reference': 'Reference',
        'referenceText':
            'Applicable UAE / Abu Dhabi traffic management and road-work safety requirements.',
      },

      'Concreting': {
        'what': 'What is Concreting Safety?',
        'whatText':
            'Concreting involves delivery, pumping, placing, vibrating and finishing fresh concrete.',
        'purpose': 'Purpose',
        'purposeText':
            'To prevent struck-by incidents, formwork failure, hose movement, chemical exposure and manual handling injuries.',
        'requirements': 'Key Requirements',
        'requirementsText':
            'Verify formwork stability, control concrete pumps and hoses, establish exclusion zones, use suitable PPE and maintain safe communication during concrete placement.',
        'responsibilities': 'Responsibilities',
        'responsibilitiesText':
            'Supervisors must coordinate the concrete operation and ensure formwork, access and equipment are safe before the pour.',
        'checklist': 'Concreting Checklist',
        'checklistText':
            'Formwork inspection • Pump inspection • Hose control • Exclusion zone • Access • PPE • Communication • Emergency arrangements.',
        'violations': 'Common Issues',
        'violationsText':
            'Uncontrolled pump hoses, unstable access, inadequate PPE and starting a pour without verifying formwork condition.',
        'best': 'Best Practice',
        'bestText':
            'Conduct a pre-pour inspection and briefing before concrete placement starts.',
        'reference': 'Reference',
        'referenceText':
            'Applicable UAE / Abu Dhabi construction safety and temporary works requirements.',
      },

      'Barricading of Hazards': {
        'what': 'What is Hazard Barricading?',
        'whatText':
            'Hazard barricading uses physical barriers, warning signs or controlled access arrangements to prevent people entering dangerous areas.',
        'purpose': 'Purpose',
        'purposeText':
            'To clearly identify hazards and prevent unauthorised access to unsafe areas.',
        'requirements': 'Key Requirements',
        'requirementsText':
            'Use suitable barriers, warning signs and access controls appropriate to the hazard. Maintain clear emergency routes and inspect barricades regularly.',
        'responsibilities': 'Responsibilities',
        'responsibilitiesText':
            'Workers should not remove or cross barricades without authorisation. Supervisors must ensure barriers remain effective.',
        'checklist': 'Barricading Checklist',
        'checklistText':
            'Correct barrier • Warning signs • Adequate visibility • Stable installation • Access controlled • Emergency route maintained.',
        'violations': 'Common Issues',
        'violationsText':
            'Weak barricades, missing signs, open gaps, damaged barriers and using tape alone where stronger protection is required.',
        'best': 'Best Practice',
        'bestText':
            'Choose the level of physical protection according to the severity and nature of the hazard.',
        'reference': 'Reference',
        'referenceText':
            'Applicable UAE / Abu Dhabi site safety, access control and hazard identification requirements.',
      },

      'Worker Welfare': {
        'what': 'What is Worker Welfare?',
        'whatText':
            'Worker welfare covers workplace arrangements that support workers health, comfort, dignity and basic needs.',
        'purpose': 'Purpose',
        'purposeText':
            'To provide suitable welfare conditions and support safe and healthy working environments.',
        'requirements': 'Key Requirements',
        'requirementsText':
            'Provide suitable drinking water, sanitation, rest facilities, welfare areas, accommodation arrangements where applicable and appropriate emergency support.',
        'responsibilities': 'Responsibilities',
        'responsibilitiesText':
            'Management must provide suitable welfare arrangements and supervisors should monitor conditions and report deficiencies.',
        'checklist': 'Welfare Checklist',
        'checklistText':
            'Drinking water • Toilets • Washing facilities • Rest area • Shade/temperature control • Cleanliness • First aid • Emergency contacts.',
        'violations': 'Common Issues',
        'violationsText':
            'Poor sanitation, insufficient drinking water, inadequate rest areas and poor welfare-area housekeeping.',
        'best': 'Best Practice',
        'bestText':
            'Inspect welfare facilities regularly and correct deficiencies promptly.',
        'reference': 'Reference',
        'referenceText':
            'Applicable UAE labour, worker welfare and occupational safety requirements.',
      },

      'MEWP': {
        'what': 'What is MEWP Safety?',
        'whatText':
            'A Mobile Elevating Work Platform (MEWP) is mobile equipment designed to raise people to elevated working positions.',
        'purpose': 'Purpose',
        'purposeText':
            'To prevent falls, overturning, crushing, collision and equipment-related incidents.',
        'requirements': 'Key Requirements',
        'requirementsText':
            'Use trained operators, inspect equipment, assess ground conditions, control overhead hazards, use required fall protection and maintain exclusion zones.',
        'responsibilities': 'Responsibilities',
        'responsibilitiesText':
            'Only authorised and competent operators should use MEWPs. Supervisors must verify equipment suitability and working conditions.',
        'checklist': 'MEWP Checklist',
        'checklistText':
            'Pre-use inspection • Operator competency • Ground condition • Guardrails • Harness where required • Overhead clearance • Exclusion zone • Emergency lowering.',
        'violations': 'Common Issues',
        'violationsText':
            'Unauthorised operation, bypassed safety devices, unstable ground, climbing guardrails and poor exclusion zones.',
        'best': 'Best Practice',
        'bestText':
            'Complete a pre-use inspection and confirm ground, overhead and surrounding conditions before positioning the MEWP.',
        'reference': 'Reference',
        'referenceText':
            'Applicable UAE / Abu Dhabi MEWP requirements, manufacturer instructions and project procedures.',
      },

      'Electricity on Site & Electrical Tools': {
        'what': 'What is Electrical Safety on Site?',
        'whatText':
            'Construction electrical safety covers temporary electrical installations, distribution systems, cables, portable electrical tools and associated equipment.',
        'purpose': 'Purpose',
        'purposeText':
            'To prevent electric shock, burns, arc-related injuries, fire and electrical equipment incidents.',
        'requirements': 'Key Requirements',
        'requirementsText':
            'Use competent electrical personnel, suitable distribution boards, protection devices, proper earthing, inspected cables and tools, and protect electrical equipment from damage and environmental conditions.',
        'responsibilities': 'Responsibilities',
        'responsibilitiesText':
            'Electrical work should be performed by authorised competent personnel. Workers must report damaged electrical equipment and never make unauthorised repairs.',
        'checklist': 'Electrical Checklist',
        'checklistText':
            'Distribution board • RCD/GFCI • Earthing • Cable condition • Plugs • Tool inspection • Protection from water • Isolation/LOTO where required.',
        'violations': 'Common Issues',
        'violationsText':
            'Damaged cables, exposed conductors, overloaded sockets, improvised connections and unauthorised electrical work.',
        'best': 'Best Practice',
        'bestText':
            'Remove defective electrical equipment from service immediately and ensure electrical systems are inspected by competent personnel.',
        'reference': 'Reference',
        'referenceText':
            'Applicable UAE / Abu Dhabi electrical safety requirements, manufacturer instructions and project procedures.',
      },

      'Temporary Works': {
        'what': 'What are Temporary Works?',
        'whatText':
            'Temporary works are structures or systems installed to support, protect or facilitate construction activities and may later be removed.',
        'purpose': 'Purpose',
        'purposeText':
            'To ensure temporary structures remain stable and safe throughout their intended use.',
        'requirements': 'Key Requirements',
        'requirementsText':
            'Use suitable design, competent review, appropriate materials, controlled installation, inspection, monitoring and an approved sequence for loading or removal.',
        'responsibilities': 'Responsibilities',
        'responsibilitiesText':
            'Engineers and competent personnel should control temporary works design and implementation. Supervisors must follow the approved method and sequence.',
        'checklist': 'Temporary Works Checklist',
        'checklistText':
            'Approved design • Design review • Foundations • Bracing • Connections • Inspection • Load limits • Installation sequence • Removal sequence.',
        'violations': 'Common Issues',
        'violationsText':
            'Unauthorised modifications, inadequate bracing, overloading, missing inspections and removing supports prematurely.',
        'best': 'Best Practice',
        'bestText':
            'Treat temporary works as engineered systems and do not alter them without appropriate technical approval.',
        'reference': 'Reference',
        'referenceText':
            'Applicable UAE / Abu Dhabi temporary works and construction safety requirements.',
      },
    };
  }

  // ------------------------------------------------------------
  // FIND CONTENT BY TOPIC TITLE
  // ------------------------------------------------------------

  Map<String, String>? get currentDetail {
    // Exact title match
    if (details.containsKey(title)) {
      return details[title];
    }

    // Normalised match to handle small differences in spacing/case
    final normalizedTitle = title.trim().toLowerCase();

    for (final entry in details.entries) {
      if (entry.key.trim().toLowerCase() == normalizedTitle) {
        return entry.value;
      }
    }

    return null;
  }

  String _value(String key) {
    return currentDetail?[key] ?? '';
  }

  // ------------------------------------------------------------
  // UI
  // ------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title.isEmpty ? 'HSE Guideline' : title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.green.shade700,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.green.shade800,
                    Colors.green.shade600,
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  const Icon(
                    Icons.health_and_safety,
                    size: 52,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (desc.isNotEmpty) ...[
                    const SizedBox(height: 10),
                    Text(
                      desc,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),
                  ],
                ],
              ),
            ),

            const SizedBox(height: 20),

            _section(
              '📖',
              _value('what'),
              _value('whatText'),
            ),

            _section(
              '🎯',
              _value('purpose'),
              _value('purposeText'),
            ),

            _section(
              '⚠️',
              _value('requirements'),
              _value('requirementsText'),
            ),

            _section(
              '👷',
              _value('responsibilities'),
              _value('responsibilitiesText'),
            ),

            _section(
              '📋',
              _value('checklist'),
              _value('checklistText'),
            ),

            _section(
              '🚨',
              _value('violations'),
              _value('violationsText'),
            ),

            _section(
              '✅',
              _value('best'),
              _value('bestText'),
            ),

            _section(
              '📚',
              _value('reference'),
              _value('referenceText'),
            ),

            const SizedBox(height: 8),

            // Important notice
            Card(
              elevation: 1,
              color: Colors.orange.shade50,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Padding(
                padding: EdgeInsets.all(15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: Colors.orange,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Important: This information is provided for HSE awareness and practical guidance. Always verify the latest applicable UAE legislation, authority requirements, Codes of Practice, manufacturer instructions and project procedures before making compliance decisions.',
                        style: TextStyle(
                          fontSize: 13,
                          height: 1.45,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // ------------------------------------------------------------
  // SECTION CARD
  // ------------------------------------------------------------

  Widget _section(
    String icon,
    String heading,
    String content,
  ) {
    if (heading.isEmpty || content.isEmpty) {
      return const SizedBox.shrink();
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      elevation: 1.5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(17),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  icon,
                  style: const TextStyle(
                    fontSize: 23,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    heading,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade800,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              content,
              style: const TextStyle(
                fontSize: 15,
                height: 1.55,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
