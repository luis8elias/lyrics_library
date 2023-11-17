class ResponseModel<T> {

  ResponseModel({required this.success, this.message, this.model});

  factory ResponseModel.fromMap(Map<String, dynamic> json) => ResponseModel(
    success: json['Success'] as bool,
    message: json['Message'] as String?, 
    model: json['Model'] as T?,
  );


  bool success;
  String? message;
  T? model;

  bool get isFailed => !success;

  bool get isModelNull => model == null;


  Map<String, dynamic> toMap() => <String, dynamic>{
    'Success': success,
    'Message': message,
    'Model': model
  };
}