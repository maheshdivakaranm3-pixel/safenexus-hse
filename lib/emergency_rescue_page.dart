import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:excel/excel.dart' hide Border;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';

import 'data/emergency_rescue/emergency_rescue_part1.dart';
import 'data/emergency_rescue/emergency_rescue_part2.dart';
import 'data/emergency_rescue/emergency_rescue_part3.dart';
import 'data/emergency_rescue/emergency_rescue_part4.dart';
import 'data/emergency_rescue/emergency_rescue_part5.dart';
import 'data/emergency_rescue/emergency_rescue_part6.dart';
import 'data/emergency_rescue/emergency_rescue_part7.dart';
import 'data/emergency_rescue/emergency_rescue_part8.dart';
import 'emergency_management.dart';
import 'emergency_topic_documents.dart';

class EmergencyRescuePage extends StatelessWidget {
  const EmergencyRescuePage({super.key});

  static const Color _green = Color(0xFF0B5D4B);
  static const Color _background = Color(0xFFF5F8F7);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _background,
      appBar: AppBar(
        backgroundColor: _green,
        foregroundColor: Colors.white,
        title: const Text('Emergency & Rescue'),
        actions: [
          IconButton(
            tooltip: 'Emergency Records',
            icon: const Icon(Icons.assignment_outlined),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => const EmergencyManagementPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 18, 16, 28),
        children: [
          _officeDocumentsCard(context),
          const SizedBox(height: 16),
          ...emergencyRescuePart1.map((topic) => _topicTile(context, topic)),
          ...emergencyRescuePart2.map((topic) => _topicTile(context, topic)),
          ...emergencyRescuePart3.map((topic) => _topicTile(context, topic)),
          ...emergencyRescuePart4.map((topic) => _topicTile(context, topic)),
          ...emergencyRescuePart5.map((topic) => _topicTile(context, topic)),
          ...emergencyRescuePart6.map((topic) => _topicTile(context, topic)),
          ...emergencyRescuePart7.map((topic) => _topicTile(context, topic)),
          ...emergencyRescuePart8.map((topic) => _topicTile(context, topic)),


          const SizedBox(height: 10),
          OutlinedButton.icon(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => const EmergencyManagementPage(),
                ),
              );
            },
            icon: const Icon(Icons.assignment_outlined),
            label: const Text('Open Emergency Records & Drills'),
          ),
          const SizedBox(height: 12),
          const Text(
            'Training reference only. Follow the current site Emergency Response Plan, approved rescue arrangements, applicable authority requirements and emergency-service instructions. Verify legal limits and mandatory intervals from current official sources.',
            style: TextStyle(fontSize: 12, color: Colors.black54, height: 1.45),
          ),
        ],
      ),
    );
  }

  Widget _officeDocumentsCard(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: Material(
          color: const Color(0xFFE5F3EC),
          borderRadius: BorderRadius.circular(18),
          child: InkWell(
            borderRadius: BorderRadius.circular(18),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => const EmergencyManagementPage(),
              ),
            ),
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.grey.shade200),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: const BoxDecoration(
                      color: _green,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.folder_open,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Office Documents & Templates',
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF17211D),
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Emergency plans, rescue forms, checklists and records',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF53635B),
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.chevron_right, color: _green, size: 28),
                ],
              ),
            ),
          ),
        ),
      );

  IconData _topicIcon(String title) {
    final t = title.toLowerCase();
    if (t.contains('fire') || t.contains('smoke')) return Icons.local_fire_department;
    if (t.contains('first aid') || t.contains('medical') || t.contains('injury')) return Icons.medical_services;
    if (t.contains('evacuat') || t.contains('assembly')) return Icons.directions_walk;
    if (t.contains('confined')) return Icons.sensor_door;
    if (t.contains('height') || t.contains('fall')) return Icons.personal_injury;
    if (t.contains('crane') || t.contains('lifting')) return Icons.precision_manufacturing;
    if (t.contains('electric') || t.contains('shock')) return Icons.electrical_services;
    if (t.contains('chemical') || t.contains('spill') || t.contains('gas')) return Icons.science;
    if (t.contains('water') || t.contains('drowning') || t.contains('marine')) return Icons.water;
    if (t.contains('vehicle') || t.contains('traffic') || t.contains('road')) return Icons.car_crash;
    if (t.contains('heat') || t.contains('weather')) return Icons.wb_sunny;
    if (t.contains('rescue')) return Icons.health_and_safety;
    if (t.contains('drill') || t.contains('exercise')) return Icons.groups;
    return Icons.emergency;
  }

  Widget _topicTile(BuildContext context, EmergencyRescueTopic topic) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Color(0xFFE1EAE6)),
      ),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        leading: CircleAvatar(
          radius: 27,
          backgroundColor: const Color(0xFFE1F2E9),
          foregroundColor: _green,
          child: Icon(_topicIcon(topic.title), size: 27),
        ),
        title: Text(
          topic.title,
          style: const TextStyle(
            color: Color(0xFF17324D),
            fontWeight: FontWeight.w700,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 7),
          child: Text(
            topic.purpose,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(height: 1.35),
          ),
        ),
        trailing: const Icon(Icons.chevron_right, color: _green),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (_) => EmergencyRescueTopicPage(topic: topic),
            ),
          );
        },
      ),
    );
  }
}

class EmergencyRescueTopicPage extends StatelessWidget {
  const EmergencyRescueTopicPage({super.key, required this.topic});

  final EmergencyRescueTopic topic;

  static const Color _green = Color(0xFF0B5D4B);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8F7),
      appBar: AppBar(
        backgroundColor: _green,
        foregroundColor: Colors.white,
        title: Text(topic.title, maxLines: 1, overflow: TextOverflow.ellipsis),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFE4F2EC),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.menu_book, color: _green, size: 24),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    '${topic.id} • Field Handbook Explanation',
                    style: const TextStyle(
                      color: _green,
                      fontWeight: FontWeight.w800,
                      height: 1.35,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _section('1. Purpose — Why this topic matters', <String>[topic.purpose]),
          _section('2. Scope & Applicability', <String>[topic.scope]),
          _section('3. Knowledge — Detailed Explanation', topic.keyKnowledge),
          _section('4. Site Implementation — Practical Actions', topic.siteImplementation),
          _section('5. Practical Site Example', topic.practicalExample),
          _section('6. Stop-Work / Escalation Conditions', topic.stopWorkConditions),
          const SizedBox(height: 8),
          OutlinedButton.icon(
            icon: const Icon(Icons.assignment_outlined),
            label: const Text('Open Topic-specific Documents Checklist'),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => EmergencyTopicDocumentsPage(
                  topicId: topic.id,
                  topicTitle: topic.title,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          FilledButton.icon(
            icon: const Icon(Icons.file_download_outlined),
            label: const Text('Save / Export This Document'),
            onPressed: () => _showExportOptions(context),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF4DB),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFEBD9A8)),
            ),
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.info_outline, color: Color(0xFF8A5A00)),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Field reminder: Protect life first. Raise the alarm early. Do not attempt an unplanned rescue or enter an uncontrolled hazard. Follow the approved site ERP and competent responder instructions.',
                    style: TextStyle(height: 1.4, color: Color(0xFF654A16)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<MapEntry<String, List<String>>> _documentSections() => [
        MapEntry('Purpose', [topic.purpose]),
        MapEntry('Scope & Applicability', [topic.scope]),
        MapEntry('Detailed Explanation', topic.keyKnowledge),
        MapEntry('Site Implementation', topic.siteImplementation),
        MapEntry('Practical Site Example', topic.practicalExample),
        MapEntry('Stop-Work / Escalation Conditions', topic.stopWorkConditions),
      ];

  Future<Directory> _exportDirectory() async =>
      await getTemporaryDirectory();

  Future<void> _shareExport(String extension, List<int> bytes, String mime) async {
    final dir = await _exportDirectory();
    final safeTitle = topic.title.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]+'), '_').replaceAll(RegExp(r'^_|_$'), '');
    final file = File('${dir.path}/${topic.id.toLowerCase()}_$safeTitle.$extension');
    await file.writeAsBytes(bytes, flush: true);
    await Share.shareXFiles([XFile(file.path, mimeType: mime)], text: '${topic.id} — ${topic.title}');
  }

  Future<void> _exportPdf() async {
    final doc = pw.Document();
    doc.addPage(pw.MultiPage(build: (_) => [
      pw.Text('SafeNexus HSE — Emergency & Rescue', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
      pw.SizedBox(height: 8),
      pw.Text('${topic.id}: ${topic.title}', style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold)),
      pw.SizedBox(height: 12),
      ..._documentSections().expand((section) => [
        pw.Text(section.key, style: pw.TextStyle(fontSize: 13, fontWeight: pw.FontWeight.bold)),
        ...section.value.map((item) => pw.Padding(padding: const pw.EdgeInsets.only(bottom: 6), child: pw.Text('• $item'))),
        pw.SizedBox(height: 8),
      ]),
      pw.Text('Field reminder: Protect life first. Raise the alarm early. Do not attempt an unplanned rescue or enter an uncontrolled hazard. Follow the approved site ERP and competent responder instructions.'),
    ]));
    await _shareExport('pdf', await doc.save(), 'application/pdf');
  }

  Future<void> _exportExcel() async {
    final book = Excel.createExcel();
    final sheet = book['Emergency Topic'];
    sheet.appendRow([TextCellValue('SafeNexus HSE — Emergency & Rescue')]);
    sheet.appendRow([TextCellValue('${topic.id}: ${topic.title}')]);
    sheet.appendRow([TextCellValue('Section'), TextCellValue('Content')]);
    for (final section in _documentSections()) {
      for (final item in section.value) {
        sheet.appendRow([TextCellValue(section.key), TextCellValue(item)]);
      }
    }
    final bytes = book.encode();
    if (bytes == null) throw StateError('Could not create Excel workbook');
    await _shareExport('xlsx', bytes, 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
  }

  String _rtfEscape(String value) {
    final out = StringBuffer();
    for (final rune in value.runes) {
      if (rune == 92 || rune == 123 || rune == 125) {
        out.write('\\${String.fromCharCode(rune)}');
      } else if (rune == 10) {
        out.write(r'\par ');
      } else if (rune <= 127) {
        out.writeCharCode(rune);
      } else {
        final units = String.fromCharCodes([rune]).codeUnits;
        for (final unit in units) {
          final signed = unit > 32767 ? unit - 65536 : unit;
          out.write('\\u${signed}?');
        }
      }
    }
    return out.toString();
  }

  Future<void> _exportWord() async {
    final content = StringBuffer(r'{\rtf1\ansi\deff0{\fonttbl{\f0 Arial;}}\f0\fs24 ');
    content.write(_rtfEscape('SafeNexus HSE — Emergency & Rescue\n${topic.id}: ${topic.title}\n\n'));
    for (final section in _documentSections()) {
      content.write(r'\b ');
      content.write(_rtfEscape('${section.key}\n'));
      content.write(r'\b0 ');
      for (final item in section.value) {
        content.write(_rtfEscape('• $item\n'));
      }
      content.write(r'\par ');
    }
    content.write(r'}');
    await _shareExport('rtf', utf8.encode(content.toString()), 'application/rtf');
  }

  Future<void> _showExportOptions(BuildContext context) async {
    await showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (sheetContext) => SafeArea(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const ListTile(title: Text('Save / Share Document', style: TextStyle(fontWeight: FontWeight.w800))),
          ListTile(leading: const Icon(Icons.picture_as_pdf), title: const Text('PDF'), subtitle: const Text('Portable document'), onTap: () { Navigator.pop(sheetContext); _exportPdf(); }),
          ListTile(leading: const Icon(Icons.description_outlined), title: const Text('Word document (RTF)'), subtitle: const Text('Opens in Microsoft Word; save as DOCX if needed'), onTap: () { Navigator.pop(sheetContext); _exportWord(); }),
          ListTile(leading: const Icon(Icons.table_chart_outlined), title: const Text('Excel (XLSX)'), subtitle: const Text('Sections and content in rows'), onTap: () { Navigator.pop(sheetContext); _exportExcel(); }),
          const SizedBox(height: 10),
        ]),
      ),
    );
  }

  Widget _section(String title, List<String> items) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: const BorderSide(color: Color(0xFFE1EAE6)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: _green,
                fontWeight: FontWeight.w800,
                fontSize: 16,
                height: 1.3,
              ),
            ),
            const SizedBox(height: 12),
            ...items.asMap().entries.map(
              (entry) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 7),
                      child: Icon(
                        entry.key == 0 && title.startsWith('5.')
                            ? Icons.lightbulb_outline
                            : Icons.circle,
                        size: entry.key == 0 && title.startsWith('5.') ? 17 : 6,
                        color: _green,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        entry.value,
                        style: const TextStyle(
                          height: 1.5,
                          fontSize: 14,
                          color: Color(0xFF263238),
                        ),
                      ),
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
}
