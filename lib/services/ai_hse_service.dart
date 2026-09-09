import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

/// ============================================================
/// SafeNexus HSE
/// AI HSE Result Model
/// ============================================================
///
/// Structured result returned by the SafeNexus HSE AI backend.
///
/// The Flutter application does NOT communicate directly with
/// OpenAI. It communicates with the secure Cloudflare Worker.
///
/// Supported response language:
/// - English
/// - Malayalam
/// ============================================================

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

  // ============================================================
  // FROM JSON
  // ============================================================

  factory AiHseResult.fromJson(
    Map<String, dynamic> json,
  ) {
    return AiHseResult(
      observationType: _stringValue(
        json['observation_type'],
        'Unsafe Condition',
      ),
      category: _stringValue(
        json['category'],
        'General Safety',
      ),
      hazard: _stringValue(
        json['hazard'],
        'General Workplace Hazard',
      ),
      riskLevel: _normalizeRiskLevel(
        json['risk_level'],
      ),
      potentialConsequence: _stringValue(
        json['potential_consequence'],
        'Potential injury or property damage.',
      ),
      correctiveAction: _stringValue(
        json['corrective_action'],
        'Follow applicable HSE controls and site procedures.',
      ),
      confidence: _confidenceValue(
        json['confidence'],
      ),
      explanation: _stringValue(
        json['explanation'],
        'AI analysis completed.',
      ),
    );
  }

  // ============================================================
  // TO JSON
  // ============================================================

  Map<String, dynamic> toJson() {
    return {
      'observation_type': observationType,
      'category': category,
      'hazard': hazard,
      'risk_level': riskLevel,
      'potential_consequence': potentialConsequence,
      'corrective_action': correctiveAction,
      'confidence': confidence,
      'explanation': explanation,
    };
  }

  // ============================================================
  // STRING NORMALIZATION
  // ============================================================

  static String _stringValue(
    dynamic value,
    String fallback,
  ) {
    if (value == null) {
      return fallback;
    }

    final String text = value.toString().trim();

    if (text.isEmpty) {
      return fallback;
    }

    return text;
  }

  // ============================================================
  // RISK LEVEL NORMALIZATION
  // ============================================================

  static String _normalizeRiskLevel(
    dynamic value,
  ) {
    final String risk = value
            ?.toString()
            .trim()
            .toLowerCase() ??
        '';

    switch (risk) {
      case 'low':
        return 'Low';

      case 'medium':
      case 'moderate':
        return 'Medium';

      case 'high':
        return 'High';

      case 'critical':
      case 'severe':
        return 'Critical';

      default:
        return 'Medium';
    }
  }

  // ============================================================
  // CONFIDENCE NORMALIZATION
  // ============================================================

  static double _confidenceValue(
    dynamic value,
  ) {
    double result = 0.0;

    if (value is num) {
      result = value.toDouble();
    } else if (value != null) {
      result = double.tryParse(
            value.toString().trim(),
          ) ??
          0.0;
    }

    // Backend may return:
    // 0.85
    // or
    // 85
    if (result > 1 && result <= 100) {
      result = result / 100;
    }

    if (result < 0) {
      result = 0;
    }

    if (result > 1) {
      result = 1;
    }

    return result;
  }
}

/// ============================================================
/// SafeNexus HSE
/// AI HSE Service
/// ============================================================
///
/// Communicates with the SafeNexus HSE Cloudflare Worker.
///
/// IMPORTANT:
/// The OpenAI API key must NEVER be placed inside this Flutter
/// application.
///
/// Flutter App
///     ↓
/// Cloudflare Worker
///     ↓
/// OpenAI
///     ↓
/// Cloudflare Worker
///     ↓
/// Flutter App
/// ============================================================

class AiHseService {
  // ============================================================
  // BACKEND ENDPOINT
  // ============================================================

  static const String endpoint =
      'https://safenexus-hse-v2.maheshdivakar-m3.workers.dev/analyze-hse';

  // ============================================================
  // REQUEST TIMEOUT
  // ============================================================

  static const Duration requestTimeout =
      Duration(seconds: 90);

  // ============================================================
  // MAX IMAGE SIZE
  // ============================================================

  static const int maxImageBytes =
      10 * 1024 * 1024;

  // ============================================================
  // ANALYZE PHOTO
  // ============================================================

  Future<AiHseResult> analyzePhoto({
    required File imageFile,
    String description = '',
    String location = '',
    String language = 'en',
  }) async {
    // ----------------------------------------------------------
    // 1. CHECK FILE
    // ----------------------------------------------------------

    if (!await imageFile.exists()) {
      throw const AiHseException(
        'Selected image file does not exist.',
      );
    }

    // ----------------------------------------------------------
    // 2. READ FILE
    // ----------------------------------------------------------

    final List<int> bytes;

    try {
      bytes = await imageFile.readAsBytes();
    } catch (error) {
      throw AiHseException(
        'Unable to read the selected image.',
        details: error.toString(),
      );
    }

    // ----------------------------------------------------------
    // 3. EMPTY IMAGE CHECK
    // ----------------------------------------------------------

    if (bytes.isEmpty) {
      throw const AiHseException(
        'Selected image is empty.',
      );
    }

    // ----------------------------------------------------------
    // 4. IMAGE SIZE CHECK
    // ----------------------------------------------------------

    if (bytes.length > maxImageBytes) {
      throw const AiHseException(
        'Image is too large. Maximum allowed size is 10 MB.',
      );
    }

    // ----------------------------------------------------------
    // 5. BASE64 ENCODE
    // ----------------------------------------------------------

    final String base64Image = base64Encode(bytes);

    // ----------------------------------------------------------
    // 6. MIME TYPE
    // ----------------------------------------------------------

    final String mimeType =
        _mimeType(imageFile.path);

    // ----------------------------------------------------------
    // 7. LANGUAGE
    // ----------------------------------------------------------
    //
    // SafeNexus currently supports:
    // English = en
    // Malayalam = ml
    //
    // Any unsupported value falls back to English.
    // ----------------------------------------------------------

    final String responseLanguage =
        _normalizeLanguage(language);

    // ----------------------------------------------------------
    // 8. REQUEST BODY
    // ----------------------------------------------------------

    final Map<String, dynamic> requestBody = {
      'image_base64': base64Image,
      'mime_type': mimeType,
      'description': description.trim(),
      'location': location.trim(),
      'language': responseLanguage,
    };

    // ----------------------------------------------------------
    // 9. SERVER URI
    // ----------------------------------------------------------

    final Uri uri;

    try {
      uri = Uri.parse(endpoint);
    } catch (error) {
      throw AiHseException(
        'Invalid HSE AI server address.',
        details: error.toString(),
      );
    }

    // ----------------------------------------------------------
    // 10. HTTP REQUEST
    // ----------------------------------------------------------

    http.Response response;

    try {
      response = await http
          .post(
            uri,
            headers: const {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
            body: jsonEncode(requestBody),
          )
          .timeout(requestTimeout);
    } on SocketException {
      throw const AiHseException(
        'Unable to connect to the HSE AI server. '
        'Please check your internet connection.',
      );
    } on HttpException {
      throw const AiHseException(
        'HSE AI server connection failed.',
      );
    } on FormatException {
      throw const AiHseException(
        'Invalid HSE AI server address.',
      );
    } on http.ClientException catch (error) {
      throw AiHseException(
        'HSE AI network request failed.',
        details: error.message,
      );
    } on IOException catch (error) {
      throw AiHseException(
        'Network error while contacting the HSE AI server.',
        details: error.toString(),
      );
    } catch (error) {
      throw AiHseException(
        'Unexpected error while contacting the HSE AI server.',
        details: error.toString(),
      );
    }

    // ----------------------------------------------------------
    // 11. DECODE RESPONSE
    // ----------------------------------------------------------

    final dynamic decoded = _decodeJsonResponse(
      response.body,
      response.statusCode,
    );

    // ----------------------------------------------------------
    // 12. RESPONSE TYPE CHECK
    // ----------------------------------------------------------

    if (decoded is! Map) {
      throw AiHseException(
        'Invalid AI server response.',
        details:
            'Expected JSON object but received '
            '${decoded.runtimeType}.',
      );
    }

    final Map<String, dynamic> data =
        Map<String, dynamic>.from(decoded);

    // ----------------------------------------------------------
    // 13. HTTP STATUS CHECK
    // ----------------------------------------------------------

    if (response.statusCode < 200 ||
        response.statusCode >= 300) {
      throw AiHseException(
        _extractServerError(data),
        statusCode: response.statusCode,
      );
    }

    // ----------------------------------------------------------
    // 14. APPLICATION SUCCESS CHECK
    // ----------------------------------------------------------

    if (data['success'] != true) {
      throw AiHseException(
        _extractServerError(data),
        statusCode: response.statusCode,
      );
    }

    // ----------------------------------------------------------
    // 15. RESULT CHECK
    // ----------------------------------------------------------

    final dynamic rawResult = data['result'];

    if (rawResult is! Map) {
      throw const AiHseException(
        'AI analysis completed but no result was returned.',
      );
    }

    final Map<String, dynamic> result =
        Map<String, dynamic>.from(rawResult);

    // ----------------------------------------------------------
    // 16. RETURN STRUCTURED RESULT
    // ----------------------------------------------------------

    return AiHseResult.fromJson(result);
  }

  // ============================================================
  // LANGUAGE NORMALIZATION
  // ============================================================

  String _normalizeLanguage(
    String language,
  ) {
    final String value =
        language.trim().toLowerCase();

    if (value == 'ml' ||
        value == 'malayalam' ||
        value.startsWith('ml-')) {
      return 'ml';
    }

    return 'en';
  }

  // ============================================================
  // JSON RESPONSE
  // ============================================================

  dynamic _decodeJsonResponse(
    String body,
    int statusCode,
  ) {
    if (body.trim().isEmpty) {
      throw AiHseException(
        'Empty response received from HSE AI server.',
        statusCode: statusCode,
      );
    }

    try {
      return jsonDecode(body);
    } catch (error) {
      throw AiHseException(
        'Invalid response received from HSE AI server.',
        statusCode: statusCode,
        details: error.toString(),
      );
    }
  }

  // ============================================================
  // SERVER ERROR
  // ============================================================

  String _extractServerError(
    Map<String, dynamic> data,
  ) {
    final dynamic error = data['error'];

    if (error != null) {
      final String message =
          error.toString().trim();

      if (message.isNotEmpty) {
        return message;
      }
    }

    final dynamic message = data['message'];

    if (message != null) {
      final String text =
          message.toString().trim();

      if (text.isNotEmpty) {
        return text;
      }
    }

    return 'AI analysis failed. Please try again.';
  }

  // ============================================================
  // MIME TYPE
  // ============================================================

  String _mimeType(
    String path,
  ) {
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

    // image_picker normally produces JPEG
    // when imageQuality is used.
    return 'image/jpeg';
  }
}

/// ============================================================
/// SafeNexus HSE AI Exception
/// ============================================================

class AiHseException implements Exception {
  final String message;
  final int? statusCode;
  final String? details;

  const AiHseException(
    this.message, {
    this.statusCode,
    this.details,
  });

  @override
  String toString() {
    if (statusCode != null) {
      return '$message (HTTP $statusCode)';
    }

    return message;
  }
}
