import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class AiHseResult {
  final String observationType;
  final String category;
  final String hazard;
  final String riskLevel;
  final String potentialConsequence;
  final String correctiveAction;
  final double confidence;
  final String explanation;

  const AiHseResult({
    required this.observationType,
    required this.category,
    required this.hazard,
    required this.riskLevel,
    required this.potentialConsequence,
    required this.correctiveAction,
    required this.confidence,
    required this.explanation,
  });

  factory AiHseResult.fromJson(Map<String, dynamic> json) {
    return AiHseResult(
      observationType:
          json['observation_type']?.toString() ?? 'Unsafe Condition',
      category:
          json['category']?.toString() ?? 'General Safety',
      hazard:
          json['hazard']?.toString() ?? 'General Workplace Hazard',
      riskLevel:
          json['risk_level']?.toString() ?? 'Medium',
      potentialConsequence:
          json['potential_consequence']?.toString() ?? 'Injury',
      correctiveAction:
          json['corrective_action']?.toString() ?? '',
      confidence:
          (json['confidence'] as num?)?.toDouble() ?? 0.0,
      explanation:
          json['explanation']?.toString() ?? '',
    );
  }
}

class AiHseService {
  /// SafeNexus HSE Cloudflare Worker
  ///
  /// IMPORTANT:
  /// OpenAI API key must NEVER be placed inside the Flutter app.
  /// The key stays securely inside the Cloudflare Worker.
  static const String endpoint =
      'https://safenexus-hse-v2.maheshdivakar-m3.workers.dev/analyze-hse';

  Future<AiHseResult> analyzePhoto({
    required File imageFile,
    String description = '',
    String location = '',
    String language = 'en',
  }) async {
    final List<int> bytes = await imageFile.readAsBytes();
    final String base64Image = base64Encode(bytes);
    final String mimeType = _mimeType(imageFile.path);

    final response = await http
        .post(
          Uri.parse(endpoint),
          headers: const {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'image_base64': base64Image,
            'mime_type': mimeType,
            'description': description,
            'location': location,
            'language': language,
          }),
        )
        .timeout(const Duration(seconds: 90));

    dynamic decoded;

    try {
      decoded = jsonDecode(response.body);
    } catch (_) {
      throw Exception(
        'Invalid response received from HSE AI server.',
      );
    }

    if (decoded is! Map) {
      throw Exception(
        'Invalid AI server response.',
      );
    }

    final Map<String, dynamic> data =
        Map<String, dynamic>.from(decoded);

    if (response.statusCode < 200 ||
        response.statusCode >= 300) {
      throw Exception(
        data['error']?.toString() ??
            'AI analysis failed. HTTP ${response.statusCode}',
      );
    }

    if (data['success'] != true) {
      throw Exception(
        data['error']?.toString() ??
            'AI analysis failed.',
      );
    }

    final dynamic rawResult = data['result'];

    if (rawResult is! Map) {
      throw Exception(
        'AI result is missing.',
      );
    }

    return AiHseResult.fromJson(
      Map<String, dynamic>.from(rawResult),
    );
  }

  String _mimeType(String path) {
    final String lower = path.toLowerCase();

    if (lower.endsWith('.png')) {
      return 'image/png';
    }

    if (lower.endsWith('.webp')) {
      return 'image/webp';
    }

    if (lower.endsWith('.gif')) {
      return 'image/gif';
    }

    if (lower.endsWith('.jpg') ||
        lower.endsWith('.jpeg')) {
      return 'image/jpeg';
    }

    return 'image/jpeg';
  }
}
