import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapproute/ui/auth/register_screen/cubit/register_states.dart';
import 'package:movieapproute/utils/app_assets.dart';
import 'package:movieapproute/utils/app_colors.dart';
import 'package:movieapproute/utils/app_routes.dart';
import 'package:movieapproute/utils/app_styles.dart';
import 'package:movieapproute/utils/validators.dart';
import 'package:movieapproute/widgets/alert_dialog.dart';
import 'package:movieapproute/widgets/animated_toggle_button.dart';
import 'package:movieapproute/widgets/custom_text_field.dart';

import '../../../l10n/app_localizations.dart';
import '../../../widgets/animated_toggle_button_theme.dart';
import '../../../widgets/custom_elevated_button.dart';
import 'cubit/register_view_model.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

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
    return BlocConsumer<RegisterViewModel, RegisterStates>(
      bloc: viewModel,
      builder: (context, state) {
        if (state is RegisterInitialState ||
            state is RegisterSuccessState ||
            state is RegisterErrorState) {
          return Scaffold(
            appBar: AppBar(
              scrolledUnderElevation: 0,
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
                                filledColor: AppColors.transparentColor,
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .titleLarge,
                                prefixIcon: ImageIcon(
                                  AssetImage(AppAssets.namePrefixIcon),
                                  color: Theme
                                      .of(context)
                                      .indicatorColor,
                                ),
                                hintText: AppLocalizations.of(context)!.name,
                                validator: AppValidators.validateFullName,
                              ),
                              SizedBox(height: height * 0.024),
                              CustomTextField(
                                controller: viewModel.emailController,
                                filledColor: AppColors.transparentColor,
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .titleLarge,
                                prefixIcon: ImageIcon(
                                  AssetImage(AppAssets.emailPrefixIcon),
                                  color: Theme
                                      .of(context)
                                      .indicatorColor,
                                ),
                                hintText: AppLocalizations.of(context)!.email,
                                validator: AppValidators.validateEmail,
                                keyboardType: TextInputType.emailAddress,
                              ),
                              SizedBox(height: height * 0.024),
                              CustomTextField(
                                controller: viewModel.passwordController,
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
                                    viewModel.isObscure = !viewModel.isObscure;
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
                                    .password,
                                validator: AppValidators.validatePassword,

                                obscureText: viewModel.isObscure,
                              ),
                              SizedBox(height: height * 0.024),
                              CustomTextField(
                                controller: viewModel.confirmPasswordController,
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
                                    viewModel.isObscureRe =
                                    !viewModel.isObscureRe;
                                    setState(() {});
                                  },
                                  child: ImageIcon(
                                    AssetImage(AppAssets.passwordSuffixIcon),
                                    color: Theme
                                        .of(context)
                                        .indicatorColor,
                                  ),
                                ),
                                hintText: AppLocalizations.of(context,)!
                                    .re_password,
                                validator: (value) {
                                  return AppValidators.validateConfirmPassword(
                                      value, viewModel.passwordController.text);
                                },
                                obscureText: viewModel.isObscureRe,
                              ),
                              SizedBox(height: height * 0.024),
                              CustomTextField(
                                controller: viewModel.phoneController,
                                filledColor: AppColors.transparentColor,
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .titleLarge,
                                prefixIcon: ImageIcon(
                                  AssetImage(AppAssets.phonePrefixIcon),
                                  color: Theme
                                      .of(context)
                                      .indicatorColor,
                                ),
                                hintText: AppLocalizations.of(context,)!
                                    .phone_number,
                                validator: AppValidators.validatePhoneNumber,
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
                            style: Theme
                                .of(context)
                                .textTheme
                                .labelMedium,
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
                    SizedBox(height: height * 0.02,),
                    AnimatedToggleButtonTheme(),
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
              Navigator.pushReplacementNamed(
                  context, AppRoutes.registerRouteName);
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