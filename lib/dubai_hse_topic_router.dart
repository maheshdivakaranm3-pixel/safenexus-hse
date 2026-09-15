import 'package:flutter/material.dart';

import 'dubai_hse_detail_page.dart';
import 'models/reference_topic.dart';

import 'pages/dubai/dubai_construction_safety_framework_page.dart';
import 'pages/dubai/dubai_hse_part1_page.dart';
import 'pages/dubai/dubai_hse_part2_page.dart';
import 'pages/dubai/scaffolding_safety_page.dart';
import 'pages/dubai/excavation_trenching_page.dart';
import 'pages/dubai/lifting_operations_page.dart';

class DubaiHsePartRouter {
  static Widget pageFor(ReferenceTopic topic) {
    switch (topic.id) {
      // ==========================================================
      // TOPIC 1 — DUBAI CONSTRUCTION SAFETY FRAMEWORK
      // ==========================================================
      case 'dubai_construction_safety':
        return const DubaiConstructionSafetyFrameworkPage();

      // ==========================================================
      // PART 1 — TEMPORARY COMPATIBILITY
      // ==========================================================
      case 'dubai_hse_management':
      case 'dubai_risk_assessment':
      case 'dubai_hse_plan':
      case 'dubai_work_at_height':
      case 'dubai_confined_space':
      case 'dubai_electrical':
        return DubaiHsePart1TopicPage(
          topicId: topic.id,
        );

      // ==========================================================
      // DEDICATED TOPICS
      // ==========================================================
      case 'dubai_scaffolding':
        return const ScaffoldingSafetyPage();

      case 'dubai_excavation':
        return const ExcavationTrenchingPage();

      case 'dubai_lifting':
        return const LiftingOperationsPage();

      // ==========================================================
      // PART 2 — TEMPORARY COMPATIBILITY
      // ==========================================================
      case 'dubai_hot_work':
      case 'dubai_traffic':
      case 'dubai_demolition':
      case 'dubai_temporary_works':
      case 'dubai_heat_stress':
      case 'dubai_occupational_health':
      case 'dubai_ppe':
      case 'dubai_emergency':
      case 'dubai_incident':
      case 'dubai_contractor':
        return DubaiHsePart2TopicPage(
          topicId: topic.id,
        );

      // ==========================================================
      // FALLBACK
      // ==========================================================
      default:
        return DubaiHseDetailPage(
          topic: topic,
        );
    }
  }
}
