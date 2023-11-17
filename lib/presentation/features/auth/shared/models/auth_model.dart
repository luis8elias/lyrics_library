class AuthModel{

  AuthModel({
    required this.token,
    required this.refreshToken,
  });

  final String token;
  final String refreshToken;
  
  factory AuthModel.fromMap(Map<String, dynamic> json) => AuthModel(
    token: json["token"],
    refreshToken: json["refresh_token"],
  );

  Map<String, dynamic> toMap() => {
    "token": token,
    "refresh_token": refreshToken,
  };
}