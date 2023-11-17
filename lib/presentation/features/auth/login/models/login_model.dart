import '/data/models/form_model.dart';
import '/utils/validator/validator.dart';

class LoginModel extends FormModel{
  
  final String? email;
  final String? password;

  LoginModel({this.email, this.password});

  LoginModel copyWith({
    String? email,
    String? password,
  }) {
    return LoginModel(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
  
  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
    };
  }

  @override
  bool get isValid =>
  (
    (email == null ? false : Validator.validateEmail(email) == null ) &&
    (password == null? false : Validator.validatePassword(password) == null)
  );
  
}