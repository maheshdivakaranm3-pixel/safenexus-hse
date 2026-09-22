import 'package:flutter/material.dart';

import 'dubai_hse_detail_page.dart';
import 'models/reference_topic.dart';
import 'pages/dubai/dubai_construction_safety_framework_page.dart';
import 'pages/dubai/dubai_hse_construction_hse_plan_page.dart';
import 'pages/dubai/dubai_hse_management_page.dart';
import 'pages/dubai/excavation_trenching_page.dart';
import 'pages/dubai/lifting_operations_page.dart' as lifting;
import 'pages/dubai/scaffolding_safety_page.dart' as scaffolding;

class DubaiHsePartRouter {
  static Widget pageFor(ReferenceTopic topic) {
    switch (topic.id) {
      case 'dubai_construction_safety':
        return const DubaiConstructionSafetyFrameworkPage();
      case 'dubai_hse_management':
        return const DubaiHseManagementPage();
      case 'dubai_hse_plan':
        return DubaiHseConstructionHsePlanPage(topic: topic);
      case 'dubai_scaffolding':
        return const scaffolding.ScaffoldingSafetyPage();
      case 'dubai_excavation':
        return const ExcavationTrenchingPage();
      case 'dubai_lifting':
        return const lifting.LiftingOperationsPage();
      default:
        return DubaiHseDetailPage(topic: topic);
    }
  }
}
