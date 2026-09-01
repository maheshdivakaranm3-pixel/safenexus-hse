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
          json['potential_consequence']
                  ?.toString() ??
              'Injury',
      correctiveAction:
          json['corrective_action']
                  ?.toString() ??
              '',
      confidence:
          (json['confidence'] as num?)
                  ?.toDouble() ??
              0.0,
      explanation:
          json['explanation']?.toString() ??
              '',
    );
  }
}

class AiHseService {
  // ============================================================
  // IMPORTANT
  // ============================================================
  //
  // Replace this with your deployed Cloudflare Worker URL.
  //
  // Example:
  // https://safenexus-hse-ai.yourname.workers.dev
  //
  static const String endpoint =
      'https://YOUR-WORKER-URL.workers.dev/analyze-hse';

  Future<AiHseResult> analyzePhoto({
    required File imageFile,
    String description = '',
    String location = '',
  }) async {
    final List<int> bytes =
        await imageFile.readAsBytes();

    final String base64Image =
        base64Encode(bytes);

    final String mimeType =
        _mimeType(imageFile.path);

    final response = await http.post(
      Uri.parse(endpoint),
      headers: {
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

    if (response.statusCode < 200 ||
        response.statusCode >= 300) {
      try {
        final Map<String, dynamic> error =
            jsonDecode(response.body);

        throw Exception(
          error['error']?.toString() ??
              'AI analysis failed.',
        );
      } catch (_) {
        throw Exception(
          'AI analysis failed '
          '(${response.statusCode}).',
        );
      }
    }

    final Map<String, dynamic> data =
        jsonDecode(response.body);

    if (data['success'] != true) {
      throw Exception(
        data['error']?.toString() ??
            'AI analysis failed.',
      );
    }

    final result =
        data['result'];

    if (result is! Map) {
      throw Exception(
        'Invalid AI response.',
      );
    }

    return AiHseResult.fromJson(
      Map<String, dynamic>.from(result),
    );
  }

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

    return 'image/jpeg';
  }
}
