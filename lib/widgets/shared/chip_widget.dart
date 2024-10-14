import 'package:flutter/material.dart';

class ChipWidget extends StatefulWidget {
  const ChipWidget({
    required this.label,
    super.key});
  final String label;


  @override
  State<ChipWidget> createState() => _ChipWidgetState();
}

class _ChipWidgetState extends State<ChipWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: const Color(0xffF5F5F5),
          borderRadius: BorderRadius.circular(8)),
      child:  Text(
        widget.label,
        style: const TextStyle(fontSize: 14),
      ),
    );
  }
}
