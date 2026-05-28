import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_textstyles.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final double? height;
  final double? width;
  final ValueChanged<String>? onChanged;
  final TextInputType? keyBoardType;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool readOnly;
  final void Function()? onTap;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final EdgeInsetsGeometry? contentPadding;
  final bool obscureText;
  final Color? fillColor;
  final double borderRadius;
  final String? suffixText;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final bool? usePadding;
  final FocusNode? focusNode;
  final void Function()? onEditingComplete;
  final int? maxLines;
  final int? minLines;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    this.maxLines = 1,
    this.minLines = 1,
    this.focusNode,
    this.onEditingComplete,
    this.borderRadius = 14,
    this.textStyle,
    this.hintStyle,
    this.height,
    this.width,
    this.onChanged,
    this.suffixText,
    this.suffixIcon,
    this.prefixIcon,
    this.readOnly = false,
    this.fillColor,
    this.validator,
    this.onTap,
    this.inputFormatters,
    this.keyBoardType,
    this.usePadding,
    this.contentPadding,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasCustomPadding = (usePadding ?? false);
    return SizedBox(
      height: height,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: hasCustomPadding ? 10.0 : 0),
        child: TextFormField(
          keyboardType: keyBoardType,
          controller: controller,
          onChanged: onChanged,
          readOnly: readOnly,
          onEditingComplete: onEditingComplete,
          focusNode: focusNode,
          inputFormatters: inputFormatters,
          onTap: onTap,
          validator: validator,
          obscureText: obscureText,
          maxLines: maxLines,
          minLines: minLines,
          style: textStyle ?? AppTextStyles.body(context),
          decoration: InputDecoration(
            hintText: hintText,
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            suffixText: suffixText,
            fillColor: fillColor ?? Colors.white,
            contentPadding: contentPadding ??
                EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: maxLines == null || (maxLines ?? 1) > 1 ? 16 : 0),
            filled: true,
            hintStyle:
                hintStyle ?? AppTextStyles.body(context, color: AppColors.grey),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: const BorderSide(color: AppColors.whiteSmoke),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: const BorderSide(color: AppColors.whiteSmoke),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: const BorderSide(color: AppColors.whiteSmoke),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: const BorderSide(color: AppColors.whiteSmoke),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: const BorderSide(color: AppColors.whiteSmoke),
            ),
          ),
        ),
      ),
    );
  }
}
