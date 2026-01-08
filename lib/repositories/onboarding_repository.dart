
import 'dart:convert';

import 'package:hero_dex_go/bloc/onboarding/onboarding_event.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingRepository {
  final SharedPreferences _prefs;
  
  static const String kOnboardingSettings = 'onboarding';
  static const String kOnboardingCompleted = 'onboarding_completed';
  static const String kAnalyticsAccepted = 'analytics_accepted';
  static const String kLocationGranted = 'location_granted';

  OnboardingRepository({required SharedPreferences prefs}) : _prefs = prefs;

  Future<void> saveOnboardingPerferences(Map<String, dynamic> perferences) async {
    String encodedMap = json.encode(perferences);

    await _prefs.setString(kOnboardingSettings, encodedMap);
  }

  Map<String, dynamic> getOnboardingPreferences() {
    String? encodedMap = _prefs.getString(kOnboardingSettings);
    
    if (encodedMap != null) {
      Map<String, dynamic> decodedMap = json.decode(encodedMap);
      return decodedMap;
    }
    
    return {};
  }
}