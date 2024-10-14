import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AlcoholScreen extends StatelessWidget {
  final List<String> options = [
    'Former drinker',
    'Social drinker',
    'Occasional drinker',
    'Light (1-2/week)',
    'Moderate (3-7/week)',
    'Binge drinker',
    'Problem drinker'
  ];

  AlcoholScreen({super.key});

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
            "Frequency of Alcohol Consumption ",
            style: GoogleFonts.urbanist(
              textStyle: const TextStyle(
                // fontFamily: 'Urbanist',
                fontWeight: FontWeight.w700,
                fontSize: 14,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 10,
            runSpacing: 2.0,
            children: options.map((option) {
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
                        // fontFamily: 'Urbanist',
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
          // const SizedBox(height: 16),
        ],
      ),
    );
  }
}
