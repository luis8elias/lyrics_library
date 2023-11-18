import '/data/models/form_model.dart';
import '/utils/utils.dart';


class RegisterModel extends FormModel<RegisterModel> {

  final String? name;
  final String? email;
  final String? password;
  final String? confirmPassword;

  RegisterModel({
    this.name, 
    this.email, 
    this.password, 
    this.confirmPassword
  });


  @override
  bool get isValid =>
  (
    (email == null ? false : Validator.validateEmail(email) == null ) &&
    (password == null? false : Validator.validatePassword(password) == null) &&
    (confirmPassword == null ? false : Validator.validateConfirmPassword(confirmPassword ?? '', password ?? '')) == null &&
    (name != null || name!.isNotEmpty)
  );

  RegisterModel copyWith({
    String? name,
    String? lastName,
    String? email,
    String? password,
    String? confirmPassword,
  }) {
    return RegisterModel(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstName': name,
      'email': email,
      'password': password
    };
  }
  
}