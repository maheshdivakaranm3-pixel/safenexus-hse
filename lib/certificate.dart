import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class CertificatePage extends StatefulWidget {
  const CertificatePage({super.key});

  @override
  State<CertificatePage> createState() => _CertificatePageState();
}

class _CertificatePageState extends State<CertificatePage> {
  final TextEditingController _nameController =
      TextEditingController(text: 'Employee Name');

  final TextEditingController _idController =
      TextEditingController();

  final TextEditingController _departmentController =
      TextEditingController();

  final TextEditingController _achievementController =
      TextEditingController(
    text:
        'for your outstanding commitment to Health, Safety & Environment\n'
        'and for actively contributing to a safe and sustainable workplace.',
  );

  final TextEditingController _companyController =
      TextEditingController(text: 'SafeNexus HSE');

  final TextEditingController _titleController =
      TextEditingController(text: 'CERTIFICATE');

  final TextEditingController _subtitleController =
      TextEditingController(text: 'OF APPRECIATION');

  final TextEditingController _footerController =
      TextEditingController(text: 'Identify. Report. Stay Safe.');

  final TextEditingController _signatoryController =
      TextEditingController(text: 'Authorized Signatory');

  DateTime selectedDate = DateTime.now();

  int selectedTemplate = 0;
  int selectedColor = 0;

  double nameFontSize = 34;
  TextAlign nameAlignment = TextAlign.center;

  bool _isExporting = false;

  final List<Color> themeColors = const [
    Color(0xFF087A3D),
    Color(0xFF1261A0),
    Color(0xFFB47B00),
  ];

  final List<String> templateNames = const [
    'HSE Appreciation',
    'Safety Excellence',
    'Employee Recognition',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _idController.dispose();
    _departmentController.dispose();
    _achievementController.dispose();
    _companyController.dispose();
    _titleController.dispose();
    _subtitleController.dispose();
    _footerController.dispose();
    _signatoryController.dispose();
    super.dispose();
  }

  Color get primaryColor => themeColors[selectedColor];

  String get formattedDate {
    return '${selectedDate.day.toString().padLeft(2, '0')}/'
        '${selectedDate.month.toString().padLeft(2, '0')}/'
        '${selectedDate.year}';
  }

  String get safeFileName {
    String name = _nameController.text.trim();

    if (name.isEmpty) {
      name = 'Employee';
    }

    name = name
        .replaceAll(RegExp(r'[^a-zA-Z0-9]+'), '_')
        .replaceAll(RegExp(r'_+'), '_');

    name = name.replaceAll(RegExp(r'^_|_$'), '');

    if (name.isEmpty) {
      name = 'Employee';
    }

    return 'SafeNexus_Certificate_$name.pdf';
  }

  Future<void> _selectDate() async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (date != null) {
      setState(() {
        selectedDate = date;
      });
    }
  }

  void _resetCertificate() {
    setState(() {
      _nameController.text = 'Employee Name';
      _idController.clear();
      _departmentController.clear();

      _achievementController.text =
          'for your outstanding commitment to Health, Safety & Environment\n'
          'and for actively contributing to a safe and sustainable workplace.';

      _companyController.text = 'SafeNexus HSE';
      _titleController.text = 'CERTIFICATE';
      _subtitleController.text = 'OF APPRECIATION';
      _footerController.text = 'Identify. Report. Stay Safe.';
      _signatoryController.text = 'Authorized Signatory';

      selectedTemplate = 0;
      selectedColor = 0;
      nameFontSize = 34;
      nameAlignment = TextAlign.center;
      selectedDate = DateTime.now();
    });
  }

  Future<void> _saveCertificate() async {
    if (_isExporting) {
      return;
    }

    setState(() {
      _isExporting = true;
    });

    try {
      final Uint8List pdfBytes = await _generatePdf();

      if (!mounted) {
        return;
      }

      await Printing.sharePdf(
        bytes: pdfBytes,
        filename: safeFileName,
      );

      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text(
              'Certificate PDF created successfully.',
            ),
            behavior: SnackBarBehavior.floating,
          ),
        );
    } catch (e) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(
              'PDF export failed: $e',
            ),
            behavior: SnackBarBehavior.floating,
          ),
        );
    } finally {
      if (mounted) {
        setState(() {
          _isExporting = false;
        });
      }
    }
  }

  Future<void> _openPdfPreview() async {
    if (_isExporting) {
      return;
    }

    try {
      final Uint8List pdfBytes = await _generatePdf();

      if (!mounted) {
        return;
      }

      await Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (context) {
            return _CertificatePdfPreview(
              pdfBytes: pdfBytes,
              fileName: safeFileName,
            );
          },
        ),
      );
    } catch (e) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(
              'Could not create PDF preview: $e',
            ),
            behavior: SnackBarBehavior.floating,
          ),
        );
    }
  }

  Future<Uint8List> _generatePdf() async {
    final pw.Document document = pw.Document();

    final PdfColor pdfPrimaryColor =
        PdfColor.fromInt(themeColors[selectedColor].value);

    final String name = _nameController.text.trim().isEmpty
        ? 'Employee Name'
        : _nameController.text.trim();

    final String company = _companyController.text.trim().isEmpty
        ? 'SafeNexus HSE'
        : _companyController.text.trim();

    final String title = _titleController.text.trim().isEmpty
        ? 'CERTIFICATE'
        : _titleController.text.trim();

    final String subtitle =
        _subtitleController.text.trim().isEmpty
            ? 'OF APPRECIATION'
            : _subtitleController.text.trim();

    final String achievement =
        _achievementController.text.trim().isEmpty
            ? 'for your outstanding commitment to Health, Safety & Environment\n'
              'and for actively contributing to a safe and sustainable workplace.'
            : _achievementController.text.trim();

    final String signatory =
        _signatoryController.text.trim().isEmpty
            ? 'Authorized Signatory'
            : _signatoryController.text.trim();

    final String footer =
        _footerController.text.trim().isEmpty
            ? 'Identify. Report. Stay Safe.'
            : _footerController.text.trim();

    final String employeeId =
        _idController.text.trim();

    final String department =
        _departmentController.text.trim();

    document.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.zero,
        build: (pw.Context context) {
          return pw.Container(
            color: PdfColor.fromInt(0xFFFDFEF9),
            padding: const pw.EdgeInsets.all(18),
            child: pw.Container(
              decoration: pw.BoxDecoration(
                border: pw.Border.all(
                  color: pdfPrimaryColor,
                  width: 6,
                ),
              ),
              padding: const pw.EdgeInsets.all(8),
              child: pw.Container(
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(
                    color: pdfPrimaryColor,
                    width: 1.5,
                  ),
                ),
                child: pw.Stack(
                  children: [
                    pw.Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      height: 120,
                      child: _pdfBackground(
                        pdfPrimaryColor,
                      ),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 24,
                      ),
                      child: pw.Column(
                        crossAxisAlignment:
                            pw.CrossAxisAlignment.center,
                        children: [
                          _pdfLogo(pdfPrimaryColor),

                          pw.SizedBox(height: 8),

                          pw.Text(
                            company,
                            textAlign: pw.TextAlign.center,
                            maxLines: 2,
                            style: pw.TextStyle(
                              color: pdfPrimaryColor,
                              fontSize: 19,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),

                          pw.SizedBox(height: 3),

                          pw.Text(
                            'AI-Powered HSE Safety & Observation App',
                            textAlign: pw.TextAlign.center,
                            style: const pw.TextStyle(
                              fontSize: 8,
                              color: PdfColors.grey700,
                            ),
                          ),

                          pw.SizedBox(height: 20),

                          pw.Text(
                            title,
                            textAlign: pw.TextAlign.center,
                            maxLines: 2,
                            style: pw.TextStyle(
                              color: pdfPrimaryColor,
                              fontSize: 29,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),

                          pw.SizedBox(height: 6),

                          pw.Container(
                            padding:
                                const pw.EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 7,
                            ),
                            decoration: pw.BoxDecoration(
                              color: pdfPrimaryColor,
                              borderRadius:
                                  pw.BorderRadius.circular(3),
                            ),
                            child: pw.Text(
                              subtitle,
                              textAlign: pw.TextAlign.center,
                              maxLines: 2,
                              style: pw.TextStyle(
                                color: PdfColors.white,
                                fontSize: 11,
                                fontWeight:
                                    pw.FontWeight.bold,
                                letterSpacing: 1,
                              ),
                            ),
                          ),

                          pw.SizedBox(height: 18),

                          pw.Text(
                            'This certificate is proudly presented to',
                            textAlign: pw.TextAlign.center,
                            style: const pw.TextStyle(
                              fontSize: 10,
                            ),
                          ),

                          pw.SizedBox(height: 7),

                          pw.Container(
                            width: double.infinity,
                            padding:
                                const pw.EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            child: pw.Text(
                              name,
                              textAlign: pw.TextAlign.center,
                              maxLines: 2,
                              overflow: pw.TextOverflow.clip,
                              style: pw.TextStyle(
                                color: pdfPrimaryColor,
                                fontSize: _pdfNameFontSize,
                                fontWeight:
                                    pw.FontWeight.bold,
                              ),
                            ),
                          ),

                          pw.Container(
                            width: double.infinity,
                            height: 1,
                            color: pdfPrimaryColor,
                          ),

                          if (employeeId.isNotEmpty ||
                              department.isNotEmpty) ...[
                            pw.SizedBox(height: 8),
                            pw.Text(
                              [
                                if (employeeId.isNotEmpty)
                                  'Employee ID: $employeeId',
                                if (department.isNotEmpty)
                                  'Department: $department',
                              ].join('   •   '),
                              textAlign: pw.TextAlign.center,
                              maxLines: 2,
                              style: const pw.TextStyle(
                                fontSize: 8,
                                color: PdfColors.grey700,
                              ),
                            ),
                          ],

                          pw.SizedBox(height: 16),

                          pw.Container(
                            width: double.infinity,
                            constraints:
                                const pw.BoxConstraints(
                              minHeight: 92,
                            ),
                            alignment: pw.Alignment.center,
                            child: pw.Text(
                              achievement,
                              textAlign: pw.TextAlign.center,
                              style: const pw.TextStyle(
                                fontSize: 10,
                                lineSpacing: 4,
                              ),
                            ),
                          ),

                          pw.SizedBox(height: 12),

                          _pdfSafetyBadges(
                            pdfPrimaryColor,
                          ),

                          pw.SizedBox(height: 24),

                          pw.Row(
                            mainAxisAlignment:
                                pw.MainAxisAlignment
                                    .spaceBetween,
                            crossAxisAlignment:
                                pw.CrossAxisAlignment.end,
                            children: [
                              _pdfSignatureBlock(
                                formattedDate,
                                'Date',
                                pdfPrimaryColor,
                              ),
                              _pdfPriorityBadge(
                                pdfPrimaryColor,
                              ),
                              _pdfSignatureBlock(
                                signatory,
                                'Authorized Signatory',
                                pdfPrimaryColor,
                              ),
                            ],
                          ),

                          pw.SizedBox(height: 14),

                          pw.Container(
                            width: double.infinity,
                            padding:
                                const pw.EdgeInsets.symmetric(
                              vertical: 8,
                              horizontal: 8,
                            ),
                            decoration: pw.BoxDecoration(
                              color: pdfPrimaryColor,
                              borderRadius:
                                  const pw.BorderRadius.only(
                                bottomLeft:
                                    pw.Radius.circular(14),
                                bottomRight:
                                    pw.Radius.circular(14),
                              ),
                            ),
                            child: pw.Text(
                              footer,
                              textAlign: pw.TextAlign.center,
                              maxLines: 2,
                              style: pw.TextStyle(
                                color: PdfColors.white,
                                fontSize: 10,
                                fontWeight:
                                    pw.FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );

    return document.save();
  }

  double get _pdfNameFontSize {
    final double size = nameFontSize;

    if (size < 20) {
      return 20;
    }

    if (size > 40) {
      return 40;
    }

    return size * 0.72;
  }

  Widget _sectionTitle(
    IconData icon,
    String title,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(
            icon,
            color: primaryColor,
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _inputField({
    required String label,
    required TextEditingController controller,
    IconData? icon,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        onChanged: (_) {
          setState(() {});
        },
        decoration: InputDecoration(
          labelText: label,
          prefixIcon:
              icon == null ? null : Icon(icon),
          border: const OutlineInputBorder(),
          isDense: true,
        ),
      ),
    );
  }

  Widget _templateCard(int index) {
    final bool isSelected =
        selectedTemplate == index;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedTemplate = index;
          });
        },
        child: Container(
          margin: const EdgeInsets.only(right: 8),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isSelected
                ? primaryColor.withValues(alpha: 0.08)
                : Colors.white,
            borderRadius:
                BorderRadius.circular(12),
            border: Border.all(
              color: isSelected
                  ? primaryColor
                  : Colors.grey.shade300,
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Column(
            children: [
              Container(
                height: 80,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      themeColors[index]
                          .withValues(alpha: 0.18),
                      Colors.white,
                    ],
                  ),
                  border: Border.all(
                    color: themeColors[index],
                  ),
                  borderRadius:
                      BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    'CERTIFICATE',
                    style: TextStyle(
                      color: themeColors[index],
                      fontWeight: FontWeight.bold,
                      fontSize: 9,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 7),
              Text(
                templateNames[index],
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _certificatePreview() {
    return AspectRatio(
      aspectRatio: 0.707,
      child: Container(
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: const Color(0xFFFDFEF9),
          border: Border.all(
            color: primaryColor,
            width: 8,
          ),
          boxShadow: const [
            BoxShadow(
              blurRadius: 12,
              color: Colors.black12,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Container(
          margin: const EdgeInsets.all(7),
          decoration: BoxDecoration(
            border: Border.all(
              color:
                  primaryColor.withValues(alpha: 0.6),
              width: 2,
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: 120,
                child: CustomPaint(
                  painter:
                      _ConstructionBackgroundPainter(
                    color: primaryColor,
                  ),
                ),
              ),
              Positioned.fill(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(
                    horizontal: 22,
                    vertical: 18,
                  ),
                  child: Column(
                    children: [
                      _certificateLogo(),

                      const SizedBox(height: 8),

                      Text(
                        _companyController.text,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow:
                            TextOverflow.ellipsis,
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 17,
                          fontWeight:
                              FontWeight.w800,
                        ),
                      ),

                      const Text(
                        'AI-Powered HSE Safety & Observation App',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 7,
                          color: Colors.black54,
                        ),
                      ),

                      const SizedBox(height: 18),

                      Text(
                        _titleController.text,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow:
                            TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: 'serif',
                          fontSize: 27,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),

                      const SizedBox(height: 5),

                      Container(
                        constraints:
                            const BoxConstraints(
                          maxWidth: 220,
                        ),
                        padding:
                            const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: primaryColor,
                        ),
                        child: Text(
                          _subtitleController.text,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow:
                              TextOverflow.ellipsis,
                          style:
                              const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight:
                                FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                      ),

                      const SizedBox(height: 15),

                      const Text(
                        'This certificate is proudly presented to',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 9),
                      ),

                      const SizedBox(height: 5),

                      GestureDetector(
                        onTap: () => _editText(
                          title:
                              'Edit Employee Name',
                          controller:
                              _nameController,
                        ),
                        child: Container(
                          width: double.infinity,
                          padding:
                              const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: primaryColor
                                  .withValues(
                                alpha: 0.35,
                              ),
                            ),
                            borderRadius:
                                BorderRadius.circular(5),
                          ),
                          child: Text(
                            _nameController.text,
                            textAlign: nameAlignment,
                            maxLines: 2,
                            overflow:
                                TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: 'cursive',
                              fontSize:
                                  nameFontSize,
                              color: primaryColor,
                              fontWeight:
                                  FontWeight.w500,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 5),

                      Container(
                        height: 1,
                        color: primaryColor
                            .withValues(
                          alpha: 0.35,
                        ),
                      ),

                      const SizedBox(height: 8),

                      if (_idController.text.isNotEmpty ||
                          _departmentController
                              .text
                              .isNotEmpty)
                        Text(
                          [
                            if (_idController
                                .text
                                .isNotEmpty)
                              'ID: ${_idController.text}',
                            if (_departmentController
                                .text
                                .isNotEmpty)
                              'Department: ${_departmentController.text}',
                          ].join('  •  '),
                          textAlign:
                              TextAlign.center,
                          maxLines: 2,
                          overflow:
                              TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 7,
                            color: Colors.black54,
                          ),
                        ),

                      const SizedBox(height: 10),

                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              _achievementController
                                  .text,
                              textAlign:
                                  TextAlign.center,
                              maxLines: 5,
                              overflow:
                                  TextOverflow.ellipsis,
                              style:
                                  const TextStyle(
                                fontSize: 10,
                                height: 1.5,
                              ),
                            ),
                            const SizedBox(height: 14),
                            _safetyBadges(),
                          ],
                        ),
                      ),

                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment
                                .spaceBetween,
                        crossAxisAlignment:
                            CrossAxisAlignment.end,
                        children: [
                          _signatureBlock(
                            formattedDate,
                            'Date',
                          ),
                          _priorityBadge(),
                          _signatureBlock(
                            _signatoryController
                                .text,
                            'Authorized Signatory',
                          ),
                        ],
                      ),

                      const SizedBox(height: 8),

                      Container(
                        width: double.infinity,
                        padding:
                            const EdgeInsets.symmetric(
                          vertical: 6,
                          horizontal: 5,
                        ),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius:
                              const BorderRadius.only(
                            bottomLeft:
                                Radius.circular(20),
                            bottomRight:
                                Radius.circular(20),
                          ),
                        ),
                        child: Text(
                          _footerController.text,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow:
                              TextOverflow.ellipsis,
                          style:
                              const TextStyle(
                            color: Colors.white,
                            fontWeight:
                                FontWeight.bold,
                            fontSize: 10,
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
      ),
    );
  }

  Widget _certificateLogo() {
    return Container(
      width: 54,
      height: 54,
      decoration: BoxDecoration(
        color: primaryColor,
        shape: BoxShape.circle,
      ),
      child: const Center(
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            Icon(
              Icons.engineering,
              color: Colors.white,
              size: 23,
            ),
            Text(
              'S',
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _safetyBadges() {
    final List<List<Object>> badges = [
      [Icons.verified_user, 'BE SAFE'],
      [Icons.construction, 'WORK SAFE'],
      [Icons.groups, 'STAY SAFE'],
      [Icons.eco, 'GO HOME SAFE'],
    ];

    return Row(
      mainAxisAlignment:
          MainAxisAlignment.spaceEvenly,
      children: badges.map((badge) {
        return Column(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: primaryColor,
                ),
              ),
              child: Icon(
                badge[0] as IconData,
                color: primaryColor,
                size: 21,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              badge[1] as String,
              style: TextStyle(
                fontSize: 6,
                color: primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        );
      }).toList(),
    );
  }

  Widget _priorityBadge() {
    return Container(
      width: 66,
      height: 66,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: primaryColor,
        border: Border.all(
          color: Colors.white,
          width: 3,
        ),
      ),
      child: const Center(
        child: Text(
          'SAFETY\nIS OUR\nPRIORITY',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 8,
            fontWeight: FontWeight.bold,
            height: 1.2,
          ),
        ),
      ),
    );
  }

  Widget _signatureBlock(
    String value,
    String label,
  ) {
    return SizedBox(
      width: 75,
      child: Column(
        children: [
          Container(
            height: 1,
            color: Colors.black54,
          ),
          const SizedBox(height: 5),
          Text(
            value,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow:
                TextOverflow.ellipsis,
            style:
                const TextStyle(fontSize: 7),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow:
                TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 6,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _editTools() {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        _sectionTitle(
          Icons.edit,
          'Edit Certificate',
        ),

        _inputField(
          label: 'Certificate Title',
          controller: _titleController,
          icon: Icons.title,
        ),

        _inputField(
          label: 'Subtitle',
          controller: _subtitleController,
          icon: Icons.label_outline,
        ),

        _inputField(
          label: 'Employee Name',
          controller: _nameController,
          icon: Icons.person,
        ),

        _inputField(
          label: 'Employee ID',
          controller: _idController,
          icon: Icons.badge_outlined,
        ),

        _inputField(
          label: 'Department',
          controller:
              _departmentController,
          icon: Icons.business,
        ),

        _inputField(
          label: 'Achievement / Reason',
          controller:
              _achievementController,
          icon: Icons.workspace_premium,
          maxLines: 4,
        ),

        _inputField(
          label: 'Company Name',
          controller:
              _companyController,
          icon: Icons.business_center,
        ),

        _inputField(
          label: 'Authorized Signatory',
          controller:
              _signatoryController,
          icon: Icons.draw,
        ),

        _inputField(
          label: 'Footer Text',
          controller:
              _footerController,
          icon: Icons.short_text,
        ),

        InkWell(
          onTap: _selectDate,
          child: InputDecorator(
            decoration:
                const InputDecoration(
              labelText:
                  'Certificate Date',
              border:
                  OutlineInputBorder(),
              prefixIcon:
                  Icon(Icons.calendar_today),
            ),
            child: Text(formattedDate),
          ),
        ),

        const SizedBox(height: 18),

        Text(
          'Name Font Size',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),

        Slider(
          min: 20,
          max: 48,
          divisions: 14,
          value: nameFontSize,
          label:
              nameFontSize.round().toString(),
          onChanged: (value) {
            setState(() {
              nameFontSize = value;
            });
          },
        ),

        Text(
          'Name Alignment',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),

        Row(
          children: [
            _alignmentButton(
              Icons.format_align_left,
              TextAlign.left,
            ),
            _alignmentButton(
              Icons.format_align_center,
              TextAlign.center,
            ),
            _alignmentButton(
              Icons.format_align_right,
              TextAlign.right,
            ),
          ],
        ),

        const SizedBox(height: 15),

        Text(
          'Certificate Theme',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),

        const SizedBox(height: 8),

        Row(
          children: List.generate(
            themeColors.length,
            (index) {
              final bool selected =
                  selectedColor == index;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedColor = index;
                  });
                },
                child: Container(
                  margin:
                      const EdgeInsets.only(
                    right: 12,
                  ),
                  width: 42,
                  height: 42,
                  decoration:
                      BoxDecoration(
                    color:
                        themeColors[index],
                    shape:
                        BoxShape.circle,
                    border: Border.all(
                      color: selected
                          ? Colors.black
                          : Colors.transparent,
                      width: 3,
                    ),
                  ),
                  child: selected
                      ? const Icon(
                          Icons.check,
                          color:
                              Colors.white,
                        )
                      : null,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _alignmentButton(
    IconData icon,
    TextAlign alignment,
  ) {
    final bool selected =
        nameAlignment == alignment;

    return Padding(
      padding:
          const EdgeInsets.only(
        right: 8,
        top: 8,
      ),
      child: OutlinedButton(
        onPressed: () {
          setState(() {
            nameAlignment = alignment;
          });
        },
        style:
            OutlinedButton.styleFrom(
          backgroundColor: selected
              ? primaryColor.withValues(
                  alpha: 0.10,
                )
              : null,
          side: BorderSide(
            color: selected
                ? primaryColor
                : Colors.grey.shade300,
          ),
        ),
        child: Icon(
          icon,
          color: selected
              ? primaryColor
              : Colors.grey,
        ),
      ),
    );
  }

  void _editText({
    required String title,
    required TextEditingController
        controller,
    int maxLines = 1,
  }) {
    final TextEditingController
        tempController =
        TextEditingController(
      text: controller.text,
    );

    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(title),
          content: TextField(
            controller: tempController,
            maxLines: maxLines,
            autofocus: true,
            decoration:
                const InputDecoration(
              border:
                  OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                tempController.dispose();
                Navigator.pop(
                  dialogContext,
                );
              },
              child:
                  const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                setState(() {
                  controller.text =
                      tempController.text;
                });

                tempController.dispose();

                Navigator.pop(
                  dialogContext,
                );
              },
              child:
                  const Text('Apply'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFF4F8F5),
      appBar: AppBar(
        backgroundColor:
            primaryColor,
        foregroundColor:
            Colors.white,
        title: const Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Text(
              'SAFENEXUS HSE',
              style: TextStyle(
                fontSize: 18,
                fontWeight:
                    FontWeight.bold,
              ),
            ),
            Text(
              'Certificate Designer',
              style: TextStyle(
                fontSize: 12,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Export PDF',
            onPressed: _isExporting
                ? null
                : _saveCertificate,
            icon: _isExporting
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child:
                        CircularProgressIndicator(
                      strokeWidth: 2,
                      color:
                          Colors.white,
                    ),
                  )
                : const Icon(
                    Icons.picture_as_pdf,
                  ),
          ),
        ],
      ),
      body: SafeArea(
        child:
            SingleChildScrollView(
          padding:
              const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment
                    .start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons
                        .workspace_premium,
                    size: 36,
                    color:
                        primaryColor,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment
                              .start,
                      children: [
                        Text(
                          'Certificate Designer',
                          style:
                              TextStyle(
                            fontSize: 24,
                            fontWeight:
                                FontWeight
                                    .bold,
                            color:
                                primaryColor,
                          ),
                        ),
                        const Text(
                          'Create • Edit • Customize • Export',
                          style:
                              TextStyle(
                            color:
                                Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 18,
              ),

              Card(
                elevation: 1,
                child: Padding(
                  padding:
                      const EdgeInsets.all(
                    14,
                  ),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment
                            .start,
                    children: [
                      _sectionTitle(
                        Icons
                            .dashboard_customize,
                        'Choose Template',
                      ),
                      Row(
                        children:
                            List.generate(
                          templateNames
                              .length,
                          _templateCard,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(
                height: 14,
              ),

              Card(
                elevation: 1,
                child: Padding(
                  padding:
                      const EdgeInsets.all(
                    14,
                  ),
                  child:
                      _editTools(),
                ),
              ),

              const SizedBox(
                height: 14,
              ),

              Card(
                elevation: 1,
                child: Padding(
                  padding:
                      const EdgeInsets.all(
                    12,
                  ),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment
                            .start,
                    children: [
                      _sectionTitle(
                        Icons.visibility,
                        'Live Preview',
                      ),
                      _certificatePreview(),
                    ],
                  ),
                ),
              ),

              const SizedBox(
                height: 14,
              ),

              Row(
                children: [
                  Expanded(
                    child:
                        OutlinedButton.icon(
                      onPressed:
                          _resetCertificate,
                      icon:
                          const Icon(
                        Icons.refresh,
                      ),
                      label:
                          const Text(
                        'Reset',
                      ),
                      style:
                          OutlinedButton
                              .styleFrom(
                        padding:
                            const EdgeInsets
                                .symmetric(
                          vertical: 14,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child:
                        FilledButton.icon(
                      onPressed:
                          _isExporting
                              ? null
                              : _saveCertificate,
                      icon: _isExporting
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child:
                                  CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            )
                          : const Icon(
                              Icons
                                  .picture_as_pdf,
                            ),
                      label: Text(
                        _isExporting
                            ? 'Creating PDF...'
                            : 'Save & Share PDF',
                      ),
                      style:
                          FilledButton.styleFrom(
                        backgroundColor:
                            primaryColor,
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

              const SizedBox(
                height: 10,
              ),

              SizedBox(
                width: double.infinity,
                child:
                    OutlinedButton.icon(
                  onPressed:
                      _openPdfPreview,
                  icon: const Icon(
                    Icons.preview,
                  ),
                  label:
                      const Text(
                    'Preview PDF',
                  ),
                ),
              ),

              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/* -------------------------------------------------------------------------- */
/* PDF HELPERS                                                                */
/* -------------------------------------------------------------------------- */

pw.Widget _pdfBackground(
  PdfColor color,
) {
  return pw.Container(
    width: double.infinity,
    height: double.infinity,
    child: pw.Column(
      children: List.generate(
        5,
        (index) {
          return pw.Expanded(
            child: pw.Container(
              decoration:
                  pw.BoxDecoration(
                border: pw.Border(
                  bottom: pw.BorderSide(
                    color: color,
                    width: 0.4,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    ),
  );
}

pw.Widget _pdfLogo(
  PdfColor color,
) {
  return pw.Container(
    width: 55,
    height: 55,
    decoration:
        pw.BoxDecoration(
      color: color,
      shape: pw.BoxShape.circle,
    ),
    child: pw.Center(
      child: pw.Column(
        mainAxisAlignment:
            pw.MainAxisAlignment
                .center,
        children: [
          pw.Text(
            'S',
            style: pw.TextStyle(
              color:
                  PdfColors.white,
              fontSize: 23,
              fontWeight:
                  pw.FontWeight.bold,
            ),
          ),
          pw.Text(
            'HSE',
            style: pw.TextStyle(
              color:
                  PdfColors.white,
              fontSize: 7,
              fontWeight:
                  pw.FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}

pw.Widget _pdfSafetyBadges(
  PdfColor color,
) {
  const List<String> labels = [
    'BE SAFE',
    'WORK SAFE',
    'STAY SAFE',
    'GO HOME SAFE',
  ];

  return pw.Row(
    mainAxisAlignment:
        pw.MainAxisAlignment
            .spaceEvenly,
    children: labels.map(
      (label) {
        return pw.Column(
          children: [
            pw.Container(
              width: 38,
              height: 38,
              decoration:
                  pw.BoxDecoration(
                shape:
                    pw.BoxShape.circle,
                border:
                    pw.Border.all(
                  color: color,
                  width: 1,
                ),
              ),
              child: pw.Center(
                child: pw.Text(
                  '✓',
                  style:
                      pw.TextStyle(
                    color: color,
                    fontSize: 17,
                    fontWeight:
                        pw.FontWeight
                            .bold,
                  ),
                ),
              ),
            ),
            pw.SizedBox(height: 4),
            pw.Text(
              label,
              textAlign:
                  pw.TextAlign.center,
              style: pw.TextStyle(
                color: color,
                fontSize: 6,
                fontWeight:
                    pw.FontWeight
                        .bold,
              ),
            ),
          ],
        );
      },
    ).toList(),
  );
}

pw.Widget _pdfPriorityBadge(
  PdfColor color,
) {
  return pw.Container(
    width: 66,
    height: 66,
    decoration:
        pw.BoxDecoration(
      shape: pw.BoxShape.circle,
      color: color,
      border: pw.Border.all(
        color: PdfColors.white,
        width: 3,
      ),
    ),
    child: pw.Center(
      child: pw.Text(
        'SAFETY\nIS OUR\nPRIORITY',
        textAlign:
            pw.TextAlign.center,
        style: pw.TextStyle(
          color: PdfColors.white,
          fontSize: 8,
          fontWeight:
              pw.FontWeight.bold,
        ),
      ),
    ),
  );
}

pw.Widget _pdfSignatureBlock(
  String value,
  String label,
  PdfColor color,
) {
  return pw.SizedBox(
    width: 90,
    child: pw.Column(
      children: [
        pw.Container(
          height: 1,
          color: PdfColors.grey700,
        ),
        pw.SizedBox(height: 5),
        pw.Text(
          value,
          textAlign:
              pw.TextAlign.center,
          maxLines: 2,
          style:
              const pw.TextStyle(
            fontSize: 7,
          ),
        ),
        pw.SizedBox(height: 3),
        pw.Text(
          label,
          textAlign:
              pw.TextAlign.center,
          maxLines: 2,
          style: pw.TextStyle(
            color: color,
            fontSize: 6,
            fontWeight:
                pw.FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

/* -------------------------------------------------------------------------- */
/* PDF PREVIEW PAGE                                                           */
/* -------------------------------------------------------------------------- */

class _CertificatePdfPreview
    extends StatelessWidget {
  final Uint8List pdfBytes;
  final String fileName;

  const _CertificatePdfPreview({
    required this.pdfBytes,
    required this.fileName,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Certificate PDF',
        ),
      ),
      body: PdfPreview(
        build: (PdfPageFormat format) async {
          return pdfBytes;
        },
        allowPrinting: true,
        allowSharing: true,
        canChangePageFormat: false,
        canChangeOrientation: false,
        pdfFileName: fileName,
      ),
    );
  }
}

/* -------------------------------------------------------------------------- */
/* LIVE PREVIEW BACKGROUND                                                    */
/* -------------------------------------------------------------------------- */

class _ConstructionBackgroundPainter
    extends CustomPainter {
  final Color color;

  _ConstructionBackgroundPainter({
    required this.color,
  });

  @override
  void paint(
    Canvas canvas,
    Size size,
  ) {
    final Paint paint = Paint()
      ..color = color.withValues(
        alpha: 0.06,
      )
      ..style =
          PaintingStyle.stroke
      ..strokeWidth = 1;

    for (
      double x = 10;
      x < size.width;
      x += 45
    ) {
      canvas.drawLine(
        Offset(
          x,
          size.height,
        ),
        Offset(
          x + 30,
          30,
        ),
        paint,
      );
    }

    for (
      double y = 20;
      y < size.height;
      y += 22
    ) {
      canvas.drawLine(
        Offset(0, y),
        Offset(
          size.width,
          y,
        ),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(
    covariant
        _ConstructionBackgroundPainter
            oldDelegate,
  ) {
    return oldDelegate.color !=
        color;
  }
}
