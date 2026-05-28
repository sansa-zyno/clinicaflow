// import 'dart:ui';

// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTypography {
  static TextStyle H7_SB = GoogleFonts.urbanist(
      textStyle: const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 20,
    height: 24 / 20,
  ));
  static TextStyle CTA_1_SB = GoogleFonts.urbanist(
      textStyle: const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 17,
    height: 23.12 / 17,
  ));
  static TextStyle CTA_4_B = GoogleFonts.urbanist(
      textStyle: const TextStyle(
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.italic,
    fontSize: 12,
    height: 14.4 / 12,
    letterSpacing: 1.03,
  ));
  static TextStyle BodyMeta1_M = GoogleFonts.roboto(
      textStyle: const TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 13,
    height: 15.6 / 13,
  ));
}
