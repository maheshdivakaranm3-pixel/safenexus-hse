enum GuidelineCategory {
  all,
  uaeGeneral,
  abuDhabi,
  dubai,
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
    switch (category.toLowerCase()) {
      case 'abu dhabi':
        return GuidelineCategory.abuDhabi;
      case 'dubai':
        return GuidelineCategory.dubai;
      default:
        return GuidelineCategory.uaeGeneral;
    }
  }
}
