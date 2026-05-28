import 'package:flutter/material.dart';
import 'package:clinica_flow/core/constants/app_colors.dart';
import 'package:clinica_flow/core/utils/helper_functions/log.dart';
import 'package:clinica_flow/shared/widgets/components/my_dialog.dart';
import 'package:intl/intl.dart';

mixin UiInfoMixin {
  /// Shows a message to the user in the form of a dialog with a [title] and
  /// [content]
  Future<dynamic> showMessage(context, String title, String content) {
    return showDialog(
        context: context,
        builder: (context) {
          return MyDialog(title: title, content: content);
        });
  }

  Future<TimeOfDay?> showMyTimePicker(BuildContext context) {
    return showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
                primary: AppColors.primaryColor,
                onPrimary: Colors.white,
                onSurface: Colors.black,
                tertiaryContainer: AppColors.lightAqua),
          ),
          child: child!,
        );
      },
    );
  }

  Future<DateTime?> showMyDatePicker(BuildContext context) {
    return showDatePicker(
        context: context,
        builder: (context, child) {
          return Theme(
              data: ThemeData.light().copyWith(
                colorScheme: const ColorScheme.light(
                    primary: AppColors.primaryColor,
                    onPrimary: Colors.white,
                    onSurface: Colors.black,
                    tertiaryContainer: AppColors.lightAqua),
              ),
              child: child!);
        },
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 14)));
  }

  void showSnackMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        content: Text(message,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500))));
  }

  Future<dynamic> pickTime(BuildContext context,
      {returnTimeObject = false}) async {
    log("Show time");
    final pickedTime = await showMyTimePicker(context);
    String? formattedTime;
    if (context.mounted) formattedTime = pickedTime?.format(context);
    log("Picked time: $formattedTime");
    return returnTimeObject ? pickedTime : formattedTime;
  }

  Future<dynamic> pickDate(BuildContext context,
      {bool returnDateObject = false}) async {
    final date = await showMyDatePicker(context);
    String? parsedDate;
    if (date != null) {
      parsedDate = DateFormat('dd/MM/yyyy').format(date);
    }

    return returnDateObject ? date : parsedDate;
  }
}
