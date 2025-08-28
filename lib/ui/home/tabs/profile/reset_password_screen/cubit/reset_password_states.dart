class ResetPasswordStates {}

class ResetInitialState extends ResetPasswordStates {}

class ResetSuccessState extends ResetPasswordStates {
  final String successMessage;

  ResetSuccessState({required this.successMessage});
}

class ResetErrorState extends ResetPasswordStates {
  final String errorMessage;

  ResetErrorState({required this.errorMessage});
}
