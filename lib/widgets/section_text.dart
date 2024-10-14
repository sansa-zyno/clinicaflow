import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtether_clinic_app/constants/app_colors.dart';

class SectionText extends StatelessWidget {
  const SectionText(this.text,
      {super.key,
      this.underlineWidth = 47,
      this.textStyle,
      this.textAlign,
      this.underlineColor});

  final String text;
  final double underlineWidth;
  final TextStyle? textStyle;
  final Color? underlineColor;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // title
        Text(text.toUpperCase(),
            textAlign: textAlign,
            style: GoogleFonts.urbanist(
                textStyle: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: AppColors.eerieBlack,
                        height: 16.8 / 14)
                    .merge(textStyle))),
        SizedBox(
            width: underlineWidth,
            child: Divider(
                color: underlineColor ?? AppColors.greenCyan,
                thickness: 2,
                height: 10))
      ],
    );
  }
}
