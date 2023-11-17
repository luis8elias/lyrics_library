export '/data/enums/send_status.dart';
import 'dart:developer';

import 'package:flutter/material.dart';

import '/data/enums/send_status.dart';

abstract class SendProvider<T> extends ChangeNotifier {
  SendProvider();

  SendStatus status = SendStatus.initial;
  String message = '';
  late T model;

  void applyStatus(SendStatus newStatus){
    log('[StatusUpdate💡] prevStatus: [${status.name}] => newStatus: [${newStatus.name}]');
    status = newStatus;
    notifyListeners();
  }

  void resetStatus ()=> status = SendStatus.initial;

}