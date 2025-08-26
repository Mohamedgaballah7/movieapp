import 'package:flutter/material.dart';
import 'package:movieapproute/api/api_manager.dart';
import 'package:movieapproute/l10n/app_localizations.dart';
import 'package:movieapproute/model/api_responses/profile_response.dart';
import 'package:movieapproute/utils/app_assets.dart';
import 'package:movieapproute/utils/app_colors.dart';
import 'package:movieapproute/utils/app_routes.dart';
import 'package:movieapproute/utils/app_styles.dart';

import '../../../../widgets/alert_dialog.dart';
import '../../../../widgets/custom_elevated_button.dart';
import '../../../../widgets/custom_text_field.dart';
import 'choose_avater.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<ProfileTab> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var selectedAvatar = -1;

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
        body: FutureBuilder<ProfileResponse>(future: ApiManager.getUserData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: AppColors.yellowColor,
                ),
              );
            } else if (snapshot.hasData) {
              nameController.text = snapshot.data!.data!.name!;
              phoneController.text = snapshot.data!.data!.phone!;
              if (selectedAvatar == -1 &&
                  snapshot.data!.data!.avaterId != null) {
                selectedAvatar = snapshot.data!.data!.avaterId!;
              }
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
                          setState(() {

                          });
                        },
                        child: Image.asset(avatars[selectedAvatar], scale: 0.6),
                      ),
                      SizedBox(height: height * 0.025),
                      Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            CustomTextField(
                              controller: nameController,
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
                              controller: phoneController,
                              style: AppStyles.medium16White,
                              prefixIcon: ImageIcon(
                                AssetImage(AppAssets.phonePrefixIcon),
                                color: AppColors.whiteColor,
                              ),
                              hintText: AppLocalizations.of(context)!
                                  .phone_number,
                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return AppLocalizations.of(
                                    context,
                                  )!.please_enter_password;
                                }
                                return null;
                              },
                              keyboardType: TextInputType.phone,
                            ),
                            SizedBox(height: height * 0.02),
                            GestureDetector(
                              onTap: () {},
                              child: Text(
                                textAlign: TextAlign.start,
                                AppLocalizations.of(context)!.reset_password,
                                style: AppStyles.medium16White,
                              ),
                            ),
                            SizedBox(height: height * 0.29,),
                            CustomElevatedButton(
                              backgroundColor: AppColors.redColor,
                              textStyle: AppStyles.medium20White,
                              onPressed: () async {
                                //todo: delete profile
                                try {
                                  await ApiManager.deleteProfile();
                                  DialogUtils.showMassege(
                                    context: context,
                                    message: "deleted Account Successfully",
                                    Title: AppLocalizations.of(context)!
                                        .great_job,
                                    PosActionName: AppLocalizations.of(context)!
                                        .ok,
                                    PosAction: () {
                                      //todo: navigate to login
                                      Navigator.pushNamedAndRemoveUntil(
                                        context, AppRoutes.loginRouteName, (
                                          route) => false,);
                                    },
                                  );
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(
                                          "Failed to delete account: $e"))
                                  );
                                }
                              },
                              text: AppLocalizations.of(context)!
                                  .delete_account,
                            ),
                            SizedBox(height: height * 0.015),
                            CustomElevatedButton(
                              onPressed: () async {
                                //todo: update profile
                                try {
                                  await ApiManager.updateProfile(
                                      name: nameController.text,
                                      avatarId: selectedAvatar,
                                      phoneNumber: phoneController.text
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(
                                          "update Account Successfully"),
                                        backgroundColor: Colors.green,)
                                  );
                                  // DialogUtils.showMassege(
                                  //   context: context,
                                  //   message: "update Account Successfully",
                                  //   Title: AppLocalizations.of(context)!
                                  //       .great_job,
                                  //   PosActionName: AppLocalizations.of(context)!
                                  //       .ok,
                                  //   PosAction: () {
                                  //     //todo: navigate to login
                                  //     Navigator.pop(context);
                                  //   },
                                  // );
                                } catch (e) {
                                  DialogUtils.showMassege(
                                    context: context,
                                    message: "Failed to update profile: $e",
                                    Title: "Error",
                                    PosActionName: AppLocalizations.of(context)!
                                        .ok,
                                  );
                                }
                              },
                              text: AppLocalizations.of(context)!.update_data,
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
              return Center(child: Text(
                "Not Found Data", style: AppStyles.semiBold20Yellow,),);
            }
          },)
    );
  }

  void changeAvatar() async {
    final selected = await showModalBottomSheet(
      backgroundColor: AppColors.transparentColor,
      context: context,
      builder: (context) =>
          Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: AppColors.blackColor,
              ),
              margin: EdgeInsets.only(left: 13, right: 13, bottom: 30),

              child: ChooseAvater(selectedAvatar: selectedAvatar)),
    );

    if (selected != null) {
      setState(() {
        selectedAvatar = selected;
      });
    }
  }


}
/*

 */