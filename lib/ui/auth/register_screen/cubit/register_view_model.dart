import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapproute/api/api_manager.dart';
import 'package:movieapproute/ui/auth/register_screen/cubit/register_states.dart';

class RegisterViewModel extends Cubit<RegisterStates> {
  RegisterViewModel() : super(RegisterInitialState());
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  int currentPage = 3;
  bool isObscure = true;
  bool isObscureRe = true;
  var formKey = GlobalKey<FormState>();
  PageController controller = PageController(
    viewportFraction: 0.35,
    initialPage: 3,
  );
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

  void onPressedRegister() {
    if (formKey.currentState?.validate() == true) {
      //todo: register
      register(
        nameController.text,
        emailController.text,
        passwordController.text,
        confirmPasswordController.text,
        phoneController.text,
        currentPage,
      );
    }
  }
}
