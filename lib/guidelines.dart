import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class GuidelinesPage extends StatelessWidget {
  const GuidelinesPage({super.key});

  @override
  Widget build(BuildContext context) {
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
          ],
        ),
      ),
    );
  }
}
