import 'package:flutter/material.dart';
import 'package:healtether_clinic_app/constants/constants.dart';

class InfoItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color containerColor;

  const InfoItem({
    Key? key,
    required this.icon,
    required this.text,
    this.containerColor = Colors.transparent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      width: 98,
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Center(
              child: Padding(
            padding: const EdgeInsets.all(4),
            child: Icon(icon),
          )),
          const SizedBox(width: 4),
          Center(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.blackColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
