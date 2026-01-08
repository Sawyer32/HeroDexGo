
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero_dex_go/bloc/settings/settings_event.dart';
import 'package:hero_dex_go/bloc/settings/settings_state.dart';
import 'package:hero_dex_go/repositories/settings_repository.dart';
import 'package:permission_handler/permission_handler.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SettingsRepository _settingsRepository;

  SettingsBloc({required SettingsRepository settingsRepository}) : _settingsRepository = settingsRepository, super(SettingsState()) {
    on<SettingsLoad>((event, emit) async {
      final theme = _settingsRepository.getThemeMode();
      final analytics = _settingsRepository.getAnalyticsEnabled();
      final gpsStatus = await Permission.location.status;

      emit(state.copyWith(
        themeMode: theme,
        analyticsEnabled: analytics,
        locationEnabled: gpsStatus.isGranted
      ));
    });

    on<SettingsToggleAnalytics>((event, emit) async {
      await _settingsRepository.setAnalyticsEnabled(event.newVaule);
      emit(state.copyWith(analyticsEnabled: event.newVaule));
    });

    on<SettingsRequestGps>((event, emit) async {
      final status = await Permission.location.request();
      emit(state.copyWith(locationEnabled: status.isGranted));
    });

    on<SettingsToggleTheme>((event, emit) async {
      await _settingsRepository.saveThemeMode(event.isDark ? ThemeMode.dark : ThemeMode.light);
      emit(state.copyWith(isDarkMode: event.isDark));
    });
  }
}