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

  factory AiHseResult.fromJson(
    Map<String, dynamic> json,
  ) {
    return AiHseResult(
      observationType:
          json['observation_type']?.toString() ??
              'Unsafe Condition',
      category:
          json['category']?.toString() ??
              'General Safety',
      hazard:
          json['hazard']?.toString() ??
              'General Workplace Hazard',
      riskLevel:
          json['risk_level']?.toString() ??
              'Medium',
      potentialConsequence:
          json['potential_consequence']?.toString() ??
              'Injury',
      correctiveAction:
          json['corrective_action']?.toString() ??
              '',
      confidence:
          (json['confidence'] as num?)?.toDouble() ??
              0.0,
      explanation:
          json['explanation']?.toString() ??
              '',
    );
  }
}

class AiHseService {
  // ============================================================
  // SAFE BACKEND ENDPOINT
  // ============================================================
  //
  // IMPORTANT:
  // Do NOT put your OpenAI API key here.
  //
  // After deploying Cloudflare Worker, replace only the URL below.
  //
  // Example:
  //
  // https://safenexus-hse-ai.example.workers.dev/analyze-hse
  //
  static const String endpoint =
      'https://YOUR-WORKER-URL.workers.dev/analyze-hse';

  // ============================================================
  // ANALYZE PHOTO
  // ============================================================

  Future<AiHseResult> analyzePhoto({
    required File imageFile,
    String description = '',
    String location = '',
  }) async {
    // Read image bytes.
    final List<int> bytes =
        await imageFile.readAsBytes();

    // Convert image to Base64.
    final String base64Image =
        base64Encode(bytes);

    // Detect MIME type.
    final String mimeType =
        _mimeType(imageFile.path);

    // Send photo to secure backend.
    final http.Response response =
        await http.post(
      Uri.parse(endpoint),
      headers: const {
        'Content-Type':
            'application/json',
      },
      body: jsonEncode({
        'image_base64': base64Image,
        'mime_type': mimeType,
        'description': description,
        'location': location,
      }),
    );

    // ==========================================================
    // HTTP ERROR
    // ==========================================================

    if (response.statusCode < 200 ||
        response.statusCode >= 300) {
      String message =
          'AI analysis failed.';

      try {
        final dynamic decoded =
            jsonDecode(response.body);

        if (decoded is Map &&
            decoded['error'] != null) {
          message =
              decoded['error'].toString();
        }
      } catch (_) {
        // Keep default message.
      }

      throw Exception(
        '$message '
        'HTTP ${response.statusCode}',
      );
    }

    // ==========================================================
    // DECODE RESPONSE
    // ==========================================================

    final dynamic decoded =
        jsonDecode(response.body);

    if (decoded is! Map) {
      throw Exception(
        'Invalid AI server response.',
      );
    }

    final Map<String, dynamic> data =
        Map<String, dynamic>.from(
      decoded,
    );

    // ==========================================================
    // SERVER ERROR
    // ==========================================================

    if (data['success'] != true) {
      throw Exception(
        data['error']?.toString() ??
            'AI analysis failed.',
      );
    }

    // ==========================================================
    // RESULT
    // ==========================================================

    final dynamic rawResult =
        data['result'];

    if (rawResult is! Map) {
      throw Exception(
        'AI result is missing.',
      );
    }

    final Map<String, dynamic> result =
        Map<String, dynamic>.from(
      rawResult,
    );

    return AiHseResult.fromJson(
      result,
    );
  }

  // ============================================================
  // MIME TYPE
  // ============================================================

  String _mimeType(String path) {
    final String lower =
        path.toLowerCase();

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

    // Default for camera photos.
    return 'image/jpeg';
  }
}
