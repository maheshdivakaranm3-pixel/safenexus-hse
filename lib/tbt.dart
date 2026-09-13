import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:excel/excel.dart' as xls;

import 'data/tbt_data.dart';

class TbtHomePage extends StatefulWidget {
  const TbtHomePage({super.key});

  @override
  State<TbtHomePage> createState() => _TbtHomePageState();
}

class _TbtHomePageState extends State<TbtHomePage> {
  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF075B45);
  static const Color navy = Color(0xFF082653);

  String _query = '';
  String _category = 'All';

  List<String> get _categories {
    final values =
        tbtTopics.map((e) => e.category).toSet().toList()..sort();

    return [
      'All',
      ...values,
    ];
  }

  List<TbtTopic> get _filteredTopics {
    final q = _query.trim().toLowerCase();

    return tbtTopics.where((topic) {
      final categoryMatch =
          _category == 'All' || topic.category == _category;

      final textMatch =
          q.isEmpty ||
          topic.title.toLowerCase().contains(q) ||
          topic.category.toLowerCase().contains(q);

      return categoryMatch && textMatch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F8FB),

      appBar: AppBar(
        title: const Text(
          'TBT - Toolbox Talk',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: navy,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: navy,
        elevation: 0,
      ),

      body: Column(
        children: [
          _buildHeader(),
          _buildSearch(),
          _buildCategoryFilter(),
          Expanded(
            child: _buildList(),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // HEADER
  // ============================================================

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(
        16,
        14,
        16,
        10,
      ),
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            darkGreen,
            primaryGreen,
          ],
        ),
        borderRadius: BorderRadius.circular(22),
      ),

      child: Row(
        children: [
          Container(
            width: 54,
            height: 54,

            decoration: BoxDecoration(
              color: Colors.white.withAlpha(35),
              borderRadius: BorderRadius.circular(16),
            ),

            child: const Icon(
              Icons.handyman_rounded,
              color: Colors.white,
              size: 29,
            ),
          ),

          const SizedBox(width: 13),

          const Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [
                Text(
                  '100 TBT Topics',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                  ),
                ),

                SizedBox(height: 4),

                Text(
                  'Ready-to-use safety briefing content for UAE worksites.',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // SEARCH
  // ============================================================

  Widget _buildSearch() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),

      child: TextField(
        onChanged: (value) {
          setState(() {
            _query = value;
          });
        },

        decoration: InputDecoration(
          hintText: 'Search TBT topic...',

          prefixIcon: const Icon(
            Icons.search_rounded,
          ),

          filled: true,

          fillColor: Colors.white,

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  // ============================================================
  // CATEGORY FILTER
  // ============================================================

  Widget _buildCategoryFilter() {
    return SizedBox(
      height: 56,

      child: ListView.separated(
        padding: const EdgeInsets.fromLTRB(
          16,
          10,
          16,
          8,
        ),

        scrollDirection: Axis.horizontal,

        itemCount: _categories.length,

        separatorBuilder: (_, __) {
          return const SizedBox(width: 8);
        },

        itemBuilder: (context, index) {
          final category =
              _categories[index];

          final selected =
              category == _category;

          return ChoiceChip(
            label: Text(category),

            selected: selected,

            onSelected: (_) {
              setState(() {
                _category = category;
              });
            },

            selectedColor:
                primaryGreen.withAlpha(35),

            labelStyle: TextStyle(
              color: selected
                  ? darkGreen
                  : navy,

              fontWeight:
                  FontWeight.w700,

              fontSize: 12,
            ),
          );
        },
      ),
    );
  }

  // ============================================================
  // TBT LIST
  // ============================================================

  Widget _buildList() {
    final topics =
        _filteredTopics;

    if (topics.isEmpty) {
      return const Center(
        child: Text(
          'No TBT topic found.',
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(
        16,
        4,
        16,
        24,
      ),

      itemCount: topics.length,

      separatorBuilder: (_, __) {
        return const SizedBox(height: 10);
      },

      itemBuilder: (context, index) {
        return _topicCard(
          topics[index],
        );
      },
    );
  }

  // ============================================================
  // TOPIC CARD
  // ============================================================

  Widget _topicCard(TbtTopic topic) {
    return Material(
      color: Colors.white,

      borderRadius:
          BorderRadius.circular(19),

      child: InkWell(
        borderRadius:
            BorderRadius.circular(19),

        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  TbtDetailPage(
                topic: topic,
              ),
            ),
          );
        },

        child: Padding(
          padding:
              const EdgeInsets.all(15),

          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,

                decoration:
                    BoxDecoration(
                  color: primaryGreen
                      .withAlpha(20),

                  borderRadius:
                      BorderRadius.circular(
                    15,
                  ),
                ),

                child: const Icon(
                  Icons
                      .health_and_safety_rounded,
                  color: primaryGreen,
                ),
              ),

              const SizedBox(width: 13),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [
                    Text(
                      'TBT ${topic.id}',
                      style:
                          const TextStyle(
                        fontSize: 10,
                        color:
                            primaryGreen,
                        fontWeight:
                            FontWeight.w800,
                      ),
                    ),

                    const SizedBox(height: 2),

                    Text(
                      topic.title,
                      style:
                          const TextStyle(
                        fontSize: 15,
                        color: navy,
                        fontWeight:
                            FontWeight.w800,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      topic.category,
                      style:
                          const TextStyle(
                        fontSize: 11,
                        color:
                            Color(
                          0xFF607D8B,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const Icon(
                Icons.chevron_right_rounded,
                color: primaryGreen,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ================================================================
// TBT DETAIL PAGE
// ================================================================

class TbtDetailPage extends StatelessWidget {
  final TbtTopic topic;

  const TbtDetailPage({
    super.key,
    required this.topic,
  });

  static const Color primaryGreen =
      Color(0xFF159447);

  static const Color darkGreen =
      Color(0xFF075B45);

  static const Color navy =
      Color(0xFF082653);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFF4F8FB),

      appBar: AppBar(
        title: Text(
          'TBT ${topic.id}',
          style: const TextStyle(
            fontWeight:
                FontWeight.w800,
            color: navy,
          ),
        ),

        backgroundColor:
            Colors.white,

        foregroundColor:
            navy,

        elevation: 0,
      ),

      body: ListView(
        padding:
            const EdgeInsets.fromLTRB(
          16,
          16,
          16,
          30,
        ),

        children: [
          _titleCard(),

          _section(
            'Objective',
            Icons.flag_rounded,
            [
              topic.objective,
            ],
          ),

          _section(
            'Key Hazards',
            Icons.warning_amber_rounded,
            topic.keyHazards,
          ),

          _section(
            'Required Controls',
            Icons.verified_user_rounded,
            topic.requiredControls,
          ),

          _section(
            'PPE',
            Icons.engineering_rounded,
            topic.ppe,
          ),

          _section(
            'Before Starting Work',
            Icons.play_circle_outline_rounded,
            topic.beforeStarting,
          ),

          _section(
            'Safe Work Practices',
            Icons.check_circle_outline_rounded,
            topic.safeWorkPractices,
          ),

          _section(
            'Emergency Response',
            Icons.emergency_rounded,
            topic.emergencyResponse,
          ),

          _section(
            'Toolbox Meeting Focus',
            Icons.record_voice_over_rounded,
            [topic.meetingFocus],
          ),

          _section(
            'Supervisor Discussion Points',
            Icons.groups_rounded,
            topic.supervisorPoints,
          ),

          _section(
            'Worker Discussion Questions',
            Icons.question_answer_rounded,
            topic.discussionQuestions,
          ),

          _codeOfPractice(),

          _meetingChecklist(),

          _confirmation(),

          const SizedBox(height: 14),

          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => _showMeetingForm(context),
                  icon: const Icon(Icons.groups_rounded),
                  label: const Text('Start Meeting'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryGreen,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _showExportMenu(context),
                  icon: const Icon(Icons.ios_share_rounded),
                  label: const Text('Export'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: primaryGreen,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    side: const BorderSide(color: primaryGreen),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }


  String _safeFileName(String value) {
    final cleaned = value
        .replaceAll(RegExp(r'[^A-Za-z0-9]+'), '_')
        .replaceAll(RegExp(r'_+'), '_')
        .replaceAll(RegExp(r'^_|_$'), '');
    return cleaned.isEmpty ? 'TBT_${topic.id}' : cleaned;
  }

  String _topicText() {
    final b = StringBuffer();
    b.writeln('SafeNexus HSE - Toolbox Talk');
    b.writeln('TBT ${topic.id}: ${topic.title}');
    b.writeln('Category: ${topic.category}');
    b.writeln();
    b.writeln('OBJECTIVE');
    b.writeln(topic.objective);
    b.writeln();
    b.writeln('TOOLBOX MEETING FOCUS');
    b.writeln(topic.meetingFocus);
    b.writeln();
    b.writeln('KEY HAZARDS');
    for (final item in topic.keyHazards) b.writeln('• $item');
    b.writeln();
    b.writeln('REQUIRED CONTROLS');
    for (final item in topic.requiredControls) b.writeln('• $item');
    b.writeln();
    b.writeln('PPE');
    for (final item in topic.ppe) b.writeln('• $item');
    b.writeln();
    b.writeln('BEFORE STARTING WORK');
    for (final item in topic.beforeStarting) b.writeln('• $item');
    b.writeln();
    b.writeln('SAFE WORK PRACTICES');
    for (final item in topic.safeWorkPractices) b.writeln('• $item');
    b.writeln();
    b.writeln('EMERGENCY RESPONSE');
    for (final item in topic.emergencyResponse) b.writeln('• $item');
    b.writeln();
    b.writeln('SUPERVISOR DISCUSSION POINTS');
    for (final item in topic.supervisorPoints) b.writeln('• $item');
    b.writeln();
    b.writeln('WORKER DISCUSSION QUESTIONS');
    for (final item in topic.discussionQuestions) b.writeln('• $item');
    b.writeln();
    b.writeln('CODE / REFERENCE');
    for (final item in topic.codeOfPractice) b.writeln('• $item');
    b.writeln();
    b.writeln('WORKER CONFIRMATION');
    b.writeln(topic.workerConfirmation);
    return b.toString();
  }

  Future<void> _copyTopic(BuildContext context) async {
    await Clipboard.setData(ClipboardData(text: _topicText()));
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('TBT topic copied successfully.')),
    );
  }

  Future<void> _exportPdf() async {
    final doc = pw.Document();
    pw.Widget title(String text) => pw.Padding(
          padding: const pw.EdgeInsets.only(top: 10, bottom: 5),
          child: pw.Text(text,
              style: pw.TextStyle(
                  fontSize: 12, fontWeight: pw.FontWeight.bold)),
        );
    pw.Widget bullets(List<String> items) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: items.map((item) => pw.Padding(
            padding: const pw.EdgeInsets.only(bottom: 3),
            child: pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [pw.Text('• '), pw.Expanded(child: pw.Text(item))],
            ),
          )).toList(),
        );
    doc.addPage(pw.MultiPage(build: (_) => [
      pw.Text('SafeNexus HSE - Toolbox Talk',
          style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
      pw.SizedBox(height: 5),
      pw.Text('TBT ${topic.id}: ${topic.title}'),
      pw.Text('Category: ${topic.category}'),
      title('OBJECTIVE'), pw.Text(topic.objective),
      title('TOOLBOX MEETING FOCUS'), pw.Text(topic.meetingFocus),
      title('KEY HAZARDS'), bullets(topic.keyHazards),
      title('REQUIRED CONTROLS'), bullets(topic.requiredControls),
      title('PPE'), bullets(topic.ppe),
      title('BEFORE STARTING WORK'), bullets(topic.beforeStarting),
      title('SAFE WORK PRACTICES'), bullets(topic.safeWorkPractices),
      title('EMERGENCY RESPONSE'), bullets(topic.emergencyResponse),
      title('SUPERVISOR DISCUSSION POINTS'), bullets(topic.supervisorPoints),
      title('WORKER DISCUSSION QUESTIONS'), bullets(topic.discussionQuestions),
      title('CODE / REFERENCE'), bullets(topic.codeOfPractice),
      title('WORKER CONFIRMATION'), pw.Text(topic.workerConfirmation),
    ]));
    await Printing.sharePdf(
      bytes: await doc.save(),
      filename: 'TBT_${topic.id}_${_safeFileName(topic.title)}.pdf',
    );
  }

  Future<void> _exportWord() async {
    final html = '''<!DOCTYPE html>
<html><head><meta charset="utf-8">
<title>TBT ${topic.id} - ${topic.title}</title></head>
<body>
<h1>SafeNexus HSE - Toolbox Talk</h1>
<h2>TBT ${topic.id}: ${topic.title}</h2>
<pre style="font-family:Arial;white-space:pre-wrap;">${_escapeHtml(_topicText())}</pre>
</body></html>''';
    final directory = await getTemporaryDirectory();
    final file = File(
      '${directory.path}/TBT_${topic.id}_${_safeFileName(topic.title)}.doc',
    );
    await file.writeAsString(html, flush: true);
    await Share.shareXFiles(
      [XFile(file.path, mimeType: 'application/msword')],
      subject: 'TBT ${topic.id} - ${topic.title}',
    );
  }

  String _escapeHtml(String value) => value
      .replaceAll('&', '&amp;')
      .replaceAll('<', '&lt;')
      .replaceAll('>', '&gt;');

  Future<void> _exportExcel() async {
    final workbook = xls.Excel.createExcel();
    final sheet = workbook['TBT'];
    final rows = <List<String>>[
      ['Field', 'Content'],
      ['TBT Number', '${topic.id}'],
      ['Topic', topic.title],
      ['Category', topic.category],
      ['Objective', topic.objective],
      ['Toolbox Meeting Focus', topic.meetingFocus],
      ['Key Hazards', topic.keyHazards.join('\n')],
      ['Required Controls', topic.requiredControls.join('\n')],
      ['PPE', topic.ppe.join('\n')],
      ['Before Starting Work', topic.beforeStarting.join('\n')],
      ['Safe Work Practices', topic.safeWorkPractices.join('\n')],
      ['Emergency Response', topic.emergencyResponse.join('\n')],
      ['Supervisor Discussion Points', topic.supervisorPoints.join('\n')],
      ['Worker Discussion Questions', topic.discussionQuestions.join('\n')],
      ['Code / Reference', topic.codeOfPractice.join('\n')],
      ['Worker Confirmation', topic.workerConfirmation],
    ];
    for (final row in rows) {
      sheet.appendRow(row.map((v) => xls.TextCellValue(v)).toList());
    }
    final bytes = workbook.encode();
    if (bytes == null) return;
    final directory = await getTemporaryDirectory();
    final file = File(
      '${directory.path}/TBT_${topic.id}_${_safeFileName(topic.title)}.xlsx',
    );
    await file.writeAsBytes(bytes, flush: true);
    await Share.shareXFiles(
      [XFile(file.path,
          mimeType:
              'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet')],
      subject: 'TBT ${topic.id} - ${topic.title}',
    );
  }

  void _showExportMenu(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (sheetContext) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 18, 20, 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('Export / Share TBT',
                    style: TextStyle(
                        color: navy, fontSize: 18, fontWeight: FontWeight.w900)),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.copy_rounded, color: primaryGreen),
              title: const Text('Copy Topic'),
              onTap: () { Navigator.pop(sheetContext); _copyTopic(context); },
            ),
            ListTile(
              leading: const Icon(Icons.picture_as_pdf_rounded, color: primaryGreen),
              title: const Text('PDF'),
              subtitle: const Text('Generate and share PDF'),
              onTap: () { Navigator.pop(sheetContext); _exportPdf(); },
            ),
            ListTile(
              leading: const Icon(Icons.description_rounded, color: primaryGreen),
              title: const Text('Word'),
              subtitle: const Text('Microsoft Word compatible .doc'),
              onTap: () { Navigator.pop(sheetContext); _exportWord(); },
            ),
            ListTile(
              leading: const Icon(Icons.table_chart_rounded, color: primaryGreen),
              title: const Text('Excel'),
              subtitle: const Text('Generate and share .xlsx'),
              onTap: () { Navigator.pop(sheetContext); _exportExcel(); },
            ),
            ListTile(
              leading: const Icon(Icons.share_rounded, color: primaryGreen),
              title: const Text('Share Topic Text'),
              onTap: () {
                Navigator.pop(sheetContext);
                Share.share(_topicText(),
                    subject: 'TBT ${topic.id} - ${topic.title}');
              },
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  void _showMeetingForm(BuildContext context) {
    final supervisor = TextEditingController();
    final location = TextEditingController();
    final attendees = TextEditingController();
    final concerns = TextEditingController();
    final actions = TextEditingController();
    bool acknowledged = false;

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (sheetContext) => StatefulBuilder(
        builder: (context, setState) => SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              18, 18, 18, MediaQuery.of(context).viewInsets.bottom + 18),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Toolbox Meeting • TBT ${topic.id}',
                      style: const TextStyle(
                          color: navy, fontSize: 19, fontWeight: FontWeight.w900)),
                  const SizedBox(height: 4),
                  Text(topic.title,
                      style: const TextStyle(
                          color: darkGreen, fontSize: 15, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 14),
                  TextField(controller: supervisor,
                      decoration: const InputDecoration(
                          labelText: 'Supervisor / Presenter',
                          border: OutlineInputBorder())),
                  const SizedBox(height: 10),
                  TextField(controller: location,
                      decoration: const InputDecoration(
                          labelText: 'Work Location',
                          border: OutlineInputBorder())),
                  const SizedBox(height: 10),
                  TextField(controller: attendees, maxLines: 3,
                      decoration: const InputDecoration(
                          labelText: 'Workers / Attendees',
                          hintText: 'Enter names or team details',
                          border: OutlineInputBorder())),
                  const SizedBox(height: 10),
                  TextField(controller: concerns, maxLines: 3,
                      decoration: const InputDecoration(
                          labelText: 'Questions / Concerns',
                          border: OutlineInputBorder())),
                  const SizedBox(height: 10),
                  TextField(controller: actions, maxLines: 3,
                      decoration: const InputDecoration(
                          labelText: 'Corrective Actions / Follow-up',
                          border: OutlineInputBorder())),
                  const SizedBox(height: 8),
                  CheckboxListTile(
                    value: acknowledged,
                    contentPadding: EdgeInsets.zero,
                    activeColor: primaryGreen,
                    title: const Text('Workers understand the topic and controls.'),
                    onChanged: (value) => setState(() {
                      acknowledged = value ?? false;
                    }),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: acknowledged
                          ? () {
                              Navigator.pop(sheetContext);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Toolbox Meeting record completed successfully.',
                                  ),
                                ),
                              );
                            }
                          : null,
                      icon: const Icon(Icons.check_circle_rounded),
                      label: const Text('Complete Meeting'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryGreen,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showMeetingBrief(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => SafeArea(
        child: Container(
          padding: const EdgeInsets.fromLTRB(18, 18, 18, 24),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    const Icon(Icons.groups_rounded, color: primaryGreen),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Toolbox Meeting • TBT ${topic.id}',
                        style: const TextStyle(
                          color: navy,
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  topic.title,
                  style: const TextStyle(
                    color: darkGreen,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Meeting flow',
                  style: TextStyle(fontWeight: FontWeight.w800, color: navy),
                ),
                const SizedBox(height: 6),
                const Text(
                  '1. Introduce today’s work scope and topic.\n'
                  '2. Explain the key hazards and controls.\n'
                  '3. Confirm PPE and emergency arrangements.\n'
                  '4. Ask the workers the discussion questions.\n'
                  '5. Record attendance, concerns and actions.\n'
                  '6. Confirm everyone understands before work starts.',
                  style: TextStyle(height: 1.45, color: Color(0xFF455A64)),
                ),
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEAF8F0),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Text(
                    'Meeting focus: ${topic.meetingFocus}',
                    style: const TextStyle(
                      color: darkGreen,
                      fontWeight: FontWeight.w700,
                      height: 1.4,
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryGreen,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Close'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // TITLE CARD
  // ============================================================

  Widget _titleCard() {
    return Container(
      padding:
          const EdgeInsets.all(19),

      decoration: BoxDecoration(
        gradient:
            const LinearGradient(
          colors: [
            darkGreen,
            primaryGreen,
          ],
        ),

        borderRadius:
            BorderRadius.circular(22),
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          Text(
            'TBT ${topic.id}',
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12,
              fontWeight:
                  FontWeight.w700,
            ),
          ),

          const SizedBox(height: 5),

          Text(
            topic.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight:
                  FontWeight.w900,
            ),
          ),

          const SizedBox(height: 7),

          Text(
            topic.category,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // COMMON SECTION
  // ============================================================

  Widget _section(
    String title,
    IconData icon,
    List<String> items,
  ) {
    return Container(
      margin:
          const EdgeInsets.only(
        top: 12,
      ),

      padding:
          const EdgeInsets.fromLTRB(
        16,
        15,
        16,
        13,
      ),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
            BorderRadius.circular(19),
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          Row(
            children: [
              Icon(
                icon,
                color:
                    primaryGreen,
                size: 21,
              ),

              const SizedBox(width: 8),

              Expanded(
                child: Text(
                  title,
                  style:
                      const TextStyle(
                    color: navy,
                    fontSize: 15,
                    fontWeight:
                        FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          ...items.map(
            (item) => Padding(
              padding:
                  const EdgeInsets.only(
                bottom: 8,
              ),

              child: Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [
                  const Padding(
                    padding:
                        EdgeInsets.only(
                      top: 6,
                    ),

                    child: Icon(
                      Icons.circle,
                      size: 5,
                      color:
                          primaryGreen,
                    ),
                  ),

                  const SizedBox(width: 9),

                  Expanded(
                    child: Text(
                      item,
                      style:
                          const TextStyle(
                        color:
                            Color(
                          0xFF455A64,
                        ),
                        fontSize: 12.5,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // CODE OF PRACTICE / REFERENCE
  // ============================================================

  Widget _codeOfPractice() {
    return Container(
      margin:
          const EdgeInsets.only(
        top: 12,
      ),

      padding:
          const EdgeInsets.fromLTRB(
        16,
        15,
        16,
        13,
      ),

      decoration: BoxDecoration(
        color:
            const Color(0xFFF7FAFF),

        borderRadius:
            BorderRadius.circular(19),

        border: Border.all(
          color:
              const Color(0xFFD8E4F0),
        ),
      ),

      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          const Row(
            children: [
              Icon(
                Icons.menu_book_rounded,
                color: primaryGreen,
                size: 21,
              ),

              SizedBox(width: 8),

              Expanded(
                child: Text(
                  'Code of Practice / Reference',
                  style:
                      TextStyle(
                    color: navy,
                    fontSize: 15,
                    fontWeight:
                        FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          ...topic.codeOfPractice.map(
            (item) => Padding(
              padding:
                  const EdgeInsets.only(
                bottom: 8,
              ),

              child: Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [
                  const Padding(
                    padding:
                        EdgeInsets.only(
                      top: 6,
                    ),

                    child: Icon(
                      Icons.circle,
                      size: 5,
                      color:
                          primaryGreen,
                    ),
                  ),

                  const SizedBox(width: 9),

                  Expanded(
                    child: Text(
                      item,
                      style:
                          const TextStyle(
                        color:
                            Color(
                          0xFF455A64,
                        ),
                        fontSize: 12.5,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 4),

          const Text(
            'Reference note: Always verify the current applicable authority requirements, project specifications and approved HSE documents before work starts.',
            style: TextStyle(
              color:
                  Color(0xFF607D8B),
              fontSize: 11,
              height: 1.4,
              fontStyle:
                  FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // TOOLBOX MEETING CHECKLIST
  // ============================================================

  Widget _meetingChecklist() {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: const Color(0xFFDDE7E3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.fact_check_rounded, color: primaryGreen, size: 21),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Toolbox Meeting Checklist',
                  style: TextStyle(
                    color: navy,
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ...[
            'Confirm work scope and location.',
            'Explain the topic, hazards and required controls.',
            'Confirm required PPE and equipment checks.',
            'Ask workers questions and record concerns.',
            'Confirm emergency arrangements and Stop Work Authority.',
            'Record attendance and worker acknowledgement.',
            'Assign corrective actions with owner and due date where required.',
          ].map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.check_box_outline_blank_rounded,
                      size: 18, color: primaryGreen),
                  const SizedBox(width: 9),
                  Expanded(
                    child: Text(
                      item,
                      style: const TextStyle(
                        color: Color(0xFF455A64),
                        fontSize: 12.5,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // WORKER CONFIRMATION
  // ============================================================

  Widget _confirmation() {
    return Container(
      margin:
          const EdgeInsets.only(
        top: 12,
      ),

      padding:
          const EdgeInsets.all(17),

      decoration: BoxDecoration(
        color:
            const Color(0xFFEAF8F0),

        borderRadius:
            BorderRadius.circular(19),

        border: Border.all(
          color:
              primaryGreen.withAlpha(40),
        ),
      ),

      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        children: [
          const Icon(
            Icons.check_circle_rounded,
            color: primaryGreen,
            size: 25,
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Text(
              topic.workerConfirmation,
              style:
                  const TextStyle(
                color: darkGreen,
                fontSize: 13,
                fontWeight:
                    FontWeight.w700,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
