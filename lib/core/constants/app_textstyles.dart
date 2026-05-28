import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/size_utils.dart';
import 'app_colors.dart';

class AppTextStyles {
  static TextStyle _getStyle({
    required double fontSize,
    required double letterSpacing,
    required FontWeight weight,
    bool italic = false,
    Color color = AppColors.black1Color, // Default primary text color
    TextDecoration? decoration = TextDecoration.none,
    Color? decorationColor = Colors.white,
  }) {
    return GoogleFonts.inter(
      fontSize: fontSize,
      letterSpacing: letterSpacing,
      fontWeight: weight,
      fontStyle: italic ? FontStyle.italic : FontStyle.normal,
      color: color,
      decoration: decoration,
      decorationColor: decorationColor,
    );
  }

  static TextStyle heading(
    BuildContext context, {
    double fontSize = 24,
    //double height = 1.2,
    double letterSpacing = 0,
    FontWeight weight = FontWeight.w700,
    bool italic = false,
    Color color =
        AppColors.black1Color, // Default primary text color for heading
    TextDecoration? decoration = TextDecoration.none,
    Color? decorationColor = Colors.white,
  }) =>
      _getStyle(
        fontSize: getFontSize(fontSize, context),
        letterSpacing: letterSpacing,
        weight: weight,
        italic: italic,
        color: color,
        decoration: decoration,
        decorationColor: decorationColor,
      );

  static TextStyle title(
    BuildContext context, {
    double fontSize = 20,
    //double height = 1.2,
    double letterSpacing = 0,
    FontWeight weight = FontWeight.w500,
    bool italic = false,
    Color color =
        AppColors.black1Color, // Default secondary text color for title
    TextDecoration? decoration = TextDecoration.none,
    Color? decorationColor = Colors.white,
  }) =>
      _getStyle(
        fontSize: getFontSize(fontSize, context),
        letterSpacing: letterSpacing,
        weight: weight,
        italic: italic,
        color: color,
        decoration: decoration,
        decorationColor: decorationColor,
      );

  static TextStyle body(
    BuildContext context, {
    double fontSize = 16,
    //double height = 1.2,
    double letterSpacing = -0.31,
    FontWeight weight = FontWeight.w400,
    bool italic = false,
    Color color = AppColors.black1Color, // Default tertiary text color for body
    TextDecoration? decoration = TextDecoration.none,
    Color? decorationColor = Colors.white,
  }) =>
      _getStyle(
        fontSize: getFontSize(fontSize, context),
        letterSpacing: letterSpacing,
        weight: weight,
        italic: italic,
        color: color,
        decoration: decoration,
        decorationColor: decorationColor,
      );
}
