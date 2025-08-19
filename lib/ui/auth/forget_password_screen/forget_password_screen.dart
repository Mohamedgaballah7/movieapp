import 'package:flutter/material.dart';
import 'package:movieapproute/utils/app_assets.dart';

import '../../../l10n/app_localizations.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_styles.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/custom_text_field.dart';

class ForgetPasswordScreen extends StatelessWidget {
   ForgetPasswordScreen({super.key});
  TextEditingController emailController = TextEditingController(text: 'youssef@gmail.com');
   var formKey=GlobalKey<FormState>();


   @override
  Widget build(BuildContext context) {
     var height = MediaQuery.of(context).size.height;
     var width = MediaQuery.of(context).size.width;
    return Scaffold(
      
      appBar:  AppBar(
        title: Text(AppLocalizations.of(context)!.forget_password,style: AppStyles.medium16yellow,),
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: width*0.044, ),

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

                CustomElevatedButton(
                    onPressed: (){
                      //todo: go back to login
                      login();
                    },
                    text: AppLocalizations.of(context)!.verify_email),


              ],
            ))

          ],
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
