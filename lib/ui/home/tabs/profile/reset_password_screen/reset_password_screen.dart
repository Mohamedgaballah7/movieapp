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
    return BlocBuilder(
      bloc: viewModel,
      builder: (context, state) {
        if (state is ResetInitialState ||
            state is ResetErrorState ||
            state is ResetSuccessState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: height * 0.01),
              Form(
                key: viewModel.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CustomTextField(
                      obscureText: viewModel.isObscure,
                      controller: viewModel.passwordController,
                      style: AppStyles.medium16White,
                      prefixIcon: ImageIcon(
                        AssetImage(AppAssets.passwordPrefixIcon),
                        color: AppColors.whiteColor,
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          viewModel.isObscure = !viewModel.isObscure;
                          setState(() {});
                        },
                        child: ImageIcon(
                          AssetImage(AppAssets.passwordSuffixIcon),
                          color: AppColors.whiteColor,
                        ),
                      ),
                      hintText: AppLocalizations.of(context)!.old_password,
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
                      style: AppStyles.medium16White,
                      prefixIcon: ImageIcon(
                        AssetImage(AppAssets.passwordPrefixIcon),
                        color: AppColors.whiteColor,
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          viewModel.isObscureNew = !viewModel.isObscureNew;
                          setState(() {});
                        },
                        child: ImageIcon(
                          AssetImage(AppAssets.passwordSuffixIcon),
                          color: AppColors.whiteColor,
                        ),
                      ),
                      hintText: AppLocalizations.of(context)!.new_password,
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
                      controller: viewModel.confirmNewPasswordController,
                      style: AppStyles.medium16White,
                      prefixIcon: ImageIcon(
                        AssetImage(AppAssets.passwordPrefixIcon),
                        color: AppColors.whiteColor,
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          viewModel.isObscureConfirm =
                              !viewModel.isObscureConfirm;
                          setState(() {});
                        },
                        child: ImageIcon(
                          AssetImage(AppAssets.passwordSuffixIcon),
                          color: AppColors.whiteColor,
                        ),
                      ),
                      hintText: AppLocalizations.of(
                        context,
                      )!.confirm_new_password,
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return AppLocalizations.of(
                            context,
                          )!.please_confirm_new_password;
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
                      text: AppLocalizations.of(context)!.change_password,
                    ),
                    SizedBox(height: height * 0.02),
                  ],
                ),
              ),
            ],
          );
        }
        return Container();
      },
    );
  }
}
