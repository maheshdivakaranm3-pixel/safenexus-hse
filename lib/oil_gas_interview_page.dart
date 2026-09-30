import 'package:flutter/material.dart';
import 'data/interview/oil_gas/level_1_basic_interview.dart';

class LearningInterviewPage extends StatelessWidget {
  const LearningInterviewPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Learning & Interview')),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text(
              'Interview Preparation',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text('Choose a sector to begin interview practice.'),
            const SizedBox(height: 16),
            Card(
              child: ListTile(
                leading: const Icon(Icons.local_gas_station, color: Colors.green),
                title: const Text('Oil & Gas'),
                subtitle: const Text('Interview questions and model answers'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const OilGasInterviewLevelsPage(),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}

class OilGasInterviewLevelsPage extends StatelessWidget {
  const OilGasInterviewLevelsPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Oil & Gas Interview')),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Card(
              child: ListTile(
                leading: const Icon(Icons.menu_book, color: Colors.green),
                title: const Text('Level 1 – Basic Interview'),
                subtitle: const Text('Questions & Answers'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const OilGasLevel1QuestionsPage(),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}

class OilGasLevel1QuestionsPage extends StatelessWidget {
  const OilGasLevel1QuestionsPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Level 1 – Basic Interview')),
        body: ListView(
          padding: const EdgeInsets.all(12),
          children: [
            // Flatten all sections into one continuous numbered question list.
            // Section headings and their introductory descriptions are omitted.
            for (final section in OilGasLevel1BasicInterview.sections)
              for (final q in section.questions)
                Card(
                  margin: const EdgeInsets.symmetric(vertical: 7),
                  child: ExpansionTile(
                    title: Text(
                      q.question,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    childrenPadding:
                        const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    children: [
                      _AnswerBlock(label: 'Model Answer', text: q.answer),
                      _AnswerBlock(
                        label: 'Technical Explanation',
                        text: q.technicalExplanation,
                      ),
                      _AnswerBlock(
                        label: 'Practical Site Example',
                        text: q.practicalExample,
                      ),
                    ],
                  ),
                ),
          ],
        ),
      );
}

class _AnswerBlock extends StatelessWidget {
  final String label;
  final String text;

  const _AnswerBlock({required this.label, required this.text});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF159447),
              ),
            ),
            const SizedBox(height: 4),
            Text(text),
          ],
        ),
      );
}
