import 'package:flutter/material.dart';
import 'package:movieapproute/onboarding_screens/onboarding_screens.dart';
import 'package:movieapproute/utils/app_routes.dart';
import 'package:movieapproute/utils/app_theme.dart';

import 'home/homescreen.dart';
import 'l10n/app_localizations.dart';

void main(){

  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.onBoardingRouteName,
      routes: {
        AppRoutes.onBoardingRouteName: (context) => OnboardingScreens(),
        AppRoutes.homeRouteName:(context)=>Homescreen(),
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