class OnboardingState {
  final int pageIndex;
  final bool? analyticsAccepted;
  final bool locationGranted;
  final bool isCompleted;

  OnboardingState({
    this.pageIndex = 0,
    this.analyticsAccepted,
    this.locationGranted = false,
    this.isCompleted = false,
  });

  OnboardingState copyWith({
    int? pageIndex,
    bool? analyticsAccepted,
    bool? locationGranted,
    bool? isCompleted,
  }) {
    return OnboardingState(
      pageIndex: pageIndex ?? this.pageIndex,
      analyticsAccepted: analyticsAccepted ?? this.analyticsAccepted,
      locationGranted: locationGranted ?? this.locationGranted,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
