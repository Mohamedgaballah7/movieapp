import 'package:flutter/material.dart';
import 'package:movieapproute/utils/app_assets.dart';

import '../../../l10n/app_localizations.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_styles.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/custom_text_field.dart';

class ForgetPasswordScreen extends StatefulWidget {
   ForgetPasswordScreen({super.key});

   @override
   State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();


  bool isObscure = true;
  bool isObscureNew = true;
  bool isObscureConfirm = true;

  var formKey = GlobalKey<FormState>();

   @override
  Widget build(BuildContext context) {
     var height = MediaQuery.of(context).size.height;
     var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar:  AppBar(
        title: Text(AppLocalizations.of(context)!.forget_password,
          style: AppStyles.medium16yellow,),
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: width*0.044, ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(AppAssets.forgetPasswordImage),
              Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CustomTextField(
                        obscureText: isObscureNew,
                        controller: newPasswordController,
                        filledColor: AppColors.transparentColor,
                        style: Theme
                            .of(context)
                            .textTheme
                            .titleLarge,
                        prefixIcon: ImageIcon(
                          AssetImage(AppAssets.passwordPrefixIcon),
                          color: Theme
                              .of(context)
                              .indicatorColor,
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            isObscureNew = !isObscureNew;
                            setState(() {});
                          },
                          child: ImageIcon(
                            AssetImage(AppAssets.passwordSuffixIcon),
                            color: Theme
                                .of(context)
                                .indicatorColor,
                          ),
                        ),
                        hintText: AppLocalizations.of(context)!.new_password,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return AppLocalizations.of(context)!
                                .please_enter_new_password;
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: height * 0.024,),
                      CustomTextField(
                        obscureText: isObscureConfirm,
                        controller: confirmNewPasswordController,
                        filledColor: AppColors.transparentColor,
                        style: Theme
                            .of(context)
                            .textTheme
                            .titleLarge,
                        prefixIcon: ImageIcon(
                          AssetImage(AppAssets.passwordPrefixIcon),
                          color: Theme
                              .of(context)
                              .indicatorColor,
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            isObscureConfirm = !isObscureConfirm;
                            setState(() {});
                          },
                          child: ImageIcon(
                            AssetImage(AppAssets.passwordSuffixIcon),
                            color: Theme
                                .of(context)
                                .indicatorColor,
                          ),
                        ),
                        hintText: AppLocalizations.of(context)!
                            .confirm_new_password,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return AppLocalizations.of(context)!
                                .please_confirm_new_password;
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: height * 0.024,),
                      CustomElevatedButton(
                          onPressed: () {
                            //todo: go back to login
                            login();
                          },
                          text: AppLocalizations.of(context)!.change_password),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  void login(){
     if(formKey.currentState?.validate()==true){
       //todo: Login
     }
   }
}
