import 'package:flutter/material.dart';
import 'data/environmental/environmental_topic_document.dart';
import 'data/environmental/environmental_part1.dart';
import 'data/environmental/environmental_part2.dart';

class EnvironmentalReferencePage extends StatelessWidget {
  const EnvironmentalReferencePage({super.key});
  static const green = Color(0xFF0B5D4B);
  @override
  Widget build(BuildContext context) {
    final topics = <EnvironmentalTopicDocument>[...environmentalPart1, ...environmentalPart2];
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8F7),
      appBar: AppBar(title: const Text('Environmental HSE Reference'), backgroundColor: green, foregroundColor: Colors.white),
      body: ListView(padding: const EdgeInsets.all(14), children: [
        Container(padding: const EdgeInsets.all(18), decoration: BoxDecoration(gradient: const LinearGradient(colors: [green, Color(0xFF16865F)]), borderRadius: BorderRadius.circular(18)), child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Icon(Icons.eco, color: Colors.white, size: 32), SizedBox(height: 10), Text('Environmental Protection & Compliance', style: TextStyle(color: Colors.white, fontSize: 19, fontWeight: FontWeight.bold)), SizedBox(height: 6), Text('Field handbook for environmental planning, pollution prevention, waste control, monitoring and records.', style: TextStyle(color: Colors.white, height: 1.4))])),
        const SizedBox(height: 16),
        const Text('PART 1 — MANAGEMENT SYSTEM & GOVERNANCE', style: TextStyle(color: green, fontWeight: FontWeight.w800)),
        const SizedBox(height: 8),
        ...environmentalPart1.map((t) => _tile(context, t)),
        const SizedBox(height: 12),
        const Text('PART 2 — OPERATIONAL ENVIRONMENTAL CONTROLS', style: TextStyle(color: green, fontWeight: FontWeight.w800)),
        const SizedBox(height: 8),
        ...environmentalPart2.map((t) => _tile(context, t)),
        const SizedBox(height: 12),
        const Text('Training reference only. Confirm applicable UAE/emirate authority requirements, permits, project EMP and approved plans. Legal limits and retention periods require current official verification.', style: TextStyle(fontSize: 12, color: Colors.black54, height: 1.4)),
      ]),
    );
  }
  Widget _tile(BuildContext context, EnvironmentalTopicDocument t) => Card(elevation: 0, margin: const EdgeInsets.only(bottom: 8), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14), side: const BorderSide(color: Color(0xFFE1EAE6))), child: ListTile(leading: CircleAvatar(backgroundColor: const Color(0xFFE1F2E9), foregroundColor: green, child: Text(t.number.toString().padLeft(2, '0'), style: const TextStyle(fontWeight: FontWeight.bold))), title: Text(t.title, style: const TextStyle(fontWeight: FontWeight.w700, color: Color(0xFF17324D))), subtitle: Padding(padding: const EdgeInsets.only(top: 5), child: Text(t.purpose, maxLines: 2, overflow: TextOverflow.ellipsis)), trailing: const Icon(Icons.chevron_right, color: green), onTap: () => Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => EnvironmentalTopicPage(topic: t))));
}

class EnvironmentalTopicPage extends StatelessWidget {
  const EnvironmentalTopicPage({super.key, required this.topic});
  final EnvironmentalTopicDocument topic;
  static const green = Color(0xFF0B5D4B);
  @override
  Widget build(BuildContext context) {
    final sections = <MapEntry<String, String>>[
      MapEntry('Definition', topic.definition), MapEntry('Purpose', topic.purpose), MapEntry('Regulatory Basis', topic.regulatoryBasis), MapEntry('Procedure / Field Method', topic.procedure), MapEntry('Required Documents & Records', topic.documents), MapEntry('Document Ownership & Control', topic.documentOwnership), MapEntry('Site Verification', topic.verification), MapEntry('Common Errors', topic.commonErrors), MapEntry('Practical Field Example', topic.fieldExample), MapEntry('Field Checklist', topic.checklist), MapEntry('Interview Preparation', topic.interview),
    ];
    return Scaffold(backgroundColor: const Color(0xFFF5F8F7), appBar: AppBar(title: Text('ENV-${topic.number.toString().padLeft(2, '0')}',), backgroundColor: green, foregroundColor: Colors.white), body: ListView(padding: const EdgeInsets.all(14), children: [Text(topic.title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Color(0xFF17324D))), const SizedBox(height: 12), ...sections.map((s) => Card(elevation: 0, margin: const EdgeInsets.only(bottom: 10), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14), side: const BorderSide(color: Color(0xFFE1EAE6))), child: Padding(padding: const EdgeInsets.all(15), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(s.key, style: const TextStyle(color: green, fontSize: 15, fontWeight: FontWeight.w800)), const SizedBox(height: 8), Text(s.value, style: const TextStyle(height: 1.5, fontSize: 14))]))))]));
  }
}
