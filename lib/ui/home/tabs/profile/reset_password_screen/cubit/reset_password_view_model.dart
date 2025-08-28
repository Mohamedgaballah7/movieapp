import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapproute/api/api_manager.dart';
import 'package:movieapproute/ui/home/tabs/profile/reset_password_screen/cubit/reset_password_states.dart';

class ResetViewModel extends Cubit<ResetPasswordStates> {
  ResetViewModel() : super(ResetInitialState());
  TextEditingController passwordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();
  bool isObscure = true;
  bool isObscureNew = true;
  bool isObscureConfirm = true;
  var formKey = GlobalKey<FormState>();

  Future<void> resetPassword(String oldPassword, String newPassword) async {
    try {
      var response = await ApiManager.patchResetPassword(
        oldPassword,
        newPassword,
      );
      if (response.message == "Password updated successfully") {
        emit(ResetSuccessState(successMessage: response.message!));
        return;
      } else {
        emit(ResetErrorState(errorMessage: response.message!));
      }
    } catch (e) {
      emit(ResetErrorState(errorMessage: e.toString()));
    }
  }

  void onPressedReset() {
    if (formKey.currentState?.validate() == true) {
      //todo: Login
      resetPassword(passwordController.text, newPasswordController.text);
    }
  }
}
