import 'package:flutter/material.dart';

import '../../../core/constants/app_textstyles.dart';
import '../../../core/utils/size_utils.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color color;
  final double? textSize;
  final Color textColor;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final double? height;
  final double? gap;
  final Border? border;
  final double? borderRadius;
  final Widget? iconLeft;
  final Widget? iconRight;
  final Function()? onpressed;

  const CustomButton({
    super.key,
    required this.text,
    this.color = Colors.transparent,
    this.textSize,
    this.textColor = Colors.white,
    this.padding,
    this.width,
    this.height,
    this.gap,
    this.border,
    this.borderRadius,
    this.iconLeft,
    this.iconRight,
    this.onpressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onpressed,
      child: Container(
        width: width,
        height: height ?? getVerticalSize(52, context),
        padding: padding,
        decoration: BoxDecoration(
            color: color,
            borderRadius:
                BorderRadius.circular(getSize(borderRadius ?? 14, context)),
            border: border),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (iconLeft != null)
              IconTheme(data: IconThemeData(size: 20), child: iconLeft!),
            if (iconLeft != null)
              SizedBox(width: getHorizontalSize(gap ?? 6, context)),
            Text(text,
                style: AppTextStyles.body(context,
                    fontSize: textSize ?? 14, color: textColor)),
            if (iconRight != null)
              SizedBox(width: getHorizontalSize(gap ?? 6, context)),
            if (iconRight != null)
              IconTheme(data: IconThemeData(size: 20), child: iconRight!),
          ],
        ),
      ),
    );
  }
}
