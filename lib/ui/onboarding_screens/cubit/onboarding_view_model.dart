import 'package:flutter_bloc/flutter_bloc.dart';

import 'onboarding_states.dart';

class OnboardingViewModel extends Cubit<OnboardingState> {
  OnboardingViewModel() : super(OnboardingInitialState());

  int currentPage = 0;

  void changePage(int index) {
    currentPage = index;
    emit(OnboardingPageChangedState(index));
  }
}
