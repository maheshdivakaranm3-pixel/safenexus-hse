import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'services/ai_hse_service.dart';

class HazardReportPage extends StatefulWidget {
  const HazardReportPage({super.key});

  @override
  State<HazardReportPage> createState() =>
      _HazardReportPageState();
}

class _HazardReportPageState
    extends State<HazardReportPage> {
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

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (image == null) {
      return;
    }

    setState(() {
      _selectedImage = File(image.path);
      _analysisResult = null;
    });
  }

  Future<void> _analyzeHazard() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please select a hazard photo first.',
          ),
        ),
      );
      return;
    }

    setState(() {
      _isAnalyzing = true;
      _analysisResult = null;
    });

    try {
      final language =
          context.locale.languageCode
                  .toLowerCase()
                  .startsWith('ml')
              ? 'ml'
              : 'en';

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
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'AI HSE analysis completed successfully.',
          ),
        ),
      );
    } catch (e) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'AI analysis failed: $e',
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

  Widget _resultRow(
    String title,
    String value,
  ) {
    if (value.trim().isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(
        bottom: 12,
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnalysisResult() {
    final result = _analysisResult;

    if (result == null) {
      return const SizedBox.shrink();
    }

    return Card(
      margin: const EdgeInsets.only(
        top: 20,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            const Text(
              'AI HSE Analysis',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const Divider(
              height: 24,
            ),

            _resultRow(
              'Observation Type',
              result.observationType,
            ),

            _resultRow(
              'Category',
              result.category,
            ),

            _resultRow(
              'Hazard',
              result.hazard,
            ),

            _resultRow(
              'Risk Level',
              result.riskLevel,
            ),

            _resultRow(
              'Potential Consequence',
              result.potentialConsequence,
            ),

            _resultRow(
              'Corrective Action',
              result.correctiveAction,
            ),

            _resultRow(
              'AI Explanation',
              result.explanation,
            ),

            const SizedBox(height: 8),

            Text(
              'AI Confidence: '
              '${(result.confidence * 100).toStringAsFixed(0)}%',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 12),

            const Text(
              'AI result must be reviewed by the HSE '
              'officer before taking action.',
              style: TextStyle(
                fontSize: 12,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }

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

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                'hazard_desc_label'.tr(),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
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
                ),
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty) {
                    return 'hazard_validation'
                        .tr();
                  }

                  return null;
                },
              ),

              const SizedBox(
                height: 16,
              ),

              SizedBox(
                width: double.infinity,
                child:
                    OutlinedButton.icon(
                  onPressed: _isAnalyzing
                      ? null
                      : _pickImage,
                  icon: const Icon(
                    Icons.photo_camera,
                  ),
                  label: const Text(
                    'Select Hazard Photo',
                  ),
                ),
              ),

              const SizedBox(
                height: 12,
              ),

              if (_selectedImage != null)
                ClipRRect(
                  borderRadius:
                      BorderRadius.circular(
                    12,
                  ),
                  child: Image.file(
                    _selectedImage!,
                    width:
                        double.infinity,
                    height: 220,
                    fit: BoxFit.cover,
                  ),
                ),

              const SizedBox(
                height: 20,
              ),

              SizedBox(
                width: double.infinity,
                child:
                    ElevatedButton.icon(
                  onPressed: _isAnalyzing
                      ? null
                      : _analyzeHazard,
                  icon: _isAnalyzing
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child:
                              CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        )
                      : const Icon(
                          Icons.analytics,
                        ),
                  label: Text(
                    _isAnalyzing
                        ? 'Analyzing...'
                        : 'Analyze with AI',
                  ),
                ),
              ),

              _buildAnalysisResult(),
            ],
          ),
        ),
      ),
    );
  }
}
