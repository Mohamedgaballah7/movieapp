import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapproute/l10n/app_localizations.dart';
import 'package:movieapproute/ui/home/tabs/profile/cubit/update_profile_states.dart';
import 'package:movieapproute/ui/home/tabs/profile/cubit/update_profile_view_model.dart';
import 'package:movieapproute/utils/app_assets.dart';
import 'package:movieapproute/utils/app_colors.dart';
import 'package:movieapproute/utils/app_routes.dart';
import 'package:movieapproute/utils/app_styles.dart';

import '../../../../widgets/alert_dialog.dart';
import '../../../../widgets/custom_elevated_button.dart';
import '../../../../widgets/custom_text_field.dart';
import 'choose_avatar.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<ProfileTab> {
  UpdateProfileViewModel viewModel = UpdateProfileViewModel();

  List<String> avatars = [
    AppAssets.avatar1Image,
    AppAssets.avatar2Image,
    AppAssets.avatar3Image,
    AppAssets.avatar4Image,
    AppAssets.avatar5Image,
    AppAssets.avatar6Image,
    AppAssets.avatar7Image,
    AppAssets.avatar8Image,
    AppAssets.avatar9Image,
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.getProfile();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text(
          AppLocalizations.of(context)!.pick_avatar,
          style: AppStyles.medium16yellow,
        ),
      ),
      body: BlocConsumer<UpdateProfileViewModel, UpdateProfileStates>(
          bloc: viewModel,
          builder: (context, state) {
            if (state is LoadingState) {
              return const Center(
                child: CircularProgressIndicator(
                    color: AppColors.yellowColor),);
            } else if (state is SuccessGetState || state is SuccessUpdateState) {
            return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.037,
                  vertical: height * 0.02,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          changeAvatar();
                          setState(() {});
                        },
                        child: Image.asset(
                          avatars[viewModel.selectedAvatar],
                          scale: 0.6,
                        ),
                      ),
                      SizedBox(height: height * 0.025),
                      Form(
                        key: viewModel.formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            CustomTextField(
                              controller: viewModel.nameController,
                              style: AppStyles.medium16White,
                              prefixIcon: ImageIcon(
                                AssetImage(AppAssets.profileIcon),
                                color: AppColors.whiteColor,
                              ),
                              hintText: AppLocalizations.of(context)!.name,
                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return AppLocalizations.of(
                                    context,
                                  )!.please_enter_name;
                                }
                                return null;
                              },
                              keyboardType: TextInputType.text,
                            ),
                            SizedBox(height: height * 0.02),
                            CustomTextField(
                              controller: viewModel.phoneController,
                              style: AppStyles.medium16White,
                              prefixIcon: ImageIcon(
                                AssetImage(AppAssets.phonePrefixIcon),
                                color: AppColors.whiteColor,
                              ),
                              hintText: AppLocalizations.of(
                                context,
                              )!.phone_number,
                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return AppLocalizations.of(
                                    context,
                                  )!.please_enter_your_phone;
                                }
                                return null;
                              },
                              keyboardType: TextInputType.phone,
                            ),
                            SizedBox(height: height * 0.02),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, AppRoutes.resetRouteName);
                              },
                              child: Text(
                                textAlign: TextAlign.start,
                                AppLocalizations.of(context)!.reset_password,
                                style: AppStyles.medium16White,
                              ),
                            ),
                            SizedBox(height: height * 0.29),
                            CustomElevatedButton(
                              backgroundColor: AppColors.redColor,
                              textStyle: AppStyles.medium20White,
                              onPressed: () async {
                                //todo: delete profile
                                viewModel.deleteProfile();
                              },
                              text: AppLocalizations.of(
                                context,
                              )!.delete_account,
                            ),
                            SizedBox(height: height * 0.02),
                            CustomElevatedButton(
                              onPressed: () async {
                                //todo: update profile
                                viewModel.updateProfileOn();
                              },
                              text: AppLocalizations.of(
                                context,
                              )!.update_data,
                            ),
                            SizedBox(height: height * 0.02),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Container();
            }
          },
          listener: (context, state) {
            if (state is SuccessDeleteState) {
              return DialogUtils.showMassege(
                context: context,
                message: state.successMessage,
                Title: AppLocalizations.of(context)!.great_job,
                PosActionName: AppLocalizations.of(context)!.lets_login,
                PosAction: () {
                  //todo: return to register
                  Navigator.pushReplacementNamed(
                    context,
                    AppRoutes.loginRouteName,
                  );
                },
              );
            }
            else if (state is SuccessUpdateState) {
              ScaffoldMessenger.of(context,).showSnackBar(
                SnackBar(
                  content: Text(textAlign: TextAlign.center,
                    "update Account Successfully",
                  ),
                  backgroundColor: Colors.green,
                ),
              );
            } else if (state is ErrorState) {
              return DialogUtils.showMassege(
                context: context,
                message: state.message,
                Title: AppLocalizations.of(context)!.something_went_wrong,
                PosActionName: AppLocalizations.of(context)!.try_again,
                PosAction: () {
                  //todo: return to register
                  Navigator.pushReplacementNamed(
                      context, AppRoutes.homeRouteName);
                },
              );
            }
          }
      ),
    );
  }

  void changeAvatar() async {
    final selected = await showModalBottomSheet(
      backgroundColor: AppColors.transparentColor,
      context: context,
      builder: (context) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: AppColors.blackColor,
        ),
        margin: EdgeInsets.only(left: 13, right: 13, bottom: 30),
        child: ChooseAvatar(selectedAvatar: viewModel.selectedAvatar),
      ),
    );

    if (selected != null) {
      setState(() {
        viewModel.selectedAvatar = selected;
      });
    }
  }
}
