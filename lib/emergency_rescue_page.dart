import 'package:flutter/material.dart';

import 'data/emergency_rescue/emergency_rescue_part1.dart';
import 'emergency_management.dart';

class EmergencyRescuePage extends StatelessWidget {
  const EmergencyRescuePage({super.key});

  static const Color _green = Color(0xFF0B5D4B);
  static const Color _background = Color(0xFFF5F8F7);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _background,
      appBar: AppBar(
        backgroundColor: _green,
        foregroundColor: Colors.white,
        title: const Text('Emergency & Rescue'),
        actions: [
          IconButton(
            tooltip: 'Emergency Records',
            icon: const Icon(Icons.assignment_outlined),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => const EmergencyManagementPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 18, 16, 28),
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF0B5D4B), Color(0xFF16865F)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.health_and_safety, color: Colors.white, size: 34),
                SizedBox(height: 12),
                Text(
                  'Professional HSE Field Handbook',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'Emergency preparedness, response, evacuation and rescue learning.',
                  style: TextStyle(color: Colors.white70, height: 1.35),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            'PART 1 — EMERGENCY FUNDAMENTALS',
            style: TextStyle(
              color: _green,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.5,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 10),
          ...emergencyRescuePart1.map(
            (topic) => Card(
              elevation: 0,
              margin: const EdgeInsets.only(bottom: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: const BorderSide(color: Color(0xFFE1EAE6)),
              ),
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                leading: CircleAvatar(
                  backgroundColor: const Color(0xFFE1F2E9),
                  foregroundColor: _green,
                  child: Text(
                    topic.id.replaceFirst('ER-', ''),
                    style: const TextStyle(fontWeight: FontWeight.w800),
                  ),
                ),
                title: Text(
                  topic.title,
                  style: const TextStyle(
                    color: Color(0xFF17324D),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(
                    topic.purpose,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                trailing: const Icon(Icons.chevron_right, color: _green),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => EmergencyRescueTopicPage(topic: topic),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => const EmergencyManagementPage(),
                ),
              );
            },
            icon: const Icon(Icons.assignment_outlined),
            label: const Text('Open Emergency Records & Drills'),
          ),
          const SizedBox(height: 12),
          const Text(
            'Training reference only. Follow the current site Emergency Response Plan, applicable authority requirements, and emergency-service instructions.',
            style: TextStyle(fontSize: 12, color: Colors.black54, height: 1.4),
          ),
        ],
      ),
    );
  }
}

class EmergencyRescueTopicPage extends StatelessWidget {
  const EmergencyRescueTopicPage({super.key, required this.topic});

  final EmergencyRescueTopic topic;

  static const Color _green = Color(0xFF0B5D4B);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8F7),
      appBar: AppBar(
        backgroundColor: _green,
        foregroundColor: Colors.white,
        title: Text(topic.title, maxLines: 1, overflow: TextOverflow.ellipsis),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _section('Purpose', <String>[topic.purpose]),
          _section('Scope & Applicability', <String>[topic.scope]),
          _section('Knowledge', topic.keyKnowledge),
          _section('Site Implementation', topic.siteImplementation),
          _section('Practical Example', topic.practicalExample),
          _section('Stop-Work Conditions', topic.stopWorkConditions),
          _section('Interview Preparation — Q&A', topic.interviewQuestions),
          const SizedBox(height: 12),
          const Text(
            'Use the approved site ERP and verified local requirements. This handbook does not replace site-specific training or competent emergency response.',
            style: TextStyle(fontSize: 12, color: Colors.black54, height: 1.4),
          ),
        ],
      ),
    );
  }

  Widget _section(String title, List<String> items) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: const BorderSide(color: Color(0xFFE1EAE6)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: _green,
                fontWeight: FontWeight.w800,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 10),
            ...items.map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 9),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 7),
                      child: Icon(Icons.circle, size: 6, color: _green),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        item,
                        style: const TextStyle(height: 1.42, fontSize: 14),
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
