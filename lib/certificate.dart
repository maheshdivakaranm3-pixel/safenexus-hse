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
  final _nameController =
      TextEditingController(text: 'Employee Name');
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

  // ===========================================================================
  // PREMIUM BRAND COLORS
  // ===========================================================================

  static const Color _green = Color(0xFF075B3A);
  static const Color _darkGreen = Color(0xFF033D29);
  static const Color _deepGreen = Color(0xFF01291D);
  static const Color _gold = Color(0xFFC9A227);
  static const Color _cream = Color(0xFFF8F5EC);
  static const Color _ink = Color(0xFF18362B);

  static const List<String> templateNames = [
    'Royal HSE',
    'Executive',
    'Elegant Gold',
    'UAE Safety',
    'Midnight',
  ];

  // ===========================================================================
  // LIFECYCLE
  // ===========================================================================

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

  // ===========================================================================
  // TEXT HELPERS
  // ===========================================================================

  String _clean(
    String value, {
    String fallback = '',
  }) {
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

  String _limitText(
    String value,
    int maxLength,
  ) {
    if (value.length <= maxLength) {
      return value;
    }

    return '${value.substring(0, maxLength - 1).trim()}…';
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

  String get formattedDate {
    return '${selectedDate.day.toString().padLeft(2, '0')} '
        '${_month(selectedDate.month)} ${selectedDate.year}';
  }

  String get shortDate {
    return '${selectedDate.day.toString().padLeft(2, '0')}/'
        '${selectedDate.month.toString().padLeft(2, '0')}/'
        '${selectedDate.year}';
  }

  void _markDirty() {
    if (!mounted) return;

    setState(() {
      _lastSavedPath = null;
    });
  }

  // ===========================================================================
  // DATE
  // ===========================================================================

  Future<void> _selectDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: _green,
              secondary: _gold,
            ),
          ),
          child: child!,
        );
      },
    );

    if (date != null && mounted) {
      setState(() {
        selectedDate = date;
        _lastSavedPath = null;
      });
    }
  }

  // ===========================================================================
  // RESET
  // ===========================================================================

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

  // ===========================================================================
  // MESSAGE
  // ===========================================================================

  void _message(
    String message, {
    bool error = false,
  }) {
    if (!mounted) return;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
          backgroundColor:
              error ? Colors.red.shade700 : _darkGreen,
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

    return result.length > 50
        ? result.substring(0, 50)
        : result;
  }

  // ===========================================================================
  // PDF TEXT STYLE
  // ===========================================================================

  pw.TextStyle _pText({
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

  // ===========================================================================
  // PDF LOGO
  // ===========================================================================

  pw.Widget _pdfLogo({
    required PdfColor primary,
    required PdfColor accent,
    bool dark = false,
    double size = 48,
  }) {
    return pw.Container(
      width: size,
      height: size,
      decoration: pw.BoxDecoration(
        shape: pw.BoxShape.circle,
        color: dark ? accent : primary,
        border: pw.Border.all(
          color: dark ? primary : accent,
          width: 2,
        ),
      ),
      child: pw.Center(
        child: pw.Container(
          width: size - 12,
          height: size - 12,
          decoration: pw.BoxDecoration(
            shape: pw.BoxShape.circle,
            border: pw.Border.all(
              color: dark ? primary : PdfColors.white,
              width: 1,
            ),
          ),
          child: pw.Center(
            child: pw.Text(
              'S',
              style: _pText(
                size: size * .40,
                color: dark ? primary : PdfColors.white,
                weight: pw.FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // PDF BRAND
  // ===========================================================================

  pw.Widget _pdfBrand({
    required String company,
    required PdfColor primary,
    required PdfColor accent,
    bool dark = false,
    bool centered = false,
  }) {
    return pw.Row(
      mainAxisAlignment: centered
          ? pw.MainAxisAlignment.center
          : pw.MainAxisAlignment.start,
      children: [
        _pdfLogo(
          primary: primary,
          accent: accent,
          dark: dark,
          size: 46,
        ),
        pw.SizedBox(width: 9),
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              _limitText(company, 38),
              maxLines: 1,
              style: _pText(
                size: 16,
                color: dark ? PdfColors.white : primary,
                weight: pw.FontWeight.bold,
                letterSpacing: .3,
              ),
            ),
            pw.SizedBox(height: 3),
            pw.Text(
              'HSE • SAFETY • OBSERVATION',
              style: _pText(
                size: 6,
                color: dark
                    ? PdfColors.grey300
                    : PdfColors.grey600,
                weight: pw.FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ===========================================================================
  // PDF ORNAMENT
  // ===========================================================================

  pw.Widget _ornament(
    PdfColor color, {
    double width = 55,
  }) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.center,
      children: [
        pw.Container(
          width: width,
          height: .8,
          color: color,
        ),
        pw.SizedBox(width: 6),
        pw.Container(
          width: 6,
          height: 6,
          decoration: pw.BoxDecoration(
            color: color,
            shape: pw.BoxShape.circle,
          ),
        ),
        pw.SizedBox(width: 6),
        pw.Container(
          width: width,
          height: .8,
          color: color,
        ),
      ],
    );
  }

  // ===========================================================================
  // PDF TITLE
  // ===========================================================================

  pw.Widget _pdfTitle({
    required String subtitle,
    required PdfColor primary,
    required PdfColor accent,
    bool dark = false,
    bool goldTitle = false,
  }) {
    final titleColor =
        goldTitle ? accent : (dark ? accent : primary);

    return pw.Column(
      children: [
        pw.Text(
          'CERTIFICATE',
          textAlign: pw.TextAlign.center,
          style: _pText(
            size: 29,
            color: titleColor,
            weight: pw.FontWeight.bold,
            letterSpacing: 2.4,
          ),
        ),
        pw.SizedBox(height: 3),
        pw.Text(
          subtitle,
          textAlign: pw.TextAlign.center,
          style: _pText(
            size: 8,
            color: dark ? PdfColors.white : accent,
            weight: pw.FontWeight.bold,
            letterSpacing: 1.8,
          ),
        ),
        pw.SizedBox(height: 8),
        _ornament(
          titleColor,
          width: 50,
        ),
      ],
    );
  }

  // ===========================================================================
  // PDF RECIPIENT
  // ===========================================================================

  pw.Widget _pdfRecipient({
    required String name,
    required PdfColor primary,
    required PdfColor accent,
    bool dark = false,
  }) {
    final safeName =
        _limitText(
          _clean(
            name,
            fallback: 'Employee Name',
          ),
          55,
        );

    return pw.Column(
      children: [
        pw.Text(
          'PROUDLY PRESENTED TO',
          textAlign: pw.TextAlign.center,
          style: _pText(
            size: 6.5,
            color: dark
                ? PdfColors.grey300
                : PdfColors.grey600,
            weight: pw.FontWeight.bold,
            letterSpacing: 1.6,
          ),
        ),
        pw.SizedBox(height: 5),
        pw.Text(
          safeName,
          textAlign: pw.TextAlign.center,
          maxLines: 2,
          style: _pText(
            size: 25,
            color: dark ? accent : primary,
            weight: pw.FontWeight.bold,
          ),
        ),
        pw.SizedBox(height: 4),
        pw.Container(
          width: 270,
          height: 1,
          color: dark ? accent : primary,
        ),
      ],
    );
  }

  // ===========================================================================
  // PDF DETAILS
  // ===========================================================================

  pw.Widget _pdfDetails({
    required String id,
    required String department,
    bool dark = false,
  }) {
    if (id.isEmpty && department.isEmpty) {
      return pw.SizedBox(height: 2);
    }

    final items = <String>[];

    if (id.isNotEmpty) {
      items.add(
        'EMPLOYEE ID: ${_limitText(id, 24)}',
      );
    }

    if (department.isNotEmpty) {
      items.add(
        'DEPARTMENT: ${_limitText(department, 28)}',
      );
    }

    return pw.Padding(
      padding: const pw.EdgeInsets.only(top: 5),
      child: pw.Text(
        items.join('   •   '),
        textAlign: pw.TextAlign.center,
        maxLines: 1,
        style: _pText(
          size: 6.5,
          color: dark
              ? PdfColors.grey300
              : PdfColors.grey600,
          weight: pw.FontWeight.bold,
          letterSpacing: .3,
        ),
      ),
    );
  }

  // ===========================================================================
  // PDF ACHIEVEMENT
  // ===========================================================================

  pw.Widget _pdfAchievement({
    required String achievement,
    required PdfColor primary,
    required PdfColor accent,
    bool dark = false,
  }) {
    final text = achievement.isEmpty
        ? 'Outstanding commitment to safety.'
        : _limitText(achievement, 420);

    return pw.Container(
      width: double.infinity,
      padding: const pw.EdgeInsets.symmetric(
        horizontal: 22,
        vertical: 10,
      ),
      decoration: pw.BoxDecoration(
        color: dark
            ? PdfColors.grey900
            : PdfColors.grey100,
        border: pw.Border.all(
          color: dark
              ? accent
              : PdfColors.grey300,
          width: .8,
        ),
        borderRadius:
            pw.BorderRadius.circular(5),
      ),
      child: pw.Column(
        children: [
          pw.Text(
            'IN RECOGNITION OF',
            style: _pText(
              size: 6,
              color: dark ? accent : primary,
              weight: pw.FontWeight.bold,
              letterSpacing: 1.4,
            ),
          ),
          pw.SizedBox(height: 5),
          pw.Text(
            text,
            textAlign: pw.TextAlign.center,
            maxLines: 5,
            style: _pText(
              size: 8.2,
              color: dark
                  ? PdfColors.white
                  : PdfColors.grey800,
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // PDF SEAL
  // ===========================================================================

  pw.Widget _pdfSeal({
    required PdfColor primary,
    required PdfColor accent,
    bool dark = false,
  }) {
    return pw.Container(
      width: 68,
      height: 68,
      decoration: pw.BoxDecoration(
        shape: pw.BoxShape.circle,
        color: dark ? accent : primary,
        border: pw.Border.all(
          color: dark ? primary : accent,
          width: 3,
        ),
      ),
      child: pw.Center(
        child: pw.Container(
          width: 54,
          height: 54,
          decoration: pw.BoxDecoration(
            shape: pw.BoxShape.circle,
            border: pw.Border.all(
              color: dark ? primary : PdfColors.white,
              width: 1,
            ),
          ),
          child: pw.Center(
            child: pw.Column(
              mainAxisAlignment:
                  pw.MainAxisAlignment.center,
              children: [
                pw.Text(
                  'HSE',
                  style: _pText(
                    size: 11,
                    color: dark ? primary : PdfColors.white,
                    weight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 2),
                pw.Text(
                  'SAFETY',
                  style: _pText(
                    size: 5.5,
                    color: dark ? primary : PdfColors.white,
                    weight: pw.FontWeight.bold,
                    letterSpacing: .8,
                  ),
                ),
                pw.Text(
                  'EXCELLENCE',
                  style: _pText(
                    size: 4.5,
                    color: dark ? primary : PdfColors.white,
                    weight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 1),
                pw.Text(
                  '★',
                  style: _pText(
                    size: 6,
                    color: dark ? primary : PdfColors.white,
                    weight: pw.FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // PDF META
  // ===========================================================================

  pw.Widget _pdfMeta({
    required String value,
    required String label,
    required PdfColor primary,
    required PdfColor accent,
    bool dark = false,
  }) {
    return pw.SizedBox(
      width: 145,
      child: pw.Column(
        children: [
          pw.Container(
            width: 135,
            height: 1,
            color: dark ? PdfColors.white : primary,
          ),
          pw.SizedBox(height: 5),
          pw.Text(
            _limitText(value, 32),
            textAlign: pw.TextAlign.center,
            maxLines: 2,
            style: _pText(
              size: 7.5,
              color: dark
                  ? PdfColors.white
                  : PdfColors.black,
              weight: pw.FontWeight.bold,
            ),
          ),
          pw.SizedBox(height: 2),
          pw.Text(
            label,
            textAlign: pw.TextAlign.center,
            style: _pText(
              size: 5.5,
              color: dark ? accent : primary,
              weight: pw.FontWeight.bold,
              letterSpacing: .7,
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // PDF FOOTER
  // ===========================================================================

  pw.Widget _pdfFooter({
    required String footer,
    required PdfColor primary,
    required PdfColor accent,
    bool dark = false,
  }) {
    return pw.Container(
      width: double.infinity,
      padding: const pw.EdgeInsets.symmetric(
        vertical: 6,
        horizontal: 12,
      ),
      color: dark ? accent : primary,
      child: pw.Text(
        footer.isEmpty
            ? 'Identify. Report. Stay Safe.'
            : _limitText(footer, 100),
        textAlign: pw.TextAlign.center,
        maxLines: 2,
        style: _pText(
          size: 6.5,
          color: dark
              ? primary
              : PdfColors.white,
          weight: pw.FontWeight.bold,
          letterSpacing: .9,
        ),
      ),
    );
  }

  // ===========================================================================
  // PDF CORNER ORNAMENT
  // ===========================================================================

  pw.Widget _pdfCorner({
    required PdfColor color,
    required bool top,
    required bool left,
  }) {
    return pw.Positioned(
      top: top ? 4 : null,
      bottom: top ? null : 4,
      left: left ? 4 : null,
      right: left ? null : 4,
      child: pw.Container(
        width: 20,
        height: 20,
        decoration: pw.BoxDecoration(
          border: pw.Border(
            top: top
                ? pw.BorderSide(
                    color: color,
                    width: 1.5,
                  )
                : pw.BorderSide.none,
            bottom: !top
                ? pw.BorderSide(
                    color: color,
                    width: 1.5,
                  )
                : pw.BorderSide.none,
            left: left
                ? pw.BorderSide(
                    color: color,
                    width: 1.5,
                  )
                : pw.BorderSide.none,
            right: !left
                ? pw.BorderSide(
                    color: color,
                    width: 1.5,
                  )
                : pw.BorderSide.none,
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // TEMPLATE 1 — ROYAL HSE
  // ===========================================================================

  pw.Widget _pdfRoyal({
    required String company,
    required String name,
    required String id,
    required String department,
    required String achievement,
    required String signatory,
    required String footer,
    required PdfColor primary,
    required PdfColor accent,
  }) {
    return pw.Container(
      color: PdfColors.white,
      padding: const pw.EdgeInsets.all(13),
      child: pw.Stack(
        children: [
          pw.Container(
            decoration: pw.BoxDecoration(
              border: pw.Border.all(
                color: primary,
                width: 4,
              ),
            ),
            padding: const pw.EdgeInsets.all(5),
            child: pw.Container(
              decoration: pw.BoxDecoration(
                border: pw.Border.all(
                  color: accent,
                  width: 1.2,
                ),
              ),
              padding: const pw.EdgeInsets.symmetric(
                horizontal: 28,
                vertical: 14,
              ),
              child: pw.Column(
                children: [
                  _pdfBrand(
                    company: company,
                    primary: primary,
                    accent: accent,
                    centered: true,
                  ),
                  pw.SizedBox(height: 7),
                  pw.Text(
                    'HSE • SAFETY • INTEGRITY • EXCELLENCE',
                    style: _pText(
                      size: 5.5,
                      color: accent,
                      weight: pw.FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                  pw.SizedBox(height: 7),
                  _pdfTitle(
                    subtitle: 'OF SAFETY EXCELLENCE',
                    primary: primary,
                    accent: accent,
                  ),
                  pw.SizedBox(height: 11),
                  _pdfRecipient(
                    name: name,
                    primary: primary,
                    accent: accent,
                  ),
                  _pdfDetails(
                    id: id,
                    department: department,
                  ),
                  pw.SizedBox(height: 9),
                  _pdfAchievement(
                    achievement: achievement,
                    primary: primary,
                    accent: accent,
                  ),
                  pw.SizedBox(height: 9),
                  pw.Row(
                    mainAxisAlignment:
                        pw.MainAxisAlignment.spaceBetween,
                    crossAxisAlignment:
                        pw.CrossAxisAlignment.end,
                    children: [
                      _pdfMeta(
                        value: formattedDate,
                        label: 'DATE OF AWARD',
                        primary: primary,
                        accent: accent,
                      ),
                      _pdfSeal(
                        primary: primary,
                        accent: accent,
                      ),
                      _pdfMeta(
                        value: signatory,
                        label: 'AUTHORIZED SIGNATORY',
                        primary: primary,
                        accent: accent,
                      ),
                    ],
                  ),
                  pw.SizedBox(height: 8),
                  _pdfFooter(
                    footer: footer,
                    primary: primary,
                    accent: accent,
                  ),
                ],
              ),
            ),
          ),
          _pdfCorner(
            color: accent,
            top: true,
            left: true,
          ),
          _pdfCorner(
            color: accent,
            top: true,
            left: false,
          ),
          _pdfCorner(
            color: accent,
            top: false,
            left: true,
          ),
          _pdfCorner(
            color: accent,
            top: false,
            left: false,
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // TEMPLATE 2 — EXECUTIVE
  // ===========================================================================

  pw.Widget _pdfExecutive({
    required String company,
    required String name,
    required String id,
    required String department,
    required String achievement,
    required String signatory,
    required String footer,
    required PdfColor primary,
    required PdfColor accent,
  }) {
    return pw.Container(
      color: PdfColors.white,
      child: pw.Stack(
        children: [
          pw.Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            child: pw.Container(
              width: 16,
              color: primary,
            ),
          ),
          pw.Positioned(
            right: 0,
            top: 0,
            child: pw.Container(
              width: 180,
              height: 100,
              decoration: pw.BoxDecoration(
                color: primary,
                borderRadius:
                    const pw.BorderRadius.only(
                  bottomLeft:
                      pw.Radius.circular(100),
                ),
              ),
            ),
          ),
          pw.Positioned(
            right: 0,
            bottom: 0,
            child: pw.Container(
              width: 120,
              height: 48,
              decoration: pw.BoxDecoration(
                color: accent,
                borderRadius:
                    const pw.BorderRadius.only(
                  topLeft:
                      pw.Radius.circular(65),
                ),
              ),
            ),
          ),
          pw.Padding(
            padding: const pw.EdgeInsets.fromLTRB(
              38,
              21,
              38,
              15,
            ),
            child: pw.Column(
              crossAxisAlignment:
                  pw.CrossAxisAlignment.start,
              children: [
                _pdfBrand(
                  company: company,
                  primary: primary,
                  accent: accent,
                ),
                pw.SizedBox(height: 13),
                pw.Text(
                  'CERTIFICATE',
                  style: _pText(
                    size: 31,
                    color: primary,
                    weight: pw.FontWeight.bold,
                    letterSpacing: 1.8,
                  ),
                ),
                pw.Text(
                  'OF PROFESSIONAL SAFETY ACHIEVEMENT',
                  style: _pText(
                    size: 8,
                    color: accent,
                    weight: pw.FontWeight.bold,
                    letterSpacing: 1.1,
                  ),
                ),
                pw.SizedBox(height: 7),
                pw.Container(
                  width: 85,
                  height: 3,
                  color: accent,
                ),
                pw.SizedBox(height: 11),
                pw.Text(
                  'THIS CERTIFICATE IS AWARDED TO',
                  style: _pText(
                    size: 6,
                    color: PdfColors.grey600,
                    weight: pw.FontWeight.bold,
                    letterSpacing: .9,
                  ),
                ),
                pw.SizedBox(height: 3),
                pw.Text(
                  _limitText(name, 55),
                  maxLines: 2,
                  style: _pText(
                    size: 27,
                    color: primary,
                    weight: pw.FontWeight.bold,
                  ),
                ),
                _pdfDetails(
                  id: id,
                  department: department,
                ),
                pw.SizedBox(height: 10),
                _pdfAchievement(
                  achievement: achievement,
                  primary: primary,
                  accent: accent,
                ),
                pw.SizedBox(height: 10),
                pw.Row(
                  mainAxisAlignment:
                      pw.MainAxisAlignment.spaceBetween,
                  crossAxisAlignment:
                      pw.CrossAxisAlignment.end,
                  children: [
                    _pdfMeta(
                      value: formattedDate,
                      label: 'DATE OF AWARD',
                      primary: primary,
                      accent: accent,
                    ),
                    _pdfMeta(
                      value: signatory,
                      label: 'AUTHORIZED SIGNATORY',
                      primary: primary,
                      accent: accent,
                    ),
                  ],
                ),
                pw.SizedBox(height: 8),
                _pdfFooter(
                  footer: footer,
                  primary: primary,
                  accent: accent,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // TEMPLATE 3 — ELEGANT GOLD
  // ===========================================================================

  pw.Widget _pdfElegant({
    required String company,
    required String name,
    required String id,
    required String department,
    required String achievement,
    required String signatory,
    required String footer,
    required PdfColor primary,
    required PdfColor accent,
  }) {
    return pw.Container(
      color: _pdfColor(_cream),
      padding: const pw.EdgeInsets.all(12),
      child: pw.Container(
        decoration: pw.BoxDecoration(
          border: pw.Border.all(
            color: accent,
            width: 4,
          ),
        ),
        padding: const pw.EdgeInsets.all(5),
        child: pw.Container(
          decoration: pw.BoxDecoration(
            border: pw.Border.all(
              color: primary,
              width: 1.3,
            ),
          ),
          padding: const pw.EdgeInsets.symmetric(
            horizontal: 28,
            vertical: 13,
          ),
          child: pw.Column(
            children: [
              pw.Text(
                'HSE • SAFETY • INTEGRITY • EXCELLENCE',
                style: _pText(
                  size: 5.5,
                  color: accent,
                  weight: pw.FontWeight.bold,
                  letterSpacing: .9,
                ),
              ),
              pw.SizedBox(height: 4),
              _pdfBrand(
                company: company,
                primary: primary,
                accent: accent,
                centered: true,
              ),
              pw.SizedBox(height: 7),
              _ornament(
                accent,
                width: 42,
              ),
              pw.SizedBox(height: 6),
              _pdfTitle(
                subtitle: 'OF ACHIEVEMENT',
                primary: primary,
                accent: accent,
                goldTitle: true,
              ),
              pw.SizedBox(height: 10),
              _pdfRecipient(
                name: name,
                primary: primary,
                accent: accent,
              ),
              _pdfDetails(
                id: id,
                department: department,
              ),
              pw.SizedBox(height: 8),
              _pdfAchievement(
                achievement: achievement,
                primary: primary,
                accent: accent,
              ),
              pw.SizedBox(height: 8),
              pw.Row(
                mainAxisAlignment:
                    pw.MainAxisAlignment.spaceBetween,
                crossAxisAlignment:
                    pw.CrossAxisAlignment.end,
                children: [
                  _pdfMeta(
                    value: formattedDate,
                    label: 'DATE OF AWARD',
                    primary: primary,
                    accent: accent,
                  ),
                  _pdfSeal(
                    primary: primary,
                    accent: accent,
                  ),
                  _pdfMeta(
                    value: signatory,
                    label: 'AUTHORIZED SIGNATORY',
                    primary: primary,
                    accent: accent,
                  ),
                ],
              ),
              pw.SizedBox(height: 8),
              _pdfFooter(
                footer: footer,
                primary: primary,
                accent: accent,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // TEMPLATE 4 — UAE SAFETY
  // ===========================================================================

  pw.Widget _pdfUae({
    required String company,
    required String name,
    required String id,
    required String department,
    required String achievement,
    required String signatory,
    required String footer,
    required PdfColor primary,
    required PdfColor accent,
  }) {
    return pw.Container(
      color: PdfColors.grey100,
      padding: const pw.EdgeInsets.all(11),
      child: pw.Container(
        color: PdfColors.white,
        child: pw.Column(
          children: [
            pw.Container(
              width: double.infinity,
              padding: const pw.EdgeInsets.symmetric(
                horizontal: 25,
                vertical: 11,
              ),
              color: primary,
              child: pw.Column(
                children: [
                  _pdfBrand(
                    company: company,
                    primary: primary,
                    accent: accent,
                    dark: true,
                    centered: true,
                  ),
                  pw.SizedBox(height: 4),
                  pw.Text(
                    'UNITED ARAB EMIRATES',
                    style: _pText(
                      size: 6.5,
                      color: accent,
                      weight: pw.FontWeight.bold,
                      letterSpacing: 1.8,
                    ),
                  ),
                ],
              ),
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.fromLTRB(
                26,
                12,
                26,
                10,
              ),
              child: pw.Column(
                children: [
                  pw.Text(
                    'SAFETY • PEOPLE • SUSTAINABILITY',
                    style: _pText(
                      size: 5.5,
                      color: accent,
                      weight: pw.FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                  pw.SizedBox(height: 3),
                  _pdfTitle(
                    subtitle: 'OF SAFETY PARTICIPATION',
                    primary: primary,
                    accent: accent,
                  ),
                  pw.SizedBox(height: 8),
                  pw.Container(
                    width: double.infinity,
                    padding: const pw.EdgeInsets.all(8),
                    decoration: pw.BoxDecoration(
                      border: pw.Border.all(
                        color: primary,
                        width: 1,
                      ),
                      borderRadius:
                          pw.BorderRadius.circular(5),
                    ),
                    child: _pdfRecipient(
                      name: name,
                      primary: primary,
                      accent: accent,
                    ),
                  ),
                  _pdfDetails(
                    id: id,
                    department: department,
                  ),
                  pw.SizedBox(height: 8),
                  _pdfAchievement(
                    achievement: achievement,
                    primary: primary,
                    accent: accent,
                  ),
                  pw.SizedBox(height: 7),
                  pw.Container(
                    width: double.infinity,
                    padding: const pw.EdgeInsets.symmetric(
                      vertical: 6,
                    ),
                    decoration: pw.BoxDecoration(
                      color: PdfColors.grey100,
                      border: pw.Border.all(
                        color: accent,
                        width: .7,
                      ),
                    ),
                    child: pw.Text(
                      'TOGETHER FOR A SAFER UAE',
                      textAlign: pw.TextAlign.center,
                      style: _pText(
                        size: 8,
                        color: primary,
                        weight: pw.FontWeight.bold,
                        letterSpacing: 1.1,
                      ),
                    ),
                  ),
                  pw.SizedBox(height: 8),
                  pw.Row(
                    mainAxisAlignment:
                        pw.MainAxisAlignment.spaceBetween,
                    crossAxisAlignment:
                        pw.CrossAxisAlignment.end,
                    children: [
                      _pdfMeta(
                        value: formattedDate,
                        label: 'DATE',
                        primary: primary,
                        accent: accent,
                      ),
                      _pdfMeta(
                        value: signatory,
                        label: 'HSE MANAGER',
                        primary: primary,
                        accent: accent,
                      ),
                      if (id.isNotEmpty)
                        _pdfMeta(
                          value: id,
                          label: 'CERTIFICATE ID',
                          primary: primary,
                          accent: accent,
                        ),
                    ],
                  ),
                ],
              ),
            ),
            _pdfFooter(
              footer: footer,
              primary: primary,
              accent: accent,
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // TEMPLATE 5 — MIDNIGHT
  // ===========================================================================

  pw.Widget _pdfNight({
    required String company,
    required String name,
    required String id,
    required String department,
    required String achievement,
    required String signatory,
    required String footer,
    required PdfColor primary,
    required PdfColor accent,
  }) {
    return pw.Container(
      color: primary,
      padding: const pw.EdgeInsets.all(12),
      child: pw.Stack(
        children: [
          pw.Container(
            decoration: pw.BoxDecoration(
              color: primary,
              border: pw.Border.all(
                color: accent,
                width: 3,
              ),
            ),
            padding: const pw.EdgeInsets.all(5),
            child: pw.Container(
              decoration: pw.BoxDecoration(
                color: primary,
                border: pw.Border.all(
                  color: accent,
                  width: 1,
                ),
              ),
              padding: const pw.EdgeInsets.symmetric(
                horizontal: 28,
                vertical: 14,
              ),
              child: pw.Column(
                children: [
                  _pdfBrand(
                    company: company,
                    primary: primary,
                    accent: accent,
                    dark: true,
                    centered: true,
                  ),
                  pw.SizedBox(height: 6),
                  pw.Text(
                    'SAFER PEOPLE • CLEANER ENVIRONMENT • STRONGER FUTURE',
                    textAlign: pw.TextAlign.center,
                    style: _pText(
                      size: 5,
                      color: accent,
                      weight: pw.FontWeight.bold,
                      letterSpacing: .8,
                    ),
                  ),
                  pw.SizedBox(height: 7),
                  _pdfTitle(
                    subtitle: 'OF SAFETY EXCELLENCE',
                    primary: primary,
                    accent: accent,
                    dark: true,
                  ),
                  pw.SizedBox(height: 11),
                  _pdfRecipient(
                    name: name,
                    primary: primary,
                    accent: accent,
                    dark: true,
                  ),
                  _pdfDetails(
                    id: id,
                    department: department,
                    dark: true,
                  ),
                  pw.SizedBox(height: 9),
                  _pdfAchievement(
                    achievement: achievement,
                    primary: primary,
                    accent: accent,
                    dark: true,
                  ),
                  pw.SizedBox(height: 9),
                  pw.Row(
                    mainAxisAlignment:
                        pw.MainAxisAlignment.spaceBetween,
                    crossAxisAlignment:
                        pw.CrossAxisAlignment.end,
                    children: [
                      _pdfMeta(
                        value: formattedDate,
                        label: 'DATE OF AWARD',
                        primary: primary,
                        accent: accent,
                        dark: true,
                      ),
                      _pdfSeal(
                        primary: primary,
                        accent: accent,
                        dark: true,
                      ),
                      _pdfMeta(
                        value: signatory,
                        label: 'AUTHORIZED SIGNATORY',
                        primary: primary,
                        accent: accent,
                        dark: true,
                      ),
                    ],
                  ),
                  pw.SizedBox(height: 8),
                  _pdfFooter(
                    footer: footer,
                    primary: primary,
                    accent: accent,
                    dark: true,
                  ),
                ],
              ),
            ),
          ),
          _pdfCorner(
            color: accent,
            top: true,
            left: true,
          ),
          _pdfCorner(
            color: accent,
            top: true,
            left: false,
          ),
          _pdfCorner(
            color: accent,
            top: false,
            left: true,
          ),
          _pdfCorner(
            color: accent,
            top: false,
            left: false,
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // PDF COLOR CONVERSION
  // ===========================================================================

  PdfColor _pdfColor(Color color) {
    return PdfColor.fromInt(color.toARGB32());
  }

  // ===========================================================================
  // PDF CREATION
  // ===========================================================================

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
        _cleanMultiline(_achievementController.text);

    final signatory = _clean(
      _signatoryController.text,
      fallback: 'HSE Manager',
    );

    final footer = _clean(
      _footerController.text,
      fallback: 'Identify. Report. Stay Safe.',
    );

    final primary = _pdfColor(_green);
    final accent = _pdfColor(_gold);

    late pw.Widget certificate;

    switch (selectedTemplate) {
      case 1:
        certificate = _pdfExecutive(
          company: company,
          name: name,
          id: id,
          department: department,
          achievement: achievement,
          signatory: signatory,
          footer: footer,
          primary: primary,
          accent: accent,
        );
        break;

      case 2:
        certificate = _pdfElegant(
          company: company,
          name: name,
          id: id,
          department: department,
          achievement: achievement,
          signatory: signatory,
          footer: footer,
          primary: primary,
          accent: accent,
        );
        break;

      case 3:
        certificate = _pdfUae(
          company: company,
          name: name,
          id: id,
          department: department,
          achievement: achievement,
          signatory: signatory,
          footer: footer,
          primary: primary,
          accent: accent,
        );
        break;

      case 4:
        certificate = _pdfNight(
          company: company,
          name: name,
          id: id,
          department: department,
          achievement: achievement,
          signatory: signatory,
          footer: footer,
          primary: primary,
          accent: accent,
        );
        break;

      default:
        certificate = _pdfRoyal(
          company: company,
          name: name,
          id: id,
          department: department,
          achievement: achievement,
          signatory: signatory,
          footer: footer,
          primary: primary,
          accent: accent,
        );
    }

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4.landscape,
        margin: pw.EdgeInsets.zero,
        build: (_) => certificate,
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

    final file = File(
      '${directory.path}/$fileName',
    );

    final bytes = await pdf.save();

    await file.writeAsBytes(
      bytes,
      flush: true,
    );

    return file;
  }

  // ===========================================================================
  // SAVE PDF
  // ===========================================================================

  Future<void> _saveCertificatePdf() async {
    if (_isGeneratingPdf) return;

    setState(() {
      _isGeneratingPdf = true;
    });

    try {
      final file = await _createCertificatePdf();

      if (!mounted) return;

      setState(() {
        _lastSavedPath = file.path;
      });

      await showDialog<void>(
        context: context,
        builder: (dialogContext) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            title: const Row(
              children: [
                Icon(
                  Icons.verified_rounded,
                  color: _green,
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text('Certificate Ready'),
                ),
              ],
            ),
            content: const Text(
              'Your premium HSE certificate PDF '
              'has been created successfully.',
            ),
            actions: [
              TextButton(
                onPressed: () =>
                    Navigator.pop(dialogContext),
                child: const Text('Close'),
              ),
              FilledButton.icon(
                onPressed: () async {
                  Navigator.pop(dialogContext);

                  final path = _lastSavedPath;

                  if (path == null) {
                    _message(
                      'Certificate PDF is not available.',
                      error: true,
                    );
                    return;
                  }

                  await _shareExistingCertificatePdf(
                    path,
                  );
                },
                icon: const Icon(Icons.share),
                label: const Text('Share'),
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

  // ===========================================================================
  // SHARE EXISTING PDF
  // ===========================================================================

  Future<void> _shareExistingCertificatePdf(
    String path,
  ) async {
    try {
      final file = File(path);

      if (!await file.exists()) {
        if (mounted) {
          setState(() {
            _lastSavedPath = null;
          });
        }

        _message(
          'Certificate PDF could not be found. '
          'Please create it again.',
          error: true,
        );

        return;
      }

      await Share.shareXFiles(
        [
          XFile(
            file.path,
            name: file.uri.pathSegments.last,
            mimeType: 'application/pdf',
          ),
        ],
        subject: 'SafeNexus HSE Certificate',
        text:
            'Certificate generated by SafeNexus HSE.',
      );
    } catch (e) {
      _message(
        'Could not share PDF: $e',
        error: true,
      );
    }
  }

  // ===========================================================================
  // SHARE PDF
  // ===========================================================================

  Future<void> _shareCertificatePdf() async {
    if (_isGeneratingPdf) return;

    setState(() {
      _isGeneratingPdf = true;
    });

    try {
      File file;

      if (_lastSavedPath != null &&
          await File(_lastSavedPath!).exists()) {
        file = File(_lastSavedPath!);
      } else {
        file = await _createCertificatePdf();

        if (mounted) {
          setState(() {
            _lastSavedPath = file.path;
          });
        }
      }

      await _shareExistingCertificatePdf(
        file.path,
      );
    } catch (e) {
      _message(
        'Could not prepare PDF for sharing: $e',
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

  // ===========================================================================
  // UI FIELD
  // ===========================================================================

  Widget _field({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        textCapitalization:
            TextCapitalization.sentences,
        onChanged: (_) => _markDirty(),
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(
            icon,
            color: _green,
          ),
          filled: true,
          fillColor: const Color(0xFFFCFDFC),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13),
            borderSide: BorderSide(
              color: Colors.grey.shade300,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13),
            borderSide: const BorderSide(
              color: _green,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // SECTION HEADER
  // ===========================================================================

  Widget _sectionTitle(
    IconData icon,
    String title,
    String subtitle,
  ) {
    return Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xFFE8F4EE),
                Color(0xFFF7FBF8),
              ],
            ),
            borderRadius:
                BorderRadius.circular(13),
          ),
          child: Icon(
            icon,
            color: _green,
          ),
        ),
        const SizedBox(width: 11),
        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                  color: _ink,
                ),
              ),
              const SizedBox(height: 2),
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

  // ===========================================================================
  // TEMPLATE CARD
  // ===========================================================================

  Widget _templateCard(int index) {
    final selected =
        selectedTemplate == index;

    const primaryColors = [
      _green,
      _green,
      _gold,
      _green,
      _darkGreen,
    ];

    const accentColors = [
      _gold,
      Colors.blueGrey,
      _green,
      Colors.teal,
      _gold,
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
              const EdgeInsets.only(right: 6),
          padding:
              const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: selected
                ? primaryColors[index]
                    .withValues(alpha: .07)
                : Colors.white,
            borderRadius:
                BorderRadius.circular(14),
            border: Border.all(
              color: selected
                  ? primaryColors[index]
                  : Colors.grey.shade300,
              width: selected ? 2 : 1,
            ),
          ),
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 1.414,
                child: _miniTemplate(
                  index,
                  primaryColors[index],
                  accentColors[index],
                ),
              ),
              const SizedBox(height: 6),
              Text(
                '${index + 1}. ${templateNames[index]}',
                textAlign: TextAlign.center,
                maxLines: 2,
                style: TextStyle(
                  fontSize: 8.5,
                  fontWeight: selected
                      ? FontWeight.w800
                      : FontWeight.w600,
                  color: selected
                      ? primaryColors[index]
                      : _ink,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // MINI TEMPLATE
  // ===========================================================================

  Widget _miniTemplate(
    int index,
    Color primary,
    Color accent,
  ) {
    if (index == 0) {
      return Container(
        color: _cream,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          border: Border.all(
            color: primary,
            width: 3,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: accent,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center,
              children: [
                const Text(
                  'SAFENEXUS HSE',
                  style: TextStyle(
                    color: _green,
                    fontSize: 4.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  'CERTIFICATE',
                  style: TextStyle(
                    color: primary,
                    fontSize: 8.5,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1,
                  ),
                ),
                Container(
                  width: 34,
                  height: 1,
                  color: accent,
                ),
              ],
            ),
          ),
        ),
      );
    }

    if (index == 1) {
      return Container(
        color: Colors.white,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: Container(
                width: 6,
                color: primary,
              ),
            ),
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                width: 48,
                height: 34,
                decoration: const BoxDecoration(
                  color: _green,
                  borderRadius:
                      BorderRadius.only(
                    bottomLeft:
                        Radius.circular(38),
                  ),
                ),
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: 35,
                height: 13,
                decoration: const BoxDecoration(
                  color: _gold,
                  borderRadius:
                      BorderRadius.only(
                    topLeft:
                        Radius.circular(25),
                  ),
                ),
              ),
            ),
            Center(
              child: Text(
                'CERTIFICATE',
                style: TextStyle(
                  color: primary,
                  fontSize: 8.5,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ],
        ),
      );
    }

    if (index == 2) {
      return Container(
        color: _cream,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          border: Border.all(
            color: accent,
            width: 3,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: primary,
            ),
          ),
          child: Center(
            child: Text(
              'CERTIFICATE',
              style: TextStyle(
                color: accent,
                fontSize: 8.5,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),
      );
    }

    if (index == 3) {
      return Container(
        color: Colors.white,
        child: Column(
          children: [
            Container(
              height: 13,
              color: primary,
            ),
            const Spacer(),
            Text(
              'UNITED ARAB EMIRATES',
              style: TextStyle(
                color: primary,
                fontSize: 4.5,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              'CERTIFICATE',
              style: TextStyle(
                color: accent,
                fontSize: 8.5,
                fontWeight: FontWeight.w900,
              ),
            ),
            const Spacer(),
            Container(
              height: 9,
              color: primary,
            ),
          ],
        ),
      );
    }

    return Container(
      color: _deepGreen,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        border: Border.all(
          color: accent,
          width: 2,
        ),
      ),
      child: Center(
        child: Text(
          'CERTIFICATE',
          style: TextStyle(
            color: accent,
            fontSize: 8.5,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // PREVIEW BRAND
  // ===========================================================================

  Widget _previewBrand({
    bool dark = false,
  }) {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.center,
      children: [
        Container(
          width: 35,
          height: 35,
          decoration: BoxDecoration(
            color: dark ? _gold : _green,
            shape: BoxShape.circle,
            border: Border.all(
              color: dark ? _green : _gold,
              width: 1.5,
            ),
          ),
          child: Center(
            child: Text(
              'S',
              style: TextStyle(
                color: dark
                    ? _darkGreen
                    : Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),
        const SizedBox(width: 7),
        Flexible(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                _clean(
                  _companyController.text,
                  fallback: 'SafeNexus HSE',
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color:
                      dark ? Colors.white : _green,
                  fontSize: 11,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Text(
                'HSE • SAFETY • OBSERVATION',
                style: TextStyle(
                  color: dark
                      ? Colors.white70
                      : Colors.black54,
                  fontSize: 5,
                  fontWeight: FontWeight.bold,
                  letterSpacing: .5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // PREVIEW TITLE
  // ===========================================================================

  Widget _previewTitle(
    String subtitle, {
    bool dark = false,
    bool goldTitle = false,
  }) {
    final color = goldTitle
        ? _gold
        : (dark ? _gold : _green);

    return Column(
      children: [
        Text(
          'CERTIFICATE',
          style: TextStyle(
            color: color,
            fontSize: 18,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.5,
          ),
        ),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: dark
                ? Colors.white
                : _gold,
            fontSize: 5.5,
            fontWeight: FontWeight.w900,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 3),
        Container(
          width: 85,
          height: 1,
          color: color,
        ),
      ],
    );
  }

  // ===========================================================================
  // PREVIEW RECIPIENT
  // ===========================================================================

  Widget _previewRecipient(
    String name, {
    bool dark = false,
  }) {
    return Column(
      children: [
        Text(
          'PROUDLY PRESENTED TO',
          style: TextStyle(
            color: dark
                ? Colors.white70
                : Colors.black54,
            fontSize: 4.5,
            fontWeight: FontWeight.bold,
            letterSpacing: .8,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          name,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: dark ? _gold : _green,
            fontSize: 17,
            fontWeight: FontWeight.w900,
          ),
        ),
        Container(
          width: 165,
          height: 1,
          color: dark ? _gold : _green,
        ),
      ],
    );
  }

  // ===========================================================================
  // PREVIEW DETAILS
  // ===========================================================================

  Widget _previewDetails(
    String id,
    String department, {
    bool dark = false,
  }) {
    if (id.isEmpty && department.isEmpty) {
      return const SizedBox(height: 2);
    }

    final values = <String>[];

    if (id.isNotEmpty) {
      values.add('ID: $id');
    }

    if (department.isNotEmpty) {
      values.add('Department: $department');
    }

    return Padding(
      padding: const EdgeInsets.only(top: 3),
      child: Text(
        values.join('  •  '),
        textAlign: TextAlign.center,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: dark
              ? Colors.white70
              : Colors.black54,
          fontSize: 4.5,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  // ===========================================================================
  // PREVIEW ACHIEVEMENT
  // ===========================================================================

  Widget _previewAchievement({
    required String achievement,
    bool dark = false,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: dark
            ? Colors.white.withValues(alpha: .05)
            : Colors.grey.shade100,
        border: Border.all(
          color: dark
              ? _gold.withValues(alpha: .6)
              : Colors.grey.shade300,
        ),
        borderRadius:
            BorderRadius.circular(5),
      ),
      child: Column(
        children: [
          Text(
            'IN RECOGNITION OF',
            style: TextStyle(
              color: dark ? _gold : _green,
              fontSize: 4.2,
              fontWeight: FontWeight.w900,
              letterSpacing: .7,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            achievement.isEmpty
                ? 'Outstanding commitment to safety.'
                : achievement,
            textAlign: TextAlign.center,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: dark
                  ? Colors.white
                  : Colors.black87,
              fontSize: 5.5,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // PREVIEW SEAL
  // ===========================================================================

  Widget _previewSeal({
    bool dark = false,
  }) {
    return Container(
      width: 47,
      height: 47,
      decoration: BoxDecoration(
        color: dark ? _gold : _green,
        shape: BoxShape.circle,
        border: Border.all(
          color: dark ? _green : _gold,
          width: 2,
        ),
      ),
      child: Center(
        child: Container(
          width: 37,
          height: 37,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: dark
                  ? _darkGreen
                  : Colors.white,
            ),
          ),
          child: Center(
            child: Text(
              'HSE\nSAFETY',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: dark
                    ? _darkGreen
                    : Colors.white,
                fontSize: 4.7,
                fontWeight: FontWeight.w900,
                height: 1.1,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // PREVIEW META
  // ===========================================================================

  Widget _previewMeta(
    String value,
    String label, {
    bool dark = false,
  }) {
    return SizedBox(
      width: 78,
      child: Column(
        children: [
          Container(
            height: 1,
            color: dark
                ? Colors.white54
                : Colors.black38,
          ),
          const SizedBox(height: 3),
          Text(
            value,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: dark
                  ? Colors.white
                  : Colors.black87,
              fontSize: 4.8,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 1),
          Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: dark ? _gold : _green,
              fontSize: 4,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // PREVIEW FOOTER
  // ===========================================================================

  Widget _previewFooter({
    required String footer,
    bool dark = false,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 4,
      ),
      color: dark ? _gold : _green,
      child: Text(
        footer,
        textAlign: TextAlign.center,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: dark
              ? _darkGreen
              : Colors.white,
          fontSize: 4.7,
          fontWeight: FontWeight.w900,
          letterSpacing: .6,
        ),
      ),
    );
  }

  // ===========================================================================
  // PREVIEW FRAME
  // ===========================================================================

  Widget _previewFrame({
    required Widget child,
    bool dark = false,
    Color? outerBorder,
  }) {
    return AspectRatio(
      aspectRatio: 1.414,
      child: Container(
        color:
            dark ? _darkGreen : Colors.white,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color:
              dark ? _darkGreen : Colors.white,
          border: Border.all(
            color: outerBorder ??
                (dark ? _gold : _green),
            width: 3,
          ),
          boxShadow: const [
            BoxShadow(
              blurRadius: 10,
              offset: Offset(0, 4),
              color: Colors.black12,
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            color:
                dark ? _darkGreen : Colors.white,
            border: Border.all(
              color: dark
                  ? _gold
                  : _gold.withValues(alpha: .8),
              width: 1,
            ),
          ),
          child: child,
        ),
      ),
    );
  }

  // ===========================================================================
  // PREVIEW ROYAL
  // ===========================================================================

  Widget _previewRoyal(
    String name,
    String achievement,
    String id,
    String department,
    String signatory,
    String footer,
  ) {
    return _previewFrame(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 7,
        ),
        child: Column(
          children: [
            _previewBrand(),
            const SizedBox(height: 3),
            _previewTitle(
              'OF SAFETY EXCELLENCE',
            ),
            const SizedBox(height: 6),
            _previewRecipient(name),
            _previewDetails(
              id,
              department,
            ),
            const SizedBox(height: 5),
            _previewAchievement(
              achievement: achievement,
            ),
            const Spacer(),
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
            const SizedBox(height: 4),
            _previewFooter(
              footer: footer,
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // PREVIEW EXECUTIVE
  // ===========================================================================

  Widget _previewExecutive(
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
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: Container(
                width: 7,
                color: _green,
              ),
            ),
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                width: 82,
                height: 57,
                decoration: const BoxDecoration(
                  color: _green,
                  borderRadius:
                      BorderRadius.only(
                    bottomLeft:
                        Radius.circular(63),
                  ),
                ),
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: 62,
                height: 27,
                decoration: const BoxDecoration(
                  color: _gold,
                  borderRadius:
                      BorderRadius.only(
                    topLeft:
                        Radius.circular(43),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                21,
                12,
                21,
                7,
              ),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  _previewBrand(),
                  const SizedBox(height: 6),
                  const Text(
                    'CERTIFICATE',
                    style: TextStyle(
                      color: _green,
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const Text(
                    'OF PROFESSIONAL SAFETY ACHIEVEMENT',
                    style: TextStyle(
                      color: _gold,
                      fontSize: 5.2,
                      fontWeight: FontWeight.w900,
                      letterSpacing: .7,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    width: 58,
                    height: 2,
                    color: _gold,
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'THIS CERTIFICATE IS AWARDED TO',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 4.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: _green,
                      fontSize: 19,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  _previewDetails(
                    id,
                    department,
                  ),
                  const SizedBox(height: 5),
                  _previewAchievement(
                    achievement: achievement,
                  ),
                  const Spacer(),
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
                  const SizedBox(height: 4),
                  _previewFooter(
                    footer: footer,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // PREVIEW ELEGANT
  // ===========================================================================

  Widget _previewElegant(
    String name,
    String achievement,
    String id,
    String department,
    String signatory,
    String footer,
  ) {
    return _previewFrame(
      outerBorder: _gold,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 7,
        ),
        child: Column(
          children: [
            const Text(
              'HSE • SAFETY • INTEGRITY • EXCELLENCE',
              style: TextStyle(
                color: _gold,
                fontSize: 4.3,
                fontWeight: FontWeight.w900,
                letterSpacing: .5,
              ),
            ),
            const SizedBox(height: 2),
            _previewBrand(),
            const SizedBox(height: 3),
            _previewTitle(
              'OF ACHIEVEMENT',
              goldTitle: true,
            ),
            const SizedBox(height: 5),
            _previewRecipient(name),
            _previewDetails(
              id,
              department,
            ),
            const SizedBox(height: 5),
            _previewAchievement(
              achievement: achievement,
            ),
            const Spacer(),
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
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
            const SizedBox(height: 4),
            _previewFooter(
              footer: footer,
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // PREVIEW UAE
  // ===========================================================================

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
        color: Colors.grey.shade100,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.symmetric(
                vertical: 6,
              ),
              color: _green,
              child: _previewBrand(
                dark: true,
              ),
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 5,
                ),
                child: Column(
                  children: [
                    const Text(
                      'UNITED ARAB EMIRATES',
                      style: TextStyle(
                        color: _gold,
                        fontSize: 4.3,
                        fontWeight: FontWeight.w900,
                        letterSpacing: .9,
                      ),
                    ),
                    const SizedBox(height: 2),
                    _previewTitle(
                      'OF SAFETY PARTICIPATION',
                    ),
                    const SizedBox(height: 4),
                    Container(
                      width: double.infinity,
                      padding:
                          const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: _green,
                        ),
                        borderRadius:
                            BorderRadius.circular(5),
                      ),
                      child:
                          _previewRecipient(name),
                    ),
                    _previewDetails(
                      id,
                      department,
                    ),
                    const SizedBox(height: 5),
                    _previewAchievement(
                      achievement: achievement,
                    ),
                    const Spacer(),
                    Container(
                      width: double.infinity,
                      padding:
                          const EdgeInsets.symmetric(
                        vertical: 4,
                      ),
                      color: Colors.white,
                      child: const Text(
                        'TOGETHER FOR A SAFER UAE',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: _green,
                          fontSize: 6,
                          fontWeight: FontWeight.w900,
                          letterSpacing: .7,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
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
                            'CERTIFICATE ID',
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            _previewFooter(
              footer: footer,
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // PREVIEW NIGHT
  // ===========================================================================

  Widget _previewNight(
    String name,
    String achievement,
    String id,
    String department,
    String signatory,
    String footer,
  ) {
    return _previewFrame(
      dark: true,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 7,
        ),
        child: Column(
          children: [
            _previewBrand(
              dark: true,
            ),
            const SizedBox(height: 4),
            _previewTitle(
              'OF SAFETY EXCELLENCE',
              dark: true,
            ),
            const SizedBox(height: 6),
            _previewRecipient(
              name,
              dark: true,
            ),
            _previewDetails(
              id,
              department,
              dark: true,
            ),
            const SizedBox(height: 5),
            _previewAchievement(
              achievement: achievement,
              dark: true,
            ),
            const Spacer(),
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              children: [
                _previewMeta(
                  formattedDate,
                  'DATE',
                  dark: true,
                ),
                _previewSeal(
                  dark: true,
                ),
                _previewMeta(
                  signatory,
                  'AUTHORIZED SIGNATORY',
                  dark: true,
                ),
              ],
            ),
            const SizedBox(height: 4),
            _previewFooter(
              footer: footer,
              dark: true,
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // PREVIEW SELECTOR
  // ===========================================================================

  Widget _preview() {
    final name = _clean(
      _nameController.text,
      fallback: 'Employee Name',
    );

    final achievement =
        _cleanMultiline(
      _achievementController.text,
    );

    final id = _clean(_idController.text);

    final department =
        _clean(_departmentController.text);

    final signatory = _clean(
      _signatoryController.text,
      fallback: 'HSE Manager',
    );

    final footer = _clean(
      _footerController.text,
      fallback: 'Identify. Report. Stay Safe.',
    );

    switch (selectedTemplate) {
      case 1:
        return _previewExecutive(
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
        return _previewNight(
          name,
          achievement,
          id,
          department,
          signatory,
          footer,
        );

      default:
        return _previewRoyal(
          name,
          achievement,
          id,
          department,
          signatory,
          footer,
        );
    }
  }

  // ===========================================================================
  // ACTIONS
  // ===========================================================================

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
                    Icons.workspace_premium_rounded,
                  ),
            label: Text(
              _isGeneratingPdf
                  ? 'Creating Certificate...'
                  : 'Save Premium Certificate PDF',
            ),
            style: FilledButton.styleFrom(
              backgroundColor: _green,
              foregroundColor: Colors.white,
              padding:
                  const EdgeInsets.symmetric(
                vertical: 15,
              ),
              shape:
                  RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(13),
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
            icon: const Icon(
              Icons.share_rounded,
            ),
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
              shape:
                  RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(13),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // BUILD
  // ===========================================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFF3F7F4),
      appBar: AppBar(
        backgroundColor: _darkGreen,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Text(
              'SAFENEXUS HSE',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w900,
                letterSpacing: .3,
              ),
            ),
            Text(
              'Premium Certificate Designer',
              style: TextStyle(
                fontSize: 10.5,
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
              Icons.picture_as_pdf_rounded,
            ),
          ),
          IconButton(
            tooltip: 'Share PDF',
            onPressed:
                _isGeneratingPdf
                    ? null
                    : _shareCertificatePdf,
            icon: const Icon(
              Icons.share_rounded,
            ),
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
                Icons.workspace_premium_rounded,
                'Premium Certificate Designer',
                'Create professional HSE certificates ready for PDF export.',
              ),

              const SizedBox(height: 15),

              // ----------------------------------------------------------------
              // DESIGN CARD
              // ----------------------------------------------------------------

              Card(
                elevation: 0,
                color: Colors.white,
                shape:
                    RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(17),
                  side: BorderSide(
                    color: Colors.grey.shade200,
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
                        'Choose Premium Design',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight:
                              FontWeight.w800,
                          color: _ink,
                        ),
                      ),
                      const SizedBox(height: 3),
                      const Text(
                        'Five professional HSE certificate styles',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.black54,
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

              // ----------------------------------------------------------------
              // DETAILS CARD
              // ----------------------------------------------------------------

              Card(
                elevation: 0,
                color: Colors.white,
                shape:
                    RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(17),
                  side: BorderSide(
                    color: Colors.grey.shade200,
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
                        label: 'Employee Name',
                        controller:
                            _nameController,
                        icon:
                            Icons.person_outline_rounded,
                      ),

                      _field(
                        label: 'Employee ID',
                        controller:
                            _idController,
                        icon:
                            Icons.badge_outlined,
                      ),

                      _field(
                        label: 'Department',
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
                        icon:
                            Icons.workspace_premium_outlined,
                        maxLines: 4,
                      ),

                      _field(
                        label: 'Company Name',
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
                        label: 'Footer Text',
                        controller:
                            _footerController,
                        icon:
                            Icons.short_text_rounded,
                      ),

                      InkWell(
                        onTap: _selectDate,
                        borderRadius:
                            BorderRadius.circular(
                          13,
                        ),
                        child: InputDecorator(
                          decoration:
                              InputDecoration(
                            labelText:
                                'Certificate Date',
                            prefixIcon:
                                const Icon(
                              Icons.calendar_today_rounded,
                              color: _green,
                            ),
                            filled: true,
                            fillColor:
                                const Color(
                              0xFFFCFDFC,
                            ),
                            border:
                                OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(
                                13,
                              ),
                            ),
                          ),
                          child: Text(
                            formattedDate,
                            style:
                                const TextStyle(
                              fontWeight:
                                  FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 14),

              // ----------------------------------------------------------------
              // PREVIEW CARD
              // ----------------------------------------------------------------

              Card(
                elevation: 0,
                color: Colors.white,
                shape:
                    RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(17),
                  side: BorderSide(
                    color: Colors.grey.shade200,
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
                        'Preview updates automatically as you edit the certificate.',
                      ),
                      const SizedBox(height: 12),
                      _preview(),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 14),

              _actions(),

              // ----------------------------------------------------------------
              // READY STATUS
              // ----------------------------------------------------------------

              if (_lastSavedPath != null) ...[
                const SizedBox(height: 10),
                Card(
                  elevation: 0,
                  color:
                      _green.withValues(alpha: .08),
                  shape:
                      RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(13),
                  ),
                  child: const Padding(
                    padding:
                        EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Icon(
                          Icons.verified_rounded,
                          color: _green,
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Premium certificate PDF is ready to share.',
                            style: TextStyle(
                              color: _ink,
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

              // ----------------------------------------------------------------
              // RESET / EXPORT
              // ----------------------------------------------------------------

              Row(
                children: [
                  Expanded(
                    child:
                        OutlinedButton.icon(
                      onPressed:
                          _isGeneratingPdf
                              ? null
                              : _resetCertificate,
                      icon: const Icon(
                        Icons.refresh_rounded,
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
                        shape:
                            RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(
                            13,
                          ),
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
                        Icons.picture_as_pdf_rounded,
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
                        shape:
                            RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(
                            13,
                          ),
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
