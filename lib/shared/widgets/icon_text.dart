import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IconText extends StatelessWidget {
  const IconText({
    super.key,
    required this.leading,
    required this.title,
    this.titleStyle,
  });

  final Widget leading;
  final String title;
  final TextStyle? titleStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // icon
        leading,

        const SizedBox(
          width: 8,
        ),

        // text
        Text(
          title,
          style: titleStyle ??
              GoogleFonts.urbanist(
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 17,
                      height: 22.7 / 17)),
        )
      ],
    );
  }
}
