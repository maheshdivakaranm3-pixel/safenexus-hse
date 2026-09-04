import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';

class CertificatePage extends StatefulWidget {
  const CertificatePage({super.key});

  @override
  State<CertificatePage> createState() => _CertificatePageState();
}

class _CertificatePageState extends State<CertificatePage> {
  final _nameController = TextEditingController(text: 'Employee Name');
  final _idController = TextEditingController();
  final _departmentController = TextEditingController();

  final _achievementController = TextEditingController(
    text:
        'For outstanding commitment to Health, Safety & Environment '
        'and for actively contributing to a safe and sustainable workplace.',
  );

  final _companyController =
      TextEditingController(text: 'SafeNexus HSE');

  final _signatoryController =
      TextEditingController(text: 'HSE Manager');

  final _footerController =
      TextEditingController(text: 'Identify. Report. Stay Safe.');

  DateTime selectedDate = DateTime.now();

  int selectedTemplate = 0;

  bool _isGeneratingPdf = false;

  String? _lastSavedPath;

  static const Color _green = Color(0xFF006B3C);
  static const Color _darkGreen = Color(0xFF004D2B);
  static const Color _gold = Color(0xFFC79A28);
  static const Color _ink = Color(0xFF17352A);

  final List<String> templateNames = const [
    'Classic Professional',
    'Modern Minimal',
    'Elegant Border',
    'Contemporary UAE',
    'Premium Dark',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _idController.dispose();
    _departmentController.dispose();
    _achievementController.dispose();
    _companyController.dispose();
    _signatoryController.dispose();
    _footerController.dispose();
    super.dispose();
  }

  String _clean(String value, {String fallback = ''}) {
    final cleaned = value
        .replaceAll(
          RegExp(r'[\u0000-\u001F\u007F\u200B-\u200D\uFEFF]'),
          '',
        )
        .replaceAll(RegExp(r'[ \t]+'), ' ')
        .trim();

    return cleaned.isEmpty ? fallback : cleaned;
  }

  String _cleanMultiline(String value) {
    return value
        .replaceAll(
          RegExp(r'[\u0000-\u001F\u007F\u200B-\u200D\uFEFF]'),
          '',
        )
        .replaceAll('\r\n', '\n')
        .replaceAll('\r', '\n')
        .split('\n')
        .map((line) => line.trim())
        .where((line) => line.isNotEmpty)
        .join('\n')
        .trim();
  }

  String get formattedDate {
    return '${selectedDate.day.toString().padLeft(2, '0')} '
        '${_month(selectedDate.month)} ${selectedDate.year}';
  }

  String _month(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    return months[month - 1];
  }

  void _markDirty() {
    if (_lastSavedPath != null) {
      setState(() {
        _lastSavedPath = null;
      });
    }
  }

  Future<void> _selectDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (date != null && mounted) {
      setState(() {
        selectedDate = date;
        _lastSavedPath = null;
      });
    }
  }

  void _resetCertificate() {
    setState(() {
      _nameController.text = 'Employee Name';
      _idController.clear();
      _departmentController.clear();

      _achievementController.text =
          'For outstanding commitment to Health, Safety & Environment '
          'and for actively contributing to a safe and sustainable workplace.';

      _companyController.text = 'SafeNexus HSE';
      _signatoryController.text = 'HSE Manager';
      _footerController.text = 'Identify. Report. Stay Safe.';

      selectedDate = DateTime.now();
      selectedTemplate = 0;
      _lastSavedPath = null;
    });
  }

  void _message(String message, {bool error = false}) {
    if (!mounted) return;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
          backgroundColor:
              error ? Colors.red.shade700 : null,
        ),
      );
  }

  String _safeFileName(String value) {
    final result = value
        .trim()
        .replaceAll(RegExp(r'[\\/:*?"<>|]'), '_')
        .replaceAll(RegExp(r'\s+'), '_');

    if (result.isEmpty) {
      return 'Employee';
    }

    return result.substring(
      0,
      result.length > 50 ? 50 : result.length,
    );
  }

  pw.TextStyle _pdfText({
    double size = 10,
    PdfColor color = PdfColors.black,
    pw.FontWeight? weight,
    double? letterSpacing,
  }) {
    return pw.TextStyle(
      fontSize: size,
      color: color,
      fontWeight: weight,
      letterSpacing: letterSpacing,
    );
  }

  pw.Widget _pdfLogo(PdfColor color) {
    return pw.Container(
      width: 58,
      height: 58,
      decoration: pw.BoxDecoration(
        color: color,
        shape: pw.BoxShape.circle,
        border: pw.Border.all(
          color: PdfColors.white,
          width: 2,
        ),
      ),
      child: pw.Center(
        child: pw.Text(
          'S',
          style: _pdfText(
            size: 27,
            color: PdfColors.white,
            weight: pw.FontWeight.bold,
          ),
        ),
      ),
    );
  }

  pw.Widget _pdfBrand(
    String company,
    PdfColor color, {
    bool light = false,
    bool compact = false,
  }) {
    final textColor =
        light ? PdfColors.white : color;

    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.center,
      children: [
        _pdfLogo(color),
        pw.SizedBox(width: 10),
        pw.Column(
          crossAxisAlignment:
              pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              company,
              style: _pdfText(
                size: compact ? 15 : 18,
                color: textColor,
                weight: pw.FontWeight.bold,
              ),
            ),
            pw.Text(
              'HSE Safety & Observation App',
              style: _pdfText(
                size: 6.5,
                color: light
                    ? PdfColors.white
                    : PdfColors.grey700,
              ),
            ),
          ],
        ),
      ],
    );
  }

  pw.Widget _pdfMeta(
    String value,
    String label,
    PdfColor color, {
    double width = 135,
    bool light = false,
  }) {
    return pw.SizedBox(
      width: width,
      child: pw.Column(
        children: [
          pw.Container(
            height: 1,
            color: light
                ? PdfColors.white
                : PdfColors.grey600,
          ),
          pw.SizedBox(height: 5),
          pw.Text(
            value,
            textAlign: pw.TextAlign.center,
            maxLines: 2,
            style: _pdfText(
              size: 8,
              color: light
                  ? PdfColors.white
                  : PdfColors.black,
            ),
          ),
          pw.SizedBox(height: 3),
          pw.Text(
            label.toUpperCase(),
            textAlign: pw.TextAlign.center,
            style: _pdfText(
              size: 6.5,
              color: light
                  ? PdfColors.white
                  : color,
              weight: pw.FontWeight.bold,
              letterSpacing: 0.7,
            ),
          ),
        ],
      ),
    );
  }

  pw.Widget _pdfSeal(
    PdfColor color, {
    bool gold = false,
  }) {
    final sealColor =
        gold ? PdfColors.amber800 : color;

    return pw.Container(
      width: 76,
      height: 76,
      decoration: pw.BoxDecoration(
        shape: pw.BoxShape.circle,
        color: sealColor,
        border: pw.Border.all(
          color: PdfColors.white,
          width: 3,
        ),
      ),
      child: pw.Center(
        child: pw.Column(
          mainAxisAlignment:
              pw.MainAxisAlignment.center,
          children: [
            pw.Text(
              'SAFETY',
              style: _pdfText(
                size: 7,
                color: PdfColors.white,
                weight: pw.FontWeight.bold,
              ),
            ),
            pw.Text(
              'IS OUR',
              style: _pdfText(
                size: 6,
                color: PdfColors.white,
              ),
            ),
            pw.Text(
              'PRIORITY',
              style: _pdfText(
                size: 8,
                color: PdfColors.white,
                weight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 3),
            pw.Text(
              'HSE',
              style: _pdfText(
                size: 6,
                color: PdfColors.white,
                weight: pw.FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  pw.Widget _pdfBadges(
    PdfColor color, {
    bool light = false,
  }) {
    const labels = [
      'SAFETY',
      'REPORT',
      'PROTECT',
      'BUILD',
    ];

    return pw.Row(
      mainAxisAlignment:
          pw.MainAxisAlignment.spaceEvenly,
      children: labels.map((label) {
        return pw.Column(
          children: [
            pw.Container(
              width: 34,
              height: 34,
              decoration: pw.BoxDecoration(
                shape: pw.BoxShape.circle,
                border: pw.Border.all(
                  color: light
                      ? PdfColors.white
                      : color,
                  width: 1.2,
                ),
              ),
              child: pw.Center(
                child: pw.Text(
                  '✓',
                  style: _pdfText(
                    size: 15,
                    color: light
                        ? PdfColors.white
                        : color,
                    weight: pw.FontWeight.bold,
                  ),
                ),
              ),
            ),
            pw.SizedBox(height: 3),
            pw.Text(
              label,
              style: _pdfText(
                size: 5.5,
                color: light
                    ? PdfColors.white
                    : color,
                weight: pw.FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
          ],
        );
      }).toList(),
    );
  }

  pw.Widget _pdfRecipient(
    String name,
    PdfColor color, {
    bool light = false,
    bool script = false,
  }) {
    return pw.Column(
      children: [
        pw.Text(
          'THIS CERTIFICATE IS PROUDLY PRESENTED TO',
          textAlign: pw.TextAlign.center,
          style: _pdfText(
            size: 7,
            color: light
                ? PdfColors.white
                : PdfColors.grey700,
            weight: pw.FontWeight.bold,
            letterSpacing: 1.1,
          ),
        ),
        pw.SizedBox(height: 7),
        pw.Text(
          name,
          textAlign: pw.TextAlign.center,
          maxLines: 2,
          style: _pdfText(
            size: script ? 28 : 25,
            color: light
                ? PdfColors.white
                : color,
            weight: pw.FontWeight.bold,
          ),
        ),
        pw.SizedBox(height: 6),
        pw.Container(
          width: 300,
          height: 1,
          color: light
              ? PdfColors.white
              : color,
        ),
      ],
    );
  }

  pw.Widget _pdfAchievement(
    String achievement, {
    bool light = false,
  }) {
    return pw.Container(
      width: double.infinity,
      padding: const pw.EdgeInsets.symmetric(
        horizontal: 25,
        vertical: 12,
      ),
      child: pw.Text(
        achievement,
        textAlign: pw.TextAlign.center,
        maxLines: 5,
        style: _pdfText(
          size: 9.5,
          color: light
              ? PdfColors.white
              : PdfColors.grey800,
        ),
      ),
    );
  }

  pw.Widget _pdfFooter(
    String footer,
    PdfColor color, {
    bool light = false,
  }) {
    return pw.Container(
      width: double.infinity,
      padding: const pw.EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 15,
      ),
      decoration: pw.BoxDecoration(
        color: light
            ? PdfColors.white
            : color,
      ),
      child: pw.Text(
        footer,
        textAlign: pw.TextAlign.center,
        maxLines: 2,
        style: _pdfText(
          size: 8,
          color: light
              ? color
              : PdfColors.white,
          weight: pw.FontWeight.bold,
          letterSpacing: 0.8,
        ),
      ),
    );
  }

  pw.Widget _template1({
    required String company,
    required String name,
    required String id,
    required String department,
    required String achievement,
    required String signatory,
    required String footer,
    required PdfColor green,
  }) {
    return pw.Container(
      color: PdfColors.white,
      padding: const pw.EdgeInsets.all(16),
      child: pw.Container(
        decoration: pw.BoxDecoration(
          border: pw.Border.all(
            color: green,
            width: 4,
          ),
        ),
        padding: const pw.EdgeInsets.all(6),
        child: pw.Container(
          decoration: pw.BoxDecoration(
            border: pw.Border.all(
              color: PdfColors.amber800,
              width: 1,
            ),
          ),
          child: pw.Padding(
            padding: const pw.EdgeInsets.symmetric(
              horizontal: 28,
              vertical: 22,
            ),
            child: pw.Column(
              children: [
                _pdfBrand(company, green),
                pw.SizedBox(height: 18),
                pw.Text(
                  'CERTIFICATE',
                  style: _pdfText(
                    size: 30,
                    color: green,
                    weight: pw.FontWeight.bold,
                    letterSpacing: 1.8,
                  ),
                ),
                pw.SizedBox(height: 4),
                pw.Text(
                  'OF SAFETY COMMITMENT',
                  style: _pdfText(
                    size: 11,
                    color: PdfColors.amber800,
                    weight: pw.FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
                pw.SizedBox(height: 24),
                _pdfRecipient(
                  name,
                  green,
                  script: true,
                ),
                if (id.isNotEmpty ||
                    department.isNotEmpty) ...[
                  pw.SizedBox(height: 8),
                  pw.Text(
                    [
                      if (id.isNotEmpty)
                        'Employee ID: $id',
                      if (department.isNotEmpty)
                        'Department: $department',
                    ].join('  |  '),
                    textAlign: pw.TextAlign.center,
                    style: _pdfText(
                      size: 7.5,
                      color: PdfColors.grey700,
                    ),
                  ),
                ],
                pw.SizedBox(height: 20),
                _pdfAchievement(achievement),
                pw.SizedBox(height: 14),
                _pdfBadges(green),
                pw.Spacer(),
                pw.Row(
                  mainAxisAlignment:
                      pw.MainAxisAlignment.spaceBetween,
                  crossAxisAlignment:
                      pw.CrossAxisAlignment.end,
                  children: [
                    _pdfMeta(
                      formattedDate,
                      'Date',
                      green,
                    ),
                    _pdfSeal(
                      green,
                      gold: true,
                    ),
                    _pdfMeta(
                      signatory,
                      'HSE Manager / Authorized Signatory',
                      green,
                    ),
                  ],
                ),
                pw.SizedBox(height: 13),
                _pdfFooter(
                  footer,
                  green,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  pw.Widget _template2({
    required String company,
    required String name,
    required String id,
    required String department,
    required String achievement,
    required String signatory,
    required String footer,
    required PdfColor green,
  }) {
    return pw.Container(
      color: PdfColors.white,
      padding: const pw.EdgeInsets.all(22),
      child: pw.Stack(
        children: [
          pw.Positioned(
            top: 0,
            right: 0,
            child: pw.Container(
              width: 190,
              height: 110,
              decoration: pw.BoxDecoration(
                color: green,
                borderRadius:
                    const pw.BorderRadius.only(
                  bottomLeft:
                      pw.Radius.circular(120),
                ),
              ),
            ),
          ),
          pw.Positioned(
            bottom: 0,
            left: 0,
            child: pw.Container(
              width: 150,
              height: 75,
              decoration: pw.BoxDecoration(
                color: PdfColors.amber800,
                borderRadius:
                    const pw.BorderRadius.only(
                  topRight:
                      pw.Radius.circular(100),
                ),
              ),
            ),
          ),
          pw.Column(
            crossAxisAlignment:
                pw.CrossAxisAlignment.start,
            children: [
              _pdfBrand(
                company,
                green,
                compact: true,
              ),
              pw.SizedBox(height: 30),
              pw.Text(
                'CERTIFICATE',
                style: _pdfText(
                  size: 31,
                  color: green,
                  weight: pw.FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
              pw.Text(
                'OF COMPLETION',
                style: _pdfText(
                  size: 11,
                  color: PdfColors.amber800,
                  weight: pw.FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              pw.SizedBox(height: 25),
              pw.Text(
                'THIS IS TO CERTIFY THAT',
                style: _pdfText(
                  size: 7,
                  color: PdfColors.grey700,
                  weight: pw.FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
              pw.SizedBox(height: 8),
              pw.Text(
                name,
                maxLines: 2,
                style: _pdfText(
                  size: 27,
                  color: green,
                  weight: pw.FontWeight.bold,
                ),
              ),
              pw.Container(
                width: 290,
                height: 2,
                color: green,
              ),
              pw.SizedBox(height: 13),
              if (id.isNotEmpty ||
                  department.isNotEmpty)
                pw.Text(
                  [
                    if (id.isNotEmpty) 'ID: $id',
                    if (department.isNotEmpty)
                      'Department: $department',
                  ].join('  |  '),
                  style: _pdfText(
                    size: 7.5,
                    color: PdfColors.grey700,
                  ),
                ),
              pw.SizedBox(height: 22),
              _pdfAchievement(achievement),
              pw.SizedBox(height: 18),
              _pdfBadges(green),
              pw.Spacer(),
              pw.Row(
                mainAxisAlignment:
                    pw.MainAxisAlignment.spaceBetween,
                children: [
                  _pdfMeta(
                    formattedDate,
                    'Date',
                    green,
                  ),
                  _pdfMeta(
                    signatory,
                    'Authorized Signatory',
                    green,
                  ),
                ],
              ),
              pw.SizedBox(height: 16),
              _pdfFooter(
                footer,
                green,
              ),
            ],
          ),
        ],
      ),
    );
  }

  pw.Widget _template3({
    required String company,
    required String name,
    required String id,
    required String department,
    required String achievement,
    required String signatory,
    required String footer,
    required PdfColor green,
  }) {
    return pw.Container(
      color: PdfColors.white,
      padding: const pw.EdgeInsets.all(14),
      child: pw.Container(
        decoration: pw.BoxDecoration(
          border: pw.Border.all(
            color: PdfColors.amber800,
            width: 5,
          ),
        ),
        padding: const pw.EdgeInsets.all(5),
        child: pw.Container(
          decoration: pw.BoxDecoration(
            border: pw.Border.all(
              color: green,
              width: 2,
            ),
          ),
          padding: const pw.EdgeInsets.symmetric(
            horizontal: 27,
            vertical: 22,
          ),
          child: pw.Column(
            children: [
              pw.Text(
                'HSE  •  SAFETY  •  EXCELLENCE',
                style: _pdfText(
                  size: 7,
                  color: PdfColors.amber800,
                  weight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 5),
              _pdfBrand(
                company,
                green,
                compact: true,
              ),
              pw.SizedBox(height: 18),
              pw.Text(
                'CERTIFICATE',
                style: _pdfText(
                  size: 28,
                  color: PdfColors.amber800,
                  weight: pw.FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
              pw.Text(
                'OF ACHIEVEMENT',
                style: _pdfText(
                  size: 10,
                  color: green,
                  weight: pw.FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              pw.SizedBox(height: 20),
              _pdfRecipient(
                name,
                green,
                script: true,
              ),
              if (id.isNotEmpty ||
                  department.isNotEmpty) ...[
                pw.SizedBox(height: 8),
                pw.Text(
                  [
                    if (id.isNotEmpty)
                      'Employee ID: $id',
                    if (department.isNotEmpty)
                      'Department: $department',
                  ].join('  |  '),
                  style: _pdfText(
                    size: 7,
                    color: PdfColors.grey700,
                  ),
                ),
              ],
              pw.SizedBox(height: 20),
              _pdfAchievement(achievement),
              pw.Spacer(),
              pw.Row(
                mainAxisAlignment:
                    pw.MainAxisAlignment.spaceBetween,
                crossAxisAlignment:
                    pw.CrossAxisAlignment.end,
                children: [
                  _pdfMeta(
                    formattedDate,
                    'Date',
                    green,
                  ),
                  _pdfSeal(
                    green,
                    gold: true,
                  ),
                  _pdfMeta(
                    signatory,
                    'Authorized Signatory',
                    green,
                  ),
                ],
              ),
              pw.SizedBox(height: 14),
              _pdfFooter(
                footer,
                green,
              ),
            ],
          ),
        ),
      ),
    );
  }

  pw.Widget _template4({
    required String company,
    required String name,
    required String id,
    required String department,
    required String achievement,
    required String signatory,
    required String footer,
    required PdfColor green,
  }) {
    return pw.Container(
      color: PdfColors.grey100,
      padding: const pw.EdgeInsets.all(15),
      child: pw.Container(
        decoration: pw.BoxDecoration(
          color: PdfColors.white,
          border: pw.Border.all(
            color: green,
            width: 2,
          ),
        ),
        child: pw.Column(
          children: [
            pw.Container(
              width: double.infinity,
              padding: const pw.EdgeInsets.symmetric(
                vertical: 18,
              ),
              color: green,
              child: _pdfBrand(
                company,
                green,
                light: true,
              ),
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 18,
              ),
              child: pw.Column(
                children: [
                  pw.Text(
                    'CERTIFICATE',
                    style: _pdfText(
                      size: 29,
                      color: green,
                      weight: pw.FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                  pw.Text(
                    'OF PARTICIPATION',
                    style: _pdfText(
                      size: 10,
                      color: PdfColors.amber800,
                      weight: pw.FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                  pw.SizedBox(height: 16),
                  pw.Container(
                    width: double.infinity,
                    padding: const pw.EdgeInsets.all(13),
                    decoration: pw.BoxDecoration(
                      border: pw.Border.all(
                        color: green,
                        width: 1,
                      ),
                      borderRadius:
                          pw.BorderRadius.circular(8),
                    ),
                    child: _pdfRecipient(
                      name,
                      green,
                    ),
                  ),
                  if (id.isNotEmpty ||
                      department.isNotEmpty) ...[
                    pw.SizedBox(height: 8),
                    pw.Text(
                      [
                        if (id.isNotEmpty)
                          'Employee ID: $id',
                        if (department.isNotEmpty)
                          'Department: $department',
                      ].join('  |  '),
                      style: _pdfText(
                        size: 7.5,
                        color: PdfColors.grey700,
                      ),
                    ),
                  ],
                  pw.SizedBox(height: 17),
                  _pdfAchievement(achievement),
                  pw.SizedBox(height: 10),
                  _pdfBadges(green),
                  pw.SizedBox(height: 18),
                  pw.Container(
                    height: 78,
                    width: double.infinity,
                    decoration: pw.BoxDecoration(
                      color: PdfColors.grey100,
                      borderRadius:
                          pw.BorderRadius.circular(10),
                    ),
                    child: pw.Center(
                      child: pw.Text(
                        'TOGETHER FOR A SAFER UAE',
                        style: _pdfText(
                          size: 12,
                          color: green,
                          weight: pw.FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                  ),
                  pw.SizedBox(height: 15),
                  pw.Row(
                    mainAxisAlignment:
                        pw.MainAxisAlignment.spaceBetween,
                    children: [
                      _pdfMeta(
                        formattedDate,
                        'Date',
                        green,
                      ),
                      _pdfMeta(
                        signatory,
                        'HSE Manager / Authorized Signatory',
                        green,
                      ),
                      if (id.isNotEmpty)
                        _pdfMeta(
                          id,
                          'Certificate / Employee ID',
                          green,
                        ),
                    ],
                  ),
                ],
              ),
            ),
            _pdfFooter(
              footer,
              green,
            ),
          ],
        ),
      ),
    );
  }

  pw.Widget _template5({
    required String company,
    required String name,
    required String id,
    required String department,
    required String achievement,
    required String signatory,
    required String footer,
    required PdfColor green,
  }) {
    return pw.Container(
      color: PdfColors.green900,
      padding: const pw.EdgeInsets.all(15),
      child: pw.Container(
        decoration: pw.BoxDecoration(
          color: PdfColors.green900,
          border: pw.Border.all(
            color: PdfColors.amber800,
            width: 3,
          ),
        ),
        padding: const pw.EdgeInsets.all(8),
        child: pw.Container(
          decoration: pw.BoxDecoration(
            border: pw.Border.all(
              color: PdfColors.amber800,
              width: 1,
            ),
          ),
          padding: const pw.EdgeInsets.symmetric(
            horizontal: 27,
            vertical: 22,
          ),
          child: pw.Column(
            children: [
              _pdfBrand(
                company,
                green,
                light: true,
              ),
              pw.SizedBox(height: 23),
              pw.Text(
                'CERTIFICATE',
                style: _pdfText(
                  size: 30,
                  color: PdfColors.amber,
                  weight: pw.FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              pw.SizedBox(height: 4),
              pw.Text(
                'OF SAFETY EXCELLENCE',
                style: _pdfText(
                  size: 10,
                  color: PdfColors.white,
                  weight: pw.FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              pw.SizedBox(height: 23),
              _pdfRecipient(
                name,
                PdfColors.amber,
                light: true,
                script: true,
              ),
              if (id.isNotEmpty ||
                  department.isNotEmpty) ...[
                pw.SizedBox(height: 8),
                pw.Text(
                  [
                    if (id.isNotEmpty)
                      'Employee ID: $id',
                    if (department.isNotEmpty)
                      'Department: $department',
                  ].join('  |  '),
                  style: _pdfText(
                    size: 7,
                    color: PdfColors.white,
                  ),
                ),
              ],
              pw.SizedBox(height: 20),
              _pdfAchievement(
                achievement,
                light: true,
              ),
              pw.SizedBox(height: 13),
              _pdfBadges(
                PdfColors.amber,
                light: true,
              ),
              pw.Spacer(),
              pw.Row(
                mainAxisAlignment:
                    pw.MainAxisAlignment.spaceBetween,
                crossAxisAlignment:
                    pw.CrossAxisAlignment.end,
                children: [
                  _pdfMeta(
                    formattedDate,
                    'Date',
                    PdfColors.amber,
                    light: true,
                  ),
                  _pdfSeal(
                    PdfColors.amber,
                    gold: true,
                  ),
                  _pdfMeta(
                    signatory,
                    'Authorized Signatory',
                    PdfColors.amber,
                    light: true,
                  ),
                ],
              ),
              pw.SizedBox(height: 15),
              _pdfFooter(
                footer,
                PdfColors.amber,
                light: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<File> _createCertificatePdf() async {
    final pdf = pw.Document();

    final company = _clean(
      _companyController.text,
      fallback: 'SafeNexus HSE',
    );

    final name = _clean(
      _nameController.text,
      fallback: 'Employee Name',
    );

    final id = _clean(_idController.text);

    final department =
        _clean(_departmentController.text);

    final achievement =
        _cleanMultiline(
      _achievementController.text,
    );

    final signatory = _clean(
      _signatoryController.text,
      fallback: 'HSE Manager',
    );

    final footer = _clean(
      _footerController.text,
      fallback: 'Identify. Report. Stay Safe.',
    );

    final green =
        PdfColor.fromInt(_green.toARGB32());

    late pw.Widget page;

    switch (selectedTemplate) {
      case 1:
        page = _template2(
          company: company,
          name: name,
          id: id,
          department: department,
          achievement: achievement,
          signatory: signatory,
          footer: footer,
          green: green,
        );
        break;

      case 2:
        page = _template3(
          company: company,
          name: name,
          id: id,
          department: department,
          achievement: achievement,
          signatory: signatory,
          footer: footer,
          green: green,
        );
        break;

      case 3:
        page = _template4(
          company: company,
          name: name,
          id: id,
          department: department,
          achievement: achievement,
          signatory: signatory,
          footer: footer,
          green: green,
        );
        break;

      case 4:
        page = _template5(
          company: company,
          name: name,
          id: id,
          department: department,
          achievement: achievement,
          signatory: signatory,
          footer: footer,
          green: green,
        );
        break;

      default:
        page = _template1(
          company: company,
          name: name,
          id: id,
          department: department,
          achievement: achievement,
          signatory: signatory,
          footer: footer,
          green: green,
        );
    }

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4.landscape,
        margin: pw.EdgeInsets.zero,
        build: (_) => page,
      ),
    );

    final directory =
        await getApplicationDocumentsDirectory();

    final datePart =
        '${selectedDate.year}'
        '${selectedDate.month.toString().padLeft(2, '0')}'
        '${selectedDate.day.toString().padLeft(2, '0')}';

    final fileName =
        'SafeNexus_Certificate_'
        '${_safeFileName(name)}_$datePart.pdf';

    final file =
        File('${directory.path}/$fileName');

    final bytes = await pdf.save();

    await file.writeAsBytes(
      bytes,
      flush: true,
    );

    return file;
  }

  Future<void> _saveCertificatePdf() async {
    if (_isGeneratingPdf) return;

    setState(() {
      _isGeneratingPdf = true;
    });

    try {
      final file =
          await _createCertificatePdf();

      _lastSavedPath = file.path;

      if (!mounted) return;

      await showDialog<void>(
        context: context,
        builder: (dialogContext) {
          return AlertDialog(
            title: const Row(
              children: [
                Icon(
                  Icons.check_circle,
                  color: Colors.green,
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text('PDF Created'),
                ),
              ],
            ),
            content: const Text(
              'Your certificate PDF has been '
              'generated successfully. '
              'You can now share it.',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(dialogContext);
                },
                child: const Text('Close'),
              ),
              FilledButton.icon(
                onPressed: () {
                  Navigator.pop(dialogContext);
                  _shareCertificatePdf();
                },
                icon: const Icon(Icons.share),
                label: const Text('Share PDF'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      _message(
        'Could not create PDF: $e',
        error: true,
      );
    } finally {
      if (mounted) {
        setState(() {
          _isGeneratingPdf = false;
        });
      }
    }
  }

  Future<void> _shareCertificatePdf() async {
    if (_isGeneratingPdf) return;

    setState(() {
      _isGeneratingPdf = true;
    });

    try {
      late File file;

      if (_lastSavedPath != null &&
          await File(_lastSavedPath!).exists()) {
        file = File(_lastSavedPath!);
      } else {
        file =
            await _createCertificatePdf();

        _lastSavedPath = file.path;
      }

      await Share.shareXFiles(
        [
          XFile(
            file.path,
            name: file.uri.pathSegments.last,
            mimeType: 'application/pdf',
          ),
        ],
        subject:
            'SafeNexus HSE Certificate',
        text:
            'Certificate generated by SafeNexus HSE.',
      );
    } catch (e) {
      _message(
        'Could not share PDF: $e',
        error: true,
      );
    } finally {
      if (mounted) {
        setState(() {
          _isGeneratingPdf = false;
        });
      }
    }
  }

  Widget _field({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    int maxLines = 1,
  }) {
    return Padding(
      padding:
          const EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        onChanged: (_) => _markDirty(),
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(
            icon,
            color: _green,
          ),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(12),
          ),
          enabledBorder:
              OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Colors.grey.shade300,
            ),
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(
    IconData icon,
    String title,
    String subtitle,
  ) {
    return Row(
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color:
                _green.withValues(alpha: .1),
            borderRadius:
                BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: _green,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight:
                      FontWeight.w800,
                  color: _ink,
                ),
              ),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 11,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _templateCard(int index) {
    final selected =
        selectedTemplate == index;

    final colors = [
      [_green, _gold],
      [_green, Colors.blueGrey],
      [_gold, _green],
      [_green, Colors.teal],
      [_darkGreen, _gold],
    ];

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedTemplate = index;
            _lastSavedPath = null;
          });
        },
        child: AnimatedContainer(
          duration:
              const Duration(milliseconds: 180),
          margin:
              const EdgeInsets.only(right: 8),
          padding:
              const EdgeInsets.all(7),
          decoration: BoxDecoration(
            color: selected
                ? colors[index][0]
                    .withValues(alpha: .08)
                : Colors.white,
            borderRadius:
                BorderRadius.circular(14),
            border: Border.all(
              color: selected
                  ? colors[index][0]
                  : Colors.grey.shade300,
              width: selected ? 2 : 1,
            ),
          ),
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 1.42,
                child: _miniTemplate(
                  index,
                  colors[index][0],
                  colors[index][1],
                ),
              ),
              const SizedBox(height: 7),
              Text(
                '${index + 1}. '
                '${templateNames[index]}',
                textAlign:
                    TextAlign.center,
                maxLines: 2,
                style: TextStyle(
                  fontSize: 9.5,
                  fontWeight: selected
                      ? FontWeight.w800
                      : FontWeight.w600,
                  color: selected
                      ? colors[index][0]
                      : _ink,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _miniTemplate(
    int index,
    Color primary,
    Color accent,
  ) {
    if (index == 4) {
      return Container(
        decoration: BoxDecoration(
          color: _darkGreen,
          border: Border.all(
            color: accent,
            width: 2,
          ),
          borderRadius:
              BorderRadius.circular(6),
        ),
        child: Center(
          child: Text(
            'CERTIFICATE',
            style: TextStyle(
              color: accent,
              fontWeight:
                  FontWeight.w900,
              fontSize: 9,
            ),
          ),
        ),
      );
    }

    if (index == 3) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: primary,
            width: 2,
          ),
          borderRadius:
              BorderRadius.circular(6),
        ),
        child: Column(
          children: [
            Container(
              height: 14,
              color: primary,
            ),
            const Spacer(),
            Text(
              'CERTIFICATE',
              style: TextStyle(
                color: primary,
                fontWeight:
                    FontWeight.w900,
                fontSize: 8,
              ),
            ),
            const Spacer(),
            Container(
              height: 10,
              color: accent,
            ),
          ],
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: primary,
          width: index == 2 ? 3 : 2,
        ),
        borderRadius:
            BorderRadius.circular(6),
      ),
      child: Center(
        child: Text(
          'CERTIFICATE',
          style: TextStyle(
            color:
                index == 2 ? accent : primary,
            fontWeight:
                FontWeight.w900,
            fontSize: 8,
          ),
        ),
      ),
    );
  }

  Widget _previewBrand() {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.center,
      children: [
        Container(
          width: 44,
          height: 44,
          decoration:
              const BoxDecoration(
            color: _green,
            shape: BoxShape.circle,
          ),
          child: const Center(
            child: Text(
              'S',
              style: TextStyle(
                color: Colors.white,
                fontSize: 23,
                fontWeight:
                    FontWeight.w900,
              ),
            ),
          ),
        ),
        const SizedBox(width: 9),
        Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Text(
              _clean(
                _companyController.text,
                fallback: 'SafeNexus HSE',
              ),
              style: const TextStyle(
                color: _green,
                fontSize: 15,
                fontWeight:
                    FontWeight.w900,
              ),
            ),
            const Text(
              'HSE Safety & Observation App',
              style: TextStyle(
                fontSize: 6.5,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _previewMeta(
    String value,
    String label,
  ) {
    return SizedBox(
      width: 90,
      child: Column(
        children: [
          Container(
            height: 1,
            color: Colors.black45,
          ),
          const SizedBox(height: 4),
          Text(
            value,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow:
                TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 6.5,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 5.5,
              color: _green,
              fontWeight:
                  FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _previewSeal({
    bool dark = false,
  }) {
    return Container(
      width: 54,
      height: 54,
      decoration: BoxDecoration(
        color: dark ? _gold : _green,
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white,
          width: 2,
        ),
      ),
      child: const Center(
        child: Text(
          'SAFETY\nIS OUR\nPRIORITY',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 5.5,
            fontWeight:
                FontWeight.w900,
            height: 1.15,
          ),
        ),
      ),
    );
  }

  Widget _previewBadges({
    bool dark = false,
  }) {
    final color =
        dark ? _gold : _green;

    return Row(
      mainAxisAlignment:
          MainAxisAlignment.spaceEvenly,
      children: [
        'SAFETY',
        'REPORT',
        'PROTECT',
        'BUILD',
      ].map((label) {
        return Column(
          children: [
            Container(
              width: 27,
              height: 27,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: color,
                ),
              ),
              child: Icon(
                Icons.check,
                size: 14,
                color: color,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 4.5,
                color: color,
                fontWeight:
                    FontWeight.bold,
              ),
            ),
          ],
        );
      }).toList(),
    );
  }

  Widget _basePreview({
    required Widget child,
    bool dark = false,
  }) {
    return AspectRatio(
      aspectRatio: 1.414,
      child: Container(
        padding:
            const EdgeInsets.all(7),
        decoration: BoxDecoration(
          color: dark
              ? _darkGreen
              : Colors.white,
          border: Border.all(
            color: dark
                ? _gold
                : _green,
            width: 5,
          ),
          boxShadow: const [
            BoxShadow(
              blurRadius: 12,
              offset: Offset(0, 5),
              color: Colors.black12,
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            color: dark
                ? _darkGreen
                : Colors.white,
            border: Border.all(
              color: dark
                  ? _gold
                  : _gold.withValues(
                      alpha: .7,
                    ),
              width: 1.5,
            ),
          ),
          child: child,
        ),
      ),
    );
  }

  Widget _preview() {
    final name = _clean(
      _nameController.text,
      fallback: 'Employee Name',
    );

    final achievement =
        _cleanMultiline(
      _achievementController.text,
    );

    final id =
        _clean(_idController.text);

    final department =
        _clean(_departmentController.text);

    final signatory = _clean(
      _signatoryController.text,
      fallback: 'HSE Manager',
    );

    final footer = _clean(
      _footerController.text,
      fallback:
          'Identify. Report. Stay Safe.',
    );

    switch (selectedTemplate) {
      case 1:
        return _previewMinimal(
          name,
          achievement,
          id,
          department,
          signatory,
          footer,
        );

      case 2:
        return _previewElegant(
          name,
          achievement,
          id,
          department,
          signatory,
          footer,
        );

      case 3:
        return _previewUae(
          name,
          achievement,
          id,
          department,
          signatory,
          footer,
        );

      case 4:
        return _previewDark(
          name,
          achievement,
          id,
          department,
          signatory,
          footer,
        );

      default:
        return _previewClassic(
          name,
          achievement,
          id,
          department,
          signatory,
          footer,
        );
    }
  }

  Widget _previewClassic(
    String name,
    String achievement,
    String id,
    String department,
    String signatory,
    String footer,
  ) {
    return _basePreview(
      child: Padding(
        padding:
            const EdgeInsets.symmetric(
          horizontal: 22,
          vertical: 15,
        ),
        child: Column(
          children: [
            _previewBrand(),
            const SizedBox(height: 9),
            const Text(
              'CERTIFICATE',
              style: TextStyle(
                fontSize: 24,
                color: _green,
                fontWeight:
                    FontWeight.w900,
                letterSpacing: 1.5,
              ),
            ),
            const Text(
              'OF SAFETY COMMITMENT',
              style: TextStyle(
                fontSize: 7,
                color: _gold,
                fontWeight:
                    FontWeight.w900,
                letterSpacing: 1.8,
              ),
            ),
            const SizedBox(height: 11),
            const Text(
              'THIS CERTIFICATE IS PROUDLY PRESENTED TO',
              style: TextStyle(
                fontSize: 5.5,
                fontWeight:
                    FontWeight.bold,
                letterSpacing: .8,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              name,
              maxLines: 2,
              overflow:
                  TextOverflow.ellipsis,
              textAlign:
                  TextAlign.center,
              style: const TextStyle(
                fontSize: 23,
                color: _green,
                fontWeight:
                    FontWeight.w800,
              ),
            ),
            Container(
              width: 230,
              height: 1,
              color: _gold,
            ),
            if (id.isNotEmpty ||
                department.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                [
                  if (id.isNotEmpty)
                    'ID: $id',
                  if (department.isNotEmpty)
                    'Department: $department',
                ].join('  |  '),
                style: const TextStyle(
                  fontSize: 5.5,
                  color: Colors.black54,
                ),
              ),
            ],
            const SizedBox(height: 7),
            Expanded(
              child: Center(
                child: Text(
                  achievement,
                  maxLines: 4,
                  overflow:
                      TextOverflow.ellipsis,
                  textAlign:
                      TextAlign.center,
                  style: const TextStyle(
                    fontSize: 7.5,
                    height: 1.35,
                  ),
                ),
              ),
            ),
            _previewBadges(),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              crossAxisAlignment:
                  CrossAxisAlignment.end,
              children: [
                _previewMeta(
                  formattedDate,
                  'DATE',
                ),
                _previewSeal(),
                _previewMeta(
                  signatory,
                  'HSE MANAGER',
                ),
              ],
            ),
            const SizedBox(height: 6),
            Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.symmetric(
                vertical: 5,
              ),
              color: _green,
              child: Text(
                footer,
                textAlign:
                    TextAlign.center,
                maxLines: 1,
                overflow:
                    TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 6.5,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _previewMinimal(
    String name,
    String achievement,
    String id,
    String department,
    String signatory,
    String footer,
  ) {
    return AspectRatio(
      aspectRatio: 1.414,
      child: Container(
        color: Colors.white,
        padding:
            const EdgeInsets.all(18),
        child: Stack(
          children: [
            Positioned(
              top: -18,
              right: -18,
              child: Container(
                width: 120,
                height: 85,
                decoration:
                    const BoxDecoration(
                  color: _green,
                  borderRadius:
                      BorderRadius.only(
                    bottomLeft:
                        Radius.circular(
                      100,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: -18,
              left: -18,
              child: Container(
                width: 100,
                height: 65,
                decoration:
                    const BoxDecoration(
                  color: _gold,
                  borderRadius:
                      BorderRadius.only(
                    topRight:
                        Radius.circular(
                      100,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  _previewBrand(),
                  const SizedBox(height: 14),
                  const Text(
                    'CERTIFICATE',
                    style: TextStyle(
                      fontSize: 24,
                      color: _green,
                      fontWeight:
                          FontWeight.w900,
                    ),
                  ),
                  const Text(
                    'OF COMPLETION',
                    style: TextStyle(
                      fontSize: 7,
                      color: _gold,
                      fontWeight:
                          FontWeight.w900,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'THIS IS TO CERTIFY THAT',
                    style: TextStyle(
                      fontSize: 5.5,
                      color: Colors.black54,
                      fontWeight:
                          FontWeight.bold,
                      letterSpacing: .8,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    name,
                    maxLines: 2,
                    overflow:
                        TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 22,
                      color: _green,
                      fontWeight:
                          FontWeight.w900,
                    ),
                  ),
                  Container(
                    width: 210,
                    height: 1.5,
                    color: _green,
                  ),
                  if (id.isNotEmpty ||
                      department.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      [
                        if (id.isNotEmpty)
                          'ID: $id',
                        if (department.isNotEmpty)
                          'Department: $department',
                      ].join('  |  '),
                      style: const TextStyle(
                        fontSize: 5.5,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                  const SizedBox(height: 8),
                  Expanded(
                    child: Center(
                      child: Text(
                        achievement,
                        maxLines: 4,
                        overflow:
                            TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 7.5,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ),
                  _previewBadges(),
                  const SizedBox(height: 7),
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: [
                      _previewMeta(
                        formattedDate,
                        'DATE',
                      ),
                      _previewMeta(
                        signatory,
                        'AUTHORIZED SIGNATORY',
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Container(
                    width: double.infinity,
                    padding:
                        const EdgeInsets.symmetric(
                      vertical: 5,
                    ),
                    color: _green,
                    child: Text(
                      footer,
                      textAlign:
                          TextAlign.center,
                      maxLines: 1,
                      overflow:
                          TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 6,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _previewElegant(
    String name,
    String achievement,
    String id,
    String department,
    String signatory,
    String footer,
  ) {
    return _basePreview(
      child: Padding(
        padding:
            const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 13,
        ),
        child: Column(
          children: [
            const Text(
              'HSE  •  SAFETY  •  EXCELLENCE',
              style: TextStyle(
                color: _gold,
                fontSize: 7,
                fontWeight:
                    FontWeight.bold,
              ),
            ),
            _previewBrand(),
            const SizedBox(height: 7),
            const Text(
              'CERTIFICATE',
              style: TextStyle(
                fontSize: 23,
                color: _gold,
                fontWeight:
                    FontWeight.w900,
                letterSpacing: 1.4,
              ),
            ),
            const Text(
              'OF ACHIEVEMENT',
              style: TextStyle(
                fontSize: 7,
                color: _green,
                fontWeight:
                    FontWeight.w900,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'THIS CERTIFICATE IS PROUDLY PRESENTED TO',
              style: TextStyle(
                fontSize: 5.5,
                fontWeight:
                    FontWeight.bold,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              name,
              maxLines: 2,
              overflow:
                  TextOverflow.ellipsis,
              textAlign:
                  TextAlign.center,
              style: const TextStyle(
                fontSize: 22,
                color: _green,
                fontWeight:
                    FontWeight.w800,
              ),
            ),
            Container(
              width: 220,
              height: 1,
              color: _gold,
            ),
            if (id.isNotEmpty ||
                department.isNotEmpty)
              Text(
                [
                  if (id.isNotEmpty)
                    'Employee ID: $id',
                  if (department.isNotEmpty)
                    'Department: $department',
                ].join('  |  '),
                style: const TextStyle(
                  fontSize: 5,
                  color: Colors.black54,
                ),
              ),
            Expanded(
              child: Center(
                child: Text(
                  achievement,
                  maxLines: 4,
                  overflow:
                      TextOverflow.ellipsis,
                  textAlign:
                      TextAlign.center,
                  style: const TextStyle(
                    fontSize: 7.2,
                    height: 1.35,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              crossAxisAlignment:
                  CrossAxisAlignment.end,
              children: [
                _previewMeta(
                  formattedDate,
                  'DATE',
                ),
                _previewSeal(),
                _previewMeta(
                  signatory,
                  'AUTHORIZED SIGNATORY',
                ),
              ],
            ),
            const SizedBox(height: 6),
            Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.symmetric(
                vertical: 5,
              ),
              color: _green,
              child: Text(
                footer,
                textAlign:
                    TextAlign.center,
                maxLines: 1,
                overflow:
                    TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 6,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _previewUae(
    String name,
    String achievement,
    String id,
    String department,
    String signatory,
    String footer,
  ) {
    return AspectRatio(
      aspectRatio: 1.414,
      child: Container(
        color: Colors.grey.shade50,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.symmetric(
                vertical: 10,
              ),
              color: _green,
              child: _previewBrandDark(),
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 22,
                  vertical: 10,
                ),
                child: Column(
                  children: [
                    const Text(
                      'CERTIFICATE',
                      style: TextStyle(
                        fontSize: 23,
                        color: _green,
                        fontWeight:
                            FontWeight.w900,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const Text(
                      'OF PARTICIPATION',
                      style: TextStyle(
                        fontSize: 7,
                        color: _gold,
                        fontWeight:
                            FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Container(
                      width: double.infinity,
                      padding:
                          const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: _green,
                        ),
                        borderRadius:
                            BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          const Text(
                            'THIS CERTIFICATE IS PROUDLY PRESENTED TO',
                            style: TextStyle(
                              fontSize: 5,
                              fontWeight:
                                  FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            name,
                            maxLines: 2,
                            overflow:
                                TextOverflow.ellipsis,
                            textAlign:
                                TextAlign.center,
                            style: const TextStyle(
                              fontSize: 20,
                              color: _green,
                              fontWeight:
                                  FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (id.isNotEmpty ||
                        department.isNotEmpty) ...[
                      const SizedBox(height: 3),
                      Text(
                        [
                          if (id.isNotEmpty)
                            'ID: $id',
                          if (department.isNotEmpty)
                            'Department: $department',
                        ].join('  |  '),
                        style: const TextStyle(
                          fontSize: 5.5,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                    Expanded(
                      child: Center(
                        child: Text(
                          achievement,
                          maxLines: 4,
                          overflow:
                              TextOverflow.ellipsis,
                          textAlign:
                              TextAlign.center,
                          style: const TextStyle(
                            fontSize: 7.2,
                            height: 1.3,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 42,
                      width: double.infinity,
                      decoration:
                          BoxDecoration(
                        color:
                            Colors.grey.shade100,
                        borderRadius:
                            BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: Text(
                          'TOGETHER FOR A SAFER UAE',
                          style: TextStyle(
                            fontSize: 8,
                            color: _green,
                            fontWeight:
                                FontWeight.w900,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 7),
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                      children: [
                        _previewMeta(
                          formattedDate,
                          'DATE',
                        ),
                        _previewMeta(
                          signatory,
                          'HSE MANAGER',
                        ),
                        if (id.isNotEmpty)
                          _previewMeta(
                            id,
                            'ID',
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.symmetric(
                vertical: 5,
              ),
              color: _green,
              child: Text(
                footer,
                textAlign:
                    TextAlign.center,
                maxLines: 1,
                overflow:
                    TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 6,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _previewDark(
    String name,
    String achievement,
    String id,
    String department,
    String signatory,
    String footer,
  ) {
    return _basePreview(
      dark: true,
      child: Padding(
        padding:
            const EdgeInsets.symmetric(
          horizontal: 21,
          vertical: 14,
        ),
        child: Column(
          children: [
            _previewBrandDark(),
            const SizedBox(height: 11),
            const Text(
              'CERTIFICATE',
              style: TextStyle(
                fontSize: 24,
                color: _gold,
                fontWeight:
                    FontWeight.w900,
                letterSpacing: 1.8,
              ),
            ),
            const Text(
              'OF SAFETY EXCELLENCE',
              style: TextStyle(
                fontSize: 7,
                color: Colors.white,
                fontWeight:
                    FontWeight.bold,
                letterSpacing: 1.4,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'THIS CERTIFICATE IS PROUDLY PRESENTED TO',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 5.5,
                fontWeight:
                    FontWeight.bold,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              name,
              maxLines: 2,
              overflow:
                  TextOverflow.ellipsis,
              textAlign:
                  TextAlign.center,
              style: const TextStyle(
                fontSize: 22,
                color: _gold,
                fontWeight:
                    FontWeight.w800,
              ),
            ),
            Container(
              width: 220,
              height: 1,
              color: _gold,
            ),
            if (id.isNotEmpty ||
                department.isNotEmpty)
              Text(
                [
                  if (id.isNotEmpty)
                    'Employee ID: $id',
                  if (department.isNotEmpty)
                    'Department: $department',
                ].join('  |  '),
                style: const TextStyle(
                  fontSize: 5,
                  color: Colors.white70,
                ),
              ),
            Expanded(
              child: Center(
                child: Text(
                  achievement,
                  maxLines: 4,
                  overflow:
                      TextOverflow.ellipsis,
                  textAlign:
                      TextAlign.center,
                  style: const TextStyle(
                    fontSize: 7.2,
                    color: Colors.white,
                    height: 1.35,
                  ),
                ),
              ),
            ),
            _previewBadges(
              dark: true,
            ),
            const SizedBox(height: 7),
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              crossAxisAlignment:
                  CrossAxisAlignment.end,
              children: [
                _previewMetaDark(
                  formattedDate,
                  'DATE',
                ),
                _previewSeal(
                  dark: true,
                ),
                _previewMetaDark(
                  signatory,
                  'AUTHORIZED SIGNATORY',
                ),
              ],
            ),
            const SizedBox(height: 6),
            Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.symmetric(
                vertical: 5,
              ),
              color: _gold,
              child: Text(
                footer,
                textAlign:
                    TextAlign.center,
                maxLines: 1,
                overflow:
                    TextOverflow.ellipsis,
                style: const TextStyle(
                  color: _darkGreen,
                  fontSize: 6,
                  fontWeight:
                      FontWeight.w900,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _previewBrandDark() {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.center,
      children: [
        Container(
          width: 42,
          height: 42,
          decoration:
              const BoxDecoration(
            color: _gold,
            shape: BoxShape.circle,
          ),
          child: const Center(
            child: Text(
              'S',
              style: TextStyle(
                color: _darkGreen,
                fontSize: 22,
                fontWeight:
                    FontWeight.w900,
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Text(
              _clean(
                _companyController.text,
                fallback: 'SafeNexus HSE',
              ),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight:
                    FontWeight.w900,
              ),
            ),
            const Text(
              'HSE Safety & Observation App',
              style: TextStyle(
                fontSize: 6,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _previewMetaDark(
    String value,
    String label,
  ) {
    return SizedBox(
      width: 90,
      child: Column(
        children: [
          Container(
            height: 1,
            color: Colors.white54,
          ),
          const SizedBox(height: 4),
          Text(
            value,
            textAlign:
                TextAlign.center,
            maxLines: 2,
            overflow:
                TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 6.5,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            textAlign:
                TextAlign.center,
            style: const TextStyle(
              fontSize: 5.5,
              color: _gold,
              fontWeight:
                  FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _actions() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: FilledButton.icon(
            onPressed:
                _isGeneratingPdf
                    ? null
                    : _saveCertificatePdf,
            icon: _isGeneratingPdf
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child:
                        CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const Icon(
                    Icons.picture_as_pdf,
                  ),
            label: Text(
              _isGeneratingPdf
                  ? 'Creating PDF...'
                  : 'Save Certificate PDF',
            ),
            style:
                FilledButton.styleFrom(
              backgroundColor: _green,
              padding:
                  const EdgeInsets.symmetric(
                vertical: 15,
              ),
            ),
          ),
        ),
        const SizedBox(height: 9),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed:
                _isGeneratingPdf
                    ? null
                    : _shareCertificatePdf,
            icon:
                const Icon(Icons.share),
            label: const Text(
              'Share Certificate PDF',
            ),
            style:
                OutlinedButton.styleFrom(
              foregroundColor: _green,
              side: const BorderSide(
                color: _green,
              ),
              padding:
                  const EdgeInsets.symmetric(
                vertical: 14,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFF3F7F4),
      appBar: AppBar(
        backgroundColor: _darkGreen,
        foregroundColor: Colors.white,
        title: const Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Text(
              'SAFENEXUS HSE',
              style: TextStyle(
                fontSize: 17,
                fontWeight:
                    FontWeight.w900,
              ),
            ),
            Text(
              'Professional Certificate Designer',
              style: TextStyle(
                fontSize: 11,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Save PDF',
            onPressed:
                _isGeneratingPdf
                    ? null
                    : _saveCertificatePdf,
            icon: const Icon(
              Icons.picture_as_pdf,
            ),
          ),
          IconButton(
            tooltip: 'Share PDF',
            onPressed:
                _isGeneratingPdf
                    ? null
                    : _shareCertificatePdf,
            icon:
                const Icon(Icons.share),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding:
              const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              _sectionTitle(
                Icons.workspace_premium,
                'Certificate Designer',
                'Choose a professional design, edit details, preview and export.',
              ),
              const SizedBox(height: 15),

              Card(
                elevation: 0,
                color: Colors.white,
                shape:
                    RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(16),
                  side: BorderSide(
                    color:
                        Colors.grey.shade200,
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.all(13),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Choose Design',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight:
                              FontWeight.w800,
                          color: _ink,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        '5 professional certificate templates',
                        style: TextStyle(
                          fontSize: 10,
                          color:
                              Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children:
                            List.generate(
                          5,
                          _templateCard,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 14),

              Card(
                elevation: 0,
                color: Colors.white,
                shape:
                    RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(16),
                  side: BorderSide(
                    color:
                        Colors.grey.shade200,
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Certificate Details',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight:
                              FontWeight.w800,
                          color: _ink,
                        ),
                      ),
                      const SizedBox(height: 11),

                      _field(
                        label:
                            'Employee Name',
                        controller:
                            _nameController,
                        icon:
                            Icons.person_outline,
                      ),

                      _field(
                        label:
                            'Employee ID',
                        controller:
                            _idController,
                        icon:
                            Icons.badge_outlined,
                      ),

                      _field(
                        label:
                            'Department',
                        controller:
                            _departmentController,
                        icon:
                            Icons.business_outlined,
                      ),

                      _field(
                        label:
                            'Achievement / Reason',
                        controller:
                            _achievementController,
                        icon: Icons
                            .workspace_premium_outlined,
                        maxLines: 4,
                      ),

                      _field(
                        label:
                            'Company Name',
                        controller:
                            _companyController,
                        icon:
                            Icons.apartment_outlined,
                      ),

                      _field(
                        label:
                            'HSE Manager / Authorized Signatory',
                        controller:
                            _signatoryController,
                        icon:
                            Icons.draw_outlined,
                      ),

                      _field(
                        label:
                            'Footer Text',
                        controller:
                            _footerController,
                        icon:
                            Icons.short_text,
                      ),

                      InkWell(
                        onTap:
                            _selectDate,
                        child:
                            InputDecorator(
                          decoration:
                              InputDecoration(
                            labelText:
                                'Certificate Date',
                            prefixIcon:
                                const Icon(
                              Icons
                                  .calendar_today,
                              color: _green,
                            ),
                            border:
                                OutlineInputBorder(
                              borderRadius:
                                  BorderRadius
                                      .circular(
                                12,
                              ),
                            ),
                          ),
                          child: Text(
                            formattedDate,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 14),

              Card(
                elevation: 0,
                color: Colors.white,
                shape:
                    RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(16),
                  side: BorderSide(
                    color:
                        Colors.grey.shade200,
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      _sectionTitle(
                        Icons.visibility_outlined,
                        'Live Preview',
                        'The selected design is reflected here.',
                      ),
                      const SizedBox(height: 12),
                      _preview(),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 14),

              _actions(),

              if (_lastSavedPath != null) ...[
                const SizedBox(height: 10),
                Card(
                  elevation: 0,
                  color: _green.withValues(
                    alpha: .08,
                  ),
                  child: const Padding(
                    padding:
                        EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: _green,
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Certificate PDF is ready to share.',
                            style:
                                TextStyle(
                              fontWeight:
                                  FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],

              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child:
                        OutlinedButton.icon(
                      onPressed:
                          _resetCertificate,
                      icon: const Icon(
                        Icons.refresh,
                      ),
                      label:
                          const Text('Reset'),
                      style:
                          OutlinedButton.styleFrom(
                        padding:
                            const EdgeInsets
                                .symmetric(
                          vertical: 14,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child:
                        FilledButton.icon(
                      onPressed:
                          _isGeneratingPdf
                              ? null
                              : _saveCertificatePdf,
                      icon: const Icon(
                        Icons.picture_as_pdf,
                      ),
                      label: const Text(
                        'Export PDF',
                      ),
                      style:
                          FilledButton.styleFrom(
                        backgroundColor:
                            _green,
                        padding:
                            const EdgeInsets
                                .symmetric(
                          vertical: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
