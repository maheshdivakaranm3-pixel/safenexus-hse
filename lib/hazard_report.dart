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
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _descriptionController =
      TextEditingController();

  final ImagePicker _picker = ImagePicker();

  final AiHseService _aiService = AiHseService();

  File? _selectedImage;

  bool _isAnalyzing = false;

  AiHseResult? _analysisResult;

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
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(22),
        ),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 12,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: EdgeInsets.all(12),
                  child: Text(
                    'Select Hazard Photo',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                // CAMERA
                ListTile(
                  leading: const CircleAvatar(
                    child: Icon(Icons.camera_alt),
                  ),
                  title: const Text(
                    'Take Photo',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: const Text(
                    'Capture a hazard using camera',
                  ),
                  onTap: () {
                    Navigator.pop(sheetContext);

                    _pickImage(
                      ImageSource.camera,
                    );
                  },
                ),

                // GALLERY
                ListTile(
                  leading: const CircleAvatar(
                    child: Icon(
                      Icons.photo_library,
                    ),
                  ),
                  title: const Text(
                    'Choose from Gallery',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: const Text(
                    'Select an existing hazard photo',
                  ),
                  onTap: () {
                    Navigator.pop(sheetContext);

                    _pickImage(
                      ImageSource.gallery,
                    );
                  },
                ),

                // REMOVE
                if (_selectedImage != null)
                  ListTile(
                    leading: const CircleAvatar(
                      child: Icon(
                        Icons.delete_outline,
                      ),
                    ),
                    title: const Text(
                      'Remove Photo',
                    ),
                    onTap: () {
                      Navigator.pop(sheetContext);

                      setState(() {
                        _selectedImage = null;
                        _analysisResult = null;
                      });
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ==========================================================
  // PICK IMAGE
  // ==========================================================

  Future<void> _pickImage(
    ImageSource source,
  ) async {
    if (_isAnalyzing) {
      return;
    }

    try {
      final XFile? image =
          await _picker.pickImage(
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
      });

      // ======================================================
      // AUTOMATIC AI ANALYSIS
      // Photo selected -> AI starts automatically
      // ======================================================

      await _analyzeHazard(
        automatic: true,
      );
    } catch (e) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            'Unable to select photo: $e',
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
          const SnackBar(
            content: Text(
              'Please select a hazard photo first.',
            ),
          ),
        );
      }

      return;
    }

    if (_isAnalyzing) {
      return;
    }

    // IMPORTANT:
    // language is declared OUTSIDE try block.
    // This fixes the flutter analyze error.
    final language =
        context.locale.languageCode
                .toLowerCase()
                .startsWith('ml')
            ? 'ml'
            : 'en';

    setState(() {
      _isAnalyzing = true;
      _analysisResult = null;
    });

    try {
      final AiHseResult result =
          await _aiService.analyzePhoto(
        imageFile: _selectedImage!,
        description:
            _descriptionController.text.trim(),
        language: language,
      );

      if (!mounted) {
        return;
      }

      setState(() {
        _analysisResult = result;

        // ====================================================
        // AUTO-FILL DESCRIPTION
        // ====================================================

        if (_descriptionController.text
            .trim()
            .isEmpty) {
          final explanation =
              result.explanation.trim();

          final hazard =
              result.hazard.trim();

          if (explanation.isNotEmpty) {
            _descriptionController.text =
                explanation;
          } else if (hazard.isNotEmpty) {
            _descriptionController.text =
                hazard;
          }
        }
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green.shade700,
          content: Text(
            language == 'ml'
                ? 'AI HSE വിശകലനം പൂർത്തിയായി.'
                : 'AI HSE analysis completed successfully.',
          ),
        ),
      );
    } catch (e) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red.shade700,
          content: Text(
            language == 'ml'
                ? 'AI വിശകലനം പരാജയപ്പെട്ടു: $e'
                : 'AI analysis failed: $e',
          ),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isAnalyzing = false;
        });
      }
    }
  }

  // ==========================================================
  // RESULT ROW
  // ==========================================================

  Widget _resultRow(
    String title,
    String value,
  ) {
    if (value.trim().isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(
        bottom: 14,
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 5),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius:
                  BorderRadius.circular(10),
            ),
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 15,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // RISK COLOR
  // ==========================================================

  Color _riskColor(String risk) {
    switch (risk.toLowerCase()) {
      case 'critical':
        return Colors.deepPurple;

      case 'high':
        return Colors.red;

      case 'medium':
        return Colors.orange;

      case 'low':
        return Colors.green;

      default:
        return Colors.grey;
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

    final riskColor =
        _riskColor(result.riskLevel);

    return Card(
      margin: const EdgeInsets.only(
        top: 20,
      ),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            // HEADER
            Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color:
                        Colors.green.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.auto_awesome,
                    color:
                        Colors.green.shade700,
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    'AI HSE Analysis',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            const Divider(),

            const SizedBox(height: 16),

            // OBSERVATION TYPE
            _resultRow(
              'Observation Type',
              result.observationType,
            ),

            // CATEGORY
            _resultRow(
              'Category',
              result.category,
            ),

            // HAZARD
            _resultRow(
              'Hazard',
              result.hazard,
            ),

            // RISK
            if (result.riskLevel
                .trim()
                .isNotEmpty)
              Padding(
                padding:
                    const EdgeInsets.only(
                  bottom: 14,
                ),
                child: Row(
                  children: [
                    const Text(
                      'Risk Level',
                      style: TextStyle(
                        fontWeight:
                            FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding:
                          const EdgeInsets
                              .symmetric(
                        horizontal: 14,
                        vertical: 7,
                      ),
                      decoration:
                          BoxDecoration(
                        color: riskColor,
                        borderRadius:
                            BorderRadius
                                .circular(
                          20,
                        ),
                      ),
                      child: Text(
                        result.riskLevel,
                        style:
                            const TextStyle(
                          color: Colors.white,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            // CONSEQUENCE
            _resultRow(
              'Potential Consequence',
              result.potentialConsequence,
            ),

            // CORRECTIVE ACTION
            _resultRow(
              'Corrective Action',
              result.correctiveAction,
            ),

            // EXPLANATION
            _resultRow(
              'AI Explanation',
              result.explanation,
            ),

            const SizedBox(height: 8),

            // CONFIDENCE
            Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color:
                    Colors.green.shade50,
                borderRadius:
                    BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.verified,
                    color:
                        Colors.green.shade700,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'AI Confidence: '
                    '${(result.confidence * 100).toStringAsFixed(0)}%',
                    style: const TextStyle(
                      fontWeight:
                          FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            // HSE REVIEW WARNING
            Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color:
                    Colors.orange.shade50,
                borderRadius:
                    BorderRadius.circular(12),
              ),
              child: const Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.warning_amber,
                    color: Colors.orange,
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'AI result must be reviewed by the HSE officer before taking action.',
                      style: TextStyle(
                        fontSize: 12,
                        fontStyle:
                            FontStyle.italic,
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

  // ==========================================================
  // BUILD
  // ==========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'hazard_report'.tr(),
        ),
        actions: [
          PopupMenuButton<Locale>(
            onSelected: (Locale locale) {
              context.setLocale(locale);
            },
            itemBuilder:
                (BuildContext context) =>
                    <PopupMenuEntry<Locale>>[
              const PopupMenuItem(
                value: Locale(
                  'en',
                  'US',
                ),
                child: Text(
                  'English',
                ),
              ),
              const PopupMenuItem(
                value: Locale(
                  'ml',
                  'IN',
                ),
                child: Text(
                  'മലയാളം',
                ),
              ),
            ],
            icon: const Icon(
              Icons.language,
            ),
          ),
        ],
      ),

      // ========================================================
      // BODY
      // ========================================================

      body: SingleChildScrollView(
        padding:
            const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              // DESCRIPTION
              Text(
                'hazard_desc_label'.tr(),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              TextFormField(
                controller:
                    _descriptionController,
                maxLines: 4,
                decoration:
                    InputDecoration(
                  hintText:
                      'hazard_hint'.tr(),
                  border:
                      const OutlineInputBorder(),
                  suffixIcon:
                      _isAnalyzing
                          ? const Padding(
                              padding:
                                  EdgeInsets.all(
                                12,
                              ),
                              child:
                                  CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            )
                          : null,
                ),

                // DESCRIPTION IS OPTIONAL
                // AI can analyze the photo directly.
                validator: (_) {
                  return null;
                },
              ),

              const SizedBox(
                height: 16,
              ),

              // ==================================================
              // PHOTO BUTTON
              // ==================================================

              SizedBox(
                width: double.infinity,
                child:
                    OutlinedButton.icon(
                  onPressed:
                      _isAnalyzing
                          ? null
                          : _showPhotoOptions,
                  icon: const Icon(
                    Icons.add_a_photo,
                  ),
                  label: Text(
                    _selectedImage == null
                        ? 'Select Hazard Photo'
                        : 'Change Hazard Photo',
                  ),
                ),
              ),

              const SizedBox(
                height: 12,
              ),

              // ==================================================
              // SELECTED PHOTO
              // ==================================================

              if (_selectedImage != null)
                ClipRRect(
                  borderRadius:
                      BorderRadius.circular(
                    14,
                  ),
                  child: Stack(
                    children: [
                      Image.file(
                        _selectedImage!,
                        width:
                            double.infinity,
                        height: 240,
                        fit: BoxFit.cover,
                      ),

                      // AI ANALYZING OVERLAY
                      if (_isAnalyzing)
                        Positioned.fill(
                          child: Container(
                            color:
                                Colors.black45,
                            child: Center(
                              child:
                                  Container(
                                padding:
                                    const EdgeInsets
                                        .symmetric(
                                  horizontal: 18,
                                  vertical: 12,
                                ),
                                decoration:
                                    BoxDecoration(
                                  color:
                                      Colors.white,
                                  borderRadius:
                                      BorderRadius
                                          .circular(
                                    30,
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize:
                                      MainAxisSize
                                          .min,
                                  children: [
                                    const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child:
                                          CircularProgressIndicator(
                                        strokeWidth:
                                            2,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      context.locale
                                                  .languageCode ==
                                              'ml'
                                          ? 'AI പരിശോധിക്കുന്നു...'
                                          : 'AI Analyzing...',
                                      style:
                                          const TextStyle(
                                        fontWeight:
                                            FontWeight
                                                .w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),

                      // REMOVE PHOTO
                      Positioned(
                        right: 10,
                        top: 10,
                        child: CircleAvatar(
                          backgroundColor:
                              Colors.black54,
                          child: IconButton(
                            color:
                                Colors.white,
                            icon:
                                const Icon(
                              Icons.close,
                            ),
                            onPressed:
                                _isAnalyzing
                                    ? null
                                    : () {
                                        setState(
                                          () {
                                            _selectedImage =
                                                null;
                                            _analysisResult =
                                                null;
                                          },
                                        );
                                      },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              const SizedBox(
                height: 20,
              ),

              // ==================================================
              // MANUAL AI BUTTON
              // ==================================================

              SizedBox(
                width: double.infinity,
                child:
                    ElevatedButton.icon(
                  onPressed:
                      _isAnalyzing ||
                              _selectedImage ==
                                  null
                          ? null
                          : () =>
                              _analyzeHazard(
                                automatic: false,
                              ),
                  icon: _isAnalyzing
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child:
                              CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Icon(
                          Icons.auto_awesome,
                        ),
                  label: Text(
                    _isAnalyzing
                        ? 'Analyzing...'
                        : 'Analyze with AI',
                  ),
                ),
              ),

              // ==================================================
              // AI RESULT
              // ==================================================

              _buildAnalysisResult(),

              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
