import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
        Text(text,
            textAlign: textAlign,
            style: GoogleFonts.urbanist(
                textStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: Colors.black,
            ).merge(textStyle))),
        const SizedBox(height: 10),
        Divider(
          thickness: 1,
          height: 1,
          color: underlineColor ?? Colors.grey.shade200,
        )
      ],
    );
  }
}
