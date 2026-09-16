import 'package:flutter/material.dart';

import '../../dubai_hse_detail_page.dart';
import '../../models/reference_topic.dart';

import 'dubai_construction_safety_framework_page.dart';
import 'dubai_hse_construction_hse_plan_page.dart';
import 'dubai_hse_management_page.dart';
import 'scaffolding_safety_page.dart';
import 'excavation_trenching_page.dart';
import 'lifting_operations_page.dart';

/// Compatibility router for the legacy path.
///
/// Canonical router:
/// lib/dubai_hse_topic_router.dart
class DubaiHsePartRouter {
  static Widget pageFor(ReferenceTopic topic) {
    switch (topic.id) {
      case 'dubai_construction_safety':
        return const DubaiConstructionSafetyFrameworkPage();

      case 'dubai_hse_management':
        return const DubaiHseManagementPage();

      case 'dubai_hse_plan':
        return DubaiHseConstructionHsePlanPage(
          topic: topic,
        );

      case 'dubai_scaffolding':
        return const ScaffoldingSafetyPage();

      case 'dubai_excavation':
        return const ExcavationTrenchingPage();

      case 'dubai_lifting':
        return const LiftingOperationsPage();

      default:
        return DubaiHseDetailPage(
          topic: topic,
        );
    }
  }
}
