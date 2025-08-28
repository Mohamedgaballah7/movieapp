import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapproute/l10n/app_localizations.dart';
import 'package:movieapproute/ui/auth/login_screen/cubit/login_states.dart';
import 'package:movieapproute/ui/auth/login_screen/cubit/login_view_model.dart';
import 'package:movieapproute/utils/app_assets.dart';
import 'package:movieapproute/utils/app_colors.dart';
import 'package:movieapproute/utils/app_routes.dart';
import 'package:movieapproute/utils/app_styles.dart';
import 'package:movieapproute/widgets/alert_dialog.dart';
import 'package:movieapproute/widgets/animated_toggle_button.dart';
import 'package:movieapproute/widgets/custom_elevated_button.dart';
import 'package:movieapproute/widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
   LoginViewModel viewModel = LoginViewModel();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return BlocConsumer(
        bloc: viewModel,
        builder: (context, state) {
          if (state is LoginInitialState || state is LoginSuccessState ||
              state is LoginErrorState) {
            return Scaffold(
              body: SafeArea(
                child: Padding(
                  padding: EdgeInsetsGeometry.symmetric(
                    horizontal: width * 0.044,),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Image.asset(
                          AppAssets.mainLogoImage, height: height * 0.20,),
                        SizedBox(height: height * 0.05,),
                        Form(
                            key: viewModel.formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                CustomTextField(
                                  controller: viewModel.emailController,
                                  style: AppStyles.medium16White,
                                  prefixIcon: ImageIcon(
                                    AssetImage(AppAssets.emailPrefixIcon),
                                    color: AppColors.whiteColor,),
                                  hintText: AppLocalizations
                                      .of(context)
                                      ?.email,
                                  validator: (text) {
                                    if (text == null || text.isEmpty) {
                                      return AppLocalizations
                                          .of(context)
                                          ?.please_enter_email;
                                    }
                                    final bool emailValid =
                                    RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(text);
                                    if (!emailValid) {
                                      return AppLocalizations
                                          .of(context)
                                          ?.please_valid_email;
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                ),
                                SizedBox(height: height * 0.024,),

                                CustomTextField(
                                  controller: viewModel.passwordController,
                                  style: AppStyles.medium16White,
                                  prefixIcon: ImageIcon(
                                    AssetImage(AppAssets.passwordPrefixIcon),
                                    color: AppColors.whiteColor,),
                                  suffixIcon:
                                  GestureDetector(
                                      onTap: () {
                                        viewModel.isObscure =
                                        !viewModel.isObscure;
                                        setState(() {

                                        });
                                      },
                                      child: ImageIcon(AssetImage(
                                          AppAssets.passwordSuffixIcon),
                                        color: AppColors.whiteColor,)),
                                  hintText: AppLocalizations
                                      .of(context)
                                      ?.password,
                                  validator: (text) {
                                    if (text == null || text.isEmpty) {
                                      return AppLocalizations
                                          .of(context)
                                          ?.please_enter_password;
                                    }
                                    if (text.length < 6) {
                                      return AppLocalizations
                                          .of(context)
                                          ?.please_valid_password;
                                    }
                                    return null;
                                  },
                                  obscureText: viewModel.isObscure,
                                ),
                                SizedBox(height: height * 0.02,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        //todo: navigate to forget password screen
                                        Navigator.pushNamed(context,
                                            AppRoutes.forgetPasswordRouteName);
                                      },
                                      child: Text(AppLocalizations.of(context)!
                                          .forget_password,
                                        style: AppStyles.medium14yellow,),)
                                  ],
                                ),
                                SizedBox(height: height * 0.03,),
                                CustomElevatedButton(
                                    onPressed: () {
                                      //todo: Login
                                      viewModel.onPressedLogin();
                                    },
                                    text: AppLocalizations.of(context)!.login),
                                SizedBox(height: height * 0.024,),
                                RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "${AppLocalizations.of(context)!
                                            .not_have_account} ",
                                        style: AppStyles.medium14White,
                                      ),
                                      TextSpan(
                                        text: AppLocalizations.of(context)!
                                            .create_one,
                                        style: AppStyles.bold14Yellow,
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            //todo:go back to login
                                            Navigator.pushNamed(context,
                                                AppRoutes.registerRouteName);
                                          },
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: height * 0.029,),
                                Row(
                                  children: [
                                    Expanded(child: Divider(
                                      thickness: 2,
                                      indent: width * 0.25,
                                      endIndent: width * 0.03,
                                      color: AppColors.yellowColor,
                                    )),
                                    Text(AppLocalizations.of(context)!.or,
                                      style: AppStyles.medium14yellow,),
                                    Expanded(child: Divider(
                                      thickness: 2,
                                      indent: width * 0.03,
                                      endIndent: width * 0.25,
                                      color: AppColors.yellowColor,
                                    )),
                                  ],
                                ),
                                SizedBox(height: height * 0.03,),
                                CustomElevatedButton(
                                  onPressed: () {
                                    //todo: sign in with google
                                    viewModel.onPressedLogin();
                                  },
                                  text: AppLocalizations.of(context)!
                                      .login_with_google,
                                  iconWidget: ImageIcon(
                                    AssetImage(AppAssets.googleIcon), size: 25,
                                    color: AppColors.blackColor,),
                                  hasIcon: true,
                                ),
                                SizedBox(height: height * 0.036,),
                                AnimatedToggleButtonLanguage()
                              ],
                            )
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
          return Container();
        },
        listener: (context, state) {
          if (state is LoginErrorState) {
            return DialogUtils.showMassege(
                context: context,
                message: state.errorMessage,
                Title: AppLocalizations.of(context)!.something_went_wrong,
                PosActionName: AppLocalizations.of(context)!.try_again,
                PosAction: () {
                  //todo: return to login
                  Navigator.pushReplacementNamed(
                      context, AppRoutes.loginRouteName);
                }
            );
          } else if (state is LoginSuccessState) {
            return DialogUtils.showMassege(
              context: context,
              message: state.successMessage,
              Title: AppLocalizations.of(context)!.logged_in_successfully,
              PosActionName: AppLocalizations.of(context)!.go_to_home,
              PosAction: () {
                //todo: navigate to home
                Navigator.pushReplacementNamed(
                    context, AppRoutes.homeRouteName);
              },
            );
          }
        }
    );
  }
}


