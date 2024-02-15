import 'dart:async';
import 'package:flutter/material.dart';

class Debouncer {
  static Timer? _timer;

  static void run(VoidCallback callback, Duration? duration) {
    _timer?.cancel();
    _timer = Timer(duration ?? const  Duration(milliseconds: 600), callback);
  }
}


class DebouncerObj {
  Timer? timer;

  final Duration? _duration;

  DebouncerObj(
    Duration? duration
  ) : _duration = duration;

  void run(VoidCallback callback) {
    timer?.cancel();
    timer = Timer(_duration ?? const  Duration(milliseconds: 600), callback);
  }
}