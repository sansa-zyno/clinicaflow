import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ScheduleButton extends StatelessWidget {
  final String text;
  final int pageIndex;
  final VoidCallback onTap;
  final bool isFilled;

  const ScheduleButton(
      {super.key, required this.text,
      required this.pageIndex,
      required this.onTap,
      required this.isFilled});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Center(
        child: Container(
          height: 62,
          width: 262,
          decoration: BoxDecoration(
            color: isFilled ? const Color(0xff03BF9C) : const Color(0xffF8F7FC),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: isFilled ? Colors.white : Colors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ScheduleLaterButton extends StatelessWidget {
  final Function? onTap;

  const ScheduleLaterButton({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap as void Function()?,
      child: Center(
        child: Container(
          height: 62,
          width: 262,
          decoration: BoxDecoration(
            color: const Color(0xffF5F5F5),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Center(
            child: Text(
              'Schedule Later',
              style: GoogleFonts.montserrat(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
