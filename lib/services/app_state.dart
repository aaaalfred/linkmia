// lib/services/app_state.dart
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class AppState {
  static const String _lastRouteKey = 'lastRoute';
  static const String _userDataKey = 'userData';
  static const String _isLoggedInKey = 'isLoggedIn';

  static Future<void> saveLastRoute(String route) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_lastRouteKey, route);
  }

  static Future<String?> getLastRoute() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_lastRouteKey);
  }

  static Future<void> saveUserData(Map<String, String> userData) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userDataKey, json.encode(userData));
  }

  static Future<Map<String, String>?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userDataString = prefs.getString(_userDataKey);
    if (userDataString != null) {
      return Map<String, String>.from(json.decode(userDataString));
    }
    return null;
  }

  static Future<void> clearAppState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  static Future<void> setLoggedIn(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoggedInKey, value);
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

// En lib/services/app_state.dart

  static Future<void> clearExtractedData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('extractedData');
  }

  static Future<void> saveExtractedData(Map<String, String> data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('extractedData', json.encode(data));
  }

  static Future<Map<String, String>?> getExtractedData() async {
    final prefs = await SharedPreferences.getInstance();
    final extractedDataString = prefs.getString('extractedData');
    if (extractedDataString != null) {
      return Map<String, String>.from(json.decode(extractedDataString));
    }
    return null;
  }


}