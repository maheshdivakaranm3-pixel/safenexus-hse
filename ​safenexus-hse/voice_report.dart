import 'package:flutter/material.dart';

class VoiceReportPage extends StatefulWidget {
  const VoiceReportPage({Key? key}) : super(key: key);

  @override
  _VoiceReportPageState createState() => _VoiceReportPageState();
}

class _VoiceReportPageState extends State<VoiceReportPage> {
  bool _isListening = false;
  String _spokenText = 'Tap the microphone icon and start speaking the hazard details...';

  void _toggleListening() {
    setState(() {
      _isListening = !_isListening;
      if (_isListening) {
        _spokenText = 'Listening... Please describe the safety hazard.';
      } else {
        _spokenText = 'Hazard: Unsecured scaffolding pole observed near Block B.';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Voice Hazard Report'),
        backgroundColor: Colors.green[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.mic_none,
              size: 80,
              color: Colors.green,
            ),
            const SizedBox(height: 24),
            Text(
              _isListening ? 'Listening to your voice...' : 'Tap to Speak',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: _isListening ? Colors.redAccent : Colors.black87,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade400),
              ),
              child: Text(
                _spokenText,
                style: const TextStyle(fontSize: 16, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 40),
            GestureDetector(
              onTap: _toggleListening,
              child: CircleAvatar(
                radius: 40,
                backgroundColor: _isListening ? Colors.red : Colors.green[700],
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
                    title: const Text('Voice Report Submitted'),
                    content: const Text('Your voice observation has been converted and sent to the HSE manager!'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[700],
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text(
                'Submit Voice Report',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
