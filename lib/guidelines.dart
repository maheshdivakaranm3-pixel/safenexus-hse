import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:safenexus_hse/guideline_detail_page.dart';

class GuidelinesPage extends StatelessWidget {
  const GuidelinesPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Instantiate GuidelineDetailPage to safely reference its full A-Z maps
    final dummyDetail = GuidelineDetailPage(guideline: const {}, language: context.locale.languageCode);
    final allDetails = dummyDetail.details;

    return Scaffold(
      appBar: AppBar(
        title: Text('guidelines'.tr()),
        actions: [
          PopupMenuButton<Locale>(
            onSelected: (Locale locale) {
              context.setLocale(locale);
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<Locale>>[
              const PopupMenuItem(
                value: Locale('en', 'US'),
                child: Text('English'),
              ),
              const PopupMenuItem(
                value: Locale('ml', 'IN'),
                child: Text('മലയാളം'),
              ),
            ],
            icon: const Icon(Icons.language),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              'guidelines_heading'.tr(),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'guidelines_content_1'.tr(),
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text(
              'guidelines_content_2'.tr(),
              style: const TextStyle(fontSize: 16),
            ),
            const Divider(height: 30, thickness: 1),
            const Text(
              'A-Z Safety Directives & Frameworks',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 10),
            ...allDetails.entries.map((entry) {
              String letter = entry.key;
              Map<String, String> data = entry.value;
              String titleText = data['what'] ?? 'Guideline $letter';

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 6),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blueAccent,
                    child: Text(letter, style: const TextStyle(color: Colors.white)),
                  ),
                  title: Text(titleText, style: const TextStyle(fontWeight: FontWeight.w600)),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GuidelineDetailPage(
                          guideline: {
                            'letter': letter,
                            'title': titleText,
                            'desc': data['whatText'] ?? '',
                          },
                          language: context.locale.languageCode,
                        ),
                      ),
                    );
                  },
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
