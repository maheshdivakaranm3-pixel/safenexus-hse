import 'package:flutter/material.dart';

import 'dubai_hse_detail_page.dart';
import 'models/reference_topic.dart';
import 'pages/dubai/scaffolding_safety_page.dart';
import 'pages/dubai/excavation_trenching_page.dart';
import 'pages/dubai/lifting_operations_page.dart';

/// SafeNexus HSE — Dubai topic routing.
///
/// Existing Dubai topics remain on the established detail page.
/// The three completed dedicated pages are routed by their existing IDs.
class DubaiHseTopicRouter {
  static Widget pageFor(ReferenceTopic topic) {
    switch (topic.id) {
      case 'dubai_scaffolding':
        return const ScaffoldingSafetyPage();

      case 'dubai_excavation':
        return const ExcavationTrenchingPage();

      case 'dubai_lifting':
        return const LiftingOperationsPage();

      default:
        return DubaiHseDetailPage(topic: topic);
    }
  }
}
