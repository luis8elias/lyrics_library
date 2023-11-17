import 'dart:developer' as developer;

class Log{

  static void b(String msg) {
    developer.log('\x1B[34m$msg\x1B[0m');
  }

  static g(String msg) {
    developer.log('\x1B[32m$msg\x1B[0m');
  }

  static void y(String msg) {
    developer.log('\x1B[33m$msg\x1B[0m');
  }

  static void r(String msg) {
    developer.log('\x1B[31m$msg\x1B[0m');
  }
}