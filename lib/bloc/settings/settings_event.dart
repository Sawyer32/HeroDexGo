abstract class SettingsEvent {}

class SettingsLoad extends SettingsEvent {}

class SettingsToggleAnalytics extends SettingsEvent {
  final bool newVaule;

  SettingsToggleAnalytics({required this.newVaule});
}

class SettingsRequestGps extends SettingsEvent {}

class SettingsToggleTheme extends SettingsEvent {
  final bool isDark;
  SettingsToggleTheme({required this.isDark});
}
