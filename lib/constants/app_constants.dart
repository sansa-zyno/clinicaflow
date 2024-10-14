import 'package:flutter/material.dart';
import 'package:healtether_clinic_app/constants/app_colors.dart';
import 'package:shimmer/shimmer.dart';

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
}
