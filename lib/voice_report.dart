import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class VoiceReportPage extends StatefulWidget {
  const VoiceReportPage({super.key});

  @override
  State<VoiceReportPage> createState() => _VoiceReportPageState();
}

class _VoiceReportPageState extends State<VoiceReportPage> {
  bool isRecording = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('voice_report'.tr()),
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                isRecording ? 'recording_status'.tr() : 'press_to_record'.tr(),
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isRecording = !isRecording;
                  });
                },
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: isRecording ? Colors.red : Colors.blue,
                  child: Icon(
                    isRecording ? Icons.stop : Icons.mic,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                isRecording ? 'tap_to_stop'.tr() : 'tap_to_start'.tr(),
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
