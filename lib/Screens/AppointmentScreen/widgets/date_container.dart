import 'package:flutter/material.dart';

class DateContainer extends StatelessWidget {
  final DateTime? selectedDate;
  final VoidCallback onTap;
  final double width;
  final String text;

  const DateContainer(
      {super.key, required this.selectedDate,
      required this.onTap,
      required this.width,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        color: const Color(0xffF5F5F5),
        width: MediaQuery.of(context).size.width * width,
        child: Padding(
          padding:
              const EdgeInsets.only(top: 15, bottom: 10, left: 10, right: 30),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  selectedDate != null
                      ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
                      : text,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: selectedDate != null ? Colors.black : Colors.grey,
                  ),
                ),
              ),
              const Icon(
                Icons.arrow_drop_down,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
