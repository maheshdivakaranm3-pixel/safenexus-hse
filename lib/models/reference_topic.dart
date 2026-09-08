/// SafeNexus HSE
/// Reference Topic Model
///
/// This model is shared by all guideline/reference data sources:
/// - UAE General
/// - Abu Dhabi
/// - Dubai
/// - HSE Safety Reference
///
/// Keep this model stable. New guideline data should use this model
/// instead of creating separate models for each emirate.

class ReferenceTopic {
  final String id;
  final String title;
  final String shortTitle;
  final String category;
  final String authority;
  final String jurisdiction;
  final String description;
  final GuidelineCategory guidelineCategory;

  const ReferenceTopic({
    required this.id,
    required this.title,
    required this.shortTitle,
    required this.category,
    required this.authority,
    required this.jurisdiction,
    required this.description,
    required this.guidelineCategory,
  });
}

/// Main categories used by the SafeNexus HSE Guidelines module.
///
/// Keep these names stable because main.dart and guideline data files
/// may use them for filtering and displaying categories.
enum GuidelineCategory {
  uaeGeneral,
  abuDhabi,
  dubai,
  hseSafety,
}
