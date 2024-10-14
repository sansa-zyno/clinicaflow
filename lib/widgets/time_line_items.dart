import 'package:flutter/material.dart';

class TimelineItem extends StatelessWidget {
  final Color iconColor;
  final String text;
  final String date;

  const TimelineItem({
    super.key,
    required this.iconColor,
    required this.text,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(backgroundColor: iconColor, radius: 5),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(text,
                  style: const TextStyle(
                      fontSize: 13, fontWeight: FontWeight.w600)),
              Text(date,
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: iconColor)),
            ],
          ),
        ),
      ],
    );
  }
}

class TimelineItemPage extends StatelessWidget {
  const TimelineItemPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Timeline Item Details'),
      ),
      body: const Center(
        child: Text('Details of the timeline item will be displayed here.'),
      ),
    );
  }
}
