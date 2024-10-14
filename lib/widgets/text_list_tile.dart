import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtether_clinic_app/utils/extensions.dart/widget_extensions.dart';

class TextListTile extends StatelessWidget {
  const TextListTile(
      {super.key,
      required this.text,
      required this.onTap,
      this.padding,
      this.backgroundColor,
      this.maxLines,
      this.leading,
      this.overflow});

  final void Function()? onTap;
  final String text;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final int? maxLines;
  final TextOverflow? overflow;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // height: 60,
        width: MediaQuery.of(context).size.width - 32,
        decoration: BoxDecoration(
          color: backgroundColor ?? const Color(0xffEEEEEE),
          borderRadius: BorderRadius.circular(3),
        ),
        child: Padding(
          padding:
              padding ?? const EdgeInsets.only(top: 18.0, left: 10, bottom: 18),
          child: Row(
            children: [
              if (leading != null) leading!.pOnly(right: 10),
                Expanded(
                  child: Text(
                    text,
                    maxLines: maxLines,
                    overflow: overflow,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: const Color(0xff000000),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
