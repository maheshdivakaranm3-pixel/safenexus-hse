import 'package:flutter/material.dart';

import 'data/emergency_rescue/emergency_rescue_part1.dart';
import 'data/emergency_rescue/emergency_rescue_part2.dart';
import 'data/emergency_rescue/emergency_rescue_part3.dart';
import 'data/emergency_rescue/emergency_rescue_part4.dart';
import 'data/emergency_rescue/emergency_rescue_part5.dart';
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
                SizedBox(height: 7),
                Text(
                  'Emergency preparedness, response, evacuation and rescue guidance for HSE Officers, Supervisors and Emergency Team members.',
                  style: TextStyle(color: Colors.white, height: 1.45),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
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
          ...emergencyRescuePart1.map((topic) => _topicTile(context, topic)),
          const SizedBox(height: 12),
          const Text(
            'PART 2 — EVACUATION, FIRE, MEDICAL & RESCUE',
            style: TextStyle(
              color: _green,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.5,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 10),
          ...emergencyRescuePart2.map((topic) => _topicTile(context, topic)),
          const SizedBox(height: 12),
          const Text(
            'PART 3 — WORK AT HEIGHT, LIFTING, ELECTRICAL & CHEMICAL RESPONSE',
            style: TextStyle(
              color: _green,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.5,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 10),
          ...emergencyRescuePart3.map((topic) => _topicTile(context, topic)),
          const SizedBox(height: 12),
          const Text(
            'PART 4 — TRAFFIC, MACHINERY, WATER & HEAT EMERGENCIES',
            style: TextStyle(
              color: _green,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.5,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 10),
          ...emergencyRescuePart4.map((topic) => _topicTile(context, topic)),
          const SizedBox(height: 12),
          const Text(
            'PART 5 — SPECIAL EMERGENCIES, DRILLS & CONTINUOUS IMPROVEMENT',
            style: TextStyle(
              color: _green,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.5,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 10),
          ...emergencyRescuePart5.map((topic) => _topicTile(context, topic)),

          const SizedBox(height: 10),
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
            'Training reference only. Follow the current site Emergency Response Plan, approved rescue arrangements, applicable authority requirements and emergency-service instructions. Verify legal limits and mandatory intervals from current official sources.',
            style: TextStyle(fontSize: 12, color: Colors.black54, height: 1.45),
          ),
        ],
      ),
    );
  }

  Widget _topicTile(BuildContext context, EmergencyRescueTopic topic) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Color(0xFFE1EAE6)),
      ),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        leading: CircleAvatar(
          radius: 23,
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
          padding: const EdgeInsets.only(top: 7),
          child: Text(
            topic.purpose,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(height: 1.35),
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
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFE4F2EC),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.menu_book, color: _green, size: 24),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    '${topic.id} • Field Handbook Explanation',
                    style: const TextStyle(
                      color: _green,
                      fontWeight: FontWeight.w800,
                      height: 1.35,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _section('1. Purpose — Why this topic matters', <String>[topic.purpose]),
          _section('2. Scope & Applicability', <String>[topic.scope]),
          _section('3. Knowledge — Detailed Explanation', topic.keyKnowledge),
          _section('4. Site Implementation — Practical Actions', topic.siteImplementation),
          _section('5. Practical Site Example', topic.practicalExample),
          _section('6. Stop-Work / Escalation Conditions', topic.stopWorkConditions),
          _section('7. Interview Preparation — Questions & Answers', topic.interviewQuestions),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF4DB),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFEBD9A8)),
            ),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.info_outline, color: Color(0xFF8A5A00)),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Field reminder: Protect life first. Raise the alarm early. Do not attempt an unplanned rescue or enter an uncontrolled hazard. Follow the approved site ERP and competent responder instructions.',
                    style: TextStyle(height: 1.4, color: Color(0xFF654A16)),
                  ),
                ),
              ],
            ),
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
                height: 1.3,
              ),
            ),
            const SizedBox(height: 12),
            ...items.asMap().entries.map(
              (entry) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 7),
                      child: Icon(
                        entry.key == 0 && title.startsWith('5.')
                            ? Icons.lightbulb_outline
                            : Icons.circle,
                        size: entry.key == 0 && title.startsWith('5.') ? 17 : 6,
                        color: _green,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        entry.value,
                        style: const TextStyle(
                          height: 1.5,
                          fontSize: 14,
                          color: Color(0xFF263238),
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
