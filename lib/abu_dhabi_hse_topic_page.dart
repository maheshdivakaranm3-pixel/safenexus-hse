import 'package:flutter/material.dart';
import 'data/abu_dhabi_hse_topics.dart';

class AbuDhabiHseTopicPage extends StatelessWidget {
  final AbuDhabiHseTopic topic;
  const AbuDhabiHseTopicPage({super.key, required this.topic});

  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);

  Widget _section(String title, List<String> items) {
    if (items.isEmpty) return const SizedBox.shrink();
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: darkGreen)),
          const SizedBox(height: 10),
          ...items.map((item) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('• ', style: TextStyle(fontWeight: FontWeight.bold, color: primaryGreen)),
              Expanded(child: Text(item)),
            ]),
          )),
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final c = topic.content;
    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(title: Text(topic.number), backgroundColor: darkGreen, foregroundColor: Colors.white),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        Card(elevation: 0, child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(topic.title, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.w800, color: darkGreen)),
            const SizedBox(height: 12),
            Wrap(spacing: 8, runSpacing: 8, children: [
              Chip(label: Text(topic.number)), Chip(label: Text(topic.version)),
              Chip(label: Text(topic.effectiveDate)), Chip(label: Text(topic.category)),
            ]),
          ]),
        )),
        const SizedBox(height: 12),
        Card(elevation: 0, child: Padding(padding: const EdgeInsets.all(16), child: Text(c.overview))),
        _section('Key Areas', c.keyAreas),
        _section('Field Practical', c.fieldPractice),
        _section('Records & Evidence', c.records),
        _section('Regulatory Verification', c.verificationNotes),
        Card(elevation: 0, child: Padding(
          padding: const EdgeInsets.all(16),
          child: SelectableText('Official source:\n$abuDhabiHseOfficialSource'),
        )),
      ]),
    );
  }
}
