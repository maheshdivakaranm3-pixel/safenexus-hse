import 'package:flutter/material.dart';

import 'dubai_hse_detail_page.dart';
import 'models/reference_topic.dart';
import 'pages/dubai/dubai_hse_part1_page.dart';
import 'pages/dubai/scaffolding_safety_page.dart';
import 'pages/dubai/excavation_trenching_page.dart';
import 'pages/dubai/lifting_operations_page.dart';

class DubaiHsePartRouter {
  static Widget pageFor(ReferenceTopic topic) {
    switch (topic.id) {
      // PART 1 — Topics 1–10
      case 'dubai_construction_safety':
      case 'dubai_hse_management':
      case 'dubai_risk_assessment':
      case 'dubai_hse_plan':
      case 'dubai_work_at_height':
      case 'dubai_confined_space':
      case 'dubai_electrical':
        return DubaiHsePart1TopicPage(topicId: topic.id);

      // Existing dedicated benchmark pages
      case 'dubai_scaffolding':
        return const ScaffoldingSafetyPage();
      case 'dubai_lifting':
        return const LiftingOperationsPage();
      case 'dubai_excavation':
        return const ExcavationTrenchingPage();

      // Topics 11–37 remain on the existing detailed engine
      // until their dedicated part is implemented.
      default:
        return DubaiHseDetailPage(topic: topic);
    }
  }
}

// Compatibility for any existing code using this name.
class DubaiDedicatedPageRouter {
  static Widget pageFor(ReferenceTopic topic) {
    return DubaiHsePartRouter.pageFor(topic);
  }
}
