import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String data;
  final Color color;
  final double? Textsize;
  final Color Textcolor;
  final double? width;
  final double? height;
  final Border? border;
  final Widget? icon;

  const CustomButton({
    super.key,
    required this.data,
    this.color = Colors.grey,
    this.Textsize,
    this.Textcolor = Colors.black,
    this.width,
    this.height,
    this.border,
    this.icon,  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(7),
        border: border,
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              data,
              style: TextStyle(
                fontSize: Textsize ?? 12,
                color: Textcolor,
                fontWeight: FontWeight.w400,
              ),
            ),
            if (icon != null) const SizedBox(width: 4),
            if (icon != null) icon!,
          ],
        ),
      ),
    );
  }
}



