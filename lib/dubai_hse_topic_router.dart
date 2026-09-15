import 'package:flutter/material.dart';

import 'dubai_hse_detail_page.dart';
import 'models/reference_topic.dart';

import 'pages/dubai/dubai_construction_safety_framework_page.dart';
import 'pages/dubai/scaffolding_safety_page.dart';
import 'pages/dubai/excavation_trenching_page.dart';
import 'pages/dubai/lifting_operations_page.dart';

class DubaiHsePartRouter {
  static Widget pageFor(ReferenceTopic topic) {
    switch (topic.id) {
      case 'dubai_construction_safety':
        return const DubaiConstructionSafetyFrameworkPage();

      // HSE Management System opens its normal detail page first.
      // The page contains an explicit Advanced Learning button.
      case 'dubai_hse_management':
        return DubaiHseDetailPage(topic: topic);

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
