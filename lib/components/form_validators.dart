import 'package:tmdbapp/constant/constant.dart';

class FormValidator {
  
  static String? validateForms({required String? contents}) {
    if (contents == null || contents.isEmpty) {
      return Constant.formValidatorNull;
    } else {
      return null;
    }
  }

  static String? validateUsername({required String? username}) {
    if (username == null || username.isEmpty) {
      return Constant.usernameValidator;
    } else if (username.contains(" ")) {
      return Constant.usernameValidatorSpace;
    } else {
      return null;
    }
  }

  static String? validatePassword({required String? password}) {
    if (password == null || password.isEmpty) {
      return Constant.passwordValidator;
    }
    if (password.length < 6) {
      return Constant.passwordValidatorChar;
    }
    return null;
  }

  static String? validateName({required String? name}) {
    if (name == null || name.isEmpty) {
      return Constant.nameValidator;
    } else {
      return null;
    }
  }
  
}