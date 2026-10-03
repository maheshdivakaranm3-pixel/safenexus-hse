import 'package:flutter/material.dart';
import 'industrial_part1.dart';
import 'industrial_part2.dart';
import 'industrial_part3.dart';
import 'industrial_part4.dart';
import 'industrial_office_documents_page.dart';

/// Unified Industrial reference. The four source files remain internal only.
class IndustrialHandbookPage extends StatefulWidget {
  const IndustrialHandbookPage({super.key});
  @override
  State<IndustrialHandbookPage> createState() => _IndustrialHandbookPageState();
}

class _IndustrialHandbookPageState extends State<IndustrialHandbookPage> {
  static const green = Color(0xFF0B6B4B);
  static const topics = <IndustrialTopic>[...industrialPart1, ...industrialPart2, ...industrialPart3, ...industrialPart4];
  String query = '';
  @override
  Widget build(BuildContext context) {
    final filtered = topics.where((t) => t.title.toLowerCase().contains(query.toLowerCase())).toList();
    return Scaffold(
      appBar: AppBar(title: const Text('Industrial HSE'), backgroundColor: green, foregroundColor: Colors.white),
      body: Column(children: [
        Padding(padding: const EdgeInsets.fromLTRB(14, 14, 14, 8), child: Card(color: const Color(0xFFE7F4EC), child: ListTile(
          leading: const Icon(Icons.folder_copy_outlined, color: green),
          title: const Text('Industrial Office Documents', style: TextStyle(fontWeight: FontWeight.w800, color: green)),
          subtitle: const Text('Prepare and save activity-specific working documents'),
          trailing: const Icon(Icons.chevron_right, color: green),
          onTap: () => Navigator.push(context, MaterialPageRoute<void>(builder: (_) => const IndustrialOfficeDocumentsPage())),
        ))),
        Padding(padding: const EdgeInsets.fromLTRB(14, 0, 14, 8), child: TextField(
          decoration: const InputDecoration(prefixIcon: Icon(Icons.search), hintText: 'Search Industrial topics', border: OutlineInputBorder()),
          onChanged: (v) => setState(() => query = v),
        )),
        Expanded(child: ListView.builder(
          itemCount: filtered.length,
          itemBuilder: (context, index) { final topic = filtered[index]; return ListTile(
            leading: const Icon(Icons.factory_outlined, color: green), title: Text(topic.title, style: const TextStyle(fontWeight: FontWeight.w600)),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.push(context, MaterialPageRoute<void>(builder: (_) => _IndustrialTopicDetail(topic: topic))),
          ); },
        )),
      ]),
    );
  }
}

class _IndustrialTopicDetail extends StatelessWidget {
  const _IndustrialTopicDetail({required this.topic});
  final IndustrialTopic topic;
  static const green = Color(0xFF0B6B4B);
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(topic.title), backgroundColor: green, foregroundColor: Colors.white),
    body: ListView(padding: const EdgeInsets.all(16), children: [
      Text(topic.purpose, style: const TextStyle(fontSize: 16, height: 1.45)),
      _section('Hazards', topic.hazards), _section('Controls', topic.controls),
      _section('Related documents', topic.documents),
      const Text('Emergency response', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      Text(topic.emergency), const SizedBox(height: 12),
      const Text('Site example', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), Text(topic.siteExample),
      const SizedBox(height: 18),
      FilledButton.icon(onPressed: () => Navigator.push(context, MaterialPageRoute<void>(builder: (_) => const IndustrialOfficeDocumentsPage())), icon: const Icon(Icons.description_outlined), label: const Text('Open Industrial Office Documents')),
    ]),
  );
  Widget _section(String title, List<String> values) => Padding(padding: const EdgeInsets.only(top: 16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), ...values.map((v) => ListTile(dense: true, leading: const Icon(Icons.check_circle_outline, color: green), title: Text(v))) ]));
}
