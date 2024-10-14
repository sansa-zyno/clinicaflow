import 'package:flutter/material.dart';
import 'package:healtether_clinic_app/constants/app_colors.dart';
import 'package:healtether_clinic_app/widgets/buttons/my_elevated_button.dart';

class DualActionBottomNav extends StatelessWidget {
  const DualActionBottomNav(
      {super.key,
      required this.text,
      required this.focusedText,
      required this.onPressed,
      required this.onFocusedPressed});
  final String text;
  final String focusedText;
  final void Function() onPressed;
  final void Function() onFocusedPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: MyElevatedButton(
                text: text,
                textStyle: const TextStyle(color: AppColors.eerieBlack),
                height: 61,
                onPressed: onPressed,
                backgroundColor: const Color(0xFFF5F5F5),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: MyElevatedButton(
                text: focusedText,
                height: 61,
                onPressed: onFocusedPressed,
              ),
            ),
          ],
        ));
  }
}
