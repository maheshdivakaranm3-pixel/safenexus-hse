import 'package:flutter/material.dart';
import 'data/interview/oil_gas/oil_gas_interview.dart';
import 'data/interview/abu_dhabi_hse_interview.dart';
import 'data/interview/oil_gas/oil_gas_safety_quiz.dart';

class LearningInterviewPage extends StatelessWidget {
  const LearningInterviewPage({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Learning & Interview')),
    body: ListView(padding: const EdgeInsets.all(16), children: [
      const Text('Interview Preparation', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      const SizedBox(height: 8), const Text('Choose a sector to begin interview practice.'),
      Card(child: ListTile(leading: const Icon(Icons.local_gas_station, color: Colors.green), title: const Text('Oil & Gas'), subtitle: const Text('150 questions across six interview levels'), trailing: const Icon(Icons.chevron_right), onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const OilGasInterviewLevelsPage())))),
      const SizedBox(height: 10),
      Card(
        child: ListTile(
          leading: const Icon(Icons.location_city, color: Colors.deepPurple),
          title: const Text('Abu Dhabi HSE Interview'),
          subtitle: const Text('Interview questions and objective practice'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AbuDhabiHseInterviewPage(),
            ),
          ),
        ),
      ),
    ]),
  );
}

class OilGasInterviewLevelsPage extends StatelessWidget {
  const OilGasInterviewLevelsPage({super.key});
  static const titles = ['Level 1 – Basic Interview','Level 2 – Technical Interview','Level 3 – Advanced Interview','Level 4 – Practical Site Scenario','Level 5 – Supervisor / Engineer Interview','Level 6 – UAE Authority-Specific Questions'];
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Oil & Gas Interview')),
    body: ListView(
      padding: const EdgeInsets.all(12),
      children: [
        for (var i = 0; i < titles.length; i++)
          Card(
            child: ListTile(
              leading: const Icon(Icons.menu_book, color: Colors.green),
              title: Text(titles[i]),
              subtitle: const Text('Questions & detailed model answers'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => OilGasQuestionListPage(
                    level: i + 1,
                    title: titles[i],
                  ),
                ),
              ),
            ),
          ),
        const SizedBox(height: 10),
        Card(
          child: ListTile(
            leading: const Icon(Icons.quiz, color: Colors.deepPurple),
            title: const Text('Oil & Gas Safety Quiz – 100 MCQs'),
            subtitle: const Text(
              'Interactive quiz • Score /100 • Pass mark 70%',
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const OilGasSafetyQuizPage(),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

class OilGasQuestionListPage extends StatelessWidget {
  final int level; final String title;
  const OilGasQuestionListPage({super.key, required this.level, required this.title});
  @override
  Widget build(BuildContext context) {
    final List<Map<String,String>> items = level == 1 ? [for (final s in OilGasLevel1BasicInterview.sections) for (final q in s.questions) {'question':q.question,'answer':q.answer,'technicalExplanation':q.technicalExplanation,'siteExample':q.practicalExample}] : level == 2 ? oilGasLevel2Questions : level == 3 ? oilGasLevel3Questions : level == 4 ? oilGasLevel4Questions : level == 5 ? oilGasLevel5Questions : oilGasLevel6Questions;
    return Scaffold(appBar: AppBar(title: Text(title)), body: ListView.builder(padding: const EdgeInsets.all(12), itemCount: items.length, itemBuilder: (context,i) { final q=items[i]; return Card(margin: const EdgeInsets.symmetric(vertical:6), child: ExpansionTile(title: Text(q['question'] ?? '', style: const TextStyle(fontWeight: FontWeight.w700)), childrenPadding: const EdgeInsets.fromLTRB(16,0,16,16), children: [_AnswerBlock(label:'Model Answer',text:q['answer'] ?? ''),_AnswerBlock(label:'Technical Explanation',text:q['technicalExplanation'] ?? ''),_AnswerBlock(label:'Practical Site Example',text:q['siteExample'] ?? q['practicalExample'] ?? '')]));}));
  }
}
class _AnswerBlock extends StatelessWidget {
 final String label,text; const _AnswerBlock({required this.label,required this.text});
 @override Widget build(BuildContext context)=>Padding(padding: const EdgeInsets.only(top:12), child: Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text(label,style:const TextStyle(fontWeight:FontWeight.bold,color:Color(0xFF159447))),const SizedBox(height:4),Text(text)]));
}
