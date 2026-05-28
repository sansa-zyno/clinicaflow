import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/time_slot_utils.dart';

/// A horizontal bar displaying the selected date with
/// forward/back navigation arrows.
class DateNavigatorBar extends StatelessWidget {
  final DateTime selectedDate;
  final VoidCallback onPreviousDay;
  final VoidCallback onNextDay;

  const DateNavigatorBar({
    super.key,
    required this.selectedDate,
    required this.onPreviousDay,
    required this.onNextDay,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      width: MediaQuery.of(context).size.width,
      height: 40,
      decoration: BoxDecoration(
        color: const Color(0xff03BF9C),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: InkWell(
              onTap: onPreviousDay,
              child: const Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 15,
                color: Colors.white,
              ),
            ),
          ),
          Text(
            TimeSlotUtils.formatDate(selectedDate),
            style: GoogleFonts.urbanist(
              textStyle: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: InkWell(
              onTap: onNextDay,
              child: const Icon(
                Icons.arrow_forward_ios_outlined,
                size: 14,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
