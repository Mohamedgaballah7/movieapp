import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapproute/cubit_theme&language/language/langauge_view_model.dart';
import 'package:movieapproute/cubit_theme&language/language/language_states.dart';
import 'package:movieapproute/cubit_theme&language/theme/theme_state.dart';
import 'package:movieapproute/cubit_theme&language/theme/theme_view_model.dart';
import 'package:movieapproute/ui/auth/forget_password_screen/forget_password_screen.dart';
import 'package:movieapproute/ui/auth/login_screen/login_screen.dart';
import 'package:movieapproute/ui/auth/register_screen/register_screen.dart';
import 'package:movieapproute/ui/home/homescreen.dart';
import 'package:movieapproute/ui/home/movie_details/movie_details.dart';
import 'package:movieapproute/ui/home/tabs/profile/reset_password_screen/reset_password_screen.dart';
import 'package:movieapproute/ui/home/tabs/profile/update_profile/update_profile.dart';
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
  final bool appThemeLight = prefs.getBool('theme') ?? true;
  ThemeMode themeMode = appThemeLight ? ThemeMode.light : ThemeMode.dark;
  final String savedLang = prefs.getString("languageCode") ?? "en";


  String initialRoute;
  final String? token = prefs.getString("authToken");
  if (showOnBoarding) {
    initialRoute = AppRoutes.onBoardingRouteName;
  }
  // else if (token != null && token.isNotEmpty) {
  //   initialRoute = AppRoutes.homeRouteName;
  // }
  else {
    initialRoute = AppRoutes.loginRouteName;
  }
  runApp(MultiBlocProvider(
      providers: [
        BlocProvider<ChangeTheme>(
          create: (BuildContext context) =>
          ChangeTheme(themeMode)
            ..changeTheme(appThemeLight ? ThemeMode.light : ThemeMode.dark),
        ),
        BlocProvider<LanguageViewModel>(
          create: (BuildContext context) => LanguageViewModel(savedLang),
        ),
      ],
      child: MyApp(initialRoute: initialRoute)));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.initialRoute});

  final String initialRoute;

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<ChangeTheme, ThemeState>(
      builder: (BuildContext context, themeState) {
        ThemeMode appTheme = ThemeMode.dark;
        if (themeState is ThemeChangedState) {
          appTheme = themeState.themeMode;
        }

        return BlocBuilder<LanguageViewModel, LanguageState>(
          builder: (context, languageState) {
            String langCode = 'en';
            if (languageState is LanguageChangeState) {
              langCode = languageState.languageCode;
            }
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              initialRoute: initialRoute,
              routes: {
                AppRoutes.onBoardingRouteName: (context) => OnboardingScreens(),
                AppRoutes.homeRouteName: (context) => Homescreen(),
                AppRoutes.loginRouteName: (context) => LoginScreen(),
                AppRoutes.registerRouteName: (context) => RegisterScreen(),
                AppRoutes.resetRouteName: (context) => ResetPasswordScreen(),
                AppRoutes.movieDetailsRouteName: (context) => MovieDetails(),
                AppRoutes.forgetPasswordRouteName: (context) =>
                    ForgetPasswordScreen(),
                AppRoutes.updateProfileRouteName: (context) => UpdateProfile()
              },
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: appTheme,
              locale: Locale(langCode),
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
            );
          },
        );
      },
    );
  }
}
