import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapproute/cubit_theme&language/language/language_states.dart';
import 'package:movieapproute/shared_preferences/shared_preferences.dart';

class LanguageViewModel extends Cubit<LanguageState> {
  LanguageViewModel(this.languageCode)
    : super(LanguageChangeState(languageCode));
  String languageCode;

  void changeLanguage(String newLanguageCode) {
    if (languageCode == newLanguageCode) {
      return;
    }
    languageCode = newLanguageCode;
    SharedPreferencesAll.saveLanguage(languageCode);
    emit(LanguageChangeState(languageCode));
  }

  bool get isArabic {
    return languageCode == 'ar';
  }
}
