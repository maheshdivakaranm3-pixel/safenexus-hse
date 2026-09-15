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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8F7),
      appBar: AppBar(
        title: const Text('Advanced Learning'),
        backgroundColor: green,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(19),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    item.subtitle,
                    style: const TextStyle(
                      color: green,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          _card('Core Explanation', item.points),
          _card('Field Verification', const [
            'Confirm the approved control is available at the actual workface.',
            'Verify competent personnel, supervision and required equipment.',
            'Check that the physical condition matches the approved work method.',
            'Record deviations and reassess significant changes before continuing.',
          ]),
          _card('Critical Control Points', const [
            'Approved planning and risk controls.',
            'Competent personnel and effective supervision.',
            'Physical barriers and engineering controls where required.',
            'Effective communication and interface coordination.',
            'Inspection, corrective action and verification.',
          ]),
          _card('Stop-Work Triggers', const [
            'A serious hazard is uncontrolled.',
            'A critical safety barrier is missing or has failed.',
            'Required competent supervision is absent.',
            'Actual conditions materially differ from the approved method.',
            'Continuing would expose people to unacceptable risk.',
          ]),
          Card(
            color: const Color(0xFFEAF4F0),
            child: ListTile(
              title: const Text(
                'Deeper Learning',
                style: TextStyle(fontWeight: FontWeight.w800),
              ),
              subtitle: const Text(
                'Open the practical decision guide for this topic.',
              ),
              trailing: const Icon(Icons.chevron_right_rounded),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      DubaiConstructionSafetyDeepLearningPage(item: item),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _card(String title, List<String> values) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(17),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 10),
            ...values.asMap().entries.map(
                  (e) => Padding(
                    padding: const EdgeInsets.only(bottom: 9),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${e.key + 1}.',
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            color: green,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            e.value,
                            style: const TextStyle(
                              fontSize: 15,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}

class DubaiConstructionSafetyDeepLearningPage extends StatelessWidget {
  final ConstructionSafetyItem item;

  const DubaiConstructionSafetyDeepLearningPage({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8F7),
      appBar: AppBar(
        title: const Text('Deeper Learning'),
        backgroundColor: const Color(0xFF0B7653),
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${item.title} — Practical Decision Guide',
                    style: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Before work starts, verify that the planned controls can actually be implemented at the workface. If conditions differ from the approved arrangement, stop, reassess and establish a safe method before exposure.',
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.55,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(17),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Decision Sequence',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ...[
                    'Is the activity planned?',
                    'Are the hazards assessed?',
                    'Are critical controls physically available?',
                    'Are competent people and supervision in place?',
                    'Are interfaces and simultaneous operations controlled?',
                    'Does the actual work match the approved method?',
                    'If not, stop and correct before exposure.',
                  ].asMap().entries.map(
                        (e) => Padding(
                          padding: const EdgeInsets.only(bottom: 9),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${e.key + 1}.',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFF0B7653),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(child: Text(e.value)),
                            ],
                          ),
                        ),
                      ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
