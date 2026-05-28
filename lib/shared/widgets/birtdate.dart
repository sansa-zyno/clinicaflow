import 'package:flutter/material.dart';

class BirthDateContainer extends StatelessWidget {
  final DateTime? selectedDate;
  final VoidCallback onTap;
  final double width;
  final String text;

  const BirthDateContainer({
    super.key,
    required this.selectedDate,
    required this.onTap,
    required this.width,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 52,
        width: MediaQuery.of(context).size.width * width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFF7F7F7)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  selectedDate != null
                      ? '${selectedDate!.year}-${selectedDate!.month}-${selectedDate!.day}'
                      : text,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: selectedDate != null ? Colors.black : Colors.grey,
                  ),
                ),
              ),
              const Icon(
                Icons.keyboard_arrow_down_outlined,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BirthDate extends StatelessWidget {
  final DateTime? selectedDate;
  final VoidCallback onTap;
  final double width;
  final String text;
  final bool showIcon;
  const BirthDate({
    super.key,
    required this.selectedDate,
    required this.onTap,
    required this.width,
    required this.text,
    this.showIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 52,
        width: MediaQuery.of(context).size.width * width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFF7F7F7)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  selectedDate != null
                      ? '${selectedDate!.day}-${selectedDate!.month}-${selectedDate!.year}'
                      : text,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: selectedDate != null ? Colors.black : Colors.grey,
                  ),
                ),
              ),
              if (showIcon) ...[
                const Icon(
                  Icons.calendar_today_outlined,
                  size: 16,
                  color: Colors.black,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
