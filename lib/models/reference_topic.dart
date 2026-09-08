// ============================================================
// SafeNexus HSE
// Reference Topic Model
//
// Supports:
// • UAE General Guidelines
// • Abu Dhabi Guidelines
// • Dubai Guidelines
// • HSE Safety References
//
// This model is independent from UI pages.
// ============================================================

/// Main categories used by the SafeNexus HSE
/// professional HSE reference system.
enum GuidelineCategory {
  /// Shows all available guideline topics.
  all,

  /// UAE-wide / general safety requirements.
  uaeGeneral,

  /// Abu Dhabi specific HSE requirements.
  abuDhabi,

  /// Dubai specific HSE requirements.
  dubai,

  /// General professional HSE reference material.
  hseReference,
}

/// Represents one HSE guideline/reference topic.
class ReferenceTopic {
  // ============================================================
  // BASIC INFORMATION
  // ============================================================

  /// Unique identifier for the topic.
  ///
  /// Used for:
  /// • Search
  /// • Favorites
  /// • Future database storage
  /// • Deep linking
  /// • Analytics
  final String id;

  /// Main display title.
  final String title;

  /// Short title used for search and compact displays.
  final String shortTitle;

  /// Short professional description of the topic.
  final String description;

  // ============================================================
  // CLASSIFICATION
  // ============================================================

  /// Topic type/category.
  ///
  /// Examples:
  /// • Heat Stress
  /// • Working at Height
  /// • Fire Safety
  /// • PPE
  final String category;

  /// Responsible authority / organization.
  ///
  /// Examples:
  /// • MOHRE
  /// • ADOSH-SF
  /// • Dubai Municipality
  final String authority;

  /// Geographic or regulatory jurisdiction.
  ///
  /// Examples:
  /// • UAE
  /// • Abu Dhabi
  /// • Dubai
  final String jurisdiction;

  /// High-level SafeNexus category.
  final GuidelineCategory guidelineCategory;

  // ============================================================
  // DETAIL CONTENT
  // ============================================================

  /// Detailed guideline content.
  final String content;

  /// Important requirements / controls.
  final List<String> keyRequirements;

  /// Practical safety controls for HSE professionals.
  final List<String> safetyControls;

  /// Responsibilities of management, supervisors,
  /// workers and HSE personnel.
  final List<String> responsibilities;

  /// References or source information.
  final List<String> references;

  // ============================================================
  // CONSTRUCTOR
  // ============================================================

  const ReferenceTopic({
    required this.id,
    required this.title,
    required this.shortTitle,
    required this.description,
    required this.category,
    required this.authority,
    required this.jurisdiction,
    required this.guidelineCategory,
    this.content = '',
    this.keyRequirements = const <String>[],
    this.safetyControls = const <String>[],
    this.responsibilities = const <String>[],
    this.references = const <String>[],
  });

  // ============================================================
  // COPY WITH
  // ============================================================

  ReferenceTopic copyWith({
    String? id,
    String? title,
    String? shortTitle,
    String? description,
    String? category,
    String? authority,
    String? jurisdiction,
    GuidelineCategory? guidelineCategory,
    String? content,
    List<String>? keyRequirements,
    List<String>? safetyControls,
    List<String>? responsibilities,
    List<String>? references,
  }) {
    return ReferenceTopic(
      id: id ?? this.id,
      title: title ?? this.title,
      shortTitle: shortTitle ?? this.shortTitle,
      description: description ?? this.description,
      category: category ?? this.category,
      authority: authority ?? this.authority,
      jurisdiction: jurisdiction ?? this.jurisdiction,
      guidelineCategory:
          guidelineCategory ?? this.guidelineCategory,
      content: content ?? this.content,
      keyRequirements:
          keyRequirements ?? this.keyRequirements,
      safetyControls:
          safetyControls ?? this.safetyControls,
      responsibilities:
          responsibilities ?? this.responsibilities,
      references:
          references ?? this.references,
    );
  }

  // ============================================================
  // SEARCH HELPER
  // ============================================================

  /// Returns true when the topic contains the supplied
  /// search query.
  bool matchesSearch(String query) {
    final normalizedQuery = query.trim().toLowerCase();

    if (normalizedQuery.isEmpty) {
      return true;
    }

    return id.toLowerCase().contains(normalizedQuery) ||
        title.toLowerCase().contains(normalizedQuery) ||
        shortTitle.toLowerCase().contains(normalizedQuery) ||
        description.toLowerCase().contains(normalizedQuery) ||
        category.toLowerCase().contains(normalizedQuery) ||
        authority.toLowerCase().contains(normalizedQuery) ||
        jurisdiction.toLowerCase().contains(normalizedQuery) ||
        content.toLowerCase().contains(normalizedQuery) ||
        keyRequirements.any(
          (item) => item.toLowerCase().contains(normalizedQuery),
        ) ||
        safetyControls.any(
          (item) => item.toLowerCase().contains(normalizedQuery),
        ) ||
        responsibilities.any(
          (item) => item.toLowerCase().contains(normalizedQuery),
        ) ||
        references.any(
          (item) => item.toLowerCase().contains(normalizedQuery),
        );
  }

  // ============================================================
  // DEBUG / DISPLAY
  // ============================================================

  @override
  String toString() {
    return 'ReferenceTopic('
        'id: $id, '
        'title: $title, '
        'category: $category, '
        'authority: $authority, '
        'jurisdiction: $jurisdiction, '
        'guidelineCategory: $guidelineCategory'
        ')';
  }
}
