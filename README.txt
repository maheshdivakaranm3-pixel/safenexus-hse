SAFE NEXUS HSE — DUBAI PART 1 TOPICS 1–10
LIFTING-PATTERN ROUTING FIX

Why the previous code had no visible effect:
The existing GuidelinesPage was still calling the old DubaiHseTopicRouter inside
lib/dubai_hse_detail_page.dart. That router only sent Scaffolding, Lifting and
Excavation to dedicated pages. Therefore the new Part 1 page was not being used.

This package fixes the routing at the source:
1. Add/replace:
   lib/pages/dubai/dubai_hse_part1_page.dart
2. Add/replace:
   lib/pages/dubai/dubai_hse_part1_advanced_learning_page.dart
3. Replace:
   lib/dubai_hse_topic_router.dart
4. In lib/guidelines.dart:
   - remove: import 'dubai_hse_detail_page.dart';
   - add:    import 'dubai_hse_topic_router.dart';
   - in _openTopic use:
       builder: (_) => DubaiHsePartRouter.pageFor(topic),

Topics routed to Part 1:
1 Dubai Construction Safety Framework
2 HSE Management System
3 Health & Safety Risk Assessment
4 Construction HSE Plan
5 Work at Height
6 Scaffolding Safety (existing dedicated benchmark)
7 Lifting Operations (existing dedicated benchmark)
8 Excavation & Trenching (existing dedicated benchmark)
9 Confined Space Entry
10 Electrical Safety

UI pattern:
Main topic -> expandable section -> small right chevron -> Advanced Learning.
No large green round arrow.

Do not create duplicate *_FINAL, *_V2 or *_UPLOAD_ONLY Dart files.
Do not change the existing Lifting Operations page.
Topics 11–20 are intentionally not changed by this package.
