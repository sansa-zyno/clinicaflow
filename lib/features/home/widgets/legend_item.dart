import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Small colored square + label used as a chart legend item.
///
/// Used by [PatientsHelpedIndicator] and [AppConstants.patientsHelpedPlaceHolder].
class LegendItem extends StatelessWidget {
  final Color color;
  final String label;

  const LegendItem({
    super.key,
    required this.color,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 20,
          width: 20,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          label,
          style: GoogleFonts.roboto(
            textStyle: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: Color(0xff0C091F),
            ),
          ),
        ),
      ],
    );
  }
}
