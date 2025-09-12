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
import 'package:movieapproute/utils/validators.dart';
import 'package:movieapproute/widgets/alert_dialog.dart';
import 'package:movieapproute/widgets/animated_toggle_button.dart';
import 'package:movieapproute/widgets/animated_toggle_button_theme.dart';
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
    return BlocConsumer<LoginViewModel, LoginStates>(
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
                                  filledColor: AppColors.transparentColor,
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .titleLarge,
                                  controller: viewModel.emailController,
                                  prefixIcon: ImageIcon(
                                    AssetImage(AppAssets.emailPrefixIcon),
                                    color: Theme
                                        .of(context)
                                        .indicatorColor,),
                                  hintText: AppLocalizations
                                      .of(context)
                                      ?.email,
                                  validator: AppValidators.validateEmail,
                                  keyboardType: TextInputType.emailAddress,
                                ),
                                SizedBox(height: height * 0.024,),

                                CustomTextField(
                                  filledColor: AppColors.transparentColor,
                                  controller: viewModel.passwordController,
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .titleLarge,
                                  prefixIcon: ImageIcon(
                                    AssetImage(AppAssets.passwordPrefixIcon),
                                    color: Theme
                                        .of(context)
                                        .indicatorColor,),
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
                                        color: Theme
                                            .of(context)
                                            .indicatorColor,)),
                                  hintText: AppLocalizations
                                      .of(context)
                                      ?.password,
                                  validator: AppValidators.validatePassword,
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
                                        style: Theme
                                            .of(context)
                                            .textTheme
                                            .labelMedium,
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
                                  textStyle: AppStyles.medium20Black,
                                  iconWidget: ImageIcon(
                                    AssetImage(AppAssets.googleIcon), size: 25,
                                    color: AppColors.blackColor,),
                                  hasIcon: true,
                                ),
                                SizedBox(height: height * 0.036,),
                                AnimatedToggleButtonLanguage(),
                                SizedBox(height: height * 0.02,),
                                AnimatedToggleButtonTheme(),
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


