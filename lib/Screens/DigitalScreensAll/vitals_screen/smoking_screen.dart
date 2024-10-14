import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SmokingScreen extends StatelessWidget {
  final List<String> options = [
    'Former smoker',
    'Irregular smoker',
    'Light (1-5cigs)',
    'Moderate (6-10cigs)',
    'Chain smoker',
    'Occasional smoker',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(18.0),
        ),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Frequency of Smoking',
            style: GoogleFonts.urbanist(
              textStyle: const TextStyle(
                // fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
                fontSize: 14,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8.0,
            children: options.take(8).map((option) {
              return GestureDetector(
                onTap: () {
                  Navigator.pop(context, option);
                },
                child: Chip(
                  label: Text(
                    option,
                    style: GoogleFonts.urbanist(
                      textStyle: const TextStyle(
                        fontSize: 16,
                        // fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  backgroundColor: const Color(0xFFF5F5F5),
                  side: BorderSide.none,
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
