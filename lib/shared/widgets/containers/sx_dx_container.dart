import 'package:flutter/material.dart';
import 'package:clinica_flow/core/constants/app_colors.dart';

class SxDxContainer extends StatelessWidget {
  final String text;
  final Color? backgroundColor;

  const SxDxContainer({super.key, required this.text, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(4),
        width: 32,
        height: 32,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            color: text == 'Sx'
                ? AppColors.darkRedColor
                : AppColors.greenLightColor),
        child: Text(text,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: 16)));
  }
}
