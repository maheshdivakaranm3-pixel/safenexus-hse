import 'package:flutter/material.dart';

class VoiceReportPage extends StatefulWidget {
  const VoiceReportPage({
    super.key,
  });

  @override
  State<VoiceReportPage> createState() =>
      _VoiceReportPageState();
}

class _VoiceReportPageState extends State<VoiceReportPage> {
  // ============================================================
  // STATE
  // ============================================================

  bool _isRecording = false;

  String _transcript = '';

  // ============================================================
  // COLORS
  // ============================================================

  static const Color primaryGreen = Color(0xFF159447);

  static const Color darkGreen = Color(0xFF0B5D4B);

  static const Color pageBackground = Color(0xFFF6F8F7);

  // ============================================================
  // RECORDING STATE
  //
  // NOTE:
  // This screen currently provides the UI layer only.
  // Actual microphone / speech-to-text integration can be
  // added later through a dedicated service.
  // ============================================================

  void _toggleRecording() {
    setState(() {
      _isRecording = !_isRecording;
    });

    if (_isRecording) {
      _showMessage(
        'Voice recording is ready for integration.',
      );
    } else {
      _showMessage(
        'Voice recording stopped.',
      );
    }
  }

  // ============================================================
  // CLEAR TRANSCRIPT
  // ============================================================

  void _clearTranscript() {
    setState(() {
      _transcript = '';
    });
  }

  // ============================================================
  // MESSAGE
  // ============================================================

  void _showMessage(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(message),
      ),
    );
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBackground,

      // ========================================================
      // APP BAR
      // ========================================================

      appBar: AppBar(
        title: const Text(
          'Voice Report',
          style: TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),

      // ========================================================
      // BODY
      // ========================================================

      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            16,
            20,
            16,
            32,
          ),
          children: [
            _buildHeader(),

            const SizedBox(
              height: 22,
            ),

            _buildMicrophoneCard(),

            const SizedBox(
              height: 20,
            ),

            _buildTranscriptCard(),

            const SizedBox(
              height: 20,
            ),

            _buildInformationCard(),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // HEADER
  // ============================================================

  Widget _buildHeader() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(
          20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Voice Safety Report',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w900,
                color: darkGreen,
              ),
            ),

            const SizedBox(
              height: 8,
            ),

            Text(
              'Use your voice to prepare a workplace safety report.',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium,
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // MICROPHONE CARD
  // ============================================================

  Widget _buildMicrophoneCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(
          24,
        ),
        child: Column(
          children: [
            AnimatedContainer(
              duration: const Duration(
                milliseconds: 250,
              ),
              width: 130,
              height: 130,
              decoration: BoxDecoration(
                shape: BoxShape.circle,

                // ==================================================
                // Flutter modern Color API
                // ==================================================

                color: _isRecording
                    ? Colors.red.withValues(
                        alpha: 0.12,
                      )
                    : primaryGreen.withValues(
                        alpha: 0.10,
                      ),

                border: Border.all(
                  color: _isRecording
                      ? Colors.red
                      : primaryGreen,
                  width: 2,
                ),
              ),
              child: Center(
                child: Container(
                  width: 92,
                  height: 92,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _isRecording
                        ? Colors.red
                        : primaryGreen,
                  ),
                  child: IconButton(
                    tooltip: _isRecording
                        ? 'Stop'
                        : 'Start',
                    onPressed: _toggleRecording,
                    icon: Icon(
                      _isRecording
                          ? Icons.stop_rounded
                          : Icons.mic_rounded,
                      color: Colors.white,
                      size: 44,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(
              height: 22,
            ),

            Text(
              _isRecording
                  ? 'Recording'
                  : 'Ready to record',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),

            const SizedBox(
              height: 7,
            ),

            Text(
              _isRecording
                  ? 'Tap the microphone to stop.'
                  : 'Tap the microphone to start.',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium,
            ),

            if (_isRecording) ...[
              const SizedBox(
                height: 18,
              ),

              const LinearProgressIndicator(),
            ],
          ],
        ),
      ),
    );
  }

  // ============================================================
  // TRANSCRIPT CARD
  // ============================================================

  Widget _buildTranscriptCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(
          18,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.description_outlined,
                  color: primaryGreen,
                ),

                const SizedBox(
                  width: 8,
                ),

                const Expanded(
                  child: Text(
                    'Voice Transcript',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),

                if (_transcript.isNotEmpty)
                  IconButton(
                    tooltip: 'Clear',
                    onPressed: _clearTranscript,
                    icon: const Icon(
                      Icons.delete_outline_rounded,
                    ),
                  ),
              ],
            ),

            const SizedBox(
              height: 12,
            ),

            Container(
              width: double.infinity,
              constraints: const BoxConstraints(
                minHeight: 110,
              ),
              padding: const EdgeInsets.all(
                14,
              ),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(
                  14,
                ),
                border: Border.all(
                  color: Colors.grey.shade300,
                ),
              ),
              child: Text(
                _transcript.isEmpty
                    ? 'Your spoken safety report will appear here when speech-to-text is connected.'
                    : _transcript,
                style: TextStyle(
                  color: _transcript.isEmpty
                      ? Colors.grey.shade600
                      : Colors.black87,
                  height: 1.45,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // INFORMATION CARD
  // ============================================================

  Widget _buildInformationCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(
          18,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                // ==================================================
                // Flutter modern Color API
                // ==================================================

                color: primaryGreen.withValues(
                  alpha: 0.10,
                ),

                borderRadius: BorderRadius.circular(
                  12,
                ),
              ),
              child: const Icon(
                Icons.info_outline_rounded,
                color: primaryGreen,
              ),
            ),

            const SizedBox(
              width: 12,
            ),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Voice reporting',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                  const SizedBox(
                    height: 5,
                  ),

                  Text(
                    'The voice interface is separated from the main hazard and observation reporting modules so that speech recognition can be added safely later without affecting the existing reporting workflow.',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
