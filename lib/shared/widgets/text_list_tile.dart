import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:clinica_flow/core/constants/app_colors.dart';
import 'package:clinica_flow/core/utils/extensions.dart/widget_extensions.dart';

class TextListTile extends StatelessWidget {
  const TextListTile({
    super.key,
    required this.text,
    required this.onTap,
    this.padding,
    this.backgroundColor,
    this.maxLines,
    this.leading,
    this.overflow,
    this.height,
  });

  final void Function()? onTap;
  final String text;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final int? maxLines;
  final TextOverflow? overflow;
  final Widget? leading;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: backgroundColor ?? AppColors.whiteSmoke,
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
                    color: Colors.black,
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
