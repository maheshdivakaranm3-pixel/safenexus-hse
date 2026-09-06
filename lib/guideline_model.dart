enum GuidelineCategory {
  uaeGeneral,
  abuDhabi,
  dubai,
}

extension GuidelineCategoryExtension on GuidelineCategory {
  String get label {
    switch (this) {
      case GuidelineCategory.uaeGeneral:
        return 'UAE General';
      case GuidelineCategory.abuDhabi:
        return 'Abu Dhabi';
      case GuidelineCategory.dubai:
        return 'Dubai';
    }
  }
}

class ReferenceTopic {
  final String title;
  final GuidelineCategory category;
  final String sourceLabel;
  final String copNumber;
  final String version;
  final String effectiveDate;

  final String shortDescription;
  final String overview;
  final String hazards;
  final String controls;
  final String planning;
  final String safePractices;
  final String ppe;
  final String checklist;
  final String inspection;
  final String dos;
  final String donts;
  final String stopWork;
  final String emergency;
  final String malayalam;

  const ReferenceTopic({
    required this.title,
    required this.category,
    required this.sourceLabel,
    required this.copNumber,
    required this.version,
    required this.effectiveDate,
    required this.shortDescription,
    required this.overview,
    required this.hazards,
    required this.controls,
    required this.planning,
    required this.safePractices,
    required this.ppe,
    required this.checklist,
    required this.inspection,
    required this.dos,
    required this.donts,
    required this.stopWork,
    required this.emergency,
    required this.malayalam,
  });
}
