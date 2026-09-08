/// ============================================================
/// SafeNexus HSE
/// Reference Topic Model
///
/// Central model for all UAE HSE guideline references.
///
/// Categories:
/// - UAE General
/// - Abu Dhabi
/// - Dubai
/// - Professional HSE Reference
/// ============================================================

import 'guideline_category.dart';

class ReferenceTopic {
  // ============================================================
  // BASIC INFORMATION
  // ============================================================

  final String id;
  final String title;
  final String shortTitle;

  // ============================================================
  // CLASSIFICATION
  // ============================================================

  final String category;
  final GuidelineCategory guidelineCategory;

  // ============================================================
  // AUTHORITY / JURISDICTION
  // ============================================================

  final String authority;
  final String jurisdiction;

  // ============================================================
  // DESCRIPTION
  // ============================================================

  final String description;

  // ============================================================
  // HSE CONTENT
  // ============================================================

  final List<String> keyRequirements;
  final List<String> safetyControls;
  final List<String> responsibilities;
  final List<String> references;

  // ============================================================
  // CONSTRUCTOR
  // ============================================================

  const ReferenceTopic({
    required this.id,
    required this.title,
    required this.shortTitle,
    required this.category,
    required this.guidelineCategory,
    required this.authority,
    required this.jurisdiction,
    required this.description,
    required this.keyRequirements,
    required this.safetyControls,
    required this.responsibilities,
    required this.references,
  });
}
