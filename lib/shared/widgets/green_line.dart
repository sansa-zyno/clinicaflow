import 'package:flutter/material.dart';

class GreenLine extends StatelessWidget {
  const GreenLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 2,
      width: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xFF52CFAC),
      ),
    );
  }
}
