import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:docx_dart/docx_dart.dart' as docx;
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WorkHubCompany {
  const WorkHubCompany({
    required this.id,
    required this.name,
    this.logoPath = '',
    this.address = '',
    this.contact = '',
    this.email = '',
    this.hseResponsible = '',
    this.projectName = '',
    this.siteLocation = '',
    this.emirate = 'Abu Dhabi',
    this.client = '',
    this.mainContractor = '',
    this.projectReference = '',
  });

  final String id;
  final String name;
  final String logoPath;
  final String address;
  final String contact;
  final String email;
  final String hseResponsible;
  final String projectName;
  final String siteLocation;
  final String emirate;
  final String client;
  final String mainContractor;
  final String projectReference;

  WorkHubCompany copyWith({
    String? id,
    String? name,
    String? logoPath,
    String? address,
    String? contact,
    String? email,
    String? hseResponsible,
    String? projectName,
    String? siteLocation,
    String? emirate,
    String? client,
    String? mainContractor,
    String? projectReference,
  }) {
    return WorkHubCompany(
      id: id ?? this.id,
      name: name ?? this.name,
      logoPath: logoPath ?? this.logoPath,
      address: address ?? this.address,
      contact: contact ?? this.contact,
      email: email ?? this.email,
      hseResponsible: hseResponsible ?? this.hseResponsible,
      projectName: projectName ?? this.projectName,
      siteLocation: siteLocation ?? this.siteLocation,
      emirate: emirate ?? this.emirate,
      client: client ?? this.client,
      mainContractor: mainContractor ?? this.mainContractor,
      projectReference: projectReference ?? this.projectReference,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'name': name,
        'logoPath': logoPath,
        'address': address,
        'contact': contact,
        'email': email,
        'hseResponsible': hseResponsible,
        'projectName': projectName,
        'siteLocation': siteLocation,
        'emirate': emirate,
        'client': client,
        'mainContractor': mainContractor,
        'projectReference': projectReference,
      };

  factory WorkHubCompany.fromJson(Map<String, dynamic> json) {
    String value(String key) => (json[key] ?? '').toString();
    return WorkHubCompany(
      id: value('id'),
      name: value('name'),
      logoPath: value('logoPath'),
      address: value('address'),
      contact: value('contact'),
      email: value('email'),
      hseResponsible: value('hseResponsible'),
      projectName: value('projectName'),
      siteLocation: value('siteLocation'),
      emirate: value('emirate').isEmpty ? 'Abu Dhabi' : value('emirate'),
      client: value('client'),
      mainContractor: value('mainContractor'),
      projectReference: value('projectReference'),
    );
  }
}

class WorkHubDailyLog {
  const WorkHubDailyLog({
    required this.id,
    required this.companyId,
    required this.date,
    required this.workDescription,
    this.startTime = '',
    this.finishTime = '',
    this.workforce = '',
    this.equipment = '',
    this.ptw = '',
    this.rams = '',
    this.observations = '',
    this.hazards = '',
    this.actions = '',
    this.incidentNearMiss = '',
    this.supervisor = '',
    this.hseOfficer = '',
    this.status = 'Draft',
    this.createdAt = '',
    this.updatedAt = '',
  });

  final String id;
  final String companyId;
  final String date;
  final String workDescription;
  final String startTime;
  final String finishTime;
  final String workforce;
  final String equipment;
  final String ptw;
  final String rams;
  final String observations;
  final String hazards;
  final String actions;
  final String incidentNearMiss;
  final String supervisor;
  final String hseOfficer;
  final String status;
  final String createdAt;
  final String updatedAt;

  WorkHubDailyLog copyWith({
    String? id,
    String? companyId,
    String? date,
    String? workDescription,
    String? startTime,
    String? finishTime,
    String? workforce,
    String? equipment,
    String? ptw,
    String? rams,
    String? observations,
    String? hazards,
    String? actions,
    String? incidentNearMiss,
    String? supervisor,
    String? hseOfficer,
    String? status,
    String? createdAt,
    String? updatedAt,
  }) {
    return WorkHubDailyLog(
      id: id ?? this.id,
      companyId: companyId ?? this.companyId,
      date: date ?? this.date,
      workDescription: workDescription ?? this.workDescription,
      startTime: startTime ?? this.startTime,
      finishTime: finishTime ?? this.finishTime,
      workforce: workforce ?? this.workforce,
      equipment: equipment ?? this.equipment,
      ptw: ptw ?? this.ptw,
      rams: rams ?? this.rams,
      observations: observations ?? this.observations,
      hazards: hazards ?? this.hazards,
      actions: actions ?? this.actions,
      incidentNearMiss: incidentNearMiss ?? this.incidentNearMiss,
      supervisor: supervisor ?? this.supervisor,
      hseOfficer: hseOfficer ?? this.hseOfficer,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'companyId': companyId,
        'date': date,
        'workDescription': workDescription,
        'startTime': startTime,
        'finishTime': finishTime,
        'workforce': workforce,
        'equipment': equipment,
        'ptw': ptw,
        'rams': rams,
        'observations': observations,
        'hazards': hazards,
        'actions': actions,
        'incidentNearMiss': incidentNearMiss,
        'supervisor': supervisor,
        'hseOfficer': hseOfficer,
        'status': status,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };

  factory WorkHubDailyLog.fromJson(Map<String, dynamic> json) {
    String value(String key) => (json[key] ?? '').toString();
    return WorkHubDailyLog(
      id: value('id'),
      companyId: value('companyId'),
      date: value('date'),
      workDescription: value('workDescription'),
      startTime: value('startTime'),
      finishTime: value('finishTime'),
      workforce: value('workforce'),
      equipment: value('equipment'),
      ptw: value('ptw'),
      rams: value('rams'),
      observations: value('observations'),
      hazards: value('hazards'),
      actions: value('actions'),
      incidentNearMiss: value('incidentNearMiss'),
      supervisor: value('supervisor'),
      hseOfficer: value('hseOfficer'),
      status: value('status').isEmpty ? 'Draft' : value('status'),
      createdAt: value('createdAt'),
      updatedAt: value('updatedAt'),
    );
  }
}

class WorkHubCompanyDayLogPage extends StatefulWidget {
  const WorkHubCompanyDayLogPage({super.key});

  @override
  State<WorkHubCompanyDayLogPage> createState() =>
      _WorkHubCompanyDayLogPageState();
}

class _WorkHubCompanyDayLogPageState extends State<WorkHubCompanyDayLogPage> {
  static const String _evidenceKey = 'workhub_daily_evidence_v1';
  static const String _companiesKey = 'workhub_companies_v1';
  static const String _logsKey = 'workhub_daily_logs_v1';
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);

  List<WorkHubCompany> _companies = <WorkHubCompany>[];
  List<WorkHubDailyLog> _logs = <WorkHubDailyLog>[];
  String? _activeCompanyId;
  bool _loading = true;

  WorkHubCompany? get _activeCompany {
    for (final company in _companies) {
      if (company.id == _activeCompanyId) return company;
    }
    return _companies.isEmpty ? null : _companies.first;
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final companyRaw = prefs.getString(_companiesKey);
    final logRaw = prefs.getString(_logsKey);
    final companies = <WorkHubCompany>[];
    final logs = <WorkHubDailyLog>[];

    if (companyRaw != null && companyRaw.isNotEmpty) {
      final decoded = jsonDecode(companyRaw);
      if (decoded is List) {
        for (final item in decoded) {
          if (item is Map) {
            companies.add(
              WorkHubCompany.fromJson(Map<String, dynamic>.from(item)),
            );
          }
        }
      }
    }

    if (logRaw != null && logRaw.isNotEmpty) {
      final decoded = jsonDecode(logRaw);
      if (decoded is List) {
        for (final item in decoded) {
          if (item is Map) {
            logs.add(WorkHubDailyLog.fromJson(Map<String, dynamic>.from(item)));
          }
        }
      }
    }

    final savedActive = prefs.getString('workhub_active_company_v1');
    if (!mounted) return;
    setState(() {
      _companies = companies;
      _logs = logs;
      _activeCompanyId = companies.any((c) => c.id == savedActive)
          ? savedActive
          : (companies.isEmpty ? null : companies.first.id);
      _loading = false;
    });
  }

  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _companiesKey,
      jsonEncode(_companies.map((e) => e.toJson()).toList()),
    );
    await prefs.setString(
      _logsKey,
      jsonEncode(_logs.map((e) => e.toJson()).toList()),
    );
    if (_activeCompanyId != null) {
      await prefs.setString('workhub_active_company_v1', _activeCompanyId!);
    }
  }

  Future<void> _selectCompany(String? id) async {
    if (id == null) return;
    setState(() => _activeCompanyId = id);
    await _saveData();
  }

  Future<void> _editCompany({WorkHubCompany? company}) async {
    final result = await Navigator.of(context).push<WorkHubCompany>(
      MaterialPageRoute<WorkHubCompany>(
        builder: (_) => WorkHubCompanyEditorPage(company: company),
      ),
    );
    if (result == null) return;

    final index = _companies.indexWhere((c) => c.id == result.id);
    setState(() {
      if (index == -1) {
        _companies = <WorkHubCompany>[..._companies, result];
      } else {
        final updated = <WorkHubCompany>[..._companies];
        updated[index] = result;
        _companies = updated;
      }
      _activeCompanyId = result.id;
    });
    await _saveData();
  }

  Future<void> _deleteCompany(WorkHubCompany company) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete company?'),
        content: Text(
          'Delete ${company.name} from the Company Master? Existing daily logs will be kept.',
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;

    setState(() {
      _companies = _companies.where((c) => c.id != company.id).toList();
      if (_activeCompanyId == company.id) {
        _activeCompanyId = _companies.isEmpty ? null : _companies.first.id;
      }
    });
    await _saveData();
  }

  Future<void> _newLog() async {
    if (_activeCompany == null) {
      await _editCompany();
      if (_activeCompany == null) return;
    }
    final result = await Navigator.of(context).push<WorkHubDailyLog>(
      MaterialPageRoute<WorkHubDailyLog>(
        builder: (_) => WorkHubDailyLogEditorPage(
          company: _activeCompany!,
        ),
      ),
    );
    if (result == null) return;
    setState(() => _logs = <WorkHubDailyLog>[result, ..._logs]);
    await _saveData();
  }

  Future<void> _editLog(WorkHubDailyLog log) async {
    final company = _companies.firstWhere(
      (c) => c.id == log.companyId,
      orElse: () => _activeCompany!,
    );
    final result = await Navigator.of(context).push<WorkHubDailyLog>(
      MaterialPageRoute<WorkHubDailyLog>(
        builder: (_) => WorkHubDailyLogEditorPage(
          company: company,
          log: log,
        ),
      ),
    );
    if (result == null) return;
    final index = _logs.indexWhere((item) => item.id == result.id);
    setState(() {
      final updated = <WorkHubDailyLog>[..._logs];
      if (index == -1) {
        updated.insert(0, result);
      } else {
        updated[index] = result;
      }
      _logs = updated;
    });
    await _saveData();
  }

  Future<void> _deleteLog(WorkHubDailyLog log) async {
    setState(() => _logs = _logs.where((item) => item.id != log.id).toList());
    await _saveData();
  }

  Future<void> _copyLogAsNew(WorkHubDailyLog log) async {
    final now = DateTime.now();
    final copy = log.copyWith(
      id: 'LOG-${now.microsecondsSinceEpoch}',
      date: _dateOnly(now),
      status: 'Draft',
      createdAt: now.toIso8601String(),
      updatedAt: now.toIso8601String(),
      finishTime: '',
      actions: '',
    );
    setState(() => _logs = <WorkHubDailyLog>[copy, ..._logs]);
    await _saveData();
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('New draft copied from the completed log.')),
    );
  }

  Future<void> _copyText(WorkHubDailyLog log) async {
    final company = _companyFor(log);
    await Clipboard.setData(ClipboardData(text: _logText(company, log)));
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Work log copied as text.')),
    );
  }

  WorkHubCompany _companyFor(WorkHubDailyLog log) {
    return _companies.firstWhere(
      (company) => company.id == log.companyId,
      orElse: () => const WorkHubCompany(id: 'unknown', name: 'Company'),
    );
  }

  String _dateOnly(DateTime date) {
    final y = date.year.toString().padLeft(4, '0');
    final m = date.month.toString().padLeft(2, '0');
    final d = date.day.toString().padLeft(2, '0');
    return '$y-$m-$d';
  }

  String _logText(WorkHubCompany company, WorkHubDailyLog log) {
    return '''SAFENEXUS HSE — DAILY WORK LOG

Company: ${company.name}
Project: ${company.projectName}
Site: ${company.siteLocation}
Emirate: ${company.emirate}
Client: ${company.client}
Main Contractor: ${company.mainContractor}
Project Reference: ${company.projectReference}
Date: ${log.date}
Status: ${log.status}

WORK
${log.workDescription}

Time: ${log.startTime} - ${log.finishTime}
Workforce: ${log.workforce}
Equipment: ${log.equipment}
PTW: ${log.ptw}
RAMS: ${log.rams}

HSE OBSERVATIONS
${log.observations}

HAZARDS
${log.hazards}

CORRECTIVE ACTIONS
${log.actions}

INCIDENT / NEAR MISS
${log.incidentNearMiss}

Supervisor: ${log.supervisor}
HSE Officer: ${log.hseOfficer}
''';
  }

  Future<List<Map<String, String>>> _evidenceForLog(
    String logId,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_evidenceKey);
    if (raw == null || raw.trim().isEmpty) {
      return <Map<String, String>>[];
    }

    try {
      final decoded = jsonDecode(raw);
      if (decoded is! List) {
        return <Map<String, String>>[];
      }

      final result = <Map<String, String>>[];
      for (final item in decoded) {
        if (item is! Map) continue;
        final map = Map<String, dynamic>.from(item);
        if ((map['logId'] ?? '').toString() != logId) continue;

        result.add(
          <String, String>{
            'type': (map['type'] ?? 'note').toString(),
            'title': (map['title'] ?? 'HSE Evidence').toString(),
            'content': (map['content'] ?? '').toString(),
            'createdAt': (map['createdAt'] ?? '').toString(),
          },
        );
      }
      return result;
    } catch (_) {
      return <Map<String, String>>[];
    }
  }

  String _evidenceText(List<Map<String, String>> evidence) {
    if (evidence.isEmpty) return 'No evidence attached.';

    final buffer = StringBuffer();
    for (var i = 0; i < evidence.length; i++) {
      final item = evidence[i];
      final type = item['type'] ?? 'note';
      final title = item['title'] ?? 'HSE Evidence';
      final content = item['content'] ?? '';

      buffer
        ..writeln('${i + 1}. $title')
        ..writeln('Type: $type')
        ..writeln(
          type == 'photo' ? 'Photo: $content' : 'Details: $content',
        )
        ..writeln();
    }
    return buffer.toString().trim();
  }

  Future<void> _export(WorkHubDailyLog log, _ExportFormat format) async {
    final company = _companyFor(log);
    try {
      final evidence = await _evidenceForLog(log.id);
      final path = switch (format) {
        _ExportFormat.pdf => await _exportPdf(company, log, evidence),
        _ExportFormat.word => await _exportWord(company, log, evidence),
        _ExportFormat.excel => await _exportExcel(company, log, evidence),
        _ExportFormat.image => await _exportImage(company, log, evidence),
      };
      if (!mounted) return;
      await Share.shareXFiles(
        <XFile>[XFile(path)],
        text: 'SafeNexus HSE — ${company.name} — Daily Work Log ${log.date}',
      );
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Export failed: $error')),
      );
    }
  }

  Future<String> _exportPdf(
    WorkHubCompany company,
    WorkHubDailyLog log,
    List<Map<String, String>> evidence,
  ) async {
    final document = pw.Document();
    pw.MemoryImage? logo;
    if (company.logoPath.isNotEmpty) {
      final file = File(company.logoPath);
      if (await file.exists()) {
        logo = pw.MemoryImage(await file.readAsBytes());
      }
    }
    final rows = <List<String>>[
      <String>['Company', company.name],
      <String>['Project', company.projectName],
      <String>['Site / Emirate', '${company.siteLocation} / ${company.emirate}'],
      <String>['Date', log.date],
      <String>['Status', log.status],
      <String>['Work', log.workDescription],
      <String>['Time', '${log.startTime} - ${log.finishTime}'],
      <String>['Workforce', log.workforce],
      <String>['Equipment', log.equipment],
      <String>['PTW', log.ptw],
      <String>['RAMS', log.rams],
      <String>['Observations', log.observations],
      <String>['Hazards', log.hazards],
      <String>['Corrective Actions', log.actions],
      <String>['Incident / Near Miss', log.incidentNearMiss],
      <String>['Supervisor', log.supervisor],
      <String>['HSE Officer', log.hseOfficer],
    ];
    if (evidence.isNotEmpty) {
      rows.add(<String>['Evidence Summary', _evidenceText(evidence)]);
    }

    document.addPage(
      pw.MultiPage(
        build: (context) => <pw.Widget>[
          if (logo != null)
            pw.Container(
              alignment: pw.Alignment.centerLeft,
              height: 55,
              child: pw.Image(logo, fit: pw.BoxFit.contain),
            ),
          pw.SizedBox(height: 8),
          pw.Text(
            'SafeNexus HSE — Daily Work Log',
            style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 10),
          pw.TableHelper.fromTextArray(
            headers: const <String>['Field', 'Details'],
            data: rows,
            cellStyle: const pw.TextStyle(fontSize: 8),
            headerStyle: pw.TextStyle(
              fontSize: 8,
              fontWeight: pw.FontWeight.bold,
            ),
            cellPadding: const pw.EdgeInsets.all(5),
          ),
        ],
      ),
    );
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/SafeNexus_${_safeName(log.id)}.pdf');
    await file.writeAsBytes(await document.save(), flush: true);
    return file.path;
  }

  Future<String> _exportWord(
    WorkHubCompany company,
    WorkHubDailyLog log,
    List<Map<String, String>> evidence,
  ) async {
    final document = docx.loadDocxDocument();
    document.addHeading(text: 'SafeNexus HSE — Daily Work Log', level: 1);
    document.addParagraph(text: 'Company: ${company.name}');
    document.addParagraph(text: 'Project: ${company.projectName}');
    document.addParagraph(text: 'Site: ${company.siteLocation}');
    document.addParagraph(text: 'Emirate: ${company.emirate}');
    document.addParagraph(text: 'Date: ${log.date}');
    document.addParagraph(text: 'Status: ${log.status}');
    document.addHeading(text: 'Work Details', level: 2);
    final table = document.addTable(14, 2, style: 'Table Grid');
    final rows = <List<String>>[
      <String>['Work', log.workDescription],
      <String>['Time', '${log.startTime} - ${log.finishTime}'],
      <String>['Workforce', log.workforce],
      <String>['Equipment', log.equipment],
      <String>['PTW', log.ptw],
      <String>['RAMS', log.rams],
      <String>['Observations', log.observations],
      <String>['Hazards', log.hazards],
      <String>['Actions', log.actions],
      <String>['Incident / Near Miss', log.incidentNearMiss],
      <String>['Supervisor', log.supervisor],
      <String>['HSE Officer', log.hseOfficer],
      <String>['Client', company.client],
      <String>['Project Reference', company.projectReference],
    ];
    for (var i = 0; i < rows.length; i++) {
      table.cell(i, 0).text = rows[i][0];
      table.cell(i, 1).text = rows[i][1];
    }
    document.addHeading(text: 'Evidence Summary', level: 2);
    document.addParagraph(text: _evidenceText(evidence));
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/SafeNexus_${_safeName(log.id)}.docx';
    document.save(filePath);
    return filePath;
  }

  Future<String> _exportExcel(
    WorkHubCompany company,
    WorkHubDailyLog log,
    List<Map<String, String>> evidence,
  ) async {
    final excel = Excel.createExcel();
    final sheet = excel['Daily Work Log'];
    final rows = <List<String>>[
      <String>['Field', 'Details'],
      <String>['Company', company.name],
      <String>['Address', company.address],
      <String>['Contact', company.contact],
      <String>['Email', company.email],
      <String>['HSE Responsible', company.hseResponsible],
      <String>['Project', company.projectName],
      <String>['Site', company.siteLocation],
      <String>['Emirate', company.emirate],
      <String>['Client', company.client],
      <String>['Main Contractor', company.mainContractor],
      <String>['Project Reference', company.projectReference],
      <String>['Date', log.date],
      <String>['Status', log.status],
      <String>['Work', log.workDescription],
      <String>['Start Time', log.startTime],
      <String>['Finish Time', log.finishTime],
      <String>['Workforce', log.workforce],
      <String>['Equipment', log.equipment],
      <String>['PTW', log.ptw],
      <String>['RAMS', log.rams],
      <String>['Observations', log.observations],
      <String>['Hazards', log.hazards],
      <String>['Corrective Actions', log.actions],
      <String>['Incident / Near Miss', log.incidentNearMiss],
      <String>['Supervisor', log.supervisor],
      <String>['HSE Officer', log.hseOfficer],
    ];
    if (evidence.isNotEmpty) {
      rows.add(<String>[
        'Evidence Summary',
        'Attached evidence: ${evidence.length}',
      ]);
      for (final item in evidence) {
        rows.add(<String>[
          'Evidence: ${item['title'] ?? 'HSE Evidence'}',
          item['type'] == 'photo'
              ? 'Photo: ${item['content'] ?? ''}'
              : (item['content'] ?? ''),
        ]);
      }
    }

    for (var row = 0; row < rows.length; row++) {
      sheet.updateCell(
        CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: row),
        TextCellValue(rows[row][0]),
      );
      sheet.updateCell(
        CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: row),
        TextCellValue(rows[row][1]),
      );
    }
    final bytes = excel.save();
    if (bytes == null) throw StateError('Excel file could not be generated.');
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/SafeNexus_${_safeName(log.id)}.xlsx');
    await file.writeAsBytes(bytes, flush: true);
    return file.path;
  }

  Future<String> _exportImage(
    WorkHubCompany company,
    WorkHubDailyLog log,
    List<Map<String, String>> evidence,
  ) async {
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/SafeNexus_${_safeName(log.id)}.png';
    final result = await Navigator.of(context).push<String>(
      PageRouteBuilder<String>(
        opaque: true,
        pageBuilder: (_, __, ___) => _ExportImagePreview(
          company: company,
          log: log,
          evidence: evidence,
          outputPath: path,
        ),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ),
    );
    if (result == null || result.isEmpty) {
      throw StateError('PNG export was cancelled.');
    }
    return result;
  }

  String _safeName(String value) {
    final cleaned = value.replaceAll(RegExp(r'[^a-zA-Z0-9_-]'), '_');
    return cleaned.isEmpty ? 'work_log' : cleaned;
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    final activeLogs = _activeCompany == null
        ? <WorkHubDailyLog>[]
        : _logs.where((log) => log.companyId == _activeCompany!.id).toList();

    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: darkGreen,
        elevation: 0,
        title: const Text(
          'Company & Daily Work Log',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _loadData,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: <Widget>[
            _sectionCard(
              title: 'Company Master',
              icon: Icons.business_outlined,
              child: Column(
                children: <Widget>[
                  if (_companies.isEmpty)
                    const Padding(
                      padding: EdgeInsets.only(bottom: 12),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Add your company profile once and reuse it in every daily log.'),
                      ),
                    )
                  else
                    DropdownButtonFormField<String>(
                      initialValue: _activeCompanyId,
                      decoration: const InputDecoration(
                        labelText: 'Active company',
                        border: OutlineInputBorder(),
                      ),
                      items: _companies
                          .map(
                            (company) => DropdownMenuItem<String>(
                              value: company.id,
                              child: Text(company.name),
                            ),
                          )
                          .toList(),
                      onChanged: _selectCompany,
                    ),
                  const SizedBox(height: 12),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: FilledButton.icon(
                          onPressed: () => _editCompany(),
                          icon: const Icon(Icons.add_business_outlined),
                          label: const Text('Add Company'),
                        ),
                      ),
                      if (_activeCompany != null) ...<Widget>[
                        const SizedBox(width: 8),
                        IconButton(
                          tooltip: 'Edit company',
                          onPressed: () => _editCompany(company: _activeCompany),
                          icon: const Icon(Icons.edit_outlined),
                        ),
                        IconButton(
                          tooltip: 'Delete company',
                          onPressed: () => _deleteCompany(_activeCompany!),
                          icon: const Icon(Icons.delete_outline),
                        ),
                      ],
                    ],
                  ),
                  if (_activeCompany != null) ...<Widget>[
                    const SizedBox(height: 12),
                    _companySummary(_activeCompany!),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 14),
            _sectionCard(
              title: 'Daily Work Log',
              icon: Icons.fact_check_outlined,
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          _activeCompany == null
                              ? 'Create a company first.'
                              : '${activeLogs.length} log(s) for ${_activeCompany!.name}',
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                      FilledButton.icon(
                        onPressed: _newLog,
                        icon: const Icon(Icons.add),
                        label: const Text('New Log'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  if (activeLogs.isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      child: Text('No daily work logs yet.'),
                    )
                  else
                    ...activeLogs.map(
                      (log) => _logCard(log, _activeCompany!),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionCard({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(icon, color: primaryGreen),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    color: darkGreen,
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            child,
          ],
        ),
      ),
    );
  }

  Widget _companySummary(WorkHubCompany company) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: primaryGreen.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Wrap(
        spacing: 16,
        runSpacing: 8,
        children: <Widget>[
          Text('Project: ${company.projectName.isEmpty ? '—' : company.projectName}'),
          Text('Site: ${company.siteLocation.isEmpty ? '—' : company.siteLocation}'),
          Text('Emirate: ${company.emirate}'),
          Text('HSE: ${company.hseResponsible.isEmpty ? '—' : company.hseResponsible}'),
        ],
      ),
    );
  }

  Widget _logCard(WorkHubDailyLog log, WorkHubCompany company) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    log.date,
                    style: const TextStyle(fontWeight: FontWeight.w800),
                  ),
                ),
                _statusChip(log.status),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              log.workDescription.isEmpty ? 'Work description not entered' : log.workDescription,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Text(
              '${company.projectName.isEmpty ? 'Project' : company.projectName} • ${log.id}',
              style: const TextStyle(fontSize: 11, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: <Widget>[
                _smallAction(Icons.edit_outlined, 'Edit', () => _editLog(log)),
                _smallAction(Icons.copy_outlined, 'Copy text', () => _copyText(log)),
                _smallAction(Icons.content_copy_outlined, 'Copy as new', () => _copyLogAsNew(log)),
                _smallAction(Icons.picture_as_pdf_outlined, 'PDF', () => _export(log, _ExportFormat.pdf)),
                _smallAction(Icons.description_outlined, 'Word', () => _export(log, _ExportFormat.word)),
                _smallAction(Icons.table_chart_outlined, 'Excel', () => _export(log, _ExportFormat.excel)),
                _smallAction(Icons.image_outlined, 'Image', () => _export(log, _ExportFormat.image)),
                _smallAction(Icons.delete_outline, 'Delete', () => _deleteLog(log)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _statusChip(String status) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: primaryGreen.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: const TextStyle(
          color: primaryGreen,
          fontSize: 11,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  Widget _smallAction(IconData icon, String label, VoidCallback onPressed) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 16),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 7),
        visualDensity: VisualDensity.compact,
      ),
    );
  }
}

enum _ExportFormat { pdf, word, excel, image }

class WorkHubCompanyEditorPage extends StatefulWidget {
  const WorkHubCompanyEditorPage({super.key, this.company});

  final WorkHubCompany? company;

  @override
  State<WorkHubCompanyEditorPage> createState() => _WorkHubCompanyEditorPageState();
}

class _WorkHubCompanyEditorPageState extends State<WorkHubCompanyEditorPage> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const List<String> _emirates = <String>[
    'Abu Dhabi',
    'Dubai',
    'Sharjah',
    'Ajman',
    'Umm Al Quwain',
    'Ras Al Khaimah',
    'Fujairah',
  ];

  late final TextEditingController _name;
  late final TextEditingController _address;
  late final TextEditingController _contact;
  late final TextEditingController _email;
  late final TextEditingController _hse;
  late final TextEditingController _project;
  late final TextEditingController _site;
  late final TextEditingController _client;
  late final TextEditingController _contractor;
  late final TextEditingController _reference;
  String _emirate = 'Abu Dhabi';
  String _logoPath = '';
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final c = widget.company;
    _name = TextEditingController(text: c?.name ?? '');
    _address = TextEditingController(text: c?.address ?? '');
    _contact = TextEditingController(text: c?.contact ?? '');
    _email = TextEditingController(text: c?.email ?? '');
    _hse = TextEditingController(text: c?.hseResponsible ?? '');
    _project = TextEditingController(text: c?.projectName ?? '');
    _site = TextEditingController(text: c?.siteLocation ?? '');
    _client = TextEditingController(text: c?.client ?? '');
    _contractor = TextEditingController(text: c?.mainContractor ?? '');
    _reference = TextEditingController(text: c?.projectReference ?? '');
    _emirate = c?.emirate ?? 'Abu Dhabi';
    _logoPath = c?.logoPath ?? '';
  }

  @override
  void dispose() {
    _name.dispose();
    _address.dispose();
    _contact.dispose();
    _email.dispose();
    _hse.dispose();
    _project.dispose();
    _site.dispose();
    _client.dispose();
    _contractor.dispose();
    _reference.dispose();
    super.dispose();
  }

  Future<void> _pickLogo() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1600,
      imageQuality: 90,
    );
    if (picked == null) return;
    final directory = await getApplicationDocumentsDirectory();
    final logoDirectory = Directory('${directory.path}/safenexus_company_logos');
    await logoDirectory.create(recursive: true);
    final extension = picked.path.toLowerCase().endsWith('.png') ? 'png' : 'jpg';
    final path = '${logoDirectory.path}/${DateTime.now().microsecondsSinceEpoch}.$extension';
    await File(picked.path).copy(path);
    if (!mounted) return;
    setState(() => _logoPath = path);
  }

  Future<void> _save() async {
    final name = _name.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Company name is required.')),
      );
      return;
    }
    setState(() => _saving = true);
    final now = DateTime.now();
    final company = WorkHubCompany(
      id: widget.company?.id ?? 'COMP-${now.microsecondsSinceEpoch}',
      name: name,
      logoPath: _logoPath,
      address: _address.text.trim(),
      contact: _contact.text.trim(),
      email: _email.text.trim(),
      hseResponsible: _hse.text.trim(),
      projectName: _project.text.trim(),
      siteLocation: _site.text.trim(),
      emirate: _emirate,
      client: _client.text.trim(),
      mainContractor: _contractor.text.trim(),
      projectReference: _reference.text.trim(),
    );
    if (!mounted) return;
    Navigator.of(context).pop(company);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8F7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: darkGreen,
        elevation: 0,
        title: Text(
          widget.company == null ? 'Add Company' : 'Edit Company',
          style: const TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          _logoCard(),
          const SizedBox(height: 12),
          _field(_name, 'Company Name', Icons.business_outlined, required: true),
          _field(_address, 'Company Address', Icons.location_on_outlined),
          _field(_contact, 'Contact Details', Icons.phone_outlined),
          _field(_email, 'Email', Icons.email_outlined),
          _field(_hse, 'HSE Responsible Person', Icons.health_and_safety_outlined),
          _field(_project, 'Project Name', Icons.apartment_outlined),
          _field(_site, 'Project / Site Location', Icons.place_outlined),
          DropdownButtonFormField<String>(
            initialValue: _emirate,
            decoration: const InputDecoration(
              labelText: 'Emirate',
              prefixIcon: Icon(Icons.map_outlined),
              border: OutlineInputBorder(),
            ),
            items: _emirates
                .map((e) => DropdownMenuItem<String>(value: e, child: Text(e)))
                .toList(),
            onChanged: (value) {
              if (value != null) setState(() => _emirate = value);
            },
          ),
          const SizedBox(height: 12),
          _field(_client, 'Client', Icons.handshake_outlined),
          _field(_contractor, 'Main Contractor', Icons.engineering_outlined),
          _field(_reference, 'Project Reference', Icons.tag_outlined),
          const SizedBox(height: 8),
          FilledButton.icon(
            onPressed: _saving ? null : _save,
            icon: const Icon(Icons.save_outlined),
            label: Text(_saving ? 'Saving...' : 'Save Company'),
            style: FilledButton.styleFrom(
              backgroundColor: primaryGreen,
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _logoCard() {
    final hasLogo = _logoPath.isNotEmpty && File(_logoPath).existsSync();
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: <Widget>[
            Container(
              width: 76,
              height: 76,
              decoration: BoxDecoration(
                color: primaryGreen.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(14),
              ),
              clipBehavior: Clip.antiAlias,
              child: hasLogo
                  ? Image.file(File(_logoPath), fit: BoxFit.contain)
                  : const Icon(Icons.business, size: 34, color: primaryGreen),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Company Logo',
                    style: TextStyle(fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 4),
                  const Text('Saved locally and reused in reports.'),
                  const SizedBox(height: 8),
                  OutlinedButton.icon(
                    onPressed: _pickLogo,
                    icon: const Icon(Icons.upload_outlined, size: 18),
                    label: Text(hasLogo ? 'Change Logo' : 'Add Logo'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _field(
    TextEditingController controller,
    String label,
    IconData icon, {
    bool required = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        maxLines: label.contains('Address') ? 2 : 1,
        decoration: InputDecoration(
          labelText: required ? '$label *' : label,
          prefixIcon: Icon(icon),
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}

class WorkHubDailyLogEditorPage extends StatefulWidget {
  const WorkHubDailyLogEditorPage({
    super.key,
    required this.company,
    this.log,
  });

  final WorkHubCompany company;
  final WorkHubDailyLog? log;

  @override
  State<WorkHubDailyLogEditorPage> createState() => _WorkHubDailyLogEditorPageState();
}

class _WorkHubDailyLogEditorPageState extends State<WorkHubDailyLogEditorPage> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  late DateTime _date;
  late final TextEditingController _work;
  late final TextEditingController _start;
  late final TextEditingController _finish;
  late final TextEditingController _workforce;
  late final TextEditingController _equipment;
  late final TextEditingController _ptw;
  late final TextEditingController _rams;
  late final TextEditingController _observations;
  late final TextEditingController _hazards;
  late final TextEditingController _actions;
  late final TextEditingController _incident;
  late final TextEditingController _supervisor;
  late final TextEditingController _hse;
  String _status = 'Draft';

  @override
  void initState() {
    super.initState();
    final log = widget.log;
    _date = log == null ? DateTime.now() : DateTime.tryParse(log.date) ?? DateTime.now();
    _work = TextEditingController(text: log?.workDescription ?? '');
    _start = TextEditingController(text: log?.startTime ?? '');
    _finish = TextEditingController(text: log?.finishTime ?? '');
    _workforce = TextEditingController(text: log?.workforce ?? '');
    _equipment = TextEditingController(text: log?.equipment ?? '');
    _ptw = TextEditingController(text: log?.ptw ?? '');
    _rams = TextEditingController(text: log?.rams ?? '');
    _observations = TextEditingController(text: log?.observations ?? '');
    _hazards = TextEditingController(text: log?.hazards ?? '');
    _actions = TextEditingController(text: log?.actions ?? '');
    _incident = TextEditingController(text: log?.incidentNearMiss ?? '');
    _supervisor = TextEditingController(text: log?.supervisor ?? '');
    _hse = TextEditingController(text: log?.hseOfficer ?? widget.company.hseResponsible);
    _status = log?.status ?? 'Draft';
  }

  @override
  void dispose() {
    _work.dispose();
    _start.dispose();
    _finish.dispose();
    _workforce.dispose();
    _equipment.dispose();
    _ptw.dispose();
    _rams.dispose();
    _observations.dispose();
    _hazards.dispose();
    _actions.dispose();
    _incident.dispose();
    _supervisor.dispose();
    _hse.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final value = await showDatePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      initialDate: _date,
    );
    if (value != null) setState(() => _date = value);
  }

  Future<void> _save() async {
    if (_work.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Work description is required.')),
      );
      return;
    }
    final now = DateTime.now();
    final log = WorkHubDailyLog(
      id: widget.log?.id ?? 'LOG-${now.microsecondsSinceEpoch}',
      companyId: widget.company.id,
      date: _dateOnly(_date),
      workDescription: _work.text.trim(),
      startTime: _start.text.trim(),
      finishTime: _finish.text.trim(),
      workforce: _workforce.text.trim(),
      equipment: _equipment.text.trim(),
      ptw: _ptw.text.trim(),
      rams: _rams.text.trim(),
      observations: _observations.text.trim(),
      hazards: _hazards.text.trim(),
      actions: _actions.text.trim(),
      incidentNearMiss: _incident.text.trim(),
      supervisor: _supervisor.text.trim(),
      hseOfficer: _hse.text.trim(),
      status: _status,
      createdAt: widget.log?.createdAt.isNotEmpty == true
          ? widget.log!.createdAt
          : now.toIso8601String(),
      updatedAt: now.toIso8601String(),
    );
    if (!mounted) return;
    Navigator.of(context).pop(log);
  }

  String _dateOnly(DateTime date) {
    return '${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8F7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: darkGreen,
        elevation: 0,
        title: Text(
          widget.log == null ? 'New Daily Work Log' : 'Edit Daily Work Log',
          style: const TextStyle(fontWeight: FontWeight.w800),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          _companyBanner(),
          const SizedBox(height: 12),
          _dateAndStatus(),
          const SizedBox(height: 12),
          _area('Work Details', Icons.work_outline, <Widget>[
            _field(_work, 'Work Description', maxLines: 4, required: true),
            _field(_start, 'Start Time'),
            _field(_finish, 'Finish Time'),
            _field(_workforce, 'Workforce'),
            _field(_equipment, 'Equipment / Machinery', maxLines: 3),
            _field(_ptw, 'PTW Reference / Status'),
            _field(_rams, 'RAMS Reference / Status'),
          ]),
          _area('HSE Record', Icons.health_and_safety_outlined, <Widget>[
            _field(_observations, 'HSE Observations', maxLines: 4),
            _field(_hazards, 'Hazards / Unsafe Conditions', maxLines: 4),
            _field(_actions, 'Corrective Actions', maxLines: 4),
            _field(_incident, 'Incident / Near Miss', maxLines: 4),
          ]),
          _area('Responsibility', Icons.assignment_ind_outlined, <Widget>[
            _field(_supervisor, 'Supervisor'),
            _field(_hse, 'HSE Officer'),
          ]),
          const SizedBox(height: 4),
          FilledButton.icon(
            onPressed: _save,
            icon: const Icon(Icons.save_outlined),
            label: const Text('Save Daily Work Log'),
            style: FilledButton.styleFrom(
              backgroundColor: primaryGreen,
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _companyBanner() {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: <Widget>[
            Container(
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                color: primaryGreen.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(12),
              ),
              clipBehavior: Clip.antiAlias,
              child: widget.company.logoPath.isNotEmpty &&
                      File(widget.company.logoPath).existsSync()
                  ? Image.file(File(widget.company.logoPath), fit: BoxFit.contain)
                  : const Icon(Icons.business, color: primaryGreen),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(widget.company.name, style: const TextStyle(fontWeight: FontWeight.w800)),
                  Text(widget.company.projectName.isEmpty ? 'Project not specified' : widget.company.projectName),
                  Text('${widget.company.siteLocation} • ${widget.company.emirate}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _dateAndStatus() {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: <Widget>[
            Expanded(
              child: OutlinedButton.icon(
                onPressed: _pickDate,
                icon: const Icon(Icons.calendar_today_outlined),
                label: Text(_dateOnly(_date)),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: DropdownButtonFormField<String>(
                initialValue: _status,
                decoration: const InputDecoration(
                  labelText: 'Status',
                  border: OutlineInputBorder(),
                ),
                items: const <DropdownMenuItem<String>>[
                  DropdownMenuItem(value: 'Draft', child: Text('Draft')),
                  DropdownMenuItem(value: 'In Progress', child: Text('In Progress')),
                  DropdownMenuItem(value: 'Completed', child: Text('Completed')),
                ],
                onChanged: (value) {
                  if (value != null) setState(() => _status = value);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _area(String title, IconData icon, List<Widget> children) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(icon, color: primaryGreen),
                const SizedBox(width: 8),
                Text(title, style: const TextStyle(color: darkGreen, fontWeight: FontWeight.w800)),
              ],
            ),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _field(
    TextEditingController controller,
    String label, {
    int maxLines = 1,
    bool required = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: required ? '$label *' : label,
          border: const OutlineInputBorder(),
          alignLabelWithHint: maxLines > 1,
        ),
      ),
    );
  }
}

class _ExportImagePreview extends StatefulWidget {
  const _ExportImagePreview({
    required this.company,
    required this.log,
    required this.evidence,
    required this.outputPath,
  });

  final WorkHubCompany company;
  final WorkHubDailyLog log;
  final List<Map<String, String>> evidence;
  final String outputPath;

  @override
  State<_ExportImagePreview> createState() => _ExportImagePreviewState();
}

class _ExportImagePreviewState extends State<_ExportImagePreview> {
  final GlobalKey _boundaryKey = GlobalKey();
  bool _capturing = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _capture());
  }

  Future<void> _capture() async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 160));
      final renderObject = _boundaryKey.currentContext?.findRenderObject();
      if (renderObject is! RenderRepaintBoundary) {
        throw StateError('Export image is not ready.');
      }
      final image = await renderObject.toImage(pixelRatio: 2.0);
      final data = await image.toByteData(format: ui.ImageByteFormat.png);
      image.dispose();
      if (data == null) throw StateError('PNG conversion failed.');
      await File(widget.outputPath).writeAsBytes(
        data.buffer.asUint8List(),
        flush: true,
      );
      if (!mounted) return;
      Navigator.of(context).pop(widget.outputPath);
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _capturing = false;
        _error = error.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8F7),
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF0B5D4B),
        title: const Text('Preparing Image Export'),
      ),
      body: Stack(
        children: <Widget>[
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: RepaintBoundary(
                key: _boundaryKey,
                child: Container(
                  width: 700,
                  padding: const EdgeInsets.all(28),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          if (widget.company.logoPath.isNotEmpty &&
                              File(widget.company.logoPath).existsSync())
                            SizedBox(
                              width: 70,
                              height: 70,
                              child: Image.file(
                                File(widget.company.logoPath),
                                fit: BoxFit.contain,
                              ),
                            ),
                          const SizedBox(width: 16),
                          const Expanded(
                            child: Text(
                              'SafeNexus HSE — Daily Work Log',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 32),
                      _row('Company', widget.company.name),
                      _row('Project', widget.company.projectName),
                      _row(
                        'Site / Emirate',
                        '${widget.company.siteLocation} / ${widget.company.emirate}',
                      ),
                      _row('Date', widget.log.date),
                      _row('Status', widget.log.status),
                      _row('Work', widget.log.workDescription),
                      _row('Time', '${widget.log.startTime} - ${widget.log.finishTime}'),
                      _row('Workforce', widget.log.workforce),
                      _row('Equipment', widget.log.equipment),
                      _row('PTW', widget.log.ptw),
                      _row('RAMS', widget.log.rams),
                      _row('Observations', widget.log.observations),
                      _row('Hazards', widget.log.hazards),
                      _row('Corrective Actions', widget.log.actions),
                      _row('Incident / Near Miss', widget.log.incidentNearMiss),
                      _row('Supervisor', widget.log.supervisor),
                      _row('HSE Officer', widget.log.hseOfficer),
                      const SizedBox(height: 12),
                      const Text(
                        'Evidence Summary',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 8),
                      if (widget.evidence.isEmpty)
                        const Text('No evidence attached.')
                      else
                        ...widget.evidence.map(
                          (item) => Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const Icon(
                                  Icons.verified_outlined,
                                  size: 18,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    '${item['title'] ?? 'HSE Evidence'} • ${item['type'] ?? 'note'}\n'
                                    '${item['type'] == 'photo' ? 'Photo evidence attached' : (item['content'] ?? '')}',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (_capturing)
            const Center(child: CircularProgressIndicator())
          else if (_error != null)
            Center(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text('Image export failed: $_error'),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 150,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w800),
            ),
          ),
          Expanded(child: Text(value.isEmpty ? '—' : value)),
        ],
      ),
    );
  }
}

