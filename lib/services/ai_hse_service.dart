import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

/// Structured result returned by the SafeNexus HSE AI backend.
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
        'Potential injury or property damage',
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

  static String _stringValue(
    dynamic value,
    String fallback,
  ) {
    if (value == null) {
      return fallback;
    }

    final text = value.toString().trim();

    return text.isEmpty ? fallback : text;
  }

  static String _normalizeRiskLevel(
    dynamic value,
  ) {
    final risk = value
        ?.toString()
        .trim()
        .toLowerCase();

    switch (risk) {
      case 'low':
        return 'Low';

      case 'medium':
        return 'Medium';

      case 'high':
        return 'High';

      case 'critical':
        return 'Critical';

      default:
        return 'Medium';
    }
  }

  static double _confidenceValue(
    dynamic value,
  ) {
    double result = 0.0;

    if (value is num) {
      result = value.toDouble();
    } else if (value != null) {
      result =
          double.tryParse(value.toString()) ?? 0.0;
    }

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

/// Service responsible for communicating with the
/// SafeNexus HSE AI backend.
///
/// IMPORTANT:
/// The OpenAI API key is never stored in this Flutter app.
/// The app communicates only with the Cloudflare Worker.
class AiHseService {
  static const String endpoint =
      'https://safenexus-hse-v2.maheshdivakar-m3.workers.dev/analyze-hse';

  static const Duration requestTimeout =
      Duration(seconds: 90);

  /// Analyze a workplace photo.
  ///
  /// The image is sent to the SafeNexus Cloudflare Worker.
  /// The Worker securely communicates with OpenAI.
  Future<AiHseResult> analyzePhoto({
    required File imageFile,
    String description = '',
    String location = '',
    String language = 'en',
  }) async {
    // ------------------------------------------------------------
    // FILE VALIDATION
    // ------------------------------------------------------------

    if (!await imageFile.exists()) {
      throw const AiHseException(
        'Selected image file does not exist.',
      );
    }

    final List<int> bytes;

    try {
      bytes = await imageFile.readAsBytes();
    } catch (error) {
      throw AiHseException(
        'Unable to read the selected image.',
        details: error.toString(),
      );
    }

    if (bytes.isEmpty) {
      throw const AiHseException(
        'Selected image is empty.',
      );
    }

    // ------------------------------------------------------------
    // IMAGE SIZE
    // ------------------------------------------------------------

    const maxImageBytes = 10 * 1024 * 1024;

    if (bytes.length > maxImageBytes) {
      throw const AiHseException(
        'Image is too large. Maximum allowed size is 10 MB.',
      );
    }

    // ------------------------------------------------------------
    // BASE64
    // ------------------------------------------------------------

    final String base64Image =
        base64Encode(bytes);

    // ------------------------------------------------------------
    // MIME TYPE
    // ------------------------------------------------------------

    final String mimeType =
        _mimeType(imageFile.path);

    // ------------------------------------------------------------
    // LANGUAGE
    // ------------------------------------------------------------

    final String normalizedLanguage =
        language.toLowerCase().trim();

    final String responseLanguage =
        normalizedLanguage.startsWith('ml')
            ? 'ml'
            : 'en';

    // ------------------------------------------------------------
    // REQUEST BODY
    // ------------------------------------------------------------

    final Map<String, dynamic> requestBody = {
      'image_base64': base64Image,
      'mime_type': mimeType,
      'description': description.trim(),
      'location': location.trim(),
      'language': responseLanguage,
    };

    // ------------------------------------------------------------
    // URI
    // ------------------------------------------------------------

    final Uri uri;

    try {
      uri = Uri.parse(endpoint);
    } catch (error) {
      throw AiHseException(
        'Invalid HSE AI server address.',
        details: error.toString(),
      );
    }

    // ------------------------------------------------------------
    // HTTP REQUEST
    // ------------------------------------------------------------

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
    } catch (error) {
      throw AiHseException(
        'Network error while contacting the HSE AI server.',
        details: error.toString(),
      );
    }

    // ------------------------------------------------------------
    // DECODE RESPONSE
    // ------------------------------------------------------------

    final dynamic decoded =
        _decodeJsonResponse(
      response.body,
      response.statusCode,
    );

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

    // ------------------------------------------------------------
    // HTTP ERROR
    // ------------------------------------------------------------

    if (response.statusCode < 200 ||
        response.statusCode >= 300) {
      throw AiHseException(
        _extractServerError(data),
        statusCode: response.statusCode,
      );
    }

    // ------------------------------------------------------------
    // APPLICATION ERROR
    // ------------------------------------------------------------

    if (data['success'] != true) {
      throw AiHseException(
        _extractServerError(data),
        statusCode: response.statusCode,
      );
    }

    // ------------------------------------------------------------
    // RESULT
    // ------------------------------------------------------------

    final dynamic rawResult =
        data['result'];

    if (rawResult is! Map) {
      throw const AiHseException(
        'AI analysis completed but no result was returned.',
      );
    }

    final Map<String, dynamic> result =
        Map<String, dynamic>.from(rawResult);

    return AiHseResult.fromJson(result);
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
    final dynamic error =
        data['error'];

    if (error != null) {
      final String message =
          error.toString().trim();

      if (message.isNotEmpty) {
        return message;
      }
    }

    final dynamic message =
        data['message'];

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

    // image_picker normally produces JPEG
    // when imageQuality is used.
    return 'image/jpeg';
  }
}

/// Application-level exception used by
/// the SafeNexus HSE AI service.
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
