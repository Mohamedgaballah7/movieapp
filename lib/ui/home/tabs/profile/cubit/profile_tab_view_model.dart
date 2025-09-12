import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapproute/ui/home/tabs/profile/cubit/profile_tap_states.dart';

import '../../../../../api/api_manager.dart';
import '../../../../../model/api_responses/profile_response.dart';

class ProfileTabViewModel extends Cubit<ProfileTabStates> {
  ProfileTabViewModel() : super(InitialState());

  Future<ProfileResponse?> getProfile() async {
    try {
      emit(LoadingState());
      var response = await ApiManager.getUserData();
      if (response.message == "Profile fetched successfully") {
        emit(
          SuccessGetState(
            avatarId: response.data!.avaterId!,
            name: response.data!.name!,
          ),
        );
        return response;
      } else {
        emit(ErrorState(message: response.message!));
      }
    } catch (e) {
      emit(ErrorState(message: e.toString()));
    }
    return null;
  }
}
