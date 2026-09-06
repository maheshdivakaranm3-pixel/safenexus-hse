import 'package:flutter/material.dart';

enum GuidelineCategory {
  all,
  uaeGeneral,
  abuDhabi,
  dubai,
}

extension GuidelineCategoryExtension on GuidelineCategory {
  String get label {
    switch (this) {
      case GuidelineCategory.all:
        return 'All';
      case GuidelineCategory.uaeGeneral:
        return 'UAE General';
      case GuidelineCategory.abuDhabi:
        return 'Abu Dhabi';
      case GuidelineCategory.dubai:
        return 'Dubai';
    }
  }

  String get shortLabel {
    switch (this) {
      case GuidelineCategory.all:
        return 'All';
      case GuidelineCategory.uaeGeneral:
        return 'UAE';
      case GuidelineCategory.abuDhabi:
        return 'Abu Dhabi';
      case GuidelineCategory.dubai:
        return 'Dubai';
    }
  }

  Color get color {
    switch (this) {
      case GuidelineCategory.all:
        return const Color(0xFF159447);
      case GuidelineCategory.uaeGeneral:
        return const Color(0xFF0B5D4B);
      case GuidelineCategory.abuDhabi:
        return const Color(0xFF1565C0);
      case GuidelineCategory.dubai:
        return const Color(0xFF8E24AA);
    }
  }

  IconData get icon {
    switch (this) {
      case GuidelineCategory.all:
        return Icons.apps_rounded;
      case GuidelineCategory.uaeGeneral:
        return Icons.public_rounded;
      case GuidelineCategory.abuDhabi:
        return Icons.location_city_rounded;
      case GuidelineCategory.dubai:
        return Icons.apartment_rounded;
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

  String get categoryLabel => category.label;

  Color get categoryColor => category.color;

  IconData get categoryIcon => category.icon;
}
