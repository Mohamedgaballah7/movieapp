import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapproute/api/api_manager.dart';
import 'package:movieapproute/model/api_responses/profile_response.dart';
import 'package:movieapproute/ui/home/tabs/profile/cubit/update_profile_states.dart';

class UpdateProfileViewModel extends Cubit<UpdateProfileStates> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var selectedAvatar = 0;

  UpdateProfileViewModel() :super(LoadingState());

  Future<ProfileResponse?> getProfile() async {
    try {
      emit(LoadingState());
      var response = await ApiManager.getUserData();
      if (response.message == "Profile fetched successfully") {
        nameController.text = response.data!.name!;
        phoneController.text = response.data!.phone!;
        selectedAvatar = response.data!.avaterId!;
        emit(SuccessGetState(avatarId: response.data!.avaterId,
            name: response.data!.name,
            phone: response.data!.phone));
        return response;
      } else {
        emit(ErrorState(message: response.message!));
      }
    }
    catch (e) {
      emit(ErrorState(message: e.toString()));
    }
    return null;
  }

  Future<void> deleteProfile() async {
    try {
      var response = await ApiManager.deleteProfile();
      if (response.message == "Profile deleted successfully") {
        emit(SuccessDeleteState(successMessage: response.message!));
      } else {
        emit(ErrorState(message: response.message!));
      }
    }
    catch (e) {
      emit(ErrorState(message: e.toString()));
    }
  }

  Future<void> updateProfile(String? name, int? avatarId,
      String? phoneNumber) async {
    try {
      emit(LoadingState());
      var response = await ApiManager.updateProfile(
          name: name, avatarId: avatarId, phoneNumber: phoneNumber
      );
      if (response.message == "Profile updated successfully") {
        emit(SuccessUpdateState(successMessage: response.message!));  
      } else {
        emit(ErrorState(message: response.message!));
      }
    }
    catch (e) {
      emit(ErrorState(message: e.toString()));
    }
  }

  void updateProfileOn() {
    if (formKey.currentState?.validate() == true) {
      //todo: register
      updateProfile(nameController.text, selectedAvatar, phoneController.text);
    }
  }
}