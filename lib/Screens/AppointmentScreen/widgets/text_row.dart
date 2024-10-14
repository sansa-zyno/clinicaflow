import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextRow extends StatelessWidget {
  final String label;
  final String value;

  const TextRow(this.label, this.value, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: GoogleFonts.montserrat(
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.montserrat(
            color: const Color(0xff32856E),
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
