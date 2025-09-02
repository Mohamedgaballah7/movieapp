import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesAll {
  Future<void> onBoardingScreen() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("OnBoardingScreen", false);
  }

  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("authToken", token);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("authToken");
  }

  static Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("authToken");
  }

  static void saveTheme(bool theme) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('theme', theme);
  }

  static void saveLanguage(String languageCode) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('languageCode', languageCode);
  }
}
