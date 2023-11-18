class AuthModel{

  AuthModel({
    required this.token,
    required this.refreshToken,
  });

  final String token;
  final String refreshToken;
  
  factory AuthModel.fromMap(Map<String, dynamic> json) => AuthModel(
    token: json["accessToken"],
    refreshToken: json["refreshToken"],
  );

  Map<String, dynamic> toMap() => {
    "accessToken": token,
    "refreshToken": refreshToken,
  };
}