import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shimmer/shimmer.dart';
import '../../features/home/widgets/legend_item.dart';
import 'app_colors.dart';

class AppConstants {
  static Map<String, DateTime?> followUpDate = {
    "None": null,
    "After 3 days": DateTime.now().add(const Duration(days: 3)),
    "After a week": DateTime.now().add(const Duration(days: 7)),
    "After 2 weeks": DateTime.now().add(const Duration(days: 14)),
    "After a month": DateTime.now().add(const Duration(days: 30)),
    "Custom": null,
  };
  static Map<String, DateTime?> drugDuration = {
    "Custom": null,
    "For 3 days": DateTime.now().add(const Duration(days: 3)),
    "For 5 days": DateTime.now().add(const Duration(days: 5)),
    "For a week": DateTime.now().add(const Duration(days: 7)),
    "For 2 weeks": DateTime.now().add(const Duration(days: 14)),
    "For a month": DateTime.now().add(const Duration(days: 30)),
  };

  static Widget buildPlaceHolder({required String title}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade500,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          children: [
            Text(
              title,
              style: const TextStyle(color: Colors.black),
            ),
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        Wrap(
          spacing: 4,
          runSpacing: 10,
          children: List<Widget>.generate(10, (index) {
            return Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                decoration: BoxDecoration(color: AppColors.whiteSmoke2),
                child: const Text('Text'));
          }),
        ),
      ]),
    );
  }

  static Widget patientsHelpedPlaceHolder() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade500,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: Row(
        children: [
          Expanded(
            child: CircularPercentIndicator(
              radius: 50.0,
              animation: true,
              animationDuration: 1200,
              lineWidth: 10.0,
              percent: 0.6,
              center: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "x%",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
                  ),
                  Text(
                    'done',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
                  )
                ],
              ),
              circularStrokeCap: CircularStrokeCap.butt,
              progressColor: Colors.grey,
              backgroundColor: Colors.grey,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ' x patients helped',
                  style: GoogleFonts.urbanist(
                    fontSize: 17,
                    color: const Color(0xff0C091F),
                  ),
                ),
                const SizedBox(height: 9),
                const LegendItem(
                  color: Color(0xff03BF9C),
                  label: 'Completed',
                ),
                const SizedBox(height: 9),
                const LegendItem(
                    color: Color(0xffE4E0F3), label: 'Remaining'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
