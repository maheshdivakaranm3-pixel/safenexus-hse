import 'package:flutter/material.dart';

class DubaiDetailItem {
  final String title;
  final String subtitle;
  final List<String> details;
  const DubaiDetailItem({
    required this.title,
    required this.subtitle,
    required this.details,
  });
}

class DubaiDetailSection {
  final String title;
  final String body;
  const DubaiDetailSection(this.title, this.body);
}

class DubaiTopicPage extends StatelessWidget {
  final String title;
  final String emoji;
  final String introduction;
  final List<DubaiDetailSection> sections;
  final List<DubaiDetailItem> tappableItems;

  const DubaiTopicPage({
    super.key,
    required this.title,
    required this.emoji,
    required this.introduction,
    required this.sections,
    required this.tappableItems,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _card(
            '$emoji  Introduction — What is it?',
            introduction,
          ),
          const SizedBox(height: 10),
          ...sections.map((s) => _expandable(s)),
          if (tappableItems.isNotEmpty) ...[
            const SizedBox(height: 10),
            const Text(
              '🔎 Tap to explore',
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            ...tappableItems.map((item) => Card(
                  child: ListTile(
                    title: Text(item.title,
                        style: const TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text(item.subtitle),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DubaiItemPage(item: item),
                      ),
                    ),
                  ),
                )),
          ],
        ],
      ),
    );
  }

  Widget _card(String heading, String body) => Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(heading,
                  style: const TextStyle(
                      fontSize: 19, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Text(body, style: const TextStyle(fontSize: 15, height: 1.45)),
            ],
          ),
        ),
      );

  Widget _expandable(DubaiDetailSection section) => Card(
        child: ExpansionTile(
          title: Text(section.title,
              style: const TextStyle(fontWeight: FontWeight.w600)),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Text(section.body,
                  style: const TextStyle(fontSize: 15, height: 1.45)),
            ),
          ],
        ),
      );
}

class DubaiItemPage extends StatelessWidget {
  final DubaiDetailItem item;
  const DubaiItemPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(item.title)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(item.title,
              style:
                  const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Text(item.subtitle),
          const SizedBox(height: 14),
          ...item.details.map((d) => Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(d,
                      style: const TextStyle(fontSize: 15, height: 1.5)),
                ),
              )),
        ],
      ),
    );
  }
}

class LiftingOperationsPage extends StatelessWidget {
  const LiftingOperationsPage({super.key});

  static const items = <DubaiDetailItem>[
    DubaiDetailItem(title: 'Mobile Crane', subtitle: 'Crane mounted on a mobile carrier', details: [
      'Focus: Rated capacity, radius, ground condition, outriggers, lift plan and exclusion zone.',
      'Rule: Never exceed the approved configuration or capacity.',
    ]),
    DubaiDetailItem(title: 'Tower Crane', subtitle: 'Fixed construction crane', details: [
      'Focus: Load/radius limits, lifting accessories, communication, exclusion zone and competent operation.',
    ]),
    DubaiDetailItem(title: 'Crawler Crane', subtitle: 'Crawler-mounted crane', details: [
      'Focus: Ground condition, configuration, load chart, positioning and exclusion zones.',
    ]),
    DubaiDetailItem(title: 'Truck-Mounted Crane', subtitle: 'Crane installed on a truck', details: [
      'Focus: Vehicle stability, outriggers, ground bearing, load/radius and safe positioning.',
    ]),
    DubaiDetailItem(title: 'Hoist', subtitle: 'Mechanical lifting appliance', details: [
      'Focus: Rated capacity, support/anchorage, hook and mechanism condition, inspection and safe operation.',
    ]),
    DubaiDetailItem(title: 'Web Sling', subtitle: 'Flexible lifting accessory', details: [
      'Checks: Identification/WLL, cuts, abrasion, heat/chemical damage, stitching and correct configuration.',
      'Never use a damaged or unidentified sling.',
    ]),
    DubaiDetailItem(title: 'Wire Rope Sling', subtitle: 'Wire-rope lifting accessory', details: [
      'Checks: Rope condition, end fittings, deformation, corrosion, broken wires and identification.',
    ]),
    DubaiDetailItem(title: 'Shackle', subtitle: 'Lifting connector', details: [
      'Checks: Identification/WLL, body, pin, deformation, cracks and correct loading direction.',
    ]),
    DubaiDetailItem(title: 'Spreader Beam', subtitle: 'Load-distribution lifting beam', details: [
      'Focus: Approved design, rated capacity, lifting points, inspection and correct load distribution.',
    ]),
    DubaiDetailItem(title: 'Tag Line', subtitle: 'Controls load movement', details: [
      'Purpose: Helps control rotation/positioning from a safe location.',
      'Never place yourself in a crush zone or wrap the line around the body.',
    ]),
    DubaiDetailItem(title: 'Banksman / Signalman', subtitle: 'Controls and communicates movement', details: [
      'Focus: Agreed signals, communication, exclusion zone and stopping the lift when unsafe.',
    ]),
  ];

  static const sections = <DubaiDetailSection>[
    DubaiDetailSection('📏 Technical Requirements', 'Approved lifting plan; verified load weight; crane capacity and radius; ground condition; outrigger arrangement; lifting-accessory inspection; WLL/SWL verification; competent operator and lifting team; communication; exclusion zone. Exact limits must follow the applicable Dubai requirement, equipment manufacturer information and approved lift plan.'),
    DubaiDetailSection('⚠️ Main Lifting Hazards', 'Dropped load; crane overturning; sling/accessory failure; overloading; collision; crushing; suspended-load exposure; electrical contact; poor ground; poor communication.'),
    DubaiDetailSection('🛡️ Safety Controls', 'Plan the lift; use competent personnel; inspect equipment/accessories; confirm load and radius; establish exclusion zone; use correct accessories; maintain communication; never stand under a suspended load.'),
    DubaiDetailSection('🔍 Pre-Lift Inspection', 'Check crane condition, hook/latch, wire rope, slings, shackles, load weight, ground, outriggers, weather/wind, communication and exclusion zone.'),
    DubaiDetailSection('🪝 Lifting Accessories', 'Select accessories suitable for the load and configuration. Verify identification and WLL/SWL, inspect condition and reject damaged, unidentified or unsuitable equipment.'),
    DubaiDetailSection('🛑 Stop-Work Conditions', 'Unknown load weight; damaged sling/accessory; overloaded crane; unstable ground; unsafe weather; people in exclusion zone; communication failure; defective equipment; unexpected load behaviour.'),
    DubaiDetailSection('👷 Lifting Team Responsibilities', 'Lifting supervisor controls the operation; crane operator operates within limits; rigger prepares and secures the load; banksman/signalman controls signals and movement.'),
    DubaiDetailSection('🚨 Emergency Response', 'Dropped load/incident: STOP → ISOLATE → ALARM → KEEP PEOPLE OUT → EMERGENCY RESPONSE → FIRST AID WITHIN COMPETENCE → SECURE EQUIPMENT → REPORT & INVESTIGATE.'),
    DubaiDetailSection('👷 Practical Site Example', 'Equipment lift: verify weight → radius → crane capacity → ground/out riggers → accessories → exclusion zone → communication → controlled lift → monitor stability → safe lowering.'),
    DubaiDetailSection('🧠 Quick Learning Formula', 'PLAN → CHECK → RIG → EXCLUDE → LIFT → CONTROL → LOWER'),
  ];

  @override
  Widget build(BuildContext context) => DubaiTopicPage(
    title: 'Lifting Operations — Dubai HSE',
    emoji: '🏗️',
    introduction: 'A lifting operation involves planning, preparing, lifting, moving and lowering a load using a crane, hoist or other lifting appliance. Safe lifting depends on competent people, suitable equipment, verified load information, planned movement and controlled exclusion zones.',
    sections: sections,
    tappableItems: items,
  );
}
