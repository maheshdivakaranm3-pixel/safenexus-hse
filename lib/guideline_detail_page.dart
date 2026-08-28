
import 'package:flutter/material.dart';

class GuidelineDetailPage extends StatelessWidget {
  final Map<String, String> guideline;
  final String language;

  const GuidelineDetailPage({
    Key? key,
    required this.guideline,
    required this.language,
  }) : super(key: key);

  String t(String key) {
    return guideline['${language}_$key'] ??
        guideline['English_$key'] ??
        '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(t('title')),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 35,
                backgroundColor: Colors.blueAccent,
                child: Text(
                  guideline['letter'] ?? '',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            _section(
              context,
              '📖',
              t('what'),
              t('whatText'),
            ),

            _section(
              context,
              '🎯',
              t('purpose'),
              t('purposeText'),
            ),

            _section(
              context,
              '⚠️',
              t('requirements'),
              t('requirementsText'),
            ),

            _section(
              context,
              '👷',
              t('responsibilities'),
              t('responsibilitiesText'),
            ),

            _section(
              context,
              '📋',
              t('checklist'),
              t('checklistText'),
            ),

            _section(
              context,
              '🚨',
              t('violations'),
              t('violationsText'),
            ),

            _section(
              context,
              '✅',
              t('bestPractice'),
              t('bestPracticeText'),
            ),

            _section(
              context,
              '📚',
              t('reference'),
              t('referenceText'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _section(
    BuildContext context,
    String icon,
    String title,
    String content,
  ) {
    if (title.isEmpty || content.isEmpty) {
      return const SizedBox.shrink();
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  icon,
                  style: const TextStyle(fontSize: 22),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            Text(
              content,
              style: const TextStyle(
                fontSize: 15,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
