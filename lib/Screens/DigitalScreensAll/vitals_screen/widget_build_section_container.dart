/*import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtether_clinic_app/Screens/AppointmentScreen/widgets/option_chip_widget.dart';

Widget buildSectionContainer(BuildContext context, String title,
    List<String> options, Container container) {
  return Container(
    padding: const EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              title,
              style: GoogleFonts.montserrat(
                textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 2,
          children: options
              .map((option) => buildOptionChip(context, option))
              .toList(),
        ),
      ],
    ),
  );
}*/