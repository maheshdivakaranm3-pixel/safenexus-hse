import 'package:flutter/material.dart';
import 'guidelines.dart';
import 'hazard_report.dart';
import 'voice_report.dart';

void main() {
  runApp(const SafeNexusApp());
}

class SafeNexusApp extends StatefulWidget {
  const SafeNexusApp({Key? key}) : super(key: key);

  @override
  State<SafeNexusApp> createState() => _SafeNexusAppState();
}

class _SafeNexusAppState extends State<SafeNexusApp> {
  Locale _locale = const Locale('en');

  void changeLanguage(String languageCode) {
    setState(() {
      _locale = Locale(languageCode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SafeNexus HSE',
      debugShowCheckedModeBanner: false,
      locale: _locale,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: LoginPage(
        languageCode: _locale.languageCode,
        onLanguageChanged: changeLanguage,
      ),
    );
  }
}

// ============================================================
// TRANSLATIONS
// ============================================================

class AppText {
  static const Map<String, Map<String, String>> translations = {
    'en': {
      'language': 'Language',
      'selectLanguage': 'Select Language',
      'login': 'Login',
      'workerId': 'Worker ID / Email',
      'password': 'Password',
      'dashboard': 'SafeNexus HSE Dashboard',
      'reportHazard': 'Report Hazard',
      'voiceReport': 'Voice Report',
      'guidelines': 'UAE A-Z Guidelines',
      'weatherRisk': 'Weather Risk',
      'appDescription':
          'AI-Powered HSE Safety & Observation App for UAE',
    },

    'ml': {
      'language': 'ഭാഷ',
      'selectLanguage': 'ഭാഷ തിരഞ്ഞെടുക്കുക',
      'login': 'ലോഗിൻ',
      'workerId': 'Worker ID / Email',
      'password': 'പാസ്‌വേഡ്',
      'dashboard': 'SafeNexus HSE ഡാഷ്ബോർഡ്',
      'reportHazard': 'അപകടം റിപ്പോർട്ട് ചെയ്യുക',
      'voiceReport': 'വോയ്സ് റിപ്പോർട്ട്',
      'guidelines': 'UAE A-Z മാർഗ്ഗനിർദ്ദേശങ്ങൾ',
      'weatherRisk': 'കാലാവസ്ഥാ അപകടസാധ്യത',
      'appDescription':
          'UAE-യ്ക്കായുള്ള AI അടിസ്ഥാനമാക്കിയ HSE സുരക്ഷാ & നിരീക്ഷണ ആപ്പ്',
    },

    'hi': {
      'language': 'भाषा',
      'selectLanguage': 'भाषा चुनें',
      'login': 'लॉगिन',
      'workerId': 'Worker ID / Email',
      'password': 'पासवर्ड',
      'dashboard': 'SafeNexus HSE डैशबोर्ड',
      'reportHazard': 'खतरा रिपोर्ट करें',
      'voiceReport': 'वॉइस रिपोर्ट',
      'guidelines': 'UAE A-Z दिशानिर्देश',
      'weatherRisk': 'मौसम जोखिम',
      'appDescription':
          'UAE के लिए AI-संचालित HSE सुरक्षा और अवलोकन ऐप',
    },

    'ta': {
      'language': 'மொழி',
      'selectLanguage': 'மொழியைத் தேர்ந்தெடுக்கவும்',
      'login': 'உள்நுழைவு',
      'workerId': 'Worker ID / Email',
      'password': 'கடவுச்சொல்',
      'dashboard': 'SafeNexus HSE டாஷ்போர்டு',
      'reportHazard': 'ஆபத்தைப் புகாரளிக்கவும்',
      'voiceReport': 'குரல் அறிக்கை',
      'guidelines': 'UAE A-Z வழிகாட்டுதல்கள்',
      'weatherRisk': 'வானிலை ஆபத்து',
      'appDescription':
          'UAE-க்கான AI அடிப்படையிலான HSE பாதுகாப்பு மற்றும் கண்காணிப்பு செயலி',
    },
  };

  static String get(String languageCode, String key) {
    return translations[languageCode]?[key] ??
        translations['en']![key] ??
        key;
  }
}

// ============================================================
// LANGUAGE SELECTOR
// ============================================================

class LanguageSelector extends StatelessWidget {
  final String languageCode;
  final Function(String) onLanguageChanged;

  const LanguageSelector({
    Key? key,
    required this.languageCode,
    required this.onLanguageChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      tooltip: AppText.get(languageCode, 'language'),
      icon: const Icon(Icons.language),
      onSelected: onLanguageChanged,
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: 'en',
          child: Text('🇬🇧 English'),
        ),
        const PopupMenuItem(
          value: 'ml',
          child: Text('🇮🇳 മലയാളം'),
        ),
        const PopupMenuItem(
          value: 'hi',
          child: Text('🇮🇳 हिन्दी'),
        ),
        const PopupMenuItem(
          value: 'ta',
          child: Text('🇮🇳 தமிழ்'),
        ),
      ],
    );
  }
}

// ============================================================
// LOGIN PAGE
// ============================================================

class LoginPage extends StatelessWidget {
  final String languageCode;
  final Function(String) onLanguageChanged;

  const LoginPage({
    Key? key,
    required this.languageCode,
    required this.onLanguageChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final t = (String key) => AppText.get(languageCode, key);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          LanguageSelector(
            languageCode: languageCode,
            onLanguageChanged: onLanguageChanged,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(
                  Icons.security,
                  size: 80,
                  color: Colors.blueAccent,
                ),

                const SizedBox(height: 16),

                const Text(
                  'SafeNexus HSE',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  t('appDescription'),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 40),

                TextField(
                  decoration: InputDecoration(
                    labelText: t('workerId'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: const Icon(Icons.person),
                  ),
                ),

                const SizedBox(height: 16),

                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: t('password'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: const Icon(Icons.lock),
                  ),
                ),

                const SizedBox(height: 24),

                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DashboardPage(
                          languageCode: languageCode,
                          onLanguageChanged: onLanguageChanged,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    t('login'),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================
// DASHBOARD PAGE
// ============================================================

class DashboardPage extends StatelessWidget {
  final String languageCode;
  final Function(String) onLanguageChanged;

  const DashboardPage({
    Key? key,
    required this.languageCode,
    required this.onLanguageChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final t = (String key) => AppText.get(languageCode, key);

    return Scaffold(
      appBar: AppBar(
        title: Text(t('dashboard')),
        backgroundColor: Colors.blueAccent,
        actions: [
          LanguageSelector(
            languageCode: languageCode,
            onLanguageChanged: onLanguageChanged,
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            _buildFeatureCard(
              context,
              t('reportHazard'),
              Icons.camera_alt,
              Colors.orange,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HazardReportPage(),
                  ),
                );
              },
            ),

            _buildFeatureCard(
              context,
              t('voiceReport'),
              Icons.mic,
              Colors.green,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const VoiceReportPage(),
                  ),
                );
              },
            ),

            _buildFeatureCard(
              context,
              t('guidelines'),
              Icons.book,
              Colors.blue,
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const GuidelinesPage(),
                  ),
                );
              },
            ),

            _buildFeatureCard(
              context,
              t('weatherRisk'),
              Icons.wb_sunny,
              Colors.red,
              () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 48,
              color: color,
            ),

            const SizedBox(height: 12),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
