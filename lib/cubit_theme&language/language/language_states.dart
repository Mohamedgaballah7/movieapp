abstract class LanguageState {}

class LanguageChangeState extends LanguageState {
  final String languageCode;

  LanguageChangeState(this.languageCode);
}
