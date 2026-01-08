abstract class OnboardingEvent {}

class OnboardingNextPage extends OnboardingEvent {}

class OnboardingLoadPreferences extends OnboardingEvent {}

class OnboardingAnalyticsChanged extends OnboardingEvent {
  final bool accepted;
  OnboardingAnalyticsChanged(this.accepted);
}

class OnboardingRequestLocation extends OnboardingEvent {}

class OnboardingCompleted extends OnboardingEvent {}