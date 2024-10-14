/*import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DrugCard extends StatelessWidget {
  final String name;
  final bool isSelected;

  const DrugCard({
    Key? key,
    required this.name,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          color:
              isSelected ? const Color(0xFFF32856E) : const Color(0xFFF8F8F8),
          margin: const EdgeInsets.symmetric(vertical: 5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              name,
              style: GoogleFonts.urbanist(
                textStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: isSelected ? Colors.white : const Color(0xFF0C091F),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}*/