import 'package:flutter/material.dart';

class SettingsState {
  final ThemeMode themeMode;
  final bool isDarkMode;
  final bool analyticsEnabled;
  final bool locationEnabled;

  SettingsState({
    this.themeMode = ThemeMode.system,
    this.isDarkMode = true,
    this.analyticsEnabled = false,
    this.locationEnabled = false,
  });

  SettingsState copyWith({
    bool? analyticsEnabled,
    bool? isDarkMode,
    bool? locationEnabled,
    ThemeMode? themeMode,
  }) {
    return SettingsState(
      themeMode: themeMode ?? this.themeMode,
      isDarkMode: isDarkMode ?? this.isDarkMode,
      analyticsEnabled: analyticsEnabled ?? this.analyticsEnabled,
      locationEnabled: locationEnabled ?? this.locationEnabled,
    );
  }
}
