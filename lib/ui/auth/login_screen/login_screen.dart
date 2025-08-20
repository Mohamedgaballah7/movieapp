import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:movieapproute/l10n/app_localizations.dart';
import 'package:movieapproute/utils/app_assets.dart';
import 'package:movieapproute/utils/app_colors.dart';
import 'package:movieapproute/utils/app_routes.dart';
import 'package:movieapproute/utils/app_styles.dart';
import 'package:movieapproute/widgets/animated_toggle_button.dart';
import 'package:movieapproute/widgets/custom_elevated_button.dart';
import 'package:movieapproute/widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
   LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
   TextEditingController emailController = TextEditingController(text: 'youssef@gmail.com');
   TextEditingController passwordController = TextEditingController(text: "1111111");
   bool isObscure = true;
   var formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: width*0.044, ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(AppAssets.mainLogoImage,height: height*0.20,),
                SizedBox(height: height*0.05,),
                Form(
                  key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CustomTextField(
                      controller: emailController,
                      style: AppStyles.medium16White,
                      prefixIcon: ImageIcon(AssetImage(AppAssets.emailPrefixIcon),color: AppColors.whiteColor,),
                      hintText: AppLocalizations.of(context)?.email,
                      validator: (text) {
                        if(text==null || text.isEmpty){
                          return AppLocalizations.of(context)?.please_enter_email;
                        }
                        final bool emailValid =
                        RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(text);
                        if(!emailValid){
                          return AppLocalizations.of(context)?.please_valid_email;
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: height*0.024,),

                    CustomTextField(
                      controller: passwordController,
                      style: AppStyles.medium16White,
                      prefixIcon: ImageIcon(AssetImage(AppAssets.passwordPrefixIcon),color: AppColors.whiteColor,),
                      suffixIcon:
                      GestureDetector(
                        onTap: (){
                          isObscure = !isObscure;
                          setState(() {

                          });
                        },
                          child: ImageIcon(AssetImage(AppAssets.passwordSuffixIcon),color: AppColors.whiteColor,)),
                      hintText: AppLocalizations.of(context)?.password,
                      validator: (text){
                        if(text==null||text.isEmpty){
                          return AppLocalizations.of(context)?.please_enter_password;
                        }
                        if(text.length<6){
                          return AppLocalizations.of(context)?.please_valid_password;
                        }
                        return null;
                      },
                      obscureText: isObscure,
                    ),
                    SizedBox(height: height * 0.02,),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                                //todo: navigate to forget password screen
                              Navigator.pushNamed(context, AppRoutes.forgetPasswordRouteName);
                            },
                             child: Text(AppLocalizations.of(context)!.forget_password,style: AppStyles.medium14yellow,),)
                        ],
                      ),
                    SizedBox(height: height*0.03,),
                    CustomElevatedButton(
                        onPressed: (){
                          //todo: Login
                          login();
                        },
                        text: AppLocalizations.of(context)!.login),
                    SizedBox(height: height*0.024,),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "${AppLocalizations.of(context)!
                                .dont_have_account} ",
                            style: AppStyles.medium14White,
                          ),
                          TextSpan(
                            text: AppLocalizations.of(context)!.create_account,
                            style: AppStyles.bold14Yellow,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                //todo:go back to login
                                Navigator.pushNamed(
                                    context, AppRoutes.registerRouteName);
                              },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: height*0.029,),
                    Row(
                      children: [
                        Expanded(child: Divider(
                          thickness: 2,
                          indent: width*0.25,
                          endIndent: width*0.03,
                          color: AppColors.yellowColor,
                        )),
                        Text(AppLocalizations.of(context)!.or,style: AppStyles.medium14yellow,),
                        Expanded(child: Divider(
                          thickness: 2,
                          indent: width*0.03,
                          endIndent: width*0.25,
                          color: AppColors.yellowColor,
                        )),
                      ],
                    ),
                    SizedBox(height: height*0.03,),
                    CustomElevatedButton(
                      onPressed: (){
                        //todo: sign in with google
                      },
                      text: AppLocalizations.of(context)!.login_with_google,
                      iconWidget: ImageIcon(AssetImage(AppAssets.googleIcon),size: 25,color: AppColors.blackColor,),
                      hasIcon: true,
                    ),
                    SizedBox(height: height*0.036,),
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
  void login(){
    if(formKey.currentState?.validate()==true){
      //todo: Login
      Navigator.pushNamed(context, AppRoutes.updateProfileRouteName);
    }
  }
}
