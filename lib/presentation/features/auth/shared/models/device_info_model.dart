class DeviceInfoModel {

  final String deviceIdentifier;
  final String platform;
  final String model;
  final String systemVersion;

  DeviceInfoModel({
    required this.deviceIdentifier, 
    required this.platform, 
    required this.model, 
    required this.systemVersion
  });
  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'deviceIdentifier': deviceIdentifier,
      'platform': platform,
      'model': model,
      'systemVersion': systemVersion,
    };
  }

  factory DeviceInfoModel.fromMap(Map<String, dynamic> map) {
    return DeviceInfoModel(
      deviceIdentifier: map['deviceIdentifier'] as String,
      platform: map['platform'] as String,
      model: map['model'] as String,
      systemVersion: map['systemVersion'] as String,
    );
  }

}