import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'services/ai_hse_service.dart';

class HazardReportPage extends StatefulWidget {
  const HazardReportPage({super.key});

  @override
  State<HazardReportPage> createState() => _HazardReportPageState();
}

class _HazardReportPageState extends State<HazardReportPage> {
  static const Color primaryGreen = Color(0xFF16835B);
  static const Color pageBackground = Color(0xFFF6F8F7);

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _descriptionController =
      TextEditingController();

  final ImagePicker _picker = ImagePicker();

  final AiHseService _aiService = AiHseService();

  File? _selectedImage;

  bool _isAnalyzing = false;

  AiHseResult? _analysisResult;

  String? _analysisError;

  // ==========================================================
  // LANGUAGE
  // ==========================================================

  bool get _isMalayalam =>
      context.locale.languageCode.toLowerCase().startsWith('ml');

  String _text(String english, String malayalam) {
    return _isMalayalam ? malayalam : english;
  }

  // ==========================================================
  // DISPOSE
  // ==========================================================

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  // ==========================================================
  // PHOTO OPTIONS
  // ==========================================================

  Future<void> _showPhotoOptions() async {
    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(28),
        ),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 45,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  _text(
                    'Select Hazard Photo',
                    'അപകടത്തിന്റെ ഫോട്ടോ തിരഞ്ഞെടുക്കുക',
                  ),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  _text(
                    'Take a new photo or choose from gallery',
                    'പുതിയ ഫോട്ടോ എടുക്കുക അല്ലെങ്കിൽ Gallery തിരഞ്ഞെടുക്കുക',
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 18),
                _photoOptionTile(
                  icon: Icons.camera_alt_rounded,
                  title: _text(
                    'Take Photo',
                    'ഫോട്ടോ എടുക്കുക',
                  ),
                  subtitle: _text(
                    'Capture the hazard using camera',
                    'Camera ഉപയോഗിച്ച് അപകടത്തിന്റെ ഫോട്ടോ എടുക്കുക',
                  ),
                  onTap: () {
                    Navigator.pop(sheetContext);
                    _pickImage(ImageSource.camera);
                  },
                ),
                const SizedBox(height: 10),
                _photoOptionTile(
                  icon: Icons.photo_library_rounded,
                  title: _text(
                    'Choose from Gallery',
                    'Galleryയിൽ നിന്ന് തിരഞ്ഞെടുക്കുക',
                  ),
                  subtitle: _text(
                    'Select an existing hazard photo',
                    'നിലവിലുള്ള ഫോട്ടോ തിരഞ്ഞെടുക്കുക',
                  ),
                  onTap: () {
                    Navigator.pop(sheetContext);
                    _pickImage(ImageSource.gallery);
                  },
                ),
                if (_selectedImage != null) ...[
                  const SizedBox(height: 10),
                  _photoOptionTile(
                    icon: Icons.delete_outline_rounded,
                    title: _text(
                      'Remove Photo',
                      'ഫോട്ടോ നീക്കം ചെയ്യുക',
                    ),
                    subtitle: _text(
                      'Remove the selected hazard photo',
                      'തിരഞ്ഞെടുത്ത ഫോട്ടോ നീക്കം ചെയ്യുക',
                    ),
                    iconColor: Colors.red,
                    onTap: () {
                      Navigator.pop(sheetContext);

                      setState(() {
                        _selectedImage = null;
                        _analysisResult = null;
                        _analysisError = null;
                      });
                    },
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _photoOptionTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Color? iconColor,
  }) {
    final color = iconColor ?? primaryGreen;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: color.withValues(alpha: 0.12),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: color,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              color: Colors.grey.shade500,
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // PICK IMAGE
  // ==========================================================

  Future<void> _pickImage(ImageSource source) async {
    if (_isAnalyzing) {
      return;
    }

    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        imageQuality: 80,
        maxWidth: 1600,
      );

      if (image == null) {
        return;
      }

      if (!mounted) {
        return;
      }

      setState(() {
        _selectedImage = File(image.path);
        _analysisResult = null;
        _analysisError = null;
      });

      await _analyzeHazard(
        automatic: true,
      );
    } catch (_) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red.shade700,
          behavior: SnackBarBehavior.floating,
          content: Text(
            _text(
              'Unable to select photo. Please try again.',
              'ഫോട്ടോ തിരഞ്ഞെടുക്കാൻ കഴിഞ്ഞില്ല. വീണ്ടും ശ്രമിക്കുക.',
            ),
          ),
        ),
      );
    }
  }

  // ==========================================================
  // AI ANALYSIS
  // ==========================================================

  Future<void> _analyzeHazard({
    bool automatic = false,
  }) async {
    if (_selectedImage == null) {
      if (!automatic) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text(
              _text(
                'Please select a hazard photo first.',
                'ആദ്യം അപകടത്തിന്റെ ഫോട്ടോ തിരഞ്ഞെടുക്കുക.',
              ),
            ),
          ),
        );
      }
      return;
    }

    if (_isAnalyzing) {
      return;
    }

    final language = _isMalayalam ? 'ml' : 'en';

    setState(() {
      _isAnalyzing = true;
      _analysisResult = null;
      _analysisError = null;
    });

    try {
      final AiHseResult result = await _aiService.analyzePhoto(
        imageFile: _selectedImage!,
        description: _descriptionController.text.trim(),
        language: language,
      );

      if (!mounted) {
        return;
      }

      setState(() {
        _analysisResult = result;

        if (_descriptionController.text.trim().isEmpty) {
          final explanation = result.explanation.trim();
          final hazard = result.hazard.trim();

          if (explanation.isNotEmpty) {
            _descriptionController.text = explanation;
          } else if (hazard.isNotEmpty) {
            _descriptionController.text = hazard;
          }
        }
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green.shade700,
          behavior: SnackBarBehavior.floating,
          content: Text(
            _text(
              'AI HSE analysis completed successfully.',
              'AI HSE വിശകലനം വിജയകരമായി പൂർത്തിയായി.',
            ),
          ),
        ),
      );
    } catch (e) {
      if (!mounted) {
        return;
      }

      final errorText = e.toString().toLowerCase();

      final isCreditError =
          errorText.contains('429') ||
          errorText.contains('credit') ||
          errorText.contains('quota') ||
          errorText.contains('insufficient');

      setState(() {
        _analysisError = isCreditError
            ? _text(
                'AI analysis is temporarily unavailable because API credits or usage limits have been reached. You can continue the report and try again later.',
                'API credit അല്ലെങ്കിൽ usage limit തീർന്നതിനാൽ AI വിശകലനം ഇപ്പോൾ ലഭ്യമല്ല. Report തുടരാം; പിന്നീട് വീണ്ടും ശ്രമിക്കാം.',
              )
            : _text(
                'AI analysis could not be completed. Please try again.',
                'AI വിശകലനം പൂർത്തിയാക്കാൻ കഴിഞ്ഞില്ല. വീണ്ടും ശ്രമിക്കുക.',
              );
      });
    } finally {
      if (mounted) {
        setState(() {
          _isAnalyzing = false;
        });
      }
    }
  }

  // ==========================================================
  // SECTION HEADER
  // ==========================================================

  Widget _sectionHeader({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: primaryGreen.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: primaryGreen,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ==========================================================
  // PHOTO PREVIEW
  // ==========================================================

  Widget _buildPhotoPreview() {
    if (_selectedImage == null) {
      return InkWell(
        onTap: _isAnalyzing ? null : _showPhotoOptions,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: double.infinity,
          height: 190,
          decoration: BoxDecoration(
            color: primaryGreen.withValues(alpha: 0.04),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: primaryGreen.withValues(alpha: 0.20),
              width: 1.5,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 62,
                height: 62,
                decoration: BoxDecoration(
                  color: primaryGreen.withValues(alpha: 0.10),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.add_a_photo_rounded,
                  size: 30,
                  color: primaryGreen,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                _text(
                  'Add Hazard Photo',
                  'അപകടത്തിന്റെ ഫോട്ടോ ചേർക്കുക',
                ),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                _text(
                  'Camera or Gallery',
                  'Camera അല്ലെങ്കിൽ Gallery',
                ),
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Stack(
        children: [
          Image.file(
            _selectedImage!,
            width: double.infinity,
            height: 250,
            fit: BoxFit.cover,
          ),

          Positioned(
            left: 12,
            top: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 7,
              ),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.54),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.photo_camera_rounded,
                    color: Colors.white,
                    size: 15,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    _text(
                      'Hazard Photo',
                      'അപകട ഫോട്ടോ',
                    ),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            right: 12,
            top: 12,
            child: Material(
              color: Colors.black.withValues(alpha: 0.54),
              shape: const CircleBorder(),
              child: IconButton(
                color: Colors.white,
                icon: const Icon(Icons.close),
                onPressed: _isAnalyzing
                    ? null
                    : () {
                        setState(() {
                          _selectedImage = null;
                          _analysisResult = null;
                          _analysisError = null;
                        });
                      },
              ),
            ),
          ),

          if (_isAnalyzing)
            Positioned.fill(
              child: Container(
                color: Colors.black.withValues(alpha: 0.45),
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            color: primaryGreen,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          _text(
                            'AI Analyzing...',
                            'AI പരിശോധിക്കുന്നു...',
                          ),
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  // ==========================================================
  // AI ERROR CARD
  // ==========================================================

  Widget _buildAnalysisError() {
    if (_analysisError == null) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.orange.shade200,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline_rounded,
            color: Colors.orange.shade800,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              _analysisError!,
              style: TextStyle(
                color: Colors.orange.shade900,
                fontSize: 13,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // RESULT ROW
  // ==========================================================

  Widget _resultRow(
    String title,
    String value, {
    IconData icon = Icons.chevron_right_rounded,
  }) {
    if (value.trim().isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(13),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(13),
          border: Border.all(
            color: Colors.grey.shade200,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              size: 19,
              color: primaryGreen,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.4,
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

  // ==========================================================
  // RISK COLOR
  // ==========================================================

  Color _riskColor(String risk) {
    switch (risk.toLowerCase().trim()) {
      case 'critical':
        return Colors.deepPurple;
      case 'high':
        return Colors.red.shade700;
      case 'medium':
        return Colors.orange.shade700;
      case 'low':
        return Colors.green.shade700;
      default:
        return Colors.grey.shade700;
    }
  }

  // ==========================================================
  // RISK ICON
  // ==========================================================

  IconData _riskIcon(String risk) {
    switch (risk.toLowerCase().trim()) {
      case 'critical':
        return Icons.dangerous_rounded;
      case 'high':
        return Icons.warning_rounded;
      case 'medium':
        return Icons.warning_amber_rounded;
      case 'low':
        return Icons.check_circle_rounded;
      default:
        return Icons.help_outline_rounded;
    }
  }

  // ==========================================================
  // AI RESULT CARD
  // ==========================================================

  Widget _buildAnalysisResult() {
    final result = _analysisResult;

    if (result == null) {
      return const SizedBox.shrink();
    }

    final riskColor = _riskColor(result.riskLevel);

    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: primaryGreen.withValues(alpha: 0.18),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 18,
            offset: const Offset(0, 7),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: primaryGreen.withValues(alpha: 0.10),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.auto_awesome_rounded,
                  color: primaryGreen,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _text(
                        'AI HSE Analysis',
                        'AI HSE വിശകലനം',
                      ),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      _text(
                        'Safety assessment from your photo',
                        'ഫോട്ടോ അടിസ്ഥാനമാക്കിയുള്ള Safety Assessment',
                      ),
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          // Risk Level
          if (result.riskLevel.trim().isNotEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: riskColor.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: riskColor.withValues(alpha: 0.25),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    _riskIcon(result.riskLevel),
                    color: riskColor,
                    size: 28,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      _text(
                        'Risk Level',
                        'റിസ്ക് ലെവൽ',
                      ),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: riskColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      result.riskLevel,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),

          const SizedBox(height: 16),

          _resultRow(
            _text('Observation Type', 'Observation Type'),
            result.observationType,
            icon: Icons.visibility_outlined,
          ),

          _resultRow(
            _text('Category', 'Category'),
            result.category,
            icon: Icons.category_outlined,
          ),

          _resultRow(
            _text('Hazard', 'Hazard'),
            result.hazard,
            icon: Icons.warning_amber_rounded,
          ),

          _resultRow(
            _text(
              'Potential Consequence',
              'സാധ്യതയുള്ള Consequence',
            ),
            result.potentialConsequence,
            icon: Icons.report_problem_outlined,
          ),

          _resultRow(
            _text(
              'Corrective Action',
              'Corrective Action',
            ),
            result.correctiveAction,
            icon: Icons.build_circle_outlined,
          ),

          _resultRow(
            _text(
              'AI Explanation',
              'AI വിശദീകരണം',
            ),
            result.explanation,
            icon: Icons.lightbulb_outline_rounded,
          ),

          const SizedBox(height: 2),

          // Confidence
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(13),
            decoration: BoxDecoration(
              color: primaryGreen.withValues(alpha: 0.07),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.verified_rounded,
                  color: primaryGreen,
                ),
                const SizedBox(width: 9),
                Expanded(
                  child: Text(
                    _text(
                      'AI Confidence',
                      'AI Confidence',
                    ),
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  '${(result.confidence * 100).toStringAsFixed(0)}%',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: primaryGreen,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // HSE Review Warning
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(13),
            decoration: BoxDecoration(
              color: Colors.orange.shade50,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: Colors.orange.shade200,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.warning_amber_rounded,
                  color: Colors.orange.shade800,
                ),
                const SizedBox(width: 9),
                Expanded(
                  child: Text(
                    _text(
                      'AI result must be reviewed by the HSE officer before taking action.',
                      'Action എടുക്കുന്നതിന് മുമ്പ് AI result HSE Officer പരിശോധിക്കണം.',
                    ),
                    style: TextStyle(
                      color: Colors.orange.shade900,
                      fontSize: 12,
                      height: 1.4,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // BUILD
  // ==========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBackground,

      // ======================================================
      // APP BAR
      // ======================================================

      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        titleSpacing: 18,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'hazard_report'.tr(),
              style: const TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              _text(
                'Report hazards. Protect lives.',
                'അപകടങ്ങൾ റിപ്പോർട്ട് ചെയ്യൂ. ജീവൻ സംരക്ഷിക്കൂ.',
              ),
              style: TextStyle(
                fontSize: 10,
                color: Colors.white.withValues(alpha: 0.85),
              ),
            ),
          ],
        ),
        actions: [
          PopupMenuButton<Locale>(
            onSelected: (Locale locale) {
              context.setLocale(locale);
            },
            itemBuilder: (BuildContext context) =>
                <PopupMenuEntry<Locale>>[
              const PopupMenuItem(
                value: Locale('en', 'US'),
                child: Row(
                  children: [
                    Icon(Icons.language),
                    SizedBox(width: 10),
                    Text('English'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: Locale('ml', 'IN'),
                child: Row(
                  children: [
                    Icon(Icons.translate),
                    SizedBox(width: 10),
                    Text('മലയാളം'),
                  ],
                ),
              ),
            ],
            icon: const Icon(
              Icons.language_rounded,
            ),
          ),
        ],
      ),

      // ======================================================
      // BODY
      // ======================================================

      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(16, 18, 16, 30),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ==================================================
                // INTRO CARD
                // ==================================================

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: primaryGreen,
                    borderRadius: BorderRadius.circular(22),
                    boxShadow: [
                      BoxShadow(
                        color: primaryGreen.withValues(alpha: 0.20),
                        blurRadius: 16,
                        offset: const Offset(0, 7),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.15),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.health_and_safety_rounded,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Text(
                              _text(
                                'Safety First',
                                'Safety First',
                              ),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              _text(
                                'Describe the hazard and add a photo for AI-assisted assessment.',
                                'Hazard വിവരങ്ങൾ നൽകുകയും AI Assessment നായി ഫോട്ടോ ചേർക്കുകയും ചെയ്യുക.',
                              ),
                              style: TextStyle(
                                color:
                                    Colors.white.withValues(alpha: 0.90),
                                fontSize: 12,
                                height: 1.35,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 22),

                // ==================================================
                // HAZARD DESCRIPTION
                // ==================================================

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(17),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.grey.shade200,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _sectionHeader(
                        icon: Icons.description_outlined,
                        title: 'hazard_desc_label'.tr(),
                        subtitle: _text(
                          'Provide details about what you observed.',
                          'നിങ്ങൾ കണ്ട അപകടത്തെക്കുറിച്ച് വിശദമായി എഴുതുക.',
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _descriptionController,
                        maxLines: 5,
                        maxLength: 500,
                        textInputAction: TextInputAction.newline,
                        decoration: InputDecoration(
                          hintText: 'hazard_hint'.tr(),
                          hintStyle: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 13,
                          ),
                          filled: true,
                          fillColor: const Color(0xFFF8FAF9),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: Colors.grey.shade200,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                              color: Colors.grey.shade200,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(
                              color: primaryGreen,
                              width: 1.5,
                            ),
                          ),
                          contentPadding:
                              const EdgeInsets.all(15),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 18),

                // ==================================================
                // PHOTO SECTION
                // ==================================================

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(17),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.grey.shade200,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _sectionHeader(
                        icon: Icons.photo_camera_outlined,
                        title: _text(
                          'Hazard Photo',
                          'അപകടത്തിന്റെ ഫോട്ടോ',
                        ),
                        subtitle: _text(
                          'Add a clear photo of the unsafe condition.',
                          'Unsafe condition വ്യക്തമായി കാണുന്ന ഫോട്ടോ ചേർക്കുക.',
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildPhotoPreview(),
                      if (_selectedImage != null &&
                          !_isAnalyzing)
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 12),
                          child: SizedBox(
                            width: double.infinity,
                            child: OutlinedButton.icon(
                              onPressed: _showPhotoOptions,
                              icon: const Icon(
                                Icons.change_circle_outlined,
                              ),
                              label: Text(
                                _text(
                                  'Change Photo',
                                  'ഫോട്ടോ മാറ്റുക',
                                ),
                              ),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: primaryGreen,
                                side: const BorderSide(
                                  color: primaryGreen,
                                ),
                                padding:
                                    const EdgeInsets.symmetric(
                                  vertical: 13,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(14),
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

                // ==================================================
                // AI ERROR
                // ==================================================

                _buildAnalysisError(),

                const SizedBox(height: 18),

                // ==================================================
                // AI BUTTON
                // ==================================================

                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: FilledButton.icon(
                    onPressed:
                        _isAnalyzing ||
                                _selectedImage == null
                            ? null
                            : () => _analyzeHazard(
                                  automatic: false,
                                ),
                    icon: _isAnalyzing
                        ? const SizedBox(
                            width: 21,
                            height: 21,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              color: Colors.white,
                            ),
                          )
                        : const Icon(
                            Icons.auto_awesome_rounded,
                          ),
                    label: Text(
                      _isAnalyzing
                          ? _text(
                              'Analyzing...',
                              'വിശകലനം ചെയ്യുന്നു...',
                            )
                          : _text(
                              'Analyze with AI',
                              'AI ഉപയോഗിച്ച് വിശകലനം ചെയ്യുക',
                            ),
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: FilledButton.styleFrom(
                      backgroundColor: primaryGreen,
                      disabledBackgroundColor:
                          Colors.grey.shade300,
                      foregroundColor: Colors.white,
                      disabledForegroundColor:
                          Colors.grey.shade600,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),

                if (_selectedImage == null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Center(
                      child: Text(
                        _text(
                          'Select a photo to enable AI analysis.',
                          'AI Analysis ലഭിക്കാൻ ആദ്യം ഫോട്ടോ തിരഞ്ഞെടുക്കുക.',
                        ),
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                  ),

                // ==================================================
                // AI RESULT
                // ==================================================

                _buildAnalysisResult(),

                const SizedBox(height: 22),

                // ==================================================
                // SAFETY NOTICE
                // ==================================================

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(17),
                    border: Border.all(
                      color: Colors.blue.shade100,
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.security_rounded,
                        color: Colors.blue.shade700,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          _text(
                            'AI is an assistance tool. Always verify the observation and risk level using professional HSE judgement.',
                            'AI ഒരു സഹായക ഉപകരണം മാത്രമാണ്. Observation, Risk Level എന്നിവ professional HSE judgement ഉപയോഗിച്ച് എപ്പോഴും പരിശോധിക്കുക.',
                          ),
                          style: TextStyle(
                            color: Colors.blue.shade900,
                            fontSize: 12,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                Center(
                  child: Text(
                    'SafeNexus HSE',
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
