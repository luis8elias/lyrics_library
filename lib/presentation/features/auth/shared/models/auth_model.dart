import 'package:jwt_decoder/jwt_decoder.dart';

class AuthModel{

  AuthModel({
    required this.token,
    required this.refreshToken,
    required this.userId,
    this.displayName = '',
    this.email = ''
  });

  final String token;
  final String refreshToken;
  final String userId;
  final String displayName;
  final String email;

  String get getDisplayNameInitials{

    if(displayName.isEmpty){
      return '?';
    }


    final nameArr = displayName.split(' ');
    if(nameArr.length > 1){
      return '${nameArr[0][0]}${nameArr[1][0]}'.toUpperCase();
    }
    return nameArr[0][0].toUpperCase();
  }
  
  factory AuthModel.fromMap(Map<String, dynamic> json) {

    final decodedToken = JwtDecoder.decode(json["accessToken"]);

    return AuthModel(
      token: json["accessToken"],
      refreshToken: json["refreshToken"],
      userId: json['userId'],
      displayName: decodedToken['DisplayName'] ?? '',
      email:  decodedToken['Email'] ?? ''
    );
  }

  Map<String, dynamic> toMap() => {
    "accessToken": token,
    "refreshToken": refreshToken,
    'userId': userId,
    'displayName' : displayName,
    'email' : email
  };
}