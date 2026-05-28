import 'package:flutter/material.dart';

mixin DeviceInfoMixin {
  Size screenDimensions(BuildContext context) => MediaQuery.sizeOf(context);
}
