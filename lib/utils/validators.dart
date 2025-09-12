class AppValidators {
  static String? validateEmail(String? text) {
    if (text == null || text.isEmpty) {
      return 'enter email';
    }
    final bool emailValid = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(text);
    if (!emailValid) {
      return 'enter valid email';
    }
    return null;
  }

  static String? validatePassword(String? text) {
    if (text == null || text.isEmpty) {
      return 'enter password';
    }
    if (text.length < 6) {
      return 'enter valid password';
    }
    return null;
  }

  static String? validateConfirmPassword(String? val, String? password) {
    if (val == null || val.isEmpty) {
      return 'this field is required';
    } else if (val != password) {
      return 'Passwords not matching';
    } else {
      return null;
    }
  }

  static String? validateFullName(String? val) {
    if (val == null || val.isEmpty) {
      return 'this field is required';
    } else {
      return null;
    }
  }

  static String? validatePhoneNumber(String? text) {
    if (text == null || text.isEmpty) {
      return 'enter phone number';
    }
    final bool phoneNumber = RegExp(
      r'^\+20(10|11|12|15)[0-9]{8}$',
    ).hasMatch(text);
    if (!phoneNumber) {
      return 'please enter +20 country code';
    }

    if (text.length < 13) {
      return 'please enter a right phone';
    }

    return null;
  }
}
