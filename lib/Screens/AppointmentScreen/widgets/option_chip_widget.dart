import 'package:flutter/material.dart';
import 'package:healtether_clinic_app/Screens/DigitalScreensAll/vitals_screen/other_vitals_screen.dart';

Widget buildOptionChip(BuildContext context, String option) {
  return GestureDetector(
    onTap: () {
      /* Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const OtherVitalsScreen(
                  appointmentId: '',
                )),
      );*/
    },
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      margin: const EdgeInsets.only(right: 4, bottom: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(7),
        border: const Border(
          bottom: BorderSide(width: 1, color: Colors.grey),
          left: BorderSide.none,
          top: BorderSide.none,
          right: BorderSide.none,
        ),
      ),
      child: Text(
        option,
        style: const TextStyle(fontSize: 15),
      ),
    ),
  );
}
