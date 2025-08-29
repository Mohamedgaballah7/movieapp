import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapproute/ui/auth/forget_password_screen/forget_password_screen.dart';
import 'package:movieapproute/ui/auth/login_screen/login_screen.dart';
import 'package:movieapproute/ui/auth/register_screen/register_screen.dart';
import 'package:movieapproute/ui/home/homescreen.dart';
import 'package:movieapproute/ui/home/tabs/profile/reset_password_screen/reset_password_screen.dart';
import 'package:movieapproute/ui/onboarding_screens/onboarding_screens.dart';
import 'package:movieapproute/utils/app_routes.dart';
import 'package:movieapproute/utils/app_theme.dart';
import 'package:movieapproute/utils/cubit_observer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  final prefs = await SharedPreferences.getInstance();
  final bool showOnBoarding = prefs.getBool("OnBoardingScreen") ?? true;
  //final String? token = prefs.getString("authToken");
  String initialRoute;
  if (showOnBoarding) {
    initialRoute = AppRoutes.onBoardingRouteName;
  }
  // else if (token != null && token.isNotEmpty) {
  //   initialRoute = AppRoutes.homeRouteName;
  // }
  else {
    initialRoute = AppRoutes.loginRouteName;
  }
  runApp(MyApp(initialRoute: initialRoute));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.initialRoute});

  final String initialRoute;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: initialRoute,
      routes: {
        AppRoutes.onBoardingRouteName: (context) => OnboardingScreens(),

        AppRoutes.homeRouteName: (context) => Homescreen(),
        AppRoutes.loginRouteName: (context) => LoginScreen(),
        AppRoutes.registerRouteName: (context) => RegisterScreen(),
        AppRoutes.resetRouteName: (context) => ResetPasswordScreen(),
        AppRoutes.forgetPasswordRouteName: (context) => ForgetPasswordScreen(),

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