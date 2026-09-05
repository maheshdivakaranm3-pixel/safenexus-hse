import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HazardReportPage extends StatefulWidget {
  const HazardReportPage({super.key});

  @override
  State<HazardReportPage> createState() => _HazardReportPageState();
}

class _HazardReportPageState extends State<HazardReportPage> {
  static const String _storageKey = 'safenexus_hazards';

  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();

  bool _isSaving = false;

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _submitReport() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_isSaving) {
      return;
    }

    setState(() {
      _isSaving = true;
    });

    try {
      final prefs = await SharedPreferences.getInstance();

      final stored =
          prefs.getStringList(_storageKey) ?? <String>[];

      final now = DateTime.now();

      final report = <String, dynamic>{
        'id': 'HZ-${now.millisecondsSinceEpoch}',
        'type': 'Hazard Report',
        'description': _descriptionController.text.trim(),
        'status': 'Open',
        'dateTime': now.toIso8601String(),
      };

      stored.add(jsonEncode(report));

      final saved = await prefs.setStringList(
        _storageKey,
        stored,
      );

      if (!saved) {
        throw Exception('Unable to save hazard report.');
      }

      if (!mounted) {
        return;
      }

      _descriptionController.clear();

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text(
              'Hazard report submitted successfully.',
            ),
            behavior: SnackBarBehavior.floating,
          ),
        );

      setState(() {
        _isSaving = false;
      });

      // Return to the previous page after successful save.
      await Future<void>.delayed(
        const Duration(milliseconds: 500),
      );

      if (!mounted) {
        return;
      }

      Navigator.of(context).pop(true);
    } catch (_) {
      if (!mounted) {
        return;
      }

      setState(() {
        _isSaving = false;
      });

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: const Text(
              'Unable to save hazard report. Please try again.',
            ),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red.shade700,
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Hazard Report',
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(
              16,
              18,
              16,
              28,
            ),
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: scheme.primaryContainer,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: scheme.primary,
                        borderRadius:
                            BorderRadius.circular(14),
                      ),
                      child: Icon(
                        Icons.warning_amber_rounded,
                        color: scheme.onPrimary,
                      ),
                    ),
                    const SizedBox(width: 14),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Report a Hazard',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            'Record an unsafe condition or hazard identified at the workplace.',
                            style: TextStyle(
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

              const SizedBox(height: 22),

              const Text(
                'Hazard Details',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                'Provide clear information so the hazard can be understood and addressed.',
                style: TextStyle(
                  fontSize: 13,
                  color: scheme.onSurfaceVariant,
                ),
              ),

              const SizedBox(height: 14),

              TextFormField(
                controller: _descriptionController,
                minLines: 5,
                maxLines: 7,
                textInputAction:
                    TextInputAction.newline,
                decoration: InputDecoration(
                  labelText: 'Hazard Description *',
                  hintText:
                      'Describe the hazard, unsafe condition, or exposure...',
                  alignLabelWithHint: true,
                  prefixIcon: const Padding(
                    padding:
                        EdgeInsets.only(bottom: 76),
                    child: Icon(
                      Icons.description_outlined,
                    ),
                  ),
                  filled: true,
                  fillColor: scheme
                      .surfaceContainerHighest
                      .withValues(alpha: 0.45),
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: scheme.outlineVariant,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: scheme.primary,
                      width: 2,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: scheme.error,
                    ),
                  ),
                  focusedErrorBorder:
                      OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: scheme.error,
                      width: 2,
                    ),
                  ),
                  contentPadding:
                      const EdgeInsets.fromLTRB(
                    16,
                    16,
                    16,
                    16,
                  ),
                ),
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty) {
                    return 'Please enter a hazard description';
                  }

                  if (value.trim().length < 5) {
                    return 'Please provide more details';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 10),

              Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.info_outline,
                    size: 17,
                    color: scheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 7),
                  Expanded(
                    child: Text(
                      'Tip: Include the location, unsafe condition, people exposed, and immediate concern where applicable.',
                      style: TextStyle(
                        fontSize: 12.5,
                        height: 1.35,
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 26),

              SizedBox(
                height: 54,
                child: FilledButton.icon(
                  onPressed:
                      _isSaving ? null : _submitReport,
                  icon: _isSaving
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child:
                              CircularProgressIndicator(
                            strokeWidth: 2.2,
                          ),
                        )
                      : const Icon(
                          Icons.send_rounded,
                        ),
                  label: Text(
                    _isSaving
                        ? 'Saving Report...'
                        : 'Submit Hazard Report',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  style: FilledButton.styleFrom(
                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
