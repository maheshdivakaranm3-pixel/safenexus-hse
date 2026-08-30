import 'package:flutter/material.dart';

void main() {
  runApp(const SafeNexusApp());
}

class SafeNexusApp extends StatelessWidget {
  const SafeNexusApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SafeNexus HSE',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Current selected language: 'en' for English, 'ml' for Malayalam
  String currentLang = 'en';

  final Map<String, Map<String, String>> localizedTexts = {
    'en': {
      'title': 'SafeNexus HSE',
      'subtitle': 'AI-Powered Safety for UAE',
      'hazard': 'Smart Hazard Observation',
      'poster': 'AI Poster Studio',
      'sos': 'Emergency SOS',
      'weather': 'UAE Weather: 42°C - Heat Alert Active',
    },
    'ml': {
      'title': 'സേഫ്നെക്സസ് എച്ച്.എസ്.ഇ.',
      'subtitle': 'യു.എ.ഇ. സുരക്ഷാ ആപ്പ്',
      'hazard': 'അപകടസാധ്യത റിപ്പോർട്ട് ചെയ്യുക',
      'poster': 'എ.ഐ. പോസ്റ്റർ സ്റ്റുഡിയോ',
      'sos': 'അടിയന്തിര സഹായം (SOS)',
      'weather': 'യു.എ.ഇ. കാലാവസ്ഥ: 42°C - ചൂട് മുന്നറിയിപ്പ്',
    },
  };

  @override
  Widget build(BuildContext context) {
    final t = localizedTexts[currentLang]!;

    return Scaffold(
      appBar: AppBar(
        title: Text(t['title']!),
        backgroundColor: Colors.green[700],
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: DropdownButton<String>(
              value: currentLang,
              dropdownColor: Colors.green[800],
              icon: const Icon(Icons.language, color: Colors.white),
              underline: const SizedBox(),
              items: const [
                DropdownMenuItem(value: 'en', child: Text('English', style: TextStyle(color: Colors.white))),
                DropdownMenuItem(value: 'ml', child: Text('മലയാളം', style: TextStyle(color: Colors.white))),
              ],
              onChanged: (String? newLang) {
                if (newLang != null) {
                  setState(() {
                    currentLang = newLang;
                  });
                }
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Weather Alert Card
            Card(
              color: Colors.orange[100],
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    const Icon(Icons.wb_sunny, color: Colors.orange, size: 30),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        t['weather']!,
                        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.brown),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            
            // Subtitle
            Center(
              child: Text(
                t['subtitle']!,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.grey[700]),
              ),
            ),
            const SizedBox(height: 30),

            // Feature 1: Hazard Observation
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.camera_alt, size: 28),
              label: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(t['hazard']!, style: const TextStyle(fontSize: 16)),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[600],
                foregroundColor: Colors.white,
              ),
            ),
            const SizedBox(height: 16),

            // Feature 2: AI Poster Studio
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.photo_size_select_actual, size: 28),
              label: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(t['poster']!, style: const TextStyle(fontSize: 16)),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[600],
                foregroundColor: Colors.white,
              ),
            ),
            const SizedBox(height: 16),

            // Feature 3: Emergency SOS
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.warning, size: 28),
              label: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(t['sos']!, style: const TextStyle(fontSize: 16)),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[600],
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
