abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {
  //todo:until data sent or not
}

class RegisterSuccessState extends RegisterStates {
  String successMessage;

  RegisterSuccessState({required this.successMessage});
}

class RegisterErrorState extends RegisterStates {
  String errorMessage;

  RegisterErrorState({required this.errorMessage});
}
