import 'package:flutter/material.dart';

import 'pages/dubai/scaffolding_safety_page.dart';
import 'pages/dubai/excavation_trenching_page.dart';
import 'pages/dubai/lifting_operations_page.dart';

class DubaiDedicatedPageRouter {
  static Widget? pageFor(String id) {
    switch (id) {
      case 'dubai_scaffolding_safety':
        return const ScaffoldingSafetyPage();
      case 'dubai_excavation_trenching':
        return const ExcavationTrenchingPage();
      case 'dubai_lifting_operations':
        return const LiftingOperationsPage();
      default:
        return null;
    }
  }
}
