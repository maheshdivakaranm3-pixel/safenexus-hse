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
  /// SafeNexus HSE Cloudflare Worker
  ///
  /// IMPORTANT:
  /// OpenAI API key must NEVER be stored
  /// inside the Flutter application.
  static const String endpoint =
      'https://safenexus-hse-v2.maheshdivakar-m3.workers.dev/analyze-hse';

  Future<AiHseResult> analyzePhoto({
    required File imageFile,
    String description = '',
    String location = '',
    String language = 'en',
  }) async {
    if (!await imageFile.exists()) {
      throw Exception(
        'Selected image file does not exist.',
      );
    }

    final List<int> bytes =
        await imageFile.readAsBytes();

    if (bytes.isEmpty) {
      throw Exception(
        'Selected image is empty.',
      );
    }

    final String base64Image =
        base64Encode(bytes);

    final String mimeType =
        _mimeType(imageFile.path);

    final Uri uri =
        Uri.parse(endpoint);

    http.Response response;

    try {
      response = await http
          .post(
            uri,

            headers: const {
              'Content-Type':
                  'application/json',
              'Accept':
                  'application/json',
            },

            body: jsonEncode({
              'image_base64':
                  base64Image,

              'mime_type':
                  mimeType,

              'description':
                  description.trim(),

              'location':
                  location.trim(),

              'language':
                  language.toLowerCase(),
            }),
          )
          .timeout(
            const Duration(
              seconds: 90,
            ),
          );
    } on SocketException {
      throw Exception(
        'Unable to connect to the HSE AI server.',
      );
    } on HttpException {
      throw Exception(
        'HSE AI server connection failed.',
      );
    } on FormatException {
      throw Exception(
        'Invalid HSE AI server address.',
      );
    } catch (e) {
      throw Exception(
        'Network error: $e',
      );
    }

    dynamic decoded;

    try {
      decoded =
          jsonDecode(response.body);
    } catch (_) {
      throw Exception(
        'Invalid response received from HSE AI server '
        '(HTTP ${response.statusCode}).',
      );
    }

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

    if (response.statusCode < 200 ||
        response.statusCode >= 300) {
      final String serverError =
          data['error']?.toString() ??
              'AI analysis failed.';

      throw Exception(
        '$serverError '
        '(HTTP ${response.statusCode})',
      );
    }

    // ==========================================================
    // SUCCESS CHECK
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

    return AiHseResult.fromJson(
      Map<String, dynamic>.from(
        rawResult,
      ),
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

    if (lower.endsWith('.jpg') ||
        lower.endsWith('.jpeg')) {
      return 'image/jpeg';
    }

    // image_picker normally gives JPEG
    // when imageQuality is used.
    return 'image/jpeg';
  }
}
