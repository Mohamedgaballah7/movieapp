import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapproute/ui/auth/register_screen/cubit/register_states.dart';
import 'package:movieapproute/utils/app_assets.dart';
import 'package:movieapproute/utils/app_colors.dart';
import 'package:movieapproute/utils/app_routes.dart';
import 'package:movieapproute/utils/app_styles.dart';
import 'package:movieapproute/widgets/alert_dialog.dart';
import 'package:movieapproute/widgets/animated_toggle_button.dart';
import 'package:movieapproute/widgets/custom_text_field.dart';

import '../../../l10n/app_localizations.dart';
import '../../../widgets/custom_elevated_button.dart';
import 'cubit/register_view_model.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isObscure = true;
  bool isObscureRe = true;
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
    viewModel.currentPage;
  }

  RegisterViewModel viewModel = RegisterViewModel();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return BlocConsumer(
      bloc: viewModel,
      builder: (context, state) {
        if (state is RegisterInitialState ||
            state is RegisterSuccessState ||
            state is RegisterErrorState) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                AppLocalizations.of(context)!.register,
                style: AppStyles.medium16yellow,
              ),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: height * 0.15,
                      child: PageView.builder(
                        padEnds: true,
                        controller: viewModel.controller,
                        itemCount: avatars.length,
                        onPageChanged: (int index) {
                          setState(() {
                            viewModel.currentPage = index;
                          });
                        },
                        itemBuilder: (context, index) {
                          if (index == viewModel.currentPage) {
                            return Image.asset(avatars[index], scale: 0.09);
                          } else {
                            return Image.asset(avatars[index], scale: 1.2);
                          }
                        },
                      ),
                    ),
                    SizedBox(height: height * 0.01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.avatar,
                          style: AppStyles.medium16White,
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.01),
                    Padding(
                      padding: EdgeInsetsGeometry.symmetric(
                        horizontal: width * 0.044,
                      ),
                      child: Form(
                        key: viewModel.formKey,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              CustomTextField(
                                controller: viewModel.nameController,
                                style: AppStyles.medium16White,
                                prefixIcon: ImageIcon(
                                  AssetImage(AppAssets.namePrefixIcon),
                                  color: AppColors.whiteColor,
                                ),
                                hintText: AppLocalizations.of(context)!.name,
                                validator: (text) {
                                  if (text == null || text.isEmpty) {
                                    return "please enter your name";
                                  }
                                  if (text.length > 30) {
                                    return "please enter a shorter name";
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: height * 0.024),
                              CustomTextField(
                                controller: viewModel.emailController,
                                style: AppStyles.medium16White,
                                prefixIcon: ImageIcon(
                                  AssetImage(AppAssets.emailPrefixIcon),
                                  color: AppColors.whiteColor,
                                ),
                                hintText: AppLocalizations.of(context)!.email,
                                validator: (text) {
                                  if (text == null || text.isEmpty) {
                                    return AppLocalizations.of(context,)!
                                        .please_enter_email;
                                  }
                                  final bool emailValid = RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                                  ).hasMatch(text);
                                  if (!emailValid) {
                                    return AppLocalizations.of(context)!
                                        .please_valid_email;
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.emailAddress,
                              ),
                              SizedBox(height: height * 0.024),
                              CustomTextField(
                                controller: viewModel.passwordController,
                                style: AppStyles.medium16White,
                                prefixIcon: ImageIcon(
                                  AssetImage(AppAssets.passwordPrefixIcon),
                                  color: AppColors.whiteColor,
                                ),
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    isObscure = !isObscure;
                                    setState(() {});
                                  },
                                  child: ImageIcon(
                                    AssetImage(AppAssets.passwordSuffixIcon),
                                    color: AppColors.whiteColor,
                                  ),
                                ),
                                hintText: AppLocalizations.of(context)!
                                    .password,
                                validator: (text) {
                                  if (text == null || text.isEmpty) {
                                    return AppLocalizations.of(context)!
                                        .please_enter_password;
                                  }
                                  if (text.length < 6) {
                                    return AppLocalizations.of(context)!
                                        .please_valid_password;
                                  }
                                  return null;
                                },
                                obscureText: isObscure,
                              ),
                              SizedBox(height: height * 0.024),
                              CustomTextField(
                                controller: viewModel.confirmPasswordController,
                                style: AppStyles.medium16White,
                                prefixIcon: ImageIcon(
                                  AssetImage(AppAssets.passwordPrefixIcon),
                                  color: AppColors.whiteColor,
                                ),
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    isObscureRe = !isObscureRe;
                                    setState(() {});
                                  },
                                  child: ImageIcon(
                                    AssetImage(AppAssets.passwordSuffixIcon),
                                    color: AppColors.whiteColor,
                                  ),
                                ),
                                hintText: AppLocalizations.of(
                                  context,
                                )!.re_password,
                                validator: (text) {
                                  if (text == null || text.isEmpty) {
                                    return AppLocalizations.of(context,)!
                                        .please_enter_password;
                                  }
                                  if (text !=
                                      viewModel.passwordController.text) {
                                    return AppLocalizations.of(context,)!
                                        .please_enter_the_same_password;
                                  }
                                  return null;
                                },
                                obscureText: isObscureRe,
                              ),
                              SizedBox(height: height * 0.024),
                              CustomTextField(
                                controller: viewModel.phoneController,
                                style: AppStyles.medium16White,
                                prefixIcon: ImageIcon(
                                  AssetImage(AppAssets.phonePrefixIcon),
                                  color: AppColors.whiteColor,
                                ),
                                hintText: AppLocalizations.of(context,)!
                                    .phone_number,
                                validator: (text) {
                                  if (text == null || text.isEmpty) {
                                    return 'please enter your phone';
                                  }
                                  if (text.length < 13) {
                                    return 'please enter a right phone';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: height * 0.024),
                              CustomElevatedButton(
                                onPressed: () {
                                  //todo: go back to login
                                  viewModel.onPressedRegister();
                                },
                                text: AppLocalizations.of(context)!.create_one,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.024),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text:
                            "${AppLocalizations.of(context)!
                                .already_have_account} ",
                            style: AppStyles.medium14White,
                          ),
                          TextSpan(
                            text: AppLocalizations.of(context)!.login,
                            style: AppStyles.bold14Yellow,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                //todo:go back to login
                                Navigator.pushNamedAndRemoveUntil(
                                  context, AppRoutes.loginRouteName,
                                      (route) => false,
                                );
                              },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: height * 0.036),
                    AnimatedToggleButtonLanguage(),
                  ],
                ),
              ),
            ),
          );
        }
        return Container();
      },
      listener: (context, state) {
        if (state is RegisterErrorState) {
          return DialogUtils.showMassege(
            context: context,
            message: state.errorMessage,
            Title: AppLocalizations.of(context)!.something_went_wrong,
            PosActionName: AppLocalizations.of(context)!.try_again,
            PosAction: () {
              //todo: return to register
              Navigator.pushNamedAndRemoveUntil(
                  context, AppRoutes.registerRouteName, (route) => false);
            },
          );
        } else if (state is RegisterSuccessState) {
          return DialogUtils.showMassege(
            context: context,
            message: state.successMessage,
            Title: AppLocalizations.of(context)!.great_job,
            PosActionName: AppLocalizations.of(context)!.lets_login,
            PosAction: () {
              //todo: navigate to login
              Navigator.pushNamedAndRemoveUntil(
                context, AppRoutes.loginRouteName, (route) => false,);
            },
          );
        }
      },
    );
  }
}