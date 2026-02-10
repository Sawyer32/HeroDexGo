import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero_dex_go/bloc/onboarding/onboarding_event.dart';
import 'package:hero_dex_go/bloc/onboarding/onboarding_state.dart';
import 'package:hero_dex_go/repositories/onboarding_repository.dart';
import 'package:permission_handler/permission_handler.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final OnboardingRepository _repository;
  OnboardingBloc({required OnboardingRepository repository})
    : _repository = repository,
      super(OnboardingState()) {
    on<OnboardingLoadPreferences>(_onLoadPerferences);
    on<OnboardingNextPage>((event, emit) {
      emit(state.copyWith(pageIndex: state.pageIndex + 1));
    });

    on<OnboardingAnalyticsChanged>((event, emit) {
      FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(event.accepted);
      if (event.accepted) {
        FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
      } else {
        FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
      }
      emit(
        state.copyWith(
          analyticsAccepted: event.accepted,
          pageIndex: state.pageIndex + 1,
        ),
      );
    });

    on<OnboardingRequestLocation>((event, emit) async {
      PermissionStatus status = await Permission.location.request();

      if (status.isGranted) {
        emit(state.copyWith(locationGranted: true));
        add(OnboardingCompleted());
      } else {
        emit(state.copyWith(locationGranted: false));
      }
    });

    on<OnboardingCompleted>((event, emit) {
      try {
        _onCompleted(event, emit);
      } catch (er) {
        debugPrint("Something went wrong: $er");
      }
    });
  }

  Future<void> _onCompleted(
    OnboardingCompleted event,
    Emitter<OnboardingState> emit,
  ) async {
    emit(state.copyWith(isCompleted: true));

    final preferencesToSave = {
      OnboardingRepository.kOnboardingCompleted: true,
      OnboardingRepository.kAnalyticsAccepted: state.analyticsAccepted ?? false,
      OnboardingRepository.kLocationGranted: state.locationGranted,
    };

    await FirebaseAnalytics.instance.logTutorialComplete();

    await _repository.saveOnboardingPreferences(preferencesToSave);
  }

  void _onLoadPerferences(
    OnboardingLoadPreferences event,
    Emitter<OnboardingState> emit,
  ) {
    final Map<String, dynamic> prefsMap = _repository
        .getOnboardingPreferences();

    if (prefsMap.isEmpty) {
      FirebaseAnalytics.instance.logTutorialBegin();
      return;
    }

    emit(
      state.copyWith(
        isCompleted:
            (prefsMap[OnboardingRepository.kOnboardingCompleted] as bool?) ??
            false,
        analyticsAccepted:
            (prefsMap[OnboardingRepository.kAnalyticsAccepted] as bool?) ??
            false,
        locationGranted:
            (prefsMap[OnboardingRepository.kLocationGranted] as bool?) ?? false,
      ),
    );
  }
}
