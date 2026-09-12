import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// SafeNexus HSE - Step 25
/// HSE Document & Evidence Center
///
/// Standalone document/evidence management layer.
/// Existing Phase 1-16 and Step 17-24 files are not modified.
///
/// Includes:
/// 25A HSE Document Master
/// 25B Document & Certificate Upload Register
/// 25C HSE Evidence Repository
/// 25D Inspection / Audit Evidence
/// 25E Incident & Investigation Evidence
/// 25F PTW / RAMS / Risk Evidence
/// 25G Training / Competency Evidence
/// 25H Equipment / Certificate Evidence
/// 25I Legal / Compliance Evidence
/// 25J Document Expiry & Review Tracking
/// 25K Evidence Verification & Approval
/// 25L Document Search & Evidence Intelligence
///
/// Note:
/// This module stores document metadata and evidence references locally.
/// It does not require file-system permissions and does not pretend to
/// upload binary files. A future file-storage connector can use filePath
/// or externalUri fields without changing the model.

enum SafeNexusDocumentCategory {
  policy,
  plan,
  procedure,
  form,
  record,
  permit,
  risk,
  rams,
  training,
  competency,
  equipment,
  inspection,
  audit,
  incident,
  legal,
  environmental,
  emergency,
  certificate,
  evidence,
  other,
}

enum SafeNexusDocumentStatus {
  draft,
  underReview,
  approved,
  active,
  expired,
  superseded,
  rejected,
  archived,
}

enum SafeNexusEvidenceStatus {
  pendingVerification,
  verified,
  rejected,
  expired,
  superseded,
}

class SafeNexusDocumentRecord {
  final String id;
  final String documentNo;
  final String title;
  final SafeNexusDocumentCategory category;
  final String documentType;
  final String phase;
  final String module;
  final String project;
  final String site;
  final String department;
  final String owner;
  final String preparedBy;
  final String reviewedBy;
  final String approvedBy;
  final String revision;
  final String issueNo;
  final DateTime? issueDate;
  final DateTime? reviewDate;
  final DateTime? expiryDate;
  final SafeNexusDocumentStatus status;
  final bool controlled;
  final String storageLocation;
  final String fileName;
  final String filePath;
  final String externalUri;
  final String description;
  final String keyRequirements;
  final String referenceNo;
  final DateTime createdAt;
  final DateTime updatedAt;

  const SafeNexusDocumentRecord({
    required this.id,
    required this.documentNo,
    required this.title,
    required this.category,
    required this.documentType,
    required this.phase,
    required this.module,
    required this.project,
    required this.site,
    required this.department,
    required this.owner,
    required this.preparedBy,
    required this.reviewedBy,
    required this.approvedBy,
    required this.revision,
    required this.issueNo,
    required this.issueDate,
    required this.reviewDate,
    required this.expiryDate,
    required this.status,
    required this.controlled,
    required this.storageLocation,
    required this.fileName,
    required this.filePath,
    required this.externalUri,
    required this.description,
    required this.keyRequirements,
    required this.referenceNo,
    required this.createdAt,
    required this.updatedAt,
  });

  SafeNexusDocumentRecord copyWith({
    String? documentNo,
    String? title,
    SafeNexusDocumentCategory? category,
    String? documentType,
    String? phase,
    String? module,
    String? project,
    String? site,
    String? department,
    String? owner,
    String? preparedBy,
    String? reviewedBy,
    String? approvedBy,
    String? revision,
    String? issueNo,
    DateTime? issueDate,
    DateTime? reviewDate,
    DateTime? expiryDate,
    SafeNexusDocumentStatus? status,
    bool? controlled,
    String? storageLocation,
    String? fileName,
    String? filePath,
    String? externalUri,
    String? description,
    String? keyRequirements,
    String? referenceNo,
    DateTime? updatedAt,
  }) {
    return SafeNexusDocumentRecord(
      id: id,
      documentNo: documentNo ?? this.documentNo,
      title: title ?? this.title,
      category: category ?? this.category,
      documentType: documentType ?? this.documentType,
      phase: phase ?? this.phase,
      module: module ?? this.module,
      project: project ?? this.project,
      site: site ?? this.site,
      department: department ?? this.department,
      owner: owner ?? this.owner,
      preparedBy: preparedBy ?? this.preparedBy,
      reviewedBy: reviewedBy ?? this.reviewedBy,
      approvedBy: approvedBy ?? this.approvedBy,
      revision: revision ?? this.revision,
      issueNo: issueNo ?? this.issueNo,
      issueDate: issueDate ?? this.issueDate,
      reviewDate: reviewDate ?? this.reviewDate,
      expiryDate: expiryDate ?? this.expiryDate,
      status: status ?? this.status,
      controlled: controlled ?? this.controlled,
      storageLocation: storageLocation ?? this.storageLocation,
      fileName: fileName ?? this.fileName,
      filePath: filePath ?? this.filePath,
      externalUri: externalUri ?? this.externalUri,
      description: description ?? this.description,
      keyRequirements: keyRequirements ?? this.keyRequirements,
      referenceNo: referenceNo ?? this.referenceNo,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  bool get isExpired {
    final date = expiryDate;
    if (date == null) return false;
    return _dayOnly(date).isBefore(
      _dayOnly(DateTime.now()),
    );
  }

  bool get reviewDue {
    final date = reviewDate;
    if (date == null) return false;
    return _dayOnly(date).isBefore(
      _dayOnly(DateTime.now()),
    );
  }

  bool get expiringSoon {
    final date = expiryDate;
    if (date == null) return false;

    final today = _dayOnly(DateTime.now());
    final expiry = _dayOnly(date);
    final days = expiry.difference(today).inDays;

    return days >= 0 && days <= 30;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'documentNo': documentNo,
      'title': title,
      'category': category.name,
      'documentType': documentType,
      'phase': phase,
      'module': module,
      'project': project,
      'site': site,
      'department': department,
      'owner': owner,
      'preparedBy': preparedBy,
      'reviewedBy': reviewedBy,
      'approvedBy': approvedBy,
      'revision': revision,
      'issueNo': issueNo,
      'issueDate': issueDate?.toIso8601String(),
      'reviewDate': reviewDate?.toIso8601String(),
      'expiryDate': expiryDate?.toIso8601String(),
      'status': status.name,
      'controlled': controlled,
      'storageLocation': storageLocation,
      'fileName': fileName,
      'filePath': filePath,
      'externalUri': externalUri,
      'description': description,
      'keyRequirements': keyRequirements,
      'referenceNo': referenceNo,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory SafeNexusDocumentRecord.fromJson(
    Map<String, dynamic> json,
  ) {
    return SafeNexusDocumentRecord(
      id: _text(json['id']),
      documentNo: _text(json['documentNo']),
      title: _text(json['title']),
      category: _category(json['category']),
      documentType: _text(json['documentType']),
      phase: _text(json['phase']),
      module: _text(json['module']),
      project: _text(json['project']),
      site: _text(json['site']),
      department: _text(json['department']),
      owner: _text(json['owner']),
      preparedBy: _text(json['preparedBy']),
      reviewedBy: _text(json['reviewedBy']),
      approvedBy: _text(json['approvedBy']),
      revision: _text(json['revision']),
      issueNo: _text(json['issueNo']),
      issueDate: _date(json['issueDate']),
      reviewDate: _date(json['reviewDate']),
      expiryDate: _date(json['expiryDate']),
      status: _status(json['status']),
      controlled: json['controlled'] == true,
      storageLocation: _text(json['storageLocation']),
      fileName: _text(json['fileName']),
      filePath: _text(json['filePath']),
      externalUri: _text(json['externalUri']),
      description: _text(json['description']),
      keyRequirements: _text(json['keyRequirements']),
      referenceNo: _text(json['referenceNo']),
      createdAt:
          _date(json['createdAt']) ?? DateTime.now(),
      updatedAt:
          _date(json['updatedAt']) ?? DateTime.now(),
    );
  }

  static String _text(dynamic value) {
    return value?.toString().trim() ?? '';
  }

  static DateTime? _date(dynamic value) {
    if (value == null) return null;
    return DateTime.tryParse(value.toString());
  }

  static SafeNexusDocumentCategory _category(dynamic value) {
    return SafeNexusDocumentCategory.values.firstWhere(
      (item) => item.name == value?.toString(),
      orElse: () => SafeNexusDocumentCategory.other,
    );
  }

  static SafeNexusDocumentStatus _status(dynamic value) {
    return SafeNexusDocumentStatus.values.firstWhere(
      (item) => item.name == value?.toString(),
      orElse: () => SafeNexusDocumentStatus.draft,
    );
  }

  static DateTime _dayOnly(DateTime value) {
    return DateTime(value.year, value.month, value.day);
  }
}

class SafeNexusEvidenceRecord {
  final String id;
  final String evidenceNo;
  final String title;
  final String documentId;
  final String sourceId;
  final String phase;
  final String module;
  final SafeNexusDocumentCategory category;
  final String project;
  final String site;
  final String recordReference;
  final String evidenceType;
  final String description;
  final String fileName;
  final String filePath;
  final String externalUri;
  final String capturedBy;
  final DateTime capturedDate;
  final String verifiedBy;
  final DateTime? verificationDate;
  final SafeNexusEvidenceStatus status;
  final String rejectionReason;
  final String remarks;
  final DateTime createdAt;
  final DateTime updatedAt;

  const SafeNexusEvidenceRecord({
    required this.id,
    required this.evidenceNo,
    required this.title,
    required this.documentId,
    required this.sourceId,
    required this.phase,
    required this.module,
    required this.category,
    required this.project,
    required this.site,
    required this.recordReference,
    required this.evidenceType,
    required this.description,
    required this.fileName,
    required this.filePath,
    required this.externalUri,
    required this.capturedBy,
    required this.capturedDate,
    required this.verifiedBy,
    required this.verificationDate,
    required this.status,
    required this.rejectionReason,
    required this.remarks,
    required this.createdAt,
    required this.updatedAt,
  });

  SafeNexusEvidenceRecord copyWith({
    String? evidenceNo,
    String? title,
    String? documentId,
    String? sourceId,
    String? phase,
    String? module,
    SafeNexusDocumentCategory? category,
    String? project,
    String? site,
    String? recordReference,
    String? evidenceType,
    String? description,
    String? fileName,
    String? filePath,
    String? externalUri,
    String? capturedBy,
    DateTime? capturedDate,
    String? verifiedBy,
    DateTime? verificationDate,
    SafeNexusEvidenceStatus? status,
    String? rejectionReason,
    String? remarks,
    DateTime? updatedAt,
  }) {
    return SafeNexusEvidenceRecord(
      id: id,
      evidenceNo: evidenceNo ?? this.evidenceNo,
      title: title ?? this.title,
      documentId: documentId ?? this.documentId,
      sourceId: sourceId ?? this.sourceId,
      phase: phase ?? this.phase,
      module: module ?? this.module,
      category: category ?? this.category,
      project: project ?? this.project,
      site: site ?? this.site,
      recordReference: recordReference ?? this.recordReference,
      evidenceType: evidenceType ?? this.evidenceType,
      description: description ?? this.description,
      fileName: fileName ?? this.fileName,
      filePath: filePath ?? this.filePath,
      externalUri: externalUri ?? this.externalUri,
      capturedBy: capturedBy ?? this.capturedBy,
      capturedDate: capturedDate ?? this.capturedDate,
      verifiedBy: verifiedBy ?? this.verifiedBy,
      verificationDate:
          verificationDate ?? this.verificationDate,
      status: status ?? this.status,
      rejectionReason:
          rejectionReason ?? this.rejectionReason,
      remarks: remarks ?? this.remarks,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'evidenceNo': evidenceNo,
      'title': title,
      'documentId': documentId,
      'sourceId': sourceId,
      'phase': phase,
      'module': module,
      'category': category.name,
      'project': project,
      'site': site,
      'recordReference': recordReference,
      'evidenceType': evidenceType,
      'description': description,
      'fileName': fileName,
      'filePath': filePath,
      'externalUri': externalUri,
      'capturedBy': capturedBy,
      'capturedDate': capturedDate.toIso8601String(),
      'verifiedBy': verifiedBy,
      'verificationDate':
          verificationDate?.toIso8601String(),
      'status': status.name,
      'rejectionReason': rejectionReason,
      'remarks': remarks,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory SafeNexusEvidenceRecord.fromJson(
    Map<String, dynamic> json,
  ) {
    return SafeNexusEvidenceRecord(
      id: _text(json['id']),
      evidenceNo: _text(json['evidenceNo']),
      title: _text(json['title']),
      documentId: _text(json['documentId']),
      sourceId: _text(json['sourceId']),
      phase: _text(json['phase']),
      module: _text(json['module']),
      category: _category(json['category']),
      project: _text(json['project']),
      site: _text(json['site']),
      recordReference: _text(json['recordReference']),
      evidenceType: _text(json['evidenceType']),
      description: _text(json['description']),
      fileName: _text(json['fileName']),
      filePath: _text(json['filePath']),
      externalUri: _text(json['externalUri']),
      capturedBy: _text(json['capturedBy']),
      capturedDate:
          _date(json['capturedDate']) ?? DateTime.now(),
      verifiedBy: _text(json['verifiedBy']),
      verificationDate: _date(json['verificationDate']),
      status: _evidenceStatus(json['status']),
      rejectionReason: _text(json['rejectionReason']),
      remarks: _text(json['remarks']),
      createdAt:
          _date(json['createdAt']) ?? DateTime.now(),
      updatedAt:
          _date(json['updatedAt']) ?? DateTime.now(),
    );
  }

  static String _text(dynamic value) {
    return value?.toString().trim() ?? '';
  }

  static DateTime? _date(dynamic value) {
    if (value == null) return null;
    return DateTime.tryParse(value.toString());
  }

  static SafeNexusDocumentCategory _category(dynamic value) {
    return SafeNexusDocumentCategory.values.firstWhere(
      (item) => item.name == value?.toString(),
      orElse: () => SafeNexusDocumentCategory.other,
    );
  }

  static SafeNexusEvidenceStatus _evidenceStatus(
    dynamic value,
  ) {
    return SafeNexusEvidenceStatus.values.firstWhere(
      (item) => item.name == value?.toString(),
      orElse: () =>
          SafeNexusEvidenceStatus.pendingVerification,
    );
  }
}

typedef SafeNexusDocumentOpener = Future<void> Function(
  BuildContext context,
  SafeNexusDocumentRecord record,
);

class SafeNexusDocumentCenter {
  static const String documentStorageKey =
      'safenexus_hse_step25_document_records';

  static const String evidenceStorageKey =
      'safenexus_hse_step25_evidence_records';

  static Future<List<SafeNexusDocumentRecord>>
      loadDocuments() async {
    final prefs = await SharedPreferences.getInstance();
    final values =
        prefs.getStringList(documentStorageKey) ??
        <String>[];

    final records = <SafeNexusDocumentRecord>[];

    for (final value in values) {
      try {
        final decoded = jsonDecode(value);
        if (decoded is Map) {
          records.add(
            SafeNexusDocumentRecord.fromJson(
              Map<String, dynamic>.from(decoded),
            ),
          );
        }
      } catch (_) {
        // Ignore malformed document record.
      }
    }

    records.sort(
      (a, b) => b.updatedAt.compareTo(a.updatedAt),
    );

    return records;
  }

  static Future<List<SafeNexusEvidenceRecord>>
      loadEvidence() async {
    final prefs = await SharedPreferences.getInstance();
    final values =
        prefs.getStringList(evidenceStorageKey) ??
        <String>[];

    final records = <SafeNexusEvidenceRecord>[];

    for (final value in values) {
      try {
        final decoded = jsonDecode(value);
        if (decoded is Map) {
          records.add(
            SafeNexusEvidenceRecord.fromJson(
              Map<String, dynamic>.from(decoded),
            ),
          );
        }
      } catch (_) {
        // Ignore malformed evidence record.
      }
    }

    records.sort(
      (a, b) => b.updatedAt.compareTo(a.updatedAt),
    );

    return records;
  }

  static Future<void> saveDocuments(
    List<SafeNexusDocumentRecord> records,
  ) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setStringList(
      documentStorageKey,
      records
          .map((item) => jsonEncode(item.toJson()))
          .toList(),
    );
  }

  static Future<void> saveEvidence(
    List<SafeNexusEvidenceRecord> records,
  ) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setStringList(
      evidenceStorageKey,
      records
          .map((item) => jsonEncode(item.toJson()))
          .toList(),
    );
  }

  static Future<void> upsertDocument(
    SafeNexusDocumentRecord record,
  ) async {
    final records = await loadDocuments();

    final index = records.indexWhere(
      (item) => item.id == record.id,
    );

    if (index >= 0) {
      records[index] = record;
    } else {
      records.add(record);
    }

    await saveDocuments(records);
  }

  static Future<void> upsertEvidence(
    SafeNexusEvidenceRecord record,
  ) async {
    final records = await loadEvidence();

    final index = records.indexWhere(
      (item) => item.id == record.id,
    );

    if (index >= 0) {
      records[index] = record;
    } else {
      records.add(record);
    }

    await saveEvidence(records);
  }

  static Future<void> deleteDocument(String id) async {
    final records = await loadDocuments();
    records.removeWhere((item) => item.id == id);
    await saveDocuments(records);
  }

  static Future<void> deleteEvidence(String id) async {
    final records = await loadEvidence();
    records.removeWhere((item) => item.id == id);
    await saveEvidence(records);
  }

  static Future<void> clearDocuments() async {
    await saveDocuments(<SafeNexusDocumentRecord>[]);
  }

  static Future<void> clearEvidence() async {
    await saveEvidence(<SafeNexusEvidenceRecord>[]);
  }
}

class SafeNexusStep25DocumentEvidenceCenter
    extends StatefulWidget {
  final SafeNexusDocumentOpener? opener;

  const SafeNexusStep25DocumentEvidenceCenter({
    super.key,
    this.opener,
  });

  @override
  State<SafeNexusStep25DocumentEvidenceCenter> createState() =>
      _SafeNexusStep25DocumentEvidenceCenterState();
}

class _SafeNexusStep25DocumentEvidenceCenterState
    extends State<SafeNexusStep25DocumentEvidenceCenter> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);

  final TextEditingController _searchController =
      TextEditingController();

  List<SafeNexusDocumentRecord> _documents =
      <SafeNexusDocumentRecord>[];

  List<SafeNexusEvidenceRecord> _evidence =
      <SafeNexusEvidenceRecord>[];

  String _query = '';
  String _view = 'Documents';
  String _category = 'All';
  String _status = 'All';

  bool _loading = true;

  List<SafeNexusDocumentRecord> get _filteredDocuments {
    final query = _query.trim().toLowerCase();

    return _documents.where((record) {
      final searchable = [
        record.documentNo,
        record.title,
        record.category.name,
        record.documentType,
        record.phase,
        record.module,
        record.project,
        record.site,
        record.department,
        record.owner,
        record.referenceNo,
        record.fileName,
      ].join(' ').toLowerCase();

      final queryMatch =
          query.isEmpty || searchable.contains(query);

      final categoryMatch =
          _category == 'All' ||
          record.category.name == _category;

      final statusMatch =
          _status == 'All' ||
          record.status.name == _status;

      return queryMatch &&
          categoryMatch &&
          statusMatch;
    }).toList();
  }

  List<SafeNexusEvidenceRecord> get _filteredEvidence {
    final query = _query.trim().toLowerCase();

    return _evidence.where((record) {
      final searchable = [
        record.evidenceNo,
        record.title,
        record.category.name,
        record.phase,
        record.module,
        record.project,
        record.site,
        record.recordReference,
        record.evidenceType,
        record.fileName,
        record.capturedBy,
        record.verifiedBy,
      ].join(' ').toLowerCase();

      final queryMatch =
          query.isEmpty || searchable.contains(query);

      final categoryMatch =
          _category == 'All' ||
          record.category.name == _category;

      final statusMatch =
          _status == 'All' ||
          record.status.name == _status;

      return queryMatch &&
          categoryMatch &&
          statusMatch;
    }).toList();
  }

  int get _expiredDocuments =>
      _documents.where((item) => item.isExpired).length;

  int get _reviewDueDocuments =>
      _documents.where((item) => item.reviewDue).length;

  int get _expiringDocuments =>
      _documents.where((item) => item.expiringSoon).length;

  int get _verifiedEvidence =>
      _evidence
          .where(
            (item) =>
                item.status ==
                SafeNexusEvidenceStatus.verified,
          )
          .length;

  int get _pendingEvidence =>
      _evidence
          .where(
            (item) =>
                item.status ==
                SafeNexusEvidenceStatus.pendingVerification,
          )
          .length;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearch);
    _load();
  }

  void _onSearch() {
    final value = _searchController.text;

    if (value != _query) {
      setState(() => _query = value);
    }
  }

  Future<void> _load() async {
    setState(() => _loading = true);

    final documents =
        await SafeNexusDocumentCenter.loadDocuments();
    final evidence =
        await SafeNexusDocumentCenter.loadEvidence();

    if (!mounted) return;

    setState(() {
      _documents = documents;
      _evidence = evidence;
      _loading = false;
    });
  }

  Future<void> _openDocument(
    SafeNexusDocumentRecord record,
  ) async {
    final opener = widget.opener;

    if (opener != null) {
      await opener(context, record);
      return;
    }

    if (!mounted) return;

    await Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => _DocumentDetailsPage(
          record: record,
        ),
      ),
    );
  }

  Future<void> _deleteDocument(
    SafeNexusDocumentRecord record,
  ) async {
    await SafeNexusDocumentCenter.deleteDocument(
      record.id,
    );
    await _load();
  }

  Future<void> _deleteEvidence(
    SafeNexusEvidenceRecord record,
  ) async {
    await SafeNexusDocumentCenter.deleteEvidence(
      record.id,
    );
    await _load();
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearch);
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
        title: const Text(
          'HSE Documents & Evidence',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'Refresh',
            onPressed: _load,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Column(
        children: [
          _searchHeader(),
          _viewSelector(),
          _filterBar(),
          Expanded(
            child: _loading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : RefreshIndicator(
                    onRefresh: _load,
                    child: ListView(
                      padding: const EdgeInsets.fromLTRB(
                        12,
                        5,
                        12,
                        24,
                      ),
                      children: [
                        _summary(),
                        const SizedBox(height: 10),
                        _intelligence(),
                        const SizedBox(height: 10),
                        if (_view == 'Documents')
                          ..._filteredDocuments.map(
                            _documentCard,
                          )
                        else
                          ..._filteredEvidence.map(
                            _evidenceCard,
                          ),
                        if (_view == 'Documents' &&
                            _filteredDocuments.isEmpty)
                          _empty(
                            'No document records found.',
                          ),
                        if (_view == 'Evidence' &&
                            _filteredEvidence.isEmpty)
                          _empty(
                            'No evidence records found.',
                          ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        onPressed: () {
          if (_view == 'Documents') {
            _showDocumentForm();
          } else {
            _showEvidenceForm();
          }
        },
        icon: const Icon(Icons.add),
        label: Text(
          _view == 'Documents'
              ? 'Document'
              : 'Evidence',
        ),
      ),
    );
  }

  Widget _searchHeader() {
    return Container(
      color: darkGreen,
      padding: const EdgeInsets.fromLTRB(
        12,
        10,
        12,
        12,
      ),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Search documents & evidence...',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: _query.isEmpty
              ? null
              : IconButton(
                  onPressed: _searchController.clear,
                  icon: const Icon(Icons.clear),
                ),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _viewSelector() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        12,
        8,
        12,
        3,
      ),
      child: SegmentedButton<String>(
        segments: const [
          ButtonSegment<String>(
            value: 'Documents',
            label: Text('Documents'),
            icon: Icon(Icons.description),
          ),
          ButtonSegment<String>(
            value: 'Evidence',
            label: Text('Evidence'),
            icon: Icon(Icons.folder_special),
          ),
        ],
        selected: <String>{_view},
        onSelectionChanged: (values) {
          setState(() => _view = values.first);
        },
      ),
    );
  }

  Widget _filterBar() {
    return SizedBox(
      height: 55,
      child: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 7,
        ),
        scrollDirection: Axis.horizontal,
        children: [
          _filterChip(
            'Category',
            _category,
            [
              'All',
              ...SafeNexusDocumentCategory.values.map(
                (item) => item.name,
              ),
            ],
            (value) {
              setState(() => _category = value);
            },
          ),
          _filterChip(
            'Status',
            _status,
            _view == 'Documents'
                ? [
                    'All',
                    ...SafeNexusDocumentStatus.values.map(
                      (item) => item.name,
                    ),
                  ]
                : [
                    'All',
                    ...SafeNexusEvidenceStatus.values.map(
                      (item) => item.name,
                    ),
                  ],
            (value) {
              setState(() => _status = value);
            },
          ),
        ],
      ),
    );
  }

  Widget _filterChip(
    String label,
    String selected,
    List<String> values,
    ValueChanged<String> onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: PopupMenuButton<String>(
        onSelected: onChanged,
        itemBuilder: (_) => values
            .map(
              (value) => PopupMenuItem<String>(
                value: value,
                child: Text(value),
              ),
            )
            .toList(),
        child: Chip(
          avatar: const Icon(
            Icons.filter_list,
            size: 17,
          ),
          label: Text('$label: $selected'),
        ),
      ),
    );
  }

  Widget _summary() {
    final total =
        _view == 'Documents'
            ? _documents.length
            : _evidence.length;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '25A–L • Document & Evidence Intelligence',
              style: TextStyle(
                color: darkGreen,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics:
                  const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 2.25,
              children: [
                _metric(
                  '$total',
                  _view == 'Documents'
                      ? 'Documents'
                      : 'Evidence',
                  Icons.dataset,
                ),
                _metric(
                  _view == 'Documents'
                      ? '$_expiredDocuments'
                      : '$_pendingEvidence',
                  _view == 'Documents'
                      ? 'Expired'
                      : 'Pending Verify',
                  Icons.warning,
                ),
                _metric(
                  _view == 'Documents'
                      ? '$_expiringDocuments'
                      : '$_verifiedEvidence',
                  _view == 'Documents'
                      ? 'Expiring ≤30d'
                      : 'Verified',
                  Icons.verified,
                ),
                _metric(
                  _view == 'Documents'
                      ? '$_reviewDueDocuments'
                      : '${_evidence.length - _verifiedEvidence}',
                  _view == 'Documents'
                      ? 'Review Due'
                      : 'Not Verified',
                  Icons.fact_check,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _metric(
    String value,
    String label,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(9),
      decoration: BoxDecoration(
        color: primaryGreen.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: primaryGreen,
            size: 22,
          ),
          const SizedBox(width: 7),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    color: darkGreen,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  label,
                  style: const TextStyle(fontSize: 10),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _intelligence() {
    final messages = <String>[];

    if (_view == 'Documents') {
      if (_expiredDocuments > 0) {
        messages.add(
          'Expired documents require immediate review.',
        );
      }

      if (_reviewDueDocuments > 0) {
        messages.add(
          'Document reviews are overdue.',
        );
      }

      if (_expiringDocuments > 0) {
        messages.add(
          'Documents are approaching expiry within 30 days.',
        );
      }
    } else {
      if (_pendingEvidence > 0) {
        messages.add(
          'Evidence verification is pending.',
        );
      }

      if (_evidence.isNotEmpty &&
          _verifiedEvidence == _evidence.length) {
        messages.add(
          'All registered evidence is verified.',
        );
      }
    }

    if (messages.isEmpty) {
      messages.add(
        _view == 'Documents'
            ? 'No document priority trigger detected.'
            : 'No evidence verification priority trigger detected.',
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(13),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(
                  Icons.lightbulb,
                  color: darkGreen,
                ),
                SizedBox(width: 7),
                Text(
                  'Management Intelligence',
                  style: TextStyle(
                    color: darkGreen,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 7),
            ...messages.map(
              (message) => Padding(
                padding:
                    const EdgeInsets.only(bottom: 4),
                child: Row(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '• ',
                      style: TextStyle(
                        color: primaryGreen,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: Text(message),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _documentCard(
    SafeNexusDocumentRecord record,
  ) {
    final urgent =
        record.isExpired || record.reviewDue;

    final color =
        record.isExpired
            ? Colors.red
            : record.reviewDue
                ? Colors.orange.shade700
                : primaryGreen;

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _openDocument(record),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor:
                        color.withValues(alpha: 0.10),
                    child: Icon(
                      urgent
                          ? Icons.warning
                          : Icons.description,
                      color: color,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          record.title.isEmpty
                              ? 'Untitled Document'
                              : record.title,
                          maxLines: 2,
                          overflow:
                              TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          '${record.documentNo} • '
                          '${record.category.name}',
                          style: const TextStyle(
                            color: darkGreen,
                            fontSize: 11,
                            fontWeight:
                                FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'delete') {
                        _deleteDocument(record);
                      }
                    },
                    itemBuilder: (_) => const [
                      PopupMenuItem<String>(
                        value: 'delete',
                        child: Text(
                          'Delete local record',
                        ),
                      ),
                    ],
                    icon:
                        const Icon(Icons.more_vert),
                  ),
                ],
              ),
              const SizedBox(height: 7),
              Wrap(
                spacing: 5,
                runSpacing: 4,
                children: [
                  _badge(
                    record.status.name,
                    primaryGreen,
                  ),
                  _badge(
                    'Rev ${record.revision.isEmpty ? '-' : record.revision}',
                    darkGreen,
                  ),
                  if (record.controlled)
                    _badge(
                      'CONTROLLED',
                      darkGreen,
                    ),
                  if (record.isExpired)
                    _badge(
                      'EXPIRED',
                      Colors.red,
                    ),
                  if (record.reviewDue)
                    _badge(
                      'REVIEW DUE',
                      Colors.orange.shade700,
                    ),
                  if (record.expiringSoon &&
                      !record.isExpired)
                    _badge(
                      'EXPIRING',
                      Colors.orange.shade700,
                    ),
                ],
              ),
              const SizedBox(height: 7),
              Text(
                'Phase: ${record.phase.isEmpty ? 'Not set' : record.phase}',
                style: const TextStyle(fontSize: 11),
              ),
              Text(
                'Project: ${record.project.isEmpty ? 'Not set' : record.project}',
                style: const TextStyle(fontSize: 11),
              ),
              Text(
                'Owner: ${record.owner.isEmpty ? 'Not set' : record.owner}',
                style: const TextStyle(fontSize: 11),
              ),
              if (record.expiryDate != null)
                Text(
                  'Expiry: ${_date(record.expiryDate!)}',
                  style: const TextStyle(fontSize: 11),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _evidenceCard(
    SafeNexusEvidenceRecord record,
  ) {
    final color =
        record.status ==
                SafeNexusEvidenceStatus.verified
            ? primaryGreen
            : record.status ==
                    SafeNexusEvidenceStatus.rejected
                ? Colors.red
                : Colors.orange.shade700;

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor:
                  color.withValues(alpha: 0.10),
              child: Icon(
                Icons.folder_special,
                color: color,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    record.title.isEmpty
                        ? 'Untitled Evidence'
                        : record.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    '${record.evidenceNo} • '
                    '${record.evidenceType}',
                    style: const TextStyle(
                      color: darkGreen,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Wrap(
                    spacing: 5,
                    runSpacing: 4,
                    children: [
                      _badge(
                        record.status.name,
                        color,
                      ),
                      _badge(
                        record.category.name,
                        darkGreen,
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Reference: ${record.recordReference.isEmpty ? 'Not set' : record.recordReference}',
                    style: const TextStyle(fontSize: 11),
                  ),
                  Text(
                    'Captured by: ${record.capturedBy.isEmpty ? 'Not set' : record.capturedBy}',
                    style: const TextStyle(fontSize: 11),
                  ),
                  if (record.fileName.isNotEmpty)
                    Text(
                      'File: ${record.fileName}',
                      style: const TextStyle(fontSize: 11),
                    ),
                ],
              ),
            ),
            PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'delete') {
                  _deleteEvidence(record);
                }
              },
              itemBuilder: (_) => const [
                PopupMenuItem<String>(
                  value: 'delete',
                  child: Text(
                    'Delete local record',
                  ),
                ),
              ],
              icon: const Icon(Icons.more_vert),
            ),
          ],
        ),
      ),
    );
  }

  Widget _badge(
    String text,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 7,
        vertical: 3,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 9,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _empty(String text) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        children: [
          Icon(
            Icons.folder_off_outlined,
            size: 52,
            color: Colors.grey.shade500,
          ),
          const SizedBox(height: 10),
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showDocumentForm() async {
    final result =
        await showModalBottomSheet<SafeNexusDocumentRecord>(
      context: context,
      isScrollControlled: true,
      builder: (_) => _DocumentFormSheet(),
    );

    if (result != null) {
      await SafeNexusDocumentCenter.upsertDocument(
        result,
      );
      await _load();
    }
  }

  Future<void> _showEvidenceForm() async {
    final result =
        await showModalBottomSheet<SafeNexusEvidenceRecord>(
      context: context,
      isScrollControlled: true,
      builder: (_) => _EvidenceFormSheet(),
    );

    if (result != null) {
      await SafeNexusDocumentCenter.upsertEvidence(
        result,
      );
      await _load();
    }
  }

  String _date(DateTime value) {
    final day =
        value.day.toString().padLeft(2, '0');
    final month =
        value.month.toString().padLeft(2, '0');

    return '$day/$month/${value.year}';
  }
}

class _DocumentFormSheet extends StatefulWidget {
  @override
  State<_DocumentFormSheet> createState() =>
      _DocumentFormSheetState();
}

class _DocumentFormSheetState
    extends State<_DocumentFormSheet> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);

  final _formKey = GlobalKey<FormState>();

  final _no = TextEditingController();
  final _title = TextEditingController();
  final _type = TextEditingController();
  final _phase = TextEditingController();
  final _module = TextEditingController();
  final _project = TextEditingController();
  final _site = TextEditingController();
  final _department = TextEditingController();
  final _owner = TextEditingController();
  final _prepared = TextEditingController();
  final _reviewed = TextEditingController();
  final _approved = TextEditingController();
  final _revision = TextEditingController();
  final _issue = TextEditingController();
  final _storage = TextEditingController();
  final _fileName = TextEditingController();
  final _filePath = TextEditingController();
  final _uri = TextEditingController();
  final _description = TextEditingController();
  final _requirements = TextEditingController();
  final _reference = TextEditingController();

  SafeNexusDocumentCategory _category =
      SafeNexusDocumentCategory.other;

  SafeNexusDocumentStatus _status =
      SafeNexusDocumentStatus.draft;

  bool _controlled = true;

  DateTime? _issueDate;
  DateTime? _reviewDate;
  DateTime? _expiryDate;

  @override
  void dispose() {
    _no.dispose();
    _title.dispose();
    _type.dispose();
    _phase.dispose();
    _module.dispose();
    _project.dispose();
    _site.dispose();
    _department.dispose();
    _owner.dispose();
    _prepared.dispose();
    _reviewed.dispose();
    _approved.dispose();
    _revision.dispose();
    _issue.dispose();
    _storage.dispose();
    _fileName.dispose();
    _filePath.dispose();
    _uri.dispose();
    _description.dispose();
    _requirements.dispose();
    _reference.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottom =
        MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: bottom),
      child: FractionallySizedBox(
        heightFactor: 0.92,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Add HSE Document'),
            backgroundColor: darkGreen,
            foregroundColor: Colors.white,
          ),
          body: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(14),
              children: [
                _field(
                  _no,
                  'Document No *',
                  required: true,
                ),
                _field(
                  _title,
                  'Document Title *',
                  required: true,
                ),
                _field(_type, 'Document Type'),
                _field(_phase, 'Phase'),
                _field(_module, 'Module'),
                _field(_project, 'Project'),
                _field(_site, 'Site'),
                _field(_department, 'Department'),
                _field(_owner, 'Document Owner'),
                _field(_prepared, 'Prepared By'),
                _field(_reviewed, 'Reviewed By'),
                _field(_approved, 'Approved By'),
                _field(_revision, 'Revision'),
                _field(_issue, 'Issue No'),
                _dropdownCategory(),
                _dropdownStatus(),
                SwitchListTile(
                  title: const Text('Controlled Document'),
                  value: _controlled,
                  activeThumbColor: primaryGreen,
                  onChanged: (value) {
                    setState(() => _controlled = value);
                  },
                ),
                _dateTile(
                  'Issue Date',
                  _issueDate,
                  (value) {
                    setState(() => _issueDate = value);
                  },
                ),
                _dateTile(
                  'Review Date',
                  _reviewDate,
                  (value) {
                    setState(() => _reviewDate = value);
                  },
                ),
                _dateTile(
                  'Expiry Date',
                  _expiryDate,
                  (value) {
                    setState(() => _expiryDate = value);
                  },
                ),
                _field(
                  _storage,
                  'Storage Location',
                ),
                _field(
                  _fileName,
                  'File Name',
                ),
                _field(
                  _filePath,
                  'File Path / Local Reference',
                ),
                _field(
                  _uri,
                  'External URI / Cloud Reference',
                ),
                _field(
                  _reference,
                  'Related Record Reference',
                ),
                _field(
                  _description,
                  'Description',
                  maxLines: 3,
                ),
                _field(
                  _requirements,
                  'Key Requirements',
                  maxLines: 3,
                ),
                const SizedBox(height: 10),
                FilledButton.icon(
                  onPressed: _save,
                  icon: const Icon(Icons.save),
                  label: const Text('Save Document'),
                  style: FilledButton.styleFrom(
                    backgroundColor: primaryGreen,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _field(
    TextEditingController controller,
    String label, {
    bool required = false,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: required
            ? (value) {
                if (value == null ||
                    value.trim().isEmpty) {
                  return 'Required';
                }
                return null;
              }
            : null,
      ),
    );
  }

  Widget _dropdownCategory() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: DropdownButtonFormField<
          SafeNexusDocumentCategory>(
        initialValue: _category,
        decoration: const InputDecoration(
          labelText: 'Category',
          border: OutlineInputBorder(),
        ),
        items: SafeNexusDocumentCategory.values
            .map(
              (item) => DropdownMenuItem<
                  SafeNexusDocumentCategory>(
                value: item,
                child: Text(item.name),
              ),
            )
            .toList(),
        onChanged: (value) {
          if (value != null) {
            setState(() => _category = value);
          }
        },
      ),
    );
  }

  Widget _dropdownStatus() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: DropdownButtonFormField<
          SafeNexusDocumentStatus>(
        initialValue: _status,
        decoration: const InputDecoration(
          labelText: 'Status',
          border: OutlineInputBorder(),
        ),
        items: SafeNexusDocumentStatus.values
            .map(
              (item) => DropdownMenuItem<
                  SafeNexusDocumentStatus>(
                value: item,
                child: Text(item.name),
              ),
            )
            .toList(),
        onChanged: (value) {
          if (value != null) {
            setState(() => _status = value);
          }
        },
      ),
    );
  }

  Widget _dateTile(
    String label,
    DateTime? value,
    ValueChanged<DateTime> onChanged,
  ) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        value == null
            ? '$label: Not set'
            : '$label: ${_date(value)}',
      ),
      trailing: const Icon(
        Icons.calendar_month,
      ),
      onTap: () async {
        final selected =
            await showDatePicker(
          context: context,
          firstDate: DateTime(2020),
          lastDate: DateTime(2100),
          initialDate:
              value ?? DateTime.now(),
        );

        if (selected != null) {
          onChanged(selected);
        }
      },
    );
  }

  void _save() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final now = DateTime.now();

    Navigator.of(context).pop(
      SafeNexusDocumentRecord(
        id: 'DOC-${now.microsecondsSinceEpoch}',
        documentNo: _no.text.trim(),
        title: _title.text.trim(),
        category: _category,
        documentType: _type.text.trim(),
        phase: _phase.text.trim(),
        module: _module.text.trim(),
        project: _project.text.trim(),
        site: _site.text.trim(),
        department: _department.text.trim(),
        owner: _owner.text.trim(),
        preparedBy: _prepared.text.trim(),
        reviewedBy: _reviewed.text.trim(),
        approvedBy: _approved.text.trim(),
        revision: _revision.text.trim(),
        issueNo: _issue.text.trim(),
        issueDate: _issueDate,
        reviewDate: _reviewDate,
        expiryDate: _expiryDate,
        status: _status,
        controlled: _controlled,
        storageLocation: _storage.text.trim(),
        fileName: _fileName.text.trim(),
        filePath: _filePath.text.trim(),
        externalUri: _uri.text.trim(),
        description: _description.text.trim(),
        keyRequirements: _requirements.text.trim(),
        referenceNo: _reference.text.trim(),
        createdAt: now,
        updatedAt: now,
      ),
    );
  }

  String _date(DateTime value) {
    final day =
        value.day.toString().padLeft(2, '0');
    final month =
        value.month.toString().padLeft(2, '0');

    return '$day/$month/${value.year}';
  }
}

class _EvidenceFormSheet extends StatefulWidget {
  @override
  State<_EvidenceFormSheet> createState() =>
      _EvidenceFormSheetState();
}

class _EvidenceFormSheetState
    extends State<_EvidenceFormSheet> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);

  final _formKey = GlobalKey<FormState>();

  final _no = TextEditingController();
  final _title = TextEditingController();
  final _documentId = TextEditingController();
  final _sourceId = TextEditingController();
  final _phase = TextEditingController();
  final _module = TextEditingController();
  final _project = TextEditingController();
  final _site = TextEditingController();
  final _reference = TextEditingController();
  final _type = TextEditingController();
  final _description = TextEditingController();
  final _fileName = TextEditingController();
  final _filePath = TextEditingController();
  final _uri = TextEditingController();
  final _capturedBy = TextEditingController();
  final _verifiedBy = TextEditingController();
  final _rejection = TextEditingController();
  final _remarks = TextEditingController();

  SafeNexusDocumentCategory _category =
      SafeNexusDocumentCategory.evidence;

  SafeNexusEvidenceStatus _status =
      SafeNexusEvidenceStatus.pendingVerification;

  DateTime _capturedDate = DateTime.now();
  DateTime? _verificationDate;

  @override
  void dispose() {
    _no.dispose();
    _title.dispose();
    _documentId.dispose();
    _sourceId.dispose();
    _phase.dispose();
    _module.dispose();
    _project.dispose();
    _site.dispose();
    _reference.dispose();
    _type.dispose();
    _description.dispose();
    _fileName.dispose();
    _filePath.dispose();
    _uri.dispose();
    _capturedBy.dispose();
    _verifiedBy.dispose();
    _rejection.dispose();
    _remarks.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottom =
        MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: bottom),
      child: FractionallySizedBox(
        heightFactor: 0.92,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Add HSE Evidence'),
            backgroundColor: darkGreen,
            foregroundColor: Colors.white,
          ),
          body: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(14),
              children: [
                _field(
                  _no,
                  'Evidence No *',
                  required: true,
                ),
                _field(
                  _title,
                  'Evidence Title *',
                  required: true,
                ),
                _field(
                  _documentId,
                  'Document ID',
                ),
                _field(
                  _sourceId,
                  'Source / Module Record ID',
                ),
                _field(_phase, 'Phase'),
                _field(_module, 'Module'),
                _field(_project, 'Project'),
                _field(_site, 'Site'),
                _field(
                  _reference,
                  'Related Record Reference',
                ),
                _field(
                  _type,
                  'Evidence Type',
                ),
                _dropdownCategory(),
                _dropdownStatus(),
                _dateTile(
                  'Captured Date',
                  _capturedDate,
                  (value) {
                    setState(
                      () => _capturedDate = value,
                    );
                  },
                ),
                _dateTile(
                  'Verification Date',
                  _verificationDate,
                  (value) {
                    setState(
                      () => _verificationDate = value,
                    );
                  },
                ),
                _field(
                  _capturedBy,
                  'Captured By',
                ),
                _field(
                  _verifiedBy,
                  'Verified By',
                ),
                _field(
                  _fileName,
                  'File Name',
                ),
                _field(
                  _filePath,
                  'File Path / Local Reference',
                ),
                _field(
                  _uri,
                  'External URI / Cloud Reference',
                ),
                _field(
                  _description,
                  'Description',
                  maxLines: 3,
                ),
                _field(
                  _rejection,
                  'Rejection Reason',
                  maxLines: 2,
                ),
                _field(
                  _remarks,
                  'Remarks',
                  maxLines: 3,
                ),
                const SizedBox(height: 10),
                FilledButton.icon(
                  onPressed: _save,
                  icon: const Icon(Icons.save),
                  label: const Text('Save Evidence'),
                  style: FilledButton.styleFrom(
                    backgroundColor: primaryGreen,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _field(
    TextEditingController controller,
    String label, {
    bool required = false,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: required
            ? (value) {
                if (value == null ||
                    value.trim().isEmpty) {
                  return 'Required';
                }
                return null;
              }
            : null,
      ),
    );
  }

  Widget _dropdownCategory() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: DropdownButtonFormField<
          SafeNexusDocumentCategory>(
        initialValue: _category,
        decoration: const InputDecoration(
          labelText: 'Category',
          border: OutlineInputBorder(),
        ),
        items: SafeNexusDocumentCategory.values
            .map(
              (item) => DropdownMenuItem<
                  SafeNexusDocumentCategory>(
                value: item,
                child: Text(item.name),
              ),
            )
            .toList(),
        onChanged: (value) {
          if (value != null) {
            setState(() => _category = value);
          }
        },
      ),
    );
  }

  Widget _dropdownStatus() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: DropdownButtonFormField<
          SafeNexusEvidenceStatus>(
        initialValue: _status,
        decoration: const InputDecoration(
          labelText: 'Verification Status',
          border: OutlineInputBorder(),
        ),
        items: SafeNexusEvidenceStatus.values
            .map(
              (item) => DropdownMenuItem<
                  SafeNexusEvidenceStatus>(
                value: item,
                child: Text(item.name),
              ),
            )
            .toList(),
        onChanged: (value) {
          if (value != null) {
            setState(() => _status = value);
          }
        },
      ),
    );
  }

  Widget _dateTile(
    String label,
    DateTime? value,
    ValueChanged<DateTime> onChanged,
  ) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        value == null
            ? '$label: Not set'
            : '$label: ${_date(value)}',
      ),
      trailing: const Icon(
        Icons.calendar_month,
      ),
      onTap: () async {
        final selected =
            await showDatePicker(
          context: context,
          firstDate: DateTime(2020),
          lastDate: DateTime(2100),
          initialDate:
              value ?? DateTime.now(),
        );

        if (selected != null) {
          onChanged(selected);
        }
      },
    );
  }

  void _save() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final now = DateTime.now();

    Navigator.of(context).pop(
      SafeNexusEvidenceRecord(
        id: 'EVD-${now.microsecondsSinceEpoch}',
        evidenceNo: _no.text.trim(),
        title: _title.text.trim(),
        documentId: _documentId.text.trim(),
        sourceId: _sourceId.text.trim(),
        phase: _phase.text.trim(),
        module: _module.text.trim(),
        category: _category,
        project: _project.text.trim(),
        site: _site.text.trim(),
        recordReference:
            _reference.text.trim(),
        evidenceType: _type.text.trim(),
        description: _description.text.trim(),
        fileName: _fileName.text.trim(),
        filePath: _filePath.text.trim(),
        externalUri: _uri.text.trim(),
        capturedBy: _capturedBy.text.trim(),
        capturedDate: _capturedDate,
        verifiedBy: _verifiedBy.text.trim(),
        verificationDate: _verificationDate,
        status: _status,
        rejectionReason:
            _rejection.text.trim(),
        remarks: _remarks.text.trim(),
        createdAt: now,
        updatedAt: now,
      ),
    );
  }

  String _date(DateTime value) {
    final day =
        value.day.toString().padLeft(2, '0');
    final month =
        value.month.toString().padLeft(2, '0');

    return '$day/$month/${value.year}';
  }
}

class _DocumentDetailsPage extends StatelessWidget {
  final SafeNexusDocumentRecord record;

  const _DocumentDetailsPage({
    required this.record,
  });

  @override
  Widget build(BuildContext context) {
    const darkGreen = Color(0xFF0B5D4B);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
        title: const Text('Document Details'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(14),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.description,
                    color: darkGreen,
                    size: 35,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    record.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _row(
                    'Document No',
                    record.documentNo,
                  ),
                  _row(
                    'Category',
                    record.category.name,
                  ),
                  _row(
                    'Type',
                    record.documentType,
                  ),
                  _row(
                    'Phase',
                    record.phase,
                  ),
                  _row(
                    'Module',
                    record.module,
                  ),
                  _row(
                    'Project',
                    record.project,
                  ),
                  _row(
                    'Site',
                    record.site,
                  ),
                  _row(
                    'Owner',
                    record.owner,
                  ),
                  _row(
                    'Revision',
                    record.revision,
                  ),
                  _row(
                    'Status',
                    record.status.name,
                  ),
                  _row(
                    'Controlled',
                    record.controlled ? 'Yes' : 'No',
                  ),
                  if (record.expiryDate != null)
                    _row(
                      'Expiry',
                      _date(record.expiryDate!),
                    ),
                  if (record.reviewDate != null)
                    _row(
                      'Review',
                      _date(record.reviewDate!),
                    ),
                  _row(
                    'File',
                    record.fileName,
                  ),
                  _row(
                    'Storage',
                    record.storageLocation,
                  ),
                  _row(
                    'External Reference',
                    record.externalUri,
                  ),
                  _row(
                    'Description',
                    record.description,
                  ),
                  _row(
                    'Key Requirements',
                    record.keyRequirements,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _row(
    String label,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 7),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value.isEmpty ? 'Not set' : value,
            ),
          ),
        ],
      ),
    );
  }

  String _date(DateTime value) {
    final day =
        value.day.toString().padLeft(2, '0');
    final month =
        value.month.toString().padLeft(2, '0');

    return '$day/$month/${value.year}';
  }
}

/// Convenience factory for main.dart.
///
/// Example:
/// SafeNexusStep25DocumentEvidenceCenter(
///   opener: (context, record) async {
///     // Connect to the real originating module here.
///   },
/// )
Widget safeNexusStep25DocumentEvidenceCenter({
  SafeNexusDocumentOpener? opener,
}) {
  return SafeNexusStep25DocumentEvidenceCenter(
    opener: opener,
  );
}
