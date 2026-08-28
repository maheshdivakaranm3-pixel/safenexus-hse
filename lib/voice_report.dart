import 'package:flutter/material.dart';

class VoiceReportPage extends StatefulWidget {
  const VoiceReportPage({Key? key}) : super(key: key);

  @override
  State<VoiceReportPage> createState() => _VoiceReportPageState();
}

class _VoiceReportPageState extends State<VoiceReportPage> {
  bool _isListening = false;

  // Change this value from your main language system.
  // Supported: English, Hindi, Malayalam, Tamil
  String _language = 'English';

  final Map<String, Map<String, String>> _translations = {
    'English': {
      'title': 'AI Voice Hazard Report',
      'tapSpeak': 'Tap to Speak',
      'listening': 'Listening to your voice...',
      'initial':
          'Tap the microphone icon and start speaking the hazard details...',
      'listeningText':
          'Listening... Please describe the safety hazard.',
      'hazard':
          'Hazard: Unsecured scaffolding pole observed near Block B.',
      'submitted': 'Voice Report Submitted',
      'success':
          'Your voice observation has been converted and sent to the HSE manager!',
      'ok': 'OK',
      'submit': 'Submit Voice Report',
    },
    'Hindi': {
      'title': 'AI वॉइस खतरा रिपोर्ट',
      'tapSpeak': 'बोलने के लिए टैप करें',
      'listening': 'आपकी आवाज़ सुनी जा रही है...',
      'initial':
          'माइक्रोफ़ोन आइकन पर टैप करें और खतरे का विवरण बोलना शुरू करें...',
      'listeningText':
          'सुन रहा है... कृपया सुरक्षा खतरे का वर्णन करें।',
      'hazard':
          'खतरा: ब्लॉक B के पास असुरक्षित स्कैफोल्डिंग पोल देखा गया।',
      'submitted': 'वॉइस रिपोर्ट जमा की गई',
      'success':
          'आपकी वॉइस ऑब्ज़र्वेशन को परिवर्तित करके HSE मैनेजर को भेज दिया गया है!',
      'ok': 'ठीक है',
      'submit': 'वॉइस रिपोर्ट जमा करें',
    },
    'Malayalam': {
      'title': 'AI വോയ്സ് ഹസാർഡ് റിപ്പോർട്ട്',
      'tapSpeak': 'സംസാരിക്കാൻ ടാപ്പ് ചെയ്യുക',
      'listening': 'നിങ്ങളുടെ ശബ്ദം കേൾക്കുന്നു...',
      'initial':
          'മൈക്രോഫോൺ ഐക്കണിൽ ടാപ്പ് ചെയ്ത് ഹസാർഡിന്റെ വിശദാംശങ്ങൾ സംസാരിക്കുക...',
      'listeningText':
          'കേൾക്കുന്നു... സുരക്ഷാ ഹസാർഡ് വിശദീകരിക്കുക.',
      'hazard':
          'ഹസാർഡ്: Block B-ക്ക് സമീപം സുരക്ഷിതമല്ലാത്ത scaffolding pole കണ്ടെത്തി.',
      'submitted': 'വോയ്സ് റിപ്പോർട്ട് സമർപ്പിച്ചു',
      'success':
          'നിങ്ങളുടെ വോയ്സ് ഒബ്സർവേഷൻ മാറ്റി HSE മാനേജർക്ക് അയച്ചിരിക്കുന്നു!',
      'ok': 'ശരി',
      'submit': 'വോയ്സ് റിപ്പോർട്ട് സമർപ്പിക്കുക',
    },
    'Tamil': {
      'title': 'AI குரல் அபாய அறிக்கை',
      'tapSpeak': 'பேச தட்டவும்',
      'listening': 'உங்கள் குரலைக் கேட்கிறது...',
      'initial':
          'மைக்ரோஃபோன் ஐகானைத் தட்டி அபாயத்தின் விவரங்களைப் பேசத் தொடங்குங்கள்...',
      'listeningText':
          'கேட்கிறது... பாதுகாப்பு அபாயத்தை விவரிக்கவும்.',
      'hazard':
          'அபாயம்: Block B அருகில் பாதுகாப்பற்ற scaffolding pole காணப்பட்டது.',
      'submitted': 'குரல் அறிக்கை சமர்ப்பிக்கப்பட்டது',
      'success':
          'உங்கள் குரல் கண்காணிப்பு மாற்றப்பட்டு HSE மேலாளருக்கு அனுப்பப்பட்டுள்ளது!',
      'ok': 'சரி',
      'submit': 'குரல் அறிக்கையை சமர்ப்பிக்கவும்',
    },
  };

  String _t(String key) {
    return _translations[_language]?[key] ??
        _translations['English']![key]!;
  }

  void _toggleListening() {
    setState(() {
      _isListening = !_isListening;

      if (_isListening) {
        _spokenText = _t('listeningText');
      } else {
        _spokenText = _t('hazard');
      }
    });
  }

  String _spokenText = '';

  @override
  void initState() {
    super.initState();
    _spokenText = _t('initial');
  }

  void _changeLanguage(String language) {
    setState(() {
      _language = language;

      if (_isListening) {
        _spokenText = _t('listeningText');
      } else {
        _spokenText = _t('initial');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_t('title')),
        backgroundColor: Colors.green[700],
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.language),
            onSelected: _changeLanguage,
            itemBuilder: (context) => const [
              PopupMenuItem(
                value: 'English',
                child: Text('English'),
              ),
              PopupMenuItem(
                value: 'Hindi',
                child: Text('हिन्दी'),
              ),
              PopupMenuItem(
                value: 'Malayalam',
                child: Text('മലയാളം'),
              ),
              PopupMenuItem(
                value: 'Tamil',
                child: Text('தமிழ்'),
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _isListening ? Icons.mic : Icons.mic_none,
              size: 80,
              color: Colors.green,
            ),

            const SizedBox(height: 24),

            Text(
              _isListening ? _t('listening') : _t('tapSpeak'),
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color:
                    _isListening ? Colors.redAccent : Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 20),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.grey.shade400,
                ),
              ),
              child: Text(
                _spokenText,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 40),

            GestureDetector(
              onTap: _toggleListening,
              child: CircleAvatar(
                radius: 40,
                backgroundColor:
                    _isListening ? Colors.red : Colors.green[700],
                child: Icon(
                  _isListening ? Icons.stop : Icons.mic,
                  size: 40,
                  color: Colors.white,
                ),
              ),
            ),

            const SizedBox(height: 40),

            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(_t('submitted')),
                    content: Text(_t('success')),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: Text(_t('ok')),
                      ),
                    ],
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[700],
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 32,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                _t('submit'),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
