import 'package:flutter/material.dart';

/// Standalone Advanced Learning page.
/// Kept independent so it does not depend on any model class from another file.
class DubaiConstructionSafetyAdvancedLearningPage extends StatelessWidget {
  final dynamic item;

  const DubaiConstructionSafetyAdvancedLearningPage({
    super.key,
    required this.item,
  });

  static const Color green = Color(0xFF0B7653);
  static const Color background = Color(0xFFF5F8F7);

  String get _title => item.title?.toString() ?? 'Construction Safety';
  String get _subtitle => item.subtitle?.toString() ?? 'Advanced HSE Learning';

  List<String> get _learning => _toStringList(item.learning);
  List<String> get _fieldChecks => _toStringList(item.fieldChecks);
  List<String> get _criticalControls => _toStringList(item.criticalControls);
  List<String> get _stopWork => _toStringList(item.stopWork);

  List<String> _toStringList(dynamic value) {
    if (value is Iterable) {
      return value.map((e) => e.toString()).toList();
    }
    return <String>[];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: const Text('Advanced Learning'),
        backgroundColor: green,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
        children: [
          _header(),
          const SizedBox(height: 12),
          _learningCard('1. Core Explanation', _learning),
          _learningCard('2. Field Verification', _fieldChecks),
          _learningCard('3. Critical Control Points', _criticalControls),
          _learningCard('4. Stop-Work Triggers', _stopWork),
          const SizedBox(height: 2),
          Card(
            color: const Color(0xFFEAF4F0),
            child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 17, vertical: 5),
              title: const Text(
                '5. Deeper Learning',
                style: TextStyle(fontWeight: FontWeight.w800),
              ),
              subtitle: const Text(
                'Open the practical field decision guide.',
              ),
              trailing: const Icon(Icons.chevron_right_rounded, size: 27),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        DubaiConstructionSafetyDeepLearningPage(
                      title: _title,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _header() {
    return Card(
      elevation: 1.5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(19),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _title,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w800,
                color: Color(0xFF10231D),
              ),
            ),
            const SizedBox(height: 7),
            Text(
              _subtitle,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: green,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _learningCard(String title, List<String> values) {
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
            if (values.isEmpty)
              const Text(
                'No additional points are available for this item.',
                style: TextStyle(fontSize: 14, height: 1.45),
              )
            else
              ...values.asMap().entries.map(
                    (entry) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${entry.key + 1}.',
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                              color: green,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              entry.value,
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
  final String title;

  const DubaiConstructionSafetyDeepLearningPage({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    const green = Color(0xFF0B7653);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F8F7),
      appBar: AppBar(
        title: const Text('Deeper Learning'),
        backgroundColor: green,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$title — Practical Decision Guide',
                    style: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Use the approved project arrangements and actual workface conditions as the basis for the decision. Do not proceed when a critical control cannot be verified.',
                    style: TextStyle(fontSize: 15, height: 1.55),
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
                  ...const [
                    'Plan the activity and define the safe sequence.',
                    'Assess the hazards and interfaces.',
                    'Verify critical controls at the workface.',
                    'Confirm competent personnel and supervision.',
                    'Coordinate simultaneous operations.',
                    'Check that actual conditions match the approved method.',
                    'Stop, reassess and correct when a critical control is not assured.',
                  ].asMap().entries.map(
                        (entry) => Padding(
                          padding: const EdgeInsets.only(bottom: 9),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${entry.key + 1}.',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                  color: green,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(child: Text(entry.value)),
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
