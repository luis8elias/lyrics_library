import '/config/config.dart';

class Validator {
  
  static const _email = r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  static String? validateEmail(String? value) {
    RegExp regExp = RegExp(_email);
    return regExp.hasMatch(value ?? '') ? null : Lang.current.validator_email;
  }


  static String? validateRequired(String? value) {
    if(value == null || value.isEmpty){
      return Lang.current.validator_required;
    }
    return null;
  }

  static String? validateConfirmPassword(value , password) {
    
    if (value.length < 6) {
      return Lang.current.validator_confirmPasswordLength(6);
    }

    if(value != password){
      return Lang.current.validator_confirmPassword;
    }

    return null;
  }



  static String? validatePassword(value) {
    
    if (value.length < 6) {
      return Lang.current.validator_confirmPasswordLength(6);
    }

    return null;
  }
}