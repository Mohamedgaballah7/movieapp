abstract class OnboardingState {}

class OnboardingInitialState extends OnboardingState {}

class OnboardingPageChangedState extends OnboardingState {
  final int currentPage;

  OnboardingPageChangedState(this.currentPage);
}
