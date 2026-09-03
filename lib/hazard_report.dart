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
  static const Color darkGreen = Color(0xFF0D6042);
  static const Color pageBackground = Color(0xFFF5F8F6);

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _descriptionController =
      TextEditingController();

  final ImagePicker _picker = ImagePicker();
  final AiHseService _aiService = AiHseService();

  File? _selectedImage;
  bool _isAnalyzing = false;

  AiHseResult? _analysisResult;
  String? _analysisError;

  bool get _isMalayalam =>
      context.locale.languageCode.toLowerCase().startsWith('ml');

  String _text(String english, String malayalam) {
    return _isMalayalam ? malayalam : english;
  }

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
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(28),
        ),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 44,
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
                    fontWeight: FontWeight.w800,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  _text(
                    'Take a new photo or choose one from your gallery.',
                    'പുതിയ ഫോട്ടോ എടുക്കുക അല്ലെങ്കിൽ Galleryയിൽ നിന്ന് തിരഞ്ഞെടുക്കുക.',
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 13,
                    height: 1.4,
                  ),
                ),

                const SizedBox(height: 20),

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
                    'നിലവിലുള്ള അപകട ഫോട്ടോ തിരഞ്ഞെടുക്കുക',
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
                      'Remove the selected photo',
                      'തിരഞ്ഞെടുത്ത ഫോട്ടോ നീക്കം ചെയ്യുക',
                    ),
                    iconColor: Colors.red.shade700,
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
          color: color.withValues(alpha: 0.055),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: color.withValues(alpha: 0.13),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.11),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: color,
                size: 23,
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
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 12,
                      height: 1.3,
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
    if (_isAnalyzing) return;

    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        imageQuality: 80,
        maxWidth: 1600,
      );

      if (image == null || !mounted) return;

      setState(() {
        _selectedImage = File(image.path);
        _analysisResult = null;
        _analysisError = null;
      });

      await _analyzeHazard(automatic: true);
    } catch (_) {
      if (!mounted) return;

      _showMessage(
        _text(
          'Unable to select photo. Please try again.',
          'ഫോട്ടോ തിരഞ്ഞെടുക്കാൻ കഴിഞ്ഞില്ല. വീണ്ടും ശ്രമിക്കുക.',
        ),
        isError: true,
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
        _showMessage(
          _text(
            'Please select a hazard photo first.',
            'ആദ്യം അപകടത്തിന്റെ ഫോട്ടോ തിരഞ്ഞെടുക്കുക.',
          ),
        );
      }
      return;
    }

    if (_isAnalyzing) return;

    final String language = _isMalayalam ? 'ml' : 'en';

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

      if (!mounted) return;

      setState(() {
        _analysisResult = result;

        if (_descriptionController.text.trim().isEmpty) {
          final String explanation = result.explanation.trim();
          final String hazard = result.hazard.trim();

          if (explanation.isNotEmpty) {
            _descriptionController.text = explanation;
          } else if (hazard.isNotEmpty) {
            _descriptionController.text = hazard;
          }
        }
      });

      _showMessage(
        _text(
          'AI HSE analysis completed successfully.',
          'AI HSE വിശകലനം വിജയകരമായി പൂർത്തിയായി.',
        ),
        isSuccess: true,
      );
    } catch (e) {
      if (!mounted) return;

      final String errorText = e.toString().toLowerCase();

      final bool isCreditError =
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
  // MESSAGE
  // ==========================================================

  void _showMessage(
    String message, {
    bool isError = false,
    bool isSuccess = false,
  }) {
    final Color color = isError
        ? Colors.red.shade700
        : isSuccess
            ? primaryGreen
            : Colors.blueGrey.shade800;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        content: Text(
          message,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
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
          width: 43,
          height: 43,
          decoration: BoxDecoration(
            color: primaryGreen.withValues(alpha: 0.09),
            borderRadius: BorderRadius.circular(13),
          ),
          child: Icon(
            icon,
            color: primaryGreen,
            size: 22,
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
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                  height: 1.35,
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
          height: 200,
          decoration: BoxDecoration(
            color: primaryGreen.withValues(alpha: 0.035),
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
                width: 68,
                height: 68,
                decoration: BoxDecoration(
                  color: primaryGreen.withValues(alpha: 0.10),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.add_a_photo_rounded,
                  size: 31,
                  color: primaryGreen,
                ),
              ),
              const SizedBox(height: 13),
              Text(
                _text(
                  'Add Hazard Photo',
                  'അപകടത്തിന്റെ ഫോട്ടോ ചേർക്കുക',
                ),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
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
            height: 255,
            fit: BoxFit.cover,
          ),

          Positioned.fill(
            child: IgnorePointer(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.30),
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.20),
                    ],
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            left: 12,
            top: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 11,
                vertical: 7,
              ),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.55),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.photo_camera_rounded,
                    color: Colors.white,
                    size: 15,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    _text(
                      'Hazard Photo',
                      'അപകട ഫോട്ടോ',
                    ),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            right: 10,
            top: 10,
            child: Material(
              color: Colors.black.withValues(alpha: 0.55),
              shape: const CircleBorder(),
              child: IconButton(
                color: Colors.white,
                tooltip: _text(
                  'Remove photo',
                  'ഫോട്ടോ നീക്കം ചെയ്യുക',
                ),
                icon: const Icon(
                  Icons.close_rounded,
                ),
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
                color: Colors.black.withValues(alpha: 0.48),
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 35),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 17,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.18),
                          blurRadius: 20,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                          width: 34,
                          height: 34,
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                            color: primaryGreen,
                          ),
                        ),
                        const SizedBox(height: 13),
                        Text(
                          _text(
                            'AI is analyzing the hazard...',
                            'AI അപകടം പരിശോധിക്കുന്നു...',
                          ),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          _text(
                            'Please wait',
                            'ദയവായി കാത്തിരിക്കുക',
                          ),
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 12,
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
  // ERROR CARD
  // ==========================================================

  Widget _buildAnalysisError() {
    if (_analysisError == null) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(15),
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
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: Colors.orange.shade100,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.info_outline_rounded,
              color: Colors.orange.shade800,
              size: 21,
            ),
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Text(
              _analysisError!,
              style: TextStyle(
                color: Colors.orange.shade900,
                fontSize: 12.5,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // RESULT ITEM
  // ==========================================================

  Widget _resultItem({
    required IconData icon,
    required String title,
    required String value,
    Color? iconColor,
  }) {
    if (value.trim().isEmpty) {
      return const SizedBox.shrink();
    }

    final Color color = iconColor ?? primaryGreen;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.09),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              size: 19,
              color: color,
            ),
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w800,
                    color: Colors.grey.shade700,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 13.5,
                    height: 1.45,
                    fontWeight: FontWeight.w500,
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
  // RISK HELPERS
  // ==========================================================

  Color _riskColor(String risk) {
    switch (risk.toLowerCase().trim()) {
      case 'critical':
        return Colors.deepPurple.shade700;
      case 'high':
        return Colors.red.shade700;
      case 'medium':
        return Colors.orange.shade700;
      case 'low':
        return Colors.green.shade700;
      default:
        return Colors.blueGrey.shade700;
    }
  }

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

  String _riskMalayalam(String risk) {
    switch (risk.toLowerCase().trim()) {
      case 'critical':
        return 'Critical / അതീവ ഗുരുതരം';
      case 'high':
        return 'High / ഉയർന്നത്';
      case 'medium':
        return 'Medium / മിതമായത്';
      case 'low':
        return 'Low / കുറഞ്ഞത്';
      default:
        return risk;
    }
  }

  // ==========================================================
  // RISK CARD
  // ==========================================================

  Widget _buildRiskCard(AiHseResult result) {
    final Color riskColor = _riskColor(result.riskLevel);

    final double confidence =
        result.confidence.clamp(0.0, 1.0).toDouble();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: riskColor.withValues(alpha: 0.075),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: riskColor.withValues(alpha: 0.28),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: riskColor.withValues(alpha: 0.13),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _riskIcon(result.riskLevel),
                  color: riskColor,
                  size: 27,
                ),
              ),
              const SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _text(
                        'Risk Level',
                        'റിസ്ക് ലെവൽ',
                      ),
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _isMalayalam
                          ? _riskMalayalam(result.riskLevel)
                          : result.riskLevel,
                      style: TextStyle(
                        color: riskColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: riskColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  result.riskLevel.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),

          Container(
            height: 1,
            color: riskColor.withValues(alpha: 0.12),
          ),

          const SizedBox(height: 13),

          Row(
            children: [
              Icon(
                Icons.shield_outlined,
                size: 18,
                color: riskColor,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  _text(
                    'AI-assisted risk classification',
                    'AI സഹായത്തോടെ Risk Classification',
                  ),
                  style: TextStyle(
                    fontSize: 11.5,
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Text(
                '${(confidence * 100).toStringAsFixed(0)}%',
                style: TextStyle(
                  color: riskColor,
                  fontWeight: FontWeight.w900,
                  fontSize: 13,
                ),
              ),
            ],
          ),

          const SizedBox(height: 7),

          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              value: confidence,
              minHeight: 7,
              backgroundColor: riskColor.withValues(alpha: 0.12),
              color: riskColor,
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // AI RESULT CARD
  // ==========================================================

  Widget _buildAnalysisResult() {
    final AiHseResult? result = _analysisResult;

    if (result == null) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(23),
        border: Border.all(
          color: primaryGreen.withValues(alpha: 0.18),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.055),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --------------------------------------------------
          // AI HEADER
          // --------------------------------------------------

          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      primaryGreen,
                      darkGreen,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Icon(
                  Icons.auto_awesome_rounded,
                  color: Colors.white,
                  size: 25,
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
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      _text(
                        'Safety assessment from your photo',
                        'ഫോട്ടോ അടിസ്ഥാനമാക്കിയുള്ള Safety Assessment',
                      ),
                      style: TextStyle(
                        fontSize: 11.5,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 9,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: primaryGreen.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.check_circle_rounded,
                      size: 14,
                      color: primaryGreen,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      _text(
                        'AI Ready',
                        'AI Ready',
                      ),
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        color: primaryGreen,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          // --------------------------------------------------
          // RISK
          // --------------------------------------------------

          _buildRiskCard(result),

          const SizedBox(height: 14),

          // --------------------------------------------------
          // OBSERVATION
          // --------------------------------------------------

          _resultItem(
            icon: Icons.visibility_outlined,
            title: _text(
              'Observation Type',
              'Observation Type',
            ),
            value: result.observationType,
          ),

          // --------------------------------------------------
          // CATEGORY
          // --------------------------------------------------

          _resultItem(
            icon: Icons.category_outlined,
            title: _text(
              'Category',
              'Category',
            ),
            value: result.category,
          ),

          // --------------------------------------------------
          // HAZARD
          // --------------------------------------------------

          _resultItem(
            icon: Icons.warning_amber_rounded,
            title: _text(
              'Hazard',
              'Hazard / അപകടം',
            ),
            value: result.hazard,
            iconColor: Colors.orange.shade700,
          ),

          // --------------------------------------------------
          // CONSEQUENCE
          // --------------------------------------------------

          _resultItem(
            icon: Icons.report_problem_outlined,
            title: _text(
              'Potential Consequence',
              'സാധ്യതയുള്ള Consequence',
            ),
            value: result.potentialConsequence,
            iconColor: Colors.red.shade700,
          ),

          // --------------------------------------------------
          // CORRECTIVE ACTION
          // --------------------------------------------------

          _resultItem(
            icon: Icons.build_circle_outlined,
            title: _text(
              'Corrective Action',
              'Corrective Action',
            ),
            value: result.correctiveAction,
            iconColor: primaryGreen,
          ),

          // --------------------------------------------------
          // AI EXPLANATION
          // --------------------------------------------------

          _resultItem(
            icon: Icons.lightbulb_outline_rounded,
            title: _text(
              'AI Explanation',
              'AI വിശദീകരണം',
            ),
            value: result.explanation,
            iconColor: Colors.amber.shade800,
          ),

          const SizedBox(height: 4),

          // --------------------------------------------------
          // REVIEW WARNING
          // --------------------------------------------------

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.orange.shade50,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.orange.shade200,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                    color: Colors.orange.shade100,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.engineering_rounded,
                    color: Colors.orange.shade800,
                    size: 19,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    _text(
                      'HSE Review Required\nAI results are assistance only. Verify the observation, risk level and corrective action using professional HSE judgement before taking action.',
                      'HSE Review ആവശ്യമാണ്\nAI result ഒരു സഹായം മാത്രമാണ്. Action എടുക്കുന്നതിന് മുമ്പ് Observation, Risk Level, Corrective Action എന്നിവ professional HSE judgement ഉപയോഗിച്ച് പരിശോധിക്കുക.',
                    ),
                    style: TextStyle(
                      color: Colors.orange.shade900,
                      fontSize: 11.5,
                      height: 1.45,
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
  // MAIN BUILD
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
        scrolledUnderElevation: 0,
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
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              _text(
                'Report hazards. Protect lives.',
                'അപകടങ്ങൾ റിപ്പോർട്ട് ചെയ്യൂ. ജീവൻ സംരക്ഷിക്കൂ.',
              ),
              style: TextStyle(
                fontSize: 10.5,
                color: Colors.white.withValues(alpha: 0.86),
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
                    Icon(Icons.language_rounded),
                    SizedBox(width: 10),
                    Text('English'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: Locale('ml', 'IN'),
                child: Row(
                  children: [
                    Icon(Icons.translate_rounded),
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
          padding: const EdgeInsets.fromLTRB(
            16,
            18,
            16,
            32,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ==================================================
                // INTRO
                // ==================================================

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        primaryGreen,
                        darkGreen,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(23),
                    boxShadow: [
                      BoxShadow(
                        color: primaryGreen.withValues(alpha: 0.22),
                        blurRadius: 18,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 58,
                        height: 58,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.14),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.health_and_safety_rounded,
                          color: Colors.white,
                          size: 31,
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
                                fontSize: 19,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              _text(
                                'Describe the hazard and add a photo for AI-assisted safety assessment.',
                                'Hazard വിവരങ്ങൾ നൽകുകയും AI Safety Assessment നായി ഫോട്ടോ ചേർക്കുകയും ചെയ്യുക.',
                              ),
                              style: TextStyle(
                                color:
                                    Colors.white.withValues(alpha: 0.91),
                                fontSize: 12,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // ==================================================
                // DESCRIPTION
                // ==================================================

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(17),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(21),
                    border: Border.all(
                      color: Colors.grey.shade200,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.025),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
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
                      const SizedBox(height: 15),
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
                            height: 1.4,
                          ),
                          filled: true,
                          fillColor: const Color(0xFFF8FAF9),
                          counterStyle: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 10,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                              color: Colors.grey.shade200,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                              color: Colors.grey.shade200,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(
                              color: primaryGreen,
                              width: 1.6,
                            ),
                          ),
                          contentPadding: const EdgeInsets.all(15),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // ==================================================
                // PHOTO
                // ==================================================

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(17),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(21),
                    border: Border.all(
                      color: Colors.grey.shade200,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.025),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
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
                      const SizedBox(height: 15),
                      _buildPhotoPreview(),

                      if (_selectedImage != null &&
                          !_isAnalyzing)
                        Padding(
                          padding: const EdgeInsets.only(top: 12),
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
                                padding: const EdgeInsets.symmetric(
                                  vertical: 13,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(15),
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

                // ==================================================
                // ERROR
                // ==================================================

                _buildAnalysisError(),

                const SizedBox(height: 16),

                // ==================================================
                // AI BUTTON
                // ==================================================

                SizedBox(
                  width: double.infinity,
                  height: 56,
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
                            size: 21,
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
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    style: FilledButton.styleFrom(
                      backgroundColor: primaryGreen,
                      disabledBackgroundColor: Colors.grey.shade300,
                      foregroundColor: Colors.white,
                      disabledForegroundColor: Colors.grey.shade600,
                      elevation: 0,
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
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                  ),

                // ==================================================
                // RESULT
                // ==================================================

                _buildAnalysisResult(),

                const SizedBox(height: 20),

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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          color: Colors.blue.shade100,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.security_rounded,
                          color: Colors.blue.shade700,
                          size: 19,
                        ),
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
                            fontSize: 11.5,
                            height: 1.45,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 14),

                Center(
                  child: Text(
                    'SafeNexus HSE',
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),

                const SizedBox(height: 3),

                Center(
                  child: Text(
                    _text(
                      'AI-assisted HSE reporting',
                      'AI സഹായത്തോടെ HSE Reporting',
                    ),
                    style: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 9.5,
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
