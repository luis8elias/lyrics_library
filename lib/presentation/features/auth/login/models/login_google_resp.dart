import '/presentation/features/auth/shared/models/auth_model.dart';

class LoginGoogleResp {
  
  final AuthModel authModel;
  final String userId;
  final String displayName;
  final String email;

  LoginGoogleResp({
    required this.authModel,
    required this.userId,
    required this.displayName,
    required this.email,
  });

  

  factory LoginGoogleResp.fromMap(Map<String, dynamic> map) {
    return LoginGoogleResp(
      authModel: AuthModel.fromMap(map['authModel'] as Map<String,dynamic>),
      userId: map['userId'] as String,
      displayName: map['displayName'] as String,
      email: map['email'] as String,
    );
  }
}
