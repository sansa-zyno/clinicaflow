import 'package:flutter/material.dart';

class ScrollableRow extends StatelessWidget {
  const ScrollableRow({super.key, required this.children, this.height = 40});

  final List<Widget> children;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: height,
        child: ListView(
          scrollDirection: Axis.horizontal,
          // clipBehavior: Clip.antiAlias,
          children: children,
        ));
  }
}
