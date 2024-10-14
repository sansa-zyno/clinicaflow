import 'package:flutter/material.dart';
import 'package:healtether_clinic_app/constants/constants.dart';

class InfoButton extends StatelessWidget {
  final IconData? icon;
  final Image? image;
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const InfoButton({
    super.key,
    this.icon,
    this.image,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 48,
          decoration: BoxDecoration(
            color: isSelected ? AppColors.greenColor : Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null)
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Icon(
                    icon,
                    color: isSelected ? Colors.white : Colors.black,
                  ),
                )
              else if (image != null)
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      "assets/homeimages/whatsapp.png",
                      width: 30,
                      height: 30,
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              const SizedBox(width: 4),
              Text(
                text,
                style: TextStyle(
                  fontSize: 14,
                  color: isSelected ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
