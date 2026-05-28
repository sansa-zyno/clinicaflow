import 'package:flutter/material.dart';

/// A selectable chip representing a single time-slot filter option.
class TimeSlotChip extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onTap;
  final String label;

  const TimeSlotChip({
    super.key,
    required this.isSelected,
    required this.onTap,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: isSelected ? const Color(0xff03BF9C) : Colors.white,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(6),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isSelected ? Colors.black : const Color(0xff9E9E9E),
            ),
          ),
        ),
      ),
    );
  }
}
