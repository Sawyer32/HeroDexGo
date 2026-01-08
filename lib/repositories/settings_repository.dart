
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsRepository {
  final SharedPreferences _prefs;
  
  static const String kSettingsPreferences = 'settings_preferences';
  static const String kThemeMode = 'settings_theme_mode';
  static const String kAnalyticsEnabled = 'settings_analytics_enabled';

  SettingsRepository({required SharedPreferences prefs}) : _prefs = prefs;

  Future<void> saveThemeMode(ThemeMode mode) async {
    await _prefs.setString(kThemeMode, mode.toString());
  }

  ThemeMode getThemeMode() {
    final String? modeStr = _prefs.getString(kThemeMode);

    if (modeStr == ThemeMode.dark.toString()) return ThemeMode.dark;
    if (modeStr == ThemeMode.light.toString()) return ThemeMode.light;

    return ThemeMode.system;
  }

  Future<void> setAnalyticsEnabled(bool enabled) async {
    await _prefs.setBool(kAnalyticsEnabled, enabled);

    // TODO: FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(enabled);
  }

  bool getAnalyticsEnabled() {
    return _prefs.getBool(kAnalyticsEnabled) ?? false;
  }
}