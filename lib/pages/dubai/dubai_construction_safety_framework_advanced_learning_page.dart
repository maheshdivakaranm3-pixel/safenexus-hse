import 'package:flutter/material.dart';

class ConstructionSafetyItem {
  final String title;
  final String subtitle;
  final List<String> points;

  const ConstructionSafetyItem({
    required this.title,
    required this.subtitle,
    required this.points,
  });
}

class DubaiConstructionSafetyAdvancedLearningPage extends StatelessWidget {
  final ConstructionSafetyItem item;

  const DubaiConstructionSafetyAdvancedLearningPage({
    super.key,
    required this.item,
  });

  static const green = Color(0xFF0B7653);
  static const bg = Color(0xFFF5F8F7);

  static const roleResponsibilities = <String, List<String>>{
    'HSE Officer': [
      'Verify field implementation of the approved HSE controls.',
      'Conduct and record routine field observations and inspections.',
      'Identify unsafe conditions, communicate corrective actions and escalate critical findings.',
      'Support toolbox talks, incident reporting and emergency readiness.',
    ],
    'HSE Supervisor': [
      'Supervise day-to-day implementation of project HSE requirements.',
      'Coordinate workfront controls with construction supervisors and subcontractors.',
      'Verify that corrective actions are implemented and effective.',
      'Intervene and stop unsafe work where critical controls fail.',
    ],
    'Senior HSE': [
      'Provide senior assurance for high-risk activities and complex interfaces.',
      'Review recurring failures, significant findings and lessons learned.',
      'Challenge inadequate controls and support management escalation.',
      'Monitor consistency of HSE implementation across work fronts.',
    ],
    'HSE Coordinator': [
      'Coordinate HSE documentation, inspections, meetings and contractor interfaces.',
      'Track actions, submissions, risk assessments and method statements.',
      'Coordinate information flow between construction, engineering and HSE teams.',
      'Maintain controlled records and follow up outstanding actions.',
    ],
    'HSE Engineer': [
      'Provide technical HSE input to risk controls, temporary works and high-risk activities.',
      'Review technical interfaces and changes that may affect safety controls.',
      'Support engineering and construction teams in resolving complex HSE issues.',
      'Contribute to investigations and technical corrective actions.',
    ],
    'HSE Manager': [
      'Provide project-level HSE governance, leadership and resources.',
      'Review significant risks, trends, serious incidents and major corrective actions.',
      'Ensure competent-person and contractor management arrangements are effective.',
      'Support stop-work decisions and verify system-level improvement.',
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        title: const Text('Advanced Learning'),
        backgroundColor: green,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
        children: [
          _hero(),
          const SizedBox(height: 12),
          _card('Core Explanation', item.points),
          const SizedBox(height: 10),
          _card('Field Verification', _fieldVerification()),
          const SizedBox(height: 10),
          _card('Critical Control Points', _criticalControls()),
          const SizedBox(height: 10),
          _card('Stop-Work Triggers', _stopWork()),
          const SizedBox(height: 10),
          _rolesCard(context),
          const SizedBox(height: 10),
          _deeperCard(context),
        ],
      ),
    );
  }

  Widget _hero() => Card(
        elevation: 1.5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(19),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item.title, style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w800, color: Color(0xFF10231D))),
              const SizedBox(height: 7),
              Text(item.subtitle, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: green)),
            ],
          ),
        ),
      );

  Widget _card(String title, List<String> values) => Card(
        child: Padding(
          padding: const EdgeInsets.all(17),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
              const SizedBox(height: 10),
              ...values.asMap().entries.map(
                    (e) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${e.key + 1}.', style: const TextStyle(fontWeight: FontWeight.w800, color: green)),
                          const SizedBox(width: 10),
                          Expanded(child: Text(e.value, style: const TextStyle(fontSize: 15, height: 1.5))),
                        ],
                      ),
                    ),
                  ),
            ],
          ),
        ),
      );

  List<String> _fieldVerification() => [
        'Confirm the approved project controls are available to the responsible team.',
        'Check the actual workface against the planned sequence and risk controls.',
        'Verify competent supervision, equipment condition, access and exclusion arrangements.',
        'Record deviations and ensure significant changes are reassessed before continuing.',
      ];

  List<String> _criticalControls() => [
        'Approved planning and risk controls before exposure.',
        'Competent people with clear authority and supervision.',
        'Physical barriers and engineering controls where required.',
        'Effective communication and interface coordination.',
        'Inspection, corrective action and verification.',
      ];

  List<String> _stopWork() => [
        'A serious hazard is uncontrolled.',
        'A critical safety barrier or protection system is missing or failed.',
        'Required competent supervision is absent.',
        'Actual conditions materially differ from the approved method.',
        'Continuing would expose people to unacceptable risk.',
      ];

  Widget _rolesCard(BuildContext context) => Card(
        child: Padding(
          padding: const EdgeInsets.all(17),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('HSE Roles — Topic-wise Responsibilities', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
              const SizedBox(height: 8),
              const Text('Tap a role to study the responsibility level in this topic.', style: TextStyle(height: 1.45)),
              const SizedBox(height: 8),
              ...roleResponsibilities.entries.map(
                (entry) => ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(entry.key, style: const TextStyle(fontWeight: FontWeight.w700)),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ConstructionSafetyRolePage(role: entry.key, points: entry.value),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Widget _deeperCard(BuildContext context) => Card(
        color: const Color(0xFFEAF4F0),
        child: ListTile(
          title: const Text('Go Deeper — Practical Decision Guide', style: TextStyle(fontWeight: FontWeight.w800)),
          subtitle: const Text('Use a field scenario to test whether the control is ready.'),
          trailing: const Icon(Icons.chevron_right_rounded),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const DubaiConstructionSafetyDeepLearningPage(),
            ),
          ),
        ),
      );
}

class ConstructionSafetyRolePage extends StatelessWidget {
  final String role;
  final List<String> points;

  const ConstructionSafetyRolePage({
    super.key,
    required this.role,
    required this.points,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8F7),
      appBar: AppBar(
        title: Text(role),
        backgroundColor: const Color(0xFF0B7653),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text('$role — Construction Safety Framework', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
          const SizedBox(height: 12),
          ...points.asMap().entries.map(
                (e) => Card(
                  margin: const EdgeInsets.only(bottom: 9),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${e.key + 1}.', style: const TextStyle(fontWeight: FontWeight.w800, color: Color(0xFF0B7653))),
                        const SizedBox(width: 10),
                        Expanded(child: Text(e.value, style: const TextStyle(fontSize: 15, height: 1.5))),
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

class DubaiConstructionSafetyDeepLearningPage extends StatelessWidget {
  const DubaiConstructionSafetyDeepLearningPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8F7),
      appBar: AppBar(
        title: const Text('Practical Decision Guide'),
        backgroundColor: const Color(0xFF0B7653),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Card(
            child: Padding(
              padding: EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Scenario: SIMOPS at a construction workfront', style: TextStyle(fontSize: 21, fontWeight: FontWeight.w800)),
                  SizedBox(height: 12),
                  Text(
                    'A crane lift, façade work and vehicle deliveries are planned in overlapping areas. Before work starts, the team should confirm the approved sequence, lifting controls, work-at-height protection, traffic segregation, exclusion zones, communication and supervision.',
                    style: TextStyle(fontSize: 15, height: 1.55),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Card(
            child: Padding(
              padding: EdgeInsets.all(17),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Decision Check', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                  SizedBox(height: 10),
                  Text('1. Are the risks assessed for the actual workface?', style: TextStyle(height: 1.5)),
                  SizedBox(height: 8),
                  Text('2. Are critical physical controls installed and verified?', style: TextStyle(height: 1.5)),
                  SizedBox(height: 8),
                  Text('3. Are responsibilities and communication clear?', style: TextStyle(height: 1.5)),
                  SizedBox(height: 8),
                  Text('4. Are simultaneous activities coordinated?', style: TextStyle(height: 1.5)),
                  SizedBox(height: 8),
                  Text('5. If a critical answer is no, stop and correct before exposure.', style: TextStyle(fontWeight: FontWeight.w700, height: 1.5)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
