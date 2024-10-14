import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtether_clinic_app/constants/app_colors.dart';

class MyTextButton extends StatelessWidget {
  const MyTextButton(
      {super.key, required this.text, required this.onTap, this.textStyle});

  final String text;
  final void Function()? onTap;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: GoogleFonts.urbanist(
            textStyle: textStyle ??
                const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    height: 17.36 / 14,
                    color: AppColors.blueViolet)),
      ),
    );
  }
}
