import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movieapproute/utils/app_assets.dart';
import 'package:movieapproute/utils/app_colors.dart';
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
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController(text: 'youssef@gmail.com');
  bool isObscure = true;
  var formKey=GlobalKey<FormState>();


  TextEditingController passwordController = TextEditingController(text: "1111111");
  TextEditingController confirmPasswordController = TextEditingController(text: "1111111");

  PageController controller = PageController(viewportFraction: 0.35,initialPage: 4);

   int currentPage = 4;

   List<String>avatars = [
     'assets/images/avatar_1.png',
     'assets/images/avatar_2.png',
     'assets/images/avatar_3.png',
     'assets/images/avatar_4.png',
     'assets/images/avatar_5.png',
     'assets/images/avatar_6.png',
     'assets/images/avatar_7.png',
     'assets/images/avatar_8.png',
     'assets/images/avatar_9.png',
   ];
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
  currentPage=4;
   }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Register',style: AppStyles.medium16yellow,),
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

                  return SizedBox(
                    
                  child:CircleAvatar(
                    backgroundImage: AssetImage('assets/images/avatar_${index+1}.png'),
                  )
                    //Image.asset('assets/images/avatar_${index+1}.png',),
                                  );
                } else {
                  return Image.asset('assets/images/avatar_${index+1}.png',);
                }

          },
            ),
        ),
        SizedBox(height: height*0.01,),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Avatar", style: AppStyles.medium16White,)
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
                  InkWell(
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
                  InkWell(
                      onTap: (){
                        isObscure = !isObscure;
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
                  obscureText: isObscure,
                ),
                SizedBox(height: height*0.024,),


                CustomTextField(
                  controller: nameController,
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

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(AppLocalizations.of(context)!.already_have_account,style: AppStyles.medium14White,),
           SizedBox(width: width*0.02,),
            InkWell(
                onTap: (){
                  //todo:go back to login
                  Navigator.pop(context);
                },
                child: Text(AppLocalizations.of(context)!.login,style: AppStyles.bold14Yellow,)),
          ],
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
