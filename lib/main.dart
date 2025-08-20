import 'package:flutter/material.dart';
import 'package:movieapproute/ui/auth/forget_password_screen/forget_password_screen.dart';
import 'package:movieapproute/ui/auth/login_screen/login_screen.dart';
import 'package:movieapproute/ui/auth/register_screen/register_screen.dart';
import 'package:movieapproute/ui/auth/update_profile/update_profile.dart';
import 'package:movieapproute/utils/app_routes.dart';
import 'package:movieapproute/utils/app_theme.dart';

import 'ui/home/homescreen.dart';
import 'l10n/app_localizations.dart';

void main(){

  runApp( MyApp());
}

class MyApp extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.loginRouteName,
      routes: {
        AppRoutes.homeRouteName:(context)=>Homescreen(),
        AppRoutes.loginRouteName:(context)=>LoginScreen(),
        AppRoutes.registerRouteName:(context)=>RegisterScreen(),
        AppRoutes.forgetPasswordRouteName:(context)=>ForgetPasswordScreen(),
        AppRoutes.updateProfileRouteName: (context) => UpdateProfile()
      },
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      locale: Locale('en'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }

}