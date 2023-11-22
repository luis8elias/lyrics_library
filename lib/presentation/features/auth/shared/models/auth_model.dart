class AuthModel{

  AuthModel({
    required this.token,
    required this.refreshToken,
    required this.userId
  });

  final String token;
  final String refreshToken;
  final String userId;
  
  factory AuthModel.fromMap(Map<String, dynamic> json) => AuthModel(
    token: json["accessToken"],
    refreshToken: json["refreshToken"],
    userId: json['userId']
  );

  Map<String, dynamic> toMap() => {
    "accessToken": token,
    "refreshToken": refreshToken,
    'userId': userId
  };
}