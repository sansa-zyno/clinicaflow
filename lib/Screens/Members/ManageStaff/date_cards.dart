import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtether_clinic_app/constants/constants.dart';

class DateCards extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;
  final double width;

  const DateCards({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onTap,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          height: 20,
          width: width,
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xff6CEBC6) : AppColors.whitColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: AppColors.blackColor,
                fontFamily: GoogleFonts.montserrat().fontFamily,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
