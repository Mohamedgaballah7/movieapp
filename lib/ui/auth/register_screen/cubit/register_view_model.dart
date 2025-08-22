import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapproute/api/api_manager.dart';
import 'package:movieapproute/ui/auth/register_screen/cubit/register_states.dart';

class RegisterViewModel extends Cubit<RegisterStates> {
  RegisterViewModel() : super(RegisterInitialState());

  //todo: handle Logic "register states holds the data"
  Future<void> register(
    String name,
    String email,
    String password,
    String confirmPassword,
    String phone,
    int avatarId,
  ) async {
    try {
      var response = await ApiManager.postRegisterData(
        name,
        email,
        password,
        confirmPassword,
        phone,
        avatarId,
      );
      //todo handle the success state
      if (response.message == "User created successfully") {
        emit(RegisterSuccessState(successMessage: response.message!));

        return;
      }
      //todo:handle the error state
      else {
        emit(RegisterErrorState(errorMessage: response.message!));
        print('${response.message}');
        return;
      }
    } catch (e) {
      emit(RegisterErrorState(errorMessage: e.toString()));
    }
  }
}
