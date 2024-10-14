import 'package:flutter/material.dart';

class OptionContainer extends StatelessWidget {
  final String text;
  final Color color;

  const OptionContainer({super.key, required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color,
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: color == Color(0xff03BF9C) ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
