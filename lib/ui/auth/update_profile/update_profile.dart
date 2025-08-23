import 'package:flutter/material.dart';
import 'package:movieapproute/l10n/app_localizations.dart';
import 'package:movieapproute/ui/auth/update_profile/choose_avater.dart';
import 'package:movieapproute/utils/app_assets.dart';
import 'package:movieapproute/utils/app_colors.dart';
import 'package:movieapproute/utils/app_styles.dart';

import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/custom_text_field.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  int selectedAvatar = 0;

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
        title: Text(
          AppLocalizations.of(context)!.pick_avatar,
          style: AppStyles.medium16yellow,
        ),
      ),
      body: Padding(
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
                },
                child: Image.asset(avatars[selectedAvatar], scale: 0.6),
              ),
              SizedBox(height: height * 0.02),
              Expanded(
                child: Form(
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
                        hintText: AppLocalizations.of(context)!.phone_number,
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
                      Spacer(),
                      CustomElevatedButton(
                        backgroundColor: AppColors.redColor,
                        textStyle: AppStyles.medium20White,
                        onPressed: () {
                          //todo: go back to login
                        },
                        text: AppLocalizations.of(context)!.delete_account,
                      ),
                      SizedBox(height: height * 0.02),
                      CustomElevatedButton(
                        onPressed: () {
                          //todo: go back to login
                        },
                        text: AppLocalizations.of(context)!.update_data,
                      ),
                      SizedBox(height: height * 0.02),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void changeAvatar() async {
    final selected = await showModalBottomSheet(
      backgroundColor: AppColors.blackColor,
      context: context,
      builder: (context) => ChooseAvater(selectedAvatar: selectedAvatar),
    );

    if (selected != null) {
      setState(() {
        selectedAvatar = selected;
      });
    }
  }
}
