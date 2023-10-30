import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

enum PreferenceTypes {
  USER_STEAM_ID,
}

class Preferences {
  static final Future<SharedPreferences> _prefs =
      SharedPreferences.getInstance();
  static SharedPreferences _prefsInstance;

  static Future<void> initPrefs() async {
    _prefsInstance = await _prefs;
  }

  static String getStringValueByType(PreferenceTypes type) {
    if (_prefsInstance == null) {
      throw Exception('SharedPreferences not loaded');
    }
    return _prefsInstance.getString(_mapTypeToString(type));
  }

  static Future<void> setStringValueByType(
      PreferenceTypes type, String value) async {
    if (_prefsInstance == null) {
      _prefsInstance = await _prefs;
    }
    await _prefsInstance.setString(_mapTypeToString(type), value);
  }

  static Future<bool> clearValues() async {
    if (_prefsInstance == null) {
      _prefsInstance = await _prefs;
    }
    return await _prefsInstance.clear();
  }

  static String _mapTypeToString(PreferenceTypes type) {
    switch (type) {
      case PreferenceTypes.USER_STEAM_ID:
        return 'steamId';
      default:
        return '';
    }
  }
}
