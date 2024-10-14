import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomRow extends StatelessWidget {
  final String first;
  final String second;

  const CustomRow({super.key, required this.first, required this.second});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
            width: MediaQuery.of(context).size.width * 0.24,
            child: Text(
              first,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0XFF6D6D6D)),
            )),
        const Text(":  "),
        Expanded(
            child: Container(
          child: Text(
            second,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0XFF266A57)),
          ),
        ))
      ],
    );
  }
}
