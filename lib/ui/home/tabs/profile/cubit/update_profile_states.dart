abstract class UpdateProfileStates {}

class LoadingState extends UpdateProfileStates {}

class UpdateProfileInitialState extends UpdateProfileStates {}

class SuccessGetState extends UpdateProfileStates {
  int? avatarId;
  String? phone;
  String? name;

  SuccessGetState({this.name, this.phone, this.avatarId});
}

class ErrorState extends UpdateProfileStates {
  String message;

  ErrorState({required this.message});
}

class SuccessDeleteState extends UpdateProfileStates {
  String successMessage;

  SuccessDeleteState({required this.successMessage});
}

class SuccessUpdateState extends UpdateProfileStates {
  String successMessage;

  SuccessUpdateState({required this.successMessage});
}

class SuccessChangeState extends UpdateProfileStates {
  String successMessage;

  SuccessChangeState({required this.successMessage});
}