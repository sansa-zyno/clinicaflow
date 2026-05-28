import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/constants/app_colors.dart';

/// A card used in the "Tools" grid on the home screen,
/// showing a label and a Flutter icon.
class ToolCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const ToolCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey, width: 0),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.urbanist(
                        textStyle: const TextStyle(
                          color: Color(0xff0C091F),
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Text(
                      subtitle,
                      style: GoogleFonts.urbanist(
                        textStyle: const TextStyle(
                          color: Color(0xff0C091F),
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                icon,
                color: AppColors.skyBlueColor,
                size: 28,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
