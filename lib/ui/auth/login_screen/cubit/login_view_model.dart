import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapproute/api/api_manager.dart';
import 'package:movieapproute/shared_preferences/shared_preferences.dart';
import 'package:movieapproute/ui/auth/login_screen/cubit/login_states.dart';

class LoginViewModel extends Cubit<LoginStates> {
  LoginViewModel() : super(LoginInitialState());
  TextEditingController emailController = TextEditingController(
      text: 'ahmed21585@gmail.com');
  TextEditingController passwordController = TextEditingController(
      text: 'Ahmed@123');
  bool isObscure = true;
  var formKey = GlobalKey<FormState>();

  //todo: handle Logic "register states holds the data"
  Future<void> login(String email, String password) async {
    try {
      var response = await ApiManager.postLoginData(email, password);
      //todo handle the success state
      if (response.message == "Success Login") {
        if (response.data != null && response.data!.isNotEmpty) {
          await SharedPreferencesAll.saveToken(response.data!);
          print("✅ Token Saved: ${response.data}");
        }
        emit(LoginSuccessState(successMessage: response.message!));
        return;
      }
      //todo:handle the error state
      else {
        emit(LoginErrorState(errorMessage: response.message!));
        print('${response.message}');
        return;
      }
    } catch (e) {
      emit(LoginErrorState(errorMessage: e.toString()));
    }
  }
  void onPressedLogin() {
    if (formKey.currentState?.validate() == true) {
      //todo: Login
      login(emailController.text, passwordController.text);
    }
  }
}
