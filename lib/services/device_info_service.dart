import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

import '/utils/logger/logger_helper.dart';
import '/services/base_service.dart';
import '/presentation/features/auth/shared/models/device_info_model.dart';

abstract class DeviceInfoService extends BaseService{

  static final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  Future<DeviceInfoModel> getDeviceInfo() async {

    try {
      
      if(Platform.isAndroid){
        final androidInfo = await _deviceInfo.androidInfo;
        return DeviceInfoModel(
          deviceIdentifier: androidInfo.serialNumber,
          platform: 'Android' , 
          model: androidInfo.model, 
          systemVersion: androidInfo.version.release
        );
      }
      final iosInfo = await _deviceInfo.iosInfo;
      return DeviceInfoModel(
        deviceIdentifier: iosInfo.localizedModel,
        platform: 'iOS', 
        model: iosInfo.model, 
        systemVersion: iosInfo.systemVersion
      );

    } catch (e) {

      Log.y('🤡 ${e.toString()}');
      Log.y('😭 Error en DeviceInfoService método [getDeviceInfo]');

      return DeviceInfoModel(
        deviceIdentifier: '',
        platform: '' , 
        model: '', 
        systemVersion: ''
      );

    }

  }
}