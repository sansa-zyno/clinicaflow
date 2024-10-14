import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtether_clinic_app/constants/app_colors.dart';

class MyElevatedButton extends StatelessWidget {
  const MyElevatedButton({
    super.key,
    this.backgroundColor,
    required this.text,
    this.textStyle,
    this.height,
    required this.onPressed,
  });

  final String text;
  final void Function() onPressed;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(
                  backgroundColor ?? AppColors.darkTeal),
              shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7)))),
          onPressed: onPressed,
          child: Text(text,
              style: GoogleFonts.urbanist(
                  textStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14)
                      .merge(textStyle)))),
    );
  }
}
