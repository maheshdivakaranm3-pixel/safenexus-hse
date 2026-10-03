import 'package:flutter/material.dart';
import 'industrial_part1.dart';
import 'industrial_part2.dart';
import 'industrial_part3.dart';
import 'industrial_part4.dart';
import 'industrial_office_documents_page.dart';

class IndustrialHandbookPage extends StatefulWidget {
  const IndustrialHandbookPage({super.key});
  @override
  State<IndustrialHandbookPage> createState() => _IndustrialHandbookPageState();
}

class _IndustrialHandbookPageState extends State<IndustrialHandbookPage> {
  static const green = Color(0xFF0B6B4B);
  static const topics = <IndustrialTopic>[
    ...industrialPart1, ...industrialPart2, ...industrialPart3, ...industrialPart4,
  ];
  String query = '';

  @override
  Widget build(BuildContext context) {
    final filtered = topics.where((t) => t.title.toLowerCase().contains(query.toLowerCase())).toList();
    return Scaffold(
      appBar: AppBar(title: const Text('Industrial HSE'), backgroundColor: green, foregroundColor: Colors.white),
      body: Column(children: [
        Padding(padding: const EdgeInsets.fromLTRB(14, 14, 14, 8), child: Card(
          color: const Color(0xFFE7F4EC),
          child: ListTile(
            leading: const Icon(Icons.folder_copy_outlined, color: green),
            title: const Text('Industrial Office Documents', style: TextStyle(fontWeight: FontWeight.w800, color: green)),
            subtitle: const Text('Prepare and save activity-specific working documents'),
            trailing: const Icon(Icons.chevron_right, color: green),
            onTap: () => Navigator.push(context, MaterialPageRoute<void>(builder: (_) => const IndustrialOfficeDocumentsPage())),
          ),
        )),
        Padding(padding: const EdgeInsets.fromLTRB(14, 0, 14, 8), child: TextField(
          decoration: const InputDecoration(prefixIcon: Icon(Icons.search), hintText: 'Search Industrial topics', border: OutlineInputBorder()),
          onChanged: (v) => setState(() => query = v),
        )),
        Expanded(child: ListView.builder(
          itemCount: filtered.length,
          itemBuilder: (context, index) {
            final topic = filtered[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              child: ListTile(
                leading: const Icon(Icons.factory_outlined, color: green),
                title: Text(topic.title, style: const TextStyle(fontWeight: FontWeight.w600)),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => Navigator.push(context, MaterialPageRoute<void>(builder: (_) => _IndustrialTopicDetail(topic: topic))),
              ),
            );
          },
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
  Widget build(BuildContext context) {
    final legacy = topic.permitsDocumentsRecords.isEmpty;
    return Scaffold(
      appBar: AppBar(title: Text(topic.title), backgroundColor: green, foregroundColor: Colors.white),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        if (legacy) ...[
          _section('Permits, Documents & Records', topic.documents.isEmpty ? ['Topic-specific approved risk assessment, JSA/SWMS, permits, inspection evidence and controlled records must be identified before work.'] : topic.documents),
          _section('Emergency, Rescue & Abnormal Conditions', [topic.emergency]),
          _section('Practical Industrial Site Example', [topic.siteExample]),
          _section('Common Non-compliance & Corrective Actions', topic.controls.isEmpty ? ['Stop unsafe work, make the area safe, assign corrective-action owner and verify closure at site.'] : topic.controls),
          _section('HSE Officer Interview Preparation', ['Explain task hazards, controls, permit triggers, stop-work authority and how you verify corrective action effectiveness.']),
          _section('Site Verification Checklist', ['Verify risk assessment, authorization, competence, equipment condition, barriers, emergency readiness, work monitoring and close-out records.']),
        ] else ...[
          _section('Permits, Documents & Records', topic.permitsDocumentsRecords),
          _section('Emergency, Rescue & Abnormal Conditions', topic.emergencyRescueAbnormal),
          _section('Practical Industrial Site Example', topic.practicalSiteExample),
          _section('Common Non-compliance & Corrective Actions', topic.commonNonComplianceCorrectiveActions),
          _section('HSE Officer Interview Preparation', topic.interviewPreparation),
          _section('Site Verification Checklist', topic.siteVerificationChecklist),
        ],
        const SizedBox(height: 18),
        FilledButton.icon(
          onPressed: () => Navigator.push(context, MaterialPageRoute<void>(builder: (_) => const IndustrialOfficeDocumentsPage())),
          icon: const Icon(Icons.description_outlined),
          label: const Text('Open Industrial Office Documents'),
        ),
      ]),
    );
  }

  Widget _section(String title, List<String> values) => Padding(
    padding: const EdgeInsets.only(top: 16),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title, style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
      const SizedBox(height: 6),
      ...values.map((v) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 7),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Padding(padding: EdgeInsets.only(top: 3), child: Icon(Icons.check_circle_outline, color: green, size: 20)),
          const SizedBox(width: 12),
          Expanded(child: Text(v, style: const TextStyle(fontSize: 16, height: 1.5))),
        ]),
      )),
    ]),
  );
}
