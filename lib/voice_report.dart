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
  // COLORS
  // ============================================================

  static const Color primaryGreen = Color(0xFF159447);
  static const Color darkGreen = Color(0xFF0B5D4B);
  static const Color pageBackground = Color(0xFFF6F8F7);

  // ============================================================
  // STATE
  // ============================================================

  bool _isRecording = false;

  String _transcript = '';

  // ============================================================
  // RECORDING
  //
  // Current version keeps the voice UI isolated.
  // Real speech-to-text can be connected later without changing
  // the main Hazard Report / Safety Observation storage flow.
  // ============================================================

  void _toggleRecording() {
    setState(() {
      _isRecording = !_isRecording;
    });

    if (_isRecording) {
      _showMessage(
        'Voice recording started.',
      );
    } else {
      _showMessage(
        'Voice recording stopped.',
      );
    }
  }

  // ============================================================
  // CLEAR
  // ============================================================

  void _clearTranscript() {
    if (_transcript.isEmpty) {
      return;
    }

    setState(() {
      _transcript = '';
    });

    _showMessage(
      'Transcript cleared.',
    );
  }

  // ============================================================
  // MESSAGE
  // ============================================================

  void _showMessage(
    String message, {
    bool error = false,
  }) {
    if (!mounted) return;

    ScaffoldMessenger.of(context)
        .hideCurrentSnackBar();

    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: error
            ? Colors.red.shade700
            : darkGreen,
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
        centerTitle: true,
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        elevation: 0,
      ),

      // ========================================================
      // BODY
      // ========================================================

      body: SafeArea(
        child: ListView(
          physics:
              const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(
            16,
            18,
            16,
            32,
          ),
          children: [
            _buildHeader(),

            const SizedBox(
              height: 18,
            ),

            _buildMicrophoneCard(),

            const SizedBox(
              height: 18,
            ),

            _buildTranscriptCard(),

            const SizedBox(
              height: 18,
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
      elevation: 0,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              primaryGreen.withValues(
                alpha: 0.12,
              ),
              Colors.white,
            ],
          ),
        ),
        child: Row(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: primaryGreen.withValues(
                  alpha: 0.12,
                ),
                borderRadius:
                    BorderRadius.circular(15),
              ),
              child: const Icon(
                Icons.mic_rounded,
                color: primaryGreen,
                size: 28,
              ),
            ),

            const SizedBox(
              width: 14,
            ),

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Voice Safety Report',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w900,
                      color: darkGreen,
                    ),
                  ),

                  const SizedBox(
                    height: 7,
                  ),

                  Text(
                    'Use your voice to prepare a workplace safety report.',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(
                          height: 1.4,
                        ),
                  ),
                ],
              ),
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
    final Color outerColor = _isRecording
        ? Colors.red
        : primaryGreen;

    final Color softColor = _isRecording
        ? Colors.red.withValues(
            alpha: 0.10,
          )
        : primaryGreen.withValues(
            alpha: 0.10,
          );

    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          20,
          26,
          20,
          24,
        ),
        child: Column(
          children: [
            // ----------------------------------------------------
            // STATUS
            // ----------------------------------------------------

            Container(
              padding:
                  const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 7,
              ),
              decoration: BoxDecoration(
                color: softColor,
                borderRadius:
                    BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisSize:
                    MainAxisSize.min,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration:
                        BoxDecoration(
                      color: outerColor,
                      shape: BoxShape.circle,
                    ),
                  ),

                  const SizedBox(
                    width: 7,
                  ),

                  Text(
                    _isRecording
                        ? 'RECORDING'
                        : 'READY',
                    style: TextStyle(
                      color: outerColor,
                      fontSize: 12,
                      fontWeight:
                          FontWeight.w800,
                      letterSpacing: 0.7,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            // ----------------------------------------------------
            // MICROPHONE
            // ----------------------------------------------------

            AnimatedContainer(
              duration:
                  const Duration(
                milliseconds: 250,
              ),
              width: 142,
              height: 142,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: softColor,
                border: Border.all(
                  color: outerColor.withValues(
                    alpha: 0.35,
                  ),
                  width: 2,
                ),
              ),
              child: Center(
                child: AnimatedContainer(
                  duration:
                      const Duration(
                    milliseconds: 250,
                  ),
                  width: 100,
                  height: 100,
                  decoration:
                      BoxDecoration(
                    shape: BoxShape.circle,
                    color: outerColor,
                    boxShadow: [
                      BoxShadow(
                        color: outerColor
                            .withValues(
                          alpha: 0.22,
                        ),
                        blurRadius: 18,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: IconButton(
                    tooltip: _isRecording
                        ? 'Stop recording'
                        : 'Start recording',
                    onPressed:
                        _toggleRecording,
                    icon: Icon(
                      _isRecording
                          ? Icons.stop_rounded
                          : Icons.mic_rounded,
                      color: Colors.white,
                      size: 46,
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
                  ? 'Recording your report'
                  : 'Ready to record',
              textAlign: TextAlign.center,
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
                  ? 'Tap the microphone to stop recording.'
                  : 'Tap the microphone and describe the safety issue clearly.',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(
                    height: 1.4,
                  ),
            ),

            if (_isRecording) ...[
              const SizedBox(
                height: 18,
              ),

              const LinearProgressIndicator(
                minHeight: 4,
              ),
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
    final bool hasTranscript =
        _transcript.trim().isNotEmpty;

    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color:
                        primaryGreen.withValues(
                      alpha: 0.10,
                    ),
                    borderRadius:
                        BorderRadius.circular(11),
                  ),
                  child: const Icon(
                    Icons
                        .description_outlined,
                    color: primaryGreen,
                    size: 21,
                  ),
                ),

                const SizedBox(
                  width: 10,
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

                if (hasTranscript)
                  IconButton(
                    tooltip: 'Clear transcript',
                    onPressed:
                        _clearTranscript,
                    icon: const Icon(
                      Icons
                          .delete_outline_rounded,
                    ),
                  ),
              ],
            ),

            const SizedBox(
              height: 12,
            ),

            Container(
              width: double.infinity,
              constraints:
                  const BoxConstraints(
                minHeight: 115,
              ),
              padding:
                  const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius:
                    BorderRadius.circular(14),
                border: Border.all(
                  color: Colors.grey.shade300,
                ),
              ),
              child: hasTranscript
                  ? Text(
                      _transcript,
                      style:
                          const TextStyle(
                        color: Colors.black87,
                        height: 1.5,
                        fontSize: 15,
                      ),
                    )
                  : Column(
                      mainAxisAlignment:
                          MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons
                              .record_voice_over_outlined,
                          size: 30,
                          color:
                              Colors.grey.shade400,
                        ),

                        const SizedBox(
                          height: 8,
                        ),

                        Text(
                          'Your spoken safety report will appear here when speech-to-text is connected.',
                          textAlign:
                              TextAlign.center,
                          style: TextStyle(
                            color:
                                Colors.grey.shade600,
                            height: 1.45,
                          ),
                        ),
                      ],
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
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color:
                        primaryGreen.withValues(
                      alpha: 0.10,
                    ),
                    borderRadius:
                        BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.info_outline_rounded,
                    color: primaryGreen,
                  ),
                ),

                const SizedBox(
                  width: 12,
                ),

                const Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Voice reporting',
                        style: TextStyle(
                          fontWeight:
                              FontWeight.w800,
                          fontSize: 16,
                        ),
                      ),

                      SizedBox(
                        height: 5,
                      ),

                      Text(
                        'Voice reporting is kept separate from the main hazard and safety observation modules.',
                        style: TextStyle(
                          height: 1.45,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 16,
            ),

            Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.all(13),
              decoration: BoxDecoration(
                color: Colors.blueGrey
                    .withValues(
                  alpha: 0.06,
                ),
                borderRadius:
                    BorderRadius.circular(12),
              ),
              child: Row(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons
                        .security_outlined,
                    size: 19,
                    color:
                        Colors.blueGrey.shade700,
                  ),

                  const SizedBox(
                    width: 8,
                  ),

                  Expanded(
                    child: Text(
                      'Your existing report history and SharedPreferences data remain unaffected.',
                      style: TextStyle(
                        fontSize: 12,
                        height: 1.4,
                        color:
                            Colors.blueGrey.shade700,
                      ),
                    ),
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
