import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';

class BuildSection extends StatelessWidget {
  const BuildSection(
      {super.key, required this.title, required this.children, this.textStyle});

  final TextStyle? textStyle;
  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.urbanist(
              textStyle: const TextStyle(
                      color: AppColors.deepAqua,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      height: 17.36 / 14)
                  .merge(textStyle)),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: children,
        ),
        const SizedBox(height: 12),
        const Divider()
      ],
    );
  }
}
