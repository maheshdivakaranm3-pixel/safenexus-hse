// lib/models/hse_work_model.dart

/// Represents one HSE document/checklist requirement
/// associated with a work activity.
class HseDocumentRequirement {
  final String id;
  final String title;
  final String category;
  final String description;
  final bool mandatory;
  final bool requiresExpiry;
  final bool requiresSignature;

  const HseDocumentRequirement({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    this.mandatory = true,
    this.requiresExpiry = false,
    this.requiresSignature = false,
  });
}

/// Represents one HSE work activity.
///
/// Example:
/// Excavation, Hot Work, Lifting Operation,
/// Work at Height, Confined Space, Electrical Work, etc.
class HseWorkActivity {
  final String id;
  final String title;
  final String category;
  final String description;
  final List<HseDocumentRequirement> requiredDocuments;

  const HseWorkActivity({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.requiredDocuments,
  });

  /// Number of mandatory documents for this activity.
  int get mandatoryDocumentCount {
    return requiredDocuments
        .where((document) => document.mandatory)
        .length;
  }

  /// Number of documents that require an expiry date.
  int get expiryDocumentCount {
    return requiredDocuments
        .where((document) => document.requiresExpiry)
        .length;
  }

  /// Creates a copy with selected values changed.
  HseWorkActivity copyWith({
    String? id,
    String? title,
    String? category,
    String? description,
    List<HseDocumentRequirement>? requiredDocuments,
  }) {
    return HseWorkActivity(
      id: id ?? this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      description: description ?? this.description,
      requiredDocuments:
          requiredDocuments ?? this.requiredDocuments,
    );
  }
}

/// Status of an HSE work-pack document.
enum HseDocumentStatus {
  pending,
  completed,
  expired,
  notApplicable,
}

/// A saved document/record inside an HSE Work Pack.
class HseWorkDocument {
  final String requirementId;
  final String title;
  final String category;
  final HseDocumentStatus status;
  final String fileName;
  final String filePath;
  final DateTime? issueDate;
  final DateTime? expiryDate;
  final String notes;

  const HseWorkDocument({
    required this.requirementId,
    required this.title,
    required this.category,
    this.status = HseDocumentStatus.pending,
    this.fileName = '',
    this.filePath = '',
    this.issueDate,
    this.expiryDate,
    this.notes = '',
  });

  HseWorkDocument copyWith({
    String? requirementId,
    String? title,
    String? category,
    HseDocumentStatus? status,
    String? fileName,
    String? filePath,
    DateTime? issueDate,
    DateTime? expiryDate,
    String? notes,
  }) {
    return HseWorkDocument(
      requirementId:
          requirementId ?? this.requirementId,
      title: title ?? this.title,
      category: category ?? this.category,
      status: status ?? this.status,
      fileName: fileName ?? this.fileName,
      filePath: filePath ?? this.filePath,
      issueDate: issueDate ?? this.issueDate,
      expiryDate: expiryDate ?? this.expiryDate,
      notes: notes ?? this.notes,
    );
  }
}

/// Represents a complete HSE Work Pack.
///
/// One Work Pack belongs to one project/activity and contains
/// all required HSE documentation and records.
class HseWorkPack {
  final String id;
  final String projectName;
  final String clientName;
  final String contractorName;
  final String location;
  final String emirate;
  final String activityId;
  final String activityTitle;
  final String supervisorName;
  final String hseOfficerName;
  final DateTime workStartDate;
  final DateTime? plannedEndDate;
  final String workDescription;
  final List<HseWorkDocument> documents;
  final String generalNotes;
  final DateTime createdAt;
  final DateTime updatedAt;

  const HseWorkPack({
    required this.id,
    required this.projectName,
    required this.clientName,
    required this.contractorName,
    required this.location,
    required this.emirate,
    required this.activityId,
    required this.activityTitle,
    required this.supervisorName,
    required this.hseOfficerName,
    required this.workStartDate,
    required this.plannedEndDate,
    required this.workDescription,
    required this.documents,
    required this.generalNotes,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Total number of documents in this work pack.
  int get totalDocuments {
    return documents.length;
  }

  /// Number of completed documents.
  int get completedDocuments {
    return documents
        .where(
          (document) =>
              document.status ==
              HseDocumentStatus.completed,
        )
        .length;
  }

  /// Number of pending documents.
  int get pendingDocuments {
    return documents
        .where(
          (document) =>
              document.status ==
              HseDocumentStatus.pending,
        )
        .length;
  }

  /// Number of expired documents.
  int get expiredDocuments {
    return documents
        .where(
          (document) =>
              document.status ==
              HseDocumentStatus.expired,
        )
        .length;
  }

  /// Completion percentage.
  double get completionPercentage {
    if (totalDocuments == 0) {
      return 0;
    }

    return completedDocuments /
        totalDocuments;
  }

  /// True when every required document is completed
  /// or marked not applicable.
  bool get isReadyForWork {
    return documents.every(
      (document) =>
          document.status ==
              HseDocumentStatus.completed ||
          document.status ==
              HseDocumentStatus.notApplicable,
    );
  }

  /// Creates a copy with selected values changed.
  HseWorkPack copyWith({
    String? id,
    String? projectName,
    String? clientName,
    String? contractorName,
    String? location,
    String? emirate,
    String? activityId,
    String? activityTitle,
    String? supervisorName,
    String? hseOfficerName,
    DateTime? workStartDate,
    DateTime? plannedEndDate,
    String? workDescription,
    List<HseWorkDocument>? documents,
    String? generalNotes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return HseWorkPack(
      id: id ?? this.id,
      projectName:
          projectName ?? this.projectName,
      clientName:
          clientName ?? this.clientName,
      contractorName:
          contractorName ?? this.contractorName,
      location:
          location ?? this.location,
      emirate:
          emirate ?? this.emirate,
      activityId:
          activityId ?? this.activityId,
      activityTitle:
          activityTitle ?? this.activityTitle,
      supervisorName:
          supervisorName ?? this.supervisorName,
      hseOfficerName:
          hseOfficerName ?? this.hseOfficerName,
      workStartDate:
          workStartDate ?? this.workStartDate,
      plannedEndDate:
          plannedEndDate ?? this.plannedEndDate,
      workDescription:
          workDescription ?? this.workDescription,
      documents:
          documents ?? this.documents,
      generalNotes:
          generalNotes ?? this.generalNotes,
      createdAt:
          createdAt ?? this.createdAt,
      updatedAt:
          updatedAt ?? this.updatedAt,
    );
  }
}

/// Common HSE document categories.
///
/// These categories are intentionally generic so the same model
/// can support UAE-wide projects and different jurisdictions.
class HseDocumentCategories {
  static const String projectManagement =
      'HSE Management';

  static const String riskManagement =
      'Risk Management';

  static const String permit =
      'Permit to Work';

  static const String methodStatement =
      'RAMS / Method Statement';

  static const String training =
      'Training & Competency';

  static const String equipment =
      'Equipment & Inspection';

  static const String emergency =
      'Emergency';

  static const String inspection =
      'Inspection & Audit';

  static const String environmental =
      'Environment';

  static const String occupationalHealth =
      'Occupational Health';

  static const String incident =
      'Incident Management';

  static const String legal =
      'Legal / Authority';

  static const String dailyRecords =
      'Daily HSE Records';

  static const String lifting =
      'Lifting Operations';

  static const String chemical =
      'Chemical Safety';

  static const String documentControl =
      'Document Control';
}

/// Common emirates supported by the UAE-wide system.
///
/// This is a selection list, not a statement that every
/// requirement is identical across emirates.
class UaeEmirates {
  static const List<String> all = [
    'Abu Dhabi',
    'Dubai',
    'Sharjah',
    'Ajman',
    'Ras Al Khaimah',
    'Fujairah',
    'Umm Al Quwain',
  ];
}

/// General lifecycle stages for a new work activity.
enum HseWorkStage {
  preStart,
  riskAssessment,
  approval,
  permit,
  mobilization,
  competency,
  preInspection,
  toolboxTalk,
  workExecution,
  monitoring,
  correctiveAction,
  closeOut,
}

/// Display names for work stages.
extension HseWorkStageExtension on HseWorkStage {
  String get displayName {
    switch (this) {
      case HseWorkStage.preStart:
        return 'Pre-Start';

      case HseWorkStage.riskAssessment:
        return 'Risk Assessment';

      case HseWorkStage.approval:
        return 'Approval';

      case HseWorkStage.permit:
        return 'Permit to Work';

      case HseWorkStage.mobilization:
        return 'Mobilization';

      case HseWorkStage.competency:
        return 'Competency';

      case HseWorkStage.preInspection:
        return 'Pre-Start Inspection';

      case HseWorkStage.toolboxTalk:
        return 'Toolbox Talk';

      case HseWorkStage.workExecution:
        return 'Work Execution';

      case HseWorkStage.monitoring:
        return 'Monitoring';

      case HseWorkStage.correctiveAction:
        return 'Corrective Action';

      case HseWorkStage.closeOut:
        return 'Close-Out';
    }
  }
}
