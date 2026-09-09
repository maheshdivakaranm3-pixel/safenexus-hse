/// ============================================================
/// SafeNexus HSE
/// Reference Topic Model
///
/// Central model for all UAE HSE guideline references.
///
/// Categories:
/// - All
/// - UAE General
/// - Abu Dhabi
/// - Dubai
/// - HSE Reference
///
/// This model is shared by:
/// - GuidelinesPage
/// - GuidelineDetailPage
/// - UAE General guideline data
/// - Abu Dhabi guideline data
/// - Dubai guideline data
/// - HSE Safety Reference data
/// ============================================================

import 'guideline_category.dart';

class ReferenceTopic {
  // ============================================================
  // BASIC INFORMATION
  // ============================================================

  /// Unique identifier for this reference topic.
  final String id;

  /// Full title displayed on the guideline detail page.
  final String title;

  /// Short title used in compact UI areas such as AppBar.
  final String shortTitle;

  // ============================================================
  // CLASSIFICATION
  // ============================================================

  /// Human-readable topic category.
  ///
  /// Example:
  /// - Fire Safety
  /// - Heat Stress
  /// - Emergency Preparedness
  /// - Construction Safety
  final String category;

  /// Main SafeNexus HSE category used by the category filter.
  final GuidelineCategory guidelineCategory;

  // ============================================================
  // AUTHORITY / JURISDICTION
  // ============================================================

  /// Relevant authority, regulator, standard body or reference owner.
  final String authority;

  /// Geographic or regulatory jurisdiction.
  ///
  /// Examples:
  /// - UAE
  /// - Abu Dhabi
  /// - Dubai
  final String jurisdiction;

  // ============================================================
  // DESCRIPTION
  // ============================================================

  /// Short professional overview of the topic.
  final String description;

  // ============================================================
  // HSE CONTENT
  // ============================================================

  /// Main requirements associated with the topic.
  final List<String> keyRequirements;

  /// Practical safety controls associated with the topic.
  final List<String> safetyControls;

  /// Responsibilities of relevant parties.
  final List<String> responsibilities;

  /// Supporting legislation, standards, codes or references.
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
    this.keyRequirements = const <String>[],
    this.safetyControls = const <String>[],
    this.responsibilities = const <String>[],
    this.references = const <String>[],
  });
}
