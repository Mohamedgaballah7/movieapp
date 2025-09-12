import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapproute/l10n/app_localizations.dart';
import 'package:movieapproute/ui/home/tabs/profile/reset_password_screen/cubit/reset_password_states.dart';
import 'package:movieapproute/ui/home/tabs/profile/reset_password_screen/cubit/reset_password_view_model.dart';
import 'package:movieapproute/utils/app_assets.dart';
import 'package:movieapproute/utils/app_colors.dart';
import 'package:movieapproute/utils/app_styles.dart';
import 'package:movieapproute/widgets/custom_elevated_button.dart';
import 'package:movieapproute/widgets/custom_text_field.dart';

import '../../../../../utils/app_routes.dart';
import '../../../../../widgets/alert_dialog.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  ResetViewModel viewModel = ResetViewModel();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return BlocConsumer<ResetViewModel, ResetPasswordStates>(
      bloc: viewModel,
      builder: (context, state) {
        if (state is ResetInitialState ||
            state is ResetErrorState ||
            state is ResetSuccessState) {
          return
            Scaffold(
                appBar: AppBar(
                  title: Text(AppLocalizations.of(context)!.reset_password,
                    style: AppStyles.medium16yellow,),
                ),
                body:
                Padding(
                  padding: EdgeInsetsGeometry.symmetric(
                    horizontal: width * 0.044,),
                  child: SingleChildScrollView(
                    child:
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Image.asset(AppAssets.forgetPasswordImage),
                        Form(
                          key: viewModel.formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              CustomTextField(
                                obscureText: viewModel.isObscure,
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
                                  child: viewModel.isObscure ? ImageIcon(
                                    AssetImage(AppAssets.passwordSuffixIcon),
                                    color: Theme
                                        .of(context)
                                        .indicatorColor,
                                  ) : Icon(Icons.remove_red_eye,
                                    color: Theme
                                        .of(context)
                                        .indicatorColor, size: 30,),
                                ),
                                hintText: AppLocalizations.of(context)!
                                    .old_password,
                                validator: (text) {
                                  if (text == null || text.isEmpty) {
                                    return AppLocalizations.of(
                                      context,
                                    )!.please_enter_old_password;
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: height * 0.024),
                              CustomTextField(
                                obscureText: viewModel.isObscureNew,
                                controller: viewModel.newPasswordController,
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
                                    viewModel.isObscureNew =
                                    !viewModel.isObscureNew;
                                    setState(() {});
                                  },
                                  child: viewModel.isObscureNew ? ImageIcon(
                                    AssetImage(AppAssets.passwordSuffixIcon),
                                    color: Theme
                                        .of(context)
                                        .indicatorColor,
                                  ) : Icon(Icons.remove_red_eye,
                                    color: Theme
                                        .of(context)
                                        .indicatorColor, size: 30,),
                                ),
                                hintText: AppLocalizations.of(context)!
                                    .new_password,
                                validator: (text) {
                                  if (text == null || text.isEmpty) {
                                    return AppLocalizations.of(
                                      context,
                                    )!.please_enter_new_password;
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: height * 0.024),
                              CustomTextField(
                                obscureText: viewModel.isObscureConfirm,
                                controller: viewModel
                                    .confirmNewPasswordController,
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
                                    viewModel.isObscureConfirm =
                                    !viewModel.isObscureConfirm;
                                    setState(() {});
                                  },
                                  child: viewModel.isObscureConfirm ? ImageIcon(
                                    AssetImage(AppAssets.passwordSuffixIcon),
                                    color: Theme
                                        .of(context)
                                        .indicatorColor,
                                  ) : Icon(Icons.remove_red_eye,
                                    color: Theme
                                        .of(context)
                                        .indicatorColor, size: 30,),
                                ),
                                hintText: AppLocalizations.of(
                                  context,
                                )!.confirm_new_password,
                                validator: (text) {
                                  if (text == null || text.isEmpty) {
                                    return AppLocalizations.of(context)!
                                        .please_confirm_new_password;
                                  }
                                  if (text !=
                                      viewModel.newPasswordController.text) {
                                    return AppLocalizations.of(context)!
                                        .please_enter_password;
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: height * 0.024),
                              CustomElevatedButton(
                                onPressed: () {
                                  //todo: change password
                                  viewModel.onPressedReset();
                                },
                                text: AppLocalizations.of(context)!
                                    .change_password,
                              ),
                              SizedBox(height: height * 0.02),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
          );
        }
        return Container();
      }, listener: (context, state) {
      if (state is ResetErrorState) {
        DialogUtils.showMassege(
          context: context,
          message: state.errorMessage,
          Title: AppLocalizations.of(context)!.something_went_wrong,
          PosActionName: AppLocalizations.of(context)!.try_again,
          PosAction: () {
            //todo: return to register
            Navigator.pushReplacementNamed(
                context, AppRoutes.homeRouteName);
          },
        );
      } else if (state is ResetSuccessState) {
        DialogUtils.showMassege(
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
