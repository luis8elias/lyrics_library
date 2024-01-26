export '/data/enums/fetch_status.dart';
import 'dart:developer';

import 'package:flutter/material.dart';

import '/data/enums/fetch_status.dart';
import '/data/models/response_model.dart';



abstract class FetchProvider<T> extends ChangeNotifier {
  FetchProvider() {
    loadData();
  }

  FetchStatus status = FetchStatus.loading;
  String message = '';
  late T model;
  bool isModelInitialized = false;



  void applyStatus(FetchStatus newStatus){
    log('[StatusUpdate💡] prevStatus: [${status.name}] => newStatus: [${newStatus.name}]');
    status = newStatus;
    notifyListeners();
  }

  

  Future<ResponseModel<T>> fetchMethod();
  

  Future<void> loadData() async {
    applyStatus(FetchStatus.loading);
    final resp = await fetchMethod();
    message = resp.message!;
    if (resp.isFailed) {
      return applyStatus(FetchStatus.failed);
    }
    model = resp.model as T;
    isModelInitialized = true;
    applyStatus(FetchStatus.success);

  }
}