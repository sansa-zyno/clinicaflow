import 'package:flutter/foundation.dart';

class AppLog {
  static void d(String msg) {
    if (kDebugMode) {
      print('DocMobileApp : $msg');
    }
  }
}
