import 'package:flutter/material.dart';

class HazardReportPage extends StatefulWidget {
  const HazardReportPage({super.key});

  @override
  State<HazardReportPage> createState() => _HazardReportPageState();
}

class _HazardReportPageState extends State<HazardReportPage> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();

  bool get _isMalayalam =>
      Localizations.localeOf(context).languageCode == 'ml';

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  void _submitReport() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final message = _isMalayalam
        ? 'Hazard report വിജയകരമായി സമർപ്പിച്ചു.'
        : 'Hazard report submitted successfully.';

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );

    _descriptionController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final ml = _isMalayalam;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          ml ? 'Hazard Report' : 'Hazard Report',
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              ml ? 'Hazard റിപ്പോർട്ട്' : 'Hazard Report',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              ml
                  ? 'തൊഴിൽ സ്ഥലത്ത് കണ്ടെത്തിയ hazard രേഖപ്പെടുത്തുക.'
                  : 'Report a hazard identified at the workplace.',
              style: TextStyle(
                fontSize: 15,
                color: Theme.of(context)
                    .colorScheme
                    .onSurfaceVariant,
              ),
            ),

            const SizedBox(height: 20),

            TextFormField(
              controller: _descriptionController,
              minLines: 4,
              maxLines: 4,
              textInputAction: TextInputAction.newline,
              decoration: InputDecoration(
                labelText: ml
                    ? 'Hazard Description'
                    : 'Hazard Description',
                hintText: ml
                    ? 'Hazard വിശദമായി വിവരിക്കുക'
                    : 'Describe the hazard in detail',
                prefixIcon: const Icon(
                  Icons.warning_amber_outlined,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return ml
                      ? 'Hazard description നൽകുക'
                      : 'Please enter a hazard description';
                }

                return null;
              },
            ),

            const SizedBox(height: 20),

            SizedBox(
              height: 50,
              child: FilledButton.icon(
                onPressed: _submitReport,
                icon: const Icon(Icons.send),
                label: Text(
                  ml ? 'Submit Report' : 'Submit Report',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
