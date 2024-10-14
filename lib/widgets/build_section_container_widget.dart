import 'package:flutter/material.dart';

Widget buildPersonalHistorySection(BuildContext context, List<String> options) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [

      Wrap(
        spacing: 8.0,
        runSpacing: 4.0,
        children: options.map((option) {
          return GestureDetector(
            onTap: () {
            },
            child: Chip(
              label: Text(
                option,
                style: const TextStyle(fontSize: 12),
              ),
              backgroundColor: const Color(0xFFF5F5F5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              side: BorderSide.none, // Removing the outline
            ),
          );
        }).toList(),
      ),
    ],
  );
}

