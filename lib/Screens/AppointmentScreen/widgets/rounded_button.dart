import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final VoidCallback onTap;

  const RoundedButton({super.key,
    required this.text,
    this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: Container(
          height: 58,
          width: screenWidth * 0.8,
          decoration: BoxDecoration(
            color: onTap != null ? const Color(0xff03BF9C) : const Color(0xffF5F5F5),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: onTap != null ? Colors.white : Colors.black,
                ),
              ),
              if (icon != null) const SizedBox(width: 10),
              if (icon != null)
                Icon(
                  icon,
                  color: onTap != null ? Colors.white : Colors.black,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
