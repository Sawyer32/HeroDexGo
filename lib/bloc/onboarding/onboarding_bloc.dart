import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero_dex_go/bloc/onboarding/onboarding_event.dart';
import 'package:hero_dex_go/bloc/onboarding/onboarding_state.dart';
import 'package:permission_handler/permission_handler.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc() : super(OnboardingState()) {
    // Handle next page
    on<OnboardingNextPage>((event, emit) {
      emit(state.copyWith(pageIndex: state.pageIndex + 1));
    });

    // Handle analytics
    on<OnboardingAnalyticsChanged>((event, emit) {
      // TODO: call analytics-service 
      // EX. FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(event.accepted);

      emit(state.copyWith(
        analyticsAccepted: event.accepted,
        pageIndex: state.pageIndex + 1,
      ));
    });

    // Handle GPS request
    on<OnboardingRequestLocation>((event, emit) async {
      // Ask system 
      PermissionStatus status = await Permission.location.request();

      if (status.isGranted) {
        emit(state.copyWith(locationGranted: true));
        add(OnboardingCompleted());
      } else {
        emit(state.copyWith(locationGranted: false));
      }
    });

    // Finish onboarding
    on<OnboardingCompleted>((event, emit) {
      // TODO: Save to SharedPreferences
      // await prefs.setBool('seenOnboarding', true);

      emit(state.copyWith(isCompleted: true));
    });
  }
}