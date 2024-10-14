import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileMenuCont extends StatefulWidget {
  final String text;
  const ProfileMenuCont({
    super.key,
    required this.text,
  });

  @override
  State<ProfileMenuCont> createState() => _ProfileMenuContState();
}

class _ProfileMenuContState extends State<ProfileMenuCont> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 280,
      decoration: BoxDecoration(
        color: const Color(0xffEEEEEE),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 18.0, left: 10),
        child: Text(
          widget.text,
          style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, fontSize: 16,
            height: 16.8 / 14,
            color: const Color(0xFF000000), ),
        ),
      ),
    );
  }
}
