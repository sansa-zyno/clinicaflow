import 'package:intl/intl.dart';

mixin TimeParserMixin {
  String formatTimeStamp(String timestamp) {
    return DateFormat('dd MMMM, yyyy. h:mm a')
        .format(DateTime.parse(timestamp));
  }
}
