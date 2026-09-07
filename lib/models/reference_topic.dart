enum GuidelineCategory {
  all,
  uaeGeneral,
  abuDhabi,
  dubai,
  hseReference,
}

class ReferenceTopic {
  final String id;
  final String title;
  final String shortTitle;
  final String description;
  final String category;
  final String authority;
  final String jurisdiction;
  final List<String> keyRequirements;
  final List<String> safetyControls;
  final List<String> responsibilities;
  final List<String> references;

  const ReferenceTopic({
    required this.id,
    required this.title,
    required this.shortTitle,
    required this.description,
    required this.category,
    required this.authority,
    required this.jurisdiction,
    required this.keyRequirements,
    required this.safetyControls,
    required this.responsibilities,
    required this.references,
  });

  GuidelineCategory get guidelineCategory {
    final normalizedCategory = category
        .trim()
        .toLowerCase()
        .replaceAll('_', ' ')
        .replaceAll('-', ' ')
        .replaceAll(RegExp(r'\s+'), ' ');

    switch (normalizedCategory) {
      case 'abu dhabi':
        return GuidelineCategory.abuDhabi;

      case 'dubai':
        return GuidelineCategory.dubai;

      case 'hse safety reference':
      case 'hse reference':
      case 'construction safety':
        return GuidelineCategory.hseReference;

      case 'uae':
      case 'uae general':
      case 'general':
      case 'all':
      case '':
        return GuidelineCategory.uaeGeneral;

      default:
        return GuidelineCategory.uaeGeneral;
    }
  }
}
