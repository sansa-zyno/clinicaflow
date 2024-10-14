import 'package:flutter/foundation.dart';

/// A wrapper around print that logs it's content only in debug mode.
void log(Object? object) {
  if (kDebugMode) {
    print(object);
  }
}
