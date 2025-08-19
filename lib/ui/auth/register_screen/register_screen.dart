import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:movieapproute/utils/app_assets.dart';
import 'package:movieapproute/utils/app_colors.dart';
import 'package:movieapproute/utils/app_routes.dart';
import 'package:movieapproute/utils/app_styles.dart';
import 'package:movieapproute/widgets/animated_toggle_button.dart';
import 'package:movieapproute/widgets/custom_text_field.dart';

import '../../../l10n/app_localizations.dart';
import '../../../widgets/custom_elevated_button.dart';

class RegisterScreen extends StatefulWidget {
   RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController(text: "youssef");
  TextEditingController emailController = TextEditingController(text: 'youssef@gmail.com');
  bool isObscure = true;
  bool isObscureRe = true;
  var formKey=GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController(text: "1111111");
  TextEditingController confirmPasswordController = TextEditingController(text: "1111111");

  PageController controller = PageController(
      viewportFraction: 0.35, initialPage: 3);

  int currentPage = 3;

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
    currentPage;
   }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.register,
          style: AppStyles.medium16yellow,),
      ),
      body: SafeArea(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: height*0.15,
            child: PageView.builder(
                  padEnds: true,
                  controller: controller,
              itemCount: avatars.length,
              onPageChanged: (int index) {
                     setState(() {
                       currentPage = index;
                     });
                  },
              itemBuilder: (context, index) {

                if (index == currentPage) {
                  return Image.asset(avatars[index], scale: 0.09,);
                } else {
                  return Image.asset(avatars[index], scale: 1.2);
                }

          },
            ),
        ),
        SizedBox(height: height*0.01,),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(AppLocalizations.of(context)!.avatar,
              style: AppStyles.medium16White,)
          ],
        ),
        SizedBox(height: height*0.01,),

        Padding(

          padding: EdgeInsetsGeometry.symmetric(horizontal: width*0.044, ),

          child: Form(
              key: formKey,
              child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomTextField(
                  controller: nameController,
                  style: AppStyles.medium16White,
                  prefixIcon: ImageIcon(AssetImage(AppAssets.namePrefixIcon),color: AppColors.whiteColor,),
                  hintText: AppLocalizations.of(context)!.name,
                ),
                SizedBox(height: height*0.024,),

                CustomTextField(
                  controller: emailController,
                  style: AppStyles.medium16White,
                  prefixIcon: ImageIcon(AssetImage(AppAssets.emailPrefixIcon),color: AppColors.whiteColor,),
                  hintText: AppLocalizations.of(context)!.email,
                  validator: (text) {
                    if(text==null || text.isEmpty){
                      return AppLocalizations.of(context)!.please_enter_email;
                    }
                    final bool emailValid =
                    RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(text);
                    if(!emailValid){
                      return AppLocalizations.of(context)!.please_valid_email;
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
                  hintText: AppLocalizations.of(context)!.password,
                  validator: (text){
                    if(text==null||text.isEmpty){
                      return AppLocalizations.of(context)!.please_enter_password;
                    }
                    if(text.length<6){
                      return AppLocalizations.of(context)!.please_valid_password;
                    }
                    return null;
                  },
                  obscureText: isObscure,
                ),
                SizedBox(height: height*0.024,),

                CustomTextField(
                  controller: confirmPasswordController,
                  style: AppStyles.medium16White,
                  prefixIcon: ImageIcon(AssetImage(AppAssets.passwordPrefixIcon),color: AppColors.whiteColor,),
                  suffixIcon:
                  GestureDetector(
                      onTap: (){
                        isObscureRe = !isObscureRe;
                        setState(() {

                        });
                      },
                      child: ImageIcon(AssetImage(AppAssets.passwordSuffixIcon),color: AppColors.whiteColor,)),
                  hintText: AppLocalizations.of(context)!.re_password,
                  validator: (text){
                    if(text==null||text.isEmpty){
                      return AppLocalizations.of(context)!.please_enter_password;
                    }
                    if(text!= passwordController.text){
                      return AppLocalizations.of(context)!.please_enter_the_same_password;
                    }
                    return null;
                  },
                  obscureText: isObscureRe,
                ),
                SizedBox(height: height*0.024,),
                CustomTextField(
                  controller: phoneController,
                  style: AppStyles.medium16White,
                  prefixIcon: ImageIcon(AssetImage(AppAssets.phonePrefixIcon),color: AppColors.whiteColor,),
                  hintText: AppLocalizations.of(context)!.phone_number,
                ),
                SizedBox(height: height*0.024,),

                CustomElevatedButton(
                    onPressed: (){
                      //todo: go back to login
                      login();
                    },
                    text: AppLocalizations.of(context)!.create_account),
              ],
            ),
          )),
        ),
        SizedBox(height: height*0.024,),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: "${AppLocalizations.of(context)!.already_have_account} ",
                style: AppStyles.medium14White,
              ),
              TextSpan(
                text: AppLocalizations.of(context)!.login,
                style: AppStyles.bold14Yellow,
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    //todo:go back to login
                    Navigator.pushNamedAndRemoveUntil(
                        context, AppRoutes.loginRouteName, (route) => false);
                  },
              ),
            ],
          ),
        ),

        SizedBox(height: height*0.036,),

        AnimatedToggleButtonLanguage()



      ]
    ),



      )
    );
  }
  void login(){
    if(formKey.currentState?.validate()==true){
      //todo: Login
      Navigator.pop(context);
    }
  }
}
