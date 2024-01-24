import 'dart:async';
import 'package:flutter/material.dart';

class Debouncer {
  static Timer? _timer;

  static void run(VoidCallback callback) {
    _timer?.cancel();
    _timer = Timer(const Duration(milliseconds: 600), callback);
  }
}