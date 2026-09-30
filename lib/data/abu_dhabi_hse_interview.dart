import 'package:flutter/material.dart';

class HseInterviewItem {
  final int number;
  final String category;
  final String question;
  final String answer;
  final String practicalExample;
  final String keyPoint;

  const HseInterviewItem({
    required this.number,
    required this.category,
    required this.question,
    required this.answer,
    this.practicalExample = '',
    this.keyPoint = '',
  });
}

class HseMcqItem {
  final int number;
  final String category;
  final String question;
  final List<String> options;
  final int correctIndex;
  final String explanation;

  const HseMcqItem({
    required this.number,
    required this.category,
    required this.question,
    required this.options,
    required this.correctIndex,
    required this.explanation,
  });
}

class AbuDhabiHseInterviewPage extends StatefulWidget {
  const AbuDhabiHseInterviewPage({super.key});

  @override
  State<AbuDhabiHseInterviewPage> createState() => _AbuDhabiHseInterviewPageState();
}

class _AbuDhabiHseInterviewPageState extends State<AbuDhabiHseInterviewPage> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'All';
  bool _showMcqs = false;
  final Set<int> _expandedItems = {};
  final Map<int, int> _selectedAnswers = {};

  static const List<HseInterviewItem> interviewQuestions = [
    HseInterviewItem(number: 1, category: 'UAE HSE Regulations', question: 'What is ADOSH-SF and what is its purpose?', answer: 'Abu Dhabi Occupational Safety and Health System Framework (ADOSH-SF) establishes a framework for managing occupational safety and health risks, responsibilities, compliance, monitoring, and continual improvement. Check the current official framework and applicable Codes of Practice.', practicalExample: 'Before high-risk work, review applicable requirements, project procedures, risk assessment, and permit conditions.', keyPoint: 'Verify current official revisions before quoting a legal requirement.'),
    HseInterviewItem(number: 2, category: 'Risk Assessment', question: 'Explain the hierarchy of controls.', answer: 'The usual order is elimination, substitution, engineering controls, administrative controls, and PPE. Higher-level controls generally reduce dependence on individual behaviour.', practicalExample: 'Consider ground-level assembly to eliminate work at height before relying on fall-arrest PPE.', keyPoint: 'PPE should not automatically be the first or only control.'),
    HseInterviewItem(number: 3, category: 'UAE HSE Regulations', question: 'How do you identify the applicable Abu Dhabi Codes of Practice?', answer: 'Identify the activity and hazards, consult the current official ADPHC/ADOSH-SF register, confirm the CoP title and revision, and review project and client requirements.', practicalExample: 'For excavation, verify current excavation requirements, utility clearance, permit, and temporary works controls.', keyPoint: 'Do not rely only on an old CoP number list.'),
    HseInterviewItem(number: 4, category: 'Road and Infrastructure Safety', question: 'Identify six common hazards in road or infrastructure work.', answer: 'Moving traffic, reversing plant, underground utilities, open excavations, poor visibility, and pedestrian-equipment interaction. Other site-specific hazards may include heat, dust, and noise.', practicalExample: 'Review traffic plan, barriers, warning signs, lighting, access routes, and banksman arrangements.', keyPoint: 'Match controls to layout, traffic speed, visibility, and activity.'),
    HseInterviewItem(number: 5, category: 'Electrical Safety', question: 'What is the purpose of an RCD in a temporary electrical DB?', answer: 'A Residual Current Device detects current imbalance and disconnects when its operating conditions are met, providing additional protection against electric shock. Required sensitivity and testing depend on applicable regulations, design, and use.', practicalExample: 'Inspect DB enclosure, protective devices, cables, earthing, test records, and environmental suitability.', keyPoint: 'One rating does not necessarily apply to every circuit and tool.'),
    HseInterviewItem(number: 6, category: 'Electrical Safety', question: 'What is earth resistance and what value is acceptable?', answer: 'Earth resistance relates to the resistance of an earthing path or electrode system. There is no single universal acceptable value for every installation; acceptance depends on design, earthing arrangement, protective-device operation, and applicable requirements.', practicalExample: 'A competent electrician tests and records results against approved design criteria.', keyPoint: 'Do not approve using a generic assumed Ohm value.'),
    HseInterviewItem(number: 7, category: 'Excavation Safety', question: 'What precautions are required during excavation?', answer: 'Review drawings, obtain permits, locate underground services, assess ground conditions, establish access and exclusion zones, and provide suitable engineered protection where required. Inspect conditions and control water, spoil, plant, and traffic; maintain emergency arrangements.', practicalExample: 'Stop work for unidentified services, ground movement, water ingress, damaged support, or unsafe access.', keyPoint: 'Protection must be based on site conditions and competent assessment.'),
    HseInterviewItem(number: 8, category: 'Confined Space', question: 'What atmospheric conditions should be checked before entry?', answer: 'Assess oxygen, flammable atmosphere, and toxic contaminants using suitable calibrated gas detection. Common screening oxygen limits are 19.5%–23.5% by volume, but approved permit criteria and applicable standards govern actual entry.', practicalExample: 'Use entry permit, isolation, atmospheric testing, ventilation as needed, standby attendant, communication, and rescue arrangements.', keyPoint: 'Never improvise an unsafe rescue entry.'),
    HseInterviewItem(number: 9, category: 'HSE Performance', question: 'What are leading and lagging HSE indicators?', answer: 'Leading indicators measure preventive activity, such as inspections, action closure, training, and safety observations. Lagging indicators measure outcomes, such as injuries, lost-time cases, and recordable incidents.', practicalExample: 'A dashboard can track planned inspections and overdue actions alongside injury statistics.', keyPoint: 'Use both; activity counts alone do not prove risk control.'),
    HseInterviewItem(number: 10, category: 'Lifting Operations', question: 'What is a critical lift?', answer: 'A critical lift is an operation classified as higher risk under the applicable procedure or project criteria. Triggers may include complex configuration, high consequence, tandem lifting, restricted clearance, unusual load, or specified capacity thresholds.', practicalExample: 'Review lift plan, load data, crane configuration, ground bearing, rigging, exclusion zone, communications, and contingency.', keyPoint: 'Use approved project criteria, not an invented universal threshold.'),
    HseInterviewItem(number: 11, category: 'Lifting Operations', question: 'Who is an Appointed Person in lifting operations?', answer: 'A competent person formally assigned responsibility for planning and coordinating lifting operations within the scope of their competence and appointment.', practicalExample: 'Confirm load data, crane configuration, rigging, ground conditions, personnel competency, and approvals.', keyPoint: 'Check applicable appointment, competency, and certification requirements.'),
    HseInterviewItem(number: 12, category: 'Lifting Operations', question: 'Name important crane safety devices.', answer: 'Depending on crane type: rated capacity/load moment indicator, anti-two-block device, limit switches, emergency stop, anemometer, level indicator, and overload protection.', practicalExample: 'Verify required devices and inspection records; never bypass a safety device.', keyPoint: 'Device set varies by crane type and configuration.'),
    HseInterviewItem(number: 13, category: 'MEWP', question: 'What competency is required for a MEWP operator?', answer: 'Training and assessment appropriate to machine type, hazards, and employer requirements, including pre-use checks, stability, positioning, emergency lowering, fall protection, and rescue.', practicalExample: 'Check machine condition, ground bearing, overhead hazards, exclusion zone, weather limits, and emergency descent.', keyPoint: 'Verify current authorization and client-required certification.'),
    HseInterviewItem(number: 14, category: 'Heat Stress', question: 'How do you manage heat stress during UAE summer work?', answer: 'Use heat-risk assessment, acclimatization, hydration, shaded rest, work-rest arrangements, education, supervision, environmental monitoring, and emergency response. Follow current UAE midday-break rules and applicable instructions.', practicalExample: 'Respond promptly to cramps, dizziness, confusion, collapse, or unusual fatigue.', keyPoint: 'Check current official restrictions and project procedures.'),
    HseInterviewItem(number: 15, category: 'Chemical Safety', question: 'What is COSHH and how should chemicals be stored?', answer: 'COSHH means Control of Substances Hazardous to Health. Chemical management includes SDS review, exposure assessment, controls, training, labeling, and spill response. Storage considers compatibility, ventilation, containment, fire, and environmental risks.', practicalExample: 'Segregate incompatible chemicals, label containers, and provide suitable spill response materials.', keyPoint: 'Use the product SDS and approved chemical risk assessment.'),
    HseInterviewItem(number: 16, category: 'Traffic Management', question: 'What controls are needed for a traffic diversion on a live road?', answer: 'Use an approved traffic management plan with warning signs, barriers, channelization, pedestrian routes, lighting, speed management, emergency access, and trained personnel where required. Coordinate with the road authority.', practicalExample: 'Inspect after installation and changes, including night visibility and barrier continuity.', keyPoint: 'Follow authority requirements and the approved site layout.'),
    HseInterviewItem(number: 17, category: 'Safety Signs', question: 'Explain common safety sign colors.', answer: 'Common conventions: red for prohibition/fire equipment, yellow or amber for warning, blue for mandatory action, and green for emergency escape or safe condition. Follow the applicable standard and signage plan.', practicalExample: 'Blue may indicate mandatory helmet use; green may identify an emergency exit.', keyPoint: 'Use standardized, visible, understood signs.'),
    HseInterviewItem(number: 18, category: 'Scaffolding', question: 'Name main scaffold components and explain inspection.', answer: 'Components may include standards, ledgers, transoms, bracing, base plates, sole boards, platforms, guardrails, midrails, toe boards, ties, and access. A competent person inspects at required intervals and after events that may affect safety.', practicalExample: 'Do not use incomplete platforms, missing guardrails, damaged components, or unsafe access.', keyPoint: 'Follow applicable inspection frequency and project tagging procedure.'),
    HseInterviewItem(number: 19, category: 'Lifting Operations', question: 'Difference between a rigger and an outrigger?', answer: 'A rigger is a trained person who handles or directs rigging within their role. An outrigger is a crane support that transfers load to the ground to improve stability.', practicalExample: 'The rigger checks slings and attachments; the lifting team verifies outrigger deployment, mats, and ground conditions.', keyPoint: 'One is a personnel role; the other is equipment.'),
    HseInterviewItem(number: 20, category: 'Manual Handling', question: 'What is manual material handling and how are risks controlled?', answer: 'It includes lifting, lowering, carrying, pushing, and pulling by human effort. Assess load, grip, posture, repetition, distance, environment, and capability. Prefer mechanical aids, task redesign, smaller loads, and suitable storage.', practicalExample: 'Use a trolley where suitable, keep the load close, avoid twisting, and clear the route.', keyPoint: 'Training alone is not an adequate control.'),
  ];

  static const List<HseMcqItem> mcqQuestions = [
    HseMcqItem(number: 1, category: 'Risk Assessment', question: 'Which control is highest in the hierarchy of controls?', options: ['PPE', 'Administrative control', 'Elimination', 'Warning sign'], correctIndex: 2, explanation: 'Elimination removes the hazard rather than relying on workers to manage exposure.'),
    HseMcqItem(number: 2, category: 'Confined Space', question: 'What should be completed before confined-space entry?', options: ['Start immediately', 'Authorize entry and verify safe conditions', 'Send one worker alone', 'Rely only on smell'], correctIndex: 1, explanation: 'Entry requires assessment, authorization, isolation, atmospheric checks, communication, and rescue arrangements.'),
    HseMcqItem(number: 3, category: 'Electrical Safety', question: 'What is the main purpose of an RCD?', options: ['Increase voltage', 'Detect residual-current imbalance and disconnect', 'Replace earthing in every case', 'Prevent every electrical fault'], correctIndex: 1, explanation: 'An RCD provides additional protection by detecting leakage-current imbalance and disconnecting under its operating conditions.'),
    HseMcqItem(number: 4, category: 'Excavation Safety', question: 'What should be done when an unidentified underground service is found?', options: ['Continue carefully', 'Touch it to identify it', 'Stop work and follow the service discovery procedure', 'Cover it with soil'], correctIndex: 2, explanation: 'Stop work, secure the area, inform the responsible personnel, and follow the approved identification and isolation process.'),
  ];

  List<String> get _categories => ['All', ...{...interviewQuestions.map((e) => e.category), ...mcqQuestions.map((e) => e.category)}.toList()..sort()];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final query = _searchController.text.trim().toLowerCase();
    final interviews = interviewQuestions.where((item) {
      final matchesCategory = _selectedCategory == 'All' || item.category == _selectedCategory;
      final matchesQuery = query.isEmpty || '${item.question} ${item.answer} ${item.category}'.toLowerCase().contains(query);
      return matchesCategory && matchesQuery;
    }).toList();
    final mcqs = mcqQuestions.where((item) {
      final matchesCategory = _selectedCategory == 'All' || item.category == _selectedCategory;
      final matchesQuery = query.isEmpty || '${item.question} ${item.category}'.toLowerCase().contains(query);
      return matchesCategory && matchesQuery;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Abu Dhabi HSE Interview'),
        backgroundColor: const Color(0xFF176B45),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            tooltip: _showMcqs ? 'Interview Q&A' : 'Objective MCQs',
            icon: Icon(_showMcqs ? Icons.menu_book : Icons.quiz_outlined),
            onPressed: () => setState(() => _showMcqs = !_showMcqs),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _searchController,
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                hintText: 'Search questions or topics...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(icon: const Icon(Icons.clear), onPressed: () { _searchController.clear(); setState(() {}); }),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
              ),
            ),
          ),
          SizedBox(
            height: 48,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              children: _categories.map((category) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: ChoiceChip(label: Text(category), selected: _selectedCategory == category, onSelected: (_) => setState(() => _selectedCategory = category)),
              )).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(_showMcqs ? 'Objective Questions: ${mcqs.length}' : 'Interview Questions: ${interviews.length}', style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: _showMcqs
                ? ListView.builder(
                    itemCount: mcqs.length,
                    itemBuilder: (context, index) {
                      final item = mcqs[index];
                      final selected = _selectedAnswers[item.number];
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        child: Padding(
                          padding: const EdgeInsets.all(14),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text('MCQ ${item.number} • ${item.category}', style: const TextStyle(color: Color(0xFF176B45), fontWeight: FontWeight.bold)),
                            const SizedBox(height: 8),
                            Text(item.question, style: const TextStyle(fontWeight: FontWeight.w600)),
                            ...List.generate(item.options.length, (i) => RadioListTile<int>(contentPadding: EdgeInsets.zero, value: i, groupValue: selected, onChanged: (value) => setState(() => _selectedAnswers[item.number] = value!), title: Text('${String.fromCharCode(65 + i)}. ${item.options[i]}')),
                            if (selected != null) Container(width: double.infinity, padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: selected == item.correctIndex ? Colors.green.withValues(alpha: 0.12) : Colors.orange.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(8)), child: Text('${selected == item.correctIndex ? 'Correct' : 'Correct answer: ${String.fromCharCode(65 + item.correctIndex)}. ${item.options[item.correctIndex]}'}\n${item.explanation}')),
                          ]),
                        ),
                      );
                    },
                  )
                : ListView.builder(
                    itemCount: interviews.length,
                    itemBuilder: (context, index) {
                      final item = interviews[index];
                      final expanded = _expandedItems.contains(item.number);
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        child: ExpansionTile(
                          key: PageStorageKey('interview-${item.number}'),
                          initiallyExpanded: expanded,
                          onExpansionChanged: (value) => setState(() { if (value) { _expandedItems.add(item.number); } else { _expandedItems.remove(item.number); } }),
                          leading: CircleAvatar(backgroundColor: const Color(0xFF176B45), foregroundColor: Colors.white, child: Text('${item.number}')),
                          title: Text(item.question, style: const TextStyle(fontWeight: FontWeight.w600)),
                          subtitle: Text(item.category),
                          childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                          children: [
                            const Align(alignment: Alignment.centerLeft, child: Text('ANSWER', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF176B45)))),
                            const SizedBox(height: 6),
                            Text(item.answer),
                            if (item.practicalExample.isNotEmpty) ...[const SizedBox(height: 12), const Align(alignment: Alignment.centerLeft, child: Text('PRACTICAL EXAMPLE', style: TextStyle(fontWeight: FontWeight.bold))), const SizedBox(height: 4), Text(item.practicalExample)],
                            if (item.keyPoint.isNotEmpty) ...[const SizedBox(height: 12), const Align(alignment: Alignment.centerLeft, child: Text('KEY POINT', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepOrange))), const SizedBox(height: 4), Text(item.keyPoint)],
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
