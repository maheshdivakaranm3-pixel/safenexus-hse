import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// SafeNexus HSE — Step 113
/// Daily Work Evidence & Attachment Hub.
///
/// This layer intentionally keeps Step 111/112 storage unchanged.
/// It stores evidence metadata in its own SharedPreferences key and copies
/// selected image files into the app documents directory.
class SafeNexusEvidenceHubPage extends StatefulWidget {
  const SafeNexusEvidenceHubPage({super.key});

  @override
  State<SafeNexusEvidenceHubPage> createState() =>
      _SafeNexusEvidenceHubPageState();
}

class _SafeNexusEvidenceHubPageState
    extends State<SafeNexusEvidenceHubPage> {
  static const String _dailyLogsKey = 'workhub_daily_logs_v1';
  static const String _evidenceKey = 'workhub_daily_evidence_v1';
  static const String _evidenceFolder = 'safenexus_hse_evidence';

  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);

  final ImagePicker _picker = ImagePicker();

  bool _loading = true;
  List<Map<String, dynamic>> _dailyLogs = <Map<String, dynamic>>[];
  List<DailyEvidenceRecord> _records = <DailyEvidenceRecord>[];
  String? _selectedLogId;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final logs = _readJsonList(prefs.getString(_dailyLogsKey));
    final evidence = _readJsonList(prefs.getString(_evidenceKey))
        .map(DailyEvidenceRecord.fromJson)
        .toList();

    if (!mounted) return;

    setState(() {
      _dailyLogs = logs;
      _records = evidence;
      _loading = false;
      if (_selectedLogId == null && logs.isNotEmpty) {
        _selectedLogId = _recordId(logs.first);
      }
    });
  }

  List<Map<String, dynamic>> _readJsonList(String? raw) {
    if (raw == null || raw.trim().isEmpty) {
      return <Map<String, dynamic>>[];
    }

    try {
      final decoded = jsonDecode(raw);
      if (decoded is List) {
        return decoded
            .whereType<Map>()
            .map(
              (item) => Map<String, dynamic>.from(item),
            )
            .toList();
      }
    } catch (_) {
      // Keep the hub usable even if another module contains invalid data.
    }

    return <Map<String, dynamic>>[];
  }

  String _recordId(Map<String, dynamic> record) {
    final id = (record['id'] ?? '').toString().trim();
    return id;
  }

  String _recordTitle(Map<String, dynamic> record) {
    final description = (record['workDescription'] ??
            record['description'] ??
            record['activity'] ??
            record['work'] ??
            'Daily HSE Work')
        .toString()
        .trim();

    return description.isEmpty ? 'Daily HSE Work' : description;
  }

  String _recordDate(Map<String, dynamic> record) {
    final date = (record['date'] ??
            record['workDate'] ??
            record['createdAt'] ??
            '')
        .toString()
        .trim();

    return date.isEmpty ? 'Date not recorded' : date;
  }

  List<DailyEvidenceRecord> get _selectedEvidence {
    final logId = _selectedLogId;
    if (logId == null) return <DailyEvidenceRecord>[];

    return _records
        .where((record) => record.logId == logId)
        .toList()
      ..sort(
        (a, b) => b.createdAt.compareTo(a.createdAt),
      );
  }

  Map<String, dynamic>? get _selectedLog {
    final logId = _selectedLogId;
    if (logId == null) return null;

    for (final log in _dailyLogs) {
      if (_recordId(log) == logId) return log;
    }
    return null;
  }

  Future<void> _saveRecords() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _evidenceKey,
      jsonEncode(
        _records.map((record) => record.toJson()).toList(),
      ),
    );
  }

  Future<void> _addPhoto(ImageSource source) async {
    final log = _selectedLog;
    final logId = _selectedLogId;

    if (log == null || logId == null) {
      _showMessage('Select a Daily Work Record first.');
      return;
    }

    try {
      final XFile? picked = await _picker.pickImage(
        source: source,
        imageQuality: 88,
        maxWidth: 2200,
      );

      if (picked == null) return;

      final directory = await getApplicationDocumentsDirectory();
      final evidenceDirectory = Directory(
        '${directory.path}/$_evidenceFolder',
      );

      if (!await evidenceDirectory.exists()) {
        await evidenceDirectory.create(recursive: true);
      }

      final extension = _extensionOf(picked.path);
      final id = _newId();
      final target = File(
        '${evidenceDirectory.path}/$id$extension',
      );

      await File(picked.path).copy(target.path);

      final record = DailyEvidenceRecord(
        id: id,
        logId: logId,
        type: 'photo',
        title: 'Site Evidence Photo',
        content: target.path,
        createdAt: DateTime.now().toIso8601String(),
      );

      setState(() {
        _records.add(record);
      });
      await _saveRecords();

      _showMessage('Photo evidence saved.');
    } catch (error) {
      _showMessage('Could not save photo evidence.');
    }
  }

  String _extensionOf(String path) {
    final dot = path.lastIndexOf('.');
    if (dot < 0 || dot == path.length - 1) return '.jpg';
    final extension = path.substring(dot).toLowerCase();
    if (extension.length > 6) return '.jpg';
    return extension;
  }

  Future<void> _addNote() async {
    final log = _selectedLog;
    final logId = _selectedLogId;

    if (log == null || logId == null) {
      _showMessage('Select a Daily Work Record first.');
      return;
    }

    final result = await showDialog<_EvidenceNoteResult>(
      context: context,
      builder: (_) => const _EvidenceNoteDialog(),
    );

    if (result == null || result.text.trim().isEmpty) return;

    final record = DailyEvidenceRecord(
      id: _newId(),
      logId: logId,
      type: result.type,
      title: result.title.trim().isEmpty
          ? 'HSE Evidence Note'
          : result.title.trim(),
      content: result.text.trim(),
      createdAt: DateTime.now().toIso8601String(),
    );

    setState(() {
      _records.add(record);
    });
    await _saveRecords();

    _showMessage('Evidence note saved.');
  }

  Future<void> _deleteEvidence(DailyEvidenceRecord record) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete evidence?'),
        content: Text(
          'Delete "${record.title}" from this Daily Work Record?',
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    if (record.type == 'photo') {
      final file = File(record.content);
      if (await file.exists()) {
        try {
          await file.delete();
        } catch (_) {
          // Metadata deletion remains possible if the file is unavailable.
        }
      }
    }

    setState(() {
      _records.removeWhere((item) => item.id == record.id);
    });
    await _saveRecords();

    _showMessage('Evidence deleted.');
  }

  Future<void> _copySummary() async {
    final log = _selectedLog;
    if (log == null) {
      _showMessage('Select a Daily Work Record first.');
      return;
    }

    final evidence = _selectedEvidence;
    final buffer = StringBuffer()
      ..writeln('SafeNexus HSE - Daily Work Evidence')
      ..writeln('Record ID: ${_recordId(log)}')
      ..writeln('Work: ${_recordTitle(log)}')
      ..writeln('Date: ${_recordDate(log)}')
      ..writeln('Evidence Count: ${evidence.length}')
      ..writeln();

    for (var index = 0; index < evidence.length; index++) {
      final item = evidence[index];
      buffer
        ..writeln('${index + 1}. ${item.title}')
        ..writeln('Type: ${item.type}')
        ..writeln(
          item.type == 'photo'
              ? 'Photo: ${item.content}'
              : 'Details: ${item.content}',
        )
        ..writeln();
    }

    await Clipboard.setData(
      ClipboardData(text: buffer.toString().trim()),
    );
    _showMessage('Evidence summary copied.');
  }

  String _newId() {
    return '${DateTime.now().microsecondsSinceEpoch}_${_records.length}';
  }

  void _showMessage(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: darkGreen,
        elevation: 0,
        title: const Text(
          'Evidence Hub',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        actions: <Widget>[
          IconButton(
            tooltip: 'Copy evidence summary',
            onPressed: _copySummary,
            icon: const Icon(Icons.copy_all_outlined),
          ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadData,
              child: _buildBody(),
            ),
    );
  }

  Widget _buildBody() {
    if (_dailyLogs.isEmpty) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(20),
        children: <Widget>[
          _infoCard(
            icon: Icons.assignment_late_outlined,
            title: 'No Daily Work Records',
            text:
                'Create a Daily Work Record in WorkHub first. Evidence can then be attached to that specific record.',
          ),
        ],
      );
    }

    final selectedLog = _selectedLog;
    final evidence = _selectedEvidence;

    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
      children: <Widget>[
        _buildRecordSelector(),
        const SizedBox(height: 14),
        if (selectedLog != null) _buildRecordCard(selectedLog),
        const SizedBox(height: 14),
        _buildAddEvidenceCard(),
        const SizedBox(height: 16),
        Row(
          children: <Widget>[
            const Expanded(
              child: Text(
                'Evidence & Attachments',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: darkGreen,
                ),
              ),
            ),
            Text(
              '${evidence.length}',
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                color: primaryGreen,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        if (evidence.isEmpty)
          _infoCard(
            icon: Icons.photo_library_outlined,
            title: 'No Evidence Added',
            text:
                'Add site photos, HSE notes, observations, hazards or corrective-action evidence for this work record.',
          )
        else
          ...evidence.map(_buildEvidenceTile),
      ],
    );
  }

  Widget _buildRecordSelector() {
    final validLogs = _dailyLogs
        .where((log) => _recordId(log).isNotEmpty)
        .toList();

    if (validLogs.isEmpty) {
      return _infoCard(
        icon: Icons.link_off_outlined,
        title: 'Daily Work IDs Missing',
        text:
            'The Evidence Hub requires a Daily Work Record ID. Existing records are not modified here.',
      );
    }

    final selectedValue = validLogs.any(
      (log) => _recordId(log) == _selectedLogId,
    )
        ? _selectedLogId
        : _recordId(validLogs.first);

    if (_selectedLogId != selectedValue) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          setState(() {
            _selectedLogId = selectedValue;
          });
        }
      });
    }

    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: primaryGreen.withValues(alpha: 0.16),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: DropdownButtonFormField<String>(
          initialValue: selectedValue,
          decoration: const InputDecoration(
            labelText: 'Daily Work Record',
            prefixIcon: Icon(Icons.assignment_outlined),
            border: OutlineInputBorder(),
          ),
          items: validLogs.map((log) {
            final id = _recordId(log);
            return DropdownMenuItem<String>(
              value: id,
              child: Text(
                '${_recordTitle(log)} • ${_recordDate(log)}',
                overflow: TextOverflow.ellipsis,
              ),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _selectedLogId = value;
            });
          },
        ),
      ),
    );
  }

  Widget _buildRecordCard(Map<String, dynamic> log) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      color: darkGreen,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Selected Work Record',
              style: TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              _recordTitle(log),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'ID: ${_recordId(log)}',
              style: const TextStyle(color: Colors.white70),
            ),
            Text(
              'Date: ${_recordDate(log)}',
              style: const TextStyle(color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddEvidenceCard() {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: primaryGreen.withValues(alpha: 0.16),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Add Evidence',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: darkGreen,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Keep evidence scoped to the selected Daily Work Record.',
            ),
            const SizedBox(height: 12),
            Row(
              children: <Widget>[
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _addPhoto(ImageSource.camera),
                    icon: const Icon(Icons.camera_alt_outlined),
                    label: const Text('Camera'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _addPhoto(ImageSource.gallery),
                    icon: const Icon(Icons.photo_library_outlined),
                    label: const Text('Gallery'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: _addNote,
                icon: const Icon(Icons.note_add_outlined),
                label: const Text('Add HSE Evidence Note'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEvidenceTile(DailyEvidenceRecord record) {
    final isPhoto = record.type == 'photo';
    final file = isPhoto ? File(record.content) : null;
    final exists = file != null && file.existsSync();

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.fromLTRB(12, 8, 8, 8),
        leading: _evidenceLeading(
          isPhoto: isPhoto,
          fileExists: exists,
          file: file,
        ),
        title: Text(
          record.title,
          style: const TextStyle(fontWeight: FontWeight.w700),
        ),
        subtitle: Text(
          isPhoto
              ? (exists ? 'Photo evidence' : 'Photo file unavailable')
              : record.content,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: IconButton(
          tooltip: 'Delete',
          onPressed: () => _deleteEvidence(record),
          icon: const Icon(Icons.delete_outline),
        ),
      ),
    );
  }

  Widget _evidenceLeading({
    required bool isPhoto,
    required bool fileExists,
    required File? file,
  }) {
    if (!isPhoto) {
      return const CircleAvatar(
        child: Icon(Icons.description_outlined),
      );
    }

    if (!fileExists || file == null) {
      return const CircleAvatar(
        child: Icon(Icons.broken_image_outlined),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.file(
        file,
        width: 54,
        height: 54,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _infoCard({
    required IconData icon,
    required String title,
    required String text,
  }) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(icon, color: primaryGreen, size: 28),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      color: darkGreen,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(text),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DailyEvidenceRecord {
  final String id;
  final String logId;
  final String type;
  final String title;
  final String content;
  final String createdAt;

  const DailyEvidenceRecord({
    required this.id,
    required this.logId,
    required this.type,
    required this.title,
    required this.content,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'logId': logId,
      'type': type,
      'title': title,
      'content': content,
      'createdAt': createdAt,
    };
  }

  factory DailyEvidenceRecord.fromJson(Map<String, dynamic> json) {
    return DailyEvidenceRecord(
      id: (json['id'] ?? '').toString(),
      logId: (json['logId'] ?? '').toString(),
      type: (json['type'] ?? 'note').toString(),
      title: (json['title'] ?? 'HSE Evidence').toString(),
      content: (json['content'] ?? '').toString(),
      createdAt: (json['createdAt'] ?? '').toString(),
    );
  }
}

class _EvidenceNoteResult {
  final String title;
  final String text;
  final String type;

  const _EvidenceNoteResult({
    required this.title,
    required this.text,
    required this.type,
  });
}

class _EvidenceNoteDialog extends StatefulWidget {
  const _EvidenceNoteDialog();

  @override
  State<_EvidenceNoteDialog> createState() => _EvidenceNoteDialogState();
}

class _EvidenceNoteDialogState extends State<_EvidenceNoteDialog> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _textController = TextEditingController();

  String _type = 'observation';

  @override
  void dispose() {
    _titleController.dispose();
    _textController.dispose();
    super.dispose();
  }

  void _save() {
    if (_textController.text.trim().isEmpty) return;

    Navigator.of(context).pop(
      _EvidenceNoteResult(
        title: _titleController.text,
        text: _textController.text,
        type: _type,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add HSE Evidence Note'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                hintText: 'Example: Housekeeping observation',
              ),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              initialValue: _type,
              decoration: const InputDecoration(
                labelText: 'Evidence Type',
              ),
              items: const <DropdownMenuItem<String>>[
                DropdownMenuItem(
                  value: 'observation',
                  child: Text('Observation'),
                ),
                DropdownMenuItem(
                  value: 'hazard',
                  child: Text('Hazard / Unsafe Condition'),
                ),
                DropdownMenuItem(
                  value: 'corrective_action',
                  child: Text('Corrective Action'),
                ),
                DropdownMenuItem(
                  value: 'incident',
                  child: Text('Incident / Near Miss'),
                ),
                DropdownMenuItem(
                  value: 'reference',
                  child: Text('Reference Note'),
                ),
              ],
              onChanged: (value) {
                if (value == null) return;
                setState(() {
                  _type = value;
                });
              },
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _textController,
              minLines: 4,
              maxLines: 7,
              decoration: const InputDecoration(
                labelText: 'Details',
                alignLabelWithHint: true,
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: _save,
          child: const Text('Save'),
        ),
      ],
    );
  }
}
