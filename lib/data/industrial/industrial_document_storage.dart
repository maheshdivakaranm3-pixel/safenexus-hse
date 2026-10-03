import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class IndustrialDocumentStorage {
  static const profileKey = 'industrial_project_profile_v1';
  static const recordsKey = 'industrial_document_records_v2';

  static Future<Map<String, String>> loadProfile() async {
    final p = await SharedPreferences.getInstance();
    final raw = p.getString(profileKey);
    if (raw == null) return <String, String>{};
    try { return Map<String, String>.from(jsonDecode(raw) as Map); } catch (_) { return <String, String>{}; }
  }

  static Future<void> saveProfile(Map<String, String> profile) async {
    final p = await SharedPreferences.getInstance();
    await p.setString(profileKey, jsonEncode(profile));
  }

  static Future<List<Map<String, dynamic>>> loadRecords() async {
    final p = await SharedPreferences.getInstance();
    final raw = p.getString(recordsKey);
    if (raw == null) return <Map<String, dynamic>>[];
    try { return (jsonDecode(raw) as List).map((e) => Map<String, dynamic>.from(e as Map)).toList(); } catch (_) { return <Map<String, dynamic>>[]; }
  }

  static Future<void> saveRecords(List<Map<String, dynamic>> records) async {
    final p = await SharedPreferences.getInstance();
    await p.setString(recordsKey, jsonEncode(records));
  }
}
