abstract class ProfileTabStates {}

class LoadingState extends ProfileTabStates {}

class InitialState extends ProfileTabStates {}

class UpdateProfileInitialState extends ProfileTabStates {}

class SuccessGetState extends ProfileTabStates {
  int avatarId;
  String name;

  SuccessGetState({required this.name, required this.avatarId});
}

class ErrorState extends ProfileTabStates {
  String message;

  ErrorState({required this.message});
}
