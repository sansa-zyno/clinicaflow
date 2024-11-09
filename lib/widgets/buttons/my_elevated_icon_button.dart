import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtether_clinic_app/constants/app_colors.dart';

class MyElevatedIconButton extends StatelessWidget {
  const MyElevatedIconButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onPressed,
    this.textStyle,
    this.backgroundColor,
    this.padding,
  });

  final String text;
  final void Function() onPressed;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        style: ButtonStyle(
            padding: MaterialStatePropertyAll(padding),
            backgroundColor: MaterialStatePropertyAll(backgroundColor ?? AppColors.darkTeal),
            shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)))),
        onPressed: onPressed,
        icon: icon,
        label: Text(
          text,
          style: GoogleFonts.urbanist(fontWeight: FontWeight.w600, fontSize: 14, color: Colors.white, height: 17.36 / 14).merge(textStyle),
        ));
  }
}
