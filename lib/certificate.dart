import 'dart:io';
import 'dart:math' as math;

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
  final TextEditingController _nameController =
      TextEditingController(text: 'Employee Name');
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _departmentController =
      TextEditingController();

  final TextEditingController _achievementController =
      TextEditingController(
    text:
        'For your outstanding commitment to Health, Safety & Environment\n'
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
  bool _isGeneratingPdf = false;
  String? _lastSavedPath;

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

  Color get primaryColor => themeColors[selectedColor];

  String get formattedDate {
    return '${selectedDate.day.toString().padLeft(2, '0')}/'
        '${selectedDate.month.toString().padLeft(2, '0')}/'
        '${selectedDate.year}';
  }

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

  String _cleanText(String value, {String fallback = ''}) {
    // Remove invisible/control characters only. Do NOT remove normal letters,
    // because names such as "John", "Anju", etc. must remain untouched.
    final String cleaned = value
        .replaceAll(RegExp(r'[\u0000-\u001F\u007F\u200B-\u200D\uFEFF]'), '')
        .replaceAll(RegExp(r'[ \t]+'), ' ')
        .trim();

    return cleaned.isEmpty ? fallback : cleaned;
  }

  String _cleanMultilineText(String value, {String fallback = ''}) {
    final String cleaned = value
        .replaceAll(RegExp(r'[\u0000-\u001F\u007F\u200B-\u200D\uFEFF]'), '')
        .replaceAll('\r\n', '\n')
        .replaceAll('\r', '\n')
        .split('\n')
        .map((String line) => line.trim())
        .where((String line) => line.isNotEmpty)
        .join('\n')
        .trim();

    return cleaned.isEmpty ? fallback : cleaned;
  }

  Future<void> _selectDate() async {
    final DateTime? date = await showDatePicker(
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
          'For your outstanding commitment to Health, Safety & Environment\n'
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
      _lastSavedPath = null;
    });
  }

  void _showMessage(String message, {bool error = false}) {
    if (!mounted) return;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
          backgroundColor: error ? Colors.red.shade700 : null,
        ),
      );
  }

  String _safeFileName(String value) {
    final String cleaned = value
        .trim()
        .replaceAll(RegExp(r'[\\/:*?"<>|]'), '_')
        .replaceAll(RegExp(r'\s+'), '_');

    if (cleaned.isEmpty) return 'Employee';
    return cleaned.length > 50 ? cleaned.substring(0, 50) : cleaned;
  }

  Future<File> _createCertificatePdf() async {
    final pw.Document pdf = pw.Document();

    final PdfColor pdfPrimaryColor =
        PdfColor.fromInt(primaryColor.toARGB32());

    final String employeeName = _cleanText(
      _nameController.text,
      fallback: 'Employee Name',
    );
    final String companyName = _cleanText(
      _companyController.text,
      fallback: 'SafeNexus HSE',
    );
    final String certificateTitle = _cleanText(
      _titleController.text,
      fallback: 'CERTIFICATE',
    );
    final String certificateSubtitle = _cleanText(
      _subtitleController.text,
      fallback: 'OF APPRECIATION',
    );
    final String signatory = _cleanText(
      _signatoryController.text,
      fallback: 'Authorized Signatory',
    );
    final String footer = _cleanText(
      _footerController.text,
      fallback: 'Identify. Report. Stay Safe.',
    );
    final String achievement = _cleanMultilineText(
      _achievementController.text,
      fallback:
          'For your valuable contribution to Health, Safety & Environment\n'
          'and for actively contributing to a safe and sustainable workplace.',
    );
    final String employeeId = _cleanText(_idController.text);
    final String department = _cleanText(_departmentController.text);

    pdf.addPage(
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
                  width: 5,
                ),
              ),
              padding: const pw.EdgeInsets.all(9),
              child: pw.Container(
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(
                    color: pdfPrimaryColor,
                    width: 1.2,
                  ),
                ),
                child: pw.Stack(
                  children: [
                    pw.Positioned.fill(
                      child: pw.CustomPaint(
                        painter: (
                          PdfGraphics canvas,
                          PdfPoint size,
                        ) {
                          final double width = size.x;
                          final double height = size.y;

                          final PdfColor backgroundColor = PdfColor(
                            pdfPrimaryColor.red,
                            pdfPrimaryColor.green,
                            pdfPrimaryColor.blue,
                            0.06,
                          );

                          canvas
                            ..setColor(backgroundColor)
                            ..setLineWidth(0.5);

                          for (double x = 0; x < width; x += 45) {
                            canvas.drawLine(
                              x,
                              height,
                              x + 30,
                              height - 100,
                            );
                          }

                          for (double y = 20; y < 140; y += 22) {
                            canvas.drawLine(0, y, width, y);
                          }

                          canvas.strokePath();
                        },
                      ),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 28,
                      ),
                      child: pw.Column(
                        children: [
                          pw.Container(
                            width: 62,
                            height: 62,
                            decoration: pw.BoxDecoration(
                              color: pdfPrimaryColor,
                              shape: pw.BoxShape.circle,
                            ),
                            child: pw.Center(
                              child: pw.Column(
                                mainAxisAlignment:
                                    pw.MainAxisAlignment.center,
                                children: [
                                  pw.Text(
                                    'S',
                                    style: pw.TextStyle(
                                      color: PdfColors.white,
                                      fontSize: 26,
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                                  ),
                                  pw.Text(
                                    'HSE',
                                    style: pw.TextStyle(
                                      color: PdfColors.white,
                                      fontSize: 7,
                                      fontWeight: pw.FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          pw.SizedBox(height: 10),
                          pw.Text(
                            companyName,
                            textAlign: pw.TextAlign.center,
                            style: pw.TextStyle(
                              color: pdfPrimaryColor,
                              fontSize: 18,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                          pw.SizedBox(height: 3),
                          pw.Text(
                            'AI-Powered HSE Safety & Observation App',
                            textAlign: pw.TextAlign.center,
                            style: const pw.TextStyle(
                              fontSize: 7,
                              color: PdfColors.grey700,
                            ),
                          ),
                          pw.SizedBox(height: 20),
                          pw.Text(
                            certificateTitle,
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
                            padding: const pw.EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 7,
                            ),
                            color: pdfPrimaryColor,
                            child: pw.Text(
                              certificateSubtitle,
                              textAlign: pw.TextAlign.center,
                              maxLines: 2,
                              style: pw.TextStyle(
                                color: PdfColors.white,
                                fontSize: 11,
                                fontWeight: pw.FontWeight.bold,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ),
                          pw.SizedBox(height: 22),
                          pw.Text(
                            'This certificate is proudly presented to',
                            textAlign: pw.TextAlign.center,
                            style: const pw.TextStyle(fontSize: 10),
                          ),
                          pw.SizedBox(height: 8),
                          pw.Container(
                            width: double.infinity,
                            padding: const pw.EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 5,
                            ),
                            decoration: pw.BoxDecoration(
                              border: pw.Border.all(
                                color: pdfPrimaryColor,
                                width: 0.7,
                              ),
                              borderRadius: pw.BorderRadius.circular(5),
                            ),
                            child: pw.Text(
                              employeeName,
                              textAlign: _pdfTextAlign(nameAlignment),
                              maxLines: 2,
                              style: pw.TextStyle(
                                color: pdfPrimaryColor,
                                fontSize: math.min(nameFontSize, 40),
                                fontWeight: pw.FontWeight.bold,
                              ),
                            ),
                          ),
                          pw.SizedBox(height: 5),
                          pw.Container(
                            height: 1,
                            color: pdfPrimaryColor,
                          ),
                          if (employeeId.isNotEmpty ||
                              department.isNotEmpty) ...[
                            pw.SizedBox(height: 9),
                            pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.center,
                              children: [
                                if (employeeId.isNotEmpty)
                                  pw.Flexible(
                                    child: pw.Text(
                                      'Employee ID: $employeeId',
                                      textAlign: pw.TextAlign.center,
                                      maxLines: 1,
                                      overflow: pw.TextOverflow.clip,
                                      style: const pw.TextStyle(
                                        fontSize: 8,
                                      ),
                                    ),
                                  ),
                                if (employeeId.isNotEmpty &&
                                    department.isNotEmpty)
                                  pw.SizedBox(width: 18),
                                if (department.isNotEmpty)
                                  pw.Flexible(
                                    child: pw.Text(
                                      'Department: $department',
                                      textAlign: pw.TextAlign.center,
                                      maxLines: 1,
                                      overflow: pw.TextOverflow.clip,
                                      style: const pw.TextStyle(
                                        fontSize: 8,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ],
                          pw.SizedBox(height: 22),
                          pw.Container(
                            constraints: const pw.BoxConstraints(
                              minHeight: 90,
                            ),
                            width: double.infinity,
                            child: pw.Center(
                              child: pw.Text(
                                achievement,
                                textAlign: pw.TextAlign.center,
                                maxLines: 5,
                                style: const pw.TextStyle(
                                  fontSize: 11,
                                  lineSpacing: 5,
                                ),
                              ),
                            ),
                          ),
                          pw.SizedBox(height: 18),
                          _pdfSafetyBadges(pdfPrimaryColor),
                          pw.Spacer(),
                          pw.Row(
                            crossAxisAlignment: pw.CrossAxisAlignment.end,
                            mainAxisAlignment:
                                pw.MainAxisAlignment.spaceBetween,
                            children: [
                              _pdfSignatureBlock(
                                formattedDate,
                                'Date',
                                pdfPrimaryColor,
                              ),
                              _pdfPriorityBadge(pdfPrimaryColor),
                              _pdfSignatureBlock(
                                signatory,
                                'Authorized Signatory',
                                pdfPrimaryColor,
                              ),
                            ],
                          ),
                          pw.SizedBox(height: 16),
                          pw.Container(
                            width: double.infinity,
                            padding: const pw.EdgeInsets.symmetric(
                              vertical: 8,
                            ),
                            decoration: pw.BoxDecoration(
                              color: pdfPrimaryColor,
                              borderRadius: const pw.BorderRadius.only(
                                bottomLeft: pw.Radius.circular(12),
                                bottomRight: pw.Radius.circular(12),
                              ),
                            ),
                            child: pw.Text(
                              footer,
                              textAlign: pw.TextAlign.center,
                              maxLines: 2,
                              style: pw.TextStyle(
                                color: PdfColors.white,
                                fontSize: 10,
                                fontWeight: pw.FontWeight.bold,
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

    final Directory directory = await getApplicationDocumentsDirectory();

    final String fileName =
        'SafeNexus_Certificate_${_safeFileName(employeeName)}_'
        '${selectedDate.year}'
        '${selectedDate.month.toString().padLeft(2, '0')}'
        '${selectedDate.day.toString().padLeft(2, '0')}.pdf';

    final File file = File('${directory.path}/$fileName');
    final List<int> bytes = await pdf.save();

    await file.writeAsBytes(bytes, flush: true);
    return file;
  }

  Future<void> _saveCertificatePdf() async {
    if (_isGeneratingPdf) return;

    setState(() {
      _isGeneratingPdf = true;
    });

    try {
      final File file = await _createCertificatePdf();
      _lastSavedPath = file.path;

      if (!mounted) return;

      _showMessage('PDF saved successfully.');

      await showDialog<void>(
        context: context,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            title: const Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green),
                SizedBox(width: 8),
                Expanded(child: Text('PDF Created')),
              ],
            ),
            content: const Text(
              'Your certificate PDF has been generated successfully. You can now share it.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext),
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
      _showMessage('Could not create PDF: $e', error: true);
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
        file = await _createCertificatePdf();
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
        subject: 'SafeNexus HSE Certificate',
        text: 'Certificate generated by SafeNexus HSE.',
      );
    } catch (e) {
      _showMessage('Could not share PDF: $e', error: true);
    } finally {
      if (mounted) {
        setState(() {
          _isGeneratingPdf = false;
        });
      }
    }
  }

  pw.TextAlign _pdfTextAlign(TextAlign alignment) {
    switch (alignment) {
      case TextAlign.left:
        return pw.TextAlign.left;
      case TextAlign.right:
        return pw.TextAlign.right;
      case TextAlign.center:
      case TextAlign.justify:
      default:
        return pw.TextAlign.center;
    }
  }

  pw.Widget _pdfSafetyBadges(PdfColor color) {
    const List<String> labels = [
      'BE SAFE',
      'WORK SAFE',
      'STAY SAFE',
      'GO HOME SAFE',
    ];

    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
      children: labels.map((String label) {
        return pw.Column(
          children: [
            pw.Container(
              width: 38,
              height: 38,
              decoration: pw.BoxDecoration(
                shape: pw.BoxShape.circle,
                border: pw.Border.all(color: color, width: 1),
              ),
              child: pw.Center(
                child: pw.Text(
                  '鉁�',
                  style: pw.TextStyle(
                    color: color,
                    fontSize: 17,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
            ),
            pw.SizedBox(height: 4),
            pw.Text(
              label,
              style: pw.TextStyle(
                color: color,
                fontSize: 6,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
          ],
        );
      }).toList(),
    );
  }

  pw.Widget _pdfPriorityBadge(PdfColor color) {
    return pw.Container(
      width: 68,
      height: 68,
      decoration: pw.BoxDecoration(
        color: color,
        shape: pw.BoxShape.circle,
        border: pw.Border.all(
          color: PdfColors.white,
          width: 3,
        ),
      ),
      child: pw.Center(
        child: pw.Text(
          'SAFETY\nIS OUR\nPRIORITY',
          textAlign: pw.TextAlign.center,
          style: pw.TextStyle(
            color: PdfColors.white,
            fontSize: 8,
            fontWeight: pw.FontWeight.bold,
            lineSpacing: 1,
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
      width: 125,
      child: pw.Column(
        children: [
          pw.Container(
            height: 1,
            color: PdfColors.grey700,
          ),
          pw.SizedBox(height: 5),
          pw.Text(
            value,
            textAlign: pw.TextAlign.center,
            maxLines: 2,
            style: const pw.TextStyle(fontSize: 8),
          ),
          pw.SizedBox(height: 3),
          pw.Text(
            label,
            textAlign: pw.TextAlign.center,
            style: pw.TextStyle(
              color: color,
              fontSize: 7,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  void _editText({
    required String title,
    required TextEditingController controller,
    int maxLines = 1,
  }) {
    final TextEditingController tempController =
        TextEditingController(text: controller.text);

    showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(title),
          content: TextField(
            controller: tempController,
            maxLines: maxLines,
            autofocus: true,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                tempController.dispose();
                Navigator.pop(dialogContext);
              },
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                setState(() {
                  controller.text = tempController.text;
                  _lastSavedPath = null;
                });
                tempController.dispose();
                Navigator.pop(dialogContext);
              },
              child: const Text('Apply'),
            ),
          ],
        );
      },
    );
  }

  Widget _sectionTitle(IconData icon, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, color: primaryColor),
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
          setState(() {
            _lastSavedPath = null;
          });
        },
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: icon == null ? null : Icon(icon),
          border: const OutlineInputBorder(),
          isDense: true,
        ),
      ),
    );
  }

  Widget _templateCard(int index) {
    final bool isSelected = selectedTemplate == index;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedTemplate = index;
            _lastSavedPath = null;
          });
        },
        child: Container(
          margin: const EdgeInsets.only(right: 8),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isSelected
                ? primaryColor.withValues(alpha: 0.08)
                : Colors.white,
            borderRadius: BorderRadius.circular(12),
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
                      themeColors[index].withValues(alpha: 0.18),
                      Colors.white,
                    ],
                  ),
                  border: Border.all(color: themeColors[index]),
                  borderRadius: BorderRadius.circular(8),
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
    final String previewName = _cleanText(
      _nameController.text,
      fallback: 'Employee Name',
    );
    final String previewCompany = _cleanText(
      _companyController.text,
      fallback: 'SafeNexus HSE',
    );
    final String previewTitle = _cleanText(
      _titleController.text,
      fallback: 'CERTIFICATE',
    );
    final String previewSubtitle = _cleanText(
      _subtitleController.text,
      fallback: 'OF APPRECIATION',
    );
    final String previewId = _cleanText(_idController.text);
    final String previewDepartment =
        _cleanText(_departmentController.text);
    final String previewAchievement = _cleanMultilineText(
      _achievementController.text,
      fallback:
          'For your outstanding commitment to Health, Safety & Environment\n'
          'and for actively contributing to a safe and sustainable workplace.',
    );
    final String previewSignatory = _cleanText(
      _signatoryController.text,
      fallback: 'Authorized Signatory',
    );
    final String previewFooter = _cleanText(
      _footerController.text,
      fallback: 'Identify. Report. Stay Safe.',
    );

    return AspectRatio(
      aspectRatio: 0.707,
      child: Container(
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: const Color(0xFFFDFEF9),
          border: Border.all(color: primaryColor, width: 8),
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
              color: primaryColor.withValues(alpha: 0.6),
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
                  painter: _ConstructionBackgroundPainter(
                    color: primaryColor,
                  ),
                ),
              ),
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 22,
                    vertical: 18,
                  ),
                  child: Column(
                    children: [
                      _certificateLogo(),
                      const SizedBox(height: 8),
                      Text(
                        previewCompany,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
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
                        previewTitle,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: 'serif',
                          fontSize: 27,
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(color: primaryColor),
                        child: Text(
                          previewSubtitle,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
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
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: primaryColor.withValues(alpha: 0.35),
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          previewName,
                          textAlign: nameAlignment,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: 'cursive',
                            fontSize: nameFontSize,
                            color: primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Container(
                        height: 1,
                        color: primaryColor.withValues(alpha: 0.35),
                      ),
                      if (previewId.isNotEmpty ||
                          previewDepartment.isNotEmpty) ...[
                        const SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (previewId.isNotEmpty)
                              Flexible(
                                child: Text(
                                  'Employee ID: $previewId',
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: 6.5),
                                ),
                              ),
                            if (previewId.isNotEmpty &&
                                previewDepartment.isNotEmpty)
                              const SizedBox(width: 10),
                            if (previewDepartment.isNotEmpty)
                              Flexible(
                                child: Text(
                                  'Department: $previewDepartment',
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: 6.5),
                                ),
                              ),
                          ],
                        ),
                      ],
                      const SizedBox(height: 10),
                      Expanded(
                        child: Column(
                          children: [
                            Expanded(
                              child: Center(
                                child: Text(
                                  previewAchievement,
                                  textAlign: TextAlign.center,
                                  maxLines: 5,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 10,
                                    height: 1.5,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            _safetyBadges(),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          _signatureBlock(formattedDate, 'Date'),
                          _priorityBadge(),
                          _signatureBlock(
                            previewSignatory,
                            'Authorized Signatory',
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                        ),
                        child: Text(
                          previewFooter,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
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
          mainAxisAlignment: MainAxisAlignment.center,
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
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: badges.map((List<Object> badge) {
        return Column(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: primaryColor),
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
        border: Border.all(color: Colors.white, width: 3),
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

  Widget _signatureBlock(String value, String label) {
    return SizedBox(
      width: 75,
      child: Column(
        children: [
          Container(height: 1, color: Colors.black54),
          const SizedBox(height: 5),
          Text(
            value,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 7),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            textAlign: TextAlign.center,
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionTitle(Icons.edit, 'Edit Certificate'),
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
          controller: _departmentController,
          icon: Icons.business,
        ),
        _inputField(
          label: 'Achievement / Reason',
          controller: _achievementController,
          icon: Icons.workspace_premium,
          maxLines: 4,
        ),
        _inputField(
          label: 'Company Name',
          controller: _companyController,
          icon: Icons.business_center,
        ),
        _inputField(
          label: 'Authorized Signatory',
          controller: _signatoryController,
          icon: Icons.draw,
        ),
        _inputField(
          label: 'Footer Text',
          controller: _footerController,
          icon: Icons.short_text,
        ),
        InkWell(
          onTap: _selectDate,
          child: InputDecorator(
            decoration: const InputDecoration(
              labelText: 'Certificate Date',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.calendar_today),
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
          label: nameFontSize.round().toString(),
          onChanged: (double value) {
            setState(() {
              nameFontSize = value;
              _lastSavedPath = null;
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
            _alignmentButton(Icons.format_align_left, TextAlign.left),
            _alignmentButton(Icons.format_align_center, TextAlign.center),
            _alignmentButton(Icons.format_align_right, TextAlign.right),
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
            (int index) {
              final bool selected = selectedColor == index;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedColor = index;
                    _lastSavedPath = null;
                  });
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 12),
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: themeColors[index],
                    shape: BoxShape.circle,
                    border: Border.all(
                      color:
                          selected ? Colors.black : Colors.transparent,
                      width: 3,
                    ),
                  ),
                  child: selected
                      ? const Icon(Icons.check, color: Colors.white)
                      : null,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _alignmentButton(IconData icon, TextAlign alignment) {
    final bool selected = nameAlignment == alignment;

    return Padding(
      padding: const EdgeInsets.only(right: 8, top: 8),
      child: OutlinedButton(
        onPressed: () {
          setState(() {
            nameAlignment = alignment;
            _lastSavedPath = null;
          });
        },
        style: OutlinedButton.styleFrom(
          backgroundColor:
              selected ? primaryColor.withValues(alpha: 0.10) : null,
          side: BorderSide(
            color: selected ? primaryColor : Colors.grey.shade300,
          ),
        ),
        child: Icon(
          icon,
          color: selected ? primaryColor : Colors.grey,
        ),
      ),
    );
  }

  Widget _pdfActionButton() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: FilledButton.icon(
            onPressed:
                _isGeneratingPdf ? null : _saveCertificatePdf,
            icon: _isGeneratingPdf
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const Icon(Icons.picture_as_pdf),
            label: Text(
              _isGeneratingPdf
                  ? 'Creating PDF...'
                  : 'Save Certificate PDF',
            ),
            style: FilledButton.styleFrom(
              backgroundColor: primaryColor,
              padding: const EdgeInsets.symmetric(vertical: 15),
            ),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed:
                _isGeneratingPdf ? null : _shareCertificatePdf,
            icon: const Icon(Icons.share),
            label: const Text('Share Certificate PDF'),
            style: OutlinedButton.styleFrom(
              foregroundColor: primaryColor,
              side: BorderSide(color: primaryColor),
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F8F5),
      appBar: AppBar(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'SAFENEXUS HSE',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Certificate Designer',
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Save PDF',
            onPressed:
                _isGeneratingPdf ? null : _saveCertificatePdf,
            icon: const Icon(Icons.picture_as_pdf),
          ),
          IconButton(
            tooltip: 'Share PDF',
            onPressed:
                _isGeneratingPdf ? null : _shareCertificatePdf,
            icon: const Icon(Icons.share),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.workspace_premium,
                    size: 36,
                    color: primaryColor,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Certificate Designer',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        const Text(
                          'Create 鈥� Edit 鈥� Customize 鈥� Export 鈥� Share',
                          style: TextStyle(color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Card(
                elevation: 1,
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _sectionTitle(
                        Icons.dashboard_customize,
                        'Choose Template',
                      ),
                      Row(
                        children: List.generate(
                          templateNames.length,
                          _templateCard,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Card(
                elevation: 1,
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: _editTools(),
                ),
              ),
              const SizedBox(height: 14),
              Card(
                elevation: 1,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _sectionTitle(Icons.visibility, 'Live Preview'),
                      _certificatePreview(),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 14),
              _pdfActionButton(),
              const SizedBox(height: 10),
              if (_lastSavedPath != null)
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Icon(Icons.check_circle, color: primaryColor),
                        const SizedBox(width: 8),
                        const Expanded(
                          child: Text(
                            'Certificate PDF is ready to share.',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _resetCertificate,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Reset'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: _isGeneratingPdf
                          ? null
                          : _saveCertificatePdf,
                      icon: const Icon(Icons.picture_as_pdf),
                      label: const Text('Export PDF'),
                      style: FilledButton.styleFrom(
                        backgroundColor: primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 14),
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

class _ConstructionBackgroundPainter extends CustomPainter {
  final Color color;

  _ConstructionBackgroundPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color.withValues(alpha: 0.06)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    for (double x = 10; x < size.width; x += 45) {
      canvas.drawLine(
        Offset(x, size.height),
        Offset(x + 30, 30),
        paint,
      );
    }

    for (double y = 20; y < size.height; y += 22) {
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(
    covariant _ConstructionBackgroundPainter oldDelegate,
  ) {
    return oldDelegate.color != color;
  }
}
