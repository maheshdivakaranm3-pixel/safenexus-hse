import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:safenexus_hse/guidelines.dart';
import 'package:safenexus_hse/hazard_report.dart';
import 'package:safenexus_hse/voice_report.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('ml', 'IN'),
      ],
      path: 'assets/translations',
      fallbackLocale: const Locale('en', 'US'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: 'SafeNexus HSE',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('title'.tr()),
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HazardReportPage()),
                );
              },
              child: Text('hazard_report'.tr()),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // VoiceReportPage-ലേക്ക് 네비ഗേഷൻ ചേർത്തു
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const VoiceReportPage()),
                );
              },
              child: Text('voice_report'.tr()),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // GuidelinesPage-ലേക്ക് 네비ഗേഷൻ ചേർത്തു
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const GuidelinesPage()),
                );
              },
              child: Text('guidelines'.tr()),
            ),
          ],
        ),
      ),
    );
  }
}
