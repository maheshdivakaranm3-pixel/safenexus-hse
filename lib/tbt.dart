import 'dart:io';

import 'package:docx_dart/docx_dart.dart' as docx;
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';

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
        actions: [
          IconButton(
            tooltip: 'Copy / Export TBT',
            icon: const Icon(Icons.ios_share_rounded),
            onPressed: () => _showExportMenu(context),
          ),
        ],
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

class TbtDetailPage extends StatefulWidget {
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

          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => _showMeetingBrief(context),
              icon: const Icon(Icons.groups_rounded),
              label: const Text('Start Toolbox Meeting'),
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
        ],
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
                  '1. Introduce today’s work scope and topic.
'
                  '2. Explain the key hazards and controls.
'
                  '3. Confirm PPE and emergency arrangements.
'
                  '4. Ask the workers the discussion questions.
'
                  '5. Record attendance, concerns and actions.
'
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
  String _safeFileName(String value) {
    final cleaned = value.replaceAll(RegExp(r'[^A-Za-z0-9]+'), '_');
    return cleaned.replaceAll(RegExp(r'_+'), '_').replaceAll(RegExp(r'^_|_$'), '');
  }

  String _plainText() {
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
    _writeList(b, 'KEY HAZARDS', topic.keyHazards);
    _writeList(b, 'REQUIRED CONTROLS', topic.requiredControls);
    _writeList(b, 'PPE', topic.ppe);
    _writeList(b, 'BEFORE STARTING', topic.beforeStarting);
    _writeList(b, 'SAFE WORK PRACTICES', topic.safeWorkPractices);
    _writeList(b, 'EMERGENCY RESPONSE', topic.emergencyResponse);
    _writeList(b, 'SUPERVISOR DISCUSSION POINTS', topic.supervisorPoints);
    _writeList(b, 'WORKER DISCUSSION QUESTIONS', topic.discussionQuestions);
    _writeList(b, 'CODE / REFERENCE', topic.codeOfPractice);
    b.writeln('WORKER CONFIRMATION');
    b.writeln(topic.workerConfirmation);
    return b.toString();
  }

  void _writeList(StringBuffer b, String title, List<String> items) {
    b.writeln(title);
    for (final item in items) b.writeln('• $item');
    b.writeln();
  }

  Future<Directory> _exportDirectory() async => getTemporaryDirectory();

  Future<void> _copyTopic() async {
    // Share sheet gives Android the standard Copy/Share actions for the full topic.
    await Share.share(_plainText(), subject: 'TBT ${topic.id} - ${topic.title}');
  }

  Future<void> _exportPdf() async {
    final document = pw.Document();
    document.addPage(
      pw.MultiPage(
        build: (_) => [
          pw.Text('SafeNexus HSE - Toolbox Talk', style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 8),
          pw.Text('TBT ${topic.id}: ${topic.title}', style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold)),
          pw.Text('Category: ${topic.category}'),
          pw.SizedBox(height: 12),
          _pdfSection('Objective', [topic.objective]),
          _pdfSection('Toolbox Meeting Focus', [topic.meetingFocus]),
          _pdfSection('Key Hazards', topic.keyHazards),
          _pdfSection('Required Controls', topic.requiredControls),
          _pdfSection('PPE', topic.ppe),
          _pdfSection('Before Starting', topic.beforeStarting),
          _pdfSection('Safe Work Practices', topic.safeWorkPractices),
          _pdfSection('Emergency Response', topic.emergencyResponse),
          _pdfSection('Supervisor Discussion Points', topic.supervisorPoints),
          _pdfSection('Worker Discussion Questions', topic.discussionQuestions),
          _pdfSection('Code / Reference', topic.codeOfPractice),
          _pdfSection('Worker Confirmation', [topic.workerConfirmation]),
        ],
      ),
    );
    final dir = await _exportDirectory();
    final file = File('${dir.path}/TBT_${topic.id}_${_safeFileName(topic.title)}.pdf');
    await file.writeAsBytes(await document.save(), flush: true);
    await Share.shareXFiles([XFile(file.path)], subject: 'TBT ${topic.id} - PDF');
  }

  pw.Widget _pdfSection(String title, List<String> items) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 10),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(title, style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 11)),
          pw.SizedBox(height: 3),
          ...items.map((x) => pw.Padding(padding: const pw.EdgeInsets.only(bottom: 2), child: pw.Text('• $x', style: const pw.TextStyle(fontSize: 9.5)))),
        ],
      ),
    );
  }

  Future<void> _exportExcel() async {
    final excel = Excel.createExcel();
    final sheet = excel['TBT'];
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
      ['Before Starting', topic.beforeStarting.join('\n')],
      ['Safe Work Practices', topic.safeWorkPractices.join('\n')],
      ['Emergency Response', topic.emergencyResponse.join('\n')],
      ['Supervisor Discussion Points', topic.supervisorPoints.join('\n')],
      ['Worker Discussion Questions', topic.discussionQuestions.join('\n')],
      ['Code / Reference', topic.codeOfPractice.join('\n')],
      ['Worker Confirmation', topic.workerConfirmation],
    ];
    for (final row in rows) {
      sheet.appendRow(row.map((v) => TextCellValue(v)).toList());
    }
    final bytes = excel.encode();
    if (bytes == null) return;
    final dir = await _exportDirectory();
    final file = File('${dir.path}/TBT_${topic.id}_${_safeFileName(topic.title)}.xlsx');
    await file.writeAsBytes(bytes, flush: true);
    await Share.shareXFiles([XFile(file.path)], subject: 'TBT ${topic.id} - Excel');
  }

  Future<void> _exportWord() async {
    final document = docx.loadDocxDocument();
    document.addHeading(text: 'SafeNexus HSE - Toolbox Talk', level: 1);
    document.addParagraph(text: 'TBT ${topic.id}: ${topic.title}');
    document.addParagraph(text: 'Category: ${topic.category}');
    _wordSection(document, 'Objective', [topic.objective]);
    _wordSection(document, 'Toolbox Meeting Focus', [topic.meetingFocus]);
    _wordSection(document, 'Key Hazards', topic.keyHazards);
    _wordSection(document, 'Required Controls', topic.requiredControls);
    _wordSection(document, 'PPE', topic.ppe);
    _wordSection(document, 'Before Starting', topic.beforeStarting);
    _wordSection(document, 'Safe Work Practices', topic.safeWorkPractices);
    _wordSection(document, 'Emergency Response', topic.emergencyResponse);
    _wordSection(document, 'Supervisor Discussion Points', topic.supervisorPoints);
    _wordSection(document, 'Worker Discussion Questions', topic.discussionQuestions);
    _wordSection(document, 'Code / Reference', topic.codeOfPractice);
    _wordSection(document, 'Worker Confirmation', [topic.workerConfirmation]);
    final dir = await _exportDirectory();
    final path = '${dir.path}/TBT_${topic.id}_${_safeFileName(topic.title)}.docx';
    document.save(path);
    await Share.shareXFiles([XFile(path)], subject: 'TBT ${topic.id} - Word');
  }

  void _wordSection(dynamic document, String title, List<String> items) {
    document.addHeading(text: title, level: 2);
    for (final item in items) document.addParagraph(text: item);
  }

  void _showExportMenu(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (_) => SafeArea(
        child: Wrap(
          children: [
            ListTile(leading: const Icon(Icons.copy_rounded), title: const Text('Copy / Share Topic'), onTap: () { Navigator.pop(context); _copyTopic(); }),
            ListTile(leading: const Icon(Icons.picture_as_pdf_rounded), title: const Text('Save / Share as PDF'), onTap: () { Navigator.pop(context); _exportPdf(); }),
            ListTile(leading: const Icon(Icons.description_rounded), title: const Text('Save / Share as Word (.docx)'), onTap: () { Navigator.pop(context); _exportWord(); }),
            ListTile(leading: const Icon(Icons.table_chart_rounded), title: const Text('Save / Share as Excel (.xlsx)'), onTap: () { Navigator.pop(context); _exportExcel(); }),
          ],
        ),
      ),
    );
  }

}
