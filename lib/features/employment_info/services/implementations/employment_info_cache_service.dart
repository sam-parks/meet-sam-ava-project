import 'dart:convert';
import 'package:meet_sam_ava/features/employment_info/model/employment_data.dart';
import 'package:meet_sam_ava/features/employment_info/services/interfaces/employment_info_cache_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmploymentInfoCacheService implements IEmploymentInfoCacheService {
  static const String _storageKey = 'employment_info_data';

  @override
  Future<EmploymentData?> get() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(_storageKey);
      
      if (jsonString != null) {
        final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
        return EmploymentData.fromJson(jsonMap);
      }
      
      return null;
    } catch (e) {
      throw Exception('Failed to load employment information from cache: $e');
    }
  }

  @override
  Future<void> save(EmploymentData data) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = jsonEncode(data.toJson());
      await prefs.setString(_storageKey, jsonString);
    } catch (e) {
      throw Exception('Failed to save employment information to cache: $e');
    }
  }

  @override
  Future<void> delete() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_storageKey);
    } catch (e) {
      throw Exception('Failed to delete employment information from cache: $e');
    }
  }

  @override
  Future<bool> exists() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.containsKey(_storageKey);
    } catch (e) {
      throw Exception('Failed to check if employment information exists in cache: $e');
    }
  }
}