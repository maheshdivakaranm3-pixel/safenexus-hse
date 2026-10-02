import 'package:flutter/material.dart';
import 'occupational_health_part1.dart';
import 'occupational_health_part2.dart';
import 'occupational_health_part3.dart';
import 'occupational_health_part4.dart';
import 'occupational_health_office_documents_page.dart';

class OccupationalHealthHandbookPage extends StatelessWidget {
  const OccupationalHealthHandbookPage({super.key});
  static const green = Color(0xFF0B5D4B);
  static const paleGreen = Color(0xFFE5F4E9);

  @override
  Widget build(BuildContext context) {
    final topics = <HandbookTopic>[
      ...occupationalHealthPart1,
      ...occupationalHealthPart2,
      ...occupationalHealthPart3,
      ...occupationalHealthPart4,
    ];
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8F7),
      appBar: AppBar(title: const Text('Occupational Health'), backgroundColor: green, foregroundColor: Colors.white),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: topics.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Card(
              color: paleGreen,
              margin: const EdgeInsets.only(bottom: 14),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                leading: const CircleAvatar(backgroundColor: green, child: Icon(Icons.folder_copy_outlined, color: Colors.white)),
                title: const Text('Office Documents & Templates', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                subtitle: const Text('40 editable document types, responsibilities and checklists'),
                trailing: const Icon(Icons.chevron_right, color: green),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const OccupationalHealthOfficeDocumentsPage())),
              ),
            );
          }
          final topic = topics[index - 1];
          return Card(
            color: Colors.white,
            margin: const EdgeInsets.only(bottom: 9),
            child: ListTile(
              leading: const CircleAvatar(backgroundColor: paleGreen, child: Icon(Icons.health_and_safety, color: Color(0xFF159447))),
              title: Text(topic.title, style: const TextStyle(fontWeight: FontWeight.w600)),
              trailing: const Icon(Icons.chevron_right, color: green),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => _OccupationalHealthTopicDetail(topic: topic))),
            ),
          );
        },
      ),
    );
  }
}

class _OccupationalHealthTopicDetail extends StatelessWidget {
  final HandbookTopic topic;
  const _OccupationalHealthTopicDetail({required this.topic});
  Widget section(String title, String body) => Padding(
    padding: const EdgeInsets.only(bottom: 20),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Color(0xFF0B5D4B))),
      const SizedBox(height: 7), SelectableText(body, style: const TextStyle(fontSize: 15, height: 1.5)),
    ]),
  );
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: const Color(0xFFF6F8F7),
    appBar: AppBar(title: Text(topic.title, maxLines: 2, overflow: TextOverflow.ellipsis), backgroundColor: const Color(0xFF0B5D4B), foregroundColor: Colors.white),
    body: ListView(padding: const EdgeInsets.all(18), children: [
      section('1. Definition, purpose & applicability', topic.overview),
      section('2. Detailed site implementation & controls', topic.field),
      section('3. Office documents, evidence & records', topic.records),
      section('4. UAE project compliance and professional review', 'Confirm current UAE federal, emirate, regulator, client and sector requirements applicable to the project. Use approved project criteria and competent occupational health advice.'),
    ]),
  );
}
